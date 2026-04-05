-- ============================================================
-- Divvy Bike Share Analysis 2019
-- Script 01: Data Inspection
-- Author: Emmanuel Baah Gyan
-- ============================================================

-- Preview all four quarterly tables
SELECT TOP 5 * FROM trips_2019_Q1;
SELECT TOP 5 * FROM trips_2019_Q2;
SELECT TOP 5 * FROM trips_2019_Q3;
SELECT TOP 5 * FROM trips_2019_Q4;

-- Check column names and data types for Q1
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'trips_2019_Q1';

-- Verify row counts for all quarters
SELECT COUNT(*) AS total_rows FROM trips_2019_Q1;  -- 365,069
SELECT COUNT(*) AS total_rows FROM trips_2019_Q2;  -- 1,108,163
SELECT COUNT(*) AS total_rows FROM trips_2019_Q3;  -- 1,640,718
SELECT COUNT(*) AS total_rows FROM trips_2019_Q4;  -- 704,054
                                                   -- Total: 3,818,004
