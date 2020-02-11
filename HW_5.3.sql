/*� ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 
 * 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, 
 * ����� ��� ���������� � ������� ���������� �������� value. ������, ������� ������ ������ ���������� � �����, ����� ���� 
 * �������.*/

use shop;
drop table if exists storehouses_products_1;
CREATE TABLE storehouses_products_1 (
  id INT UNSIGNED,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT "����� �������� ������� �� ������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = "������ �� ������";

select * from storehouses_products_1 ;
insert storehouses_products_1 (value) values (0), (2500), (0), (30), (500), (1);

select value 
from 
storehouses_products_1 
order by value = 0, value;



