DROP DATABASE IF EXISTS xyzcollege;
DROP DATABASE IF EXISTS college;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data
INSERT INTO customers (name, email) VALUES 
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com');

INSERT INTO products (product_name, price) VALUES 
('Laptop', 1000.00),
('Phone', 500.00);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES 
(1, '2024-01-15', 1500.00),
(2, '2024-02-20', 500.00);

INSERT INTO order_items (order_id, product_id, quantity) VALUES 
(1, 1, 1),
(1, 2, 1),
(2, 2, 1);

SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING total_spent > 500
ORDER BY total_spent DESC;

SELECT o.order_id, c.name, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

SELECT c.name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

SELECT o.order_id, o.total_amount, c.name
FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.customer_id;

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE total_amount > (SELECT AVG(total_amount) FROM orders)
    
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE total_amount > (SELECT AVG(total_amount) FROM orders)
);

SELECT customer_id, AVG(total_amount) AS avg_order_value
FROM orders
GROUP BY customer_id;

SELECT SUM(total_amount) AS total_revenue
FROM orders;

CREATE VIEW product_sales AS
SELECT p.product_id, p.product_name, SUM(oi.quantity * p.price) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name;

SELECT * FROM product_sales WHERE total_sales > 1000;

CREATE INDEX idx_customer_id ON orders(customer_id);

-- Index on order_date for faster date range queries
CREATE INDEX idx_order_date ON orders(order_date);

-- Composite index for order_items
CREATE INDEX idx_order_product ON order_items(order_id, product_id);

EXPLAIN SELECT * FROM orders WHERE customer_id = 101;

Drop DATABASE IF exists employee;
drop database if exists student;
drop database if exists sys;