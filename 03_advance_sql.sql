-- Kelompok 6:
-- - Fawwas Aliy 235150300111009
-- - Briliiant Akhmad Assiddiqqy 235150301111045
-- - Andan Riski Mustari 235150301111002

WITH temperature_analysis AS (
  SELECT 
    sensor_id,
    temperature,
    recorded_at,
    LAG(temperature) OVER (
      PARTITION BY sensor_id 
      ORDER BY recorded_at
    ) AS prev_temp
  FROM sensor_readings_hist
),
anomalies AS (
  SELECT 
    sensor_id,
    temperature AS current_temp,
    prev_temp,
    ABS(temperature - prev_temp) AS temp_diff,
    CASE
      WHEN ABS(temperature - prev_temp) > 15 THEN 'HIGH'
      WHEN ABS(temperature - prev_temp) > 10 THEN 'MEDIUM'
      ELSE 'LOW'
    END AS anomaly_level
  FROM temperature_analysis
  WHERE prev_temp IS NOT NULL
)
SELECT * 
FROM anomalies
WHERE temp_diff > 10
ORDER BY temp_diff DESC;