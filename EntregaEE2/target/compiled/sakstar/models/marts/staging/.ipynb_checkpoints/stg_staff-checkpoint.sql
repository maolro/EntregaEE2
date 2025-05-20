

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
    from `sakila_dwh`.`staff`
),

address as (
    select * from `sakila_dwh`.`address`
),

city as (
    select * from `sakila_dwh`.`city`
),

country as (
    select * from `sakila_dwh`.`country`
)

select 
    lower(hex(MD5(toString(coalesce(cast(s.staff_id as String), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(s.last_update as String), '_dbt_utils_surrogate_key_null_') )))) as staff_skey,
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