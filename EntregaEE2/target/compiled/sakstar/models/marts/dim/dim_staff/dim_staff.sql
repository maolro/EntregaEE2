

SELECT
    staff_skey,
    staff_id,
    staff_first_name,
    staff_last_name,
    staff_email,
    store_id,
    staff_active,
    staff_last_update
FROM `adw09_stag`.`stg_staff`


WHERE staff_last_update > (SELECT max(staff_last_update) FROM `adw09_star`.`dim_staff`)
