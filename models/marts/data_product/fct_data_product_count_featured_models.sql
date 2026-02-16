select

    *,
    array_size(featured_models) as cntfeatured_models_count
    
from {{ ref('stg_data_product') }}
where cntfeatured_models_count > 5

{{ filter_exceptions() }}