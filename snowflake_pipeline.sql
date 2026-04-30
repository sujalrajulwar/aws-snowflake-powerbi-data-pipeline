-- ===============================
-- STORAGE INTEGRATION
-- ===============================
CREATE OR REPLACE STORAGE INTEGRATION PBI_Integration
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = 'S3'
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::983915672818:role/powerbi.role'
STORAGE_ALLOWED_LOCATIONS = ('s3://amzn-snowflake-pbi-project/');

DESC INTEGRATION PBI_Integration;

-- ===============================
-- DATABASE + SCHEMA + TABLE
-- ===============================
CREATE DATABASE PowerBI;

CREATE SCHEMA PBI_Data;

CREATE TABLE PBI_Dataset (
    Year INT,
    Location STRING,
    Area INT,
    Rainfall FLOAT,
    Temperature FLOAT,
    Soil_type STRING,
    Irrigation STRING,
    yeilds INT,
    Humidity FLOAT,
    Crops STRING,
    price INT,
    Season STRING
);

-- ===============================
-- STAGE CREATION
-- ===============================
CREATE STAGE PowerBI.PBI_Data.pbi_stage
URL = 's3://amzn-snowflake-pbi-project'
STORAGE_INTEGRATION = PBI_Integration;

-- ===============================
-- LOAD DATA
-- ===============================
COPY INTO PBI_Dataset
FROM @pbi_stage
FILE_FORMAT = (TYPE = CSV FIELD_DELIMITER = ',' SKIP_HEADER = 1)
ON_ERROR = 'CONTINUE';

-- ===============================
-- VALIDATION
-- ===============================
LIST @pbi_stage;

SELECT * FROM PBI_Dataset;