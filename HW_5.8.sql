/*Подсчитайте произведение чисел в столбце таблицы*/

use shop;
create table just_tbl (value INT UNSIGNED);
insert into just_tbl values (1), (2), (3), (4), (5);

select * from just_tbl;

select exp (SUM(log (value))) from just_tbl;



 

