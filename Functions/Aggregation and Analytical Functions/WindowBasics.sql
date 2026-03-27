use SalesDB


--Partition By--

--find the total sales for each product and show details such order id and order date.
select
	OrderID,OrderDate,ProductID,
	sum(Sales) over(partition by ProductID) as total_sales
from Sales.Orders




--find the total sales for all product and show details such order id and order date.
select
	OrderID,OrderDate,ProductID,
	sum(Sales) over() as total_sales
from Sales.Orders





/* find the total sales for all orders 
   find the total sales for each product
   find total sales for each product and orders status
   and show details such order id and order date. */
   select OrderID,OrderDate,ProductID,Sales,OrderStatus,
   sum(sales) over() as total_sales_for_allOrders,
   sum(sales) over(partition by productID) total_sales_for_eachProduct,
   sum(sales) over(partition by productID,orderStatus) total_sales_byOrderStatus
   from Sales.Orders

----------------------------------------------------------------------------------------------------------
 
 --Order By--


 /* Rank each order based on sales from highest to lowest 
	and show details such order id and order date. */
select OrderID,OrderDate,sales,
rank() over(order by sales DESC) RankSales
from Sales.Orders

----------------------------------------------------------------------------------------------------------

--Frame--

-- rank customer based on their total sales
select CustomerID,
sum(Sales) total_sales,
rank() over(order by sum(Sales) DESC ) rank_customer
from Sales.Orders
Group by CustomerID
