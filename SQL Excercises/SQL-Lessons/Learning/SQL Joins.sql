
---------------------------SQL JOINS--------------------------

--What are SQL joins 
A JOIN clause is used to combine rows from two or more tables, based on a related column between them.

----Let's look at a selection from the "Orders" table:

--But why have data in multiple tables? 
 
--Types of Joins 
--Cross Joins --- Cartesian Products 
--Inner Joins 
 --Left Joins 
--Right Joins 
--Full Outer Join 
---Set Operations 



---------------------SQL Hands-on on Joins 
 --Tables--
SELECT * FROM membership
SELECT * FROM users1
SELECT * FROM groups
 
--------------Cross Joins --- Cartesian Products 
SELECT * FROM users1 t1
CROSS JOIN groups t2


----Inner Joins 

SELECT * FROM users1 AS u1
INNER JOIN membership AS m1 
ON u1.user_id = m1.user_id 

SELECT * FROM membership AS m1
INNER JOIN users1 u1
ON m1.user_id=u1.user_id

 
----------------Left Joins----

SELECT * FROM membership AS m1
LEFT JOIN users1 AS u1
ON u1.user_id=m1.user_id


----------Right Joins---------

SELECT * FROM membership AS m1
RIGHT JOIN users1 AS u1
ON m1.user_id = u1.user_id;

------------Full Outer Join--------------------

Select * From membership AS m1
full outer join users1 AS u1
ON m1.user_id=u1.user_id;




 ----------------------------Set Operations------------------- 
 The UNION operator is used to combine the result-set of two or more SELECT statements.

Every SELECT statement within UNION must have the same number of columns
The columns must also have similar data types
The columns in every SELECT statement must also be in the same order.


-------------------------Set Operations Hands-on--------------------
--UNION: The UNION operator is used to combine the results of two or more SELECT statements into a single result set. The UNION operator removes duplicate rows between the various SELECT statements.

--1.UNION ALL: The UNION ALL operator is similar to the UNION operator, but it does not remove duplicate rows from the result set.
--2.INTERSECT: The INTERSECT operator returns only the rows that appear in both result sets of two SELECT statements.
--3.EXCEPT: The EXCEPT or MINUS operator returns only the distinct rows that appear in the first result set but not in the second result set of two SELECT statements.



----UNION Syntax

SELECT * FROM Person1
UNION
SELECT * FROM Person2
UNION
SELECT * FROM Person3



-------UNION ALL Syntax
SELECT * FROM Person1
UNION ALL
SELECT * FROM Person2
UNION ALL
SELECT * FROM Person3
ORDER BY name ASC

SELECT * FROM Person1
UNION ALL
SELECT * FROM Person2
UNION ALL
SELECT * FROM Person3
ORDER BY name ASC

----UNION ALL With WHERE

SELECT City, Country FROM Customers
WHERE Country='Germany'
UNION
SELECT City, Country FROM Suppliers
WHERE Country='Germany'
ORDER BY City;

----INTERSECT----
 
SELECT * FROM Person1
INTERSECT
SELECT * FROM Person2
INTERSECT
SELECT * FROM Person3

----EXCEPT----

SELECT *FROM Person1
EXCEPT
SELECT * FROM Person2


--Self Join 
--A self join is a type of join in which a table is joined with itself. This means that the table is treated as two separate tables, with each row in the table being compared to every other row in the same table.
--Self joins are used when you want to compare the values of two different rows within the same table. 
--For example, you might use a self join to compare the salaries of two employees who work in the same department, or to find all pairs of customers who have the same billing address.


-------------------Self Join Hands-on 

 --Q-1: Find the name of emergency contact number

 SELECT * FROM users1 AS t1
 JOIN Users1 AS t2
 ON t1.emergency_contact=t2.user_id;
  



 ----Q-2:Find those employees whose salary more than to their mangers salary
 --SELECT * FROM emp_manager

SELECT t1.emp_name, t1.salary, t2.emp_name AS manager_name, t2.salary AS Managers_Sal FROM emp_manager AS t1
JOIN emp_manager AS t2 
ON t1.manager_id = t2.emp_id
WHERE t1.salary > t2.salary;

CREATE TABLE accounts(std_id VARCHAR(255), Course_id VARCHAR(255), Since int);
drop TABLE accounts
INSERT INTO accounts VALUES('S1', 'C1', 2016),('S2', 'C1',2017),('S1', 'C2',2017),('S2', 'C3',2018),('S3', 'C1',2018);

SELECT std_id, COUNT(*) AS Count_courses 
FROM accounts
GROUP BY std_id


---------------------Query Execution Order --------------------

--FROM, JOIN, WHERE, GROUP BY, HAVING, SELECT, DISTINCT, ORDER BY, and finally, LIMIT/OFFSET.


--Joining on more than one col 

SELECT * FROM students AS t1
JOIN class AS t2
ON t1.class_id = t2.class_id
AND t1.enrollment_year = t2.class_year




-----------------Joining more than-------------------
--SELECT * FROM users3
--SELECT * FROM orders1
--SELECT * FROM order_details;
--SELECT * FROM category;

--Rename Column--------------------------- to Remember that syntax-----------
--EXEC sp_rename 'category.Vertical',  'category', 'COLUMN';
--EXEC sp_rename 'category.Vertical1',  'vertical', 'COLUMN';

--Find the Name of customers by joining required table with 

SELECT od.order_id,od.amount,od.profit,u3.name,u.user_id
FROM order_details AS od
JOIN orders1 AS u
ON od.order_id =u.order_id
join users3 u3
ON u.user_id=u3.user_id;


-- Find order_id, name, and city by joining users and orders. 

SELECT t2.order_id, t1.name,t1. city FROM users3 AS t1
JOIN orders1 AS t2
ON t1.user_id= t2.user_id



-- Find order_id, and product category by joining order_details and category Filtering Rows 

SELECT t1.order_id,t1.category_id,t2.category FROM order_details AS t1
JOIN category AS t2
ON t1.category_id= t2.category_id
WHERE T2.category ='Stole'




--------------SELECT * FROM category----------
-- Find all the orders placed in Pune 

SELECT * FROM order_details AS t1
JOIN orders1 AS t2 
ON t1.order_id= t2.order_id
JOIN users3 AS t3
ON t2.user_id=t3.user_id
WHERE city ='Pune'


---------------SELECT * FROM category-----------------

-- Find all orders under the Chairs category Practice Questions 

SELECT * FROM order_details AS t1
JOIN category AS t2
ON t1.category_id = t2.category_id
WHERE category = 'Chairs'


--Find all profitable orders 

 SELECT  t1.order_id, SUM(profit) AS Order_Profit FROM orders1 AS t1
 JOIN order_details t2
 ON t1.order_id =t2.order_id
 GROUP BY t1.order_id
 HAVING SUM(profit)>0
 ORDER BY Order_Profit DESC




--Find the customer who has placed the max number of orders 

SELECT TOP(1) name, COUNT(*) AS No_orders  FROM users3 t1
JOIN orders1 t2
ON t1.user_id=t2.user_id
GROUP BY name
ORDER BY No_orders DESC






--Which is the most profitable category 

SELECT * FROM users3
--SELECT * FROM orders1
--;
--
SELECT TOP (1) t1.category, SUM(profit) AS Profitable_cat FROM category AS t1
JOIN order_details AS t2
ON t1.category_id= t2.category_id
GROUP BY t2.order_id, t1.category
ORDER BY Profitable_cat DESC

---Which is the most profitable state

SELECT TOP (1) t1.State, SUM(t3.profit) AS profitable_state FROM users3 AS t1
JOIN  orders1 t2
ON t1.user_id=t2.user_id
JOIN order_details t3
ON t2.order_id=t3.order_id
GROUP BY t1.State
ORDER BY profitable_state DESC;



--Find all catergories with profit higher than 5000

SELECT  t2.category,SUM(profit) AS Profit
 FROM order_details AS t1
JOIN category AS t2
ON t1.category_id =t2.category_id
GROUP BY  t2.category
HAVING SUM(profit) > 5000
ORDER BY Profit DESC


