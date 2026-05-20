-- Create Database
CREATE DATABASE sales_analysis;

-- Use Database
USE sales_analysis;

-- CREATE TABLES
-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- INSERT DATA INTO CUSTOMERS

INSERT INTO customers VALUES
(1, 'Rahul', 'Delhi'),
(2, 'Aman', 'Mumbai'),
(3, 'Priya', 'Jaipur'),
(4, 'Sneha', 'Pune'),
(5, 'Rohit', 'Bangalore');

-- INSERT DATA INTO PRODUCTS

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mobile', 'Electronics', 20000),
(103, 'Headphones', 'Accessories', 2000),
(104, 'Keyboard', 'Accessories', 1500),
(105, 'Mouse', 'Accessories', 800);

-- INSERT DATA INTO ORDERS
INSERT INTO orders VALUES
(1001, 1, 101, 1, '2025-01-10'),
(1002, 2, 102, 2, '2025-01-12'),
(1003, 3, 103, 3, '2025-01-15'),
(1004, 4, 104, 1, '2025-01-20'),
(1005, 5, 105, 4, '2025-01-22'),
(1006, 1, 102, 1, '2025-01-25'),
(1007, 2, 103, 2, '2025-01-28');


-- DISPLAY TABLES


SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;


-- TOTAL SALES

SELECT 
    SUM(orders.quantity * products.price) AS total_sales
FROM orders
JOIN products
ON orders.product_id = products.product_id;


-- TOP SELLING PRODUCTS

SELECT 
    products.product_name,
    SUM(orders.quantity) AS total_quantity
FROM orders
JOIN products
ON orders.product_id = products.product_id
GROUP BY products.product_name
ORDER BY total_quantity DESC;


-- CUSTOMER PURCHASE ANALYSIS

SELECT 
    customers.customer_name,
    COUNT(orders.order_id) AS total_orders
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_name
ORDER BY total_orders DESC;


-- HIGHEST REVENUE PRODUCT

SELECT 
    products.product_name,
    SUM(orders.quantity * products.price) AS revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
GROUP BY products.product_name
ORDER BY revenue DESC
LIMIT 1;

-- CITY-WISE CUSTOMERS

SELECT 
    city,
    COUNT(customer_id) AS total_customers
FROM customers
GROUP BY city;


-- ORDER DETAILS WITH CUSTOMER & PRODUCT

SELECT
    orders.order_id,
    customers.customer_name,
    products.product_name,
    orders.quantity,
    products.price,
    (orders.quantity * products.price) AS total_price
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
JOIN products
ON orders.product_id = products.product_id;

-- AVERAGE PRODUCT PRICE

SELECT 
    AVG(price) AS average_price
FROM products;


-- PRODUCTS PRICE GREATER THAN 5000
SELECT *
FROM products
WHERE price > 5000;

