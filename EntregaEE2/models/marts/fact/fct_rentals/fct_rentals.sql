{{ config(
    materialized='incremental',
    unique_key='rental_id',
    schema=var('schema_star')
) }}

with stg_rentals as (
    select
        rental_id,
        customer_id,
        film_id,
        staff_id,
        rental_date,
        count_rentals,
        rental_duration
    from {{ ref('stg_rentals') }}
    {% if is_incremental() %}
    where rental_date > (select max(rental_date) from {{ this }})
    {% endif %}
),

dim_customer as (
    select customer_id, customer_skey
    from {{ ref('dim_customer') }}
),

dim_film as (
    select film_id, film_skey
    from {{ ref('dim_film') }}
),

dim_staff as (
    select staff_id, staff_skey, store_id
    from {{ ref('dim_staff') }}
),

dim_store as (
    select store_id, store_skey
    from {{ ref('dim_store') }}
),

dim_date as (
    select date_actual, date_key
    from {{ source('adw09_star', 'dim_date') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['stg_rentals.rental_id']) }} as rental_skey,
    dim_customer.customer_skey,
    dim_film.film_skey,
    dim_staff.staff_skey,
    dim_store.store_skey,
    dim_date.date_key,
    stg_rentals.rental_id,
    stg_rentals.count_rentals,
    stg_rentals.rental_duration
from stg_rentals
left join dim_customer
    on stg_rentals.customer_id = dim_customer.customer_id
left join dim_film
    on stg_rentals.film_id = dim_film.film_id
left join dim_staff
    on stg_rentals.staff_id = dim_staff.staff_id
LEFT JOIN dim_store 
    ON dim_staff.store_id = dim_store.store_id
left join dim_date
    on cast(stg_rentals.rental_date as date) = dim_date.date_actual
