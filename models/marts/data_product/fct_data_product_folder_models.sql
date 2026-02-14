select

    node_unique_id as model,
    node_folder_path as model_folder_path,
    data_product_folder_name as change_folder_path_to

from {{ ref('int_data_product_relationships') }}
where data_product_folder_name <> node_folder_path