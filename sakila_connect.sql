CREATE DATABASE sakila_dwh ENGINE = MySQL('mariadb:3306', 'sakila', 'maolro', 'mysql_pwd') SETTINGS read_write_timeout = 10000, connect_timeout = 100;
