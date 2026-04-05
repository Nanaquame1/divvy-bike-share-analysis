-- ============================================================
-- Divvy Bike Share Analysis 2019
-- Script 04: Exploratory Analysis
-- Author: Emmanuel Baah Gyan
-- ============================================================

-- Q1: Overall rides and duration by user type
SELECT
    usertype,
    COUNT(*)                                                    AS total_rides,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS pct_of_total,
    CAST(AVG(ride_length_mins) AS DECIMAL(10,2))                AS avg_ride_mins,
    CAST(MIN(ride_length_mins) AS DECIMAL(10,2))                AS min_ride_mins,
    CAST(MAX(ride_length_mins) AS DECIMAL(10,2))                AS max_ride_mins
FROM all_trips_clean
GROUP BY usertype
ORDER BY total_rides DESC;

-- Q2: Rides by day of week per user type
SELECT
    usertype, day_of_week,
    COUNT(*)                                     AS total_rides,
    CAST(AVG(ride_length_mins) AS DECIMAL(10,2)) AS avg_ride_mins
FROM all_trips_clean
GROUP BY usertype, day_of_week
ORDER BY usertype,
    CASE day_of_week
        WHEN 'Monday' THEN 1 WHEN 'Tuesday' THEN 2 WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4 WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6 WHEN 'Sunday' THEN 7 END;

-- Q3: Rides by month per user type
SELECT
    usertype, month_name, quarter,
    COUNT(*)                                     AS total_rides,
    CAST(AVG(ride_length_mins) AS DECIMAL(10,2)) AS avg_ride_mins
FROM all_trips_clean
GROUP BY usertype, month_name, quarter
ORDER BY usertype, quarter,
    CASE month_name
        WHEN 'January' THEN 1 WHEN 'February' THEN 2 WHEN 'March' THEN 3
        WHEN 'April' THEN 4 WHEN 'May' THEN 5 WHEN 'June' THEN 6
        WHEN 'July' THEN 7 WHEN 'August' THEN 8 WHEN 'September' THEN 9
        WHEN 'October' THEN 10 WHEN 'November' THEN 11 WHEN 'December' THEN 12 END;

-- Q4: Rides by hour of day per user type
SELECT
    usertype, hour_of_day,
    COUNT(*)                                     AS total_rides,
    CAST(AVG(ride_length_mins) AS DECIMAL(10,2)) AS avg_ride_mins
FROM all_trips_clean
GROUP BY usertype, hour_of_day
ORDER BY usertype, hour_of_day;

-- Q5: Top start stations by user type
SELECT TOP 20
    usertype, from_station_name,
    COUNT(*) AS total_rides
FROM all_trips_clean
WHERE from_station_name IS NOT NULL
GROUP BY usertype, from_station_name
ORDER BY usertype, total_rides DESC;

-- Q6: Demographics by user type and gender
SELECT
    usertype, gender,
    COUNT(*)                                                    AS total_rides,
    CAST(AVG(CAST(age AS FLOAT)) AS DECIMAL(10,1))              AS avg_age,
    MIN(age) AS min_age, MAX(age) AS max_age
FROM all_trips_clean
WHERE gender IS NOT NULL AND age BETWEEN 16 AND 90
GROUP BY usertype, gender
ORDER BY usertype, total_rides DESC;
