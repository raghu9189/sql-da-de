CREATE DATABASE window_functions_practice;
USE window_functions_practice;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);
INSERT INTO departments (department_id, department_name)
VALUES (1, 'IT'),
    (2, 'HR'),
    (3, 'Finance'),
    (4, 'Sales'),
    (5, 'Marketing');
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
INSERT INTO employees (
        employee_id,
        employee_name,
        department_id,
        salary,
        hire_date
    )
VALUES (1, 'Rahul', 1, 90000, '2021-03-15'),
    (2, 'Priya', 1, 85000, '2022-06-10'),
    (3, 'Arjun', 1, 85000, '2023-01-20'),
    (4, 'Sneha', 1, 75000, '2023-08-12'),
    (5, 'Vikram', 1, 70000, '2024-02-18'),
    (6, 'Anita', 2, 80000, '2020-05-10'),
    (7, 'Kiran', 2, 75000, '2021-09-22'),
    (8, 'Ravi', 2, 75000, '2022-11-05'),
    (9, 'Meena', 2, 65000, '2024-01-15'),
    (10, 'Suresh', 3, 95000, '2019-04-18'),
    (11, 'Divya', 3, 90000, '2020-07-25'),
    (12, 'Manoj', 3, 80000, '2022-03-11'),
    (13, 'Pooja', 3, 80000, '2023-05-19'),
    (14, 'Ramesh', 4, 85000, '2020-02-10'),
    (15, 'Lakshmi', 4, 75000, '2021-06-14'),
    (16, 'Tarun', 4, 70000, '2022-09-01'),
    (17, 'Swathi', 4, 70000, '2023-12-20'),
    (18, 'Naveen', 4, 60000, '2024-03-10'),
    (19, 'Asha', 5, 90000, '2021-01-12'),
    (20, 'Rohit', 5, 85000, '2022-04-17'),
    (21, 'Neha', 5, 75000, '2023-07-21'),
    (22, 'Vijay', 5, 70000, '2024-01-08');
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);
INSERT INTO customers (customer_id, customer_name, city)
VALUES (1, 'Customer A', 'Hyderabad'),
    (2, 'Customer B', 'Bangalore'),
    (3, 'Customer C', 'Chennai'),
    (4, 'Customer D', 'Mumbai'),
    (5, 'Customer E', 'Delhi'),
    (6, 'Customer F', 'Pune');
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);
INSERT INTO products (product_id, product_name, category, price)
VALUES (1, 'Laptop', 'Electronics', 60000),
    (2, 'Monitor', 'Electronics', 20000),
    (3, 'Keyboard', 'Accessories', 3000),
    (4, 'Mouse', 'Accessories', 1500),
    (5, 'Headphones', 'Accessories', 4000),
    (6, 'Mobile Phone', 'Electronics', 30000),
    (7, 'Tablet', 'Electronics', 25000),
    (8, 'Smart Watch', 'Wearables', 10000);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (101, 1, '2025-01-05'),
    (102, 1, '2025-01-12'),
    (103, 1, '2025-01-20'),
    (104, 1, '2025-02-05'),
    (105, 1, '2025-02-18'),
    (106, 2, '2025-01-03'),
    (107, 2, '2025-01-15'),
    (108, 2, '2025-02-01'),
    (109, 2, '2025-02-20'),
    (110, 3, '2025-01-07'),
    (111, 3, '2025-01-18'),
    (112, 3, '2025-02-10'),
    (113, 3, '2025-02-25'),
    (114, 4, '2025-01-10'),
    (115, 4, '2025-01-22'),
    (116, 4, '2025-02-08'),
    (117, 5, '2025-01-05'),
    (118, 5, '2025-01-25'),
    (119, 5, '2025-02-15'),
    (120, 5, '2025-02-28'),
    (121, 6, '2025-01-11'),
    (122, 6, '2025-01-30'),
    (123, 6, '2025-02-12');
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity)
VALUES -- Customer A
    (1, 101, 1, 1),
    (2, 101, 4, 2),
    (3, 102, 2, 1),
    (4, 102, 3, 2),
    (5, 103, 6, 1),
    (6, 104, 7, 2),
    (7, 104, 4, 1),
    (8, 105, 5, 2),
    -- Customer B
    (9, 106, 1, 1),
    (10, 107, 3, 3),
    (11, 107, 4, 2),
    (12, 108, 6, 2),
    (13, 109, 2, 2),
    (14, 109, 5, 1),
    -- Customer C
    (15, 110, 7, 1),
    (16, 111, 1, 1),
    (17, 111, 4, 2),
    (18, 112, 6, 1),
    (19, 112, 5, 2),
    (20, 113, 2, 1),
    -- Customer D
    (21, 114, 3, 5),
    (22, 115, 1, 1),
    (23, 115, 5, 1),
    (24, 116, 7, 1),
    (25, 116, 4, 2),
    -- Customer E
    (26, 117, 6, 1),
    (27, 118, 1, 1),
    (28, 118, 2, 1),
    (29, 119, 8, 2),
    (30, 120, 7, 1),
    (31, 120, 5, 1),
    -- Customer F
    (32, 121, 2, 1),
    (33, 122, 6, 1),
    (34, 122, 4, 3),
    (35, 123, 1, 1),
    (36, 123, 8, 1);