# Write your MySQL query statement below

SELECT 
    p.product_id, 
    ROUND(IFNULL(SUM(p.price * u.units) / SUM(u.units), 0), 2) AS average_price
FROM prices p
LEFT Join Unitssold u
    ON p.product_id = u.product_id
    AND u.purchase_date Between p.start_date AND p.end_date
group by p.product_id
;