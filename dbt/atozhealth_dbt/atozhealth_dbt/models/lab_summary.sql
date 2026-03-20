{{ config(materialized='table') }}

select
    test_category,
    test_name,

    count(distinct lab_order_id) as total_lab_orders,
    count(distinct patient_id) as unique_patients,
    count_if(abnormal_flag is not null and abnormal_flag <> '') as abnormal_results

from atozhealth_db.silver.lab_orders_results_silver

group by test_category, test_name