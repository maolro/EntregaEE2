

SELECT
    customer_skey,
    customer_id,
    customer_first_name,
    customer_last_name,
    customer_email,
    customer_active,
    customer_address,
    customer_district,
    customer_postal_code,
    customer_phone_number,
    customer_city,
    customer_country,
    customer_create_date,
    customer_last_update
FROM `adw09_stag`.`stg_customer`


WHERE customer_last_update > (SELECT max(customer_last_update) FROM `adw09_star`.`dim_customer`)
