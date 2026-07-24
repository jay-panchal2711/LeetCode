# Write your MySQL query statement below
-- SELECT Customer_number FROM Orders
-- GRoup By Customer_number
-- ORDER By COUNT(Customer_number) DESC
-- LIMIT 1;

WITH CTE AS(
SELECT *,
Dense_rank() OVer(ORDER BY COUNT(Order_number) DESC)as rnk
FROM Orders
GROUP BY customer_number) 
SELECT  Customer_number from CTE
WHERE rnk = 1;


