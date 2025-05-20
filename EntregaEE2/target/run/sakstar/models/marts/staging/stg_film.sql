

  create or replace view `adw09_stag`.`stg_film` 
  
    
    
  as (
    

with film_category as (
    select
        film_id,
        category_id,
        last_update as category_last_update
    from `sakila_dwh`.`film_category`
),

category as (
    select
        category_id, 
        name as category_name
    from `sakila_dwh`.`category`
),

language as (
    select
        language_id,
        name as language_name,
        last_update
    from `sakila_dwh`.`language`
),

film as (
    select
        film_id,
        title as film_title,
        description as film_description,
        release_year as film_release_year,
        language_id,
        original_language_id,
        rental_duration,
        rental_rate,
        length as film_duration,
        replacement_cost as film_replacement_cost,
        rating as film_rating,
        special_features as film_special_features,
        last_update as film_last_update
    from `sakila_dwh`.`film`
)

select
    lower(hex(MD5(toString(coalesce(cast(f.film_id as String), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(f.film_last_update as String), '_dbt_utils_surrogate_key_null_') )))) as film_skey, 
    f.film_id as film_id,
    f.film_title,
    f.film_description,
    f.film_release_year,
    l.language_name as film_language,
    ol.language_name as film_original_language,
    f.rental_duration as film_rental_duration,
    f.rental_rate as film_rental_rate,
    f.film_duration,
    f.film_replacement_cost,
    f.film_rating,
    f.film_special_features,
    c.category_name as film_category_name,
    f.film_last_update
from film f
join language l
    on f.language_id = l.language_id
join language ol
    on f.original_language_id = ol.language_id
join film_category fc
    on f.film_id = fc.film_id
join category c
    on fc.category_id = c.category_id
    
  )
      
      
                    -- end_of_sql
                    
                    