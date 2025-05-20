{{ config(
    materialized='incremental',
    unique_key='store_id',
    schema=var('schema_star')
) }}

SELECT
    store_skey,
    store_id,
    store_address,
    store_district,
    store_postal_code,
    store_phone_number,
    store_city,
    store_country,
    store_manager_staff_id,
    store_manager_first_name,
    store_manager_last_name,
    store_last_update
FROM {{ ref('stg_store') }}

{% if is_incremental() %}
WHERE store_last_update > (SELECT max(store_last_update) FROM {{ this }})
{% endif %}
