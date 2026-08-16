# Write your MySQL query statement below

SELECT round(SUM(tiv_2016),2) as tiv_2016
FROM Insurance
Where tiv_2015 IN (select tiv_2015 
FROM Insurance
group by tiv_2015
Having count(*) > 1) 
AND (lat,lon) IN (Select lat, lon
FROM Insurance
group by lat, lon
Having count(*) = 1);