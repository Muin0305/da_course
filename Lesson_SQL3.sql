create schema if not exists spotify;

create table if not exists users(
	user_id serial --integer unique not null auto_increment 
	, username varchar(20)
	, created_at timestamp 
	, deleted_at timestamp 
	, primary key (user_id)
);

drop table user;

set search_path to spotify;
create table if not exists users(
	user_id serial --integer unique not null auto_increment 
	, username varchar(20)
	, created_at timestamp 
	, deleted_at timestamp 
	, primary key (user_id)
);

create table if not exists tracks ( 
	track_id serial
	, track_name text not null
	, composer text
	, added_at timestamp default localtimestamp
	, duration integer
	, size_in_bytes integer
	, primary key (track_id)
);

create table playlist (
	user_id integer not null
	, track_id integer not null
	, foreign key (user_id) references users(user_id) on delete cascade
	, foreign key (track_id) references tracks(track_id) on delete cascade
	)
	;
insert into users(username, created_at)
values 
	('user1', '2025-01-01')
	, ('user2', '2025-02-03')
	, ('user3', '2025-01-04');

select *
from users
;

insert into users (username, created_at)
select 
	first_name as username
	, hire_date as created_at
from public.employee;

select *
from users
;

create table invoice_subset as
select *
from public.invoice
limit 10
;

select *
from invoice_subset;

alter table invoice_subset
rename to inv_subset;

select *
from inv_subset;

alter table inv_subset
 add column inv_year integer;

update inv_subset
set inv_year = extract ('year' from invoice_date);

select *
from inv_subset;

update inv_subset
set total = 20
where
	invoice_id = 1;
	


select *
from inv_subset;

update inv_subset
set total = total * 10
where
	billing_country in ('USA', 'Canada');

select *
from inv_subset;

delete from inv_subset
where 
	billing_country = 'France';

truncate table inv_subset;

create index track_name_ix on tracks (track_name);
create index username_ix on users (username);

select *
from users 
where
	username like '%cy';

set search_path to public;

select current_schema;

select *
from track;

create view v_track as
select 
	track_id
	, name as track_name
	, round (milliseconds / 60000., 2) as duration_in_min
	, round (bytes /(1024.*1024), 2) as sixe_in_mb
from track;

select *
from v_track;






