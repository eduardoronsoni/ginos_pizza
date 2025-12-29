with customers as (
    select 
        sk_customer
        , customer_id
        , first_name
        , last_name
        , name_suffix
        , full_name
        , gender
        , date_of_birth
        , data_source
        , age
        , age_group
    from {{ ref('int_customers') }}
)

select *
from customers