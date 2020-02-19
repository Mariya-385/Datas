select * from users;
select * from orders;
select * from products p ;
select * from catalogs;

select user_id,orders.user_id from users u join orders on u.id = orders.user_id; 
select p.name, catalogs.name from products p join catalogs on p.catalog_id =catalogs.id;