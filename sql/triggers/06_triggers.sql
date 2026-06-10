-- ============================================================
--  OneReserve — Bangladesh Tourism Reservation System
--  File: 06_triggers.sql
--  Description: 6 production triggers covering seat management,
--               room availability, booking logs, and cost calc
-- ============================================================

USE onereserve;

DELIMITER $$

-- ============================================================
-- TRIGGER 1: After booking_bus INSERT
-- Reduces available_seats on the bus by seat_quantity
-- ============================================================
DROP TRIGGER IF EXISTS trg_booking_bus_after_insert$$
CREATE TRIGGER trg_booking_bus_after_insert
AFTER INSERT ON booking_bus
FOR EACH ROW
BEGIN
    -- Decrease available seats
    UPDATE buses b
    JOIN  schedules s ON s.bus_id = b.bus_id
    SET   b.available_seats = b.available_seats - NEW.seat_quantity
    WHERE s.schedule_id = NEW.schedule_id;

    -- Log the seat deduction
    INSERT INTO booking_logs (booking_id, action_type, remarks, action_time)
    VALUES (NEW.booking_id, 'SEATS_RESERVED',
            CONCAT('Reserved ', NEW.seat_quantity, ' seat(s) on schedule #', NEW.schedule_id),
            NOW());
END$$

-- ============================================================
-- TRIGGER 2: After booking_hotel INSERT
-- Reduces available_rooms on the room_type
-- ============================================================
DROP TRIGGER IF EXISTS trg_booking_hotel_after_insert$$
CREATE TRIGGER trg_booking_hotel_after_insert
AFTER INSERT ON booking_hotel
FOR EACH ROW
BEGIN
    UPDATE room_types
    SET    available_rooms = available_rooms - 1
    WHERE  room_type_id = NEW.room_type_id;

    INSERT INTO booking_logs (booking_id, action_type, remarks, action_time)
    VALUES (NEW.booking_id, 'ROOM_RESERVED',
            CONCAT('Reserved room_type #', NEW.room_type_id,
                   ' for ', NEW.nights, ' night(s)'),
            NOW());
END$$

-- ============================================================
-- TRIGGER 3: After booking status UPDATE
-- Logs every status transition with old → new values
-- ============================================================
DROP TRIGGER IF EXISTS trg_bookings_status_update$$
CREATE TRIGGER trg_bookings_status_update
AFTER UPDATE ON bookings
FOR EACH ROW
BEGIN
    IF OLD.booking_status <> NEW.booking_status THEN
        INSERT INTO booking_logs
            (booking_id, action_type, old_status, new_status, action_time, remarks)
        VALUES
            (NEW.booking_id,
             CASE NEW.booking_status
                 WHEN 'confirmed'  THEN 'BOOKING_CONFIRMED'
                 WHEN 'cancelled'  THEN 'BOOKING_CANCELLED'
                 WHEN 'completed'  THEN 'TRIP_COMPLETED'
                 ELSE 'STATUS_CHANGED'
             END,
             OLD.booking_status,
             NEW.booking_status,
             NOW(),
             CONCAT('Status changed: ', OLD.booking_status, ' → ', NEW.booking_status));
    END IF;
END$$

-- ============================================================
-- TRIGGER 4: After booking_bus DELETE (cancellation)
-- Restores available_seats when a bus booking is removed
-- ============================================================
DROP TRIGGER IF EXISTS trg_booking_bus_after_delete$$
CREATE TRIGGER trg_booking_bus_after_delete
AFTER DELETE ON booking_bus
FOR EACH ROW
BEGIN
    UPDATE buses b
    JOIN  schedules s ON s.bus_id = b.bus_id
    SET   b.available_seats = b.available_seats + OLD.seat_quantity
    WHERE s.schedule_id = OLD.schedule_id;

    INSERT INTO booking_logs (booking_id, action_type, remarks, action_time)
    VALUES (OLD.booking_id, 'SEATS_RELEASED',
            CONCAT('Released ', OLD.seat_quantity, ' seat(s) from schedule #', OLD.schedule_id),
            NOW());
END$$

-- ============================================================
-- TRIGGER 5: After booking_hotel DELETE (cancellation)
-- Restores available_rooms
-- ============================================================
DROP TRIGGER IF EXISTS trg_booking_hotel_after_delete$$
CREATE TRIGGER trg_booking_hotel_after_delete
AFTER DELETE ON booking_hotel
FOR EACH ROW
BEGIN
    UPDATE room_types
    SET    available_rooms = available_rooms + 1
    WHERE  room_type_id = OLD.room_type_id;

    INSERT INTO booking_logs (booking_id, action_type, remarks, action_time)
    VALUES (OLD.booking_id, 'ROOM_RELEASED',
            CONCAT('Released room_type #', OLD.room_type_id),
            NOW());
END$$

-- ============================================================
-- TRIGGER 6: After payment INSERT
-- Auto-confirms booking when payment is 'completed'
-- ============================================================
DROP TRIGGER IF EXISTS trg_payment_after_insert$$
CREATE TRIGGER trg_payment_after_insert
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    IF NEW.payment_status = 'completed' THEN
        UPDATE bookings
        SET    booking_status = 'confirmed'
        WHERE  booking_id     = NEW.booking_id
          AND  booking_status = 'pending';

        INSERT INTO booking_logs
            (booking_id, action_type, old_status, new_status, performed_by, action_time, remarks)
        VALUES
            (NEW.booking_id, 'PAYMENT_RECEIVED', 'pending', 'confirmed', 'system',
             NOW(), CONCAT('Auto-confirmed after ', NEW.payment_method,
                           ' payment ref: ', COALESCE(NEW.transaction_ref, 'N/A')));
    END IF;
END$$

DELIMITER ;

-- ============================================================
-- End of 06_triggers.sql
-- ============================================================
