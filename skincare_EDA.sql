-- SKINCARE Exploratory Data Analsyis

-- Total Number of orders
SELECT COUNT(*) AS total_rows
FROM skincare AS s;

-- Earliest and latest order dates (Date Range)
SELECT MIN(s.order_date) AS first_order, MAX(s.order_date) AS last_order
FROM skincare AS s;

-- Product sales and profit
SELECT s.product, SUM(s.sales) AS total_sales, SUM(s.profit) AS total_profit
FROM skincare AS s
GROUP BY s.product
ORDER BY total_sales DESC;

-- Top regions by sales/profit
SELECT s.region, SUM(s.sales) AS revenue, SUM(s.profit) AS total_profit
FROM skincare AS s
GROUP BY s.region
ORDER BY revenue DESC;

-- Product categories sales and profit
SELECT s.category, SUM(s.sales) AS total_sales, SUM(s.profit) AS total_profit
FROM skincare AS s
GROUP BY s.category;

-- Home and accessories category analysis
-- Poor performing products within 'Home and Accessories' (by profit)
SELECT product,
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profit,
	SUM(quantity) AS total_quantity,
	AVG(discount) AS average_discount_rate
FROM skincare AS s
WHERE category = 'Home and Accessories'
GROUP BY product
ORDER BY total_profit ASC;

-- Summary of Profitable vs. Unprofitable Products in 'Home and Accessories'
WITH ProductProfit AS (
    SELECT
        product,
        SUM(profit) AS total_product_profit,
        SUM(sales) AS total_product_sales
    FROM  skincare
    WHERE category = 'Home and Accessories'
    GROUP BY product
)
SELECT
    CASE
        WHEN total_product_profit < 0 THEN 'Loss Making'
        WHEN total_product_profit > 0 THEN 'Profitable'
        ELSE 'Break Even'
    END AS profit_status,
    COUNT(DISTINCT product) AS number_of_products,
    SUM(total_product_sales) AS total_sales_in_status,
    SUM(total_product_profit) AS total_profit_in_status
FROM ProductProfit
GROUP BY profit_status
ORDER BY total_profit_in_status ASC;

-- Top 10 countries by sales
SELECT s.country, SUM(s.sales) AS total_revenue, SUM(s.profit) AS total_profit
FROM skincare AS s
GROUP BY s.country
ORDER BY total_revenue DESC;
-- Key Insight: Indonesia & Turkey: The Loss-Making Countries, The USA: Dominant market.

-- What is the average sales and profit per order?
WITH OrderIDStatus AS (
	SELECT 
			s.order_id, 
			SUM(s.sales) AS total_sales, 
			SUM(s.profit) AS total_profit
	FROM skincare AS s
	GROUP BY s.order_id
)
SELECT 
	AVG(total_sales) AS avg_sales,
	AVG(total_profit) AS avg_profit
FROM OrderIDStatus;
-- This means that, on average, each order in the dataset generates about $257.27 in sales and $46.01 in profit.

-- Which segment (e.g., Consumer, Corporate, Home Office) has the highest average order value (AOV)?
WITH AOV AS (
	SELECT 
			s.segment,
			s.order_id, 
			SUM(s.sales) AS total_sales
	FROM skincare AS s
	GROUP BY s.segment, s.order_id
)
SELECT
	segment,
	AVG(total_sales) AS avg_order_value
FROM AOV
GROUP BY segment;
--Key Insight: This indicates that when corporate customers make a purchase, they tend to spend considerably more per order than individual consumers or self-employed individuals.

-- How many distinct products are sold in each category?
SELECT s.category, COUNT(DISTINCT s.product) AS product_count
FROM skincare AS s
GROUP BY s.category;

-- What is the total sales and profit for each market for the year 2023?
SELECT s.market, SUM(s.sales) AS revenue, SUM(s.profit) AS profits
FROM skincare AS s
WHERE s.order_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY s.market;
--Key Insights: Asia Pacific - Highest Revenue Market, Europe - Highest Profit Market, and Africa - Smallest Market Share

--  The top 5 customers by total profit, and what was their total sales and quantity purchased?
SELECT s.customer_id, SUM(s.profit) AS total_profit, SUM(s.sales) AS revenue, SUM(s.quantity) AS quantity_purchased
FROM skincare AS s
GROUP BY s.customer_id
ORDER BY total_profit DESC
LIMIT 5;

--  Which subcategory has the highest average discount percentage, and what is its average profit?
SELECT s.subcategory, AVG(s.discount) AS avg_discount, AVG(s.profit) AS avg_profit
FROM skincare AS s
GROUP BY s.subcategory
ORDER BY avg_discount DESC
LIMIT 10;
-- Key insights: Excessive discounting (as seen with "fragrances") can directly lead to unprofitability, even for products that might otherwise be popular. However, it also shows that some products can sustain higher discounts due to inherently better profit margins.

-- What are the total sales and total profit for each month (across all years)?
SELECT 
	EXTRACT (YEAR FROM order_date) AS years,
	EXTRACT (MONTH FROM order_date) AS months,
	SUM(s.sales) AS revenue, 
	SUM(s.profit) AS total_profit
FROM skincare AS s
GROUP BY EXTRACT (YEAR FROM order_date), EXTRACT (MONTH FROM order_date)
ORDER BY years, months;

--  Find products that have ever been sold at a loss (i.e., profit < 0), and list their total sales, total profit, and the number of times they were sold
SELECT s.product, SUM(s.sales) AS total_sales, SUM(s.profit) AS total_profit, COUNT(s.order_id) AS no_of_transactions
FROM skincare AS s
GROUP BY s.product
HAVING SUM(s.profit) < 0
ORDER BY total_profit;

-- For countries where Home and Accessories products were sold at a loss, what was the total sales and total profit from Home and Accessories in those specific countries?
WITH PoorProfitCountries AS (
	SELECT s.country, SUM(s.sales) AS revenue, SUM(s.profit) AS profits
	FROM skincare AS s
	WHERE category = 'Home and Accessories'
	GROUP BY s.country
	HAVING SUM(s.profit) < 0
)
SELECT country, revenue, profits
FROM PoorProfitCountries
ORDER BY profits;
-- Key Insights: A very long list of countries, from Honduras to Turkmenistan, are losing money on 'Home and Accessories'. This reinforces that the issue with this category isn't confined to a few regions; it's a global problem. 

-- Calculate the profit margin percentage for each category. Profit Margin = (Total Profit / Total Sales) * 100.
SELECT s.category, (SUM(s.profit * 100.0) / SUM(s.sales)) AS profit_margin_percent
FROM skincare AS s
GROUP BY s.category;
-- Key insights: Home and Accessories - The Confirmed Loss-Maker, Face Care and Make Up are the High-Margin Winners.