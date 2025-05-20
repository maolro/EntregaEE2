{{ config(
    materialized='view',
    schema=var('schema_stag')
) }}

with rental as (
    select *
    from {{ source('raw_sakila', 'rental') }}
),

inventory as (
    select *
    from {{ source('raw_sakila', 'inventory') }}
),

staff as (
    select *
    from {{ source('raw_sakila', 'staff') }}
)

select
    r.rental_id,
    r.customer_id,
    i.film_id,
    r.staff_id as staff_id,               
    s.store_id as store_id,  
    r.rental_date,
    r.return_date,
    1 as count_rentals,
    datediff(day, r.rental_date, r.return_date) as rental_duration,
    {{ dbt_utils.generate_surrogate_key(['r.rental_id', 'r.last_update']) }} as rental_skey
from {{ source('raw_sakila', 'rental') }} r
join {{ source('raw_sakila', 'inventory') }} i on r.inventory_id = i.inventory_id
join {{ source('raw_sakila', 'staff') }} s on r.staff_id = s.staff_id
