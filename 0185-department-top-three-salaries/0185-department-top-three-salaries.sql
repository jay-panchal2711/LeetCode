# Write your MySQL query statement below

-- Select Department, Employee , Salary 
-- FROM(
--     SELECT 
--     d.name as Department, 
--     e.name as Employee ,
--     e.salary as Salary, 
--     DENSE_RANK() OVER (Partition By e.departmentId Order By e.salary DESC) as sal_rnk
--     FROM Employee e
--     Join Department d
--     ON e.departmentID = d.id
-- )as ranked_Salary
-- Where sal_rnk <= 3;



-- WITH CTE AS(
--     SELECT e.id as emp_id, e.name as "Employee", e.salary, e.departmentId, d.id as dept_id, d.name as "Department",
--     DENSE_RANK() OVER (PARTITION BY d.id ORDER BY salary DESC) as rnk
--     FROM Employee e
--     JOIN Department d
--     ON e.departmentId = d.id
-- )
-- SELECT Department , Employee, salary FROM CTE
-- WHERE rnk <= 3;


-- SELECT 
--     d.name AS Department,
--     e.name AS Employee,
--     e.salary AS Salary
-- FROM Employee e
-- JOIN Department d 
--     ON e.departmentId = d.id
-- WHERE 3 > (
--     SELECT COUNT(DISTINCT e2.salary)
--     FROM Employee e2
--     WHERE e2.departmentId = e.departmentId 
--       AND e2.salary > e.salary
-- );

WITH RankedSalaries AS (
    SELECT 
        departmentId,
        salary,
        DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) as rnk
    FROM (
        SELECT DISTINCT departmentId, salary 
        FROM Employee
    ) unique_salaries
)
SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e
JOIN RankedSalaries rs 
    ON e.departmentId = rs.departmentId 
   AND e.salary = rs.salary
JOIN Department d 
    ON e.departmentId = d.id
WHERE rs.rnk <= 3;





