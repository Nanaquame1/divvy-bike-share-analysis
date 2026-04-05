-- ============================================================
-- Divvy Bike Share Analysis 2019
-- Script 05: Export Queries for Tableau
-- Author: Emmanuel Baah Gyan
-- Run each query and save results as CSV for Tableau
-- ============================================================

-- Export 1: divvy_user_summary.csv
SELECT usertype, COUNT(*) AS total_rides,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS pct_of_total,
    CAST(AVG(ride_length_mins) AS DECIMAL(10,2)) AS avg_ride_mins
FROM all_trips_clean GROUP BY usertype;

-- Export 2: divvy_day_of_week.csv
SELECT usertype, day_of_week, COUNT(*) AS total_rides,
    CAST(AVG(ride_length_mins) AS DECIMAL(10,2)) AS avg_ride_mins
FROM all_trips_clean GROUP BY usertype, day_of_week
ORDER BY usertype,
    CASE day_of_week WHEN 'Monday' THEN 1 WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3 WHEN 'Thursday' THEN 4 WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6 WHEN 'Sunday' THEN 7 END;

-- Export 3: divvy_monthly.csv
SELECT usertype, month_name, quarter, COUNT(*) AS total_rides,
    CAST(AVG(ride_length_mins) AS DECIMAL(10,2)) AS avg_ride_mins
FROM all_trips_clean GROUP BY usertype, month_name, quarter
ORDER BY usertype, quarter,
    CASE month_name WHEN 'January' THEN 1 WHEN 'February' THEN 2
        WHEN 'March' THEN 3 WHEN 'April' THEN 4 WHEN 'May' THEN 5
        WHEN 'June' THEN 6 WHEN 'July' THEN 7 WHEN 'August' THEN 8
        WHEN 'September' THEN 9 WHEN 'October' THEN 10
        WHEN 'November' THEN 11 WHEN 'December' THEN 12 END;

-- Export 4: divvy_hourly.csv
SELECT usertype, hour_of_day, COUNT(*) AS total_rides,
    CAST(AVG(ride_length_mins) AS DECIMAL(10,2)) AS avg_ride_mins
FROM all_trips_clean GROUP BY usertype, hour_of_day ORDER BY usertype, hour_of_day;

-- Export 5: divvy_top_stations.csv
SELECT usertype, from_station_name, COUNT(*) AS total_rides
FROM all_trips_clean WHERE from_station_name IS NOT NULL
GROUP BY usertype, from_station_name HAVING COUNT(*) > 1000
ORDER BY usertype, total_rides DESC;

-- Export 6: divvy_demographics.csv
SELECT usertype, gender, COUNT(*) AS total_rides,
    CAST(AVG(CAST(age AS FLOAT)) AS DECIMAL(10,1)) AS avg_age
FROM all_trips_clean WHERE gender IS NOT NULL AND age BETWEEN 16 AND 90
GROUP BY usertype, gender ORDER BY usertype, total_rides DESC;
