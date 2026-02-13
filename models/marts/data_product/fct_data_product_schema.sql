with data_product_cte as (

    select 
    
        unique_id,
        name,
    
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
        config_schema
    
    from {{ ref('stg_nodes') }}

),

joined_cte as (

    select 
        data_product_cte.name,
        nodes_cte.config_schema
    from data_product_cte
    left join exposure_relationships_cte
    on data_product_cte.unique_id = exposure_relationships_cte.resource_id
    left join nodes_cte
    on exposure_relationships_cte.direct_parent_id = nodes_cte.unique_id

)

select * from joined_cte
where name <> config_schema