with data_product_cte as (

    select 
    
        unique_id,
        name,
        folder_name,
        folder_path
    
    from {{ ref('stg_data_product') }}

),

exposure_relationships_cte as (

    select
    
        resource_id,
        direct_parent_id

    from {{ ref('stg_exposure_relationships') }}

),

nodes_cte as (

    select

        unique_id,
        config_schema,
        split(file_path, '/') as path_array,
        array_slice(path_array,0,array_size(path_array) - 1) as folder_path_array,
        array_to_string(folder_path_array, '/')::varchar as folder_path
    
    from {{ ref('stg_nodes') }}

),

joined_cte as (

    select 
        data_product_cte.name,
        data_product_cte.folder_name as data_product_folder_name,
        nodes_cte.unique_id as node_unique_id,
        nodes_cte.config_schema,
        nodes_cte.folder_path as node_folder_path

    from data_product_cte
    left join exposure_relationships_cte
    on data_product_cte.unique_id = exposure_relationships_cte.resource_id
    left join nodes_cte
    on exposure_relationships_cte.direct_parent_id = nodes_cte.unique_id

)

select * from joined_cte