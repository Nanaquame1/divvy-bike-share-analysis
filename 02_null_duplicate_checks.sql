-- ============================================================
-- Divvy Bike Share Analysis 2019
-- Script 02: NULL and Duplicate Checks
-- Author: Emmanuel Baah Gyan
-- ============================================================

-- Standardise Q2 column names to match Q1, Q3, Q4
EXEC sp_rename 'trips_2019_Q2._01_Rental_Details_Rental_ID',                   'trip_id',           'COLUMN';
EXEC sp_rename 'trips_2019_Q2._01_Rental_Details_Local_Start_Time',             'start_time',        'COLUMN';
EXEC sp_rename 'trips_2019_Q2._01_Rental_Details_Local_End_Time',               'end_time',          'COLUMN';
EXEC sp_rename 'trips_2019_Q2._01_Rental_Details_Bike_ID',                      'bikeid',            'COLUMN';
EXEC sp_rename 'trips_2019_Q2._01_Rental_Details_Duration_In_Seconds_Uncapped', 'tripduration',      'COLUMN';
EXEC sp_rename 'trips_2019_Q2._03_Rental_Start_Station_ID',                     'from_station_id',   'COLUMN';
EXEC sp_rename 'trips_2019_Q2._03_Rental_Start_Station_Name',                   'from_station_name', 'COLUMN';
EXEC sp_rename 'trips_2019_Q2._02_Rental_End_Station_ID',                       'to_station_id',     'COLUMN';
EXEC sp_rename 'trips_2019_Q2._02_Rental_End_Station_Name',                     'to_station_name',   'COLUMN';
EXEC sp_rename 'trips_2019_Q2.User_Type',                                        'usertype',          'COLUMN';
EXEC sp_rename 'trips_2019_Q2.Member_Gender',                                    'gender',            'COLUMN';
EXEC sp_rename 'trips_2019_Q2._05_Member_Details_Member_Birthday_Year',          'birthyear',         'COLUMN';

-- Check NULLs across all quarters
SELECT 'Q1' AS quarter,
    SUM(CASE WHEN trip_id IS NULL THEN 1 ELSE 0 END)           AS null_trip_id,
    SUM(CASE WHEN start_time IS NULL THEN 1 ELSE 0 END)        AS null_start_time,
    SUM(CASE WHEN end_time IS NULL THEN 1 ELSE 0 END)          AS null_end_time,
    SUM(CASE WHEN tripduration IS NULL THEN 1 ELSE 0 END)      AS null_tripduration,
    SUM(CASE WHEN from_station_name IS NULL THEN 1 ELSE 0 END) AS null_from_station,
    SUM(CASE WHEN to_station_name IS NULL THEN 1 ELSE 0 END)   AS null_to_station,
    SUM(CASE WHEN usertype IS NULL THEN 1 ELSE 0 END)          AS null_usertype,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END)            AS null_gender,
    SUM(CASE WHEN birthyear IS NULL THEN 1 ELSE 0 END)         AS null_birthyear
FROM trips_2019_Q1
UNION ALL
SELECT 'Q2', SUM(CASE WHEN trip_id IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN start_time IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN end_time IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN tripduration IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN from_station_name IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN to_station_name IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN usertype IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN birthyear IS NULL THEN 1 ELSE 0 END)
FROM trips_2019_Q2
UNION ALL
SELECT 'Q3', SUM(CASE WHEN trip_id IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN start_time IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN end_time IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN tripduration IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN from_station_name IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN to_station_name IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN usertype IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN birthyear IS NULL THEN 1 ELSE 0 END)
FROM trips_2019_Q3
UNION ALL
SELECT 'Q4', SUM(CASE WHEN trip_id IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN start_time IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN end_time IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN tripduration IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN from_station_name IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN to_station_name IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN usertype IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN birthyear IS NULL THEN 1 ELSE 0 END)
FROM trips_2019_Q4;

-- Check for duplicate trip IDs
SELECT 'Q1' AS quarter, trip_id, COUNT(*) AS occurrences
FROM trips_2019_Q1 GROUP BY trip_id HAVING COUNT(*) > 1
UNION ALL
SELECT 'Q2', trip_id, COUNT(*) FROM trips_2019_Q2 GROUP BY trip_id HAVING COUNT(*) > 1
UNION ALL
SELECT 'Q3', trip_id, COUNT(*) FROM trips_2019_Q3 GROUP BY trip_id HAVING COUNT(*) > 1
UNION ALL
SELECT 'Q4', trip_id, COUNT(*) FROM trips_2019_Q4 GROUP BY trip_id HAVING COUNT(*) > 1;
-- Result: 0 rows — no duplicates found

-- Check ride duration outliers
SELECT 'Q1' AS quarter,
    MIN(tripduration/60.0) AS min_mins, MAX(tripduration/60.0) AS max_mins,
    SUM(CASE WHEN tripduration < 60 THEN 1 ELSE 0 END)    AS rides_under_1min,
    SUM(CASE WHEN tripduration > 10800 THEN 1 ELSE 0 END) AS rides_over_3hrs
FROM trips_2019_Q1
UNION ALL
SELECT 'Q2', MIN(tripduration/60.0), MAX(tripduration/60.0),
    SUM(CASE WHEN tripduration < 60 THEN 1 ELSE 0 END),
    SUM(CASE WHEN tripduration > 10800 THEN 1 ELSE 0 END)
FROM trips_2019_Q2
UNION ALL
SELECT 'Q3', MIN(tripduration/60.0), MAX(tripduration/60.0),
    SUM(CASE WHEN tripduration < 60 THEN 1 ELSE 0 END),
    SUM(CASE WHEN tripduration > 10800 THEN 1 ELSE 0 END)
FROM trips_2019_Q3
UNION ALL
SELECT 'Q4', MIN(tripduration/60.0), MAX(tripduration/60.0),
    SUM(CASE WHEN tripduration < 60 THEN 1 ELSE 0 END),
    SUM(CASE WHEN tripduration > 10800 THEN 1 ELSE 0 END)
FROM trips_2019_Q4;
