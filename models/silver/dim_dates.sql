with dates as(
    select
    generate_series(
        (select min(booking_date) from {{ref('fct_reservations')}}),
        (select max(booking_date) from {{ref('fct_reservations')}}),
        interval '1 day'
    )::date as date_day
)


select

    date_day,
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    extract(day from date_day) as day,
    extract(dow from date_day) as day_of_week,
    extract(week from date_day) as week_of_year,
    to_char(date_day, 'Month') as month_name,
    case when extract(dow from date_day) in (0,6) then true else false end as is_weekend

from dates