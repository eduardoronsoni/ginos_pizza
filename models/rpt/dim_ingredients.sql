with ingredients as (
    select 
        sk_ingredient
        , ingredient_name
    from {{ ref('int_ingredients')}}
)

select *
from ingredients