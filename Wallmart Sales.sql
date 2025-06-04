create database walmartSales;

USE walmartSales;

-- Create table

CREATE TABLE  sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT,
    gross_income DECIMAL(12, 4),
    rating FLOAT
);
LOAD DATA INFILE 'C:/PowerBI Project/Wallmart.csv'
INTO TABLE sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- View data
SELECT * FROM sales;

-- Add time_of_day column
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
UPDATE sales
SET time_of_day = (
    CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END
);

-- Add day_name column
ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
UPDATE sales SET day_name = DAYNAME(date);

-- Add month_name column
ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales SET month_name = MONTHNAME(date);

-- Generic Queries
SELECT DISTINCT city FROM sales;
SELECT DISTINCT city, branch FROM sales;

-- Product Queries
SELECT DISTINCT product_line FROM sales;

SELECT SUM(quantity) AS qty, product_line FROM sales GROUP BY product_line ORDER BY qty DESC;

SELECT month_name AS month, SUM(total) AS total_revenue FROM sales GROUP BY month_name ORDER BY total_revenue DESC;

SELECT month_name AS month, SUM(cogs) AS cogs FROM sales GROUP BY month_name ORDER BY cogs DESC;

SELECT product_line, SUM(total) AS total_revenue FROM sales GROUP BY product_line ORDER BY total_revenue DESC;

SELECT branch, city, SUM(total) AS total_revenue FROM sales GROUP BY city, branch ORDER BY total_revenue DESC;

SELECT product_line, AVG(tax_pct) AS avg_tax FROM sales GROUP BY product_line ORDER BY avg_tax DESC;

-- Remark based on quantity
SELECT AVG(quantity) AS avg_qnty FROM sales;
SELECT product_line,
    CASE WHEN AVG(quantity) > 6 THEN 'Good' ELSE 'Bad' END AS remark
FROM sales GROUP BY product_line;

-- Branch performance
SELECT branch, SUM(quantity) AS qnty FROM sales GROUP BY branch HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- Gender-based insights
SELECT gender, product_line, COUNT(gender) AS total_cnt FROM sales GROUP BY gender, product_line ORDER BY total_cnt DESC;
SELECT ROUND(AVG(rating), 2) AS avg_rating, product_line FROM sales GROUP BY product_line ORDER BY avg_rating DESC;

-- Customer Queries
SELECT DISTINCT customer_type FROM sales;

SELECT DISTINCT payment FROM sales;

SELECT customer_type, COUNT(*) AS count FROM sales GROUP BY customer_type ORDER BY count DESC;

SELECT customer_type, COUNT(*) FROM sales GROUP BY customer_type;

SELECT gender, COUNT(*) AS gender_cnt FROM sales GROUP BY gender ORDER BY gender_cnt DESC;

SELECT gender, COUNT(*) AS gender_cnt FROM sales WHERE branch = 'C' GROUP BY gender ORDER BY gender_cnt DESC;

-- Time-based rating insights
SELECT time_of_day, AVG(rating) AS avg_rating FROM sales GROUP BY time_of_day ORDER BY avg_rating DESC;

SELECT time_of_day, AVG(rating) AS avg_rating FROM sales WHERE branch = 'A' GROUP BY time_of_day ORDER BY avg_rating DESC;

SELECT day_name, AVG(rating) AS avg_rating FROM sales GROUP BY day_name ORDER BY avg_rating DESC;

SELECT day_name, COUNT(day_name) AS total_sales FROM sales WHERE branch = 'C' GROUP BY day_name ORDER BY total_sales DESC;

-- Sales performance by time
SELECT time_of_day, COUNT(*) AS total_sales FROM sales WHERE day_name = 'Sunday' GROUP BY time_of_day ORDER BY total_sales DESC;

-- Revenue by customer type
SELECT customer_type, SUM(total) AS total_revenue FROM sales GROUP BY customer_type ORDER BY total_revenue DESC;

-- VAT / Tax insights
SELECT city, ROUND(AVG(tax_pct), 2) AS avg_tax_pct FROM sales GROUP BY city ORDER BY avg_tax_pct DESC;
SELECT customer_type, AVG(tax_pct) AS total_tax FROM sales GROUP BY customer_type ORDER BY total_tax;


 -- Total number of sales
SELECT COUNT(*) AS total_sales FROM sales;

-- Total gross income
SELECT SUM(gross_income) AS total_gross_income FROM sales;

--  Average unit price per product line
SELECT product_line, ROUND(AVG(unit_price),2) AS avg_unit_price FROM sales GROUP BY product_line;

--  Monthly gross income trend
SELECT month_name, SUM(gross_income) AS total_gross_income FROM sales GROUP BY month_name ORDER BY FIELD(month_name,'January','February','March','April','May','June','July','August','September','October','November','December');

--  Payment method distribution
SELECT payment, COUNT(*) AS total_transactions FROM sales GROUP BY payment ORDER BY total_transactions DESC;

--  Best-selling product in each branch
SELECT branch, product_line, SUM(quantity) AS total_sold
FROM sales
GROUP BY branch, product_line
ORDER BY branch, total_sold DESC;

--  Branch with highest average rating
SELECT branch, ROUND(AVG(rating),2) AS avg_rating FROM sales GROUP BY branch ORDER BY avg_rating DESC;

--  Revenue per product line per city
SELECT city, product_line, SUM(total) AS total_revenue
FROM sales
GROUP BY city, product_line
ORDER BY city, total_revenue DESC;

--  Most popular day for each branch
SELECT branch, day_name, COUNT(*) AS total_sales
FROM sales
GROUP BY branch, day_name
ORDER BY branch, total_sales DESC;

--  Average gross margin percentage per product line
SELECT product_line, ROUND(AVG(gross_margin_pct)*100, 2) AS avg_gross_margin_pct
FROM sales
GROUP BY product_line
ORDER BY avg_gross_margin_pct DESC;

--  Average quantity sold per payment method
SELECT payment, ROUND(AVG(quantity), 2) AS avg_quantity
FROM sales
GROUP BY payment
ORDER BY avg_quantity DESC;

--  Top 5 most profitable invoices
SELECT invoice_id, gross_income
FROM sales
ORDER BY gross_income DESC
LIMIT 5;
