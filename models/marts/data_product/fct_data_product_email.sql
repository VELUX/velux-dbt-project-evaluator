with test_cte as (

    select
    
        name as data_product,
        owner_email,
        owner_email ilike '%@VELUX.COM' as is_correct_velux_email_address
    
    from {{ ref('stg_data_product') }}
    where is_correct_velux_email_address = false

)

select * from test_cte

{{ filter_exceptions() }}