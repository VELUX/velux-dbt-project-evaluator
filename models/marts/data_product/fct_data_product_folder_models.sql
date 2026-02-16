with test_cte as (

    select

        node_unique_id as model,
        node_folder_path as model_folder_path,
        data_product_folder_path as change_folder_path_to

    from {{ ref('int_data_product_relationships') }}
    where lower(data_product_folder_path) <> lower(node_folder_path)

)

select * from test_cte

{{ filter_exceptions() }}