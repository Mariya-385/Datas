create function hello ()
RETURNS varchar(30) deterministic
begin
	set @value = DATE_FORMAT(NOW(), '%H:%i');
		if @value between '06:00' and '12:00' then
		set @hello = 'Доброе утро';
		elseif @value between '12:00' and '18:00' then
		set @hello = 'Добрый день';
		elseif @value between '18:00' and '00:00' then
		set @hello = 'Добрый вечер';
		else 
		set @hello = 'Доброй ночи';
		end if;
	return @hello;
end//



create trigger if_null BEFORE INSERT ON products
FOR EACH row
begin
		if new.name is null and new.description is null then 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled'; 
		else
			begin
				declare prod_name varchar (255);
				SELECT name INTO prod_name FROM products ORDER BY id LIMIT 1;
  				SET NEW.name = COALESCE(NEW.name, prod_name);
			end;
	end if;
end// 

--Обновление подразумевает, что какие-то записи в строках уже есть. Значит там есть либо name not null, либо description not null (тк мы триггером это обеспечили).
-- Следовательно, проверять условие is NULL у обоих столбцов нет смысла. Далее, при update мы можем менять только один конкретный столбец. Следовтельно, если меняем name на null
-- то встанет старое имя, если оно есть, если нет - триггер внесет коррективы. По условию, у нас должен быть заполнен хотя бы один столбец. ТАкимо бразом, мы в люом случае 
-- получем имя и выполняем условие. Если надо два обязательно, тогда добавляем еще один блок бегин энд и пишем туда то же самое, меняя просто name на description.
create trigger if_null_update before update on products
for each row 
begin 
			declare prod_name varchar (255);
			SELECT name INTO prod_name FROM products ORDER BY id LIMIT 1;
  			SET NEW.name = COALESCE(NEW.name, old.name, prod_name);
end// 