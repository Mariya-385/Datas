/*� ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. 
����������� ����������.*/
create database sample;
use sample;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT "��� ����������",
  birthday_at DATE COMMENT "���� ��������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = "����������";


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

/*�������� �������������, ������� ������� �������� name �������� ������� �� ������� products � ��������������� �������� �������� name �� ������� catalogs*/

use shop;

CREATE OR REPLACE VIEW prod_cat as 
select products.name as products_name, catalogs.name as catalog_name from products
join catalogs 
on products.catalog_id = catalogs.id;

select * from prod_cat;



