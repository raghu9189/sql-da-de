CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    dept_id INT
);

INSERT INTO employees VALUES
(1, 'Ravi', 10),
(2, 'Priya', 20),
(3, 'Arun', 30),
(4, 'Sita', 40),
(5, 'Kumar', NULL);

CREATE TABLE departments (
    dept_id INT,
    dept_name VARCHAR(50)
);

INSERT INTO departments VALUES
(10, 'IT'),
(20, 'HR'),
(30, 'Finance'),
(50, 'Marketing');

CREATE TABLE projects (
    project_id INT,
    project_name VARCHAR(50),
    emp_id INT
);

INSERT INTO projects VALUES
(101, 'Website', 1),
(102, 'Payroll', 2),
(103, 'Database', 3),
(104, 'Security', 6);

CREATE TABLE salaries (
    emp_id INT,
    salary INT
);

INSERT INTO salaries VALUES
(1, 60000),
(2, 50000),
(3, 70000),
(4, 45000),
(6, 80000);