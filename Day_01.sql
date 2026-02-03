show databases;
create database basics;
use basics;
create table table1 (
	id int primary key auto_increment,
    name varchar (20) not null,
    country varchar (20) not null,
    score int not null,
    part_of_bricks bool
);

insert into table1 values (1, 'Maria', 'Germany',350, false),
(2, 'Jhon', 'USA', 900, true),
(3, 'Georg', 'UK', 750, true),
(4, 'Awais', 'Germany',500, false);

insert into table1 (name, country, score, part_of_bricks) values
('Peter', 'USA', 0, true);

select * from table1;

select country, sum(score) as total_score, part_of_bricks
from table1
where part_of_bricks is false
group by country, part_of_bricks
having total_score >400;

select id,country, round(avg(score),2) as avg_score
from table1 
group by country, id
having avg_score >430;

select count(distinct(country)) from table1;

-- 2nd highest avg_score country
select id,country, round(avg(score),2) as avg_score
from table1 
group by country, id
having avg_score >430
order by avg_score desc
limit 1 offset 1;

-- top lowest score country
select * from table1
order by score asc
limit 3;


-- 2nd table
create table orders (
	order_id int unique auto_increment,
    customer_id int not null,
    order_date date,
    sales int not null
);

insert into orders values (1001, 1, '2021-01-11', 35),
       (1002, 2, '2021-04-05', 15);
       
insert into orders (customer_id, order_date, sales)
value
(2, '2021-06-18', 20),
(3, '2021-08-31', 10),
(4, '2021-10-25', 22),
(3, '2021-12-30', 16);


-- most recent orders
select order_date, order_id from orders
order by order_date desc limit 2;

select * from orders;
select * from table1;
-- select the customer placing order and sum of score
select distinct(t1.id), t1.name, sum(o.sales) as sum_of_sales from table1 as t1
join orders as o on 
t1.id = o.customer_id
group by o.customer_id;


select id, name, 
'New_customer' as customer_type -- static value column self created
from table1;
