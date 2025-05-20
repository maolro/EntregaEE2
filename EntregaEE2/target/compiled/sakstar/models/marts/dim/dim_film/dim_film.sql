

SELECT
    film_skey,
    film_id,
    film_title,
    film_description,
    film_release_year,
    film_language,
    film_original_language,
    film_rental_duration,
    film_rental_rate,
    film_duration,
    film_replacement_cost,
    film_rating,
    film_special_features,
    film_category_name,
    film_last_update
FROM `adw09_stag`.`stg_film`


WHERE film_last_update > (SELECT max(film_last_update) FROM `adw09_star`.`dim_film`)
