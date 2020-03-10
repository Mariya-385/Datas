create table logs (
table_name varchar (30),
id INT unsigned not null,
name_string varchar (255),
created_at datetime DEFAULT CURRENT_TIMESTAMP
)  ENGINE=ARCHIVE DEFAULT CHARSET=utf8;

select*from catalogs;



create trigger users_insert after insert on shop.users 
FOR EACH row
begin
	insert into logs (table_name, id, name_string) values
	('users', new.id, new.name);
end //

create trigger catalogs_insert after insert on shop.catalogs
FOR EACH row
begin
	insert into logs (table_name, id, name_string) values
	('catalogs', new.id, new.name);
end //

create trigger products_insert after insert on shop.products 
FOR EACH row
begin
	insert into logs (table_name, id, name_string) values
	('products', new.id, new.name);
end //
