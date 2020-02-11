/*������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � 
 * � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10". ���������� ������������� ���� � ���� DATETIME,
 *  �������� �������� ����� ��������.*/

use shop;
CREATE TABLE users_2 (
  id INT UNSIGNED,
  name VARCHAR(255) COMMENT "��� ����������",
  birthday_at DATE COMMENT "���� ��������",
  created_at varchar (25),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = "����������";

select * from users_2;
desc users_2;

truncate users_2; 
insert into users_2 (created_at) values ('20.10.2017 8:10');
update users_2 set created_at = STR_TO_DATE (created_at, '%d.%m.%Y %h:%i');