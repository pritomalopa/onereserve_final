-- ============================================================
--  OneReserve — Bangladesh Tourism Reservation System
--  File: 01_schema.sql
--  Description: Complete production schema — 15 tables
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;
DROP DATABASE IF EXISTS onereserve;
CREATE DATABASE onereserve
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE onereserve;

-- ============================================================
-- TABLE 1: users
-- ============================================================
CREATE TABLE users (
    user_id       INT            AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100)   NOT NULL,
    email         VARCHAR(150)   NOT NULL,
    password      VARCHAR(255)   NOT NULL,
    phone         VARCHAR(20),
    created_at    TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    is_active     TINYINT(1)     NOT NULL DEFAULT 1,

    CONSTRAINT uq_users_email UNIQUE (email),
    CONSTRAINT chk_users_email CHECK (email LIKE '%@%.%'),
    CONSTRAINT chk_users_phone CHECK (phone REGEXP '^[0-9+]{10,15}$' OR phone IS NULL),

    INDEX idx_users_email  (email),
    INDEX idx_users_active (is_active)
);

-- ============================================================
-- TABLE 2: districts
-- ============================================================
CREATE TABLE districts (
    district_id   INT           AUTO_INCREMENT PRIMARY KEY,
    district_name VARCHAR(100)  NOT NULL,

    CONSTRAINT uq_districts_name UNIQUE (district_name),
    INDEX idx_districts_name (district_name)
);

-- ============================================================
-- TABLE 3: places
-- ============================================================
CREATE TABLE places (
    place_id      INT             AUTO_INCREMENT PRIMARY KEY,
    district_id   INT             NOT NULL,
    place_name    VARCHAR(150)    NOT NULL,
    description   TEXT,
    image_path    VARCHAR(255),
    latitude      DECIMAL(10,8),
    longitude     DECIMAL(11,8),
    google_map_url TEXT,
    category      VARCHAR(60),
    is_featured   TINYINT(1)      NOT NULL DEFAULT 0,

    CONSTRAINT fk_places_district
        FOREIGN KEY (district_id) REFERENCES districts(district_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_places_lat  CHECK (latitude  BETWEEN  -90  AND  90  OR latitude  IS NULL),
    CONSTRAINT chk_places_lng  CHECK (longitude BETWEEN -180  AND 180  OR longitude IS NULL),

    INDEX idx_places_district  (district_id),
    INDEX idx_places_category  (category),
    INDEX idx_places_featured  (is_featured),
    FULLTEXT INDEX ft_places_name_desc (place_name, description)
);

-- ============================================================
-- TABLE 4: bus_companies
-- ============================================================
CREATE TABLE bus_companies (
    company_id    INT           AUTO_INCREMENT PRIMARY KEY,
    company_name  VARCHAR(100)  NOT NULL,
    contact_no    VARCHAR(20),
    logo_path     VARCHAR(255),
    is_active     TINYINT(1)    NOT NULL DEFAULT 1,

    CONSTRAINT uq_bus_companies_name UNIQUE (company_name),
    INDEX idx_bus_companies_active (is_active)
);

-- ============================================================
-- TABLE 5: buses
-- ============================================================
CREATE TABLE buses (
    bus_id          INT          AUTO_INCREMENT PRIMARY KEY,
    company_id      INT          NOT NULL,
    bus_name        VARCHAR(100) NOT NULL,
    bus_type        VARCHAR(50)  NOT NULL,
    seat_capacity   INT          NOT NULL,
    available_seats INT          NOT NULL DEFAULT 0,

    CONSTRAINT fk_buses_company
        FOREIGN KEY (company_id) REFERENCES bus_companies(company_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_buses_capacity CHECK (seat_capacity > 0),
    CONSTRAINT chk_buses_avail    CHECK (available_seats >= 0 AND available_seats <= seat_capacity),

    INDEX idx_buses_company  (company_id),
    INDEX idx_buses_type     (bus_type)
);

-- ============================================================
-- TABLE 6: schedules
-- ============================================================
CREATE TABLE schedules (
    schedule_id      INT             AUTO_INCREMENT PRIMARY KEY,
    bus_id           INT             NOT NULL,
    place_id         INT             NOT NULL,
    departure_city   VARCHAR(100)    NOT NULL DEFAULT 'Dhaka',
    departure_time   DATETIME        NOT NULL,
    arrival_time     DATETIME        NOT NULL,
    fare             DECIMAL(10,2)   NOT NULL,
    is_active        TINYINT(1)      NOT NULL DEFAULT 1,

    CONSTRAINT fk_schedules_bus
        FOREIGN KEY (bus_id)   REFERENCES buses(bus_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_schedules_place
        FOREIGN KEY (place_id) REFERENCES places(place_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_schedules_fare       CHECK (fare > 0),
    CONSTRAINT chk_schedules_time_order CHECK (arrival_time > departure_time),

    INDEX idx_schedules_bus         (bus_id),
    INDEX idx_schedules_place       (place_id),
    INDEX idx_schedules_departure   (departure_time),
    INDEX idx_schedules_active      (is_active)
);

-- ============================================================
-- TABLE 7: hotels
-- ============================================================
CREATE TABLE hotels (
    hotel_id    INT             AUTO_INCREMENT PRIMARY KEY,
    place_id    INT             NOT NULL,
    hotel_name  VARCHAR(150)    NOT NULL,
    address     TEXT,
    rating      DECIMAL(2,1)    DEFAULT 0.0,
    image_path  VARCHAR(255),
    is_active   TINYINT(1)      NOT NULL DEFAULT 1,

    CONSTRAINT fk_hotels_place
        FOREIGN KEY (place_id) REFERENCES places(place_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_hotels_rating CHECK (rating BETWEEN 0.0 AND 5.0),

    INDEX idx_hotels_place   (place_id),
    INDEX idx_hotels_rating  (rating),
    INDEX idx_hotels_active  (is_active)
);

-- ============================================================
-- TABLE 8: room_types
-- ============================================================
CREATE TABLE room_types (
    room_type_id     INT             AUTO_INCREMENT PRIMARY KEY,
    hotel_id         INT             NOT NULL,
    room_name        VARCHAR(100)    NOT NULL,
    room_price       DECIMAL(10,2)   NOT NULL,
    room_capacity    INT             NOT NULL DEFAULT 2,
    available_rooms  INT             NOT NULL DEFAULT 0,
    amenities        TEXT,

    CONSTRAINT fk_room_types_hotel
        FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_room_price    CHECK (room_price > 0),
    CONSTRAINT chk_room_capacity CHECK (room_capacity > 0),
    CONSTRAINT chk_room_avail    CHECK (available_rooms >= 0),

    INDEX idx_room_types_hotel (hotel_id),
    INDEX idx_room_types_price (room_price)
);

-- ============================================================
-- TABLE 9: bookings  (master booking record)
-- ============================================================
CREATE TABLE bookings (
    booking_id      INT              AUTO_INCREMENT PRIMARY KEY,
    user_id         INT              NOT NULL,
    booking_date    TIMESTAMP        DEFAULT CURRENT_TIMESTAMP,
    total_amount    DECIMAL(12,2)    NOT NULL DEFAULT 0.00,
    booking_status  VARCHAR(30)      NOT NULL DEFAULT 'pending',
    notes           TEXT,

    CONSTRAINT fk_bookings_user
        FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_bookings_status CHECK (
        booking_status IN ('pending','confirmed','cancelled','completed')
    ),
    CONSTRAINT chk_bookings_amount CHECK (total_amount >= 0),

    INDEX idx_bookings_user    (user_id),
    INDEX idx_bookings_status  (booking_status),
    INDEX idx_bookings_date    (booking_date)
);

-- ============================================================
-- TABLE 10: booking_bus
-- ============================================================
CREATE TABLE booking_bus (
    id           INT             AUTO_INCREMENT PRIMARY KEY,
    booking_id   INT             NOT NULL,
    schedule_id  INT             NOT NULL,
    seat_quantity INT            NOT NULL DEFAULT 1,
    fare         DECIMAL(10,2)   NOT NULL,

    CONSTRAINT fk_booking_bus_booking
        FOREIGN KEY (booking_id)  REFERENCES bookings(booking_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_booking_bus_schedule
        FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_bb_seats CHECK (seat_quantity > 0),
    CONSTRAINT chk_bb_fare  CHECK (fare > 0),

    UNIQUE INDEX uq_booking_bus (booking_id, schedule_id),
    INDEX idx_booking_bus_schedule (schedule_id)
);

-- ============================================================
-- TABLE 11: booking_hotel
-- ============================================================
CREATE TABLE booking_hotel (
    id             INT             AUTO_INCREMENT PRIMARY KEY,
    booking_id     INT             NOT NULL,
    room_type_id   INT             NOT NULL,
    checkin_date   DATE            NOT NULL,
    checkout_date  DATE            NOT NULL,
    nights         INT             NOT NULL,
    room_cost      DECIMAL(10,2)   NOT NULL,

    CONSTRAINT fk_booking_hotel_booking
        FOREIGN KEY (booking_id)   REFERENCES bookings(booking_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_booking_hotel_room
        FOREIGN KEY (room_type_id) REFERENCES room_types(room_type_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_bh_dates  CHECK (checkout_date > checkin_date),
    CONSTRAINT chk_bh_nights CHECK (nights > 0),
    CONSTRAINT chk_bh_cost   CHECK (room_cost > 0),

    UNIQUE INDEX uq_booking_hotel (booking_id, room_type_id, checkin_date),
    INDEX idx_booking_hotel_room (room_type_id)
);

-- ============================================================
-- TABLE 12: payments
-- ============================================================
CREATE TABLE payments (
    payment_id      INT              AUTO_INCREMENT PRIMARY KEY,
    booking_id      INT              NOT NULL,
    amount          DECIMAL(12,2)    NOT NULL,
    payment_method  VARCHAR(50)      NOT NULL,
    payment_status  VARCHAR(30)      NOT NULL DEFAULT 'pending',
    payment_date    TIMESTAMP        DEFAULT CURRENT_TIMESTAMP,
    transaction_ref VARCHAR(100),

    CONSTRAINT fk_payments_booking
        FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_payments_amount  CHECK (amount > 0),
    CONSTRAINT chk_payments_method  CHECK (
        payment_method IN ('bkash','nagad','rocket','card','bank_transfer','cash')
    ),
    CONSTRAINT chk_payments_status  CHECK (
        payment_status IN ('pending','completed','failed','refunded')
    ),

    INDEX idx_payments_booking (booking_id),
    INDEX idx_payments_status  (payment_status),
    INDEX idx_payments_method  (payment_method)
);

-- ============================================================
-- TABLE 13: reviews
-- ============================================================
CREATE TABLE reviews (
    review_id    INT          AUTO_INCREMENT PRIMARY KEY,
    user_id      INT          NOT NULL,
    place_id     INT          NOT NULL,
    rating       INT          NOT NULL,
    review_text  TEXT,
    review_date  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_reviews_user
        FOREIGN KEY (user_id)  REFERENCES users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_reviews_place
        FOREIGN KEY (place_id) REFERENCES places(place_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_reviews_rating CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT uq_reviews_user_place UNIQUE (user_id, place_id),

    INDEX idx_reviews_place  (place_id),
    INDEX idx_reviews_rating (rating)
);

-- ============================================================
-- TABLE 14: wishlist
-- ============================================================
CREATE TABLE wishlist (
    wishlist_id  INT        AUTO_INCREMENT PRIMARY KEY,
    user_id      INT        NOT NULL,
    place_id     INT        NOT NULL,
    added_at     TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_wishlist_user
        FOREIGN KEY (user_id)  REFERENCES users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_wishlist_place
        FOREIGN KEY (place_id) REFERENCES places(place_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_wishlist_user_place UNIQUE (user_id, place_id),

    INDEX idx_wishlist_user  (user_id),
    INDEX idx_wishlist_place (place_id)
);

-- ============================================================
-- TABLE 15: booking_logs  (audit trail + trigger demo)
-- ============================================================
CREATE TABLE booking_logs (
    log_id       INT          AUTO_INCREMENT PRIMARY KEY,
    booking_id   INT,
    action_type  VARCHAR(50)  NOT NULL,
    old_status   VARCHAR(30),
    new_status   VARCHAR(30),
    performed_by VARCHAR(100),
    action_time  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    remarks      TEXT,

    INDEX idx_booking_logs_booking (booking_id),
    INDEX idx_booking_logs_action  (action_type),
    INDEX idx_booking_logs_time    (action_time)
);

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- End of 01_schema.sql
-- ============================================================
