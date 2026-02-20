with source as (
    select * from {{ref('brz_reservations')}}
)
select 
        reservation_uuid as reservation_id,
        customer_uuid as customer_id,
        restaurant_uuid as restaurant_id,
        dt_day_booking_date as booking_date,
        dt_day_meal_date as meal_date,
        amt_revenue_eur as revenue_eur,
        party_size,
        is_net,
        is_online,
        is_walk_in,
        channel,
        lunch_type,
        (dt_day_meal_date - dt_day_booking_date) as booking_lead_days
from source