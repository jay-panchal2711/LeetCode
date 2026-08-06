# Write your MySQL query statement below

SELECT s.student_id, s.student_name, su.subject_name, COUNT(e.subject_name) as attended_exams
FROM Students s
Cross Join Subjects su
LEFT Join Examinations e
ON su.subject_name = e.subject_name
AND s.student_id = e.student_id
Group by s.student_id, s.student_name, su.subject_name
Order By s.student_id, su.subject_name;