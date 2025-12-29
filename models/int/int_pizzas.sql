with pizzas as (

    select
        distinct
          pizza_id
        , trim(pizza_name) as pizza_name
        , trim(pizza_size) as pizza_size
        , trim(pizza_category) as pizza_category
    from {{ ref('stg_sales') }}

)

, generate_sk as (

    select
          {{ dbt_utils.generate_surrogate_key(['pizza_id']) }} as sk_pizza
        , *
    from pizzas

)

select *
from generate_sk

