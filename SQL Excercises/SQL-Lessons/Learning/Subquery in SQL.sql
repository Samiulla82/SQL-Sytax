

------------------------What is subquery in SQL-------------
A subquery is a SQL query nested inside a larger query.

------A subquery can be located in :
--- A SELECT clause
--- A FROM clause
--- A WHERE clause
--- A HAVING clause

--------------------------------Practical Example of Subquery ---------------------

---Example:- Fidn the movie with highest rating

SELECT * FROM movies  
ORDER BY score DESC;

-- Types of Subquery 
-- Where can subquery be used? 
-- Scalar Subquery 
-- Example #4 Independent subquery 
-- Row Subquery 
-- Table Subquery 
-- Example #2 Usage with FROM 
-- Example #1 Usage with HAVING 
-- Example #1 Subquery in INSERT 
-- Example #1 Subquery in UPDATE 
-- Example #1 (Get the query at the last section of this session) Subquery in DELETE 
-- Subquery in UPDATE (Resolved) 

--             Independent Subquery - Scalar Subquery---------------

--1. Find the movie with highest profit(vs order by)

SELECT * FROM movies
WHERE (gross-budget)= (SELECT  MAX(gross-budget) FROM movies)	

SELECT TOP (1) *, (gross - budget) AS profit FROM movies
ORDER BY profit DESC;




--2.Find how many movies have a rating > the avg of all the movie ratings(Find the count of above average movies)

SELECT Count(*) AS Total_movies_Count_of_AVG_rating 
FROM movies
WHERE score > (SELECT AVG(score) AVG_Rating 
                FROM movies)


 
--3. Find the highest rated movie of 2000

SELECT * FROM movies WHERE year = 2000 AND score =(SELECT MAX(score) 
                                                   FROM movies 
												   WHERE year = 2000)



--4. Find the highest rated movie among all movies whose number of votes are > the dataset avg votes 


SELECT * FROM movies WHERE score= (SELECT MAX(score) 
                                   FROM movies WHERE votes > (SELECT AVG(votes) 
								                              FROM movies))



------------Independent Subquery - Row Subquery(One Col Multi Rows)------
USE zomato

--1. Find all users who never ordered

 SELECT * FROM users
 WHERE user_id NOT IN (SELECT DISTINCT(USER_ID) FROM orders)



--2. Find all the movies made by top 3 directors(in terms of total gross income)

SELECT * FROM movies
WHERE director IN ( SELECT TOP(3) director
                    FROM movies
					GROUP BY director
					ORDER BY SUM(gross) DESC)





--3.Find all movies of all those actors whose filmography's avg rating > 8.5(take 25000 votes as cutoff)

SELECT * FROM movies
WHERE star IN (SELECT star 
                FROM movies 
				WHERE votes > 25000 
				GROUP BY star 
				HAVING AVG(score)> 8.5)


-------Independent Subquery - Table Subquery(Multi Col Multi Row)-----------

--1. Find the most profitable movie of each year

SELECT * FROM movies
WHERE (year, (gross-budget)) IN ( SELECT year, MAX(gross-budget) 
                                 FROM movies 
								 GROUP BY year)

--2. Find the highest rated movie of each genre votes cutoff of 25000

SELECT * FROM movies
WHERE (genre, score) IN (SELECT genre, MAX(score) 
                           FROM movies 
						   WHERE votes > 25000 
						   GROUP BY genre)




--3.Find the highest grossing movies of top 5 actor/director combo in terms of
--total gross income.

SELECT * FROM movies 
WHERE (star, director) IN (SELECT star, director 
                            FROM movies
							GROUP BY star, director 
							ORDER BY MAX(gross) DESC)


---------------------------Correlated Subquery------------------


--1.Find all the movies that have a rating higher than the average rating of movies in the same genre.

SELECT *FROM movies m1
WHERE score> (SELECT AVG(score) FROM movies m2
WHERE  m1.genre=m2.genre)






--2. Find the favorite food of each customer.
WITH Temp_table AS (
SELECT t2.user_id, t1.name,t4.f_name, count(*)AS Frequent_order FROM users AS t1
JOIN orders AS t2 ON t1.user_id = t2.user_id
JOIN order_details AS t3 ON t2.order_id=t3.order_id
JOIN food AS t4 ON t3.f_id=t4.f_id
GROUP BY T1.name, T2.user_id,t3.f_id, t4.f_name
)
SELECT *FROM Temp_table f1
WHERE Frequent_order =(SELECT  MAX(Frequent_order) 
                         FROM  Temp_table f2 
						 WHERE f2.user_id = f1.user_id)



 
 --------------------Usage with SELECT---------------------



--1.Get the percentage of votes for each movie compared to the total number of votes.

SELECT name, (votes/(SELECT SUM(votes) FROM movies))*100 FROM movies



--2. Display all movie names ,genre, score and avg(score) of genre 

SELECT name, genre, score, (SELECT AVG(score) AS AVG_score FROM movies m2 WHERE m2.genre=m1.genre) FROM movies m1



--3. Display all movie names ,genre, score,  and Max(profit) of genre 
--Why this is inefficient?



SELECT  name, genre, (gross- budget)AS Profit,(SELECT MAX(gross - budget) FROM movies n2 WHERE n2.genre=n1.genre)  FROM movies n1


 ----------------------Usage with FROM------------------------

-- 1. Display average rating of all the restaurants

SELECT * FROM orders
SELECT * FROM restaurants

SELECT r_name, AVG_rating
FROM (SELECT r_id, AVG(restaurant_rating) AVG_rating FROM orders GROUP BY r_id) j1 join restaurants j2 ON j1.r_id=j2.r_id

---------------------Usage with HAVING----------------------

--1. Find genres having avg score > avg score of all the movies

SELECT genre, AVG(score) FROM movies
GROUP BY genre
having AVG(score) > (

SELECT AVG(score) FROM movies)																				

------------------------------Subquery In INSERT-----------------------
--Populate a already created loyal_customers table with records of only those customers who have ordered food more than 3 times.


CREATE TABLE loyal_customers (user_id int, names varchar(50), money int)

INSERT INTO loyal_customers
(names, user_id)
SELECT  t6.name, t6.user_id FROM orders AS t7 
JOIN users AS t6 
ON t6.user_id=t7.user_id
GROUP BY t6.user_id, t6.name
HAVING count(order_id)>3 

SELECT * FROM loyal_customers



-----------------------------Subquery in UPDATE----------------------

--Populate the money col of loyal_cutomer table using the orders table.
--Provide a 10% app money to all customers based on their order value.

SELECT user_id, Round((SUM(amount)*0.1),0) AS Incentive  FROM orders
GROUP BY user_id



--------------------Subquery in DELETE------------------------
Delete all the customers record who have never ordered.

SELECT * FROM users

DELETE users
WHERE user_id IN (SELECT user_id 
                    FROM users 
					WHERE user_id NOT IN (SELECT user_id 
					                        FROM orders))