-- =========================
-- DATABASE
-- =========================
CREATE DATABASE sql_practice;
USE sql_practice;
-- =========================
-- DEPARTMENTS
-- =========================
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);
-- =========================
-- EMPLOYEES
-- =========================
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
-- =========================
-- CUSTOMERS
-- =========================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);
-- =========================
-- PRODUCTS
-- =========================
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);
-- =========================
-- ORDERS
-- =========================
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
-- =========================
-- ORDER ITEMS
-- =========================
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO departments
VALUES (1, 'IT'),
    (2, 'HR'),
    (3, 'Finance'),
    (4, 'Sales'),
    (5, 'Marketing');
INSERT INTO employees
VALUES (101, 'Rahul', 1, 75000),
    (102, 'Priya', 1, 85000),
    (103, 'Arjun', 1, 65000),
    (104, 'Sneha', 1, 90000),
    (105, 'Kiran', 1, 72000),
    (106, 'Anil', 1, 95000),
    (107, 'Meena', 1, 68000),
    (108, 'Ravi', 2, 55000),
    (109, 'Pooja', 2, 60000),
    (110, 'Vijay', 2, 58000),
    (111, 'Suresh', 3, 80000),
    (112, 'Divya', 3, 85000),
    (113, 'Naveen', 3, 78000),
    (114, 'Swathi', 3, 82000),
    (115, 'Amit', 4, 60000),
    (116, 'Neha', 4, 70000),
    (117, 'Rohit', 4, 65000),
    (118, 'Kavya', 4, 75000),
    (119, 'Manoj', 4, 68000),
    (120, 'Lakshmi', 4, 72000),
    (121, 'Varun', 5, 62000),
    (122, 'Anusha', 5, 67000);
INSERT INTO customers
VALUES (1, 'Ramesh', 'Hyderabad'),
    (2, 'Sita', 'Bangalore'),
    (3, 'Karthik', 'Chennai'),
    (4, 'Anjali', 'Hyderabad'),
    (5, 'Mahesh', 'Mumbai'),
    (6, 'Deepa', 'Delhi'),
    (7, 'Venkat', 'Pune'),
    (8, 'Swetha', 'Hyderabad');
INSERT INTO products
VALUES (1, 'Laptop', 'Electronics', 60000),
    (2, 'Smartphone', 'Electronics', 30000),
    (3, 'Headphones', 'Electronics', 5000),
    (4, 'Keyboard', 'Accessories', 3000),
    (5, 'Mouse', 'Accessories', 1500),
    (6, 'Monitor', 'Electronics', 15000),
    (7, 'Printer', 'Electronics', 12000),
    (8, 'Office Chair', 'Furniture', 10000);
INSERT INTO orders
VALUES (1001, 1, '2026-01-05'),
    (1002, 1, '2026-01-10'),
    (1003, 1, '2026-01-15'),
    (1004, 1, '2026-01-20'),
    (1005, 1, '2026-02-01'),
    (1006, 2, '2026-01-07'),
    (1007, 2, '2026-01-18'),
    (1008, 3, '2026-01-09'),
    (1009, 3, '2026-01-25'),
    (1010, 3, '2026-02-05'),
    (1011, 3, '2026-02-15'),
    (1012, 4, '2026-01-12'),
    (1013, 4, '2026-02-10'),
    (1014, 5, '2026-01-14'),
    (1015, 5, '2026-02-20'),
    (1016, 5, '2026-03-01'),
    (1017, 5, '2026-03-10'),
    (1018, 6, '2026-02-01'),
    (1019, 6, '2026-02-12'),
    (1020, 7, '2026-02-05'),
    (1021, 8, '2026-02-08'),
    (1022, 8, '2026-02-18'),
    (1023, 8, '2026-03-05');
INSERT INTO order_items
VALUES -- Ramesh
    (1, 1001, 1, 2),
    (2, 1001, 3, 4),
    (3, 1002, 2, 2),
    (4, 1002, 5, 5),
    (5, 1003, 6, 3),
    (6, 1004, 1, 1),
    (7, 1004, 4, 5),
    (8, 1005, 2, 3),
    -- Sita
    (9, 1006, 3, 5),
    (10, 1006, 5, 10),
    (11, 1007, 6, 2),
    -- Karthik
    (12, 1008, 1, 1),
    (13, 1008, 3, 5),
    (14, 1009, 2, 2),
    (15, 1009, 6, 2),
    (16, 1010, 1, 2),
    (17, 1011, 7, 4),
    -- Anjali
    (18, 1012, 8, 3),
    (19, 1012, 4, 5),
    (20, 1013, 6, 4),
    -- Mahesh
    (21, 1014, 1, 2),
    (22, 1015, 2, 4),
    (23, 1015, 3, 5),
    (24, 1016, 6, 5),
    (25, 1017, 1, 1),
    (26, 1017, 7, 3),
    -- Deepa
    (27, 1018, 3, 10),
    (28, 1019, 5, 20),
    -- Venkat
    (29, 1020, 2, 3),
    -- Swetha
    (30, 1021, 1, 1),
    (31, 1021, 6, 2),
    (32, 1022, 2, 2),
    (33, 1023, 1, 2),
    (34, 1023, 3, 5);