-- ============================================================
-- Divvy Bike Share Analysis 2019
-- Script 03: Create Clean Master Table
-- Author: Emmanuel Baah Gyan
-- ============================================================

-- Combine all four quarters, remove outliers, engineer new columns
SELECT
    trip_id,
    start_time,
    end_time,
    bikeid,
    tripduration,
    CAST(tripduration / 60.0 AS DECIMAL(10,2))       AS ride_length_mins,
    CONVERT(VARCHAR(8), DATEADD(SECOND, tripduration, 0), 108) AS ride_length_hms,
    from_station_id,
    from_station_name,
    to_station_id,
    to_station_name,
    usertype,
    gender,
    birthyear,
    CASE WHEN birthyear IS NOT NULL THEN 2019 - birthyear ELSE NULL END AS age,
    DATENAME(WEEKDAY, start_time)   AS day_of_week,
    DATENAME(MONTH, start_time)     AS month_name,
    DATEPART(HOUR, start_time)      AS hour_of_day,
    DATEPART(QUARTER, start_time)   AS quarter
INTO all_trips_clean
FROM (
    SELECT * FROM trips_2019_Q1
    UNION ALL
    SELECT * FROM trips_2019_Q2
    UNION ALL
    SELECT * FROM trips_2019_Q3
    UNION ALL
    SELECT * FROM trips_2019_Q4
) AS combined
WHERE tripduration >= 60
  AND tripduration <= 10800;
-- Result: 3,803,858 rows (removed 14,146 outlier rides)

-- Verify
SELECT COUNT(*) AS total_clean_rows FROM all_trips_clean;
SELECT TOP 5 * FROM all_trips_clean;
