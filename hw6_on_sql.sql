-- задача 1: сумма продаж по годам и месяцам с доп. расчетами
with sales_by_month as (
    select
        c.customer_id,
        c.first_name || ' ' || c.last_name as full_name,
        extract(year from i.invoice_date) as year,
        extract(month from i.invoice_date) as monthkey,
        sum(i.total) as total
    from invoice i
    join customer c on i.customer_id = c.customer_id
    group by c.customer_id, c.first_name, c.last_name, year, monthkey
),
monthly_totals as (
    select
        year,
        monthkey,
        sum(total) as monthly_total
    from sales_by_month
    group by year, monthkey
),
cumulative_sales as (
    select
        s.customer_id,
        s.full_name,
        s.year,
        s.monthkey,
        s.total,
        s.total / m.monthly_total * 100 as percentage_of_monthly_total,
        sum(s.total) over (partition by s.customer_id, s.year order by s.monthkey) as cumulative_total,
        avg(s.total) over (partition by s.customer_id order by s.year, s.monthkey rows between 2 preceding and current row) as moving_avg,
        s.total - lag(s.total) over (partition by s.customer_id order by s.year, s.monthkey) as period_difference
    from sales_by_month s
    join monthly_totals m on s.year = m.year and s.monthkey = m.monthkey
)
select * from cumulative_sales;


-- Топ-3 продаваемых альбома за каждый год
with album_sales as (
    select
        extract(year from i.invoice_date) as year,
        a.title as album_name,
        ar.name as artist_name,
        count(il.track_id) as track_sales
    from invoice i
    join invoice_line il on i.invoice_id = il.invoice_id
    join track t on il.track_id = t.track_id
    join album a on t.album_id = a.album_id
    join artist ar on a.artist_id = ar.artist_id
    group by year, album_name, artist_name
),
ranked_albums as (
    select
        year,
        album_name,
        artist_name,
        track_sales,
        rank() over (partition by year order by track_sales desc) as rank
    from album_sales
)
select year, album_name, artist_name, track_sales
from ranked_albums
where rank <= 3;


-- задача 3: количество клиентов на сотрудника и их процент от общего числа клиентов
with employee_clients as (
    select
        e.employee_id,
        e.first_name || ' ' || e.last_name as full_name,
        count(c.customer_id) as client_count
    from employee e
    left join customer c on e.employee_id = c.support_rep_id
    group by e.employee_id, e.first_name, e.last_name
),
total_clients as (
    select count(customer_id) as total_client_count from customer
)
select
    ec.employee_id,
    ec.full_name,
    ec.client_count,
    (ec.client_count * 100.0 / tc.total_client_count) as client_percentage
from employee_clients ec
cross join total_clients tc;



-- задача 4: первая и последняя покупка клиента и разница между ними
select
    c.customer_id,
    c.first_name || ' ' || c.last_name as full_name,
    min(i.invoice_date) as first_purchase_date,
    max(i.invoice_date) as last_purchase_date,
    extract(year from age(max(i.invoice_date), min(i.invoice_date))) as years_between_purchases
from customer c
join invoice i on c.customer_id = i.customer_id
group by c.customer_id, full_name;
