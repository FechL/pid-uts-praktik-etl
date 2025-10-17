# Ujian Tengah Semester (UTS) – Arsitektur Sistem Data & Manajemen Informasi

**Waktu Pengerjaan:** 100 menit  
**Total Poin:** 100  
**Petunjuk Umum:**
Ujian ini berbentuk **PRAKTIK CODING** dengan studi kasus sederhana. Mahasiswa harus menyelesaikan masalah menggunakan **kode aktual** (SQL, Python, NoSQL queries). Setiap soal menyediakan dataset yang harus dimanipulasi. Jawaban harus berupa **working code**.

**Requirements:**
- Code harus dapat dijalankan (syntax correct)
- Sertakan komentar pada bagian kode penting
- Focus pada implementasi, bukan teori

---

## Soal 1 – Batch Processing Pipeline dengan Python
**(20 Poin | 15 menit)**

**Dataset Disediakan: `sensor_data_raw.csv` (100 records)**
```csv
truck_id,sensor_id,timestamp,temperature,humidity,gps_lat,gps_lng
TRK001,SENS001,2024-10-13 08:00:00,25.5,65.5,-6.2088,106.8456
TRK001,SENS001,2024-10-13 08:15:00,26.2,67.2,-6.2088,106.8456
TRK002,SENS002,2024-10-13 08:00:00,,70.1,-6.1751,106.8650
```

**Tugas Coding:**
1. **Data Cleaning:** Handle missing temperature values (gunakan median)
2. **Aggregation:** Hitung average temperature dan max humidity per truck
3. **Save Output:** Simpan hasil ke CSV

**Code Template:**
```python
import pandas as pd

def clean_sensor_data(df):
    # Fill missing temperature dengan median
    # Return cleaned DataFrame
    pass

def calculate_aggregates(df):
    # Group by truck_id dan calculate avg temp, max humidity
    # Return aggregated DataFrame
    pass

# Test dengan data
df = pd.read_csv('sensor_data_raw.csv')
cleaned_df = clean_sensor_data(df)
result_df = calculate_aggregates(cleaned_df)
result_df.to_csv('aggregated_results.csv', index=False)
```

---

## Soal 2 – Database Implementation (MySQL + MongoDB)
**(25 Poin | 20 menit)**

**Skenario:** Sistem sederhana untuk sensor data.

### **Bagian A: MySQL Implementation (15 poin)**
**Tugas:**
1. **Create Tables:** Buat 2 tabel dengan relasi
2. **Insert Data:** Masukkan sample data
3. **Query:** Buat 1 JOIN query

```sql
-- Template DDL
CREATE TABLE trucks (
    truck_id VARCHAR(10) PRIMARY KEY,
    model VARCHAR(50),
    year INT
);

CREATE TABLE sensors (
    sensor_id VARCHAR(10) PRIMARY KEY,
    truck_id VARCHAR(10),
    sensor_type VARCHAR(20),
    FOREIGN KEY (truck_id) REFERENCES trucks(truck_id)
);

-- TODO: Insert minimal 3 trucks dan 5 sensors
-- TODO: Query untuk show all sensors dengan truck info
```

### **Bagian B: MongoDB Document Design (10 poin)**
**Tugas:** Design document structure untuk sensor readings

```javascript
// Template document
{
  "sensor_id": "SENS001",
  "truck_id": "TRK001",
  "timestamp": ISODate(),
  "readings": {
    "temperature": 25.5,
    "humidity": 67.2
  }
}

// TODO: Complete the document design
// TODO: Write MongoDB query untuk find all readings dari truck tertentu
```

---

## Soal 3 – Advanced SQL dengan Window Functions
**(20 Poin | 15 menit)**

**Dataset:** Tabel `sensor_readings` sudah tersedia dengan sample data.

**Tugas:** Buat query untuk detect temperature anomalies menggunakan LAG() function.

**Template Query:**
```sql
-- Challenge: Find sensors dengan temperature swing >10°C 
-- antara reading sekarang dan reading sebelumnya

WITH temperature_analysis AS (
  SELECT 
    sensor_id,
    temperature,
    recorded_at,
    LAG(temperature) OVER (
      PARTITION BY sensor_id 
      ORDER BY recorded_at
    ) as prev_temperature
  FROM sensor_readings
),
anomalies AS (
  -- TODO: Calculate temperature difference
  -- TODO: Filter where difference > 10
  -- TODO: Classify as 'HIGH', 'MEDIUM', 'LOW' anomaly
)
SELECT * FROM anomalies 
ORDER BY temperature_diff DESC;
```

**Expected Output:**
- sensor_id, current_temp, prev_temp, temp_diff, anomaly_level
- Sorted by highest temperature difference

---

## Soal 4 – Simple ETL Pipeline
**(20 Poin | 25 menit)**

**Skenario:** Extract data dari JSON, transform, dan load ke CSV.

**Input File: `sensors.json`**
```json
[
  {
    "sensor_id": "SENS001",
    "truck_id": "TRK001",
    "readings": [
      {"timestamp": "2024-10-13T08:00:00Z", "temp": 25.5, "humidity": 65}
    ]
  }
]
```

**Tugas:**
1. **Extract:** Read JSON dan flatten nested structure
2. **Transform:** Convert temperature to Fahrenheit, add comfort_index
3. **Load:** Save to CSV format

**Code Template:**
```python
import pandas as pd
import json

def extract_json_data(file_path):
    """Extract dan flatten JSON data"""
    # TODO: Read JSON file
    # TODO: Flatten nested readings array
    # TODO: Return DataFrame
    pass

def transform_data(df):
    """Apply transformations"""
    # TODO: Convert temp to Fahrenheit: F = C * 9/5 + 32
    # TODO: Calculate comfort_index = temp / humidity * 100
    # TODO: Return transformed DataFrame
    pass

def load_to_csv(df, output_path):
    """Save to CSV"""
    # TODO: Save DataFrame to CSV
    pass

# Execute ETL pipeline
raw_data = extract_json_data('sensors.json')
transformed_data = transform_data(raw_data)
load_to_csv(transformed_data, 'etl_output.csv')
```

---

## Soal 5 – Data Quality Validation
**(15 Poin | 25 menit)**

**Skenario:** Implementasi basic data quality checker.

**Sample Problematic Data:**
```python
import pandas as pd

# Test data dengan quality issues
test_data = pd.DataFrame([
    {"sensor_id": "SENS001", "truck_id": "TRK001", "temp": -999, "humidity": 120},  # Invalid values
    {"sensor_id": "SENS002", "truck_id": "", "temp": 25.5, "humidity": None},       # Missing values  
    {"sensor_id": "SENS001", "truck_id": "TRK001", "temp": 25.5, "humidity": 65},   # Duplicate
    {"sensor_id": "SENS001", "truck_id": "TRK001", "temp": 25.5, "humidity": 65}    # Duplicate
])
```

**Tugas:** Implementasikan data quality checker

```python
class DataQualityChecker:
    def __init__(self):
        self.violations = []
    
    def check_missing_values(self, df, required_columns):
        """Check for missing values"""
        # TODO: Count missing values in required columns
        # TODO: Add violations to self.violations list
        pass
    
    def check_value_ranges(self, df):
        """Check if values are in valid ranges"""
        # TODO: Check temperature: -40 to 80
        # TODO: Check humidity: 0 to 100
        # TODO: Add violations to self.violations list
        pass
    
    def check_duplicates(self, df, key_columns):
        """Check for duplicate records"""
        # TODO: Find duplicate rows based on key_columns
        # TODO: Add violations to self.violations list
        pass
    
    def generate_report(self):
        """Generate quality report"""
        # TODO: Return summary of all violations
        pass

# Test the checker
checker = DataQualityChecker()
checker.check_missing_values(test_data, ['sensor_id', 'truck_id'])
checker.check_value_ranges(test_data)
checker.check_duplicates(test_data, ['sensor_id', 'truck_id'])
report = checker.generate_report()
print(report)
```

---

## Alokasi Waktu:

| Soal | Topik | Waktu | Poin |
|:---|:---|:---|:---|
| 1 | Batch Processing (Python) | 15 menit | 20 |
| 2 | Database Implementation | 20 menit | 25 |
| 3 | Advanced SQL | 15 menit | 20 |
| 4 | ETL Pipeline | 25 menit | 20 |
| 5 | Data Quality | 25 menit | 15 |
| **Total** | | **100 menit** | **100** |

---

## Kriteria Penilaian:

| Aspek | Bobot | Fokus |
|:---|:---|:---|
| **Code Syntax & Logic** | 60% | Code dapat dijalankan, logic benar, dalam bentuk IPYNB |
| **Implementation** | 30% | Kelengkapan implementasi sesuai requirements |
| **Code Quality** | 10% | Clean code, comments yang berguna |

### Grading:
- **A (85-100):** Code lengkap dan berfungsi sempurna
- **B (70-84):** Code sebagian besar benar dengan minor issues
- **C (55-69):** Code dasar benar tapi kurang complete
- **D (40-54):** Code ada tapi banyak errors
- **E (<40):** Code tidak berfungsi atau tidak ada