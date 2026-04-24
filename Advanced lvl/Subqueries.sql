use SalesDB

--SubQueries--

/*  A- Result Types:- 
       scalar Query -> return single value
       Row Query    -> retuen multi rows and single col
       Table Query  -> retuen multi  rows and multi col */

select
    avg(sales) as scalarQuery
from Sales.Orders

select
    OrderID as RowQuery
from Sales.Orders

select
    OrderID,CustomerID,OrderDate as TableQuery
from Sales.Orders


---------------------------------------------------------------------------------------------------------------------
/* B- How to use subQueries in different locations in our Query? */

-- 1- From clause : Used as temporary table for the main Query ---
--Find the products that have a price higher than the average price of all products--
select
*
from (
    select
        productId,Price,
        AVG(price) over() AVGPrice
    from Sales.Products)t
where price >AVGPrice

--Rnak customers based on their total amount of sales--

select *,
    Rank() over(order by TotalSales DESC)  CustomerRank
from (
    select 
        customerId,
        sum(Sales)  TotalSales
    from Sales.Orders
    group by customerId
)t


-- 2- Select clause ---
--Show the product IDs, names, prices and total number of orders--
select
    ProductID,product,Price,
    (select count(*) from Sales.Orders) TotalOrders
from Sales.Products


-- 3- Join SubQueries ---
--Show all customer details and find the total orders of each customer--
select 
    * 
from Sales.Customers c
Left join(
    select 
        CustomerID,count(*) TotalOrders
    from Sales.Orders
    group by CustomerID) o
ON c.CustomerID=o.CustomerID


select 
    c.*, o.TotalOrders
from Sales.Customers c
Left join(
    select 
        CustomerID,count(*) TotalOrders
    from Sales.Orders
    group by CustomerID) o
ON c.CustomerID=o.CustomerID


-- 4- WHERE SubQueries ---
--Find the products that have a price higher than the average price of all products--
select
    productID,Price ,
    (select avg(Price) from Sales.Products) AVGPrice
from Sales.Products
where price > (select avg(Price) from Sales.Products)


--Show the details of orders made by the cutomers in germany--
select
    * 
from Sales.Orders 
where CustomerID IN (select CustomerID from Sales.Customers where Country='Germany' )


--Find female emoployees whose salaries are greater than the salaries of any male employees--
select 
    *
from Sales.Employees
where Gender ='F' AND Salary <Any (select Salary from Sales.Employees where Gender='M' )


--Find female emoployees whose salaries are greater than the salaries of all male employees--
select 
    *
from Sales.Employees
where Gender ='F' AND Salary >ALL (select Salary from Sales.Employees where Gender='M' )






---------------------------------------------------------------------------------------------------------------------
-- C ====== Dependancy Type-> NoN-Correlated and Correlated Subquery ======
---------------------------------------------------------------------------
/* NoN-Correlated: Subquery run independt from main query 
   Correlated: Subquery depend on values from main query */



--Find all customer details and find the total orders for each customer--
SELECT 
    *,
    (SELECT
        COUNT(*)
     FROM Sales.Orders sub
     WHERE sub.CustomerID = main.CustomerID) TotalOrder  --Correlated
FROM Sales.Customers main


---Exists operator---
--Show the details of orders made by customers in Germany--
select 
    *
from Sales.Orders o
where exists (select
                    * 
              from Sales.Customers c
              where country='Germany' and c.CustomerID =o.CustomerID )
 