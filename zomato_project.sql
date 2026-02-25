use big_project;
select * from users;
select * from orders;

-- Find customers who have never ordered
select u.user_id,u.name from users u left join orders o
on u.user_id=o.user_id
where o.user_id is null;
-- or 
select name from users 
where user_id not in (select user_id from orders);

select * from menu;
select * from food;

-- Average Price/dish
select f.f_name, avg(m.price) as avg_price from food f 
join menu m on m.f_id=f.f_id
group by f.f_name;
-- or 
select f_id, avg(price) from menu group by f_id; 

select * from orders;
select * from restaurants;
-- Find the top restaurant in terms of the number of orders.
select r.r_name,
       count(o.order_id) as n_order
from restaurants r
join orders o on o.r_id = r.r_id
where monthname(date) ='June'
group by r.r_name
order by n_order desc;

-- Find the top restaurant in terms of the number of orders for a given month
select r_id,count(order_id) as n_orders from orders 
where monthname(date) = 'June'
group by r_id
order by n_orders desc limit 0,1;
 
-- restaurant name with monthly sales > x
select r.r_id,r.r_name, sum(o.amount) as total_sales
from restaurants r
left join orders o on r.r_id = o.r_id
group by r.r_id, r.r_name
order by total_sales desc;

-- in a specific month sales > 1000
select r.r_name, sum(o.amount) as total_revenue from restaurants r
join orders o on r.r_id = o.r_id
where monthname(o.date) = 'June' 
group by r.r_name
having sum(o.amount)>500
order by total_revenue desc;

-- give all the order detail of a specific customer on a specific date
select * from users;
select * from orders;
select * from order_details;
-- give all the order detail of a customer has id = 1 on july
select o.order_id,o1.f_id,m.price,f.f_name,o.date from orders o 
join order_details o1 on o.order_id = o1.order_id
join menu m on m.f_id = o1.f_id
join food f on f.f_id = o1.f_id
where o.user_id=4
and (date > '2022-06-10' and date<'2022-07-10');

-- find the restaurant that has max repeated customers
with sales as (
    select month(date) as month_no,
           monthname(date) as month_name,
           sum(amount) as total_revenue
    from orders
    group by month_no, month_name
)

select month_name,
       total_revenue,
       lag(total_revenue) over (order by month_no) as previous_month_revenue,
       
       round(
           (total_revenue - lag(total_revenue) over (order by month_no))
           / lag(total_revenue) over (order by month_no) * 100
       ,2) as growth_percentage

from sales
order by month_no;