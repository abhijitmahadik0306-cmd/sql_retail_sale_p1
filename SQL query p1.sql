-- SQL Retail Sales Analysis - P1
CREATE DATABASE retail_sales_com;

-- CREATE TABLE
DROP TABLE IF EXISTS retail_sale
CREATE TABLE retail_sale
             (
                 transactions_id INT PRIMARY KEY,
                 sale_time TIME,
                 sale_date DATE,
                 customers_id INT,
                 gender VARCHAR(15),
                 age INT,
                 category VARCHAR(15),
                 quantity INT,
                 price_per_unit FLOAT,
                 cogs FLOAT,
                 total_sale FLOAT
                 );

SELECT * FROM retail_sale;
SELECT COUNT(*)
FROM  retail_sale;

-- DATA CLEANING 
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE 
transactions_id IS NULL
OR 
sale_date IS NULL
OR 
sale_time IS NULL
OR 
customer_id IS NULL
OR
gender IS NULL
OR 
age IS NULL
OR 
category IS NULL
OR 
quantiy IS NULL
OR 
price_per_unit IS NULL
OR 
cogs IS NULL
OR
total_sale IS NULL;

-- DATA Exploration 

-- How many sales we have 
SELECT COUNT(*) AS total_sales
FROM retail_sale;

-- How many Unique Customers we have ❔
SELECT COUNT(DISTINCT customer_id) as total_sales
 FROM retail_sale;
 
-- How Many Categories we have ❔
SELECT  DISTINCT category
 FROM retail_sale;
 
 -- Data Analysis & Business Key Promblem & answers
 
 -- Q.1 Write a sql query to retrieve all columns from sales made on '2022-11-05'
 SELECT * 
 FROM retail_sale
 WHERE sale_date = '2022-11-05';
 
 -- Q.2 Write a sql query to retrieve all transactions where the category is "clothing' and the quantity sold is more than 2  in the month of Nov-2022
 SELECT *
FROM retail_sale
WHERE category = 'Clothing'
AND quantiy >=4
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
SELECT * FROM retail_sale;
-- Q.3 Write a sql query to calculate the total sales (total_sales) for each category
SELECT category, SUM(total_sale)
FROM retail_sale
GROUP BY category
ORDER BY category desc;

-- Q.4 Write a sql query to find the average age of customers who purchased items who purchased items from the "beauty' category
SELECT category,ROUND(AVG(age),2) as avg_age
FROM retail_sale
WHERE category = 'beauty'
GROUP BY category;

-- Q.5 Write a sql query to find all transactions where the total_sale is greatar than 1000
SELECT * 
FROM retail_sale
WHERE total_sale>1000;

-- Q.6 Write a sql query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT category, gender, COUNT(*) as total_trans
FROM retail_sale
GROUP BY category, gender
ORDER BY 1;

-- Q.7 Write a sql query to calculate the average sale for each month, find out the best selling month in each year 
SELECT
    year,
    month,
    avg_sale
FROM
(
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rnk
    FROM retail_sale
    GROUP BY
        EXTRACT(YEAR FROM sale_date),
        EXTRACT(MONTH FROM sale_date)
) AS monthly_sales
WHERE rnk = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sale)
FROM retail_sale
GROUP BY 1
ORDER BY  SUM(total_sale) DESC
LIMIT 5;

-- Q.9 Write a sql query to find the number of unique customers who purchased items from each category
SELECT  category, COUNT(DISTINCT customer_id)
FROM retail_sale
GROUP BY category;

-- Q.10 Write a Write a sql query to create each shift and number of orders( example Morning <=12, Afternoon between 12 & 17, Evening >17)
SELECT *,
     CASE 
         WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
         WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
         ELSE 'Evening'
	 END as shift
FROM retail_sale;
         
-- END OF Projects





 
 
 
 
 
 

 
 
 SELECT * FROM retail_sale;



