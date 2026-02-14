select

    name,
    folder_name,
    name as change_folder_name_to

from {{ ref('stg_data_product') }}
where name <> folder_name