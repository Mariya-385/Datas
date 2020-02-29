create function hello ()
RETURNS varchar(30) deterministic
begin
	set @value = DATE_FORMAT(NOW(), '%H:%i');
		if @value between '06:00' and '12:00' then
		set @hello = '������ ����';
		elseif @value between '12:00' and '18:00' then
		set @hello = '������ ����';
		elseif @value between '18:00' and '00:00' then
		set @hello = '������ �����';
		else 
		set @hello = '������ ����';
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

--���������� �������������, ��� �����-�� ������ � ������� ��� ����. ������ ��� ���� ���� name not null, ���� description not null (�� �� ��������� ��� ����������).
-- �������������, ��������� ������� is NULL � ����� �������� ��� ������. �����, ��� update �� ����� ������ ������ ���� ���������� �������. ������������, ���� ������ name �� null
-- �� ������� ������ ���, ���� ��� ����, ���� ��� - ������� ������ ����������. �� �������, � ��� ������ ���� �������� ���� �� ���� �������. ������ ������, �� � ���� ������ 
-- ������� ��� � ��������� �������. ���� ���� ��� �����������, ����� ��������� ��� ���� ���� ����� ��� � ����� ���� �� �� �����, ����� ������ name �� description.
create trigger if_null_update before update on products
for each row 
begin 
			declare prod_name varchar (255);
			SELECT name INTO prod_name FROM products ORDER BY id LIMIT 1;
  			SET NEW.name = COALESCE(NEW.name, old.name, prod_name);
end// 