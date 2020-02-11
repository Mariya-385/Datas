/*Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и 
 * в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME,
 *  сохранив введеные ранее значения.*/

use shop;
CREATE TABLE users_2 (
  id INT UNSIGNED,
  name VARCHAR(255) COMMENT "Имя покупателя",
  birthday_at DATE COMMENT "Дата рождения",
  created_at varchar (25),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = "Покупатели";

select * from users_2;
desc users_2;

truncate users_2; 
insert into users_2 (created_at) values ('20.10.2017 8:10');
update users_2 set created_at = STR_TO_DATE (created_at, '%d.%m.%Y %h:%i');