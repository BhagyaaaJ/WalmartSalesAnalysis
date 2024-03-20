CREATE DATABASE IF NOT EXISTS salesDataWalmart;

CREATE TABLE IF NOT EXISTS sales(
invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
branch VARCHAR(5) NOT NULL,
city VARCHAR(30) NOT NULL,
customer_type VARCHAR(30) NOT NULL,
gender VARCHAR(10) NOT NULL,
product_line VARCHAR(100) NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,
quantity INT NOT NULL,
VAT FLOAT(6,4) NOT NULL,
total DECIMAL(12,4) NOT NULL,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment_method VARCHAR(15) NOT NULL,
cogs DECIMAL(10,2) NOT NULL,
gross_margin_pct FLOAT(11,9),
gross_income DECIMAL(12,4) NOT NULL,
rating FLOAT(2,1)
);



-- ---------------------------------------------------------------------------------------
-- ----------------------Feature Engineeriing-------------------------------------------

-- day_name
SELECT
    date,
    DAYNAME(date) AS day_name
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

-- month_name------------------------------------------------------------------------------------------------
SELECT
    date,
    MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);



-- ---------------------------------------------------------------------------------------------------------
-- -------------------------------------Generic Business Queries--------------------------------------------
-- How many unique city does the data have?

SELECT
DISTINCT city
FROM sales;

-- How many branches do we have?

SELECT
DISTINCT branch
FROM sales;

-- -----------------------------------------------------------------------------------------------------------------
-- ----------------------------------------Product Specific Business Queries----------------------------------------

-- Name the unique product lines the data has?

SELECT
    DISTINCT product_line
FROM sales;

-- State the number of product lines that the data has?

SELECT
    COUNT(DISTINCT product_line)
FROM sales;

-- What is the most common payment method?
SELECT
    payment_method,
    COUNT(payment_method) AS cnt
FROM sales
GROUP BY payment_method
ORDER BY cnt DESC;

-- What is the top selling product line?

SELECT
    product_line,
    COUNT(product_line) AS cnt
FROM sales
GROUP BY product_line
ORDER BY cnt DESC;

-- What is the total number of products sold this year?

SELECT
COUNT(product_line) AS Total_Sales
FROM sales;



-- What is the Total Revenue by Month?

SELECT
month_name AS month,
SUM(total) AS Total_Revenue
FROM sales
GROUP BY month
ORDER BY Total_Revenue DESC;



-- What month has the highest COGS?

SELECT
month_name AS month,
SUM(cogs) AS cogs
FROM sales
GROUP BY month
ORDER BY cogs DESC;


-- What product line has the largest revenue?

SELECT
    product_line,
    SUM(total) AS Highest_Revenue
FROM sales
GROUP by product_line
ORDER BY Highest_Revenue DESC;




-- Highest Revenue by city & branch?

SELECT
    city,
    branch,
    SUM(total) AS Highest_Revenue
FROM sales
GROUP by city,branch
ORDER BY Highest_Revenue DESC;

-- What product line has the largest VAT?

SELECT
    product_line,
    AVG(VAT) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Which branch sold more products than average product sold?

SELECT
    branch,
    SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);


-- What is the most common product line by gender?

SELECT
    gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;



-- What is the average rating of each product line?

SELECT
    product_line,
    ROUND(AVG(rating), 2) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;






-- -------------------------------------------Sales Specific Business Queries-------------------------------------------
------------------------------------------------------------------------------------------------------------------------



-- Which day the highest of quantity of products are sold ?

SELECT
    day_name AS Day,
    SUM(quantity) AS Qty
FROM sales
GROUP BY Day
ORDER BY Qty DESC;

-- Which Customer Type brings in the most Revenue?

SELECT
    customer_type,
    SUM(total) AS total_rev
FROM sales
GROUP BY customer_type
ORDER BY total_rev DESC;

-- Which city has the largest tax percent /VAT (Value Added Tax)?

SELECT
    city,
    AVG(VAT) AS avg_VAT
FROM sales
GROUP BY city
ORDER BY avg_VAT DESC;



-- Which Customer Type pays the most VAT ?

SELECT
    customer_type,
    AVG(VAT) AS avg_VAT
FROM sales
GROUP BY customer_type
ORDER BY avg_VAT DESC;


-- Which product has the highest unit price?

SELECT
    product_line,
    AVG(unit_price) AS Max_Price
FROM sales
GROUP BY product_line
ORDER BY Max_Price DESC;


-- Which product line sold the most number of items?

SELECT
    product_line,
    SUM(quantity) AS Qty
FROM sales
GROUP BY product_line
ORDER BY Qty DESC;



-- ------------------------------------------------------------------------------------------------------------------
-- ------------------------------Customer Specififc Business Queries-------------------------------------------------

-- How many unique customer types does the data have ?

SELECT
    DISTINCT(customer_type)
FROM sales;



-- How many unique payment methods do we have?

SELECT
DISTINCT(payment_method)
FROM sales;


-- Which customer type buys the most?

SELECT
    customer_type,
    SUM(quantity) AS Qtty
FROM sales
GROUP BY customer_type
ORDER BY Qtty DESC;
 
 
 -- Which is the most common type of customer type?
 
 SELECT
   customer_type,
   COUNT(*) AS count
   FROM sales
   GROUP BY customer_type;
   
   -- What is the gender of most of the customers?
   
   SELECT
       gender,
       COUNT(*) AS gndr_cnt
	FROM sales
    GROUP BY gender
    ORDER BY gndr_cnt DESC;
   
   
   -- What is the gender distribution per branch?
   
   SELECT
       gender,
       COUNT(*) AS gndr_cnt
	FROM sales
    WHERE branch = "A"
    GROUP BY gender
    ORDER BY gndr_cnt DESC;
    
    -- Which day of the week has best avg ratings ?
    SELECT
        day_name,
        AVG(rating) AS avg_rating
	FROM sales
    GROUP BY day_name
    ORDER BY avg_rating DESC;

