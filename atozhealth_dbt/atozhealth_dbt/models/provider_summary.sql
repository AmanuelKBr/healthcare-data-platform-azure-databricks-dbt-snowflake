{{ config(materialized='table') }}

select
    pr.provider_id,
    pr.first_name,
    pr.last_name,
    pr.specialty,
    pr.department,

    count(distinct a.admission_id) as total_admissions,
    count(distinct a.patient_id) as unique_patients,

    avg(a.length_of_stay_days_clean) as avg_los,
    sum(a.total_charge) as total_revenue

from atozhealth_db.silver.providers_silver pr

left join atozhealth_db.silver.inpatient_admissions_silver a
    on pr.provider_id = a.attending_provider_id

group by
    pr.provider_id, pr.first_name, pr.last_name, pr.specialty, pr.department