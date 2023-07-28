-- 1) Which product has the highest price? Only return a single row.
select product_name from products
where price = ( select max(price) from products);

select product_name from products
group by product_name
having max(price)
order by product_name desc
limit 1;


-- 2) Which customer has made the most orders?

Select c.first_name, c.last_name 
from customers c join orders o on c.customer_id = o.customer_id
where o.order_id = ( select max(order_id) from orders);

-- -- 3) What’s the total revenue per product?
select p.product_name, Sum(p.price * o.quantity) as revenue_per_product
from products p
join order_items o
on p.product_id = o.product_id
group by  p.product_name 
order by revenue_per_product desc;


-- 4) Find the day with the highest revenue.
select order_date, Sum(p.price * oi.quantity) as revenue_per_product
from orders o
join order_items oi
on o.order_id = oi.order_id
join products p
on p.product_id = oi.product_id
group by order_date
order by revenue_per_product desc
limit 1;


-- 5) Find the first order (by date) for each customer.

select c.customer_id, order_date, min(order_id) 
from customers c
join orders o 
on c.customer_id = o.customer_id
group by customer_id
order by customer_id;

SET SQL_SAFE_UPDATES = 0;
select @@global.sql_mode;
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');


-- 6) Find the top 3 customers who have ordered the most distinct products

Select c.customer_id, c.first_name, c.last_name, count(distinct 
oi.product_id) AS distinct_product 
From customers c
Join orders o ON c.customer_id = o.customer_id
join order_items oi ON o.order_id = oi.order_id
Group by c.customer_id, c.first_name, c.last_name
order by distinct_product desc
limit 3;


-- 7) Which product has been bought the least in terms of quantity?



Select  p.product_name, oi.product_id, SUM(quantity) AS qty
From order_items oi Join products p
On p.product_id = oi.product_id
Group BY oi.product_id, p.product_name
Order By SUM(quantity) asc;

-- 9) For each order, determine if it was ‘Expensive’ (total over 300), 
-- ‘Affordable’ (total over 100), or ‘Cheap’.

select p.product_name, Sum(p.price * o.quantity) as revenue_per_product,
case when Sum(p.price * o.quantity) > 300 then "Expensive" 
     when  Sum(p.price * o.quantity) < 300 and  Sum(p.price * o.quantity) > 100 then "Affordable"
else "Cheap" end as order_category
from products p
join order_items o
on p.product_id = o.product_id
group by  p.product_name 
order by revenue_per_product desc;
