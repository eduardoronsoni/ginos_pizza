with pizzas as (

    select
          pizza_id
        , pizza_name
        , pizza_size
        , pizza_category
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
