with test_cte as (

    select

        node_unique_id as model,
        config_schema as model_schema,
        name as change_schema_to

    from {{ ref('int_data_product_relationships') }}
    where lower(name) <> lower(config_schema)

)

select * from test_cte

{{ filter_exceptions() }}