-- однострочный комментарий

/*
Многострочный 
комментарий
*/

select -- для чтения файла, по правилам нужно писать большими буквами
	track_id, 
	name, 
	composer,
	album_id -- запитую можно написать и в начале например , album_id
from track; -- обязательно надо поставить точка запятио, чтобы понять о завершении кода

select 9/3;

select 9/4.; -- чтобы получить полный ответ с числами после дроба, нужно поставить точку после цифра

select
	name as track_name -- можно поменять название таблицы
	, round(milliseconds / 60000., 2) as duration_in_minute -- чтобы создать новую таблицу и дать её значения
from track
-- мы округлили через раунд

select *
from track
order by -- сортировка через одну группу
	name desc -- через desc можно обратно фильтровать, без desc обчний фильтр
;
select *
from track 
order by
	name desc -- можно сортировать через две группы
	, track_id -- sorting here isn't by desc
;

select *
from track
limit 10 -- чтобы поставить ограничение, то есть лимит строк

select *
from track 
order by 
	track_id desc
limit 10

select *
from track 
limit 10 
offset 10 -- чтобы получить то что после 10

*/
порядок обработки команд со сторонҷ СУБД:
1 from
2 select
3 offset
4 limit
*/

select *
from track
where 
	album_id = 3 -- id который равны трём (3)
;
select *
from track
where 
	album_id != 3 -- id который неравны трём (3)
;

select *
from track 
where
	composer = 'Queen' -- фильтр по словам
;

select *
from track 
where
	composer = 'Queen'
	or composer = 'U2'
	or composer = 'AC/DC'
;

select *
from track 
where
	composer in ('Queen', 'AC/DC', 'Pink Floyd')
;

select *
from track 
where
	composer = 'Queen'
	and bytes > 9000000
;

select *
from track 
where
	composer = 'Queen'
	or composer = 'AC/DC'
order by -- ордер байт идёт после всего
	bytes
;

select *
from track 
where 
	bytes > 9000000
	and (composer = 'Queen' -- тут будет не правильно, потому что байтс должен быть в конце
	or composer = 'AC/DC') -- ПОЭТОМУ НУЖНО СКОБКИ
;

select *
from track 
where 
	composer is null -- выводим все пустые значения
;

select *
from track 
where 
	composer is not null -- выводим все непустые значения
	
select *
from track
;
select 
	max (total),
	min (total)
from invoice;

select 
	country
from customer
;





	


