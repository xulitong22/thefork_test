with validated_bookings as (
    select
        fr.booking_date,
        fr.lunch_type,
        dc.unified_customer_id
    from {{ref('fct_reservations')}} fr
    join {{ref('dim_customers')}} dc
    on fr.customer_id = dc.customer_id

    where fr.is_net = true and fr.channel = 'TheFork Network'
),


active_customers as (
    select 
        dd.date_day,
        vb.unified_customer_id,
        vb.lunch_type
    from {{ref('dim_dates')}} dd
    join validated_bookings vb
    on vb.booking_date between dd.date_day - interval '180 days' and dd.date_day
)

select
    date_day,
    lunch_type,
    count(distinct unified_customer_id) as active_customers_6months
from active_customers
group by date_day,lunch_type