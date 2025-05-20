{{ config(
    materialized='view',
    schema=var('schema_stag')
) }}

with store as (
    select
        store_id,
        manager_staff_id,
        address_id,
        last_update as store_last_update
    from {{ source('raw_sakila', 'store') }}
),

staff as (
    select
        staff_id,
        first_name as store_manager_first_name,
        last_name as store_manager_last_name
    from {{ source('raw_sakila', 'staff') }}
),

address as (
    select *
    from {{ source('raw_sakila', 'address') }}
),

city as (
    select *
    from {{ source('raw_sakila', 'city') }}
),

country as (
    select *
    from {{ source('raw_sakila', 'country') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['ss.store_id', 'ss.store_last_update']) }} as store_skey,
    ss.store_id,
    sa.address as store_address,
    sa.district as store_district,
    sa.postal_code as store_postal_code,
    sa.phone as store_phone_number,
    scty.city as store_city,
    sctr.country as store_country,
    ss.manager_staff_id as store_manager_staff_id,
    sst.store_manager_first_name,
    sst.store_manager_last_name,
    ss.store_last_update
from store ss
join address sa
    on ss.address_id = sa.address_id
join city scty
    on sa.city_id = scty.city_id
join country sctr
    on scty.country_id = sctr.country_id
join staff sst
    on ss.manager_staff_id = sst.staff_id
