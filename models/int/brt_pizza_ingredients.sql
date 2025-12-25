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

select *
from deduplicated