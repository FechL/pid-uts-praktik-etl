-- Sample Database untuk Testing SQL Queries (Soal 3)
-- Execute script ini untuk membuat database testing

CREATE DATABASE uts_fleet_test;
USE uts_fleet_test;

-- Tabel untuk historical sensor readings
CREATE TABLE sensor_readings_hist (
    id INT PRIMARY KEY AUTO_INCREMENT,
    truck_id VARCHAR(20),
    sensor_id VARCHAR(20), 
    temperature DECIMAL(5,2),
    humidity DECIMAL(5,2),
    recorded_at DATETIME,
    location_lat DECIMAL(10,8),
    location_lng DECIMAL(11,8),
    engine_rpm INT,
    fuel_level DECIMAL(4,1),
    INDEX idx_truck_time (truck_id, recorded_at),
    INDEX idx_sensor_time (sensor_id, recorded_at),
    INDEX idx_recorded_at (recorded_at)
);

-- Sample data insertion (representasi 10,000 records)
INSERT INTO sensor_readings_hist (truck_id, sensor_id, temperature, humidity, recorded_at, location_lat, location_lng, engine_rpm, fuel_level) VALUES
('TRK001', 'SENS001', 25.5, 65.2, '2024-09-15 08:00:00', -6.2088, 106.8456, 1500, 75.5),
('TRK001', 'SENS001', 26.2, 66.1, '2024-09-15 08:15:00', -6.2090, 106.8460, 1520, 75.3),
('TRK001', 'SENS001', 27.8, 67.5, '2024-09-15 08:30:00', -6.2095, 106.8465, 1480, 75.1),
('TRK001', 'SENS001', 45.2, 68.2, '2024-09-15 09:30:00', -6.2100, 106.8470, 1600, 74.8), -- Anomali temperature swing
('TRK002', 'SENS002', 22.1, 70.3, '2024-09-15 08:00:00', -6.1751, 106.8650, 1400, 80.2),
('TRK002', 'SENS002', 23.5, 71.8, '2024-09-15 08:15:00', -6.1755, 106.8655, 1420, 80.0),
('TRK002', 'SENS002', 24.0, 72.1, '2024-09-15 08:30:00', -6.1760, 106.8660, 1380, 79.8),
('TRK003', 'SENS003', 29.3, 74.5, '2024-09-15 08:00:00', -6.1950, 106.8720, 1650, 65.5),
('TRK003', 'SENS003', 30.1, 75.2, '2024-09-15 08:15:00', -6.1948, 106.8725, 1680, 65.2),
('TRK003', 'SENS003', 48.7, 76.8, '2024-09-15 09:15:00', -6.1945, 106.8730, 1720, 64.8), -- Anomali temperature swing
('TRK004', 'SENS004', 23.7, 64.2, '2024-09-15 08:00:00', -6.2180, 106.8420, 1350, 85.0),
('TRK004', 'SENS004', 24.8, 65.1, '2024-09-15 08:15:00', -6.2185, 106.8425, 1380, 84.8),
('TRK005', 'SENS005', 27.0, 69.4, '2024-09-15 08:00:00', -6.1850, 106.8580, 1550, 70.3),
('TRK005', 'SENS005', 28.2, 70.7, '2024-09-15 08:15:00', -6.1855, 106.8585, 1570, 70.1),
-- Data untuk hari-hari sebelumnya (pattern similar dengan variasi timestamp)
('TRK001', 'SENS001', 24.8, 64.8, '2024-09-14 08:00:00', -6.2088, 106.8456, 1490, 76.2),
('TRK001', 'SENS001', 25.3, 65.4, '2024-09-14 08:15:00', -6.2090, 106.8460, 1510, 76.0),
('TRK002', 'SENS002', 21.9, 69.8, '2024-09-14 08:00:00', -6.1751, 106.8650, 1390, 81.0),
('TRK002', 'SENS002', 22.7, 70.5, '2024-09-14 08:15:00', -6.1755, 106.8655, 1410, 80.8),
('TRK003', 'SENS003', 28.9, 73.2, '2024-09-14 08:00:00', -6.1950, 106.8720, 1630, 66.2),
('TRK003', 'SENS003', 29.6, 74.1, '2024-09-14 08:15:00', -6.1948, 106.8725, 1660, 66.0),
-- More historical data pattern
('TRK006', 'SENS006', 26.5, 67.1, '2024-09-13 08:00:00', -6.2350, 106.8200, 1460, 78.5),
('TRK007', 'SENS007', 28.1, 68.9, '2024-09-13 08:00:00', -6.1680, 106.8750, 1520, 72.3),
('TRK008', 'SENS008', 25.2, 63.4, '2024-09-13 08:00:00', -6.2450, 106.8150, 1380, 82.1),
('TRK009', 'SENS009', 29.8, 71.6, '2024-09-13 08:00:00', -6.1580, 106.8850, 1590, 68.7),
('TRK010', 'SENS010', 27.3, 66.8, '2024-09-13 08:00:00', -6.2280, 106.8320, 1470, 74.9);

-- Procedure untuk generate lebih banyak test data (simulasi 10K records)
DELIMITER //
CREATE PROCEDURE GenerateTestData()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE truck_num INT;
    DECLARE sensor_num INT;
    DECLARE base_date DATE DEFAULT '2024-09-01';
    DECLARE current_datetime DATETIME;
    DECLARE temp_base DECIMAL(5,2);
    DECLARE humidity_base DECIMAL(5,2);
    
    WHILE i < 9000 DO
        SET truck_num = (i % 10) + 1;
        SET sensor_num = truck_num;
        SET current_datetime = DATE_ADD(base_date, INTERVAL FLOOR(i/10) HOUR);
        SET temp_base = 20 + (RAND() * 15);  -- Random temp 20-35°C
        SET humidity_base = 60 + (RAND() * 20); -- Random humidity 60-80%
        
        -- Occasional anomalies (5% chance untuk temperature swing)
        IF RAND() < 0.05 THEN
            SET temp_base = temp_base + (20 + RAND() * 25); -- Anomali +20-45°C
        END IF;
        
        INSERT INTO sensor_readings_hist (
            truck_id, sensor_id, temperature, humidity, recorded_at, 
            location_lat, location_lng, engine_rpm, fuel_level
        ) VALUES (
            CONCAT('TRK', LPAD(truck_num, 3, '0')),
            CONCAT('SENS', LPAD(sensor_num, 3, '0')),
            temp_base,
            humidity_base,
            current_datetime,
            -6.2 + (RAND() * 0.3), -- Random lat around Jakarta
            106.8 + (RAND() * 0.2), -- Random lng around Jakarta  
            1300 + FLOOR(RAND() * 500), -- Random RPM 1300-1800
            50 + (RAND() * 40) -- Random fuel 50-90%
        );
        
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

-- Execute procedure untuk generate test data
-- CALL GenerateTestData();

-- Verification queries untuk mahasiswa
SELECT COUNT(*) as total_records FROM sensor_readings_hist;
SELECT truck_id, COUNT(*) as reading_count FROM sensor_readings_hist GROUP BY truck_id;
SELECT DATE(recorded_at) as date, COUNT(*) as daily_count FROM sensor_readings_hist GROUP BY DATE(recorded_at) ORDER BY date;

-- Sample query untuk testing anomaly detection
SELECT 
    truck_id,
    sensor_id,
    temperature,
    recorded_at,
    LAG(temperature) OVER (PARTITION BY sensor_id ORDER BY recorded_at) as prev_temp,
    ABS(temperature - LAG(temperature) OVER (PARTITION BY sensor_id ORDER BY recorded_at)) as temp_diff
FROM sensor_readings_hist 
WHERE truck_id IN ('TRK001', 'TRK003')
ORDER BY sensor_id, recorded_at;