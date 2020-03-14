create database airbnb;

use airbnb;

drop table users;

create table users (
id int unsigned not null primary key,
first_name varchar (100) not null,
last_name varchar (100) not null,
email varchar (150) unique,
`password` varchar (18),
is_host boolean,
birthdate date,
sex char (1) not null,
city varchar (100) not null,
country_id int unsigned not null,
photo_id int unsigned,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


create table profiles_guests (
guest_id int unsigned not null primary key,
profile_confirmation boolean
);


create table profiles_hosts (
host_id int unsigned not null primary key,
apartment_id int unsigned not null,
overall_rating int unsigned,
reviews_views_quantity int unsigned,
earnings_month int unsigned,
views_quantity int unsigned,
response_rate int unsigned,
profile_confirmation boolean,
is_superhost boolean
);


create table apartments(
id int unsigned not null primary key,
host_id int unsigned not null,
price int not null,
apartment_name varchar (50) not null,
country_id int unsigned not null,
city varchar (100) not null,
apartment_photo_id int unsigned not null,
apartment_type int unsigned not null,
accommodation_type int unsigned not null,
description text not null,
apartment_rating int unsigned,
apartment_status_confirmation int unsigned not null,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);



create table reviews (
id int unsigned not null primary key,
user_id int unsigned not null,
target_type_id int unsigned not null,
target_id int unsigned,
rating int unsigned not null,
review_text text not null,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


create table target_types (
id int unsigned not null primary key,
name varchar (20) not null
);


create table countries(
id int unsigned not null primary key,
country_name varchar (100) not null
);


create table messages (
id int unsigned not null primary key, 
from_user_id int unsigned not null,
to_user_id int unsigned not null,
body text not null,
is_delivered boolean,
is_readed boolean,
created_at DATETIME DEFAULT NOW()
);


create table confirmation_statuses (
id int unsigned not null primary key,
name varchar (30) not null unique
);


create table guests_favorits_aparts (
id int unsigned not null primary key,
guest_id int unsigned not null,
apartment_id int unsigned not null,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

create table apartments_guests (
guest_id int unsigned not null,
apartment_id int unsigned not null
);


create table photos_users_apartments (
id int unsigned not null primary key,
target_type_id int unsigned,
target_id int unsigned,
filename varchar (255) not null,
size int not null,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


create table apartment_types (
id int unsigned not null primary key,
name varchar (30) not null
);

create table accommodation_types (
id int unsigned not null primary key,
name varchar (30) not null
);

insert into target_types (id, name) values
(1, 'User'), 
(2, 'Apartment');

insert into confirmation_statuses (id, name) values
(1, 'Confirmed'), 
(2, 'Rejected'),
(3, 'Waiting');

insert into apartment_types (id, name) values
(1, '��������'), 
(2, '���'),
(3, '����� ��� ����/��������'),
(4, '���������� �����'), 
(5, 'B&B'),
(6, '�����-�����'),
(7, '������������'), 
(8, '����'),
(9, '�����������');

insert into accommodation_types (id, name) values
(1, '����� �������'), 
(2, '��������� �������'),
(3, '����� � �������');


alter table users add constraint users_country_id_fk foreign key (country_id) references countries(id) on delete no action;
alter table users add constraint users_photo_id_fk foreign key (photo_id) references photos_users_apartments(id) on delete no action;
alter table profiles_guests add constraint profiles_guests_guest_id_fk foreign key (guest_id) references users(id) on delete cascade;
alter table profiles_hosts add constraint profiles_hosts_host_id_fk foreign key (host_id) references users(id) on delete cascade;
alter table profiles_hosts add constraint profiles_hosts_apartment_id_fk foreign key (apartment_id) references apartments(id) on delete cascade;
alter table apartments add constraint apartments_host_id_fk foreign key (host_id) references users(id) on delete cascade;
alter table apartments add constraint apartments_country_id_fk foreign key (country_id) references countries(id) on delete no action;
alter table apartments add constraint apartments_photo_id_fk foreign key (apartment_photo_id) references photos_users_apartments(id) on delete no action;
alter table apartments add constraint apartments_apartment_type_fk foreign key (apartment_type) references apartment_types (id) on delete no action;
alter table apartments add constraint apartments_accommodation_type_fk foreign key (accommodation_type) references accommodation_types (id) on delete no action;
alter table apartments add constraint apartments_apartment_status_confirmation_fk foreign key (apartment_status_confirmation) references confirmation_statuses (id)on delete no action;
alter table reviews add constraint reviews_user_id_fk foreign key (user_id) references users (id) on delete cascade;
alter table reviews add constraint reviews_target_type_id_fk foreign key (target_type_id) references target_types (id) on delete no action;
alter table messages add constraint messages_from_user_id_fk foreign key (from_user_id) references users (id) on delete cascade;
alter table messages add constraint messages_to_user_id_fk foreign key (to_user_id) references users (id) on delete cascade;
alter table guests_favorits_aparts add constraint guests_favorits_aparts_guest_id_fk foreign key (guest_id) references users (id) on delete cascade;
alter table guests_favorits_aparts add constraint guests_favorits_aparts_apartment_id_fk foreign key (apartment_id) references apartments (id) on delete cascade;
alter table apartments_guests add constraint apartments_guests_guest_id_fk foreign key (guest_id) references users (id) on delete cascade;
alter table apartments_guests add constraint apartments_guests_apartment_id_fk foreign key (apartment_id) references apartments (id) on delete cascade;
alter table photos_users_apartments add constraint photos_users_apartments_target_type_id_fk foreign key (target_type_id) references target_types(id) on delete no action;


create index users_id_is_host_idx on users (id, is_host);
create index profiles_hosts_host_id_is_superhost_idx on profiles_hosts (host_id, is_superhost);
create index profiles_hosts_host_id_apartment_id_idx on profiles_hosts (host_id, apartment_id);
create index apartments_country_id_city_price_id_idx on apartments (country_id, city, price, id);
create index apartments_id_apartment_photo_id_idx on apartments (id, apartment_photo_id);
create index reviews_target_type_id_target_id_rating_idx on reviews (target_type_id, target_id, rating);
create index photos_users_apartments_target_type_id_target_id on photos_users_apartments (target_type_id, target_id);
create index apartments_apartment_type_id on apartments (apartment_type, id);
create index apartments_accommodation_type_id on apartments (accommodation_type, id);
create index apartments_apartment_status_confirmation_id_idx on apartments (apartment_status_confirmation, id);


/* ��������� ���������� ������������ � ������ �� ����� */

select distinct countries.country_name, 
count(apartments.id) over (partition by apartments.country_id) as total_aparts
from (countries
left join 
apartments on countries.id = apartments.country_id)
order by total_aparts DESC
;

/*��������� ������� ������� �� ������� ��� 10 ����� ������� ������������*/

select target_id as apartment_id, AVG(rating) as av_rate 
from reviews 
where target_type_id=2 and target_id in (select * from (select id from apartments order by price desc limit 10) as max_price_aparts)
group by target_id;



/* ��������� ������ super_host. ����������: ������� ������� �� ������������ ����� ������� 4,8; ������� ������� - 90 */


select profiles_hosts.host_id, apartments.id as apatment_id,
AVG (reviews.rating) as average_apartment_rate
from (profiles_hosts
left join apartments on apartments.id=profiles_hosts.apartment_id
join reviews on apartments.id = reviews.target_id and reviews.target_type_id=2) 
where profiles_hosts.response_rate >=90
group by profiles_hosts.host_id 
having average_apartment_rate >=4.8;

/* �������� �������. �� ����� ������ ���������� id ������*/

create function get_country_id (country_name varchar(100))
returns int reads sql data
begin
	set @country_name = country_name;
	set @id = (select id from countries where countries.country_name = @country_name);
return @id;
end/
 

/*���������, ����������� ����� ������������ � �������� ������*/


create procedure search_apts_by_country (in country_name varchar (30))
begin
	create temporary table aparts_ids (
	id_s int
	);
	set country_name = country_name;
	set @id = (select get_country_id (country_name));
	insert into aparts_ids (id_s) 
	(select id from apartments where apartments.country_id = @id);
	select*from aparts_ids;
end//



/* ������� ����������� ������������ ������� null �������� � ������� price, apartment_type � accomodation_type */

create trigger not_null before insert on apartments
for each row 
begin 
	if new.price is null and new.apartment_type is null and new.accommodation_type is null then 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled. Need price, apartment_type and accommodation_type'; 
	else
		begin
			set new.price = new.price;
			set new.apartment_type = new.apartment_type;
			set new.accommodation_type = new.accommodation_type;
		end;
end if;
end/




/* ������������� ��� ������ id �����������, ������ � ������ ������������ �����������, ���� ��� ������� ��� �����������*/

create view apt_contries_cities (apart_id, country_name, city) as 
select apartments.id, countries.country_name, apartments.city from apartments join countries on apartments.country_id = countries.id;
select * from apt_contries_cities;

/* ������������� ��� ������ ������ ��������������� ������������, ������ �������� ����� � ������� ��� ������ �������*/

create view confirmed_houses_all (apart_id, host_id) as 
select id, host_id from apartments where apartment_type = 2 and accommodation_type = 1 and apartment_status_confirmation =1;











