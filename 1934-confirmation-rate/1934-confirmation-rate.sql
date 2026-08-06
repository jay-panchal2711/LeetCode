# Write your MySQL query statement below

-- With CTE as (
--     SELECT user_id,
--     Sum(CASE When action = "confirmed" THEN 1 ELSE 0 END) as cnt
--     FROM Confirmations
--     Group by user_id
-- )

-- SELECT s.user_id, Round(IFNULL(ct.cnt/Count(c.action), 0),2) as confirmation_rate
-- FROM Signups s
-- LEFT Join Confirmations c
-- ON s.user_id = c.user_id
-- LEFT Join CTE ct
-- ON s.user_id = ct.user_id
-- Group By s.user_id;




-- SELECT s.user_id,
-- ROUND(IFNULL(SUM(CASE WHEN c.action = "confirmed" Then 1 ELSE 0 END) /count(c.action), 0),2) as confirmation_rate
-- FROM Signups s
-- LEFT Join confirmations c
-- On s.user_id = c.user_id
-- Group by s.user_id;


SELECT 
    s.user_id,
    ROUND(IFNULL(AVG(c.action = 'confirmed'), 0), 2) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id;


-- WITH Stats AS (
--     SELECT 
--         user_id,
--         COUNT(*) AS total_reqs,
--         SUM(action = 'confirmed') AS confirmed_reqs
--     FROM Confirmations
--     GROUP BY user_id
-- )
-- SELECT 
--     s.user_id,
--     ROUND(IFNULL(st.confirmed_reqs / st.total_reqs, 0), 2) AS confirmation_rate
-- FROM Signups s
-- LEFT JOIN Stats st
--     ON s.user_id = st.user_id;