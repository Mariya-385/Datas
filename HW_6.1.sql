/*добавила возможность не прописывать словами название добавленного объекта. Теперь, 
если добавлено фото, то будет напсиано фото, если видео, то видео. В идеале, в последней 
строке кода тоже надо бы не руками прописывать. Но как это сделать на sql я пока не знаю*/

SELECT CONCAT('Пользователь ', 
(SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = media.user_id),
' Добавил ', (select  
Case 
    when media_type_id = 1 then 'фото'
    when media_type_id = 2 then 'видео'
    when media_type_id = 3 then 'аудио'
End
from media_types limit 1), filename, ' ', created_at) AS news 
FROM media WHERE user_id = 1 
AND media_type_id = (SELECT id FROM media_types WHERE name LIKE 'audio');