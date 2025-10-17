// Kelompok 6:
// - Fawwas Aliy 235150300111009
// - Briliiant Akhmad Assiddiqqy 235150301111045
// - Andan Riski Mustari 235150301111002

// 1. Contoh struktur dokumen sensor_readings
db.sensor_readings.insertMany([
    {
        "sensor_id": "SENS001",
        "truck_id": "TRK001",
        "timestamp": ISODate("2024-10-13T08:00:00Z"),
        "readings": {
            "temperature": 25.5,
            "humidity": 67.2
        }
    },
    {
        "sensor_id": "SENS002",
        "truck_id": "TRK001",
        "timestamp": ISODate("2024-10-13T08:15:00Z"),
        "readings": {
            "temperature": 26.0,
            "humidity": 68.1
        }
    },
    {
        "sensor_id": "SENS003",
        "truck_id": "TRK002",
        "timestamp": ISODate("2024-10-13T08:00:00Z"),
        "readings": {
            "temperature": 27.4,
            "humidity": 64.5
        }
    },
    {
        "sensor_id": "SENS004",
        "truck_id": "TRK003",
        "timestamp": ISODate("2024-10-13T08:10:00Z"),
        "readings": {
            "temperature": 23.8,
            "humidity": 70.2
        }
    },
    {
        "sensor_id": "SENS005",
        "truck_id": "TRK002",
        "timestamp": ISODate("2024-10-13T08:20:00Z"),
        "readings": {
            "temperature": 28.5,
            "humidity": 62.0
        }
    }
]);

// 2. Query untuk menampilkan semua readings dari truck tertentu (misal TRK001)
db.sensor_readings.find({ truck_id: "TRK001" });

// 3. (Opsional) Query untuk menampilkan sensor dengan suhu di atas 26°C
db.sensor_readings.find({ "readings.temperature": { $gt: 26 } });