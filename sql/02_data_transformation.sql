-- ===============================
-- CREATE WORKING TABLE
-- ===============================
CREATE TABLE Agriculture AS 
SELECT * FROM PowerBI.PBI_Data.PBI_Dataset;

-- ===============================
-- DATA ADJUSTMENTS
-- ===============================
UPDATE Agriculture
SET Rainfall = 1.1 * Rainfall;

UPDATE Agriculture
SET Area = 0.9 * Area;

-- ===============================
-- YEAR GROUPING
-- ===============================
ALTER TABLE Agriculture ADD YEAR_GROUP STRING;

UPDATE Agriculture
SET YEAR_GROUP = 'Y1'
WHERE YEAR BETWEEN 2004 AND 2009;

UPDATE Agriculture
SET YEAR_GROUP = 'Y2'
WHERE YEAR BETWEEN 2010 AND 2014;

UPDATE Agriculture
SET YEAR_GROUP = 'Y3'
WHERE YEAR BETWEEN 2015 AND 2019;

-- ===============================
-- RAINFALL GROUPING
-- ===============================
ALTER TABLE Agriculture ADD RAINFALL_GROUP STRING;

UPDATE Agriculture
SET RAINFALL_GROUP = 'Low'
WHERE RAINFALL <= 1955;

UPDATE Agriculture
SET RAINFALL_GROUP = 'Medium'
WHERE RAINFALL >= 1956 AND RAINFALL <= 2956;

UPDATE Agriculture
SET RAINFALL_GROUP = 'High'
WHERE RAINFALL >= 2957;

-- ===============================
-- FINAL CHECK
-- ===============================
SELECT * FROM Agriculture;
