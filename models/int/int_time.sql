with hours as (

    select
        seq4() as hour
    from table(generator(rowcount => 24))

),

clock as (

    select
        hour
        , lpad(hour::varchar, 2, '0') || ':00' as time_label
        , case
            when hour between 6  and 10 then 'morning'
            when hour between 11 and 14 then 'lunch'
            when hour between 15 and 17 then 'afternoon'
            when hour between 18 and 22 then 'dinner'
            else 'late_night'
        end as day_period
    from hours
)

, generate_sk as (

    select
        {{ dbt_utils.generate_surrogate_key(['hour']) }} as sk_time
        , *
    from clock
)

select *
from generate_sk
