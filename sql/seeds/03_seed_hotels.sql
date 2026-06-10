-- ============================================================
--  OneReserve — Bangladesh Tourism Reservation System
--  File: 03_seed_hotels.sql
--  Description: Hotels (60 rows) + Room Types (180 rows — 3 per hotel)
-- ============================================================

USE onereserve;

-- ============================================================
-- HOTELS  (60 rows — 3 per place)
-- ============================================================

-- Places 1–7 (21 hotels)
INSERT INTO hotels (place_id, hotel_name, address, rating, image_path) VALUES
(1,'Sayeman Beach Resort',          'Marine Drive, Kolatoli, Cox''s Bazar',               4.7,'assets/hotels/sayeman.jpg'),
(1,'Ocean Paradise Hotel & Resort', 'VVIP Road, Kolatoli, Cox''s Bazar',                  4.5,'assets/hotels/ocean_paradise.jpg'),
(1,'Seagull Hotels Ltd',            'Sugandha Beach, Cox''s Bazar',                        4.3,'assets/hotels/seagull.jpg'),
(2,'Blue Marine Resort',            'Bazar Road, Saint Martin Island',                     4.2,'assets/hotels/blue_marine.jpg'),
(2,'Fantasy Jetty Resort',          'Jetty Ghat, Saint Martin Island',                     4.0,'assets/hotels/fantasy_jetty.jpg'),
(2,'Labiba Bilas Resort',           'West Beach, Saint Martin Island',                     4.1,'assets/hotels/labiba_bilas.jpg'),
(3,'Hotel Graver Inn International','Kuakata Beach Road, Patuakhali',                      4.4,'assets/hotels/graver_inn.jpg'),
(3,'Sikder Resort & Villas',        'Kuakata Eco Park Road, Patuakhali',                   4.6,'assets/hotels/sikder_resort.jpg'),
(3,'Hotel Khan Jahan Ali',          'Main Beach West Side, Kuakata',                       3.8,'assets/hotels/khan_jahan_kuakata.jpg'),
(4,'Hotel Sea World Patenga',       'Patenga Beach Road, Chattogram',                      3.9,'assets/hotels/sea_world_patenga.jpg'),
(4,'The Peninsula Chattogram',      'GEC Circle, Chattogram',                              4.5,'assets/hotels/peninsula.jpg'),
(4,'Chattogram Boat Club Resort',   'Patenga Road, Chattogram',                            4.2,'assets/hotels/boat_club.jpg'),
(5,'Sitakunda Guest House',         'Main Bazar Road, Sitakunda, Chattogram',              3.7,'assets/hotels/sitakunda_gh.jpg'),
(5,'Hotel Green Eye',               'By-pass Road, Sitakunda',                             3.6,'assets/hotels/green_eye.jpg'),
(5,'Guliakhali Eco Lodge',          'Guliakhali Beach Road, Sitakunda',                    3.9,'assets/hotels/guliakhali_eco.jpg'),
(6,'Nijhum Resort',                 'Forest Department Area, Nijhum Dwip',                 4.0,'assets/hotels/nijhum_resort.jpg'),
(6,'Hotel Island View',             'Bandartila Ghat, Nijhum Dwip',                        3.7,'assets/hotels/island_view.jpg'),
(6,'Sea Beach Eco Cottage',         'Namajpur Beach Road, Nijhum Dwip',                    3.8,'assets/hotels/nijhum_cottage.jpg'),
(7,'Grand Sultan Tea Resort & Golf','Radhanagar, Srimangal, Moulvibazar',                  4.9,'assets/hotels/grand_sultan.jpg'),
(7,'Lemon Garden Resort',           'Lawachara National Park Road, Srimangal',             4.4,'assets/hotels/lemon_garden.jpg'),
(7,'Balishira Resort',              'Radhanagar, Srimangal',                               4.5,'assets/hotels/balishira.jpg');

-- Places 8–14 (21 hotels)
INSERT INTO hotels (place_id, hotel_name, address, rating, image_path) VALUES
(8,'Jaflong Inn',                   'Tamabil Road, Jaflong, Sylhet',                       3.9,'assets/hotels/jaflong_inn.jpg'),
(8,'Green Valley Resort',           'Mama Dekho Mukh, Jaflong',                            4.1,'assets/hotels/green_valley.jpg'),
(8,'River View Guest House',        'Ghat Road, Jaflong',                                  3.7,'assets/hotels/river_view.jpg'),
(9,'Ratargul Eco Resort',           'Gowainghat, Near Swamp Forest, Sylhet',               4.2,'assets/hotels/ratargul_eco.jpg'),
(9,'Swamp View Cabins',             'Motor Ghat, Ratargul',                                4.0,'assets/hotels/swamp_view.jpg'),
(9,'Forest Lodge Sylhet',           'Khadimnagar (Near Ratargul Route)',                   4.1,'assets/hotels/forest_lodge.jpg'),
(10,'Haor Houseboat Premium',       'Tahirpur Ghat, Sunamganj',                            4.6,'assets/hotels/houseboat.jpg'),
(10,'Sunamganj Luxury Inn',         'Sadar Road, Sunamganj',                               3.9,'assets/hotels/sunamganj_inn.jpg'),
(10,'Tanguar Eco Camp',             'Tahandpur, Sunamganj',                                4.3,'assets/hotels/tanguar_camp.jpg'),
(11,'Madhabkunda Rest House',       'Parjatan Area, Barlekha, Moulvibazar',                3.8,'assets/hotels/madhabkunda_rh.jpg'),
(11,'Juri Valley Eco Lodge',        'Juri Road, Moulvibazar',                              4.0,'assets/hotels/juri_valley.jpg'),
(11,'Eco Falls Resort',             'Waterfall Road, Barlekha',                            3.9,'assets/hotels/eco_falls.jpg'),
(12,'Sairu Hill Resort',            'Chimbuk Road, Bandarban',                             4.8,'assets/hotels/sairu.jpg'),
(12,'Hotel Plaza Bandarban',        'Sadar Road, Bandarban',                               4.1,'assets/hotels/hotel_plaza.jpg'),
(12,'Green Peak Resort',            'Recha, Cantonment Road, Bandarban',                   4.4,'assets/hotels/green_peak.jpg'),
(13,'Hotel Sufia International',    'Kathaltoli, Rangamati',                               4.0,'assets/hotels/hotel_sufia.jpg'),
(13,'Parjatan Motel Rangamati',     'Hanging Bridge Road, Rangamati',                      4.2,'assets/hotels/parjatan_rangamati.jpg'),
(13,'Lake View Island Resort',      'Kaptai Lake, Rangamati',                              4.5,'assets/hotels/lake_view.jpg'),
(14,'Parjatan Motel Khagrachari',   'Chengi Square, Khagrachari',                          4.1,'assets/hotels/parjatan_khagrachari.jpg'),
(14,'Hotel Mount Diamond',          'Mahajan Para, Khagrachari',                           3.8,'assets/hotels/mount_diamond.jpg'),
(14,'Heritage Eco Resort',          'Alutila Road, Khagrachari',                           4.3,'assets/hotels/heritage_khagrachari.jpg');

-- Places 15–20 (18 hotels)
INSERT INTO hotels (place_id, hotel_name, address, rating, image_path) VALUES
(15,'Sundarban Tiger Roar Resort',  'Datta River Side, Shyamnagar, Satkhira',              4.4,'assets/hotels/tiger_roar.jpg'),
(15,'Pashur Parjatan Hotel',        'Mongla Port, Bagerhat (Sundarban Entry)',              4.0,'assets/hotels/pashur_mongla.jpg'),
(15,'Sundarban Eco Cottage',        'Karamjal Route, Khulna',                              4.2,'assets/hotels/sundarban_cottage.jpg'),
(16,'Hotel Shat Gombuj',            'Shat Gombuj Mosque Road, Bagerhat',                   3.9,'assets/hotels/shat_gombuj_hotel.jpg'),
(16,'Bagerhat Castle',              'Sadar Bypass Road, Bagerhat',                         4.0,'assets/hotels/bagerhat_castle.jpg'),
(16,'Khan Jahan Ali Guest House',   'Dargah Road, Bagerhat',                               3.7,'assets/hotels/khan_jahan_gh.jpg'),
(17,'Paharpur Archaeology Rest',    'Somapura Mahavihara Complex, Naogaon',                3.9,'assets/hotels/paharpur_rest.jpg'),
(17,'Hotel Naogaon Inn',            'Main Road, Naogaon Sadar',                            3.6,'assets/hotels/naogaon_inn.jpg'),
(17,'Vihara Lodge & Restaurant',    'Paharpur Bazar, Naogaon',                             3.8,'assets/hotels/vihara_lodge.jpg'),
(18,'Momo Inn Bogura',              'Nawwabganj Road, Bogura',                             4.7,'assets/hotels/momo_inn.jpg'),
(18,'Hotel Naz Garden',             'Silimpur, Bogura',                                    4.3,'assets/hotels/naz_garden.jpg'),
(18,'Bogura Parjatan Motel',        'Banani Mor, Bogura',                                  4.1,'assets/hotels/parjatan_bogura.jpg'),
(19,'Rajshahi Parjatan Motel',      'Abdul Hamid Road, Rajshahi',                          4.2,'assets/hotels/parjatan_rajshahi.jpg'),
(19,'Hotel Nice International',     'Ganakpara, Rajshahi',                                 3.9,'assets/hotels/hotel_nice.jpg'),
(19,'Puthia Royal Palace Hotel',    'Temple Road, Puthia, Rajshahi',                       3.7,'assets/hotels/puthia_royal.jpg'),
(20,'Hotel Grand River View',       'Lalon Shah River Road, Rajshahi',                     4.6,'assets/hotels/grand_river.jpg'),
(20,'Hotel Mukta International',    'Sheader Mor, Rajshahi',                               4.0,'assets/hotels/mukta_intl.jpg'),
(20,'Varendra Heritage Inn',        'Museum Road, Rajshahi',                               4.1,'assets/hotels/varendra_inn.jpg');

-- ============================================================
-- ROOM TYPES  (180 rows — 3 room types per hotel, 60 hotels)
-- Standard / Deluxe / Suite pricing calibrated to hotel rating
-- ============================================================

-- Helper: each INSERT block handles 10 hotels (30 rooms)

-- Hotels 1–10
INSERT INTO room_types (hotel_id, room_name, room_price, room_capacity, available_rooms, amenities) VALUES
(1,'Standard Sea View',    3500.00,2,8, 'Sea view, AC, WiFi, TV'),
(1,'Deluxe Pool Facing',   5500.00,2,5, 'Pool view, AC, WiFi, Mini-bar, TV'),
(1,'Premier Suite',        9500.00,3,3, 'Panoramic sea view, AC, Jacuzzi, WiFi, Mini-bar, Balcony'),
(2,'Standard Room',        3200.00,2,10,'AC, WiFi, TV, Room service'),
(2,'Deluxe Ocean View',    5200.00,2,6, 'Ocean view, AC, WiFi, TV, Mini-bar'),
(2,'Executive Suite',      8800.00,4,3, 'Suite, AC, WiFi, Bathtub, Balcony, Mini-bar'),
(3,'Standard Room',        2200.00,2,12,'AC, WiFi, TV'),
(3,'Superior Room',        3400.00,2,7, 'Garden view, AC, WiFi, TV'),
(3,'Deluxe Suite',         5800.00,3,3, 'Sea view, AC, WiFi, Sitting area, Mini-bar'),
(4,'Beach Cabin',          2800.00,2,6, 'Beach access, Fan, Solar power'),
(4,'Deluxe Cabin',         4200.00,2,4, 'Beach access, AC, Solar power, WiFi'),
(4,'Coral Suite',          7000.00,3,2, 'AC, WiFi, Balcony, Sea view, Generator backup'),
(5,'Standard Cottage',     2000.00,2,5, 'Fan, Solar power, Beach proximity'),
(5,'Deluxe Cottage',       3200.00,2,4, 'AC, WiFi, Solar power'),
(5,'Premium Cottage',      5000.00,3,2, 'AC, WiFi, Balcony, Sea view'),
(6,'Standard Cabin',       2400.00,2,4, 'Beach view, Fan, Solar power'),
(6,'Deluxe Cabin',         3800.00,2,3, 'AC, Generator backup, WiFi'),
(6,'Island Suite',         6200.00,4,2, 'AC, WiFi, Sunset view, Kitchenette'),
(7,'Standard Room',        1800.00,2,8, 'AC, WiFi, TV, Garden view'),
(7,'Deluxe Room',          2800.00,2,5, 'AC, WiFi, TV, Sea/canal view'),
(7,'Premium Suite',        4800.00,3,2, 'AC, WiFi, Large balcony, Canal view'),
(8,'Standard Room',        1600.00,2,8, 'AC, WiFi, TV'),
(8,'Deluxe Room',          2500.00,2,5, 'AC, WiFi, TV, Garden view'),
(8,'Premier Suite',        4500.00,3,2, 'AC, WiFi, Balcony, Mangrove view'),
(9,'Standard Room',        2800.00,2,10,'AC, WiFi, TV, Breakfast included'),
(9,'Deluxe Beach View',    4200.00,2,6, 'AC, WiFi, TV, Beach view, Breakfast'),
(9,'Honeymoon Suite',      7200.00,2,2, 'AC, WiFi, Balcony, Sea view, Jacuzzi, Breakfast'),
(10,'Standard Room',       2500.00,2,8, 'AC, WiFi, TV, City view'),
(10,'Deluxe Room',         3800.00,2,5, 'AC, WiFi, TV, Sea view'),
(10,'Executive Suite',     6500.00,3,2, 'AC, WiFi, Sitting lounge, Sea view, Bathtub');

-- Hotels 11–20
INSERT INTO room_types (hotel_id, room_name, room_price, room_capacity, available_rooms, amenities) VALUES
(11,'Standard Room',       1800.00,2,10,'AC, WiFi, TV'),
(11,'Deluxe Room',         2800.00,2,6, 'AC, WiFi, TV, Balcony'),
(11,'Family Suite',        4500.00,4,3, 'AC, WiFi, TV, Separate bedroom, Kitchen'),
(12,'Standard Room',       1500.00,2,10,'AC, WiFi, TV'),
(12,'Deluxe Room',         2300.00,2,6, 'AC, WiFi, TV, Garden view'),
(12,'Suite',               3800.00,4,3, 'AC, WiFi, TV, Large room, Sitting area'),
(13,'Standard Room',       1600.00,2,8, 'Fan, WiFi, TV'),
(13,'Deluxe Room',         2400.00,2,5, 'AC, WiFi, TV'),
(13,'Eco Suite',           3800.00,3,2, 'AC, WiFi, Nature view, Balcony'),
(14,'Standard Room',       1400.00,2,8, 'Fan, WiFi, TV'),
(14,'Deluxe Room',         2200.00,2,5, 'AC, WiFi, TV'),
(14,'Eco Cottage',         3500.00,3,3, 'AC, WiFi, Beach access, Private veranda'),
(15,'Standard Room',       1500.00,2,8, 'Fan, WiFi, TV'),
(15,'Deluxe Room',         2300.00,2,5, 'AC, WiFi, TV'),
(15,'Island Cottage',      3600.00,4,3, 'AC, WiFi, Island view, Hammock, Veranda'),
(16,'Standard Room',       1400.00,2,6, 'Fan, WiFi'),
(16,'Deluxe Room',         2100.00,2,4, 'AC, WiFi, TV'),
(16,'Forest View Suite',   3500.00,3,2, 'AC, WiFi, Forest panorama, Balcony'),
(17,'Standard Room',       1200.00,2,8, 'Fan, WiFi'),
(17,'Deluxe Room',         1900.00,2,5, 'AC, WiFi, TV'),
(17,'Tea Garden Suite',    3200.00,4,3, 'AC, WiFi, Tea garden view, Balcony, Mini-bar'),
(18,'Standard Room',       1300.00,2,8, 'AC, WiFi, TV'),
(18,'Deluxe Room',         2000.00,2,5, 'AC, WiFi, TV, Mountain view'),
(18,'Premier Chalet',      3500.00,3,3, 'AC, WiFi, Mountain panorama, Fireplace'),
(19,'Standard Room',       1400.00,2,8, 'Fan, WiFi'),
(19,'Deluxe Room',         2200.00,2,5, 'AC, WiFi, TV'),
(19,'Lake View Suite',     3800.00,4,3, 'AC, WiFi, Kaptai Lake view, Balcony'),
(20,'Standard Room',       1300.00,2,8, 'Fan, WiFi, TV'),
(20,'Deluxe Room',         2000.00,2,5, 'AC, WiFi, TV'),
(20,'Tribal Heritage Suite',3400.00,3,3,'AC, WiFi, Hill view, Ethnic decor, Balcony');

-- Hotels 21–30
INSERT INTO room_types (hotel_id, room_name, room_price, room_capacity, available_rooms, amenities) VALUES
(21,'Standard Room',       1500.00,2,8, 'AC, WiFi, TV'),
(21,'Deluxe Room',         2300.00,2,5, 'AC, WiFi, TV, Hill view'),
(21,'Cave View Suite',     3800.00,3,3, 'AC, WiFi, Alutila hill view, Balcony'),
(22,'Standard Room',       1300.00,2,8, 'Fan, WiFi'),
(22,'Deluxe Room',         2000.00,2,5, 'AC, WiFi, TV'),
(22,'Hill Suite',          3300.00,4,2, 'AC, WiFi, Valley panorama, Balcony'),
(23,'Standard Room',       1400.00,2,8, 'Fan, WiFi, TV'),
(23,'Deluxe Room',         2100.00,2,5, 'AC, WiFi, TV'),
(23,'Eco Heritage Suite',  3500.00,3,3, 'AC, WiFi, Forest view, Tribal motifs'),
(24,'Forest Tent',         2800.00,2,5, 'Fan, Solar power, Jungle proximity'),
(24,'Standard Cottage',    4200.00,2,4, 'AC, WiFi, Forest view, Balcony'),
(24,'Tiger Trail Suite',   7500.00,3,2, 'AC, WiFi, Sundarban view, Binoculars, Guide incl.'),
(25,'Standard Room',       1800.00,2,8, 'AC, WiFi, TV'),
(25,'Deluxe Room',         2800.00,2,5, 'AC, WiFi, TV, River view'),
(25,'Mangrove Suite',      4800.00,3,2, 'AC, WiFi, Sundarban panorama, Balcony'),
(26,'Standard Room',       1600.00,2,8, 'AC, WiFi, TV'),
(26,'Deluxe Room',         2400.00,2,5, 'AC, WiFi, TV, Mangrove view'),
(26,'Heritage Suite',      4000.00,3,2, 'AC, WiFi, Forest view, Kayak access'),
(27,'Standard Room',       1300.00,2,8, 'Fan, WiFi'),
(27,'Deluxe Room',         2000.00,2,5, 'AC, WiFi, TV'),
(27,'Mosque View Suite',   3300.00,3,2, 'AC, WiFi, Sixty Dome view, Heritage tour incl.'),
(28,'Standard Room',       1200.00,2,8, 'Fan, WiFi, TV'),
(28,'Deluxe Room',         1800.00,2,5, 'AC, WiFi, TV'),
(28,'Heritage Suite',      3000.00,4,2, 'AC, WiFi, Garden view, Heritage tour incl.'),
(29,'Standard Room',       1100.00,2,8, 'Fan, WiFi'),
(29,'Deluxe Room',         1700.00,2,5, 'AC, WiFi, TV'),
(29,'Vihara Suite',        2800.00,4,2, 'AC, WiFi, Archaeological site view');

-- Hotels 30–40
INSERT INTO room_types (hotel_id, room_name, room_price, room_capacity, available_rooms, amenities) VALUES
(30,'Standard Room',       1400.00,2,8, 'Fan, WiFi'),
(30,'Deluxe Room',         2100.00,2,5, 'AC, WiFi, TV'),
(30,'Archaeological Suite',3600.00,3,2, 'AC, WiFi, Site view, Museum pass incl.'),
(31,'Standard Room',       1200.00,2,8, 'Fan, WiFi'),
(31,'Deluxe Room',         1800.00,2,5, 'AC, WiFi, TV'),
(31,'Heritage Suite',      3000.00,4,2, 'AC, WiFi, Terracotta exhibits, Garden view'),
(32,'Standard Room',       2500.00,2,8, 'AC, WiFi, TV, Breakfast included'),
(32,'Deluxe Room',         3800.00,2,5, 'AC, WiFi, TV, Breakfast + Dinner, Bogura specialty'),
(32,'Royal Suite',         6500.00,3,2, 'AC, WiFi, Panoramic view, Full board, Bathtub'),
(33,'Standard Room',       1600.00,2,8, 'AC, WiFi, TV'),
(33,'Deluxe Room',         2400.00,2,5, 'AC, WiFi, TV, Mahasthangarh view'),
(33,'Archaeology Suite',   4200.00,3,2, 'AC, WiFi, Mural art, Balcony, Guided tour incl.'),
(34,'Standard Room',       1400.00,2,8, 'Fan, WiFi, TV'),
(34,'Deluxe Room',         2200.00,2,5, 'AC, WiFi, TV'),
(34,'Heritage Suite',      3600.00,3,2, 'AC, WiFi, Temple view, Cultural tour incl.'),
(35,'Standard Room',       1200.00,2,8, 'Fan, WiFi'),
(35,'Deluxe Room',         1900.00,2,5, 'AC, WiFi, TV'),
(35,'Museum Suite',        3200.00,4,2, 'AC, WiFi, Padma River view, Museum ticket incl.'),
(36,'Standard Room',       2200.00,2,8, 'AC, WiFi, TV, Padma view'),
(36,'Deluxe Room',         3400.00,2,5, 'AC, WiFi, TV, Padma River view, Breakfast'),
(36,'Presidential Suite',  7000.00,4,2, 'AC, WiFi, Full board, Padma view, Jacuzzi, Lounge');

-- Hotels 41–50
INSERT INTO room_types (hotel_id, room_name, room_price, room_capacity, available_rooms, amenities) VALUES
(37,'Standard Room',       1600.00,2,8, 'AC, WiFi, TV'),
(37,'Deluxe Room',         2500.00,2,5, 'AC, WiFi, TV, Museum proximity'),
(37,'Heritage Suite',      4000.00,3,2, 'AC, WiFi, Museum view, Breakfast, Cultural tour'),
(38,'Standard Room',       1300.00,2,8, 'Fan, WiFi'),
(38,'Deluxe Room',         2000.00,2,5, 'AC, WiFi, TV'),
(38,'Varendra Suite',      3300.00,4,2, 'AC, WiFi, Museum corridor view, Artifact replica decor'),
(39,'Standard Room',       3000.00,2,8, 'AC, WiFi, TV, Breakfast'),
(39,'Deluxe Hill View',    4800.00,2,5, 'AC, WiFi, TV, Hill panorama, Breakfast + Dinner'),
(39,'Premium Villa',       8500.00,3,2, 'Private villa, AC, WiFi, Infinity pool view, Full board'),
(40,'Standard Room',       2200.00,2,8, 'AC, WiFi, TV'),
(40,'Deluxe Room',         3400.00,2,5, 'AC, WiFi, TV, Mountain view'),
(40,'Summit Suite',        5800.00,3,2, 'AC, WiFi, 360° mountain view, Balcony, Telescope'),
(41,'Standard Room',       2400.00,2,8, 'AC, WiFi, TV'),
(41,'Deluxe Room',         3800.00,2,5, 'AC, WiFi, TV, Hill view'),
(41,'Panorama Suite',      6200.00,3,2, 'AC, WiFi, Full hill panorama, Balcony, Breakfast'),
(42,'Standard Room',       1800.00,2,8, 'AC, WiFi, TV'),
(42,'Deluxe Lake View',    2800.00,2,5, 'AC, WiFi, TV, Kaptai Lake view'),
(42,'Lake Suite',          4800.00,3,2, 'AC, WiFi, Lake panorama, Balcony, Kayak access'),
(43,'Standard Room',       2000.00,2,8, 'AC, WiFi, TV'),
(43,'Deluxe Lake View',    3200.00,2,5, 'AC, WiFi, TV, Kaptai Lake view, Breakfast'),
(43,'Honeymoon Suite',     5500.00,2,2, 'AC, WiFi, Private lake view, Jacuzzi, Breakfast + Dinner');

-- Hotels 51–60
INSERT INTO room_types (hotel_id, room_name, room_price, room_capacity, available_rooms, amenities) VALUES
(44,'Standard Room',       1700.00,2,8, 'AC, WiFi, TV'),
(44,'Deluxe Room',         2600.00,2,5, 'AC, WiFi, TV, Hill view'),
(44,'Valley Suite',        4200.00,3,3, 'AC, WiFi, Valley panorama, Balcony, Guided cave tour'),
(45,'Standard Room',       1500.00,2,8, 'Fan, WiFi, TV'),
(45,'Deluxe Room',         2300.00,2,5, 'AC, WiFi, TV'),
(45,'Cave View Suite',     3700.00,3,2, 'AC, WiFi, Hill view, Alutila cave guide incl.'),
(46,'Standard Room',       1600.00,2,8, 'Fan, WiFi, TV'),
(46,'Deluxe Room',         2500.00,2,5, 'AC, WiFi, TV, Hill view'),
(46,'Eco Suite',           4000.00,4,3, 'AC, WiFi, Tribal art, Nature veranda'),
(47,'Standard Room',       1800.00,2,8, 'AC, WiFi, TV'),
(47,'Deluxe Room',         2800.00,2,5, 'AC, WiFi, TV, Tea garden view'),
(47,'Tea Planter Suite',   5000.00,3,3, 'AC, WiFi, Tea estate panorama, Balcony, Golf access'),
(48,'Standard Room',       1600.00,2,8, 'AC, WiFi, TV'),
(48,'Deluxe Room',         2500.00,2,5, 'AC, WiFi, TV, Forest view'),
(48,'Nature Suite',        4200.00,3,3, 'AC, WiFi, Lawachara forest view, Bird watching deck'),
(49,'Standard Room',       1700.00,2,8, 'AC, WiFi, TV'),
(49,'Deluxe Room',         2600.00,2,5, 'AC, WiFi, TV, Tea garden view'),
(49,'Balishira Suite',     4500.00,3,3, 'AC, WiFi, Tea estate view, Balcony, Cycle tour'),
(50,'Standard Room',       1500.00,2,8, 'Fan, WiFi, TV'),
(50,'Deluxe River View',   2400.00,2,5, 'AC, WiFi, TV, River view'),
(50,'Boulder Suite',       4000.00,3,3, 'AC, WiFi, River & hill view, Balcony, Stone tour');

-- ============================================================
-- End of 03_seed_hotels.sql
-- ============================================================
