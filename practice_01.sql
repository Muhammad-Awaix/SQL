use practice;
describe sales;
select * from sales limit 5;

-- level 01

-- Show all sales from Karachi.
select * from sales where city="Karachi";
-- Show all Electronics sales.
select * from sales where product_category="Electronics";
-- Show total number of sales.
select count(sale_id) from sales;
-- Find total revenue 
select round(sum(quantity*price),1) as total_revenue from sales;
-- Find average price per category. 
select product_category, avg(price) as avg_price 
from sales group by product_category;
-- Show top 5 most expensive sales. 
select *, quantity*price as total_revenue 
from sales order by total_revenue desc limit 5;
-- Count number of sales per city. 
select city, count(*) from sales group by city;
-- Show sales where quantity > 5. 
select * from sales where quantity>5;
-- Show total revenue per city. 
select city ,sum(quantity*price) as total_revenue 
from sales group by city order by total_revenue desc;

-- level02

-- Show total revenue per city but only cities where revenue > 50,000.
select city, sum(quantity*price) as total_revenue from sales 
group by city having total_revenue>50000;
-- Show product categories that have sold more than 100 total quantity.
select product_category,sum(quantity) as total_sold from sales 
group by product_category having total_sold>100;
-- using case statment
select *,
case 
	when (quantity * price) > 500 then 'High'
    when (quantity * price) between 200 and 500 then 'Medium'
    else 'Low'
end as total_sales
from sales;

-- show monthly based sales
select monthname(order_date) as month,sum(quantity*price)as total_sales
from sales
group by month order by total_sales desc;
-- What is the average order value per city?
select city, round(avg(quantity*price),2) as avg_order
from sales
group by city;
-- Which product category contributes the highest percentage of total revenue?
select product_category, sum(price*quantity) as total_revenue
from sales group by product_category order by total_revenue desc limit 1;



