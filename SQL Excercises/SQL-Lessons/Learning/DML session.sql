

----SQL DML session

-------------DML session---------------------------

--Insert 
--Insert Variation
--Insert Multiple 

USE CampusX
USE Excercise

SELECT * FROM smartphones_cleaned_v6


CREATE TABLE users (user_id int, name VARCHAR (255),email VARCHAR (255), password VARCHAR (255));

SELECT * FROM users

EXEC sp_Columns users


----How to Import data in DBMS /mysql work Bench

USE Excercise

SELECT * FROM smartphone

--Select all
--filter columns
--alias- renaming columns
--create experession using columns
--constants



---Fetche first 3 colums
SELECT model,price,rating FROM smartphone;


--Fetch Coulmn with coulmn Alias

SELECT os AS 'Operating System', model, battery_capacity FROM smartphone

SELECT model, 
SQRT(cast (resolution_width AS INT ) * resolution_width + cast (resolution_height AS INT) * resolution_height)/screen_size AS PPI_values
FROM smartphone;


SELECT model,rating/10 AS Ratings FROM smartphone;

---Constant-----
 
SELECT model,'Smartphone' AS Type FROM smartphone;



----Distinct (Unique) Values from a Column----

SELECT DISTINCT(brand_name) FROM smartphone

SELECT DISTINCT(processor_brand) FROM smartphone

SELECT DISTINCT(os) FROM smartphone

----Distinct Combos-----

SELECT DISTINCT brand_name, processor_brand  FROM smartphone



---Filter rows WHERE clause-----

SELECT * FROM smartphone WHERE brand_name= 'samsung'

SELECT * FROM smartphone WHERE price > 100000

--Between-----

--Findi all phones in the price range of 100000 and 200000
SELECT * FROM smartphone WHERE price BETWEEN 100000 AND 2000000

SELECT * FROM smartphone WHERE price > 100000 AND price < 150000

--Two Condition--
SELECT * FROM smartphone WHERE rating >80 AND price < 25000;

SELECT * FROM smartphone WHERE rating >80 AND price < 15000;

--Three Condition--
SELECT * FROM smartphone WHERE price < 18000 AND rating > 80 AND processor_brand='snapdragon';

-- Samsung phones with ram >8 GB
SELECT * FROM smartphone WHERE ram_capacity > 8;

---IN and NOT IN

  where processor_brand IN ('snapdragon','exynos', 'dimensity','bionic')

  
  WHERE processor_brand NOT IN ('snapdragon', 'exynos','mediatek')


---------------UPDATE-------------
USE Excercise

UPDATE smartphone
SET processor_brand='mediatek'
WHERE processor_brand ='dimensity'



SELECT * FROM smartphone 
WHERE processor_brand IN ('mediatek')

UPDATE users
 SET names= 'Soniya Sana'
 WHERE userID=1008


UPDATE users
SET names= 'Taniya Sharma', email='taniya@email.com'



 ---DELETE------

DELETE users

USE CampusX
SELECT * FROM users

USE Excercise

--Delete the phone price are greater 2 lakh

DELETE smartphone
WHERE price > 200000

DELETE smartphone
WHERE battery_capacity > 70000

 
 ------====---Types of SQL Functions---====-----------------

-----Min/Max--------

SELECT MAX(price) AS Costliest_Phone FROM smartphone

SELECT MIN(price) AS Cheapest_Price  FROM smartphone

SELECT MIN(price) AS Cheapest_Phone, MAX(price) AS Costeliest_phone FROM smartphone


SELECT MAX(price)AS Samsung_costeliest_phone FROM smartphone
WHERE brand_name= 'samsung'


-----AVG--------

SELECT AVG(rating) AS AVG_Samsung_phone FROM smartphone
WHERE brand_name ='samsung'

----SUM-----

SELECT SUM(price) AS Total_Samsung_price FROM smartphone
WHERE brand_name='samsung'

-----Count--------

SELECT COUNT(*) FROM smartphone	
WHERE brand_name='samsung'

-----Count(Distinct)--------

SELECT DISTINCT(brand_name) FROM smartphone

SELECT COUNT(distinct brand_name) Total_brands FROM smartphone

SELECT STDEV(price) FROM smartphone

SELECT VAR(price) FROM smartphone


SELECT VAR(screen_size) FROM smartphone

---  ABS---------


---   Round ---------

---ROUND(,0)

SELECT ROUND(VAR(price),2) FROM smartphone


-------------Ciel/Floor----------
----Ciel(roundoff)
SELECT brand_name,CEILING(screen_size) FROM smartphone

---Floor(-1)

SELECT brand_name,FLOOR(screen_size) FROM smartphone

----Find the AVG battary & AVG Rear Camera ,price greater than or equeal 1 lakhh

SELECT AVG(battery_capacity)AS AVG_Bat, AVG(num_rear_cameras) AS AVG_Cam FROM smartphone 
WHERE price >= 100000;

--AVG Capacity of phone that has a 120 HZ refresh rate ,front camera >20 MP

SELECT  AVG(internal_memory) AS AVG_Phone_Capacity FROM smartphone WHERE refresh_rate = 120 AND primary_camera_front >= 20


---Find the 5G campatibility phone

SELECT COUNT(*) FROM smartphone WHERE has_5g =1


