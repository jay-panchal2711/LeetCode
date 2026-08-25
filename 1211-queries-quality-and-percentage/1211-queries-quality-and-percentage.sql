# Write your MySQL query statement below
SELECT query_name, 
Round(sum(rating/position) / count(query_name), 2) as quality,
Round(SUM(CASE WHEN rating < 3 Then 1 Else 0 END) / count(*)  * 100,  2) as poor_query_percentage
FROM Queries
Where query_name IS NOT NULL
Group by query_name;