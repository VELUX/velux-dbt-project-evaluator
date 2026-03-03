with test_cte as (

    select

        name,
        data_product_node_unique_id as model_name

    from {{ ref('int_data_product_relationships') }}
    where node_unique_id is null

)

select * from test_cte

{{ filter_exceptions() }}