-- Kelompok 6:
-- - Fawwas Aliy 235150300111009
-- - Briliiant Akhmad Assiddiqqy 235150301111045
-- - Andan Riski Mustari 235150301111002

-- 1. Membuat tabel trucks
CREATE TABLE IF NOT EXISTS trucks (
    truck_id VARCHAR(10) PRIMARY KEY,
    model VARCHAR(50),
    year INT
);

-- 2. Membuat tabel sensors dengan relasi ke trucks
CREATE TABLE IF NOT EXISTS sensors (
    sensor_id VARCHAR(10) PRIMARY KEY,
    truck_id VARCHAR(10),
    sensor_type VARCHAR(20),
    FOREIGN KEY (truck_id) REFERENCES trucks(truck_id)
);

-- 3. Insert sample data (3 trucks, 5 sensors)
INSERT INTO trucks (truck_id, model, year) VALUES
('TRK001', 'Isuzu NQR', 2019),
('TRK002', 'Hino 300', 2020),
('TRK003', 'Mitsubishi Fuso', 2018);

INSERT INTO sensors (sensor_id, truck_id, sensor_type) VALUES
('SENS001', 'TRK001', 'temperature'),
('SENS002', 'TRK001', 'humidity'),
('SENS003', 'TRK002', 'temperature'),
('SENS004', 'TRK003', 'gps'),
('SENS005', 'TRK002', 'pressure');

-- 4. Query untuk menampilkan semua sensors dengan informasi truck
SELECT
  s.sensor_id,
  s.sensor_type,
  t.truck_id,
  t.model,
  t.year
FROM sensors s
JOIN trucks t ON s.truck_id = t.truck_id
ORDER BY t.truck_id, s.sensor_id;