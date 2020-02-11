/*�� ������� users ���������� ������� �������������, ���������� � ������� � ���. 
 ������ ������ � ���� ������ ���������� �������� ('may', 'august')*/

use shop;
CREATE TABLE users_5 (
  id INT UNSIGNED,
  name VARCHAR(255) COMMENT "��� ����������",
  birthday_at DATE COMMENT "���� ��������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = "����������";

select * from users_5;


insert into users_5 select * from users limit 9;
alter table users_5 add column month_b VARCHAR (20) after birthday_at;
update users_5 set month_b = MONTHNAME (birthday_at);
select name from users_5 where month_b in ('May','August');
