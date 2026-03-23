    {{ config(materialized='table') }}

select
    date_trunc('day', a.admit_datetime) as report_date,

    count(distinct p.patient_id) as total_patients,
    count(distinct a.admission_id) as total_admissions,
    count(distinct e.ed_visit_id) as total_ed_visits,
    count(distinct l.lab_order_id) as total_lab_orders,
    count(distinct rx.pharmacy_order_id) as total_med_orders,
    count(distinct r.radiology_order_id) as total_radiology_orders,

    sum(a.total_charge) as total_revenue,
    avg(a.length_of_stay_days_clean) as avg_los

from atozhealth_db.silver.patient_master_silver p

left join atozhealth_db.silver.inpatient_admissions_silver a
    on p.patient_id = a.patient_id

left join atozhealth_db.silver.emergency_visits_silver e
    on p.patient_id = e.patient_id

left join atozhealth_db.silver.lab_orders_results_silver l
    on p.patient_id = l.patient_id

left join atozhealth_db.silver.pharmacy_orders_silver rx
    on p.patient_id = rx.patient_id

left join atozhealth_db.silver.radiology_orders_silver r
    on p.patient_id = r.patient_id

group by
    report_date