
/* Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.*/

CREATE INDEX media_user_id_media_type_id_idx ON media(user_id, media_type_id);
CREATE INDEX users_first_name_last_name_idx ON users(first_name, last_name);
CREATE INDEX profiles_user_id_photo_id_idx ON profiles(user_id, photo_id);
CREATE INDEX profiles_user_id_hometown_idx ON profiles(user_id, hometown);
CREATE INDEX profiles_user_id_idx ON profiles(user_id);
CREATE INDEX post_user_id_id_idx ON post(user_id, id);
CREATE INDEX friendship_user_id_friend_id_status_id_idx ON friendship(user_id, friend_id,status_id);


show index from friendship from vk;

/*Построить запрос, который будет выводить следующие столбцы:
имя группы
среднее количество пользователей в группах
самый молодой пользователь в группе
самый пожилой пользователь в группе
общее количество пользователей в группе
всего пользователей в системе
отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100
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

/*выбрала первый джоин - обычный, т.к. не может быть сообщества без имени. А второй джоин - левый, т.к. в сообществе может не быть ни одного пользователя.*/

/*Задание 3*/

/* Мне видится, что от табилцы лайков можно избавиться, если у каждой сущености будет стоять в соответствующем столбце счетчик на количество лайков. 
 * Юзеров тоже можно разнести по таблицам, но это прям крайний случай, наверное. Все же таблицу юзеров лучше дерать до послденего.
 * По поводу правильности запроса - не могу ответить, т.к. в программировании нет одного правильного варианта решения. Всегда одну и ту же задачу можно
 * решить несоклькими путями*/



from communities_users
join profiles 
on communities_users.user_id = profiles.user_id 
window w as (partition by community)