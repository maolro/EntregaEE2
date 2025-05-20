{{ config(
    materialized='incremental',
    unique_key='staff_id',
    schema=var('schema_star')
) }}

SELECT
    staff_skey,
    staff_id,
    staff_first_name,
    staff_last_name,
    staff_email,
    store_id,
    staff_active,
    staff_last_update
FROM {{ ref('stg_staff') }}

{% if is_incremental() %}
WHERE staff_last_update > (SELECT max(staff_last_update) FROM {{ this }})
{% endif %}
