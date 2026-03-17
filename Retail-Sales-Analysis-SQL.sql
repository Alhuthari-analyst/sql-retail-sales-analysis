CREATE DATABASE retail_project;

USE retail_project;

-- Data imported from CSV file into MySQL
-- Dataset contains 1000 retail transactions

ALTER TABLE sales
ADD COLUMN Date2 DATE;

UPDATE sales
SET Date2 = STR_TO_DATE(`Date`, '%m/%d/%Y');

CREATE TABLE products (
    `Product Category` VARCHAR(50),
    `Product Name` VARCHAR(50),
    Supplier VARCHAR(50),
    `Cost Per Unit` DECIMAL(5,2)
  );

INSERT INTO products VALUES
('Beauty', 'Perfume', 'Loreal', 50),
('Beauty', 'Cream', 'Dove', 30),
('Electronics', 'Laptop', 'Dell', 150),
('Electronics', 'Headphones', 'Sony', 80),
('Clothing', 'T-Shirt', 'H&M', 20),
('Clothing', 'Cap', 'Zara', 40);

-- Which product category generates the highest total sales revenue?
SELECT `Product Category`,
SUM(`Total Amount`) AS total_revenue
FROM sales
GROUP BY `Product Category`
ORDER BY total_revenue DESC;

-- What is the average total amount per product category?
SELECT `Product Category`,
AVG(`Total Amount`) AS avg_order_value
FROM sales
GROUP BY `Product Category`
ORDER BY avg_order_value DESC;

-- How can customers be segmented based on their spending level?
SELECT 
CASE
WHEN `Total Amount` < 100 THEN 'Low Spending'
WHEN `Total Amount` BETWEEN 100 AND 500 THEN 'Medium Spending'
ELSE 'High Spending'
END AS spending_level,
COUNT(*) AS total_orders
FROM sales
GROUP BY spending_level;

-- Which age group spends the most in total?
SELECT `Age Group`,
SUM(`Total Amount`) AS total_revenue
FROM sales
GROUP BY `Age Group`
ORDER BY total_revenue DESC;

-- How does purchasing behavior differ by gender?
SELECT Gender,
    COUNT(*) AS total_orders,
    SUM(`Total Amount`) AS total_revenue, 
    AVG(`Total Amount`) AS avg_order_value,
    SUM(s.`Total Amount` - p.`Cost Per Unit` * s.Quantity) AS total_profit 
FROM sales s JOIN products p 
ON s.`Product Category` = p.`Product Category`
and s.`Product Name` = p.`Product Name`
GROUP BY Gender
ORDER BY total_revenue DESC;

-- How do product categories compare in terms of total revenue,
-- number of transactions, and average order value?
SELECT 
    `Product Category`,
    COUNT(*) AS total_orders, 
    SUM(`Total Amount`) AS total_revenue, 
    AVG(`Total Amount`) AS avg_order_value
FROM sales
GROUP BY `Product Category`
ORDER BY avg_order_value DESC;

-- Which products are high-performing in terms of total revenue and number of orders?
SELECT 
    `Product Name`,
    COUNT(*) AS number_of_orders,
    SUM(`Total Amount`) AS total_revenue
FROM sales
GROUP BY `Product Name`
HAVING SUM(`Total Amount`) > 50000
ORDER BY total_revenue DESC;

-- Which products generate the highest total profit?
SELECT s.`Product Name`,
  SUM(s.`Total Amount` - p.`Cost Per Unit` * s.Quantity) AS total_profit
FROM sales s JOIN products p
ON s.`Product Category` = p.`Product Category`
AND s.`Product Name` = p.`Product Name`
GROUP BY s.`Product Name`
ORDER BY total_profit DESC;

-- What are the top 3 most profitable transactions in each product category?
SELECT * FROM 
(SELECT s.`Product Category`,
(s.`Total Amount` - p.`Cost Per Unit` * s.Quantity) AS total_profit,
ROW_NUMBER() OVER(PARTITION BY s.`Product Category` 
     ORDER BY (s.`Total Amount` - p.`Cost Per Unit` * s.Quantity) DESC) AS profit_rank
FROM sales s JOIN products p
ON s.`Product Category` = p.`Product Category`
AND s.`Product Name` = p.`Product Name`) t
WHERE profit_rank <= 3;


-- Which transactions resulted in a financial loss?
SELECT * FROM 
(SELECT s.`Product Name`, s.Quantity, s.`Total Amount`, p.`Cost Per Unit`,
(s.`Total Amount` - p.`Cost Per Unit` * s.Quantity) AS total_profit
FROM sales s JOIN products p
ON s.`Product Category` = p.`Product Category`
AND s.`Product Name` = p.`Product Name`) t
WHERE total_profit < 0;

-- Total revenue per month
SELECT MONTHNAME(Date2) AS month,
       SUM(`Total Amount`) AS total_revenue
FROM sales
GROUP BY MONTH(Date2), MONTHNAME(Date2)
ORDER BY MONTH(Date2);

-- Which months generated the highest total profit?
SELECT MONTHNAME(s.Date2) AS month,
SUM(s.`Total Amount` - p.`Cost Per Unit` * s.Quantity) AS total_profit
FROM sales s JOIN products p
ON s.`Product Category` = p.`Product Category`
AND s.`Product Name` = p.`Product Name`
GROUP BY month
ORDER BY total_profit DESC;
