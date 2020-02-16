/*ѕодсчитать общее количество лайков, которые получили 10 самых молодых пользователей.*/

-- готово

select count(*) as like_s 
from likes where target_id IN (select user_id from profiles where birthdate >='2017-01-01' );


/*ќпределить кто больше поставил лайков (всего) - мужчины или женщины?*/

-- таблица дл€ понимани€ праивльного результата:
alter table likes add column sex VARCHAR (1) not null after user_id;
update likes set sex = (select sex from profiles where profiles.user_id = likes.user_id);
select COUNT(*) as likes, sex from likes group by sex;

-- решение:
select COUNT(*) as likes, (select sex from profiles where profiles.user_id = likes.user_id) as sex
from likes 
group by sex;


-- найти 10 наименее активных пользователей
-- наименее активный - тот, у кого меньше всего постов
select * from post;
select count(*) as posts, user_id from post group by user_id order by posts limit 10;