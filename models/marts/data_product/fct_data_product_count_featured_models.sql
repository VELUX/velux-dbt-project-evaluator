with test_cte as (
    
    select

        *,
        array_size(featured_models) as cntfeatured_models_count
    
    from {{ ref('stg_data_product') }}
    where cntfeatured_models_count > 5

)

select * from test_cte

{{ filter_exceptions() }}