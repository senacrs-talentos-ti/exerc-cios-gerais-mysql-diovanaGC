create database store;
use store;

create table Clients (
id int (3) primary key auto_increment,
name varchar (50) not null,
email varchar (50)
);

use store;

create table Products (
id int (3) primary key auto_increment,
name varchar (50) not null,
price decimal (5,2) not null
);

use store;

create table ORDERS (
id int (3) primary key auto_increment,
client_id int,
order_date date not null,
total decimal(5,2) not null,
foreign key (client_id) references Clients (id) 
);

use store;

create table Order_itens(
order_id int,
product_id int,
quantity int (3) not null,
price decimal(5,2) not null,
primary key(order_id, product_id),
foreign key (order_id) references Orders (id),
foreign key (product_id) references Products (id)
);

use store;

insert into clients (id, name, email) values
(default, "Aliza", "aliza@gmail.com"),
(default, "Baliza", "baliza@gmail.com"),
(default, "Caliza", "caliza@gmail.com"),
(default, "Daliza", "daliza@gmail.com"),
(default, "Eliza", "eliza@gmail.com"),
(default, "Fliza", "fliza@gmail.com"),
(default, "Galiza", "galiza@gmail.com"),
(default, "Haliza", "haliza@gmail.com"),
(default, "Iliza", "iliza@gmail.com"),
(default, "Jiza", "jiza@gmail.com");

use store;

insert into products (id, name, price) values
(default, "cordão_acetinado", 15.50),
(default, "fita100m", 19.00),
(default, "botões", 1.50),
(default, "agulha_trico", 15.50),
(default, "feltro", 25.00),
(default, "tnt", 2.00),
(default, "lã", 17.00),
(default, "elástico", 5.00);

use store;

insert into orders (id, client_id, order_date, total) values
(default, 1,'2024-07-12', 15.50),
(default, 3,'2024-07-10', 50.00),
(default, 6,'2024-07-12', 2.50),
(default, 1,'2024-06-1', 100.00),
(default, 2,'2024-06-12', 15.50),
(default, 4,'2024-06-5', 25.00),
(default, 1,'2024-06-1', 100.00),
(default, 4,'2024-05-5', 25.00);

use store;
select * from products;

insert into order_itens (order_id, product_id, quantity, price) values
(1, 5, 2, 25.00),
(2, 1, 10, 15.50);

insert into order_itens (order_id, product_id, quantity, price) values
(1, 1, 2, 15.50),
(2, 5, 10, 25.00),
(3, 8, 5, 5.00),
(4, 7, 5, 17.00),
(5, 3, 20, 1.50),
(6, 6, 10, 2.00);

use store;


update products set price = 15.00 where id = 1;
update order_itens set price = 15.00 where order_id = 1;

select * from products;
select * from order_itens;

use store;

select * from orders;


use store;

alter table clients add column birthdate date ;
select * from clients;

use store;

select clients.name as clients, orders.id as orders_id, order_itens.product_id, products.name as products
from clients
inner join orders on clients.id = orders.client_id
inner join order_itens on orders.id = order_itens.order_id
inner join products on order_itens.product_id = products.id;

use store;

select clients.name as clients, orders.id as orders_id, order_itens.product_id, products.name as products
from clients
left join orders on clients.id = orders.client_id
left join order_itens on orders.id = order_itens.order_id
left join products on order_itens.product_id = products.id;

use store;

select orders.id as orders_id, order_itens.product_id, products.name as products
from  orders 
right join order_itens on orders.id = order_itens.order_id
right join products on order_itens.product_id = products.id;

use store;

select sum(total) as total_vendas
from orders;

select sum(quantity) as total_vendas_item
from order_itens;

select sum(total) as total_vendas, sum(quantity) as total_vendas_item
from orders, order_itens
group by total,quantity;

use store;

select clients.name as cliente, clients.id, count(total) as total_pedidos
from clients
left JOIN orders
ON clients.id = orders.client_id
group by clients.id, orders.total
order by total_pedidos desc; 

use store;

select products.name as products, products.id, count(quantity) as quantity
from products
right JOIN order_itens
ON products.id = order_itens.product_id
group by products.id, order_itens.quantity
order by quantity desc; 

select products.name as products, products.id, count(quantity) as quantity
from products
right JOIN order_itens
ON products.id = order_itens.product_id
group by products.id, order_itens.quantity
order by quantity asc
limit 3; 

select clients.name as cliente, clients.id, count(total) as total_pedidos
from clients
right JOIN orders
ON clients.id = orders.client_id
group by clients.id, orders.total
order by total desc
limit 3; 

select clients.name as cliente, clients.id, sum(total) as total_pedidos
from clients
right JOIN orders
ON clients.id = orders.client_id
group by clients.id, orders.total
order by total desc
limit 3; 

select clients.name as cliente, clients.id, avg(quantity) as media_produtos, order_itens.order_id,products.id as products_id, products.name as products
from clients
inner join orders ON clients.id = orders.client_id
inner join order_itens on orders.id = order_itens.order_id
inner join products on order_itens.product_id = products.id
group by clients.id, orders.id, order_itens.order_id, products.id
order by media_produtos asc ;

use store;

select orders.order_date as months, count( orders.id) as total_orders, count(orders.client_id) as total_client   
from orders
group by orders.order_date
order by months;


use store;

select products.id, products.name as products, products.price, order_itens.product_id
from products
left join order_itens on products.id = order_itens.product_id
where order_itens.product_id is null;

use store;


select order_itens.order_id, orders.id, order_itens.product_id
from orders
inner join order_itens on orders.id = order_itens.order_id
group by order_itens.order_id, order_itens.product_id
having count( order_itens.product_id) > 2;


select clients.id, clients.name, avg(total) as values_order
from clients
inner join orders on clients.id = orders.client_id
group by clients.id, clients.name, orders.id
order by values_order desc;

use store;

select products.id, products.name, sum(quantity) as quantity_total
from products
right join order_itens on products.id = order_itens.product_id
group by products.id, order_itens.product_id
order by quantity_total desc;

