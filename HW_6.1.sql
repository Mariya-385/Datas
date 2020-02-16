/*�������� ����������� �� ����������� ������� �������� ������������ �������. ������, 
���� ��������� ����, �� ����� �������� ����, ���� �����, �� �����. � ������, � ��������� 
������ ���� ���� ���� �� �� ������ �����������. �� ��� ��� ������� �� sql � ���� �� ����*/

SELECT CONCAT('������������ ', 
(SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = media.user_id),
' ������� ', (select  
Case 
    when media_type_id = 1 then '����'
    when media_type_id = 2 then '�����'
    when media_type_id = 3 then '�����'
End
from media_types limit 1), filename, ' ', created_at) AS news 
FROM media WHERE user_id = 1 
AND media_type_id = (SELECT id FROM media_types WHERE name LIKE 'audio');