-- 1. Create a database named "ecommerce_sales_data"
create database if not exists ecommerce_sales_data;
show databases;
use ecommerce_sales_data;

-- 2. Create a table with named as "Sales_Datasets" inside database named "ecommerce_sales_data"
-- Command to gernerate SQL file: csvsql --dialect mysql --snifflimit 10000 Sales_Dataset.csv>Result.sql
-- create this table script with help of automation of anaconda prompt
CREATE TABLE `Sales_Dataset` (
	order_id VARCHAR(15) NOT NULL, 
	order_date DATE NOT NULL, 
	ship_date DATE NOT NULL, 
	ship_mode VARCHAR(14) NOT NULL, 
	customer_name VARCHAR(22) NOT NULL, 
	segment VARCHAR(11) NOT NULL, 
	state VARCHAR(36) NOT NULL, 
	country VARCHAR(32) NOT NULL, 
	market VARCHAR(6) NOT NULL, 
	region VARCHAR(14) NOT NULL, 
	product_id VARCHAR(16) NOT NULL, 
	category VARCHAR(15) NOT NULL, 
	sub_category VARCHAR(11) NOT NULL, 
	product_name VARCHAR(127) NOT NULL, 
	sales DECIMAL(38, 0) NOT NULL, 
	quantity DECIMAL(38, 0) NOT NULL, 
	discount DECIMAL(38, 3) NOT NULL, 
	profit DECIMAL(38, 5) NOT NULL, 
	shipping_cost DECIMAL(38, 2) NOT NULL, 
	order_priority VARCHAR(8) NOT NULL, 
	year DECIMAL(38, 0) NOT NULL
);

Use ecommerce_sales_data;
desc sales_dataset;
select * from sales_dataset;
Drop table sales_dataset;

-- 3. Load the data available in sales_dataset.csv file to the sales_dataset table
-- Famous Error:The MYSQL server is runing with the --secure-file-priv option 
-- C:/ProgramData/MySQL/MySQL Server 8.0/Uploads
LOAD DATA INFILE 'E:/SQL/Analyse_e-commerce_data/Sales_Dataset.csv'
INTO TABLE sales_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from sales_dataset;

-- Identify top 3(three) state with highest shipping costs
select state,max(shipping_cost) as highest_shipping_cost from sales_dataset
group by state
order by highest_shipping_cost desc
limit 3;

-- State  highest_sum_of_shipping_cost
with sws as (select state, sum(shipping_cost) as sum_shipping_cost from sales_dataset
group by state)

select * from sws
order by sum_shipping_cost desc
limit 3;


select state, sum(shipping_cost) as sum_shipping_cost
from sales_dataset
group by state
order by sum_shipping_cost desc
limit 3;

-- Common Table Expression: Complexity of any given Query + Reusability of the Query

with states as (select state, sum(shipping_cost) as sum_shipping_cost from sales_dataset
group by state
order by sum_shipping_cost desc
limit 3
)select * from states

-- Usually whenever you feel a lot of subqueries or joins are there in your sql queries, go for CTE

