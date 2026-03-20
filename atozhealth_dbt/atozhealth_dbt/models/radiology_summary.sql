{{ config(materialized='table') }}

select
    imaging_type,
    body_part,
    count(distinct radiology_order_id) as total_orders,
    count(distinct patient_id) as unique_patients
from atozhealth_db.silver.radiology_orders_silver
group by
    imaging_type,
    body_part