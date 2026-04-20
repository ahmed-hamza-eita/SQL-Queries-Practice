use SalesDB

--Null Functions--

/* Null means unknown , not equal anything
IsNull or coalesce-> replace a null with value
NullIF-> replace a value with null value
Is Null-> check for nulls
   */

--IsNull & Coalesce--

--replace null value with zero before doing aggergation and mathematical operations--

--Find the avg score of the customers
 select CustomerID,
 AVG(Score) over () AVGScore,
 AVG(Coalesce(score,0)) over () AVGScore  
 from Sales.Customers

 --Display full name of customers in a single field and add 10 bouns to each customer score
select 
coalesce(FirstName,' ')+coalesce(LastName,' ')  as [Full Name],
Score ,
coalesce(Score,0)+10 AS ScoreWithBouns 
from Sales.Customers 

--show all customers score from lowest to highest with nulls apppear last
select CustomerID,
Score,
case when Score is null then 1 else 0 end AS Flag
from Sales.Customers 
order by case when Score is null then 1 else 0 end ,Score -- if we put score then case statement -> will order null first


--NullIF -> nullIf(A,B) -> if A = B return null else return A
--preventing the error of division by zero

--find the sales price for each order by dividing sales by quantity.
select OrderID,Sales,Quantity,
Sales / NULLIF(Quantity,0) AS [Sales Price] 
from sales.Orders

--identify the customers who have no score
select  *
from Sales.Customers
where score is null

--identify the customers who have  score
select  *
from Sales.Customers
where score is not null


--ISNULL & JOINS --
--left Anti Join = Left Join + ISNULL
--Right Anti Join = Right Join + ISNULL

--List all details for customers who have not placed any orders
select * from Sales.Customers
select * from Sales.Orders

select 
c.* , o.OrderID
from Sales.Customers as c
left join Sales.Orders as o
on c.CustomerID= o.CustomerID
where o.CustomerID IS NULL


--Null - empty string - blank spaces --

with Orders As (
select 1 Id, 'A' Category Union
select 2, null Union
select 3, '' union
select 4, '  ' 
)
select 
*,
DATALENGTH(Category) as category_length,
DATALENGTH(TRIM(Category)) as policy_1, --convert blank spaces to empty string
nullIf(TRIM(Category),'') as policy_2, -- convert empty string to null  
coalesce(nullIf(trim(Category),''),'unknown') as policy3
from Orders


