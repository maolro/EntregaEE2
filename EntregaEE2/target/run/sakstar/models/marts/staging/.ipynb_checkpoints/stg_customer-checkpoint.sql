

  create or replace view `adw09_star_adw09_stag`.`stg_customer-checkpoint` 
  
    
    
  as (
    

with customers as (
    select
        customer_id,
        store_id,
        first_name as customer_first_name,
        last_name as customer_last_name,
        address_id,
        email as customer_email,
        active as customer_active,
        create_date as customer_create_date,
        last_update as customer_last_update
    from `sakila_dwh`.`customer`
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
    lower(hex(MD5(toString(coalesce(cast(sc.customer_id as String), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(sc.customer_last_update as String), '_dbt_utils_surrogate_key_null_') )))) as customer_skey,
    sc.customer_id,
    sc.customer_first_name,
    sc.customer_last_name,
    sc.customer_email,
    sc.customer_active,
    sa.address as customer_address,
    sa.district as customer_district,
    sa.postal_code as customer_postal_code,
    sa.phone as customer_phone_number,
    scty.city as customer_city,
    sctr.country as customer_country,
    sc.customer_create_date,
    sc.customer_last_update
from customers sc
join address sa
    on sc.address_id = sa.address_id
join city scty
    on sa.city_id = scty.city_id
join country sctr
    on scty.country_id = sctr.country_id
    
  )
      
      
                    -- end_of_sql
                    
                    