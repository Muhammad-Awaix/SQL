-- Joins 

CREATE DATABASE join_practice;
USE join_practice;

-- 1st table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    country VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Awais', 'Pakistan'),
(2, 'Ali', 'India'),
(3, 'Sara', 'USA'),
(4, 'John', 'UK');

-- 2nd table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount INT
);
INSERT INTO orders VALUES
(101, 1, 200),
(102, 1, 150),
(103, 2, 300),
(104, 5, 400);

-- 3rd table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    status VARCHAR(20)
);
INSERT INTO payments VALUES
(201, 1, 'Paid'),
(202, 3, 'Pending'),
(203, 6, 'Paid');



-- practice questions
select * from customers;
select * from orders;
select * from payments;

-- Show customer name and order amount (Only customers who have orders)
select c.name, o.amount from customers c
inner join orders o on c.customer_id = o.customer_id;

-- Show all customers and their order amounts, even if they don’t have orders.
select c.name, o.amount from customers c
left join orders o on c.customer_id = o.customer_id;

-- Find customers who never placed an order
select c.name, o.amount from customers c
left join orders o on c.customer_id = o.customer_id
where amount is null;

-- customer name, order amount, payment status
SELECT c.name, o.amount, p.status
FROM customers c
JOIN orders o
  ON c.customer_id = o.customer_id
JOIN payments p 
  ON c.customer_id = p.customer_id;
  
-- Show: customer name, order amount, payment status
-- Include all customers who have orders, but if payment is missing → NULL for status

select c.name , o.amount, p.status
from customers c join orders o on 
c.customer_id = o.customer_id
left join payments p
on c.customer_id = p.customer_id;
  


