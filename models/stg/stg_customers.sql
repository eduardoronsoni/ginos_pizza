select
    cast(id as string) as id
    , firstname as first_name
    , lastname as last_name
    , namesuffix as name_suffix
    , trim(concat(firstname, ' ', lastname, ' ', coalesce(namesuffix, ''))) AS full_name
    , case
        when lower(gender) = 'male' then 'Male'
        when lower(gender) = 'female' then 'Female'
        else 'Unknown'
      end as gender
    , try_cast(dob as date) as  date_of_birth
from {{ source('pos_system', 'customers')}}
