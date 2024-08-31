SHOW Databases;
Use techforallwithpriya;
show tables;

select * from learners;

-- Count the number of students who joined the course as via Linkedin,Youtube and Community
Select Learner_SOJ, count(*) as number_of_students
from learners
group by Learner_SOJ;

-- Grouping via both Source of Joining and location
Select Learner_SOJ, Location, count(*) as number_of_students
from learners
group by Learner_SOJ,Location;

select * from courses;
select * from learners;

-- corresponding to each course how many students have been enrolled
select selected_course, count(*) as enrolled_students
from learners
group by selected_course;

-- corresponding to individual source of joining, give me maximum year of experience any person
Select Learner_SOJ, max(Year_of_Experience) as maximum_years_of_exp
from learners
group by Learner_SOJ;

-- corresponding to individual source of joining, give me minimum year of experience any person
Select Learner_SOJ, min(Year_of_Experience) as minimum_years_of_exp
from learners
group by Learner_SOJ;

-- corresponding to individual source of joining, give me average year of experience any person
Select Learner_SOJ, avg(Year_of_Experience) as average_years_of_exp
from learners
group by Learner_SOJ;

-- corresponding to individual source of joining, give me summation year of experience any person hold?
-- It does not make sense for industry purpaose in this case
Select Learner_SOJ, sum(Year_of_Experience) as summation_years_of_exp
from learners
group by Learner_SOJ;

-- Display the record of those learner who have joined the course via more than 1 source of joining
-- Filteration is required on aggregation ===> after group by apply having clause
select * from learners;
select Learner_FirstName,count(Learner_SOJ) as learner_SOJ from learners
group by Learner_FirstName having learner_SOJ>1;

-- Display the count of those learners who have joined via linkedIn
Select Learner_SOJ, count(*) as Number_of_student from learners
group by Learner_SOJ
having Learner_SOJ='LinkedIn';

select count(*) from learners
where Learner_SOJ='LinkedIn';

-- Display the course which does not include "Excel"
select *  from courses
where CourseName  not like '%Excel%';

-- Display the records of those students who have less than 4 years of experience and source of Joining is "YouTube" and Location is  Chennai
-- If All condition need to satisfy then we can go for AND operator
select * from learners
where Year_of_Experience < 4 and Learner_SOJ='Youtube' and Location='Chennai';
 
 -- Display the record of those student who have the years of experience between 2 to 4 years -- it inclusive the  between condition 
select * from learners
where Year_of_Experience between 2 and 4;

-- Display the records of those students who have less than 4 years of experience or source of Joining is "YouTube" or Location is  Chennai
-- If any one of condition need to satisfy then we can go for OR operator
select * from learners
where Year_of_Experience < 4 or Learner_SOJ='Youtube' or Location='Chennai';
 
-- Alter Command
DESC employee;
select * from employee;
Alter table employee ADD column jobPosition varchar(50);
Alter table employee modify column LastName varchar(20);
Alter table employee DROP constraint EMPID;
Alter table employee DROP column EMPID;

-- Trunacate  Command
-- Delete vs Truncate Command in SQL

-- DataTypes in SQL --> Decimal
-- Implicit typecasting
INSERT INTO courses(CourseName, CourseDuration, CourseFee) VALUES ("The Foundation of Machine Learning" ,3.5, 3999);
INSERT INTO courses(CourseName, CourseDuration, CourseFee) VALUES ("The Foundation of Data Engineering Courses" ,3.2, 4999);
DESC courses;
Select * from courses;
Alter table courses modify column CourseDuration decimal not null;

CREATE TABLE Courses_Upadate(
CourseID INT AUTO_INCREMENT,
CourseName	varchar(50) NOT NULL,
CourseDuration decimal(3,1) NOT NULL,
CourseFee INT NOT NULL,
PRIMARY KEY(CourseID)
);

DESC Courses_Upadate;
INSERT INTO Courses_Upadate(CourseName, CourseDuration, CourseFee) VALUES ("The Complete Excel Mastery" ,1.5, 1499);
INSERT INTO Courses_Upadate(CourseName, CourseDuration, CourseFee) VALUES ("DSA For Interview Prepartion" ,2.5, 4999);
INSERT INTO Courses_Upadate(CourseName, CourseDuration, CourseFee) VALUES ("SQL Bootcamp" ,1, 2999);
select * from Courses_Upadate;

-- Add oe more colum in courses_update table to see when change happen
drop table Courses_Upadate;

CREATE TABLE Courses_Upadate(
CourseID INT AUTO_INCREMENT,
CourseName	varchar(50) NOT NULL,
CourseDuration decimal(3,1) NOT NULL,
CourseFee INT NOT NULL,
Changed_AT timestamp default Now(),
PRIMARY KEY(CourseID)
);

DESC Courses_Upadate;
INSERT INTO Courses_Upadate(CourseName, CourseDuration, CourseFee) VALUES ("The Complete Excel Mastery" ,1.5, 1499);
INSERT INTO Courses_Upadate(CourseName, CourseDuration, CourseFee) VALUES ("DSA For Interview Prepartion" ,2.5, 4999);
INSERT INTO Courses_Upadate(CourseName, CourseDuration, CourseFee) VALUES ("SQL Bootcamp" ,1, 2999);
INSERT INTO Courses_Upadate(CourseName, CourseDuration, CourseFee) VALUES ("Statistics for Data Science" ,2.5, 3999);
select * from Courses_Upadate;

-- Update the courseFee of SQL Bootcamp to 3999 ---> works only on primary key as in where clause
Update Courses_Upadate set courseFee= 3999 
where CourseID= 3;
-- where CourseName='SQL Bootcamp';

Alter table Courses_Upadate modify column Changed_AT timestamp default Now() on Update Now();
Update Courses_Upadate set courseFee= 4999 
where CourseID= 3;


Select * from learners;
-- Give me the number of learner  who have enrolled the courses on monthly basis.
select distinct Month(Learner_EnrollmentDate) as month_enrollment,count(Learner_EnrollmentDate) as count_of_monthly_enrollments
from learners
group by Month(Learner_EnrollmentDate);                                                                                                                                                                      

select distinct Month(Learner_EnrollmentDate) as month_enrollment,
count(Learner_EnrollmentDate) over(partition by Month(Learner_EnrollmentDate)) as count_of_monthly_enrollments
from learners;

