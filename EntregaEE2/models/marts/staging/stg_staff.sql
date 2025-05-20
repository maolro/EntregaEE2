{{
    config(
        materialized='view',
        schema=var('schema_stag')
    )
}}

with staff as (
    select
        staff_id,
        first_name,
        last_name,
        address_id,
        email,
        store_id,
        active,
        last_update
    from {{ source('raw_sakila', 'staff') }}
),

address as (
    select * from {{ source('raw_sakila', 'address') }}
),

city as (
    select * from {{ source('raw_sakila', 'city') }}
),

country as (
    select * from {{ source('raw_sakila', 'country') }}
)

select 
    {{ dbt_utils.generate_surrogate_key(['s.staff_id', 's.last_update']) }} as staff_skey,
    s.staff_id,
    s.first_name as staff_first_name,
    s.last_name as staff_last_name,
    a.address as staff_address,
    a.district as staff_district,
    a.postal_code as staff_postal_code,
    a.phone as staff_phone_number,
    c.city as staff_city,
    co.country as staff_country,
    s.email as staff_email,
    s.store_id,
    s.active as staff_active,
    s.last_update as staff_last_update
from staff s
join address a 
    on s.address_id = a.address_id
join city c 
    on a.city_id = c.city_id
join country co 
    on c.country_id = co.country_id