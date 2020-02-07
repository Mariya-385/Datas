drop table if exists users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(15) NOT NULL UNIQUE,
  `password` VARCHAR(15),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

drop table if exists profiles;
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  birthdate DATE,
  sex CHAR(1) NOT NULL,
  hometown VARCHAR(100),
  country VARCHAR(100),
  photo_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

drop table if exists messages;
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  is_important BOOLEAN,
  is_delivered BOOLEAN,
  created_at DATETIME DEFAULT NOW()
);

drop table if exists friendship;
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL,
  friend_id INT UNSIGNED NOT NULL,
  status_id INT UNSIGNED NOT NULL,
  requested_at DATETIME DEFAULT NOW(),
  confirmed_at DATETIME,
  PRIMARY KEY (user_id, friend_id)
);

drop table if exists friendship_statuses;
CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);


drop table if exists communities;
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);

drop table if exists communities_users;
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (community_id, user_id)
);

drop table if exists media;
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  media_type_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  filename VARCHAR(255) NOT NULL,
  size INT NOT NULL,
  metadata JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

drop table if exists media_types;
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);



UPDATE users SET created_at = updated_at WHERE created_at > updated_at;


CREATE TEMPORARY TABLE sex (sex CHAR(1));
INSERT INTO sex VALUES ('m'), ('f');
UPDATE profiles SET sex = (SELECT sex FROM sex ORDER BY RAND() LIMIT 1);

select * from profiles;

select photo_id from profiles p;
UPDATE profiles SET photo_id = FLOOR(1 + (RAND() * 100));

SELECT * FROM messages;
UPDATE messages SET
  from_user_id = FLOOR(1 + (RAND() * 100)),
  to_user_id = FLOOR(1 + (RAND() * 100))
  where from_user_id = to_user_id;

SELECT * FROM messages where from_user_id = to_user_id ; 
 
UPDATE messages SET created_at = updated_at WHERE created_at > updated_at;
TRUNCATE media_types;

INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;

UPDATE media SET media_type_id = FLOOR(1 + (RAND() * 3));
SELECT * FROM media;

UPDATE media SET user_id = FLOOR(1 + (RAND() * 100));
UPDATE media SET filename = CONCAT('https://dropbox/vk/file_', size);
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');
UPDATE media SET size = FLOOR(1 + (RAND() * 100)) where size=0;
 
 

ALTER TABLE media MODIFY COLUMN metadata JSON;

DESC media;

SELECT * FROM friendship where user_id = friend_id ;

UPDATE friendship SET
  user_id = FLOOR(1 + (RAND() * 100)),
  friend_id = FLOOR(1 + (RAND() * 100))
;


TRUNCATE friendship_statuses;

INSERT INTO friendship_statuses (name)
  VALUES ('Requested'), ('Confirmed'), ('Rejected');
  
SELECT * FROM friendship;
UPDATE friendship SET status_id = FLOOR(1 + (RAND() * 3));

update friendship set requested_at = confirmed_at where requested_at > confirmed_at; 

DELETE FROM communities WHERE id > 20;

SELECT * FROM communities_users cu ;
update communities_users set user_id = FLOOR(1 + (RAND() * 100)) where user_id >100;
update communities_users set community_id = FLOOR(1 + (RAND() * 100));

UPDATE communities_users SET
  community_id = FLOOR(1 + (RAND() * 10)),
  user_id = FLOOR(1 + (RAND() * 100))
;

ALTER TABLE messages ADD COLUMN to_community_id INT UNSIGNED AFTER to_user_id;
UPDATE messages 
  SET to_community_id = FLOOR(1 + (RAND() * 20))
  WHERE id >50 and id <70; 
 UPDATE messages 
  SET to_community_id = 0
  WHERE id <50;
select *from messages;

ALTER TABLE communities ADD COLUMN is_open BOOLEAN;
ALTER TABLE communities ADD COLUMN description VARCHAR(255) AFTER name;

UPDATE communities SET is_open = TRUE WHERE id IN (2, 3, 5, 7, 8, 9);
UPDATE communities SET is_open = false where is_open is null;

ALTER TABLE communities ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE communities ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP;

select * from communities;
UPDATE communities SET description = (SELECT first_name FROM users WHERE id = communities.id);


CREATE table post (
  id INT unsigned not null auto_increment primary key, 
  media_id INT unsigned, 
  user_id INT unsigned not null, 
  post mediumtext, 
  created_at datetime default Current_Timestamp, 
  updated_at datetime default Current_Timestamp on update Current_Timestamp
); 

select * from post;
UPDATE post SET created_at = updated_at WHERE created_at > updated_at;



CREATE table likes (
  id INT unsigned not null auto_increment primary key, 
  post_id INT unsigned, 
  user_id INT unsigned not null, 
  created_at datetime default Current_Timestamp, 
  updated_at datetime default Current_Timestamp on update Current_Timestamp
);

UPDATE likes SET created_at = updated_at WHERE created_at > updated_at;
alter table likes drop column liked_object;
alter table likes add column liked_object varchar (25) not null after user_id; 
CREATE TEMPORARY TABLE objects_types (types varchar (20));
INSERT INTO objects_types VALUES ('profile'), ('message'), ('post'), ('photo'), ('media');
UPDATE likes SET liked_object = (SELECT types FROM objects_types ORDER BY RAND() LIMIT 1);
alter table likes add column object_id INT not null after liked_object; 
update likes set object_id = (SELECT id FROM messages ORDER BY RAND() LIMIT 1) where liked_object = 'message';
update likes set object_id = (SELECT id FROM post ORDER BY RAND() LIMIT 1) where liked_object = 'post';
update likes set object_id = (SELECT id FROM profiles ORDER BY RAND() LIMIT 1) where liked_object = 'profile';
update likes set object_id = (SELECT photo_id FROM profiles ORDER BY RAND() LIMIT 1) where liked_object = 'profile';
update likes set object_id = (SELECT id FROM media ORDER BY RAND() LIMIT 1) where liked_object = 'media';

