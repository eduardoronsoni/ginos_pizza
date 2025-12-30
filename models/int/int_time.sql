with hours as (

    select
        seq4() as hour
    from table(generator(rowcount => 24))

),

clock as (

    select
        hour
        , case
            when hour between 6  and 10 then 'morning (6-10h)'
            when hour between 11 and 14 then 'lunch (11-14h)'
            when hour between 15 and 17 then 'afternoon (15-17h)'
            when hour between 18 and 22 then 'dinner (18-22h)'
            else 'late_night (23-5h)'
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
