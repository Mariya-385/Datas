-- Урок 4
-- CRUD операции


-- Работа с БД vk
-- Загружаем дамп консольным клиентом
DROP DATABASE vk;
CREATE DATABASE vk;

-- Переходим в папку с дампом (/home/ubuntu)
-- mysql -u root -p vk < vk.dump.sql

-- Дорабатываем тестовые данные
SHOW TABLES;

-- users
-- Смотрим содержимое
SELECT * FROM users LIMIT 10;

-- Приводим в порядок даты
UPDATE users SET created_at = updated_at WHERE created_at > updated_at;

-- profiles
SELECT * FROM profiles LIMIT 10;

-- Выставляем значения пола при помощи использования временной таблицы
CREATE TEMPORARY TABLE sex (sex CHAR(1));
INSERT INTO sex VALUES ('m'), ('f');
UPDATE profiles SET sex = (SELECT sex FROM sex ORDER BY RAND() LIMIT 1);

-- Приводим в порядок даты
UPDATE profiles SET created_at = updated_at WHERE created_at > updated_at;

-- Проверяем медиафайлы
SELECT COUNT(*) FROM media;

-- Меняем ссылку на фотографию пользователя на случайное значение из диапазона 1 - 100
UPDATE profiles SET photo_id = FLOOR(1 + (RAND() * 100));


SHOW TABLES;


-- Проверяем сообщения
SELECT * FROM messages LIMIT 10;

-- Меняем отправителя и получателя сообщений
UPDATE messages SET
  from_user_id = FLOOR(1 + (RAND() * 100)),
  to_user_id = FLOOR(1 + (RAND() * 100))
;

-- Проверяем типы медиафайлов
SELECT * FROM media_types LIMIT 10;

-- Удаляем без обнуления значения идентификатора
DELETE FROM media_types;

-- Либо удаляем с обнулением значения идентификатора
TRUNCATE media_types;

-- Вставляем типы медиа
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;

-- Проверяем медиафайлы
SELECT * FROM media LIMIT 10;

-- Обновляем ссылки на типы
UPDATE media SET media_type_id = FLOOR(1 + (RAND() * 3));

-- Обновляем идентификаторы владельцев
UPDATE media SET user_id = FLOOR(1 + (RAND() * 100));

-- Улучшаем внешний вид ссылки на файл
UPDATE media SET filename = CONCAT('https://dropbox/vk/file_', size);

-- Дорабатываем метаданные    
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');   
   
DESC media;

-- Возвращаем правильный тип данных для метаданных   
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- Анализируем содержимое таблицы дружбы
SELECT * FROM friendship LIMIT 10;

-- Обновляем ссылки на ддрузей
UPDATE friendship SET
  user_id = FLOOR(1 + (RAND() * 100)),
  friend_id = FLOOR(1 + (RAND() * 100))
;

DESC friendship;

-- Проверяем статусы дружбы
SELECT * FROM friendship_statuses;

-- Очищаем статусы
TRUNCATE friendship_statuses;

-- Вставляем новые значения
INSERT INTO friendship_statuses (name)
  VALUES ('Requested'), ('Confirmed'), ('Rejected');
  
-- Обновляем ссылки на статусы в таблице дружбы  
UPDATE friendship SET status_id = FLOOR(1 + (RAND() * 2));  

-- Проверяем группы
SELECT * FROM communities;

-- Удаляем лишние группы
DELETE FROM communities WHERE id > 20;

-- Проверяем таблицу связи communities_users
SELECT * FROM communities_users LIMIT 10;

-- Обновляем значения идентификаторов для группы и членов групп
UPDATE communities_users SET
  community_id = FLOOR(1 + (RAND() * 10)),
  user_id = FLOOR(1 + (RAND() * 100))
;



-- Предложения по доработке структуры БД vk (только для ознакомления и анализа)

-- Вариант 1
-- По поводу улучшения таблицы ВК могу предложить связать таблицу профиль с 
-- таблицей юзерс по внешними ключу. Сейчас таблице профиль связана по
-- внешнему ключу только с фотографиями, а фотографии связаны уже с
-- пользователем. Мне кажется, что такая связь не удобна для написания сложных
-- запросов.

ALTER TABLE profiles ADD COLUMN user_id INT UNSIGNED NOT NULL UNIQUE FIRST;
UPDATE profiles SET user_id = FLOOR(1 + (RAND() * 100)); 


-- Вариант 2
-- Скрипты таблиц прикладываю ниже 
CREATE table post (
  id INT unsigned not null auto_increment primary key, 
  media_id INT unsigned, 
  user_id INT unsigned not null, 
  post mediumtext, 
  created_at datetime default Current_Timestamp, 
  updated_at datetime default Current_Timestamp on update Current_Timestamp
); 

CREATE table likes (
  id INT unsigned not null auto_increment primary key, 
  post_id INT unsigned, 
  user_id INT unsigned not null, 
  created_at datetime default Current_Timestamp, 
  updated_at datetime default Current_Timestamp on update Current_Timestamp
);

-- Применим для таблицы постов
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  media_id INT UNSIGNED, 
  user_id INT UNSIGNED not null,
  head VARCHAR(255), 
  body MEDIUMTEXT, 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
); 

-- Вариант 3
-- Я бы добавила к каждой таблице поле id c параметрами autoincrement и primary
-- key, чтобы каждая запись в табилце имела индивидуальный порядковый номер.

-- Вариант 4
-- Я бы добавила к таблице users, поля community_count/friends_count - которое
-- определяло бы текущее количество сообществ, в которых состоит пользователь
-- и его друзей, для того чтобы каждый раз при запросе данных об пользователе
-- не считать их общее количество из таблиц ( в вк в странице пользователя
-- показывается общее чилсо )

-- Вариант 5
-- В таблицу message добавила бы поле is_readed, определяющее прочитано ли
-- сообщение

-- Вариант 6
-- Ввести идентификатор в таблицу message, определяющий является ли сообщение
-- групповое ( один пользователь отправляет сообщение группе пользователей )

-- Добавим столбец
ALTER TABLE messages ADD COLUMN to_community_id INT UNSIGNED AFTER to_user_id;

-- Заполним данными
UPDATE messages 
  SET to_community_id = FLOOR(1 + (RAND() * 10))
  WHERE id > 50 AND id < 70; 

-- Вариант 7
-- Добавить информацию о группе ( статус группы - открытая или закрытая
-- /описание ) в таблице community

-- Добавим столбцы
ALTER TABLE communities ADD COLUMN is_open BOOLEAN;
ALTER TABLE communities ADD COLUMN description VARCHAR(255) AFTER name;

-- Если нужно удалить и пересоздать
ALTER TABLE communities DROP COLUMN description;

-- Заполняем данными
UPDATE communities SET is_open = TRUE WHERE id IN (2, 3, 5, 8, 9);
UPDATE communities SET description = (SELECT body 
    FROM messages WHERE messages.id = communities.id);



-- Замена первичного ключа в случае такой необходимости
CREATE INDEX id_pk_unique ON smsusers (id)
ALTER TABLE parent DROP PRIMARY KEY;
ALTER TABLE parent ADD PRIMARY KEY (userid);



-- Использование справки в терминальном клиенте
HELP SELECT;

-- Документация
-- https://dev.mysql.com/doc/refman/8.0/en/
-- http://www.rldp.ru/mysql/mysql80/index.htm

