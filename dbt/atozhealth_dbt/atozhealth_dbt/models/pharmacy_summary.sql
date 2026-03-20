{{ config(materialized='table') }}

select
    medication_name,
    route,
    pharmacy_status,
    count(distinct pharmacy_order_id) as total_orders,
    count(distinct patient_id) as unique_patients
from atozhealth_db.silver.pharmacy_orders_silver
group by
    medication_name,
    route,
    pharmacy_status