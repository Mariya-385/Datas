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
