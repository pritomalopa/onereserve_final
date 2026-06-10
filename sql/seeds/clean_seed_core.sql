-- ============================================================
--  OneReserve — Bangladesh Tourism Reservation System
--  File: 02_seed_core.sql
--  Description: Districts, Places, Bus Companies, Buses, Schedules
-- ============================================================

USE onereserve;

-- ============================================================
-- DISTRICTS
-- ============================================================
INSERT INTO districts (district_name) VALUES
("Cox's Bazar"),
('Patuakhali'),
('Chattogram'),
('Noakhali'),
('Moulvibazar'),
('Sylhet'),
('Sunamganj'),
('Bandarban'),
('Rangamati'),
('Khagrachari'),
('Khulna'),
('Bagerhat'),
('Naogaon'),
('Bogura'),
('Rajshahi');

-- ============================================================
-- PLACES
-- ============================================================
INSERT INTO places (district_id, place_name, description, image_path, latitude, longitude, google_map_url, category, is_featured)
VALUES
(1, "Cox's Bazar", 'Longest natural unbroken sea beach in the world, stretching 120 km along the Bay of Bengal.', 'assets/places/coxs_bazar.jpg', 21.42720, 92.00580, 'https://goo.gl/maps/coxsbazar', 'Coastal', 1),
(1, "Saint Martin's Island", "Bangladesh's only coral island featuring crystal-clear blue waters and the secluded Chera Dwip peninsula.", 'assets/places/saint_martin.jpg', 20.62720, 92.32280, 'https://goo.gl/maps/saintmartin', 'Coastal', 1),
(2, 'Kuakata', 'Known as Sagar Kannya (Daughter of the Sea) - the only beach in Bangladesh where you can witness both sunrise and sunset.', 'assets/places/kuakata.jpg', 21.81670, 90.11670, 'https://goo.gl/maps/kuakata', 'Coastal', 1),
(3, 'Patenga Beach', 'A popular, bustling beach near Chattogram port city, ideal for sunset views and waterfront street food.', 'assets/places/patenga.jpg', 22.23450, 91.79460, 'https://goo.gl/maps/patenga', 'Coastal', 0),
(3, 'Guliakhali Beach', 'Located in Sitakunda, this hidden gem is famous for its unique landscape of emerald grass meeting tidal canals.', 'assets/places/guliakhali.jpg', 22.62890, 91.56450, 'https://goo.gl/maps/guliakhali', 'Coastal', 0),
(4, 'Nijhum Dwip', 'A tranquil island in the Bay of Bengal famous for dense mangrove forest and one of the largest herds of spotted deer in Bangladesh.', 'assets/places/nijhum_dwip.jpg', 22.06280, 91.00280, 'https://goo.gl/maps/nijhumdwip', 'Island', 0),
(5, 'Srimangal', 'The Tea Capital of Bangladesh - home to vast emerald tea estates, seven-layer tea, and the wildlife-rich Lawachara National Park.', 'assets/places/srimangal.jpg', 24.30650, 91.72950, 'https://goo.gl/maps/srimangal', 'Nature', 1),
(6, 'Jaflong', 'A scenic gem at the foothills of the Khasi and Jaintia hills where crystal rivers carry giant boulders down from Meghalaya.', 'assets/places/jaflong.jpg', 25.16340, 92.01930, 'https://goo.gl/maps/jaflong', 'Nature', 0),
(6, 'Ratargul Swamp Forest', "Bangladesh's only freshwater swamp forest - a mystical flooded jungle navigable only by narrow wooden boats.", 'assets/places/ratargul.jpg', 25.00040, 91.86870, 'https://goo.gl/maps/ratargul', 'Nature', 1),
(7, 'Tanguar Haor', 'A RAMSAR-designated vast wetland in Sunamganj hosting over 200 species of migratory birds and shimmering cloud reflections.', 'assets/places/tanguar_haor.jpg', 25.09350, 91.07700, 'https://goo.gl/maps/tanguarhaor', 'Wetland', 1),
(5, 'Madhabkunda Waterfall', 'One of the largest cascading waterfalls in Bangladesh, set amid betel leaf plantations and rubber forest.', 'assets/places/madhabkunda.jpg', 24.63670, 92.22410, 'https://goo.gl/maps/madhabkunda', 'Nature', 0),
(8, 'Bandarban', "Bangladesh's most dramatic hill district - home to Boga Lake, Saka Haphong (highest peak), Nilgiri, and rich indigenous culture.", 'assets/places/bandarban.jpg', 22.19530, 92.21840, 'https://goo.gl/maps/bandarban', 'Hills', 1),
(9, 'Rangamati', 'The jewel of the Chittagong Hill Tracts, famous for the expansive Kaptai Lake, iconic hanging bridge, and tribal craft markets.', 'assets/places/rangamati.jpg', 22.65330, 92.15250, 'https://goo.gl/maps/rangamati', 'Hills', 1),
(10, 'Khagrachari', 'A stunning hilly district known for the mysterious Alutila Cave, the Risang Khong hanging bridge, and scenic tribal villages.', 'assets/places/khagrachari.jpg', 23.11050, 91.99610, 'https://goo.gl/maps/khagrachari', 'Hills', 0),
(11, 'Sundarbans', 'A UNESCO World Heritage Site and the largest mangrove forest in the world - last stronghold of the Royal Bengal Tiger.', 'assets/places/sundarbans.jpg', 21.94970, 89.18330, 'https://goo.gl/maps/sundarbans', 'Heritage', 1),
(12, 'Bagerhat', 'A UNESCO World Heritage City showcasing exquisite 15th-century Islamic architecture, headlined by the iconic Sixty Dome Mosque.', 'assets/places/bagerhat.jpg', 22.65650, 89.78910, 'https://goo.gl/maps/bagerhat', 'Heritage', 1),
(13, 'Paharpur', 'Home to Somapura Mahavihara - a UNESCO World Heritage site and one of the greatest ancient Buddhist monasteries in South Asia.', 'assets/places/paharpur.jpg', 25.03050, 88.97740, 'https://goo.gl/maps/paharpur', 'Heritage', 0),
(14, 'Mahasthangarh', 'Located in Bogura, this is the earliest known archaeological site in Bangladesh, with continuous occupation from the 3rd century BC.', 'assets/places/mahasthangarh.jpg', 24.96200, 89.34560, 'https://goo.gl/maps/mahasthangarh', 'Heritage', 0),
(15, 'Puthia Temple Complex', 'Rajshahi district houses the largest concentration of historically significant Hindu temples in Bangladesh in a single campus.', 'assets/places/puthia.jpg', 24.36420, 88.83540, 'https://goo.gl/maps/puthia', 'Heritage', 0),
(15, 'Varendra Research Museum', 'The oldest museum in Bangladesh, in Rajshahi, housing thousands of ancient sculptures, terracotta plaques, coins, and inscriptions.', 'assets/places/varendra.jpg', 24.36670, 88.59960, 'https://goo.gl/maps/varendra', 'Heritage', 0);

-- ============================================================
-- BUS COMPANIES
-- ============================================================
INSERT INTO bus_companies (company_name, contact_no, logo_path) VALUES
('Green Line', '01711122233', 'assets/logos/green_line.png'),
('Hanif Enterprise', '01713046025', 'assets/logos/hanif.png'),
('Shyamoli Paribahan', '01711428612', 'assets/logos/shyamoli.png'),
('Ena Transport', '01711536974', 'assets/logos/ena.png'),
('Sohag Paribahan', '01711645321', 'assets/logos/sohag.png'),
('Saintmartin Paribahan', '01711987654', 'assets/logos/saintmartin.png');

-- ============================================================
-- BUSES
-- ============================================================
INSERT INTO buses (company_id, bus_name, bus_type, seat_capacity, available_seats) VALUES
(1, 'Green Line Scania Multi-Axle', 'AC Business Class', 36, 36),
(1, 'Green Line Volvo B11R', 'AC Premium', 36, 36),
(1, 'Green Line Sleeper Coach', 'AC Sleeper', 30, 30),
(1, 'Green Line Hino RM2', 'AC Economy', 40, 40),
(1, 'Green Line Hyundai Universe', 'AC Business Class', 36, 36),
(2, 'Hanif Hino AK1J-01', 'Non-AC', 40, 40),
(2, 'Hanif Hino AK1J-02', 'Non-AC', 40, 40),
(2, 'Hanif Volvo B9R', 'AC Deluxe', 36, 36),
(2, 'Hanif Scania Touring', 'AC Business', 36, 36),
(2, 'Hanif Hino AK1J-03', 'Non-AC', 40, 40),
(3, 'Shyamoli Hino AK1J', 'Non-AC', 40, 40),
(3, 'Shyamoli Hyundai Universe', 'AC Premium', 36, 36),
(3, 'Shyamoli Scania K360', 'AC Business Class', 36, 36),
(3, 'Shyamoli Hino AK1J-S2', 'Non-AC', 40, 40),
(3, 'Shyamoli Volvo B11R', 'AC Deluxe', 36, 36),
(4, 'Ena Hino AK1J-E1', 'Non-AC', 40, 40),
(4, 'Ena Hino AK1J-E2', 'Non-AC', 40, 40),
(4, 'Ena Hyundai Universe-E1', 'AC Deluxe', 36, 36),
(4, 'Ena Hyundai Universe-E2', 'AC Deluxe', 36, 36),
(4, 'Ena Hino AK1J-E3', 'Non-AC', 40, 40),
(5, 'Sohag Scania Multi-Axle', 'AC Business Class', 36, 36),
(5, 'Sohag Volvo B11R', 'AC Premium', 36, 36),
(5, 'Sohag Sleeper Coach', 'AC Sleeper', 30, 30),
(5, 'Sohag Hino AK1J', 'Non-AC', 40, 40),
(5, 'Sohag Scania Touring', 'AC Business Class', 36, 36),
(6, 'Saintmartin Hino RM2', 'AC Deluxe', 40, 40),
(6, 'Saintmartin Hyundai Universe', 'AC Premium', 36, 36),
(6, 'Saintmartin Sleeper Coach', 'AC Sleeper', 30, 30),
(6, 'Saintmartin Hino AK1J', 'Non-AC', 40, 40),
(6, 'Saintmartin Scania K360', 'AC Business Class', 36, 36);

-- ============================================================
-- SCHEDULES
-- ============================================================
INSERT INTO schedules (bus_id, place_id, departure_city, departure_time, arrival_time, fare, is_active) VALUES
(1, 1, 'Dhaka', '2026-06-10 06:00:00', '2026-06-10 16:00:00', 1980.00, 1),
(2, 2, 'Dhaka', '2026-06-10 10:00:00', '2026-06-10 22:00:00', 2280.00, 1),
(3, 3, 'Dhaka', '2026-06-10 14:00:00', '2026-06-10 22:00:00', 1800.00, 1),
(4, 4, 'Dhaka', '2026-06-10 18:00:00', '2026-06-11 00:00:00', 1240.00, 1),
(5, 5, 'Dhaka', '2026-06-10 08:00:00', '2026-06-10 17:30:00', 1400.00, 1),
(6, 6, 'Dhaka', '2026-06-10 12:00:00', '2026-06-11 03:00:00', 2500.00, 1),
(7, 7, 'Dhaka', '2026-06-10 07:00:00', '2026-06-10 15:00:00', 1950.00, 1),
(8, 8, 'Dhaka', '2026-06-10 11:00:00', '2026-06-10 18:30:00', 1650.00, 1),
(9, 9, 'Dhaka', '2026-06-10 09:00:00', '2026-06-10 17:00:00', 1720.00, 1),
(10, 10, 'Dhaka', '2026-06-10 13:00:00', '2026-06-10 21:30:00', 2100.00, 1),
(11, 11, 'Dhaka', '2026-06-10 06:30:00', '2026-06-10 14:30:00', 1550.00, 1),
(12, 12, 'Dhaka', '2026-06-10 10:30:00', '2026-06-10 18:00:00', 1810.00, 1),
(13, 13, 'Dhaka', '2026-06-10 14:30:00', '2026-06-10 23:00:00', 2050.00, 1),
(14, 14, 'Dhaka', '2026-06-10 15:00:00', '2026-06-11 00:30:00', 1900.00, 1),
(15, 15, 'Dhaka', '2026-06-10 07:30:00', '2026-06-10 17:00:00', 1600.00, 1),
(16, 16, 'Dhaka', '2026-06-10 08:30:00', '2026-06-10 18:30:00', 1850.00, 1),
(17, 17, 'Dhaka', '2026-06-10 09:30:00', '2026-06-10 19:00:00', 1750.00, 1),
(18, 18, 'Dhaka', '2026-06-10 12:30:00', '2026-06-10 21:30:00', 2150.00, 1),
(19, 19, 'Dhaka', '2026-06-10 13:30:00', '2026-06-10 22:30:00', 2200.00, 1),
(20, 20, 'Dhaka', '2026-06-10 11:30:00', '2026-06-10 20:00:00', 1900.00, 1);
