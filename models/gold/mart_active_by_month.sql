with daily_active as (
    select
        *
    from {{ ref('kpi_active_last_six_months') }}
)

select
    date_trunc('month', date_day) as month,
    round(avg(active_customers_6months)) as avg_active_customers_6months
from daily_active
group by 1
order by 1
