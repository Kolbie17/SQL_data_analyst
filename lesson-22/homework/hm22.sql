SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date ROWS UNBOUNDED PRECEDING) AS running_total_sales
FROM sales_data
ORDER BY customer_id, order_date;


SELECT 
    product_category,
    COUNT(*) AS order_count
FROM sales_data
GROUP BY product_category;

SELECT 
    product_category,
    MAX(total_amount) AS max_total_amount
FROM sales_data
GROUP BY product_category;



SELECT 
    product_category,
    MIN(unit_price) AS min_unit_price
FROM sales_data
GROUP BY product_category;

SELECT 
    order_date,
    total_amount,
    AVG(total_amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg_3_days
FROM sales_data
ORDER BY order_date;

SELECT 
    region,
    SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;

SELECT 
    customer_id,
    customer_name,
    SUM(total_amount) AS total_purchase_amount,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS purchase_rank
FROM sales_data
GROUP BY customer_id, customer_name
ORDER BY purchase_rank;


SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS difference_from_prev_sale
FROM sales_data
ORDER BY customer_id, order_date;


SELECT 
    product_category,
    product_name,
    unit_price
FROM (
    SELECT
        product_category,
        product_name,
        unit_price,
        ROW_NUMBER() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS rn
    FROM sales_data
) sub
WHERE rn <= 3
ORDER BY product_category, unit_price DESC;


SELECT 
    region,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date ROWS UNBOUNDED PRECEDING) AS cumulative_sales
FROM sales_data
ORDER BY region, order_date;


SELECT
    product_category,
    order_date,
    SUM(total_amount) OVER (
        PARTITION BY product_category 
        ORDER BY order_date 
        ROWS UNBOUNDED PRECEDING
    ) AS cumulative_revenue
FROM sales_data
ORDER BY product_category, order_date;


SELECT
    Value,
    SUM(Value) OVER (ORDER BY (SELECT NULL) ROWS UNBOUNDED PRECEDING) AS running_sum
FROM OneColumn;


SELECT customer_id, customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;


WITH region_avg AS (
    SELECT region, AVG(total_amount) AS avg_spending
    FROM sales_data
    GROUP BY region
)
SELECT s.customer_id, s.customer_name, s.region, SUM(s.total_amount) AS total_spending
FROM sales_data s
JOIN region_avg r ON s.region = r.region
GROUP BY s.customer_id, s.customer_name, s.region, r.avg_spending
HAVING SUM(s.total_amount) > r.avg_spending;


SELECT 
    customer_id,
    customer_name,
    region,
    SUM(total_amount) AS total_spending,
    RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS region_rank
FROM sales_data
GROUP BY customer_id, customer_name, region
ORDER BY region, region_rank;


SELECT 
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date ROWS UNBOUNDED PRECEDING) AS cumulative_sales
FROM sales_data
ORDER BY customer_id, order_date;


WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS sales_month,
        SUM(total_amount) AS total_sales
    FROM sales_data
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT 
    sales_month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY sales_month) AS prev_month_sales,
    CASE 
        WHEN LAG(total_sales) OVER (ORDER BY sales_month) IS NULL THEN NULL
        ELSE (total_sales - LAG(total_sales) OVER (ORDER BY sales_month)) * 100.0 / LAG(total_sales) OVER (ORDER BY sales_month)
    END AS growth_rate_percentage
FROM monthly_sales
ORDER BY sales_month;



SELECT 
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_amount
FROM sales_data
WHERE total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date);


SELECT DISTINCT
    product_name,
    product_category,
    unit_price
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data);


SELECT
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL
    END AS Sum_Val1_Val2_Per_Group
FROM MyData
ORDER BY Grp, Id;


