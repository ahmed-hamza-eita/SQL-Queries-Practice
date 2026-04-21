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
