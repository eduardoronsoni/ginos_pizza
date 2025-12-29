with
    customers as (

        select *
        from {{ ref('int_customers') }}

    )

    , dates as (

        select *
        from {{ ref('int_dates')}}

    )

    , pizzas as (

        select *
        from {{ ref('int_pizzas') }}

    )

    , time as (

        select *
        from {{ ref('int_time') }}

    )

    , sales as (

        select *
        from {{ ref('int_order_details') }}

    )

    , creating_fk as (

        select
            sales.sk_order_detail
            , sales.sk_order
            , customers.sk_customer as fk_customer
            , dates.sk_date as fk_date
            , time.sk_time as fk_time
            , pizzas.sk_pizza as fk_pizza
            , sales.qty
            , sales.order_date
            , sales.order_time
            , sales.unit_price
            , sales.total_price
        from sales
        left join customers
            on customers.customer_id = sales.customer_id
        left join dates
            on dates.date = sales.order_date
        left join pizzas
            on pizzas.pizza_id = sales.pizza_id
        left join time
            on time.hour = extract(hour from sales.order_datetime)
    )

    select *
    from creating_fk
