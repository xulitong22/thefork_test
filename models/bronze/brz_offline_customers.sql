select 
customer_uuid,
online_customer_uuid,
locale as locale_code,
status,
ts_cre,
ts_upd
from {{source('raw','offline_customers')}}