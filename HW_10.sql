
/* ���������������� ����� ������� ����� ����������� �������� ����� � �������� ������ ���������� � �������� ����������� �������.*/

CREATE INDEX media_user_id_media_type_id_idx ON media(user_id, media_type_id);
CREATE INDEX users_first_name_last_name_idx ON users(first_name, last_name);
CREATE INDEX profiles_user_id_photo_id_idx ON profiles(user_id, photo_id);
CREATE INDEX profiles_user_id_hometown_idx ON profiles(user_id, hometown);
CREATE INDEX profiles_user_id_idx ON profiles(user_id);
CREATE INDEX post_user_id_id_idx ON post(user_id, id);
CREATE INDEX friendship_user_id_friend_id_status_id_idx ON friendship(user_id, friend_id,status_id);


show index from friendship from vk;

/*��������� ������, ������� ����� �������� ��������� �������:
��� ������
������� ���������� ������������� � �������
����� ������� ������������ � ������
����� ������� ������������ � ������
����� ���������� ������������� � ������
����� ������������� � �������
��������� � ��������� (����� ���������� ������������� � ������ / ����� ������������� � �������) * 100
 */

select distinct communities.id, communities.name,  
(select (select count(distinct (communities_users.user_id)) from communities_users)/(select count(distinct (communities.id)) from communities)) as aver,
COUNT(communities_users.user_id) over asd as total_users_in_community,
COUNT(communities_users.user_id) over () as total_users,
FIRST_VALUE(profiles.user_id) over bd as oldest_user,
first_value (profiles.user_id) over bd_desc as youngest_user,
COUNT(communities_users.user_id) over asd  / COUNT(communities_users.user_id) over () *100 as '%' 
from (communities 
join communities_users on communities_users.community_id = communities.id
left join profiles on communities_users.user_id = profiles.user_id)
window asd as (partition by communities.id),
bd as (partition by communities.id order by profiles.birthdate),
bd_desc as (partition by communities.id order by profiles.birthdate DESC);

/*������� ������ ����� - �������, �.�. �� ����� ���� ���������� ��� �����. � ������ ����� - �����, �.�. � ���������� ����� �� ���� �� ������ ������������.*/

/*������� 3*/

/* ��� �������, ��� �� ������� ������ ����� ����������, ���� � ������ ��������� ����� ������ � ��������������� ������� ������� �� ���������� ������. 
 * ������ ���� ����� �������� �� ��������, �� ��� ���� ������� ������, ��������. ��� �� ������� ������ ����� ������ �� ����������.
 * �� ������ ������������ ������� - �� ���� ��������, �.�. � ���������������� ��� ������ ����������� �������� �������. ������ ���� � �� �� ������ �����
 * ������ ����������� ������*/



from communities_users
join profiles 
on communities_users.user_id = profiles.user_id 
window w as (partition by community)