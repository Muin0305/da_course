select *
from track 
where 
	composer = 'Queen';

select *
from track 
where
	name like 'K%' -- k in the beginning
;

select *
from track 
where
	name like '%K%'--  k in the middle
;

select *
from track
where 
	name like '%K' -- k at the end
;

select *
from track 
where 
	name ilike '%k%' -- doesn't depend on register
;

select *
from customer 
where last_name like '_%'
;

select *
from customer 
where last_name like 'K_hler' -- instead of none existing letters
--should be typed _
;

select 
	customer_id
	, country 
	, state 
	, city
	, country || ' ' || state || ' ' || city as address -- unified the address
	, concat (country, ' ', state, ' ', city) as address2 -- easily unified
	, concat_ws(' ', country, state, city) as address3 -- supereasy unification
from customer;

select 
	name
	, length (name) as title_len -- to find the number of letters
from track;

select 
	name
	, upper (name) as all_caps
	, lower (name) as all_lowers
	, initcap (name) as each_cap_
from track;

select 
	name
	, left (name, 3) as first3_letters
	, right (name, 2) as last2_symbols
	, substring (name, 2, 4) as middle_symbols
from track;

select  
	name
	, position ('n' in name) as n_ix
from track;

select replace ('AIAcademy', 'AI', 'Artificial Intelligence ');

select 
	name 
	, replace (name, 'Shark', 'baby shark')
from track;

select 
	employee_id
	, email
	, split_part(email, '@', 2) as domain_name -- to split text using a symbol
	-- we put 2 to print the second part 
from employee;

select 
	employee_id
	, email
	, split_part(email, '@', 2) as domain_name -- to split text using a symbol
	-- we put 2 to print the second part 
	, (string_to_array (email, '@')) [1] as email_arr -- to pick the first part
from employee;

select * 
from track;

select 
	name
	, regexp_substr (name, '\d{4}') as year_in_track_name -- those which have 4 digits
from track 
where
	regexp_like(name, '\d'); -- to find all track names that have digits 123456789
;

select *
from track 
where 
	regexp_like (name, '^S')
;

select *
from track 
where 
	regexp_like (name, 'm$')
;

select *
from track 
where 
	regexp_like (name, '^[^K]') -- doesn't start with k
;
from track 
where 
	regexp_like (name, '^[^K].*') -- doesn't start with k
;

select
	name 
	, regexp_substr (name, '\d{1,3}') 
from track 
;

-- РАБОТА С ДАТОЙ И ВРЕМЕНИ
select now ();

select localtimestamp;

select current_date;

select current_time, current_timestamp;

select 
	pg_typeof(current_date)
	, pg_typeof(localtimestamp)
	, pg_typeof(current_time)
;

select 
	employee_id
	, hire_date
	, localtimestamp - hire_date
	, age (localtimestamp, hire_date) as diff_in_years
	, extract ('year' from age ((localtimestamp, hire_date)) as years
from employee;

select 
	employee_id
	, hire_date
	, extract ('year' from hire_date) as hire_year
	, extract ('month' from hire_date) as hire_monthname
	, to_char (hire_date, 'month') as hire_monthname
	, to_char (hire_date, 'day') as hire_dayname
	, cast (to_char(hire_date, 'YYYYMM') as integer) as monthkey
	, to_char(hire_date, 'YYYYMM') :: integer as monthkey_int
from employee;

select 
	make_date (2020, 4, 12)
	, make_timestamp (2020, 4, 12, 16, 24, 3.23)
	, make_interval (days=>5)
;

select 
	localtimestamp
	, date_trunc('day', localtimestamp)
	, date_trunc('month', localtimestamp)
	, date_trunc('year', localtimestamp)
	, date_trunc('month', localtimestamp) - make_interval (days=-1)







