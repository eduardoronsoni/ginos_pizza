with base as (

    select
        pizza_id
        , pizza_ingredients
    from {{ ref('stg_sales') }}

)

, split_ingredients as (

    select
        pizza_id
        , trim(f.value::string) as ingredient_name
    from base
       , lateral flatten(
            input => split(pizza_ingredients, ',')
         ) f

)

, deduplicated as (

    select distinct
        pizza_id
        , ingredient_name
    from split_ingredients

)

, with_keys as (

    select
        pizzas.sk_pizza              as fk_pizza
        , ingredients.sk_ingredient  as fk_ingredient
    from deduplicated d
    left join {{ ref('dim_pizzas') }} pizzas
        on pizzas.pizza_id = d.pizza_id
    left join {{ ref('dim_ingredients') }} ingredients
        on ingredients.ingredient_name = d.ingredient_name
)

select *
from with_keys
where fk_pizza is not null
  and fk_ingredient is not null
