-- ## Window Functions — 10 Practice Questions
-- ### 🟢 Basic
-- 1. **Find the rank of each employee based on salary across the company.**
-- 2. **Find the salary rank of each employee within their department.**
-- 3. **Display each employee's salary along with the average salary of their department.**
-- ### 🟡 Intermediate
-- 4. **Find the highest-paid employee(s) in each department.**
-- 5. **For each employee, show their salary and the previous employee's salary when ordered by salary.**
-- 6. **For each customer, show every order along with their previous order amount.**
-- 7. **Calculate the running total of sales for each customer ordered by order date.**
-- ### 🔴 Advanced
-- 8. **Find the top 3 highest-paid employees in each department.**
-- 9. **For each product, calculate its sales along with its percentage contribution to the total sales.**
-- 10. **Calculate a 3-order moving average of sales for each customer using a window frame.**

-- 1. **Find the rank of each employee based on salary across the company.**
select 
	employee_name,
    salary,
    dense_rank() over(order by salary desc) as rnk
from employees;

-- 2. **Find the salary rank of each employee within their department.**
select 
	e.employee_name,
    e.salary,
    d.department_name,
    dense_rank() over(
		partition by d.department_name
		order by e.salary desc) as rnk
from employees e
join departments d
on e.department_id = d.department_id;

-- 3. **Display each employee's salary along with the average salary of their department.**
select 
	e.employee_name,
    e.salary,
    d.department_name,
    avg(e.salary) over(
		partition by d.department_name
		) as dept_avg_salary
from employees e
join departments d
on e.department_id = d.department_id
;

-- 4. **Find the highest-paid employee(s) in each department.**
with dept_ranked_emp as (
select 
	e.employee_name,
    e.salary,
    d.department_name,
    dense_rank() over(
		partition by d.department_name
        order by e.salary desc
		) as rnk
from employees e
join departments d
on e.department_id = d.department_id)

select * from dept_ranked_emp where rnk = 1;
;

-- 5. **For each employee, show their salary and the previous employee's salary when ordered by salary.**

select 
	employee_name,
    salary,
    lag(salary, 1, 0) over(order by salary desc) as prev_sal
from employees;

-- 6. **For each customer, show every order along with their previous order amount.**
with cust_every_ord as (
select 
	c.customer_name,
    o.order_id,
    o.order_date,
    sum(oi.quantity * p.price) as amount
from orders o

join customers c 
on o.customer_id = c.customer_id

join order_items oi
on o.order_id = oi.order_id

join products p 
on oi.product_id = p.product_id
group by 
c.customer_name,
    o.order_id,
    o.order_date)

select 
	customer_name,
    order_id,
    order_date,
    amount,
    lag(amount) over(partition by customer_name order by order_date) as prev_ord
from cust_every_ord
;

-- 7. **Calculate the running total of sales for each customer ordered by order date.**
with total_sales as (
select 
	c.customer_name,
    o.order_id,
    o.order_date,
    sum(oi.quantity * p.price) as total
from orders o

join customers c 
on o.customer_id = c.customer_id

join order_items oi
on o.order_id = oi.order_id

join products p
on oi.product_id = p.product_id
group by c.customer_name,
    o.order_id,
    o.order_date)

select 
	customer_name,
    order_id,
    order_date,
    total,
    sum(total) over(partition by customer_name order by order_date) as running_total
from total_sales;

-- 8. **Find the top 3 highest-paid employees in each department.**
with highest_paid_emp as (
select 
	e.employee_name,
    e.salary,
    d.department_name,
    dense_rank() over(
		partition by d.department_name
        order by e.salary desc
    ) as rnk
from employees e

join departments d
on e.department_id = d.department_id)

select 
	employee_name,
    salary,
    department_name
from highest_paid_emp
where rnk <= 3;



-- 10. **Calculate a 3-order moving average of sales for each customer using a window frame.**
with total_sales_2 as (
select 
	c.customer_name,
    o.order_id,
    o.order_date,
    sum(oi.quantity * p.price) as total
from orders o

join customers c 
on o.customer_id = c.customer_id

join order_items oi
on o.order_id = oi.order_id

join products p
on oi.product_id = p.product_id
group by c.customer_name,
    o.order_id,
    o.order_date)

select
	customer_name,
    order_id,
    order_date,
    total,
    avg(total) over(
		partition by customer_name
        order by order_date
        rows between 2 preceding and current row
    ) as mv_avg
from total_sales_2;

