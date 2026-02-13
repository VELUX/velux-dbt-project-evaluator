select * from {{ ref('stg_data_product') }}
where name <> folder_name