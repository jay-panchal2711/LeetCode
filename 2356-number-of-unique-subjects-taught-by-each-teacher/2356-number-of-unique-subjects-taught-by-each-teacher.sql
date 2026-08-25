# Write your MySQL query statement below
select teacher_id, count(distinct subject_id) as cnt
FROM Teacher
Group By teacher_id;