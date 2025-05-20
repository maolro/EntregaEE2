{% snapshot dstaff_snapshot %}

{{ config(
    target_schema=var('schema_star'),
    unique_key='staff_id',
    strategy='timestamp',
    updated_at='staff_last_updat'
) }}

SELECT
    staff_skey,
    staff_id,
    staff_first_name,
    staff_last_name,
    staff_email,
    staff_active,
    store_id,
    staff_last_update
FROM {{ ref('stg_staff') }}

{% endsnapshot %}

