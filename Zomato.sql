create database Zomato;
use Zomato;
select * from `zomato_dataset` LIMIT 10;

/* 1. Total Rows vs. Unique Rows (Find Duplicates Count) */

SELECT 
    (SELECT COUNT(*) FROM `zomato_dataset`) AS total_rows,
    (SELECT COUNT(DISTINCT CONCAT_WS('|', `Restaurant_Name`, `Dining_Rating`, `Delivery_Rating`, `Dining Votes`, `Delivery_Votes`,
    `Cuisine`, `Place_Name`, `City`,`Item_Name`, `Best_Seller`, `Votes`, `Prices`)) 
    FROM `zomato_dataset`) AS unique_rows,
    (SELECT COUNT(*) FROM `zomato_dataset`) - 
    (SELECT COUNT(DISTINCT CONCAT_WS('|',`Restaurant_Name`, `Dining_Rating`, `Delivery_Rating`, `Dining Votes`, `Delivery_Votes`,
    `Cuisine`, `Place_Name`, `City`,`Item_Name`, `Best_Seller`, `Votes`, `Prices`)) 
    FROM `zomato_dataset`) AS duplicate_count;

/* 2. List All Duplicate Records */

SELECT 
    `Restaurant_Name`, `Dining_Rating`, `Delivery_Rating`, `Dining Votes`, `Delivery_Votes`,
    `Cuisine`, `Place_Name`, `City`,`Item_Name`, `Best_Seller`, `Votes`, `Prices`,
    COUNT(*) AS occurrence
FROM `zomato_dataset`
GROUP BY 
    `Restaurant_Name`, `Dining_Rating`, `Delivery_Rating`, `Dining Votes`, `Delivery_Votes`,
    `Cuisine`, `Place_Name`, `City`,`Item_Name`, `Best_Seller`, `Votes`, `Prices`
HAVING COUNT(*) > 1;

/* 3. Count of Duplicates Only */

SELECT 
    SUM(occurrence - 1) AS duplicate_count
FROM (
    SELECT 
        COUNT(*) AS occurrence
    FROM `zomato_dataset`
    GROUP BY 
        `Restaurant_Name`, `Dining_Rating`, `Delivery_Rating`, `Dining Votes`, `Delivery_Votes`,
    `Cuisine`, `Place_Name`, `City`,`Item_Name`, `Best_Seller`, `Votes`, `Prices`
    HAVING COUNT(*) > 1
) AS subquery;

/* 4. Total Number of Restaurants */
SELECT COUNT(DISTINCT `Restaurant_Name`) AS total_restaurants FROM `zomato_dataset`;

/* 5. Total Number of Cities Covered */
SELECT COUNT(DISTINCT `City`) AS total_cities FROM `zomato_dataset`;

/* 6. Average Dining Rating Across All Restaurants */
SELECT ROUND(AVG(`Dining_Rating`), 2) AS avg_dining_rating FROM `zomato_dataset`;

/* 7. Average Delivery Rating Across All Restaurants */
SELECT ROUND(AVG(`Delivery_Rating`), 2) AS avg_delivery_rating FROM `zomato_dataset`;

/* 8. Total Votes Received Across All Restaurants */
SELECT SUM(`Votes`) AS total_votes FROM `zomato_dataset`;

/* 9. Number of Best Seller Items */
SELECT COUNT(*) AS total_best_sellers 
FROM `zomato_dataset` 
WHERE `Best_Seller` = 'Yes';

-- 10. City with Highest Number of Restaurants
SELECT `City`, COUNT(*) AS restaurant_count
FROM `zomato_dataset`
GROUP BY `City`
ORDER BY restaurant_count DESC
LIMIT 1;

-- 11. Most Popular Cuisine (Based on Number of Restaurants)
SELECT `Cuisine`, COUNT(*) AS cuisine_count
FROM `zomato_dataset`
GROUP BY `Cuisine`
ORDER BY cuisine_count DESC
LIMIT 1;

-- 12. Average Price for Dining per City
SELECT `City`, ROUND(AVG(`Prices`), 2) AS avg_price
FROM `zomato_dataset`
GROUP BY `City`
ORDER BY avg_price DESC;

-- 13. Restaurants with High Prices but Low Ratings
SELECT `Restaurant_Name` `City`, `Prices`, `Dining_Rating`
FROM `zomato_dataset`
WHERE `Prices` > (SELECT AVG(`Prices`) FROM `zomato_dataset`)
  AND `Dining_Rating` < (SELECT AVG(`Dining_Rating`) FROM `zomato_dataset`);
  
-- 14. Cities with Lowest Average Delivery Rating
SELECT `City`, ROUND(AVG(`Delivery_Rating`), 2) AS avg_delivery_rating
FROM `zomato_dataset`
GROUP BY `City`
ORDER BY avg_delivery_rating ASC
LIMIT 5;

-- 15. Price Distribution by City to Optimize Pricing Strategy
SELECT `City`, ROUND(AVG(`Prices`), 2) AS avg_price
FROM `zomato_dataset`
GROUP BY `City`
ORDER BY avg_price DESC;

-- 16. Percentage of Best Seller Items per City
SELECT `City`,
       COUNT(CASE WHEN `Best_Seller` = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS best_seller_percentage
FROM `zomato_dataset`
GROUP BY `City`
ORDER BY best_seller_percentage ASC;




