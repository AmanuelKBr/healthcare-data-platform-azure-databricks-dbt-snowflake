# Architecture Overview

Medallion Architecture implemented using:

- Azure Data Factory (Orchestration)
- Databricks (Bronze + Silver)
- Snowflake (Data Warehouse)
- dbt (Gold Layer Modeling)

Flow:
ADF → Databricks → Snowflake (Silver) → dbt (Gold)

Monitoring:
- Azure Monitor Alerts
- Log Analytics

Environment:
- DEV (DBT_GOLD_DEV)
- PROD (GOLD)