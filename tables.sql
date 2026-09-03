CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    dept_id INT
);
INSERT INTO employees
VALUES (1, 'Ravi', 10),
    (2, 'Priya', 20),
    (3, 'Arun', 30),
    (4, 'Sita', 40),
    (5, 'Kumar', NULL);
CREATE TABLE departments (dept_id INT, dept_name VARCHAR(50));
INSERT INTO departments
VALUES (10, 'IT'),
    (20, 'HR'),
    (30, 'Finance'),
    (50, 'Marketing');
CREATE TABLE projects (
    project_id INT,
    project_name VARCHAR(50),
    emp_id INT
);
INSERT INTO projects
VALUES (101, 'Website', 1),
    (102, 'Payroll', 2),
    (103, 'Database', 3),
    (104, 'Security', 6);
CREATE TABLE salaries (emp_id INT, salary INT);
INSERT INTO salaries
VALUES (1, 60000),
    (2, 50000),
    (3, 70000),
    (4, 45000),
    (6, 80000);
select *
from employees;
select *
from departments;
select *
from projects;
select *
from salaries;
-- inner join
select *
from employees e
    join departments d on e.dept_id = d.dept_id;
-- left join
select *
from employees e
    left join departments d on e.dept_id = d.dept_id;
-- right join
select *
from employees e
    right join departments d on e.dept_id = d.dept_id;
-- Write a query to find the second highest salary in an employee table.
select *
from (
        select e.emp_name,
            s.salary,
            rank() over (
                order by s.salary desc
            ) as rnk
        from employees e
            join salaries s on e.emp_id = s.emp_id
    ) t
where rnk = 2;
-- How do you retrieve only duplicate records from a table?
select *
from student;
select name,
    count(name) as cnt
from student
group by name
having count(name) > 1;
-- Find employees who earn more than the average salary in their department.
-- select * from employees;
select emp_name,
    dept_name,
    avg_salary
from (
        select e.emp_name,
            d.dept_name,
            s.salary,
            avg(s.salary) over (
                partition by d.dept_name
            ) as avg_salary
        from employees e
            join departments d on e.dept_id = d.dept_id
            join salaries s on e.emp_id = s.emp_id
    ) t
where salary > avg_salary;
-- Write a query to find the most frequently occurring value in a column.
select dept_id,
    count(dept_id)
from employees
group by dept_id
order by count(dept_id) desc
limit 1;
-- Write a query to count how many employees share the same salary.
select *
from employees;
select *
from salaries;
select s.salary,
    count(s.salary) over (partition by s.salary) as same_count_salary
from employees e
    join salaries s on e.emp_id = s.emp_id
order by same_count_salary desc;
--  How do you fetch the top 3 records for each group in a table?
with top_records as (
    SELECT e.emp_id,
        e.emp_name,
        d.dept_name,
        s.salary,
        rank() over(
            partition by d.dept_name
            order by s.salary desc
        ) as rnk
    FROM employees e
        JOIN salaries s ON e.emp_id = s.emp_id
        JOIN departments d ON e.dept_id = d.dept_id
)
select *
from top_records
where rnk <= 3;