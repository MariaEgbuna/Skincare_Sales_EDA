# Skincare Sales Data Exploratory Data Analysis (EDA)

---

## Project Overview

This project showcases an Exploratory Data Analysis (EDA) performed on a skincare sales dataset. The main goal was to uncover key insights into sales performance, profitability, customer behavior, and geographical market trends. By leveraging SQL queries, this analysis aims to identify strengths, weaknesses, and potential areas for strategic improvement within the business.

---

## Dataset Description

The dataset, named `Skin_Care Target.csv`, contains transactional sales data. Here are the key columns:

* **`order_id`**: Unique identifier for each transaction line item.
* **`product`**: Name of the product sold.
* **`category`**: Product category (e.g., 'Body care', 'Make up').
* **`subcategory`**: More specific product grouping (e.g., 'fragrances', 'Nail care products').
* **`sales`**: Revenue generated from the transaction.
* **`profit`**: Profit generated from the transaction.
* **`quantity`**: Number of units sold.
* **`discount`**: Discount applied to the transaction line item (numeric, e.g., 0.10 for 10%).
* **`order_date`**: Date of the order.
* **`customer_id`**: Unique identifier for the customer.
* **`segment`**: Customer segment (e.g., 'Consumer', 'Corporate').
* **`city`, `state`, `country`, `market`**: Geographical information.

---

## Tools Used

* **PostgreSQL**: Database system used for storing and querying the data.
* **SQL**: All data querying, aggregation, and analysis were performed using SQL.

---

## Key Findings & Insights

This EDA revealed several critical insights about the skincare business:

* **Profitability Discrepancies by Category:**
    * **High-Margin Winners:** `Face care` (**38.56% profit margin**) and `Make up` (**38.00% profit margin**) are highly efficient at generating profit.
    * **Sales Leader with Good Margin:** `Body care` (**24.19% profit margin**) is the highest revenue-generating category and maintains a solid profit margin.
    * **Razor-Thin Margins:** `Hair care` (**0.49% profit margin**) generates significant sales but contributes almost no profit. This category requires strategic review.
    * **Loss-Making Category:** `Home and Accessories` (**-5.17% profit margin**) is actively losing money for the business. A substantial portion of its products (652 out of 1633 unique products) are unprofitable.

* **Problematic Products & Subcategories:**
    * Specific **jewelry items** (e.g., 'Amethyst Echo Earrings') and **fragrances** (e.g., 'Versace Coco Mademoiselle') were identified as major loss drivers, often showing negative profit even without discounts.
    * The `fragrances` subcategory specifically had the **highest average discount (nearly 30%)** and a significant average loss per item.

* **Geographical Performance:**
    * **United States:** The overall dominant market in terms of both sales and profit. However, it also incurred a significant loss from the `Home and Accessories` category.
    * **Europe:** While not the highest in sales volume, Europe emerged as the **most profitable market** in 2023.
    * **Loss-Making Countries** Countries like **Turkey** and **Nigeria** (my current location) show substantial losses specifically within the `Home and Accessories` category, indicating areas for immediate review.

* **Customer Value:** The top 5 profitable customers (e.g., `EH-1376527` with $1,953 total profit) contribute significantly, highlighting the importance of high-value client retention.

* **Seasonal Trends:** The business exhibits clear seasonality, with sales dips around mid-year (July-August) and surges towards the end of the year (November-December), crucial for inventory and marketing planning.

---

## Analytical Questions Answered

This project addressed the following analytical questions using SQL queries:
    **Average Sales and Profit per Order?**,
    **Highest Average Order Value (AOV) Segment?**,
    **Distinct Products per Category?**,
    **Top 5 Customers by Profit**,
    **Subcategory with Highest Average Discount & Profit**,
    **Monthly Sales and Profit Trends**,
    **Products Sold at a Loss**,
    **Home and Accessories Losses by Country**,
    **Profit Margin Percentage per Category**.
    
## How to Replicate This Analysis

To run this analysis on your own:

1.  **PostgreSQL Database:** Ensure you have a PostgreSQL database set up.
2.  **Load Data:** Import your `Skin_Care Target.csv` dataset into a table named `skincare` in your PostgreSQL database.
3.  **Execute Queries:** Use a SQL client (like psql, DBeaver, PgAdmin, or VS Code with a PostgreSQL extension) to connect to your database. Then, execute the SQL queries provided in the [`Skincare_EDA.sql`](Skincare_EDA.sql) file.

---
