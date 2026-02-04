show databases;
use join_practice_2;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    city VARCHAR(50)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, customer_name, email, city)
VALUES 
    (1, 'John Smith', 'john@example.com', 'New York'),
    (2, 'Jane Doe', 'jane@example.com', 'Los Angeles'),
    (3, 'Robert Johnson', 'robert@example.com', 'Chicago'),
    (4, 'Emily Davis', 'emily@example.com', 'Houston'),
    (5, 'Michael Brown', 'michael@example.com', 'Phoenix');
INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES 
    (101, 1, '2023-01-15', 150.75),
    (102, 3, '2023-01-16', 89.50),
    (103, 1, '2023-01-20', 45.25),
    (104, 2, '2023-01-25', 210.30),
    (105, 3, '2023-02-01', 75.00);
    
show tables;
select * from customers;
select * from orders;

-- Get all customers and their orders (if any)
select c.customer_name, sum(o.total_amount) as total_purchase
from customers c left join
orders o on c.customer_id = o.customer_id
group by c.customer_id
order by total_purchase desc;

-- Finding customers with no orders
select c.customer_name, c.customer_id
from customers c left join
orders o on c.customer_id = o.customer_id
where o.order_id is null;

-- Get customer order counts and total spending
select c.customer_id,c.customer_name, sum(o.total_amount) as total_purchase, count(o.order_id) as total_orders
from customers c left join
orders o on c.customer_id = o.customer_id
group by c.customer_id
order by total_purchase desc;

CREATE TABLE shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    shipping_date DATE,
    carrier VARCHAR(50),
    tracking_number VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO shipping (shipping_id, order_id, shipping_date, carrier, tracking_number)
VALUES 
    (1001, 101, '2023-01-16', 'FedEx', 'FDX123456789'),
    (1002, 104, '2023-01-26', 'UPS', 'UPS987654321'),
    (1003, 105, '2023-02-02', 'USPS', 'USPS456789123');
    
show tables;
select * from customers;
select * from orders;
select * from shipping;

-- Get customers, their orders, and shipping information
SELECT c.customer_name,o.order_id,o.order_date,o.total_amount,s.carrier,s.tracking_number
FROM customers c
LEFT JOIN 
    orders o ON c.customer_id = o.customer_id
LEFT JOIN 
    shipping s ON o.order_id = s.order_id;
    
-- Flitring
SELECT c.customer_name,o.order_id,o.order_date,o.total_amount,s.carrier,s.tracking_number
FROM customers c
LEFT JOIN 
    orders o ON c.customer_id = o.customer_id
LEFT JOIN 
    shipping s ON o.order_id = s.order_id
where o.order_id is not null;

-- Find customers who haven't ordered in the past 30 days

select c.customer_id, c.customer_name, max(o.order_date) as last_order_date
from customers c left join orders o on 
c.customer_id = o.customer_id
group by c.customer_id
having last_order_date is null or 
last_order_date < date_sub(curdate(), interval 30 day);	