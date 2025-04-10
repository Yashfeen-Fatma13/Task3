# Task3

Ecommerce SQL Database Step by Step Explanation:

As part of exploring SQL using a sample e-commerce database, I designed and worked with four main tables: customers, orders, products, and order_items. Here’s what I did step by step and how each SQL query helped me analyze the data effectively:


---

1. Setting Up the Database and Inserting Data

First, I created the necessary tables to represent the structure of a typical e-commerce system. These included:

customers – to store customer information like name and email.

orders – to track orders placed by customers along with date and total amount.

products – to store product names and prices.

order_items – to link orders with products and record quantities.


After creating the tables, I inserted sample data into each of them to work with realistic scenarios.


---

2. Using SELECT, WHERE, ORDER BY, and GROUP BY

To analyze customer spending, I wrote the following query:

SELECT customer_id, SUM(total_amount) AS total_spent 
FROM orders 
GROUP BY customer_id 
HAVING total_spent > 500 
ORDER BY total_spent DESC;

What I did:
I grouped the orders by customer_id to calculate the total amount spent by each customer. Then, I filtered only those who spent more than $500, and finally, I sorted them in descending order to see the top spenders.


---

3. Working with Joins (INNER, LEFT, RIGHT)

To combine data across tables, I practiced different types of joins:

INNER JOIN:


SELECT o.order_id, c.name, o.total_amount 
FROM orders o 
INNER JOIN customers c ON o.customer_id = c.customer_id;

What I did: Joined orders with customers to show each order along with the customer’s name.

LEFT JOIN:


SELECT c.name, o.order_id, o.total_amount 
FROM customers c 
LEFT JOIN orders o ON c.customer_id = o.customer_id;

What I did: Retrieved all customers, including those who haven’t placed any orders yet.

RIGHT JOIN:


SELECT o.order_id, o.total_amount, c.name 
FROM orders o 
RIGHT JOIN customers c ON o.customer_id = c.customer_id;

What I did: Listed all orders, even if a matching customer record might be missing (though rare, this helps understand data consistency).


---

4. Writing Subqueries

To find customers who placed orders above the average order value, I used a subquery:

SELECT * 
FROM customers 
WHERE customer_id IN (
    SELECT customer_id 
    FROM orders 
    WHERE total_amount > (
        SELECT AVG(total_amount) FROM orders
    )
);

What I did:
Calculated the average total_amount from all orders, and then selected customers who had orders exceeding that average. This helped me identify high-value customers.


---

5. Using Aggregate Functions

I used SQL’s built-in aggregation functions to extract useful metrics:

Average order value per customer:


SELECT customer_id, AVG(total_amount) AS avg_order_value 
FROM orders 
GROUP BY customer_id;

What I did: Found the average amount each customer spends per order.

Total revenue generated:


SELECT SUM(total_amount) AS total_revenue FROM orders;

What I did: Calculated the total income from all orders, which is a key business metric.


---

6. Creating Views for Reusability

I created a view to simplify analysis of product-level sales:

CREATE VIEW product_sales AS 
SELECT p.product_id, p.product_name, SUM(oi.quantity * p.price) AS total_sales 
FROM order_items oi 
JOIN products p ON oi.product_id = p.product_id 
GROUP BY p.product_id, p.product_name;

What I did:
Created a virtual table that summarizes **total
