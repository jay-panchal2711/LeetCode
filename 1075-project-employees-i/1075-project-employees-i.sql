# Write your MySQL query statement below
select p.project_id, 
Round(sum(e.experience_years)/count(p.employee_id), 2) as average_years
FROM Project p
Join Employee e
ON p.employee_id = e.employee_id
Group By p.project_id
;