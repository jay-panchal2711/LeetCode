# Write your MySQL query statement below

Select user_id, count(user_id) as followers_count
FROM Followers
Group by user_id
order by user_id