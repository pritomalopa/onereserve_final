-- ============================================================
--  OneReserve — Bangladesh Tourism Reservation System
--  File: 05_views.sql
--  Description: 8 production-ready VIEWs
-- ============================================================

USE onereserve;

-- ============================================================
-- VIEW 1: vw_place_details
-- Full place info including district name and review stats
-- ============================================================
CREATE OR REPLACE VIEW vw_place_details AS
SELECT
    p.place_id,
    p.place_name,
    p.description,
    p.category,
    p.image_path,
    p.latitude,
    p.longitude,
    p.google_map_url,
    p.is_featured,
    d.district_id,
    d.district_name,
    COUNT(r.review_id)           AS total_reviews,
    ROUND(AVG(r.rating), 1)      AS avg_rating,
    COUNT(w.wishlist_id)         AS wishlist_count
FROM places p
JOIN  districts d  ON p.district_id = d.district_id
LEFT JOIN reviews  r ON p.place_id   = r.place_id
LEFT JOIN wishlist w ON p.place_id   = w.place_id
GROUP BY p.place_id, p.place_name, p.description, p.category,
         p.image_path, p.latitude, p.longitude, p.google_map_url,
         p.is_featured, d.district_id, d.district_name;

-- ============================================================
-- VIEW 2: vw_schedule_details
-- Full schedule info with bus, company, and place name
-- ============================================================
CREATE OR REPLACE VIEW vw_schedule_details AS
SELECT
    s.schedule_id,
    s.departure_city,
    s.departure_time,
    s.arrival_time,
    s.fare,
    s.is_active,
    TIMESTAMPDIFF(HOUR, s.departure_time, s.arrival_time) AS journey_hours,
    b.bus_id,
    b.bus_name,
    b.bus_type,
    b.seat_capacity,
    b.available_seats,
    bc.company_id,
    bc.company_name,
    bc.logo_path   AS company_logo,
    p.place_id,
    p.place_name,
    p.category     AS place_category,
    d.district_name
FROM schedules s
JOIN buses        b  ON s.bus_id      = b.bus_id
JOIN bus_companies bc ON b.company_id  = bc.company_id
JOIN places       p  ON s.place_id    = p.place_id
JOIN districts    d  ON p.district_id = d.district_id;

-- ============================================================
-- VIEW 3: vw_hotel_details
-- Hotel with place info and room summary
-- ============================================================
CREATE OR REPLACE VIEW vw_hotel_details AS
SELECT
    h.hotel_id,
    h.hotel_name,
    h.address,
    h.rating,
    h.image_path,
    h.is_active,
    p.place_id,
    p.place_name,
    d.district_name,
    COUNT(rt.room_type_id)               AS room_type_count,
    MIN(rt.room_price)                   AS min_price,
    MAX(rt.room_price)                   AS max_price,
    SUM(rt.available_rooms)              AS total_available_rooms
FROM hotels h
JOIN  places     p  ON h.place_id    = p.place_id
JOIN  districts  d  ON p.district_id = d.district_id
LEFT JOIN room_types rt ON h.hotel_id = rt.hotel_id
GROUP BY h.hotel_id, h.hotel_name, h.address, h.rating,
         h.image_path, h.is_active, p.place_id, p.place_name, d.district_name;

-- ============================================================
-- VIEW 4: vw_booking_summary
-- Full booking overview for a user
-- ============================================================
CREATE OR REPLACE VIEW vw_booking_summary AS
SELECT
    bk.booking_id,
    bk.booking_date,
    bk.total_amount,
    bk.booking_status,
    bk.notes,
    u.user_id,
    u.full_name,
    u.email,
    -- Bus info
    p_bus.place_name   AS destination,
    d_bus.district_name,
    s.departure_time,
    s.arrival_time,
    b.bus_name,
    b.bus_type,
    bb.seat_quantity,
    bb.fare            AS bus_fare,
    -- Hotel info
    h.hotel_name,
    rt.room_name,
    bh.checkin_date,
    bh.checkout_date,
    bh.nights,
    bh.room_cost,
    -- Payment
    py.payment_status,
    py.payment_method,
    py.amount          AS paid_amount
FROM bookings bk
JOIN  users         u    ON bk.user_id      = u.user_id
LEFT JOIN booking_bus  bb   ON bk.booking_id    = bb.booking_id
LEFT JOIN schedules    s    ON bb.schedule_id   = s.schedule_id
LEFT JOIN buses        b    ON s.bus_id         = b.bus_id
LEFT JOIN places       p_bus ON s.place_id      = p_bus.place_id
LEFT JOIN districts    d_bus ON p_bus.district_id = d_bus.district_id
LEFT JOIN booking_hotel bh  ON bk.booking_id    = bh.booking_id
LEFT JOIN room_types   rt   ON bh.room_type_id  = rt.room_type_id
LEFT JOIN hotels       h    ON rt.hotel_id      = h.hotel_id
LEFT JOIN payments     py   ON bk.booking_id    = py.booking_id;

-- ============================================================
-- VIEW 5: vw_popular_places
-- Places ranked by booking count and avg rating
-- ============================================================
CREATE OR REPLACE VIEW vw_popular_places AS
SELECT
    p.place_id,
    p.place_name,
    p.category,
    p.image_path,
    d.district_name,
    COUNT(DISTINCT bb.booking_id)   AS total_bookings,
    COUNT(DISTINCT r.review_id)     AS total_reviews,
    ROUND(AVG(r.rating), 1)         AS avg_rating,
    COUNT(DISTINCT w.wishlist_id)   AS wishlist_count
FROM places p
JOIN  districts  d  ON p.district_id = d.district_id
LEFT JOIN schedules   s   ON p.place_id   = s.place_id
LEFT JOIN booking_bus bb  ON s.schedule_id = bb.schedule_id
LEFT JOIN reviews     r   ON p.place_id   = r.place_id
LEFT JOIN wishlist    w   ON p.place_id   = w.place_id
GROUP BY p.place_id, p.place_name, p.category, p.image_path, d.district_name
ORDER BY total_bookings DESC, avg_rating DESC;

-- ============================================================
-- VIEW 6: vw_revenue_summary
-- Revenue by payment method and booking status
-- ============================================================
CREATE OR REPLACE VIEW vw_revenue_summary AS
SELECT
    py.payment_method,
    py.payment_status,
    COUNT(py.payment_id)          AS transaction_count,
    SUM(py.amount)                AS total_revenue,
    ROUND(AVG(py.amount), 2)      AS avg_transaction,
    MIN(py.amount)                AS min_transaction,
    MAX(py.amount)                AS max_transaction
FROM payments py
GROUP BY py.payment_method, py.payment_status;

-- ============================================================
-- VIEW 7: vw_user_dashboard
-- Per-user stats: bookings, total spent, reviews, wishlist
-- ============================================================
CREATE OR REPLACE VIEW vw_user_dashboard AS
SELECT
    u.user_id,
    u.full_name,
    u.email,
    u.phone,
    u.created_at,
    COUNT(DISTINCT bk.booking_id)                                             AS total_bookings,
    SUM(CASE WHEN bk.booking_status = 'completed' THEN 1 ELSE 0 END)         AS completed_trips,
    SUM(CASE WHEN bk.booking_status = 'confirmed' THEN 1 ELSE 0 END)         AS upcoming_trips,
    SUM(CASE WHEN bk.booking_status = 'cancelled' THEN 1 ELSE 0 END)         AS cancelled_trips,
    COALESCE(SUM(py.amount), 0)                                               AS total_spent,
    COUNT(DISTINCT r.review_id)                                               AS reviews_written,
    COUNT(DISTINCT w.wishlist_id)                                             AS wishlist_items
FROM users u
LEFT JOIN bookings bk ON u.user_id = bk.user_id
LEFT JOIN payments py ON bk.booking_id = py.booking_id AND py.payment_status = 'completed'
LEFT JOIN reviews  r  ON u.user_id = r.user_id
LEFT JOIN wishlist w  ON u.user_id = w.user_id
GROUP BY u.user_id, u.full_name, u.email, u.phone, u.created_at;

-- ============================================================
-- VIEW 8: vw_available_schedules
-- Only active, future schedules with seats available
-- ============================================================
CREATE OR REPLACE VIEW vw_available_schedules AS
SELECT
    s.schedule_id,
    s.departure_city,
    s.departure_time,
    s.arrival_time,
    s.fare,
    TIMESTAMPDIFF(HOUR, s.departure_time, s.arrival_time) AS journey_hours,
    b.bus_name,
    b.bus_type,
    b.available_seats,
    bc.company_name,
    p.place_name    AS destination,
    d.district_name
FROM schedules s
JOIN buses         b  ON s.bus_id      = b.bus_id
JOIN bus_companies bc ON b.company_id  = bc.company_id
JOIN places        p  ON s.place_id    = p.place_id
JOIN districts     d  ON p.district_id = d.district_id
WHERE s.is_active        = 1
  AND b.available_seats  > 0
  AND s.departure_time   > NOW();

-- ============================================================
-- End of 05_views.sql
-- ============================================================
