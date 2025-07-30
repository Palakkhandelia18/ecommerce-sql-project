CREATE DATABASE ecommerce_project; 
USE ecommerce_project;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    registration_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO customers (name, email, city, registration_date)
VALUES 
  ('Aarav Mehta', 'aarav@gmail.com', 'Delhi', '2023-04-01'),
  ('Palak Khandelia', 'palak@gmail.com', 'Jhunjhunu', '2023-06-15'),
  ('Riya Sharma', 'riya.sharma@yahoo.com', 'Mumbai', '2023-07-10');
  
  INSERT INTO products (name, description, price)
VALUES 
  ('Bluetooth Headphones', 'Wireless over-ear headphones with mic', 1999.99),
  ('Smart Watch', 'Touchscreen fitness tracking watch', 2999.00),
  ('Phone Case', 'Silicone case for iPhone 13', 399.50);
  
  INSERT INTO orders (customer_id, order_date)
VALUES 
  (1, '2023-07-01'),
  (2, '2023-07-03'),
  (3, '2023-07-05');
  
  INSERT INTO payments (order_id, amount, payment_date)
VALUES 
  (1, 1999.99, '2023-07-01'),
  (2, 2999.00, '2023-07-03'),
  (3, 399.50, '2023-07-05');
  
SELECT o.order_id, c.name AS customer_name, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT SUM(amount) AS total_revenue FROM payments;

SELECT c.name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

SELECT * FROM orders                                                               
WHERE order_date >= CURDATE() - INTERVAL 30 DAY;

SELECT SUM(amount) AS total_payment 
FROM payments;

SELECT c.name, o.order_id, o.order_date
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id;

SELECT c.name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_orders DESC
LIMIT 1;

SELECT p.name AS product_name, COUNT(*) AS total_sold
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 1;

SELECT SUM(amount) AS total_revenue
FROM payments;

SELECT MONTH(order_date) AS month, COUNT(*) AS orders_count
FROM orders
GROUP BY MONTH(order_date)
ORDER BY month;

SELECT * FROM orders
WHERE order_date > CURDATE() - INTERVAL 30 DAY;