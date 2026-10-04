{{ config(
    materialized = 'table'
) }}

SELECT 
    ROW_ID,
    ORDER_ID,
    ORDER_DATE,
    SHIP_DATE,
    SHIP_MODE,
    CUSTOMER_ID,
    COUNTRY_REGION,
    CITY,
    STATE_PROVINCE,
    POSTAL_CODE,
    DIVISION,
    REGION,
    PRODUCT_ID,
    PRODUCT_NAME,
    SALES,
    UNITS,
    GROSS_PROFIT,
    COST,
    _LOADED_AT,
    _FILE_NAME
FROM {{ source('bronze', 'str_raw_candy_sales') }}