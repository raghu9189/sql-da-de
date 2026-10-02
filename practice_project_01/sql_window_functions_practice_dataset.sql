-- SQL Window Functions Practice Dataset
-- Designed for MySQL 8+ and SQL interview practice.
-- Tables: employees, customers, orders, sales, daily_metrics
create database practice_project_02;
use practice_project_02;
DROP TABLE IF EXISTS daily_metrics;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    job_title VARCHAR(50),
    salary INT,
    hire_date DATE,
    manager_id INT
);

INSERT INTO employees
(employee_id, employee_name, department, job_title, salary, hire_date, manager_id)
VALUES
(1,'Amit','IT','Manager',90000,'2019-01-15',NULL),
(2,'Ravi','IT','Developer',70000,'2020-03-10',1),
(3,'Priya','IT','Developer',70000,'2021-06-20',1),
(4,'Kiran','IT','Analyst',60000,'2022-02-12',1),
(5,'Sneha','IT','Analyst',55000,'2023-07-01',1),
(6,'Suresh','HR','Manager',80000,'2018-05-10',NULL),
(7,'Neha','HR','HR Executive',60000,'2020-08-15',6),
(8,'Anil','HR','HR Executive',60000,'2021-09-18',6),
(9,'Divya','HR','Recruiter',50000,'2023-01-10',6),
(10,'Vikram','Sales','Manager',85000,'2019-11-20',NULL),
(11,'Rahul','Sales','Sales Executive',65000,'2020-04-12',10),
(12,'Pooja','Sales','Sales Executive',65000,'2021-08-05',10),
(13,'Arjun','Sales','Sales Executive',55000,'2022-10-11',10),
(14,'Meena','Sales','Sales Executive',45000,'2024-01-20',10),
(15,'Aravind','Finance','Manager',95000,'2018-02-01',NULL),
(16,'Lakshmi','Finance','Accountant',70000,'2020-05-15',15),
(17,'Ramesh','Finance','Accountant',65000,'2021-03-22',15),
(18,'Swathi','Finance','Analyst',60000,'2023-06-10',15);

CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE,
    updated_at DATETIME
);

INSERT INTO customers
(customer_id, customer_name, email, city, signup_date, updated_at)
VALUES
(101,'Ravi Kumar','ravi@gmail.com','Hyderabad','2024-01-10','2024-01-10 10:00:00'),
(101,'Ravi Kumar','ravi@gmail.com','Hyderabad','2024-01-10','2024-03-15 12:00:00'),
(101,'Ravi Kumar','ravi@gmail.com','Bangalore','2024-01-10','2024-06-20 15:00:00'),
(102,'Priya Sharma','priya@gmail.com','Hyderabad','2024-02-05','2024-02-05 09:00:00'),
(103,'Anil Reddy','anil@gmail.com','Warangal','2024-03-01','2024-03-01 11:00:00'),
(103,'Anil Reddy','anil@gmail.com','Warangal','2024-03-01','2024-05-10 14:00:00'),
(104,'Sneha Rao','sneha@gmail.com','Karimnagar','2024-04-12','2024-04-12 10:30:00'),
(105,'Kiran Das','kiran@gmail.com','Hyderabad','2024-05-20','2024-05-20 08:30:00'),
(105,'Kiran Das','kiran@gmail.com','Chennai','2024-05-20','2024-08-15 16:00:00');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    order_amount DECIMAL(10,2)
);

INSERT INTO orders
(order_id, customer_id, order_date, order_status, order_amount)
VALUES
(1001,101,'2025-01-05','Completed',5000),
(1002,101,'2025-01-15','Completed',7000),
(1003,101,'2025-02-10','Completed',3000),
(1004,102,'2025-01-10','Completed',8000),
(1005,102,'2025-02-20','Cancelled',4000),
(1006,102,'2025-03-15','Completed',9000),
(1007,103,'2025-01-20','Completed',6000),
(1008,103,'2025-01-25','Completed',6500),
(1009,104,'2025-02-01','Completed',3000),
(1010,104,'2025-02-15','Completed',4500),
(1011,104,'2025-03-01','Completed',7000),
(1012,105,'2025-03-05','Completed',2000),
(1013,105,'2025-03-20','Completed',2500);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    salesperson VARCHAR(50),
    region VARCHAR(50),
    product VARCHAR(50),
    category VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    sales_amount DECIMAL(12,2)
);

INSERT INTO sales
(sale_id,sale_date,salesperson,region,product,category,quantity,unit_price,sales_amount)
VALUES
(1,'2024-01-03','Priya','South','Monitor','Electronics',4,15000,60000.00),
(2,'2024-01-12','Rahul','North','Headphones','Accessories',5,5000,25000.00),
(3,'2024-01-22','Arjun','West','Keyboard','Accessories',6,3000,18000.00),
(4,'2024-02-03','Pooja','North','Headphones','Accessories',5,5000,25000.00),
(5,'2024-02-12','Ravi','West','Keyboard','Accessories',6,3000,18000.00),
(6,'2024-02-22','Kiran','South','Laptop','Electronics',7,60000,420000.00),
(7,'2024-03-03','Priya','West','Keyboard','Accessories',6,3000,18000.00),
(8,'2024-03-12','Rahul','South','Laptop','Electronics',7,60000,420000.00),
(9,'2024-03-22','Arjun','North','Phone','Electronics',8,30000,240000.00),
(10,'2024-04-03','Pooja','South','Laptop','Electronics',7,60000,420000.00),
(11,'2024-04-12','Ravi','North','Phone','Electronics',8,30000,240000.00),
(12,'2024-04-22','Kiran','West','Tablet','Electronics',2,20000,40000.00),
(13,'2024-05-03','Priya','North','Phone','Electronics',8,30000,240000.00),
(14,'2024-05-12','Rahul','West','Tablet','Electronics',2,20000,40000.00),
(15,'2024-05-22','Arjun','South','Monitor','Electronics',3,15000,45000.00),
(16,'2024-06-03','Pooja','West','Tablet','Electronics',2,20000,40000.00),
(17,'2024-06-12','Ravi','South','Monitor','Electronics',3,15000,45000.00),
(18,'2024-06-22','Kiran','North','Headphones','Accessories',4,5000,NULL),
(19,'2024-07-03','Priya','South','Monitor','Electronics',3,15000,45000.00),
(20,'2024-07-12','Rahul','North','Headphones','Accessories',4,5000,20000.00),
(21,'2024-07-22','Arjun','West','Keyboard','Accessories',5,3000,15000.00),
(22,'2024-08-03','Pooja','North','Headphones','Accessories',4,5000,20000.00),
(23,'2024-08-12','Ravi','West','Keyboard','Accessories',5,3000,15000.00),
(24,'2024-08-22','Kiran','South','Laptop','Electronics',6,60000,360000.00),
(25,'2024-09-03','Priya','West','Keyboard','Accessories',5,3000,15000.00),
(26,'2024-09-12','Rahul','South','Laptop','Electronics',6,60000,360000.00),
(27,'2024-09-22','Arjun','North','Phone','Electronics',7,30000,210000.00),
(28,'2024-10-03','Pooja','South','Laptop','Electronics',6,60000,360000.00),
(29,'2024-10-12','Ravi','North','Phone','Electronics',7,30000,210000.00),
(30,'2024-10-22','Kiran','West','Tablet','Electronics',8,20000,160000.00),
(31,'2024-11-03','Priya','North','Phone','Electronics',7,30000,210000.00),
(32,'2024-11-12','Rahul','West','Tablet','Electronics',8,20000,160000.00),
(33,'2024-11-22','Arjun','South','Monitor','Electronics',2,15000,30000.00),
(34,'2024-12-03','Pooja','West','Tablet','Electronics',8,20000,160000.00),
(35,'2024-12-12','Ravi','South','Monitor','Electronics',2,15000,30000.00),
(36,'2024-12-22','Kiran','North','Headphones','Accessories',3,5000,15000.00),
(37,'2025-01-03','Priya','North','Headphones','Accessories',5,5000,27500.00),
(38,'2025-01-12','Rahul','West','Keyboard','Accessories',6,3000,19800.00),
(39,'2025-01-22','Arjun','South','Laptop','Electronics',7,60000,462000.00),
(40,'2025-02-03','Pooja','West','Keyboard','Accessories',6,3000,19800.00),
(41,'2025-02-12','Ravi','South','Laptop','Electronics',7,60000,462000.00),
(42,'2025-02-22','Kiran','North','Phone','Electronics',8,30000,264000.00),
(43,'2025-03-03','Priya','South','Laptop','Electronics',7,60000,462000.00),
(44,'2025-03-12','Rahul','North','Phone','Electronics',8,30000,264000.00),
(45,'2025-03-22','Arjun','West','Tablet','Electronics',2,20000,44000.00),
(46,'2025-04-03','Pooja','North','Phone','Electronics',8,30000,264000.00),
(47,'2025-04-12','Ravi','West','Tablet','Electronics',2,20000,NULL),
(48,'2025-04-22','Kiran','South','Monitor','Electronics',3,15000,49500.00),
(49,'2025-05-03','Priya','West','Tablet','Electronics',2,20000,44000.00),
(50,'2025-05-12','Rahul','South','Monitor','Electronics',3,15000,49500.00),
(51,'2025-05-22','Arjun','North','Headphones','Accessories',4,5000,22000.00),
(52,'2025-06-03','Pooja','South','Monitor','Electronics',3,15000,49500.00),
(53,'2025-06-12','Ravi','North','Headphones','Accessories',4,5000,22000.00),
(54,'2025-06-22','Kiran','West','Keyboard','Accessories',5,3000,16500.00),
(55,'2025-07-03','Priya','North','Headphones','Accessories',4,5000,22000.00),
(56,'2025-07-12','Rahul','West','Keyboard','Accessories',5,3000,16500.00),
(57,'2025-07-22','Arjun','South','Laptop','Electronics',6,60000,396000.00),
(58,'2025-08-03','Pooja','West','Keyboard','Accessories',5,3000,16500.00),
(59,'2025-08-12','Ravi','South','Laptop','Electronics',6,60000,396000.00),
(60,'2025-08-22','Kiran','North','Phone','Electronics',7,30000,231000.00),
(61,'2025-09-03','Priya','South','Laptop','Electronics',6,60000,396000.00),
(62,'2025-09-12','Rahul','North','Phone','Electronics',7,30000,231000.00),
(63,'2025-09-22','Arjun','West','Tablet','Electronics',8,20000,176000.00),
(64,'2025-10-03','Pooja','North','Phone','Electronics',7,30000,231000.00),
(65,'2025-10-12','Ravi','West','Tablet','Electronics',8,20000,176000.00),
(66,'2025-10-22','Kiran','South','Monitor','Electronics',2,15000,33000.00),
(67,'2025-11-03','Priya','West','Tablet','Electronics',8,20000,176000.00),
(68,'2025-11-12','Rahul','South','Monitor','Electronics',2,15000,33000.00),
(69,'2025-11-22','Arjun','North','Headphones','Accessories',3,5000,16500.00),
(70,'2025-12-03','Pooja','South','Monitor','Electronics',2,15000,33000.00),
(71,'2025-12-12','Ravi','North','Headphones','Accessories',3,5000,16500.00),
(72,'2025-12-22','Kiran','West','Keyboard','Accessories',4,3000,13200.00);

-- Daily metrics: deliberately contains date gaps for sequence/gap questions.
CREATE TABLE daily_metrics (
    metric_date DATE PRIMARY KEY,
    website_visits INT,
    orders INT,
    revenue DECIMAL(12,2)
);

INSERT INTO daily_metrics
(metric_date,website_visits,orders,revenue)
VALUES
('2025-01-01',1000,50,50000),
('2025-01-02',1200,55,57000),
('2025-01-03',1100,52,54000),
('2025-01-05',1400,70,72000),
('2025-01-06',1500,75,80000),
('2025-01-07',1600,80,85000),
('2025-01-10',1800,90,95000),
('2025-01-11',1750,88,92000),
('2025-01-12',1900,95,100000),
('2025-01-13',2000,100,110000),
('2025-01-14',2100,105,115000),
('2025-01-15',2200,110,120000),
('2025-01-17',2300,115,125000),
('2025-01-18',2250,112,121000),
('2025-01-19',2400,120,130000),
('2025-01-20',2500,125,135000),
('2025-01-22',2700,135,145000),
('2025-01-23',2650,132,142000),
('2025-01-24',2800,140,150000),
('2025-01-25',2900,145,158000),
('2025-01-27',3000,150,165000),
('2025-01-28',3100,155,170000),
('2025-01-29',3050,152,168000),
('2025-01-30',3200,160,175000),
('2025-01-31',3300,165,182000);

-- Useful checks after loading:
-- SELECT COUNT(*) FROM employees;       -- 18
-- SELECT COUNT(*) FROM customers;       -- 9
-- SELECT COUNT(*) FROM orders;          -- 13
-- SELECT COUNT(*) FROM sales;           -- 72
-- SELECT COUNT(*) FROM daily_metrics;   -- 25
