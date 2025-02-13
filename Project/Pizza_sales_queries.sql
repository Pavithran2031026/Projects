# CREATE DATABASE 
Create Database if not exists Supermarket_details;
Use Supermarket_details;

# CREATE TABLE DATABASE :
# TABLE SALESMANDETAILS
Create Table if not exists SalesmanDetails (Salesman_ID Int Primary Key not null, S_Name varchar(20) not null, City varchar(20) null,
Commission float); 

#TABLE CUSTOMERDETAILS
Create Table if not exists CustomerDetails(Customer_ID Int Primary Key,Customer_Name Varchar(25),City varchar(20),Grade varchar(10),
SD_ID Int, foreign key(SD_ID) references SalesmanDetails(Salesman_ID));

# TABLE ORDERDETAILS
Create Table if not exists OrderDetails(Order_No Int Primary Key,Purchase_Amt float(10,2),Order_Date Date ,CD_ID int,
SD_ID Int, foreign key(SD_ID) references SalesmanDetails(Salesman_ID),foreign key(CD_ID) references CustomerDetails(Customer_ID));

# DESC ( SHOW THE FIELD & TYPE OF TABLE)
desc OrderDetails;
desc CustomerDetails;

# INSERT THE VALUES OF TABLES ( SALESMANDETAILS, CUSTOMERDETAILS, ORDERDETAILS )

Insert SalesmanDetails (Salesman_ID,S_Name,City,Commission) values(5001,'James Hoog','New York',0.15),(5002,'Nail Kite','Paris',0.13),
(5005,'Pit Alex','London',0.11),(5006,'Mc Lyon','Paris',0.14),(5003,'Lauson Hen',null,0.12),(5007,'Paul Adam','Rome',0.13); 
Insert into CustomerDetails(Customer_ID,Customer_Name,City,Grade,SD_ID) values (3002,'Nick Rimando','New york',100,5001),
(3005,'Graham Zusi','California',200,5002),(3001,'Brad Guzan','London',100,null),(3004,'Fabian Johns','Paris',300,5006),
(3007,'Brad Davis','New york',200,5001),(3009,'Geoff Camero','Berlin',100,null),
(3008,'Julian Green','London',300,5002),(3003,'Jozy Altidor','Moncow',200,5007);
Insert into OrderDetails values(70001,150.5,'2016-10-05',3005,5002),(70009,270.65,'2016-09-10',3001,null),(70002,65.26,'2016-10-05',3002,5001),
(70004,110.5,'2016-08-17',3009,null),(70007,948.5,'2016-09-10',3005,5002),(70005,2400.6,'2016-07-27',3007,5001),
(70008,5670,'2016-09-10',3002,5001),(70010,1983.43,'2016-10-10',3004,5006),(70003,2480.4,'2016-10-10',3009,null),
(70012,250.45,'2016-06-27',3008,5002),(70011,75.29,'2016-08-17',3003,5007);

# Excute the Tables
Select * from SalesmanDetails;
select * from CustomerDetails;
select * from OrderDetails;


Delete from SalesmanDetails where Salesman_ID=5003;								# DELETE
Insert into SalesmanDetails (Salesman_ID,S_Name,City,Commission) 
values(5003,'Lauson Hen',null,0.12);											# INSERT THE VALUES	
select Order_No,Order_Date,Purchase_Amt from OrderDetails where SD_ID=5001;		# WHERE 

# STRING FUNCTION #
select substr(S_Name,1,5) from SalesmanDetails;									# SUB-STRING
select Customer_Name,position("a" in Customer_Name) from CustomerDetails;		# POSITION 		
select rtrim(S_Name) from SalesmanDetails;										# RIGHT TRIM
select ltrim(Customer_Name) from CustomerDetails;								# LEFT TRIM
select concat_ws(S_Name,Customer_Name) from SalesmanDetails,CustomerDetails;	# CONCAT_WS	
select S_Name,UCASE(S_Name) as UPPER_S_Name from SalesmanDetails;				# UPPER CASE
Select Customer_Name,LCASE(Customer_Name) as LOWER_C_Name from CustomerDetails;	# LOWER CASE
select left(S_Name,5) from SalesmanDetails;										# LEFT
select right(Customer_Name,5) from CustomerDetails;								# RIGHT	

# AGGREGATE FUNCTION #
Select SD_ID,sum(Purchase_Amt) from OrderDetails where SD_ID 
between 5001 and 5007 group by SD_ID;											# SUM
select City,max(Grade) from CustomerDetails group by City;						# MAX
select CD_ID,min(Purchase_Amt) from OrderDetails group by CD_ID;				# MIN	
select avg(Purchase_Amt) from OrderDetails;										# AVARAGE
select count(distinct City) from CustomerDetails; 								# Count
select Purchase_Amt,SD_ID,CD_ID from OrderDetails where Purchase_Amt = (select max(Purchase_Amt) from OrderDetails); 
select distinct(SD_ID)from OrderDetails;										# DISTINCT

# GROUP BY & HAVING FUNCTION
select Order_No,Purchase_Amt,SD_ID from OrderDetails where Purchase_Amt >=2000 
having SD_ID=5001;																# HAVING
select Count(SD_ID),Purchase_Amt from OrderDetails group by CD_ID 
having Count(SD_ID) >2; 														# GROUP BY ,HAVING
Select SD_ID,Purchase_Amt from OrderDetails where Purchase_Amt > 500 
Group by SD_ID,Purchase_Amt 
having Order_Date = '2016-09-10' order by Purchase_Amt;							# GROUP BY , HAVING, ORDER BY FUNCTION
Select * from SalesmanDetails order by S_Name asc;								# ORDER BY ASC
Select * from CustomerDetails order by Customer_Name desc;						# ORDER BY DESC	
select Customer_ID,Customer_Name,count(Grade) from CustomerDetails 
where Grade=200 group by Customer_Name,Customer_ID;								# GROUP BY
select S_Name,Customer_Name,Grade,Purchase_Amt from SalesmanDetails,CustomerDetails,OrderDetails where Grade >200 
group by Customer_ID,S_Name,Customer_Name,Purchase_Amt
having Purchase_Amt > 500 order by Purchase_Amt;								# GROUP BY, HAVING, ORDER BY FUNCTION

# LOGICAL FUNCTION #
Select * from SalesmanDetails where Commission >0.13;							#  ">" GREATE THAN FUNCTION
Select S_Name,commission from SalesmanDetail
where Commission between 0.12 and 0.14; 										# BETWEEN & AND FUNCTION
select Order_No,Order_Date from OrderDetails 
where Order_Date between '2016-09-10' and '2016-09-27';							# BETWEEN & AND FUNCTION
select Customer_ID,Customer_Name,City,Grade from CustomerDetails 
where City ='New york' or not Grade > 100; 										# OR FUNCTION
select * from CustomerDetails where City in ('New York','London');				# IN 
select * from SalesmanDetails where City not in ('Berlin','Paris');				# NOT IN

# IS NULL ,LIKE , NOT LIKE & LIMIT
select * from OrderDetails limit 5;												# LIMIT
select * from OrderDetails where Purchase_Amt >500 limit 3;						# LIMIT
Select * from CustomerDetails where Customer_Name like '[b%-g%]';				# LIKE 
select S_Name,commission from SalesmanDetails 
where S_Name like "_a%" order by Commission; 									# Like & Order By 
select S_Name,commission from SalesmanDetails where S_Name like "_a%";			# Like
select Customer_Name,Grade from CustomerDetails where Customer_Name not like "_r%"; # Not Like
select * from SalesmanDetails where City is null;								# Is Null	

# ALTER FUNCTION				
Alter table SalesmanDetails add S_Age int;										# ADD
alter table SalesmanDetails drop column S_Age ;									# DROP
alter table salesmanDetails modify S_Age varchar(10);							# MODIFY
alter table OrderDetails rename column O_Date to Order_Date;					# RENAME

# UPDATE
Update SalesmanDetails set City = 'Rome' where Salesman_ID=5003; 				
update OrderDetails set SD_ID = 5005 where Order_No = 70009;					

# UNION #
select Salesman_ID from SalesmanDetails union all(select Customer_Name from CustomerDetails);

# INNER JOIN # 
select OrderDetails.Order_No,OrderDetails.Purchase_Amt,CustomerDetails.Customer_Name from OrderDetails 
inner join CustomerDetails on OrderDetails.CD_ID = CustomerDetails.Customer_ID order by Order_No;

# RIGHT JOIN #
select OrderDetails.Order_No,OrderDetails.Purchase_Amt,SalesmanDetails.S_Name from OrderDetails 
Right join SalesmanDetails on OrderDetails.SD_ID = SalesmanDetails.Salesman_ID order by Order_No;

# LEFT JOIN #
Select SalesmanDetails.Salesman_ID,SalesmanDetails.S_Name,SalesmanDetails.Commission,CustomerDetails.Customer_Name from CustomerDetails
left join SalesmanDetails on SalesmanDetails.City = CustomerDetails.City order by Commission ;

# DROP FUNCTION
drop database  Supermarket_details;
drop table SalesmanDetails;



