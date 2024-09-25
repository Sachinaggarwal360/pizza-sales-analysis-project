-- DATA PROCESSING --

select * from pizza;



SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME ='pizza';


ALTER TABLE  pizza
MODIFY COLUMN order_date DATE;

ALTER TABLE  pizza
MODIFY COLUMN order_time TIME;


-- ------------------------------------------------------- --
-- --------------------------Q/A-------------------------- --
-- ------------------------------------------------------- --


-- 1. Total Revenue: --

SELECT ROUND(SUM(total_price),0) AS total_revenue FROM pizza;



-- 2. Average Order Value  --

WITH cte AS 
		(SELECT order_id AS 'no_of_order', SUM(total_price) AS total_order_value FROM pizza
		GROUP BY no_of_order)
        
SELECT ROUND(SUM(total_order_value)/COUNT(no_of_order), 2 )
AS average_order_value FROM cte;




-- 3. Total Pizzas Sold --

SELECT COUNT(quantity) AS total_pizzas_sold FROM pizza;




-- 4. Total Orders --

SELECT COUNT(DISTINCT(order_id)) AS No_of_orders FROM pizza;




-- 5. Average Pizzas Per Order --

WITH cte AS (
		SELECT DISTINCT(order_id) AS no_of_orders, SUM(quantity) no_of_pizzas FROM pizza
		GROUP BY no_of_orders)
        
SELECT  ROUND(SUM(no_of_pizzas)/COUNT(no_of_orders) , 2) AS avg_pizza_per_order FROM cte;




-- ------------------------------------------------------------ --
-- ------------------------------------------------------------ --
-- ------------------------------------------------------------ --



-- B. Daily Trend for Total Orders --

SELECT DAYNAME(order_date) AS Days, COUNT(DISTINCT(order_id)) AS no_of_orders FROM pizza
GROUP BY days
ORDER BY no_of_orders DESC;



-- C. Monthly Trend for Orders --

SELECT MONTHNAME(order_date) AS months, COUNT(DISTINCT(order_id)) AS no_of_orders FROM pizza
GROUP BY months
ORDER BY no_of_orders DESC;



-- D. % of Sales by Pizza Category--


SELECT pizza_category,  ROUND(SUM(total_price),2 ) AS total_revenue,
CONCAT(ROUND(ROUND(SUM(total_price),2 )*100.00/
(SELECT SUM(total_price) FROM pizza),2), '%') AS 'sales_pct'
FROM pizza
GROUP BY pizza_category;




-- E. % of Sales by Pizza Size --

SELECT pizza_size, ROUND((ROUND(SUM(total_price),2)*100.00)/
(SELECT SUM(total_price) FROM pizza),2) AS '%_of_sales' 
FROM pizza
GROUP By pizza_size;




-- G. Top 5 Pizzas by Revenue --

SELECT  pizza_name, ROUND(SUM(total_price),1) AS revenue FROM pizza
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;




-- G. Bottom 5 Pizzas by Revenue --

SELECT  pizza_name, ROUND(SUM(total_price),1) AS revenue FROM pizza
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5;


-- I. Top 5 Pizzas by Quantity --

SELECT  pizza_name, SUM(quantity) AS revenue FROM pizza
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- J. Bottom 5 Pizzas by Quantity --

SELECT  pizza_name, SUM(quantity) AS revenue FROM pizza
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5;




--  K. Top 5 Pizzas by Total Orders --

SELECT  pizza_name, COUNT(DISTINCT(order_id)) AS revenue FROM pizza
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;



--  L. Bottom 5 Pizzas by Total Orders --

SELECT  pizza_name, COUNT(DISTINCT(order_id)) AS revenue FROM pizza
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5;

