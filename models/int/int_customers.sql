with customers as (

    select
        id as customer_id
        , first_name
        , last_name
        , name_suffix
        , full_name
        , gender
        , date_of_birth
    from {{ ref('stg_customers') }}

)

, enriched as (

    select
          *
        , datediff(year, date_of_birth, current_date) as age
        , case
            when datediff(year, date_of_birth, current_date) < 18
                then 'under_18'
            when datediff(year, date_of_birth, current_date) between 18 and 24
                then '18_24'
            when datediff(year, date_of_birth, current_date) between 25 and 34
                then '25_34'
            when datediff(year, date_of_birth, current_date) between 35 and 44
                then '35_44'
            when datediff(year, date_of_birth, current_date) between 45 and 54
                then '45_54'
            else '55_plus'
          end as age_group
    from customers

)

, generate_sk as (

    select
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as sk_customer
        , *
    from enriched

)

select *
from generate_sk
