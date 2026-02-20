with validated_bookings as (
    select
        fr.booking_date,
        dr.restaurant_country,
        dc.unified_customer_id
    from {{ref('fct_reservations')}} fr
    join {{ref('dim_customers')}} dc
    on fr.customer_id = dc.customer_id
    join {{ref('dim_restaurants')}} dr 
    on fr.restaurant_id = dr.restaurant_id

    where fr.is_net = true and fr.channel = 'TheFork Network'
),


active_customers as (
    select 
        dd.date_day,
        vb.unified_customer_id,
        vb.restaurant_country
    from {{ref('dim_dates')}} dd
    join validated_bookings vb
    on vb.booking_date between dd.date_day - interval '180 days' and dd.date_day
)

select
    date_day,
    restaurant_country,
    count(distinct unified_customer_id) as active_customers_6months
from active_customers
group by date_day, restaurant_country