USE onereserve;
SELECT 'Places' AS 'Table', COUNT(*) AS Count FROM places
UNION ALL
SELECT 'Districts', COUNT(*) FROM districts
UNION ALL
SELECT 'Schedules', COUNT(*) FROM schedules
UNION ALL
SELECT 'Buses', COUNT(*) FROM buses
UNION ALL
SELECT 'Bus Companies', COUNT(*) FROM bus_companies;
