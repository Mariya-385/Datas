/*����������� ������� ������� ������������� � ������� users*/

DROP TABLE IF EXISTS users_3;
CREATE TABLE users_3 (
  id INT UNSIGNED,
  name VARCHAR(255) COMMENT "��� ����������",
  birthday_at DATE COMMENT "���� ��������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = "����������";

truncate users_3; 
insert into users_3 select * from users u2 limit 9;

select*from users_3;

update users_3 set age = round (to_days (Now()) - to_days(birthday_at))/365;
select AVG (age) from users_3;








