{{ config(materialized='table') }}

select
    therapy_type,
    count(distinct visit_id) as total_visits,
    count(distinct patient_id) as unique_patients,
    avg(session_duration_minutes) as avg_session_duration
from atozhealth_db.silver.rehab_physio_visits_silver
group by
    therapy_type