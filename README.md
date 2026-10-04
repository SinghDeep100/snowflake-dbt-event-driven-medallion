# snowflake-dbt-event-driven-medallion
Event-driven Medallion architecture in Snowflake using Streams, Tasks, and native dbt execution.

# Event-Driven Medallion Data Architecture (Snowflake & dbt)

## 📌 Architecture Overview
This project implements an automated, event-driven Medallion (Bronze -> Silver -> Gold) data lakehouse architecture inside Snowflake using **Snowflake Streams**, **Serverless Tasks**, and **Snowflake Native Apps (dbt)**.

### Key Highlights:
- **Zero-Cost Idle Monitoring:** Uses `SYSTEM$STREAM_HAS_DATA` inside Snowflake Tasks to evaluate stream conditions every 60 seconds without consuming compute credits when no data is present.
- **CDC Pointer Management:** Snowflake Streams capture delta changes on Bronze raw tables using Log Sequence Numbers (LSN).
- **Native dbt Execution:** Runs `dbt build` directly on Snowflake compute via `EXECUTE DBT PROJECT`, eliminating external orchestrators like Airflow or dbt Cloud.
- **Physical Table Persistence:** Materializes Silver staging as physical tables to safely consume stream offsets and prevent data loss.

---

## 🛠️ Project Structure

```text
├── dbt_project.yml                   # dbt configuration & targets
├── models/
│   ├── staging/
│   │   ├── _src_bronze.yml           # Source definitions (Bronze stream)
│   │   └── stg_raw_sales.sql         # Reads Bronze stream & materializes Silver staging
│   └── marts/
│       ├── fct_candy_sales.sql       # Conformed Silver Fact table
│       └── fct_sales_summary.sql     # Gold Aggregation table (Daily KPIs)
└── sql_orchestration/
    ├── 01_setup_bronze_stream.sql   # Creates Bronze source table & CDC stream
    ├── 02_setup_dbt_task.sql        # Creates event-driven TSK_RUN_DBT_BUILD task
    └── 03_monitoring_verify.sql     # Task history and dbt execution log checks
