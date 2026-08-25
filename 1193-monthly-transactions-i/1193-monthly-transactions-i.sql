# Write your MySQL query statement below


select DATE_FORMAT(trans_date, '%Y-%m') as "month",
country, 
Count(*) as trans_count,
SUM(CASE WHEN state = 'approved' Then 1 else 0 END) as approved_count,
SUM(amount) as trans_total_amount,
SUM(CASE WHEN state = 'approved' THEN amount else 0 END) as approved_total_amount
FROM Transactions
Group By DATE_FORMAT(trans_date, '%Y-%m') , country
;
