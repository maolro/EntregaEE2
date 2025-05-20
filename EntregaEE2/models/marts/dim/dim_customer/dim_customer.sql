{{ config(
    materialized='incremental',
    unique_key='customer_id',
    schema=var('schema_star')
) }}

SELECT
    customer_skey,
    customer_id,
    customer_first_name,
    customer_last_name,
    customer_email,
    customer_active,
    customer_address,
    customer_district,
    customer_postal_code,
    customer_phone_number,
    customer_city,
    customer_country,
    customer_create_date,
    customer_last_update
FROM {{ ref('stg_customer') }}

{% if is_incremental() %}
WHERE customer_last_update > (SELECT max(customer_last_update) FROM {{ this }})
{% endif %}

