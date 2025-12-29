with pizza_sales as (
    
    select
        order_details_id
        , order_id
        , customer_id
        , pizza_id
        , qty
        , order_date
        , order_time
        , to_timestamp_ntz(
                order_date || ' ' || order_time
            ) as order_datetime
        , unit_price
        , total_price
    from {{ ref('stg_sales')}}

)

, generate_sk as (
    select
        {{ dbt_utils.generate_surrogate_key(['order_details_id']) }} as sk_order_detail
        , {{ dbt_utils.generate_surrogate_key(['order_id']) }} as sk_order
        , *
    from pizza_sales
)

select *
from generate_sk
