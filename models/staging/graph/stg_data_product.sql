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
        split(file_path, '/')[array_size(split(file_path, '/')) - 2]::varchar as folder_name,
        parse_json(meta):featured_models as featured_models,

    from {{ ref('stg_exposures') }}
    where file_path like '%data_product.yml%'
)

select * from data_products_cte