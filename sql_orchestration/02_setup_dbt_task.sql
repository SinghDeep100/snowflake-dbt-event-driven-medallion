-- ============================================================================
-- 02_SETUP_DBT_TASK.SQL
-- Purpose: Event-driven Task definition with zero-cost idle monitoring
-- ============================================================================

USE ROLE ACCOUNTADMIN;
USE DATABASE MAVEN_CANDY_ANALYTICS;
USE SCHEMA SILVER;

-- Create serverless task triggered on stream condition
CREATE OR REPLACE TASK MAVEN_CANDY_ANALYTICS.SILVER.TSK_RUN_DBT_BUILD
  WAREHOUSE = COMPUTE_WH
  SCHEDULE = '1 MINUTE'
  WHEN SYSTEM$STREAM_HAS_DATA('MAVEN_CANDY_ANALYTICS.BRONZE.STR_RAW_CANDY_SALES')
AS
  EXECUTE DBT PROJECT MAVEN_CANDY_ANALYTICS.SILVER.maven_candy_dbt_proj ARGS = 'build';

-- Resume task to start listening for changes
ALTER TASK MAVEN_CANDY_ANALYTICS.SILVER.TSK_RUN_DBT_BUILD RESUME;
