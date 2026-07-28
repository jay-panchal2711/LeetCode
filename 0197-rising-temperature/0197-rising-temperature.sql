# Write your MySQL query statement below

-- WITH RowComparison AS (
--     SELECT 
--         id, 
--         recordDate, 
--         temperature,
--         LAG(temperature, 1) OVER(ORDER BY recordDate) AS Prev_day,
--         LAG(recordDate, 1) OVER(ORDER BY recordDate) AS Prev_date
--     FROM Weather
-- ) 
-- SELECT id 
-- FROM RowComparison
-- WHERE temperature > Prev_day 
--   AND DATEDIFF(recordDate, Prev_date) = 1;


-- SELECT w1.id FROM Weather w1
-- Join weather w2
-- ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
-- Where w1.temperature > w2.temperature;



WITH CTEs AS(
    SELECT
    id, recordDate, temperature,
    lag(temperature, 1) OVER(Order By recordDate) AS Prev_day,
    lag(recordDate, 1) Over(Order By recordDate) AS Prev_Date
FROM Weather
)
SELECT id FROM CTEs
Where temperature > Prev_day 
AND
DATEDIFF(recordDate, Prev_Date) = 1;


