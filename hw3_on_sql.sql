-- Сиддиков Мухин
/*
Создайте новую схему store и активируйте её.
В новой схеме создайте таблицу customers со следующими полями:
customer_id - id клиента; основной ключ таблицы
customer_name - имя клиента; не может быть больше 50 символов; не может быть пустым
email - имейл клиента; не может быть больше 260 символов
address - адрес клиента; может содержать любое количество символов
Заполните таблицу данными из таблицы customer датасета chinook. При этом, значения для поля customer_name должны быть составлены из полей first_name и last_name исходной таблицы. А значения для поля address должно быть составлено из полей country, state, city и address исходной таблицы. В качестве делимитера между значениями должен использовать пробел.
Создайте таблицу products со следующими полями:
product_id - id продукта; основной ключ таблицы
product_name - название продукта; не может содержать больше 100 символов; но может быть пустым
price -цена продукта; не может быть пустым
Заполните таблицу списком следующих товаров:
Ноутбук Lenovo Thinkpad; 12000
Мышь для компьютера, беспроводная; 90
Подставка для ноутбука; 300
Шнур электрический для ПК; 160
Создайте таблицу sales, со следующими полями:
sale_id - id продажи; основной ключ таблицы
sale_timestamp - время продажи; не может быть пустым; по умолчанию равно текущей дате и времени
customer_id - id клиента; не может быть пустым; является внешним ключём, ссылающимся на поле customer_id таблицы customers
product_id - id продукта; не может быть пустым; является внешним ключём, ссылающимся на поле product_id таблицы products
quantity - количество проданного товара; не может быть пустым; по умолчанию равно единице
Заполните таблицу следующими данными:
customer_id	product_id	quantity
3	4	1
56	2	3
11	2	1
31	2	1
24	2	3
27	2	1
37	3	2
35	1	2
21	1	2
31	2	2
15	1	1
29	2	1
12	2	1
Добавьте столбец discount в таблицу sales и установите его значение равным 0.2 для всех строк где product_id равен 1
Создайте представление v_usa_customers, которое возвращает список всех клиентов из США
*/

create schema if not exists store;

set search_path to store; 

create table if not exists customers (
	customer_id serial primary key
	, customer_name varchar(50) not null 
	, email varchar(260) 
	, address text
);
 select *
 from customers
;
insert into store.customers (customer_name, email, address)
select 
	first_name || ' ' || last_name as customer_name
	, email
	, country || ' ' || coalesce (state, '') || ' ' || city || ' ' || address as address
from public.customer;

create table products (
	product_id serial primary key
	, product_name varchar(100) 
	, price numeric not null
);
 select *
 from products
;
insert into products (product_name, price)
values 
	('Ноутбук Lenovo Thinkpad', 12000)
	 , ('Мышь для компьютера, беспроводная', 90)
	 , ('Подставка для ноутбука', 300)
	 , ('Шнур электрический для ПК', 160);

select *
from products
;	

create table sales (
	sale_id serial primary key
	, sale_timestamp timestamp not null default current_timestamp
	, customer_id int not null
	, product_id int not null
	, quantity int not null default 1
	, foreign key (customer_id) references store.customers(customer_id)
	, foreign key (product_id) references store.products(product_id)
);

select *
from sales;

insert into sales (customer_id, product_id, quantity)	
values
	(3,	4,	1)
	, (56,	2,	3)
	, (11,	2,	1)
	, (31,	2,	1)
	, (24,	2,	3)
	, (27,	2,	1)
	, (37,	3,	2)
	, (35,	1,	2)
	, (21,	1,	2)
	, (31,	2,	2)
	, (15,	1,	1)
	, (29,	2,	1)
	, (12,	2,	1)
;
	
alter table sales
add column discount numeric default 0;

update sales
set 
	discount = 0.2
where 
	product_id = 1;

create view v_usa_customers AS
select customer_id, customer_name, email, address
from store.customers
where address LIKE '%USA%';

select *
from sales;
	
	



