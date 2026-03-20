{{ config(materialized='table') }}

select
    a.department,

    count(distinct a.admission_id) as total_admissions,
    count(distinct a.patient_id) as unique_patients,

    avg(a.length_of_stay_days_clean) as avg_los,
    sum(a.total_charge) as total_revenue,

    count(distinct e.ed_visit_id) as related_ed_visits

from atozhealth_db.silver.inpatient_admissions_silver a

left join atozhealth_db.silver.emergency_visits_silver e
    on a.patient_id = e.patient_id

group by a.department