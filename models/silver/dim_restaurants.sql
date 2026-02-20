with restaurants as(
    select distinct 
    restaurant_uuid as restaurant_id,
    restaurant_city,
    restaurant_country
    from {{ref('brz_reservations')}}
)

select * from restaurants