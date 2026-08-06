# Write your MySQL query statement below

Select Department, Employee , Salary 
FROM(
    SELECT 
    d.name as Department, 
    e.name as Employee ,
    e.salary as Salary, 
    DENSE_RANK() OVER (Partition By e.departmentId Order By e.salary DESC) as sal_rnk
    FROM Employee e
    Join Department d
    ON e.departmentID = d.id
)as ranked_Salary
Where sal_rnk <= 3;



-- WITH CTE AS(
--     SELECT e.id as emp_id, e.name as "Employee", e.salary, e.departmentId, d.id as dept_id, d.name as "Department",
--     DENSE_RANK() OVER (PARTITION BY d.id ORDER BY salary DESC) as rnk
--     FROM Employee e
--     JOIN Department d
--     ON e.departmentId = d.id
-- )
-- SELECT Department , Employee, salary FROM CTE
-- WHERE rnk <= 3;









