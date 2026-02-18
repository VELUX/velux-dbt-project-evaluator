with test_cte as (

    select

        name,
        folder_name,
        name as change_folder_name_to

    from {{ ref('stg_data_product') }}
    where lower(name) <> lower(folder_name)

)

select * from test_cte

{{ filter_exceptions() }}