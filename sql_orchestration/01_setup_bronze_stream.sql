-- ============================================================================
-- 01_SETUP_BRONZE_STREAM.SQL
-- Purpose: Setup Bronze base table and CDC Stream for Event-Driven Ingestion
-- ============================================================================

USE ROLE ACCOUNTADMIN;
USE DATABASE MAVEN_CANDY_ANALYTICS;
USE SCHEMA BRONZE;

-- Create Bronze Raw Sales Table (Target for raw ingestion)
CREATE OR REPLACE TABLE MAVEN_CANDY_ANALYTICS.BRONZE.RAW_CANDY_SALES (
    ROW_ID NUMBER,
    ORDER_ID VARCHAR(50),
    ORDER_DATE DATE,
    SHIP_DATE DATE,
    SHIP_MODE VARCHAR(50),
    CUSTOMER_ID VARCHAR(50),
    COUNTRY_REGION VARCHAR(50),
    CITY VARCHAR(50),
    STATE_PROVINCE VARCHAR(50),
    POSTAL_CODE VARCHAR(20),
    DIVISION VARCHAR(50),
    REGION VARCHAR(50),
    PRODUCT_ID VARCHAR(50),
    PRODUCT_NAME VARCHAR(100),
    SALES NUMBER(10,2),
    UNITS NUMBER(10,0),
    GROSS_PROFIT NUMBER(10,2),
    COST NUMBER(10,2)
);

-- Create Stream on Bronze table for Log Sequence Number (LSN) CDC tracking
CREATE OR REPLACE STREAM MAVEN_CANDY_ANALYTICS.BRONZE.STR_RAW_CANDY_SALES 
ON TABLE MAVEN_CANDY_ANALYTICS.BRONZE.RAW_CANDY_SALES;
