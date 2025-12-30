with all_customers_from_sales as (
    -- Gets all unique customers from sales
    select distinct 
        customer_id
    from {{ ref('stg_sales') }}
    where customer_id is not null
)

, existing_customers as (

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

, base_customers as (
    select
        a.customer_id,
        -- Get real data when available. If not, define as unknown
        coalesce(e.first_name, 'Unknown') as first_name,
        coalesce(e.last_name, 'Customer') as last_name,
        e.name_suffix,
        coalesce(
            e.full_name,
            'Customer ' || a.customer_id
        ) as full_name,
        e.gender,
        e.date_of_birth,
        -- Flag to know where the data came from
        case 
            when e.customer_id is not null then 'From Customer Table'
            else 'Inferred from Sales'
        end as data_source
    from all_customers_from_sales a
    left join existing_customers e
        on e.customer_id = a.customer_id
)

, enriched as (
    select
        *,
        datediff(year, date_of_birth, current_date) as age,
        case
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
            when datediff(year, date_of_birth, current_date) >= 55
                then '55_plus'
            else 'Unknown_age'  -- For clients not on the customers source
        end as age_group,
    from base_customers
)

, generate_sk as (
    select
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as sk_customer,
        *
    from enriched
)

select *
from generate_sk