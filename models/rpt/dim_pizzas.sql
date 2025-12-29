with pizzas as (
    select 
        sk_pizza
        , pizza_id
        , pizza_name
        , pizza_size
        , pizza_category
    from {{ ref('int_pizzas')}}
)

select *
from pizzas
