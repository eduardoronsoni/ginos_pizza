with dates as (

    {{ dbt_utils.date_spine(
        datepart = "day"
        , start_date = "date('2017-01-01')"
        , end_date   = "date('2030-12-31')"
    ) }}

)

, calendar as (
    select
        date_day as date
        , extract(year  from date_day) as year
        , extract(month from date_day) as month
        , monthname(date_day) as month_name
        , extract(day   from date_day) as day
        , dayofweek(date_day) as day_of_week
        , weekofyear(date_day) as week_of_year
        , dayofyear(date_day) as day_of_year
        , case
            when dayofweek(date_day) in (1, 7)
            then true else false
        end as is_weekend
    from dates
)

, generate_sk as (
     select
            {{ dbt_utils.generate_surrogate_key(['date']) }} as sk_date
            , *
        from calendar
)

select *
from generate_sk
