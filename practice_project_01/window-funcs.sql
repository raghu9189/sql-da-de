use practice_project_02;

-- Calculate the running total of sales amount ordered by sale date.
select 
	sale_id,
    sale_date,
    sales_amount,
	sum(sales_amount) over(order by sale_date asc, sale_id asc 
		rows between 
		unbounded 
        preceding and 
        current row)
        as running_total
from sales;

-- Calculate the running average of sales amount ordered by sale_date.
select 
	sale_id,
    sale_date,
    sales_amount,
	avg(sales_amount) over(order by sale_date asc, sale_id asc
		rows between unbounded preceding and current row) as running_average
from sales;
-- Calculate the running count of sales transactions ordered by sale_date.
select 
	sale_id,
	sale_date,
	count(sale_id) over(order by sale_date asc, sale_id asc
		rows between unbounded preceding and current row) as running_count
from sales;

-- For each sale, display the previous sale's sales amount, ordered by sale_date.
select 
	sale_id,
	sale_date,
	sales_amount,
    lag(sales_amount) over(order by sale_date, sale_id ) as previous_sales_amount
from sales;

-- For each sale, display the next sale's sales amount, ordered by sale_date.
select 
	sale_id,
	sale_date,
	sales_amount,
    lead(sales_amount, 1) over(order by sale_date, sale_id ) as next_sales_amount
from sales;

-- For each sale, display the sales amount from 2 rows before the current sale.
select 
	sale_id,
	sale_date,
	sales_amount,
    lag(sales_amount, 2) over(order by sale_date, sale_id ) as sales_2_rows_before
from sales;

-- For each sale, display the sales amount from 2 rows after the current sale.
select 
	sale_id,
	sale_date,
	sales_amount,
    lead(sales_amount, 2) over(order by sale_date, sale_id ) as sales_2_rows_after
from sales;

-- Problem
-- The customers table contains multiple records for the same customer because their information was updated over time.
-- Find the latest record for each customer based on updated_at.
select 
	customer_id,
    customer_name,
    email,
    city,
    updated_at 
from
(select 
	*,
    row_number() over(partition by customer_id order by updated_at desc) as uniq_num
from customers) as t
where uniq_num = 1;
-- Find the first record for each customer based on updated_at.
select 
	customer_id,
    customer_name,
    email,
    city,
    updated_at 
from
(select 
	*,
    row_number() over(partition by customer_id order by updated_at asc) as uniq_num
from customers) as t
where uniq_num = 1;

-- Find the last record for each customer based on updated_at.
select 
	customer_id,
    customer_name,
    email,
    city,
    updated_at 
from
(select 
	*,
    row_number() over(partition by customer_id order by updated_at desc) as uniq_num
from customers) as t
where uniq_num = 1;

-- Find the top 2 highest-paid employees in each department.
select 
	department,
    employee_name,
    salary, rnk
from (
select 
    *,
    dense_rank() over(partition by department order by salary desc) as rnk
from employees) t
where rnk <= 2
;

-- Find the top 2 highest-paid employees in each department, exactly 2 employees per department, even if salaries are tied.
select 
	department,
    employee_name,
    salary
from (
select 
    *,
    row_number() over(partition by department order by salary desc) as rnk
from employees) t
where rnk <= 2
;

-- Find the 3rd highest distinct salary in each department.
select 
	department,
    employee_name,
    salary
from (
select 
	*,
    dense_rank() over(partition by department order by salary desc) as rnk
from employees) t
where rnk = 3
;
-- Find the 2nd lowest distinct salary in each department.
select 
	department,
    employee_name,
    salary
from (
select 
	*,
    dense_rank() over(partition by department order by salary asc) as rnk
from employees) t
where rnk = 2
;
-- Display every employee along with their salary rank within their department.
select
	department,
    employee_name,
    salary,
    rank() over(partition by department order by salary desc) as salary_rank
from employees;

-- Calculate the percentile rank of each employee's salary within their department, with the lowest salary having percentile rank 0 and highest salary 1.
select
	department,
    employee_name,
    salary,
    percent_rank() over(partition by department order by salary asc) * 100 as prc
from employees;

-- Calculate the cumulative distribution of salary within each department, from lowest to highest salary.
select
	department,
    employee_name,
    salary,
    cume_dist() over(partition by department order by salary asc) as prc
from employees;

-- Divide employees within each department into 4 salary buckets, where bucket 1 contains the highest salaries.
select
	department,
    employee_name,
    salary,
    ntile(4) over(partition by department order by salary desc) as salary_bucket
from employees;

-- Calculate a 3-row moving average of sales amount, ordered by sale date.
select 
	sale_id,
    sale_date,
    sales_amount,
    avg(sales_amount) over(
		order by sale_date, sale_id asc
        rows between 2 preceding and current row
    ) as moving_average_3_day
from sales;

-- Calculate a 3-row moving total of sales amount, ordered by sale_date.
select 
	sale_id,
    sale_date,
    sales_amount,
    sum(sales_amount) over(
		order by sale_date, sale_id asc
        rows between 2 preceding and current row
    ) as moving_sum_3_day
from sales;

-- Calculate the number of sales transactions in the current row and previous 2 rows.
select 
	sale_id,
    sale_date,
    sales_amount,
    count(sale_id) over(
    order by sale_date, sale_id
    rows between 2 preceding and current row
    ) as cnt
from sales;
-- Calculate the minimum sales amount within the current row and previous 2 rows.
select 
	sale_id,
    sale_date,
    sales_amount,
    min(sales_amount) over(
		order by sale_date, sale_id
        rows between 2 preceding and current row
    ) as moving_min
from sales;
-- Calculate the maximum sales amount within the current row and previous 2 rows.
select 
	sale_id,
    sale_date,
    sales_amount,
    max(sales_amount) over(
		order by sale_date, sale_id
        rows between 2 preceding and current row
    ) as moving_max
from sales;
-- Calculate the difference between the current sale amount and the previous sale amount.
select
	sale_id,
    sale_date,
    sales_amount,
    lag(sales_amount, 1) over(order by sale_date, sale_id) as previous_sales,
    sales_amount - lag(sales_amount, 1) over(order by sale_date, sale_id) as difference
from sales;

-- Calculate the percentage change in sales amount compared with the previous sale.
with sales_with_previous  as (
select 
	sale_id,
    sale_date,
    sales_amount,
    lag(sales_amount) over(order by sale_date, sale_id) as  previous_sales
from sales)

select 
	sale_id,
    sale_date,
    sales_amount,
    (sales_amount - previous_sales)/nullif(previous_sales, 0)* 100 as percentage_change
from sales_with_previous;

-- For each employee, calculate their salary compared with the average salary of their department.
select 
	employee_name,
    department,
    salary,
    department_avg_salary,
    salary - department_avg_salary as difference_from_avg
from (
select 
	employee_name,
    department,
    salary,
	avg(salary) over(partition by department) as department_avg_salary
from employees) t;

-- For each employee, return only employees whose salary is above their department's average salary.
select 
	employee_name,
	department,
	salary,
    department_avg_salary
from (
select 
	employee_name,
	department,
	salary,
	avg(salary) over(partition by department) as department_avg_salary
from employees) t
where salary > department_avg_salary;

-- For each employee, calculate the difference between the department's maximum salary and the employee's salary.
select 
	employee_name,
	department,
	salary,
    department_max_salary,
    department_max_salary - salary as difference_from_max
from (
select 
	employee_name,
	department,
	salary,
	max(salary) over(partition by department) as department_max_salary
from employees) t;
-- Difference from Department Minimum
select 
	employee_name,
	department,
	salary,
    department_min_salary,
	salary - department_min_salary as difference_from_min
from (
select 
	employee_name,
	department,
	salary,
	min(salary) over(partition by department) as department_min_salary
from employees) t;

-- First Sale per Customer
select 
	customer_id,
	order_id,
    order_date,
    order_amount
from (
select 
	customer_id,
	order_id,
    order_date,
    order_amount,
    row_number() over(partition by customer_id order by order_date asc
    rows between unbounded preceding and current row) as rnk
from orders o) t
where rnk = 1
;

-- Customer Order Sequence
select 
	customer_id,
	order_id,
    order_date,
    order_amount,
    row_number() over(
		partition by customer_id 
        order by order_date, order_id
        ) as order_number
from orders;

-- Days Since Previous Order
-- For each customer, calculate how many days passed between their current order and their previous order.
select 
	customer_id,
    order_id,
    order_date,
    previous_order_date,
    datediff(order_date, previous_order_date) as days
from (
select 
	customer_id,
    order_id,
    order_date,
    lag(order_date) over(partition by customer_id order by order_date, order_id ) as previous_order_date
from orders) t;

-- Customer's Order Amount Change
-- For each customer, calculate the difference between the current order amount and their previous order amount.
with previous_order_sales as (
select
	customer_id,
    order_id,
    order_date,
    order_amount,
    lag(order_amount, 1) over(partition by customer_id order by order_date, order_id) as previous_order_amount
from orders)
select 
	customer_id,
    order_id,
    order_date,
    order_amount,
    order_amount - previous_order_amount as amount_difference
from previous_order_sales;
-- Customer Order Amount Growth %
-- For each customer, calculate the percentage change in order amount compared with their previous order.
with previous_amount_sales as  (
select 
	customer_id,
    order_id,
    order_date,
    order_amount,
    lag(order_amount, 1) over(partition by customer_id order by order_date, order_id )as previous_order_amount
from orders)

select 
	customer_id,
    order_id,
    order_date,
    order_amount,
    (order_amount - previous_order_amount)/previous_order_amount * 100 as amount_growth_percent
from previous_amount_sales;

-- Running Customer Spend
-- For each customer, calculate their cumulative order amount up to each order.
select
	customer_id,
    order_id,
    order_date,
    order_amount,
    sum(order_amount) over(
		partition by customer_id
        order by order_date, order_id
        rows between unbounded preceding and current row
    ) as running_customer_spend
    from orders;
    
    -- Customer's % of Total Spend
    -- For every order, calculate what percentage of that customer's total lifetime spending that order represents.
with customers_with_total_spends as (
select
	customer_id,
	order_id,
	order_amount,
    sum(order_amount) over(partition by customer_id) as customer_total_spend
from orders)

select 
	customer_id,
	order_id,
	order_amount,
    (order_amount/nullif(customer_total_spend, 0)) * 100 as percentage_of_customer_spend 
from customers_with_total_spends;

-- Running Percentage of Customer Spend
-- For each order, calculate what percentage of the customer's final/lifetime spending has been accumulated up to that order.
with customers_with_total_spends as (
select
	customer_id,
    order_id,
    order_date,
    order_amount,
    sum(order_amount) over(partition by customer_id) as customer_total_spend,
	sum(order_amount) over(partition by customer_id order by order_date, order_id
		rows between unbounded preceding and current row
    ) as running_customer_spend
from orders)

select 
	customer_id,
    order_id,
    order_date,
    order_amount,
    customer_total_spend,
    running_customer_spend,
    (running_customer_spend/customer_total_spend) * 100 as running_spend_percent
from customers_with_total_spends;
-- First Value in Window
-- The first_salary_in_department should be the lowest salary in that employee's department.
select
	employee_name,
	department,
	salary,
    first_value(salary) over(partition by department order by salary) as first_salary_in_department
from employees;

-- Last Value in Window
-- Using the employees table, find the highest salary in each department using LAST_VALUE().
select
	employee_name,
	department,
	salary,
    last_value(salary) over(
		partition by department 
        order by salary
        rows between unbounded preceding and unbounded following
        ) as last_salary_in_department
from employees;
-- Ignore NULLs: FIRST_VALUE()
select
	sale_id,
	sale_date,
	sales_amount,
    first_value(sales_amount) over(
        order by sales_amount is null, sale_date, sale_id
        rows between unbounded preceding and unbounded following
    ) as first_non_null_value
from sales;

-- Cumulative Maximum
-- Using the sales table, calculate the highest sales amount seen so far for each salesperson.
select 
	salesperson,
    sale_date,
    sale_id,
    sales_amount,
    max(sales_amount) over(
		partition by salesperson
        order by sale_date, sale_id
        rows between unbounded preceding and current row
    ) as cumulative_max
from sales;