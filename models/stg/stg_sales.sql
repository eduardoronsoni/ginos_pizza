select
    cast(order_details_id as string) as order_details_id
    , cast(order_id as string) as order_id
    , cast(customer_id as string) as customer_id
    , pizza_id
    , cast(quantity as int) as qty
    , cast(order_date as date) as order_date
    , cast(order_time as time) as order_time
    , round(cast(unit_price as float),2) as unit_price
    , round(cast(total_price as float),2) as total_price
    , pizza_size
    , pizza_category
    , pizza_ingredients
    , pizza_name
from {{ source('pos_system', 'pizza_sales') }}
where order_id <> '4232'
