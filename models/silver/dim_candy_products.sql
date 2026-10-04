{{ 
    config(
        materialized='table', 
        schema='SILVER'
    ) 
}}

SELECT DISTINCT
    TRIM(product_id)                    AS product_id,
    TRIM(product_name)                  AS product_name,
    TRIM(division)                      AS division,
    TRIM(factory)                       AS factory,
    CAST(unit_price AS NUMBER(10,2))    AS unit_price,
    CAST(unit_cost AS NUMBER(10,2))     AS unit_cost,
    CURRENT_TIMESTAMP()                 AS dw_updated_at
FROM {{ source('bronze', 'raw_candy_products') }}
WHERE product_id IS NOT NULL