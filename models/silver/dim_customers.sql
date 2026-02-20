with online as (
    select
    customer_uuid as customer_id,
    customer_uuid as unified_customer_id,
    'online' as customer_type,
    lower(status) as customer_status,
    locale_code
    from {{ref('brz_online_customers')}}
),

offline as (
    select
    customer_uuid as customer_id,
    coalesce(online_customer_uuid, customer_uuid) as unified_customer_id,
    'offline' as customer_type,
    lower(status) as customer_status,
    locale_code
    from {{ref('brz_offline_customers')}}
)

select
*
from online
union all
select
*
from offline