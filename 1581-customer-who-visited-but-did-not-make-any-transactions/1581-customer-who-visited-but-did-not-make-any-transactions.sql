# Write your MySQL query statement below

SELECT v.customer_id, COUNT(v.customer_id) as count_no_trans FROM Visits v
LEFT Join Transactions t
ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL 
GROUP By customer_id;