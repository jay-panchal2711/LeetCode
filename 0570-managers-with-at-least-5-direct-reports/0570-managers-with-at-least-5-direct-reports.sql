# Write your MySQL query statement below

-- Select name from Employee
-- WHERE id in (SELECT managerId FROM Employee
-- Group By managerID
-- Having Count(managerID) >= 5);

Select e1.name From employee e1
Join employee e2
On e1.id = e2.managerId
Group By e1.id, e1.name
Having Count(e2.managerId) >= 5;
