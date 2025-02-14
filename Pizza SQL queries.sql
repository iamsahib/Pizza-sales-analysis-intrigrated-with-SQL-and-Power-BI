create database pizzadb;
use pizzadb;  #DATABASE AND TABLE CREATION IMPORTING A DATA FROM EXCEL TO SQL SERVER 
CREATE TABLE pizza (
    pizza_id INT AUTO_INCREMENT PRIMARY KEY,      -- Unique identifier for each pizza
    order_id INT NOT NULL,                        -- ID referencing the order
    pizza_name_id VARCHAR(30),                   -- ID referencing the name of the pizza
    quantity INT NOT NULL,                        -- Quantity of pizzas ordered
    order_date DATE NOT NULL,                     -- Date of the order
    order_time TIME NOT NULL,                     -- Time of the order
    unit_price DECIMAL(10, 2) NOT NULL,           -- Unit price of the pizza
    total_price DECIMAL(10, 2) NOT NULL,          -- Total price (quantity * unit_price)
    pizza_size VARCHAR(20),  -- Size of the pizza
    pizza_category VARCHAR(50) NOT NULL,          -- Category of the pizza (e.g., Veg, Non-Veg)
    pizza_ingredients VARCHAR(100),                       -- Ingredients of the pizza
    pizza_name VARCHAR(100) NOT NULL              -- Name of the pizza
);
DROP TABLE pizza;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pizza_sales.csv'
INTO TABLE pizza
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

select * from pizza;
describe pizza;

#IMPORTING THE DATA IS DONE TASK ONE IS COMPLETED

#PROBLEM STATEMENT 
#TASK 1 -- FIND OUT THE TOTAL REVENUE OF THE PIZZA SALES
select sum(total_price) as total_revenue from pizza; 

#TASK 2 -- FIND OUT THE AVERAGE ORDER VALE
SELECT * FROM pizza;
SELECT round(sum(total_price)/COUNT( distinct order_id),2) as average_order_value FROM pizza; #By calculating the total revenue / total number of orders 

#TASK 3 TOTAL PIZZA SOLD 

SELECT sum(quantity) as PIZZA_SOLD from pizza;

#TASK 4 FIND OUT THE TOTAL ORDERS
SELECT * FROM pizza;
SELECT count(distinct order_id) as total_orders FROM pizza;

#TASK 5 FIND OUT THE AVERAGE PIZZA PER ORDER 
select * from pizza;
select sum(quantity)/count(distinct order_id) as avg_pizza_per_order from pizza;

#FOR VISUALIZATION 

#TASK 6 FIND OUT THE COUNT OF PER DAY / DAILY TREAD SALES 

select * from pizza;
select dayname(order_date) as Day_Name,
count(distinct order_id) as Total_Order 
from pizza group by Day_Name;

#TASK 7 HOURLY TREND FOR PIZZA SALES
select * from pizza;
select hour(order_time) as hourly_order,
count(distinct order_id) as total_orders 
from pizza group by hourly_order 
order by hourly_order;

#TASK 8 PERCENTAGE SALE BY PIZZA CATEGORY
select * from pizza;
select pizza_category,
sum(total_price) as total_sales, #show the sales of the category
round(sum(total_price)*100/(select sum(total_price) from pizza),2) as percentage_sale
from pizza 
group by pizza_category;

#TASK 9 PERCENTAGE SALE BY PIZZA SIZE
SELECT pizza_size,
round(sum(total_price)*100/(select sum(total_price) from pizza),2) as percentage_sale
from pizza
group by pizza_size
order by percentage_sale;

 #TASK 10 PIZZA SOLD BY PIZZA CATEGOTY 
 
 SELECT * from pizza;
 SELECT pizza_category,SUM(quantity) as total_quantity_sold
from pizza
group by pizza_category;


#TASK 11 TOP 5 PIZZA SOLD 
select * from pizza;
select pizza_name, sum(quantity) as total_quantity_sold
from pizza
group by pizza_name
order by total_quantity_sold desc
limit 5;

##TASK 11 BOTTOM 5 PIZZA SOLD 
select pizza_name, sum(quantity) as total_quantity_sold
from pizza
group by pizza_name
order by total_quantity_sold
limit 5;