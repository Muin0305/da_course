-- 1. Информация о сотрудниках и их менеджерах
select 
  e.employee_id, 
  e.first_name || ' ' || e.last_name as employee_name, 
  e.title, 
  e.reports_to, 
  (select m.first_name || ' ' || m.last_name || ', ' || m.title 
   from employee m 
   where m.employee_id = e.reports_to) as manager_info 
from employee e;

-- 2. Список чеков выше среднего за 2023 год
select 
  invoice_id, 
  invoice_date, 
  extract(YEAR from invoice_date) * 100 + extract(MONTH from invoice_date) as monthkey, 
  customer_id, 
  total 
from invoice 
where total > (select AVG(total) from invoices where extract(YEAR from invoice_date) = 2023);

-- 3. Дополнение информации email-ом клиента
select 
  i.invoice_id, 
  i.invoice_date, 
  i.monthkey, 
  i.customer_id, 
  i.total, 
  c.email 
from (
  select 
    invoice_id, 
    invoice_date, 
    extract(YEAR from invoice_date) * 100 + extract(MONTH from invoice_date) as monthkey, 
    customer_id, 
    total 
  from invoice 
  where total > (select AVG(total) from invoice where extract (YEAR from invoice_date) = 2023)
) i, 
customer c 
where i.customer_id = c.customer_id;

-- 4. Исключение клиентов с gmail
select * 
from (
  select 
    i.invoice_id, 
    i.invoice_date, 
    i.monthkey, 
    i.customer_id, 
    i.total, 
    c.email 
  from invoice i, customer c 
  where i.customer_id = c.customer_id 
    AND i.total > (select AVG(total) from invoice where extract (YEAR FROM invoice_date) = 2023)
) filtered 
where filtered.email NOT LIKE '%@gmail.com';

-- 5. Процент от выручки за 2024 год по чекам
select 
  invoice_id, 
  total, 
  (total * 100.0 / (select SUM(total) from invoice where extract (YEAR FROM invoice_date) = 2024)) as revenue_percentage 
from invoice
where extract (YEAR from invoice_date) = 2024;

-- 6. Процент от выручки за 2024 год по клиентам
select 
  customer_id, 
  SUM(total) as customer_total, 
  (SUM(total) * 100.0 / (select SUM(total) from invoice where extract (YEAR from invoice_date) = 2024)) as revenue_percentage 
from invoice 
where extract (YEAR from invoice_date) = 2024 
GROUP BY customer_id;


