
-------------SQL BASIC---------------

----DDL Commands for TABLES
--CREATE
--TRUNCATE
--DROP



---Create Database

 CREATE DATABASE CampusX
 CREATE DATABASE IF NOT EXISTS CampusX;

 ----Use Database---
  USE  CampusX
  USE master

 USE Excercise
 
 ---Drop Database

  DROP DATABASE IF  EXISTS CampusX;

   CREATE DATABASE happy;
 use master
 DROP DATABASE happy;




 ----CREATE TABLE-----

 CREATE TABLE users (userID INT, names VARCHAR(250), email varchar(200), Password char (250))

 SELECT * FROM users
 INSERT into users values(1001,'Taniya','taniya@email.com','Tannu4U'),
(1002,'Saniya','Saniya@email.com','Saanu4U'),
(1003,'Romaniya','romananiya@email.com','Romannu4U'),
(1004,'Saiana','Saiana@email.com','Saiana4u'),
(1005,'Gulbaniya','Gulbaniya@email.com','Gulbaniya4u'),
(1006,'Dilbar','Dilbar@email.com','Dilbar4U'),
(1007,'janiya','janiya@email.com','janiya4U'),
(1008,'Soniya','Soniyaa@email.com','Soniya4U'),
(1009,'Shamiya','Shamiya@email.com','Shamiya4U');
 
  ----CREATE TABLE-----

 CREATE TABLE employee(
  e_id int,
  e_name varchar(255),
  e_salary int,
  e_age int ,
  e_gender varchar(5),
  e_dept varchar (20),
  primary key (e_id)
   );

   SELECT * FROM employee

   INSERT INTO employee VALUES
   (1013,'John Smith', 25000,28,'Male','D01');

  --- Drop Table Employee

   INSERT INTO employee VALUES(
   1002,'Tina Smith', 23500,24,'Femal','D02'),
   (1003,'William Smith', 29000,29,'Male','D01'),
   (1004,'Ellie Williamson', 26000,30,'Femal','D04'),
   (1005,'John Williamson', 27000,30,'Male','D03'),
   (1006,'Mary Smith', 33000,33,'Femal','D04'),
   (1007,'Elizabeth Smith', 29000,30,'Femal','D02'),
   (1008,'John Smith', 38000,38,'Male','D01'),
   (1009,'Betty Smith', 26550,28,'Femal','D04'),
   (1010,'Tom Smith', 34000,35,'Male','D01'),
   (1011,'Tonny Smith', 31000,30,'Male','D02');

   SELECT count(*) FROM employee
   SELECT Distinct(e_name) FROM employee

Create TABLE users1(
user_ids int NOT NULL,
names VARCHAR(255) NOT NULL,
email VARCHAR (255) NOT NULL UNIQUE,
password VARCHAR (255) NOT NULL
)

DELETE FROM Employees

----Drop Table data


DROP TABLE Employees

DROP TABLE FROM Employees

SELECT * FROM users
SELECT * FROM employee
SELECT COUNT(*) FROM employee

DELETE e_name FROM employee
GROUP BY names
HAVING COUNT(*)>1


CREATE TABLE Employees( 
    [ID] INT NOT NULL PRIMARY KEY IDENTITY , 
    [FirstName] Varchar(100), 
    [LastName] Varchar(100), 
    [Country] Varchar(100), 
	CONSTRAINT my_cons UNIQUE (ID,FirstName)
    ) 
    GO 
    
----Insert Data into Table----


    Insert into Employees ([FirstName],[LastName],[Country] )values('Raj','Gupta','India'),
                                ('Raj','Gupta','India'),
                                ('Mohan','Kumar','USA'),
                                ('James','Barry','UK'),
                                ('James','Barry','UK'),
                                ('James','Barry','UK');

SELECT * FROM Employees



DELETE ID FROM Employees
GROUP BY ID
HAVING COUNT(*) >1

SELECT [FirstName], 
    [LastName], 
    [Country], 
    COUNT(*) AS CNT
FROM [SampleDB].[dbo].[Employee]
GROUP BY [FirstName], 
      [LastName], 
      [Country]
HAVING COUNT(*) > 1;

SELECT * FROM Employees

drop table Employees




CREATE TABLE Students (
student_id INT PRIMARY KEY ,
names VARCHAR(55),
age INT 

CONSTRAINT students_age_Check CHECK( age >6 AND age <25)
);

INSERT INTO Students 
VALUES (1001,'Sanam Saeed', 15),
(1002,'Hania Amir',23 );



SELECT * FROM Students

DROP TABLE Students 

CREATE TABLE students (
ID INT PRIMARY KEY ,
names VARCHAR (255),
age int check (age >6 AND age <25)
);

INSERT into students VALUES
(1001, 'Sania Mirza', 32),
(1002, 'Hania', 24),
(1003,'Mahira Khan', 24)
;

 

 SELECT * FROM ticket
 DROP TABLE ticket

 CREATE TABLE ticket( ticket_ID INT PRIMARY KEY ,
 ticket_name VARCHAR(255) NOT NULL,
 ticket_date DATE DEFAULT GETDATE()
 );

 
 INSERT INTO ticket(ticket_ID, ticket_name) VALUES
(123, 'Lalu Yadav'),
(456, 'Dimple Yadav');


CREATE TABLE ticket (
ticket_ID INT PRIMARY KEY,
ticket_name VARCHAR (255) NOT NULL,
ticket_date DATE DEFAULT GETDATE()
);

INSERT INTO ticket(ticket_ID, ticket_name)VALUES
(123456, 'Sanam Saeed'),
(45678,'Hania Amir'),
(12365,'Mahira Khan'),
(258741,'Dananeer');

SELECT * FROM ticket;

update ticket
SET ticket_name='Ayesha khan'
WHERE ticket_name='Mahira Khan'

---Forein Key----

DROP TABLE customer

CREATE TABLE customer(
c_ID INT PRIMARY KEY IDENTITY,
c_name VARCHAR (255) NOT NULL,
c_email VARCHAR (255) NOT NULL UNIQUE,
);

INSERT INTO customer (c_name,c_email) VALUES(
 'Tabassum','Tabbu_4u@email.com'),
( 'Riya', 'Riya_4u@email.com'),
( 'Tamanna', 'Tamanna_4u@email.com');
INSERT INTO customer(c_name, c_email) VALUES('Nadiya Tabassum', 'Nadiya_4u@email.com');

---Cascade----

CREATE TABLE orders (order_ID INT PRIMARY KEY IDENTITY,
c_ID INT NOT NULL , 
order_Date DATE NOT NULL DEFAULT GETDATE()

CONSTRAINT order_fk FOREIGN KEY (c_ID) REFERENCES customer (c_ID)

ON DELETE CASCADE 
ON UPDATE CASCADE );


SELECT * FROM customer
---DROP TABLE customer

SELECT * FROM orders
----DROP TABLE orders


CREA


INSERT INTO orders(c_ID) VALUES (2);
DELETE customer
WHERE c_name='Tamanna';

DELETE orders 
WHERE c_ID =2
DELETE customer
WHERE c_name='Riya';

UPDATE customer
SET c_name ='TABBASSUM KAUSAR'
WHERE c_ID=1

---Set Null ----


------ADD COULMN -----

SELECT * FROM customer

ALTER TABLE customer
ADD  passwords VARCHAR(250);

ALTER TABLE customer
ADD password VARCHAR (255);

ALTER TABLE customer 
ADD age INT;

ALTER TABLE customer
---ADD surname VARCHAR  (255) NULL--
---ADD SURNAMES VARCHAR  (255) NULL---
ADD PAN  VARCHAR (255) NULL; 


---------------------------DROP_COLUMN------------------

ALTER TABLE customer 
DROP COLUMN surname;

ALTER TABLE customer
DROP COLUMN surnames

ALTER TABLE customer
DROP COLUMN PAN

ALTER TABLE customer
DROP COLUMN PANCARD;

ALTER TABLE customer
DROP COLUMN passwords;
---------------RENAME-------------



EXEC sp_rename 'customer.PAN',  'PANCARD', 'COLUMN';

-----ALTER TABLE -------

ALTER TABLE customer
ADD order_status VARCHar(255) DEFAULT 'ordered'

SELECT * FROM customer

INSERT INTO customer(c_name,c_email,passwords)VALUES
('Rihana','Rihaana4u@email.com','rihu143');

ALTER TABLE customer
DROP COLUMN order_status

SELECT * FROM customer

ALTER TABLE customer
DROP COLUMN passwords 

exec sp_columns customer



ALTER TABLE customer
DROP COLUMN order_status


----- --- ADD CONTSTRAINT----------
SELECT * FROM customer

ALTER TABLE customer
ADD CONSTRAINT name_age_check CHECK(age >21);

ALTER TABLE customer
ADD CONSTRAINT chech_on_age CHECK (age >21);



----- --- EDIT/DELETE CONTSTRAINT----------

ALTER TABLE customer
ADD age INT CHECK (age > 18 AND age <70);

ALTER TABLE customer
DROP COLUMN age

INSERT INTO customer (c_name,c_email,age)VALUES
('Tarannum', 'Tarru4U@email.com',35);

ALTER TABLE customer
ADD CONSTRAINT check_age_cons Check