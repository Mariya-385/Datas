/*����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.
*/

use shop;
CREATE TABLE users_1 (
  id INT UNSIGNED,
  name VARCHAR(255) COMMENT "��� ����������",
  birthday_at DATE COMMENT "���� ��������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = "����������";


select * from users_1 ;

insert into
users_1 
select
*
from 
users;

update users_1 set created_at = NOW();
update users_1 set updated_at = NOW();
