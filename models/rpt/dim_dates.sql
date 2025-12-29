with dates as (
    select 
        sk_date
        , date
        , year
        , month
        , month_name
        , day
        , day_of_week
        , week_of_year
        , day_of_year
        , is_weekend
    from {{ ref('int_dates')}}
)

select *
from dates