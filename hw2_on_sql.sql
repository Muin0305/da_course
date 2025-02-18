-- 1. дата самой первой и самой последней покупки
select min(invoice_date) as first_purchase, max(invoice_date) as last_purchase
from invoice;

-- 2. средний чек для покупок из сша
select avg(total) as average_check
from invoice
where billing_country = 'usa';

-- 3. список городов, где более одного клиента
select city
from customer
group by city
having count(customer_id) > 1;

-- 4. телефонные номера без скобок
select phone
from customer
where phone not like '%(%' and phone not like '%)%';

-- 5. преобразование текста 'lorem ipsum'
select initcap('lorem') || ' ' || lower('ipsum') as formatted_text;

-- 6. список песен, содержащих слово 'run'
select name
from track
where name ilike '%run%';

-- 7. список клиентов с почтовым ящиком в 'gmail'
select *
from customer
where email ilike '%@gmail.com';

-- 8. произведение с самым длинным названием
select name
from track
order by length(name) desc
limit 1;

-- 9. общая сумма продаж за 2021 год по месяцам
select 
    extract(month from invoice_date) as month_id,
    sum(total) as sales_sum
from invoice
where extract(year from invoice_date) = 2021
group by month_id
order by month_id;

-- 10. добавление названия месяца
select 
    extract(month from invoice_date) as month_id,
    to_char(invoice_date, 'month') as month_name,
    sum(total) as sales_sum
from invoice
where extract(year from invoice_date) = 2021
group by month_id, month_name
order by month_id;

-- 11. топ-3 самых возрастных сотрудников
select 
    first_name || ' ' || last_name as full_name,
    birth_date,
    extract(year from age(birth_date)) as age_now
from employee
order by birth_date
limit 3;

-- 12. средний возраст сотрудников через 3 года и 4 месяца
select 
    avg(extract(year from age(birth_date + interval '3 years 4 months'))) as avg_age_future
from employee;

-- 13. сумма продаж по годам и странам (отфильтровано по >20, сортировка по году и убыванию суммы)
select 
    extract(year from invoice_date) as sales_year,
    billing_country,
    sum(total) as sales_sum
from invoice
group by sales_year, billing_country
having sum(total) > 20
order by sales_year asc, sales_sum desc;
