show databases;
Use techforallwithpriya;
Show tables;
select * from employee;

select FirstName,LastName,salary,
Salary+ salary*0.25 as Final_salary_after_increment
from employee;

--  For each location, What is the count of each employee and average salary of the employee in those location
select location,count(location) as Total ,avg(salary) as average_Salary from employee
group by location;

--  For each location, What is the count of each employee and average salary of the employee in those location
-- But also display FirstName & LastName corresponding to each record
Select FirstName, LastName,employee.Location,Total,average_Salary 
from employee
JOIN
(select location,count(location) as Total ,avg(salary) as average_Salary from employee
group by location) as temp
ON employee.Location = temp.location;
/*select location,count(location) as Total ,avg(salary) as average_Salary from employee
group by location;
select location, FirstName, LastName,count(location) as Total ,avg(salary) as average_Salary from employee
group by location, FirstName, LastName;*/

-- Optimise the above queries via Window Functions
select FirstName,LastName,Location, 
count(Location) Over(partition by location) as Total,
avg(salary) Over(partition by location) as Average_Salary
from employee;

-- Differece between Row_Number() vs Rank() vs Dense_Rank()
-- If there is no duplicate entries in your data, then Row_Number() vs Rank() vs Dense_Rank() will work exactly same means return same result.
Select * from employee;
-- Want to add one more column( priority) that given priority order of employee on the basis of salary
select FirstName,LastName,salary,
row_number() over(order by salary desc) as Priority_Emp
from employee;

select FirstName,LastName,salary,
RANK() over(order by salary desc) as Priority_Emp
from employee;

select FirstName,LastName,salary,
DENSE_RANK() over(order by salary desc) as Priority_Emp
from employee;

-- Give the record of the employee having third highest salary
Select * from
(select FirstName,LastName,salary,
DENSE_RANK() over(order by salary desc) as Priority_Emp
from employee) as temp
where Priority_Emp = 3;

-- Using Common Table Express written below query of above question
with secondhighestsalary as (select FirstName,LastName,salary,
DENSE_RANK() over(order by salary desc) as Priority_Emp
from employee)
select * from secondhighestsalary
where Priority_Emp = 3;

-- Give me the first employee having third higest salary
Select * from
(select FirstName,LastName,salary,
ROW_NUMBER() over(order by salary desc) as Priority_Emp
from employee) as temp
where Priority_Emp = 3;

-- Specify the details of highest salary people in each location
select * from employee;

Select * from
(select FirstName,LastName,salary,Location,
ROW_NUMBER() over(Partition by  location order by salary desc) as Priority_Emp
from employee) as temp
where Priority_Emp = 1;

-- Delete Duplicate Emails
delete from person
where id in (select id from
(select id,email,row_number() over(partition by email order by id) rnumber
from person) as temp
where rnumber > 1)


