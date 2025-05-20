

with rental as (
    select *
    from `sakila_dwh`.`rental`
),

inventory as (
    select *
    from `sakila_dwh`.`inventory`
),

staff as (
    select *
    from `sakila_dwh`.`staff`
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
    lower(hex(MD5(toString(coalesce(cast(r.rental_id as String), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(r.last_update as String), '_dbt_utils_surrogate_key_null_') )))) as rental_skey
from `sakila_dwh`.`rental` r
join `sakila_dwh`.`inventory` i on r.inventory_id = i.inventory_id
join `sakila_dwh`.`staff` s on r.staff_id = s.staff_id