/*Задача №1
Посчитайте количество клиентов, закреплённых за каждым сотрудником 
(подсказка: в таблице customer есть поле support_rep_id, которое хранит employee_id сотрудника, за которым закреплён клиент). 
Итоговая таблица должна содержать следующие поля: id сотрудника, полное имя, количество клиентов.
Добавьте к получившейся таблице поле, показывающее какой процент от общей клиентской базы обслуживает каждый сотрудник.
*/
with customer_count as (
    select 
        e.employee_id,
        e.first_name || ' ' || e.last_name as full_name,
        count(c.customer_id) as client_count
    from employee e
    left join customer c on e.employee_id = c.support_rep_id
    group by e.employee_id, full_name
),
total_clients as (
    select count(*) as total from customer
)
select 
    customer_count.employee_id,
    customer_count.full_name,
    customer_count.client_count,
    round((customer_count.client_count * 100.0 / total_clients.total), 2) as client_percentage
from customer_count
join total_clients on true
order by customer_count.client_count desc;

/*
Задача №2
Верните список альбомов, треки из которых вообще не продавались. Итоговая таблица должна содержать следующие поля: 
название альбома, имя исполнителя.
*/
select 
	a.title as album_name
	, ar.name as artist_name
from album a
join artist ar on a.artist_id = ar.artist_id 
left join track t on a.album_id = t.album_id
left join invoice_line il on t.track_id = il.track_id 
where il.track_id is null;

/*
Задача №3
Выведите список сотрудников у которых нет подчинённых.
*/
select
	e.employee_id
	, e.first_name || ' ' || e.last_name as full_name
from employee e
left join employee m on e.employee_id = m.reports_to 
where m.employee_id is null;

/*
Задача №4
Верните список треков, которые продавались как в США так и в Канаде. Итоговая таблица должна содержать следующие поля: 
id трека, название трека.
*/
SELECT DISTINCT
    t.track_id,
    t.name AS track_name
FROM track t
JOIN invoice_line il ON t.track_id = il.track_id
JOIN invoice i ON il.invoice_id = i.invoice_id
WHERE i.billing_country = 'USA'
AND t.track_id IN (
    SELECT t2.track_id
    FROM track t2
    JOIN invoice_line il2 ON t2.track_id = il2.track_id
    JOIN invoice i2 ON il2.invoice_id = i2.invoice_id
    WHERE i2.billing_country = 'Canada'
);
select distinct 
	t.track_id
	, t.name as track_name
from track t
join invoice_line il on t.track_id = il.track_id 
join invoice i on il.invoice_id = i.invoice_id 
where i.billing_country = 'USA'
and t.track_id in (
	select t2.track_id
	from track t2
	join invoice_line il2 on t2.track_id = il2.track_id 
	join invoice i2 on il2.invoice_id = i2.invoice_id 
	where i2.billing_country = 'Canada'
);
/*
Задача №5
Верните список треков, которые продавались в Канаде, но не продавались в США. Итоговая таблица должна содержать следующие поля: 
id трека, название трека.
*/
select distinct 
	t.track_id
	, t.name as track_name
from track t
join invoice_line il on t.track_id = il.track_id 
join invoice i on il.invoice_id = i.invoice_id 
where i.billing_country = 'Canada'
and t.track_id not in (
	select t2.track_id
	from track t2
	join invoice_line il2 on t2.track_id = il2.track_id 
	join invoice i2 on il2.invoice_id = i2.invoice_id 
	where i2.billing_country = 'USA'
);