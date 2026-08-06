# Write your MySQL query statement below

Select id, movie, description, rating FROM Cinema
WHERE id & 1 AND description <> 'boring'
ORDER BY rating DESC;