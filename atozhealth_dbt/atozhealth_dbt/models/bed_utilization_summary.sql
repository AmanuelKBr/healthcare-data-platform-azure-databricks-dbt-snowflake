{{ config(materialized='table') }}

select
    b.bed_id,
    b.room_number,
    b.department,
    b.bed_type,
    b.status as current_status,

    count(distinct a.admission_id) as total_admissions,
    count(distinct a.patient_id) as unique_patients,
    avg(a.length_of_stay_days_clean) as avg_los

from atozhealth_db.silver.bed_inventory_silver b

left join atozhealth_db.silver.inpatient_admissions_silver a
    on b.bed_id = a.bed_id

group by
    b.bed_id, b.room_number, b.department, b.bed_type, b.status