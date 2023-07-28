-- Case Study Questions

-- 1) Which product has the highest price? Only return a single row.

select product_name from products
where price = ( select max(price) from products);


-- 2) Which customer has made the most orders?


-- 3) What’s the total revenue per product?

-- 4) Find the day with the highest revenue.

-- 5) Find the first order (by date) for each customer.

-- 6) Find the top 3 customers who have ordered the most distinct products

-- 7) Which product has been bought the least in terms of quantity?

-- 8) What is the median order total?

-- 9) For each order, determine if it was ‘Expensive’ (total over 300), ‘Affordable’ (total over 100), or ‘Cheap’.

-- 10) Find customers who have ordered the product with the highest price.


