show databases;
Use techforallwithpriya;
Show tables;
select * from employee;
select * from courses;
select * from learners;
select * from courses_upadate;

-- Data Analysis
-- Which courses have the highest enrollment rates?
select Selected_Course, count(Selected_Course) as highest_enrollement_rate 
from learners
group by Selected_Course 
order by highest_enrollemnt_rate desc 
limit 1;

---
-- Which courses have the highest enrollment rates?
-- courseId, courseName, enrollementCount
-- inner join
-- Query 1
select CourseID,CourseName,temp.highest_enrollement_rate 
from courses 
join
(select Selected_Course, count(Selected_Course) as highest_enrollement_rate 
from learners
group by Selected_Course 
order by highest_enrollement_rate desc 
limit 1) temp
on courses.CourseID = temp.Selected_Course;

-- Query 1(filter first then lesser record to join) is better in term of optimisation and performance because it took n time and Query 2 took n^2 time
-- Other way also can do above query
-- Query 2
select CourseID,CourseName,count(*) as EnnrollmentCount
from learners 
join courses on courses.CourseID = learners.Selected_Course
group by Selected_Course 
order by EnnrollmentCount desc
limit 1;



