

SELECT
    store_skey,
    store_id,
    store_address,
    store_district,
    store_postal_code,
    store_phone_number,
    store_city,
    store_country,
    store_manager_staff_id,
    store_manager_first_name,
    store_manager_last_name,
    store_last_update
FROM `adw09_stag`.`stg_store`


WHERE store_last_update > (SELECT max(store_last_update) FROM `adw09_star`.`dim_store`)
