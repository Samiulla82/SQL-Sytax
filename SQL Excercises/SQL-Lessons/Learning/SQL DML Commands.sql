
---------------------------SQL DML Commands-----------------

 ------------------Chapters-----------
 USE Excercise

 SELECT * FROM smartphone

--1. find the top 5 Samsung phones with the biggest screen size  

SELECT TOP (5) screen_size, model 
FROM smartphone 
WHERE brand_name= 'samsung'
ORDER BY screen_size DESC



--2. sort all the phones in descending order of the number of total cameras  

SELECT model, (num_rear_cameras + num_front_cameras) AS Total_camera 
FROM smartphone
ORDER BY Total_camera DESC



--3. sort data on the basis of ppi in decreasing order 

SELECT ROUND(SQRT(CAST(resolution_height  AS INT) * resolution_height + CAST(resolution_width AS INT) * resolution_width)/screen_size,1) AS PPI_values
FROM smartphone 
ORDER BY PPI_values DESC




--4. find the phone with 2nd largest battery  

SELECT MAX(battery_capacity) FROM smartphone
WHERE battery_capacity < (SELECT MAX(battery_capacity) FROM smartphone);



--5. find the name and rating of the worst rated apple phone 

SELECT TOP (1) model, rating FROM smartphone 

WHERE brand_name ='Apple'

ORDER BY rating ASC 

--6. sort phones alphabetically and then on the basis of rating in desc order 

SELECT brand_name, rating FROM smartphone
ORDER BY brand_name ASC, rating DESC

--7. sort phones alphabetically and then on the basis of price in ascending order ********************************* * 

SELECT * FROM smartphone 
ORDER BY model, price ASC




--  find the phone name, price of the costliest phone  

SELECT TOP (1) model, price 
FROM smartphone
ORDER BY price DESC;

---8. Find the phone name, price of the costlies phone.

SELECT TOP(1) model, price AS Costliest_phone FROM smartphone
ORDER BY Costliest_phone DESC



--------------------Grouping Data-------------------------

--GB1. Group smartphones by brand and get the count, average price, max rating, avg screen size, and avg battery capacity ********************************* * 

SELECT TOP(15) brand_name, COUNT(*) AS Count_of_Phone, AVG(price) AS AVG_Price, MAX(rating) AS Max_rating,ROUND(AVG(screen_size),2)AS AVG_Screen, ROUND(AV(battery_capacity),0) AS AVG_Batt 
FROM smartphone
GROUP BY brand_name
ORDER BY Count_of_Phone DESC 


--GB2--Group smartphones by whether they have an NFC and get the average price and rating Avg price of 5g phones vs avg price of non 5g phones 

SELECT has_nfc,AVG(price)AS AVG_price ,ROUND(AVG(rating),2) AS AVG_ratings 
FROM smartphone
GROUP BY has_nfc

--5g phones
SELECT has_5g,AVG(price),ROUND(AVG(rating),2) 
FROM smartphone
GROUP BY has_5g


--extended_memory_available--

SELECT extended_memory_available,AVG(price),ROUND(AVG(rating),2)
FROM smartphone
GROUP BY extended_memory_available


--Analysis of Fast Charging Available  

SELECT fast_charging_available, AVG(price) AS AVG_price, ROUND(AVG(rating),2) AS AVG_rating FROM smartphone
GROUP BY fast_charging_available

--GB3--Group smartphones by the extended memory available and get the average price  

SELECT extended_memory_available,AVG(price) AS AVG_price
FROM smartphone
GROUP BY extended_memory_available


1--------------------GroupBY on multiple columns  -------------

--GB4--Group smartphones by the brand and processor brand and get the count of models and the average primary camera resolution (rear)  

SELECT has_nfc, has_5g FROM smartphone
GROUP BY has_nfc,has_5g

SELECT brand_name, processor_brand,
COUNT(model) AS Numb_of_model,
ROUND(AVG(primary_camera_front),2) AS Pri_Cam
FROM smartphone
GROUP BY brand_name, processor_brand
ORDER BY Numb_of_model DESC, brand_name ASC   



--GB5-Find the top 5 most costly phone brands  

SELECT TOP(5) brand_name, AVG(price) AS costly_phone FROM smartphone
GROUP BY brand_name
ORDER BY costly_phone DESC



--GB6--Which brand makes the smallest-screen smartphones  
SELECT TOP(1) brand_name, ROUND(AVG(screen_size),1) AS smallest_screen FROM smartphone
GROUP BY brand_name
ORDER BY smallest_screen ASC;



--GB7 AVG price of 5G phones v/s AVG price of non 5G phones

SELECT has_5g,ROUND(AVG(price),2) AS AVG_price_5G_phone 
FROM smartphone
GROUP BY has_5g

--8. Group smartphones by the brand, and find the brand with the highest number of models that have both NFC and an IR blaster  

SELECT TOP(1) brand_name, COUNT(model) AS number_of_models 
FROM smartphone
WHERE has_nfc ='True' AND has_ir_blaster ='True'
GROUP BY brand_name
ORDER BY number_of_models DESC


--9. Find all Samsung 5g enabled smartphones and find out the avg price for NFC and Non-NFC phones  

SELECT has_nfc, AVG(price) AVG_Price
FROM smartphone
WHERE has_5g= 'True' AND brand_name= 'samsung'
GROUP BY  has_nfc

--


************************************************************************************************************* 

--Having clause  

--Costliest Brand which has at least 20 phones.  
SELECT brand_name, COUNT(model) AS Count_models, AVG(price) AS Costliest_phone 
FROM smartphone
GROUP BY brand_name
HAVING COUNT(model)  >40
ORDER BY  Count_models DESC



--find the avg rating of smartphone brands that have more than 20 phones 

SELECT brand_name, ROUND(AVG(rating),0) AS AVG_ratings, COUNT(*) AS Count_Phones
FROM smartphone
GROUP BY brand_name
HAVING COUNT(*) >20
ORDER BY AVG_ratings DESC;



--Find the top 3 brands with the highest avg ram that has a refresh rate of at least 90 Hz and fast charging available and don't consider brands that have less than 10 phones  

SELECT TOP(3) brand_name,

ROUND(AVG(ram_capacity),1)AS AVG_Ram_Ratings
FROM smartphone
WHERE refresh_rate > 90 AND fast_charging_available ='True'
GROUP BY brand_name
HAVING COUNT(*) >10
ORDER BY AVG_Ram_Ratings DESC




--Find the avg price of all the phone brands with avg rating of 70 and num_phones more than 10 among all 5g enabled phones  

SELECT brand_name, AVG(price)AS AVG_price, ROUND(AVG(rating),1) AS AVG_ratings
FROM smartphone
WHERE has_5g = 'True'
GROUP BY brand_name
HAVING AVG(rating) >70 AND COUNT(*) >10  

SELECT * FROM IPL_Ball
---*************************************************************************************************************  

----------------------------------Practice on IPL Dataset 1--------------

--- find the top 5 batsmen in IPL  

SELECT TOP(5) batter, SUM(batsman_run)AS Total_runs FROM IPL_Ball
GROUP BY batter
ORDER BY Total_runs DESC;



--- find the 2nd highest 6 hitters in IPL  
SELECT batter, COUNT(batsman_run)AS 'No_Sixes'
FROM IPL_Ball
WHERE batsman_run=6
GROUP BY batter
ORDER BY No_Sixes DESC
OFFSET 1 ROWS
FETCH NEXT 1 ROWS ONLY;



--- Find Virat Kohli's performance against all Bowler 

SELECT batter, bowler, SUM(batsman_run)AS Runs, Count(*)AS no_of_balls
FROM IPL_Ball
WHERE batter= 'V Kohli'
GROUP BY batter, bowler
ORDER BY Runs DESC


   
--- Find the top 10 batsmen with centuries in IPL [Need sub-query]  
 
 SELECT  batter,ID,  SUM(batsman_run)AS Score
 FROM IPL_Ball
 GROUP BY batter, ID
 HAVING SUM(batsman_run) > 100
 ORDER BY batter


--- find the top 5 batsmen with the highest strike rate who have played a min of 1000 balls  

SELECT TOP(10) batter, SUM(batsman_run)AS Runs, Count(batsman_run)AS BallS_Faced,
ROUND((SUM(batsman_run) / Count(batsman_run))*100,2) AS Strike_Rate
FROM IPL_Ball
GROUP BY batter
HAVING Count(batsman_run) >1000
ORDER BY Strike_Rate DESC

