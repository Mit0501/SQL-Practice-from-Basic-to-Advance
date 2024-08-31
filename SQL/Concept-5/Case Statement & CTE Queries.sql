show databases;
Use techforallwithpriya;
show tables;
select * from courses_upadate;

-- CASE Statements in SQL
-- Create a new column named "CourseFeeStatus"
/* 
    CourseFee > 3999  ---> "Expensive Course"
     CourseFee > 1499  ---> "Moderate Course"
     ELSE  --> "Cheaper Course"  
*/
     
SELECT CourseID,CourseName,CourseFee,
   CASE 
	   WHEN CourseFee > 3999 THEN "Expensive Course"
       WHEN CourseFee > 1499 THEN "Moderate Course"
       ELSE "Cheaper Course"
	END AS CourseFeeStatus
from courses_upadate;

-- CASE Expressions in SQL
-- CourseType: Premium Course, Plus Course, Regular Course
SELECT CourseID,CourseName,CourseFee,
   CASE CourseFee
	   WHEN 4999 THEN "Premium Course"
       WHEN 3999 THEN "Plus Course"
       ELSE "Regular Course"
	END AS CourseType
from courses_upadate;


--  Create a new table "orders" in techforallwithpriya data
-- OrderID --> Primary Key[Auto Increment]
-- Order_Date
-- Order_Student_ID
-- Order_Status  --> Complete,Pending, Closed
Create Table orders(OrderID int auto_increment,
Order_Date timestamp NOT NULL,
Order_Learner_ID INT NOT NULL,
Order_Status varchar(10) NOT NULL,
Primary Key(OrderID),
FOREIGN KEY(Order_Learner_ID) references learners(Learner_Id));

desc orders;
select * from orders;
select * from learners;

-- Insertion of the records inside the orders Table
insert into orders(Order_Date,Order_Learner_ID,Order_Status) values('2024-01-24',2,'Complete');
insert into orders(Order_Date,Order_Learner_ID,Order_Status) values('2024-01-21',1,'Complete');
insert into orders(Order_Date,Order_Learner_ID,Order_Status) values('2024-01-25',5,'Complete');
insert into orders(Order_Date,Order_Learner_ID,Order_Status) values('2024-03-12',3,'Complete');
insert into orders(Order_Date,Order_Learner_ID,Order_Status) values('2024-05-24',5,'Complete');
insert into orders(Order_Date,Order_Learner_ID,Order_Status) values('2024-03-24',6,'Complete');
insert into orders(Order_Date,Order_Learner_ID,Order_Status) values('2024-01-14',4,'Complete');
insert into orders(Order_Date,Order_Learner_ID,Order_Status) values('2024-05-03',6,'Complete');
insert into orders(Order_Date,Order_Learner_ID,Order_Status) values('2024-04-23',3,'Complete');
insert into orders(Order_Date,Order_Learner_ID,Order_Status) values('2024-04-19',2,'Closed');
insert into orders(Order_Date,Order_Learner_ID,Order_Status) values('2024-01-10',3,'Pending');
-- Total orders per student
select Order_Learner_ID, count(*) as Total_Orders 
from orders
group by Order_Learner_ID;

-- Order_Learner_ID,Learner Learner_FirstName,Learner_LastName and total_orders also.
select Order_Learner_ID,Learner_FirstName,Learner_LastName,Total_Orders
from learners
join
(select Order_Learner_ID, count(*) as Total_Orders 
from orders
group by Order_Learner_ID) temp
on (temp.Order_Learner_ID = Learners.Learner_Id);

-- Order_Learner_ID,Learner Learner_FirstName,Learner_LastName and total_orders and Avg_Orders_entire_students --> AVG(SUM(Total_Orders))
select 
Order_Learner_ID,
Learner_FirstName,
Learner_LastName,
Total_Orders,
Total_Orders/SUM(Total_Orders) over() as Avg_Orders_entire_students from
(select temp.Order_Learner_ID,Learner_FirstName,Learner_LastName,temp.Total_Orders
from learners
join
(select Order_Learner_ID, count(*) as Total_Orders
from orders
group by Order_Learner_ID) temp
on temp.Order_Learner_ID = Learners.Learner_Id) t1
group by 1;

---
select 
Order_Learner_ID,
Learner_FirstName,
Learner_LastName,
Total_Orders,
AVG(Total_Orders) over() as Avg_Orders_entire_students from
(select temp.Order_Learner_ID,Learner_FirstName,Learner_LastName,temp.Total_Orders
from learners
join
(select Order_Learner_ID, count(*) as Total_Orders
from orders
group by Order_Learner_ID) temp
on temp.Order_Learner_ID = Learners.Learner_Id) t1
group by 1;

-- Same question implemented with common table expression

with my_cte as
(
	select Order_Learner_ID,Learner_FirstName,Learner_LastName,Total_Orders
from learners
join
(select Order_Learner_ID, count(*) as Total_Orders 
from orders
group by Order_Learner_ID) temp
on (temp.Order_Learner_ID = Learners.Learner_Id)
),
my_cte_sum as (
select Order_Learner_ID,sum(Total_Orders) over() as total_sum_order from (select Order_Learner_ID,Learner_FirstName,Learner_LastName,Total_Orders
from learners
join
(select Order_Learner_ID, count(*) as Total_Orders 
from orders
group by Order_Learner_ID) temp
on (temp.Order_Learner_ID = Learners.Learner_Id)) t1
)

select my_cte.Order_Learner_ID,Learner_FirstName,Learner_LastName,Total_Orders,
Total_Orders/total_sum_order as Avg_Orders_entire_students from my_cte
join my_cte_sum
on my_cte.Order_Learner_ID = my_cte_sum.Order_Learner_ID
