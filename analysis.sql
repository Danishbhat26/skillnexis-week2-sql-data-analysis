-- SKILL NEXIS INTERNSHIP - WEEK 2: SQL FOR DATA ANALYSIS
CREATE DATABASE IF NOT EXISTS skillnexis_week2;
USE skillnexis_week2;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
 order_id INT PRIMARY KEY, customer_name VARCHAR(100), order_date DATE,
 category VARCHAR(50), sub_category VARCHAR(50), product_name VARCHAR(150),
 quantity INT, unit_price DECIMAL(10,2), total_price DECIMAL(10,2), region VARCHAR(50)
);

-- Import sales_data.csv into sales using MySQL Workbench Import Wizard.

-- 1. Basic SELECT
SELECT * FROM sales;

-- 2. COUNT
SELECT COUNT(*) AS total_orders FROM sales;

-- 3. SUM: total revenue
SELECT ROUND(SUM(total_price),2) AS total_revenue FROM sales;

-- 4. AVG: average order value
SELECT ROUND(AVG(total_price),2) AS average_order_value FROM sales;

-- 5. Top 10 customers by total spending
SELECT customer_name, ROUND(SUM(total_price),2) AS total_spent
FROM sales GROUP BY customer_name ORDER BY total_spent DESC LIMIT 10;

-- 6. Top 10 customers by number of orders
SELECT customer_name, COUNT(*) AS total_orders
FROM sales GROUP BY customer_name ORDER BY total_orders DESC LIMIT 10;

-- 7. WHERE: orders above 5,000
SELECT order_id, customer_name, total_price FROM sales
WHERE total_price > 5000 ORDER BY total_price DESC;

-- 8. Sales by region
SELECT region, ROUND(SUM(total_price),2) AS total_sales
FROM sales GROUP BY region ORDER BY total_sales DESC;

-- 9. Number of orders by region
SELECT region, COUNT(*) AS number_of_orders
FROM sales GROUP BY region ORDER BY number_of_orders DESC;

-- 10. Average order value by region
SELECT region, ROUND(AVG(total_price),2) AS average_order_value
FROM sales GROUP BY region ORDER BY average_order_value DESC;

-- 11. Sales by category
SELECT category, ROUND(SUM(total_price),2) AS total_sales
FROM sales GROUP BY category ORDER BY total_sales DESC;

-- 12. Sales by sub-category
SELECT sub_category, ROUND(SUM(total_price),2) AS total_sales
FROM sales GROUP BY sub_category ORDER BY total_sales DESC;

-- 13. Sales by region and category
SELECT region, category, ROUND(SUM(total_price),2) AS total_sales
FROM sales GROUP BY region, category ORDER BY region, total_sales DESC;

-- 14. CASE: classify order value
SELECT order_id, customer_name, total_price,
 CASE WHEN total_price >= 10000 THEN 'High Value'
      WHEN total_price >= 5000 THEN 'Medium Value'
      ELSE 'Low Value' END AS order_category
FROM sales ORDER BY total_price DESC;

-- 15. CASE + GROUP BY
SELECT CASE WHEN total_price >= 10000 THEN 'High Value'
            WHEN total_price >= 5000 THEN 'Medium Value'
            ELSE 'Low Value' END AS order_category,
       COUNT(*) AS number_of_orders
FROM sales
GROUP BY CASE WHEN total_price >= 10000 THEN 'High Value'
              WHEN total_price >= 5000 THEN 'Medium Value'
              ELSE 'Low Value' END;

-- 16. Subquery: orders above average order value
SELECT order_id, customer_name, total_price FROM sales
WHERE total_price > (SELECT AVG(total_price) FROM sales)
ORDER BY total_price DESC;

-- 17. Subquery: highest-spending customer(s)
SELECT customer_name, ROUND(SUM(total_price),2) AS total_spent
FROM sales GROUP BY customer_name
HAVING SUM(total_price) = (
 SELECT MAX(customer_total) FROM (
  SELECT customer_name, SUM(total_price) AS customer_total
  FROM sales GROUP BY customer_name
 ) AS customer_sales
);

-- 18. Monthly sales
SELECT YEAR(order_date) AS sales_year, MONTH(order_date) AS sales_month,
       ROUND(SUM(total_price),2) AS monthly_sales
FROM sales GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY sales_year, sales_month;

-- 19. JOIN: customer summary
DROP TABLE IF EXISTS customer_summary;
CREATE TABLE customer_summary AS
SELECT customer_name, region, COUNT(*) AS total_orders,
       ROUND(SUM(total_price),2) AS total_spent
FROM sales GROUP BY customer_name, region;

SELECT s.order_id, s.customer_name, s.total_price,
       c.total_orders, c.total_spent
FROM sales s
JOIN customer_summary c
 ON s.customer_name = c.customer_name AND s.region = c.region
ORDER BY c.total_spent DESC, s.order_id;
