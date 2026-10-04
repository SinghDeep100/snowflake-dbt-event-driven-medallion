{{ config(
    materialized = 'table'
) }}

SELECT 
    F.ORDER_DATE,
    F.DIVISION,
    F.REGION,
    COUNT(DISTINCT F.ORDER_ID) AS TOTAL_ORDERS,
    SUM(F.UNITS) AS TOTAL_UNITS_SOLD,
    SUM(F.SALES) AS TOTAL_REVENUE,
    SUM(F.GROSS_PROFIT) AS TOTAL_PROFIT
FROM {{ ref('fct_candy_sales') }} F
GROUP BY 1, 2, 3