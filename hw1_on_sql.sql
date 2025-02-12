/*
 Сиддиков Муин
*/



/*
2. Напишите код, который вернёт из таблицы track поля name и genre_id
*/
select  
	name, 
	genre_id 
from track;

/*
3. Напишите код, который вернёт из таблицы track поля name, composer, unit_price. 
Переименуйте поля на song, author и price соответственно. Расположите поля так, чтобы сначало следовало название произведения, 
далее его цена и в конце список авторов.
*/
select
	name as song,
	unit_price as price,
	composer as author
from track;


/*
4. Напишите код, который вернёт из таблицы track название произведения и его длительность в минутах. 
Результат должен быть отсортирован по длительности произведения по убыванию.
*/
select
	name,
	round (milliseconds/60000., 2) as duration_in_minute
from track
order by
	 milliseconds desc
;
	

/*
5. Напишите код, который вернёт из таблицы track поля name и genre_id, и только первые 15 строк.
*/
select 
	name,
	genre_id
from track 
limit 15;

/*
6. Напишите код, который вернёт из таблицы track все поля и все строки начиная с 50-й строки. 
*/
select *
from track 
offset 49;

/*
7. Напишите код, который вернёт из таблицы track названия всех произведений, чей объём больше 100 мегабайт (подсказка: 1mb=1048576 bytes).
*/
select 
	name
from track
where
	bytes > 104857600;

/*
8. Напишите код, который вернёт из таблицы track поля name и composer, где composer не равен "U2". 
Код должен вернуть записи с 10 по 20-й включительно.
*/
select 
	name,
	composer
from track
where
	composer != 'U2'
limit 11
offset 9;




