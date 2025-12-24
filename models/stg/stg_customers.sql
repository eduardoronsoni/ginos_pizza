select
    cast(id as string) as id
    , firstname as first_name
    , lastname as last_name
    , namesuffix as name_suffix
    , trim(concat(firstname, ' ', lastname, ' ', coalesce(namesuffix, ''))) AS full_name
    , gender
    , try_cast(dob as date) as  date_of_birth
from {{ source('pos_system', 'customers')}}
