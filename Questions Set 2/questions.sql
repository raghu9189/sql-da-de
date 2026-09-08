-- 1. GROUP BY & Aggregation ⭐⭐⭐
-- 1. Find total sales by customer.
-- 2. Find average salary by department.
-- 3. Find departments having more than 5 employees.
-- 4. Find the highest salary in each department.
-- 5. Find products with total sales greater than ₹100,000.
-- 6. Find customers who placed more than 3 orders.
-- 7. Find the number of employees in each department.
-- 8. Find the percentage contribution of each product to total sales.
-- 2. Subqueries ⭐⭐⭐
-- What is a subquery?
-- 1. Find the second-highest salary.
-- 2. Find employees earning more than the average salary.
-- 3. Find employees earning the maximum salary.
-- 4. Find customers whose order value is greater than the average order value.
-- 5. Find the highest-paid employee in each department.
-- 6. Find products that have never been ordered.
-- 3. Correlated Subquery Practice
-- 1. Employees above their department average 
-- 2. Employees with the second-highest salary in their department
-- 1. Find total sales by customer.
select c.customer_id,
    c.customer_name,
    sum(oi.quantity * p.price) as total_sales
from customers c
    join orders o on c.customer_id = o.customer_id
    join order_items oi on o.order_id = oi.order_id
    join products p on oi.product_id = p.product_id
group by c.customer_id,
    c.customer_name;
-- 2. Find average salary by department.
select d.department_name,
    avg(e.salary) as avg_salary
from employees e
    join departments d on e.department_id = d.department_id
group by d.department_name;
-- 3. Find departments having more than 5 employees.
select d.department_name,
    count(e.employee_id) as emp_count
from employees e
    join departments d on e.department_id = d.department_id
group by d.department_name
having count(e.employee_id) > 1;
-- 4. Find the highest salary in each department.
select d.department_name,
    max(e.salary) as highest_salary
from employees e
    join departments d on e.department_id = d.department_id
group by d.department_name;
-- 5. Find products with total sales greater than ₹100,000.
select p.product_name,
    sum(oi.quantity * p.price) as total_sales
from orders o
    join order_items oi on o.order_id = oi.order_id
    join products p on oi.product_id = p.product_id
group by p.product_id
having sum(oi.quantity * p.price) > 100000;
-- 6. Find customers who placed more than 3 orders.
select c.customer_name,
    count(*) as orders_count
from customers c
    join orders o on c.customer_id = o.customer_id
group by c.customer_id
having count(o.order_id) > 3;
-- 7. Find the number of employees in each department.
select d.department_name,
    count(*) as emp_count
from employees e
    join departments d on e.department_id = d.department_id
group by d.department_name;
-- 8. Find the percentage contribution of each product to total sales. (problem pending)
select p.product_name,
    sum(oi.quantity * p.price) as prod_total_sales,
    (
        select sum(oi.quantity * p.price)
        from orders o
            join order_items oi on o.order_id = oi.order_id
            join products p on oi.product_id = p.product_id
    ) as total_sales,
    sum(oi.quantity * p.price) /(
        select sum(oi.quantity * p.price)
        from orders o
            join order_items oi on o.order_id = oi.order_id
            join products p on oi.product_id = p.product_id
    ) * 100 as contribution_per
from orders o
    join order_items oi on o.order_id = oi.order_id
    join products p on oi.product_id = p.product_id
group by p.product_name;
-- 1. Find the second-highest salary.
select max(salary)
from employees
where salary < (
        select max(salary)
        from employees
    );
-- 2. Find employees earning more than the average salary.
select employee_name,
    salary
from employees
where salary > (
        select avg(salary)
        from employees
    );
-- 3. Find employees earning the maximum salary.
select employee_name,
    salary
from employees
where salary = (
        select max(salary)
        from employees
    );
-- 4. Find customers whose order value is greater than the average order value. (pending)
-- 5. Find the highest-paid employee in each department.
select d.department_name,
    e.employee_name,
    e.salary
from employees e
    join departments d on e.department_id = d.department_id
where e.salary = (
        select max(e2.salary)
        from employees e2
        where e2.department_id = e.department_id
    );
-- 6. Find products that have never been ordered.
select *
from products
where product_id not in (
        select distinct p.product_id
        from orders o
            join order_items oi on o.order_id = oi.order_id
            join products p on oi.product_id = p.product_id
    );
-- 1. Employees above their department average 
select e.employee_name,
    d.department_name,
    e.salary
from employees e
    join departments d on e.department_id = d.department_id
where e.salary > (
        select avg(e2.salary)
        from employees e2
        where e.department_id = e2.department_id
    );
-- 2. Employees with the second-highest salary in their department
select e.employee_name,
    d.department_name,
    e.salary
from employees e
    join departments d on e.department_id = d.department_id
where e.salary < (
        select max(e2.salary)
        from employees e2
        where e.department_id = e2.department_id
    );