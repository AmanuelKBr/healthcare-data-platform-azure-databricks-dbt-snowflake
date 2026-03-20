{{ config(materialized='table') }}

with inpatient as (
    select
        department,
        count(distinct admission_id) as total_admissions,
        count(distinct patient_id) as unique_inpatients,
        avg(length_of_stay_days_clean) as avg_los,
        sum(total_charge) as total_revenue
    from atozhealth_db.silver.inpatient_admissions_silver
    group by department
),
providers as (
    select
        department,
        count(distinct provider_id) as total_providers
    from atozhealth_db.silver.providers_silver
    group by department
),
beds as (
    select
        department,
        count(distinct bed_id) as total_beds,
        count_if(status = 'Occupied') as occupied_beds,
        count_if(status = 'Available') as available_beds
    from atozhealth_db.silver.bed_inventory_silver
    group by department
)

select
    i.department,
    i.total_admissions,
    i.unique_inpatients,
    i.avg_los,
    i.total_revenue,
    p.total_providers,
    b.total_beds,
    b.occupied_beds,
    b.available_beds
from inpatient i
left join providers p
    on i.department = p.department
left join beds b
    on i.department = b.department