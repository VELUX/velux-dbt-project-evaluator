with test_cte as (

    select
    
        owner_email,
        owner_email ilike '%@VELUX.COM' as is_velux_email_address
    
    from {{ ref('stg_data_product') }}
    where is_velux_email_address = false

)

select * from test_cte

{{ filter_exceptions() }}