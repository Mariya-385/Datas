/*Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

use shop;
CREATE TABLE users_4 (
  id INT UNSIGNED,
  name VARCHAR(255) COMMENT "Имя покупателя",
  birthday_at DATE COMMENT "Дата рождения",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = "Покупатели";

select * from users_4;

insert into users_4 select * from users limit 9;
alter table users_4 add column days VARCHAR (35) after birthday_at ;
update users_4 set days = date_format (birthday_at, '%d.%m.2020');
alter table users_4 add column datas DATETIME after days;
update users_4 set datas = STR_TO_DATE (days, '%d.%m.%Y');
alter table users_4 add column weekdays varchar (20) after days;
update users_4 set weekdays = dayname(days) ;
select COUNT(name), weekdays from users_4 group by weekdays;



