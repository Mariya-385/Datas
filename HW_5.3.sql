/*¬ таблице складских запасов storehouses_products в поле value могут встречатьс€ самые разные цифры: 
 * 0, если товар закончилс€ и выше нул€, если на складе имеютс€ запасы. Ќеобходимо отсортировать записи таким образом, 
 * чтобы они выводились в пор€дке увеличени€ значени€ value. ќднако, нулевые запасы должны выводитьс€ в конце, после всех 
 * записей.*/

use shop;
drop table if exists storehouses_products_1;
CREATE TABLE storehouses_products_1 (
  id INT UNSIGNED,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT "«апас товарной позиции на складе",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = "«апасы на складе";

select * from storehouses_products_1 ;
insert storehouses_products_1 (value) values (0), (2500), (0), (30), (500), (1);

select value 
from 
storehouses_products_1 
order by value = 0, value;



