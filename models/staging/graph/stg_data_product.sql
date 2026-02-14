with data_products_cte as (
    select

        unique_id,
        name,
        resource_type,
        file_path,
        is_described,
        exposure_type,
        maturity,
        package_name,
        url,
        owner_name,
        owner_email,
        meta,
        split(file_path, '/') as path_array,
        array_slice(path_array,0,array_size(path_array) - 1) as folder_path_array,
        array_to_string(folder_path_array, '/')::varchar as folder_path,
        path_array[array_size(path_array) - 2]::varchar as folder_name,
    
        parse_json(meta):featured_models as featured_models,

    from {{ ref('stg_exposures') }}
    where file_path like '%data_product.yml%'
)

select * from data_products_cte