-- ============================================================
--  OneReserve — Bangladesh Tourism Reservation System
--  File: 08_functions.sql
--  Description: 6 stored functions for business logic
-- ============================================================

USE onereserve;

DELIMITER $$

-- ============================================================
-- FUNCTION 1: fn_calculate_booking_total
-- Returns bus fare + hotel cost for a hypothetical booking
-- ============================================================
DROP FUNCTION IF EXISTS fn_calculate_booking_total$$
CREATE FUNCTION fn_calculate_booking_total(
    p_schedule_id   INT,
    p_seat_qty      INT,
    p_room_type_id  INT,
    p_nights        INT
) RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_bus_fare    DECIMAL(10,2) DEFAULT 0;
    DECLARE v_room_price  DECIMAL(10,2) DEFAULT 0;

    SELECT fare       INTO v_bus_fare   FROM schedules  WHERE schedule_id  = p_schedule_id;
    SELECT room_price INTO v_room_price FROM room_types WHERE room_type_id = p_room_type_id;

    RETURN (v_bus_fare * p_seat_qty) + (v_room_price * p_nights);
END$$

-- ============================================================
-- FUNCTION 2: fn_get_place_avg_rating
-- Returns the average rating for a place, rounded to 1dp
-- ============================================================
DROP FUNCTION IF EXISTS fn_get_place_avg_rating$$
CREATE FUNCTION fn_get_place_avg_rating(p_place_id INT)
RETURNS DECIMAL(3,1)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_avg DECIMAL(3,1) DEFAULT 0.0;
    SELECT ROUND(AVG(rating), 1) INTO v_avg
    FROM   reviews
    WHERE  place_id = p_place_id;
    RETURN COALESCE(v_avg, 0.0);
END$$

-- ============================================================
-- FUNCTION 3: fn_seats_available
-- Returns remaining available seats for a schedule
-- ============================================================
DROP FUNCTION IF EXISTS fn_seats_available$$
CREATE FUNCTION fn_seats_available(p_schedule_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_avail INT DEFAULT 0;
    SELECT b.available_seats INTO v_avail
    FROM   buses b
    JOIN   schedules s ON s.bus_id = b.bus_id
    WHERE  s.schedule_id = p_schedule_id;
    RETURN COALESCE(v_avail, 0);
END$$

-- ============================================================
-- FUNCTION 4: fn_user_total_spent
-- Returns the total confirmed amount spent by a user
-- ============================================================
DROP FUNCTION IF EXISTS fn_user_total_spent$$
CREATE FUNCTION fn_user_total_spent(p_user_id INT)
RETURNS DECIMAL(14,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(14,2) DEFAULT 0;
    SELECT COALESCE(SUM(py.amount), 0) INTO v_total
    FROM   payments py
    JOIN   bookings bk ON py.booking_id = bk.booking_id
    WHERE  bk.user_id = p_user_id
      AND  py.payment_status = 'completed';
    RETURN v_total;
END$$

-- ============================================================
-- FUNCTION 5: fn_journey_hours
-- Returns journey duration in hours from a schedule
-- ============================================================
DROP FUNCTION IF EXISTS fn_journey_hours$$
CREATE FUNCTION fn_journey_hours(p_schedule_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_hours INT DEFAULT 0;
    SELECT TIMESTAMPDIFF(HOUR, departure_time, arrival_time)
    INTO   v_hours
    FROM   schedules
    WHERE  schedule_id = p_schedule_id;
    RETURN COALESCE(v_hours, 0);
END$$

-- ============================================================
-- FUNCTION 6: fn_booking_status_label
-- Returns a human-readable Bangla/English label for status
-- ============================================================
DROP FUNCTION IF EXISTS fn_booking_status_label$$
CREATE FUNCTION fn_booking_status_label(p_status VARCHAR(30))
RETURNS VARCHAR(60)
DETERMINISTIC
NO SQL
BEGIN
    RETURN CASE p_status
        WHEN 'pending'   THEN 'Pending Payment'
        WHEN 'confirmed' THEN 'Booking Confirmed ✓'
        WHEN 'cancelled' THEN 'Cancelled'
        WHEN 'completed' THEN 'Trip Completed ✓'
        ELSE 'Unknown Status'
    END;
END$$

DELIMITER ;

-- ============================================================
-- End of 08_functions.sql
-- ============================================================
