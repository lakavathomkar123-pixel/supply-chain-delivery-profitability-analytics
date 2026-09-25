-- Supply Chain Delivery & Profitability Analytics
-- 8 Critical SQL Queries
-- Dataset: DataCo Smart Supply Chain (Kaggle)

-- QUERY 1: Late Delivery Rate (%)
SELECT 
    COUNT(*) as total_orders,
    SUM(CASE WHEN `Delivery_Status` = 'Late delivery' THEN 1 ELSE 0 END) as late_orders,
    ROUND(100.0 * SUM(CASE WHEN `Delivery_Status` = 'Late delivery' THEN 1 ELSE 0 END) / COUNT(*), 2) as late_percentage
FROM datacosupplychaindataset;

-- QUERY 2: Late Delivery % by Shipping Mode
SELECT 
    `Shipping Mode`,
    COUNT(*) as total_orders,
    SUM(CASE WHEN `Delivery_Status` = 'Late delivery' THEN 1 ELSE 0 END) as late_orders,
    ROUND(100.0 * SUM(CASE WHEN `Delivery_Status` = 'Late delivery' THEN 1 ELSE 0 END) / COUNT(*), 2) as late_percentage
FROM datacosupplychaindataset
GROUP BY `Shipping Mode`
ORDER BY late_percentage DESC;

-- QUERY 3: Total Profit by Product Category
SELECT 
    `Product_category`,
    COUNT(*) as order_count,
    ROUND(SUM(`Profit`), 2) as total_profit,
    ROUND(AVG(`Profit`), 2) as avg_profit_per_order
FROM datacosupplychaindataset
GROUP BY `Product_category`
ORDER BY total_profit DESC;

-- QUERY 4: Top Profit Regions
SELECT 
    `Market`,
    COUNT(*) as order_count,
    ROUND(SUM(`Profit`), 2) as total_profit
FROM datacosupplychaindataset
GROUP BY `Market`
ORDER BY total_profit DESC
LIMIT 10;

-- QUERY 5: Profit by Delivery Status
SELECT 
    `Delivery_Status`,
    COUNT(*) as order_count,
    ROUND(AVG(`Profit`), 2) as avg_profit
FROM datacosupplychaindataset
GROUP BY `Delivery_Status`;

-- QUERY 6: Monthly Trends
SELECT 
    DATE_FORMAT(`Order_Date`, '%Y-%m') as month,
    COUNT(*) as order_count,
    ROUND(SUM(`Profit`), 2) as monthly_profit
FROM datacosupplychaindataset
GROUP BY DATE_FORMAT(`Order_Date`, '%Y-%m')
ORDER BY month;

-- QUERY 7: Top Products
SELECT 
    `Product_Name`,
    `Product_category`,
    COUNT(*) as order_count,
    ROUND(SUM(`Profit`), 2) as total_profit
FROM datacosupplychaindataset
GROUP BY `Product_Name`, `Product_category`
ORDER BY total_profit DESC
LIMIT 15;

-- QUERY 8: Shipping Mode Analysis
SELECT 
    `Shipping Mode`,
    `Delivery_Status`,
    COUNT(*) as order_count
FROM datacosupplychaindataset
GROUP BY `Shipping Mode`, `Delivery_Status`
ORDER BY `Shipping Mode`;
