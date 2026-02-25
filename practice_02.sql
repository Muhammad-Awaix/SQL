use big_project;

select u.name,u.email,r.*,p.partner_name,o.amount from orders as o 
inner join users as u on o.user_id=u.user_id 
inner join restaurants as r on o.r_id=r.r_id 
inner join delivery_partner as p on p.partner_id=o.partner_id;

select r.r_name from restaurants r 
left join orders o on r.r_id = o.r_id 
where o.r_id is null;

-- how many each user spend
select * from orders;
select * from users;

select u.name, sum(amount) as total_spending from orders o 
join users u on o.user_id=u.user_id
group by u.name order by total_spending desc;

-- level 02
use practice;
create table users (
    user_id int primary key,
    name varchar(50),
    city varchar(50),
    email varchar(100)
);
insert into users values
(1, 'Ali', 'Karachi', 'ali@gmail.com'),
(2, 'Sara', 'Lahore', 'sara@gmail.com'),
(3, 'Ahmed', 'Karachi', null),
(4, 'Zara', 'Islamabad', 'zara@gmail.com'),
(5, 'Usman', 'Lahore', 'usman@gmail.com'),
(6, 'Hina', 'Karachi', null),
(7, 'Bilal', 'Islamabad', 'bilal@gmail.com'),
(8, 'Ayesha', 'Karachi', 'ayesha@gmail.com'),
(9, 'Omar', 'Lahore', 'omar@gmail.com'),
(10, 'Noor', 'Multan', null);
create table restaurants (
    r_id int primary key,
    r_name varchar(50),
    city varchar(50),
    rating decimal(2,1)
);
insert into restaurants values
(101, 'KFC', 'Karachi', 4.2),
(102, 'McDonalds', 'Lahore', 4.0),
(103, 'PizzaHut', 'Islamabad', 3.8),
(104, 'Subway', 'Karachi', null),
(105, 'Hardees', 'Lahore', 4.5),
(106, 'Dominos', 'Multan', 4.1),
(107, 'BurgerLab', 'Karachi', 4.3),
(108, 'Cheezious', 'Islamabad', null);
create table orders (
    order_id int primary key,
    user_id int,
    r_id int,
    amount decimal(10,2),
    order_date date,
    foreign key (user_id) references users(user_id),
    foreign key (r_id) references restaurants(r_id)
);
insert into orders values
(1001, 1, 101, 1500, '2024-01-05'),
(1002, 2, 102, 2200, '2024-01-10'),
(1003, 1, 107, 1800, '2024-02-02'),
(1004, 3, 101, 900, '2024-02-05'),
(1005, 4, 103, 2500, '2024-02-12'),
(1006, 5, 105, 3000, '2024-03-01'),
(1007, 6, 104, 1100, '2024-03-07'),
(1008, 7, 103, 2750, '2024-03-12'),
(1009, 8, 101, 1600, '2024-04-01'),
(1010, 9, 102, 2000, '2024-04-08'),
(1011, 1, 101, 1300, '2024-04-12'),
(1012, 2, 105, 3400, '2024-05-01'),
(1013, 3, 107, 2100, '2024-05-03'),
(1014, 5, 102, 1900, '2024-05-15'),
(1015, 8, 104, 1200, '2024-06-01'),
(1016, 9, 101, 1700, '2024-06-05'),
(1017, 1, 107, 2600, '2024-06-10'),
(1018, 2, 103, 2800, '2024-06-12'),
(1019, 7, 101, 2300, '2024-07-01'),
(1020, 6, 105, 3100, '2024-07-04'),
(1021, 3, 101, null, '2024-07-10');


select * from users;
select * from orders;
select * from restaurants;

-- Find total spending per user.
select u.name, sum(amount) as total_spending from orders o
left join users u on u.user_id=o.user_id
group by u.name order by total_spending desc;

-- Find users who never placed an order.
select distinct(u.name) from users u 
left join orders o on u.user_id = o.user_id
where o.user_id is null;

-- 	Find restaurants that never received an order.
select (r.r_name) from restaurants r 
left join orders o on r.r_id = o.r_id
where o.r_id is null;

-- Find total revenue per city (restaurant city).
select u.city, sum(amount) as total_revenue from orders o
left join users u on u.user_id = o.user_id
group by u.city order by total_revenue desc;

-- Find average order amount (handle NULL properly)
use practice;
-- Find users who ordered from more than 1 restaurant.
select u.name, count(o.order_id) as number_of_orders from users u
join orders o on u.user_id=o.user_id
group by u.name 
having number_of_orders >1
order by number_of_orders desc;
-- 
select u.user_id,
       u.name,
       count(distinct o.r_id) as restaurant_count
from users u
join orders o 
    on u.user_id = o.user_id
group by u.user_id, u.name
having count(distinct o.r_id) > 1
order by restaurant_count desc;

-- using windows function


