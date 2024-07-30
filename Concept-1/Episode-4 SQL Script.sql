CREATE TABLE Courses(
CourseID INT AUTO_INCREMENT,
CourseName	varchar(50) NOT NULL,
CourseDuration INT NOT NULL,
CourseFee INT NOT NULL,
PRIMARY KEY(CourseID)
)

INSERT INTO courses(CourseName, CourseDuration, CourseFee) VALUES ("The Complete Excel Mastery" ,1, 1499);
INSERT INTO courses(CourseName, CourseDuration, CourseFee) VALUES ("DSA For Interview Prepartion" ,2, 4999);
INSERT INTO courses(CourseName, CourseDuration, CourseFee) VALUES ("SQL Bootcamp" ,1, 2999);

select * from courses;

SHOW TABLES;

CREATE TABLE Students(
StudentID	INT	AUTO_INCREMENT,
S_FirstName	varchar(50) NOT NULL,
S_LastName	varchar(50) NOT NULL,
S_Email varchar(50) NOT NULL,
S_Phone	varchar(50) NOT NULL,
S_EnrollmentDate timestamp NOT NULL,
Selected_Course	INT NOT NULL,
Years_Of_Exp INT NOT NULL,
S_Company varchar(50) NOT NULL,
Batch_Start_Date timestamp NOT NULL,
Location varchar(50) NOT NULL,
PRIMARY KEY(StudentID)
);
-----------------------------------------------------------------------
select * from learners;
desc learners;

 drop table learners;
 
CREATE TABLE learners(
Learner_Id INT	AUTO_INCREMENT,
Learner_FirstName 	varchar(50) NOT NULL,
Learner_LastName 	varchar(50) NOT NULL,
Learner_EmailId 	varchar(50),
Learner_PhoneNo 	varchar(10) NOT NULL,
Learner_EnrollmentDate timestamp NOT NULL,
Selected_Course  INT NOT NULL,
Year_of_Experience INT NOT NULL,
Learner_Company varchar(50),
Learner_SOJ varchar(50) NOT NULL,
Batch_Start_Date timestamp NOT NULL,
Location varchar(50) NOT NULL,
PRIMARY KEY(Learner_Id),
UNIQUE kEY(Learner_EmailId),
FOREIGN KEY(Selected_Course) references courses(CourseID)
);

INSERT INTO learners(Learner_FirstName, Learner_LastName,Learner_EmailId,Learner_PhoneNo,Learner_EnrollmentDate,Selected_Course,Year_of_Experience,Learner_Company,Learner_SOJ,Batch_Start_Date,Location) 
VALUES ("Akhil","George","akhil.george.8743@gmail.com",9779766293,"2024-01-21",1,4,"Amazon","LinkedIn","2024-02-29","Bengaluru");

INSERT INTO learners(Learner_FirstName,Learner_LastName,Learner_EmailId,Learner_PhoneNo,Learner_EnrollmentDate,Selected_Course,Year_of_Experience,Learner_Company,Learner_SOJ,Batch_Start_Date,Location) 
VALUES ("Rishikesh","Joshi","carjkop@gmail.com",9950192388,"2024-03-19",3,2,"HCL","Youtube","2024-03-25","Chennai");

INSERT INTO learners(Learner_FirstName,Learner_LastName,Learner_EmailId,Learner_PhoneNo,Learner_EnrollmentDate,Selected_Course,Year_of_Experience,Learner_SOJ,Batch_Start_Date,Location) 
VALUES ("Jeevan","Hegde","jeevanhegdek@yahoo.co.in",9657856732,"2024-01-15",2,0,"Linkedin","2024-01-16","Noida");

INSERT INTO learners(Learner_FirstName,Learner_LastName,Learner_EmailId,Learner_PhoneNo,Learner_EnrollmentDate,Selected_Course,Year_of_Experience,Learner_Company,Learner_SOJ,Batch_Start_Date,Location) 
VALUES ("Akhil","George","akhil.george.87@gmail.com",7689558930,"2024-03-13",3,4,"Accenture","Community","2024-03-25","Bengaluru");

INSERT INTO learners(Learner_FirstName,Learner_LastName,Learner_EmailId,Learner_PhoneNo,Learner_EnrollmentDate,Selected_Course,Year_of_Experience,Learner_Company,Learner_SOJ,Batch_Start_Date,Location) 
VALUES ("Sidhish","Kumar","sidhishkumar@gmail.com",6475765443,"2024-01-10",1,4,"Meta","Youtube","2024-03-29","Bengaluru");


INSERT INTO learners(Learner_FirstName,Learner_LastName,Learner_EmailId,Learner_PhoneNo,Learner_EnrollmentDate,Selected_Course,Year_of_Experience,Learner_Company,Learner_SOJ,Batch_Start_Date,Location) 
VALUES ("NagaSai","Sreedhar","saisreedhar2001@gmail.com",9182937061,"2024-03-17",3,4,"TCS","Community","2024-03-25","Mumbai");

/*
INSERT INTO learners(Learner_FirstName,Learner_LastName,Learner_EmailId,Learner_PhoneNo,Learner_EnrollmentDate,Selected_Course,Year_of_Experience,Learner_Company,Learner_SOJ,Batch_Start_Date,Location) 
VALUES ("Naga","Sai","saisreedhar21@gmail.com",9182937061,"2024-03-17",4,4,"TCS","Community","2024-03-25","Mumbai"); -- can't insert because foreign key property not satisfy */

select * from learners;

-- Data Analysis (Employee, Courses, Learners)
-- 1 Give me the record of the employee getting highest salary
select * from employee
order by salary desc 
limit 1;

select * from employee
where salary= (select max(salary) from employee);

-- 2. Give me the record of the employee getting second highest salary
select * from (select * from employee 
order by salary desc
limit 2) as hs
order by salary
limit 1;

select * from employee ;
-- 3. Give me the record of the employee getting highest salary and age is bigger than 30
Select * from employee
where age > 30
order by salary desc
limit 1;

select * from learners ;
-- 4. Display the number of enrollments in the website of techforallwithpriya
select count(*) as number_of_enrollments from learners;

-- 5. Display the number of enrollments for the courseid=3[SQL Bootcamp]
select count(*) as number_of_learners_SQL 
from learners
where Selected_Course = 3 ;

select * from learners ;
select count(9)
from learners;

-- 6. Count the number of learners enrolled in the month of Jan
SELECT count(*) as number_learners_jan from learners
where Learner_EnrollmentDate LIKE '%-01-%';

update learners
set Year_of_Experience =1 , Learner_Company = 'Amazon'
where Learner_Id = 3;

-- 7. Count the number of companies where learners currently doing their jobs
-- Count  -> count the non null entries
-- Unique count of the companies
SELECT count(Learner_Company)  from learners;
SELECT count( distinct Learner_Company) as distinct_companies from learners;
