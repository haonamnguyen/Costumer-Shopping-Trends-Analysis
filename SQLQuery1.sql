-- This calculates the total number of male and female customers from the 'shopping_trends_updated' dataset
-- It also calculates the percentage distribution of male and female customers, rounded to two decimal places with FORMAT.

SELECT 
    Gender, 
    COUNT(Customer_ID) AS Count,
    FORMAT(
        (COUNT(Customer_ID) * 1.0 / 
         (SELECT COUNT(Customer_ID) FROM shopping_trends_updated)) * 100, 'N2'
    ) + '%' AS Percentage
FROM shopping_trends_updated
GROUP BY Gender
ORDER BY Count DESC;

-- This categorizes customers into predefined age groups (18-24, 25-34, 45-54) based on their age.
-- It uses a CASE statement to create age group labels and counts the number of customers within each group.
-- The data is grouped by the age categories and ordered by the age group labels for a structured view.
-- This analysis provides insights into the age demographics of customers, helping businesses tailor their products and marketing strategies to specific age segments.

SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age >= 55 THEN '55+'
        ELSE 'Unknown'
    END AS Age_Group,
    COUNT(Customer_ID) AS Customer_Count
FROM shopping_trends_updated
GROUP BY 
    CASE 
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age >= 55 THEN '55+'
        ELSE 'Unknown'
    END
ORDER BY Age_Group;

-- Identifies the most popular payment methods by counting the number of transactions for each method.
-- The insights can help businesses understand customer preferences and optimize payment options accordingly.

SELECT Payment_Method, 
COUNT(Customer_ID) AS Usage_Count
FROM shopping_trends_updated
GROUP BY Payment_Method
ORDER BY Usage_Count DESC;

-- Analyzes the popularity of product categories by counting the number of transactions associated with each category.
-- The results provide valuable information for inventory management and targeted marketing strategies.

SELECT Category,
COUNT (Customer_ID) AS Category_Count
FROM shopping_trends_updated
GROUP BY Category
ORDER BY Category_Count DESC;


-- Evaluates the popularity of shipping methods by counting the number of transactions using each shipping type.
-- These insights can assist businesses in optimizing logistics and improving customer satisfaction.

SELECT Shipping_Type,
COUNT (Customer_ID) AS Shipping_Count
FROM shopping_trends_updated
GROUP BY Shipping_Type
ORDER BY Shipping_Count DESC;

-- This calculates the total spending for each state by summing up the values in the "Purchase_Amount_USD" column.
-- The data is grouped by the "Location" column (representing states) and sorted in descending order of total spending.
-- This analysis highlights the states contributing the most revenue, offering valuable insights for regional sales strategies and resource allocation.

SELECT 
Location AS State, 
SUM([Purchase_Amount_USD]) AS Total_Spending
FROM shopping_trends_updated
GROUP BY Location
ORDER BY Total_Spending DESC
