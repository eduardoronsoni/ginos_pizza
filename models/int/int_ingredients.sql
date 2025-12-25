with base as (

    select
        pizza_ingredients
    from {{ ref('stg_sales') }}

)

, split_ingredients as (

    select
        trim(f.value::string) as ingredient_name
    from base
       , lateral flatten(
            input => split(pizza_ingredients, ',')
         ) f

)

, generate_sk as (

    select distinct
        {{ dbt_utils.generate_surrogate_key(['ingredient_name']) }} as sk_ingredient
        , ingredient_name
    from split_ingredients

)

select *
from generate_sk
