/*В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
Используйте транзакции.*/
create database sample;
use sample;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT "Имя покупателя",
  birthday_at DATE COMMENT "Дата рождения",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = "Покупатели";


start transaction;
select shop.users.id from shop.users where shop.users.id=1;
savepoint checking_value;
insert into 
  sample.users
select
  *
from 
  shop.users
where shop.users.id=1; 
commit;

/*Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs*/

use shop;

CREATE OR REPLACE VIEW prod_cat as 
select products.name as products_name, catalogs.name as catalog_name from products
join catalogs 
on products.catalog_id = catalogs.id;

select * from prod_cat;



