# Write your MySQL query statement below
Update Salary
SET sex = (CASE When sex = 'f' then 'm' else 'f' END) ;