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


ordered_bookings as (
    select
        unified_customer_id,
        locale_code,
        booking_date,
        row_number()over(
            partition by unified_customer_id 
            order by booking_date) as booking_rank,
        first_value(booking_date)over(
            partition by unified_customer_id 
            order by booking_date) as first_booking_date
    from validated_bookings
),


repeaters as(
    select 
        unified_customer_id,
        locale_code,
        booking_date as second_booking_date
    from ordered_bookings
    where booking_rank = 2
    and booking_date <= first_booking_date + interval '30 days'
)



select
    second_booking_date,
    locale_code,
    count(distinct unified_customer_id) as repeaters_30days
from repeaters
group by 1,2
order by 1,2