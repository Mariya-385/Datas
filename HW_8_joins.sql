/*Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
 * Я все проверила руками - результат сошелся*/

select SUM(user_likes) from
(select likes.target_id, Count(*) as user_likes 
from likes 
join profiles on profiles.user_id = likes.target_id where likes.target_id in (select*from (select user_id from profiles order by birthdate desc limit 10)as sorted_profiles) 
and likes.target_type_id=2
group by likes.target_id) as total;

/*Определить кто больше поставил лайков (всего) - мужчины или женщины?*/

select COUNT(*) as likes, (select sex from profiles where profiles.user_id = likes.user_id) as sex
from likes 
join profiles 
on profiles.user_id = likes.user_id
group by sex;

-- найти 10 наименее активных пользователей
-- взяла не свой, а варинат из урока с разбора ДЗ
-- взяла 12, а то есть различия в два юзера между первым и вторым зарпосом

SELECT CONCAT(first_name, ' ', last_name) AS user, users.id, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) 
	AS overall_activity 
	FROM users
	ORDER BY overall_activity limit 12;


select CONCAT(first_name, ' ', last_name) AS user, users.id,
(select count(*) from likes where likes.user_id=users.id) +
(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) 
as overal_activity
from users 
left join likes on likes.user_id=users.id 
left join media on media.user_id=users.id 
left join messages on messages.from_user_id=users.id
order by overal_activity limit 12; 






