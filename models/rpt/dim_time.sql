with time as (
    select 
        sk_time
        , hour
        , day_period
    from {{ ref('int_time')}}
)

select *
from time