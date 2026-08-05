# Write your MySQL query statement below

# solving using Union ALL

SELECT e.name, b.bonus FROM employee e
JOIN bonus b
ON e.empID = b.empId
Where b.bonus < 1000
UNION ALL
Select e.name, b.bonus FROM employee e
Left Join bonus b
ON e.empID = b.empId
Where b.bonus IS NULL;
