CREATE TABLE adw09_star.dim_date (
  date_key Int64,
  date_actual Date,
  epoch Float64,
  day_suffix String,
  day_name String,
  day_of_week Int64,
  day_of_month Int64,
  day_of_quarter Int64,
  day_of_year Int64,
  week_of_month Int64,
  week_of_year Int64,
  week_of_year_iso String,
  month_actual Int64,
  month_name String,
  month_name_abbreviated String,
  quarter_actual Int64,
  quarter_name String,
  year_actual Int64,
  first_day_of_week Date,
  last_day_of_week Date,
  first_day_of_month Date,
  last_day_of_month Date,
  first_day_of_quarter Date,
  last_day_of_quarter Date,
  first_day_of_year Date,
  last_day_of_year Date,
  mmyyyy Int64,
  mmddyyyy Int64,
  weekend_indr Bool
) ENGINE = MergeTree()
ORDER BY date_key;
INSERT INTO adw09_star.dim_date
SELECT *
FROM s3(
  'https://izar.ls.fi.upm.es:30009/sakstar/dim_date.csv',
  'YA9JokyWUb2hFUbKYEEN',
  '0k2ornkQpVTqUrBbOEsEXOnBEEWgJf4AFQOU4O7Y',
  'CSVWithNames'
);
