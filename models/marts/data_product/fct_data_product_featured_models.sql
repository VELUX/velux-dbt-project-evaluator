with data_product_relationships_cte as (

    select

        name,
        data_product_featured_models,
        node_unique_id

    from {{ ref('int_data_product_relationships') }}

),

depends_on_cte as (

    select

        name,
        split(node_unique_id, '.')[2]::string as model_name

    from data_product_relationships_cte

),

featured_models_cte as (

    select
    
        distinct
        name,
        featured_model.value::string as featured_model_name

    from data_product_relationships_cte,
    lateral flatten(input => data_product_featured_models) featured_model

),

joined_cte as (

    select

        featured_models_cte.name,
        featured_models_cte.featured_model_name,
        depends_on_cte.model_name

    from featured_models_cte
    left join depends_on_cte
    on featured_models_cte.name = depends_on_cte.name
    and featured_models_cte.featured_model_name = depends_on_cte.model_name

),

final_cte as (

    select

        name as data_product,
        featured_model_name as featured_model_not_found

    from joined_cte
    where model_name is null

)

select * from final_cte

{{ filter_exceptions() }}