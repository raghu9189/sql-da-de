CREATE DATABASE practice_project_01;

USE practice_project_01;


-- 1. Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(256) NOT NULL,
    city VARCHAR(256),
    signup_date DATE
);


-- 2. Orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE,
    amount DECIMAL(10,2),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


-- 3. Products
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(256) NOT NULL,
    category VARCHAR(256),
    unit_price DECIMAL(10,2)
);


-- 4. Order Items
CREATE TABLE order_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,

    PRIMARY KEY (order_id, product_id),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


-- 5. Employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(256) NOT NULL,
    department VARCHAR(256),
    manager_id INT,

    FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
);