/*��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.*/

select * from products;
select * from catalogs;


select id from users where id in (select user_id from orders);

/*�������� ������ ������� products � �������� catalogs, ������� ������������� ������.*/
select name as Products, (select name from catalogs where catalogs.id = products.catalog_id) as Category
from products;

/*(�� �������) ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). 
���� from, to � label �������� ���������� �������� �������, ���� name � �������. �������� ������ ������ flights � �������� ���������� �������.*/


create database aero;

use aero;
create table flights (
id INT not null,
from_city VARCHAR (50) not null,
to_city VARCHAR (50) not null
);

create table cities (
label VARCHAR (50) not null,
name VARCHAR (50) not null
);

insert into flights (id,from_city,to_city) values
(1, 'moscow', 'omsk'),
(2, 'novgorod', 'kazan'),
(3, 'irkutsk', 'moscow'),
(4, 'omsk', 'irkutsk'),
(5, 'moscow', 'kazan');

insert into cities (label, name) values
('moscow', '������'),
('irkutsk', '�������'),
('novgorod', '��������'),
('kazan', '������'),
('omsk', '����');


select * from cities;

select id, (select name from cities where flights.from_city =cities.label) as Departure, (select name from cities where flights.to_city =cities.label) as Arrival
from flights;




