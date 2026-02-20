with validated_bookings as (
    select
        fr.booking_date,
        dc.unified_customer_id,
        dc.locale_code
    from {{ref('fct_reservations')}} fr
    join {{ref('dim_customers')}} dc
    on fr.customer_id = dc.customer_id

    where fr.is_net = true and fr.channel = 'TheFork Network'
),


active_customers as (
    select 
        dd.date_day,
        vb.unified_customer_id,
        vb.locale_code
    from {{ref('dim_dates')}} dd
    join validated_bookings vb
    on vb.booking_date between dd.date_day - interval '180 days' and dd.date_day
)

select
    date_day,
    locale_code,
    count(distinct unified_customer_id) as active_customers_6months
from active_customers
group by date_day,locale_code
order by date_day