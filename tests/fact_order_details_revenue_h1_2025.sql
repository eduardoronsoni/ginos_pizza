with h1_revenue as (

    select
        sum(total_price) as revenue_h1
    from {{ ref('fact_order_details') }}
    where order_date >= '2025-01-01'
      and order_date <  '2025-07-01'

)

select
    revenue_h1
from h1_revenue
where revenue_h1 <> 16413703.75
