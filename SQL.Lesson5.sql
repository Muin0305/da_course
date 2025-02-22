/*
Очередь выполнения
1. from
2. join
3. where 
4. group by
5. having
6. select
7. offset
8. limit
*/
create table tr1 as 
select
  track_id
  , name
from track
limit 5;


create table tr2 as
select
  track_id
  , name
from track
limit 5
offset 2;

select *
from tr1
union all
select *
from tr2;

select *
from tr1
union
select *
from tr2;

select * 
from tr1;
select * from tr2;

update tr2
set name = 'APT'
where 
  track_id =4;
select *
from tr1
union
select *
from tr2
order by 
track_id;

select *
from tr1
intersect
select *
from tr2;

select *
from tr1
except 
select *
from tr2;

-- джойны

select *
from tr1
  left join tr2 on tr1.track_id = tr2.track_id;
select *
from tr1
	right join tr2
		on tr1.track_id = tr2.track_id;


select 
	t.track_id 
	, t.name 
	, g.name as genre_name
from track t, genre g
where 
	t.genre_id = g.genre_id 
;

select 
	i.customer_id
	, concat_ws(' ', c.first_name, c.last_name) as full_name
	, i.total
from invoice i
	left join customer c
		on i.customer_id = c.customer_id;

update tr2
 set track_id=3
 where   name='APT';
 select*
 from tr2;
 
 
 update tr2
 set track_id=7
 where   track_id = 7;
select *
from tr1
	left join tr2
		on tr1.track_id = tr2.track_id;

select
	e1.employee_id 
	, e1.last_name 
	, count(e2.employee_id) as subordinates_cnt
from employee e1
	left join employee e2
		on e1.employee_id = e2.reports_to 
group by 
	e1.employee_id
	, e1.last_name
order by
	e1.employee_id;

--- anti join
select 
	t.track_id
	, t.name
	, t.unit_price
	, i1.track_id
from track t
	left join invoice_line i1
		on t.track_id = i1.track_id 
where 
	i1.track_id is null;



select 
	t.track_id
	, t.name
from track t
where
	t.track_id in (
		select track_id
		from invoice_line
	)
;

--- semi join
select 
	t.track_id
	, t.name
from track t
where 
	exists (
		select 1
		from invoice_line i1
		where 
			i1.track_id = t.track_id
	)
;

--- cross join 








