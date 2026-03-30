use SalesDB

--Count--

/* Find total num of orders 
	Find total numbers of orders for each customers
	provide details such order id and order data. */

select OrderID,OrderDate,customerId,productId,
count(*) over() total_order,
count(*) over(partition by productId order by productId DESC) total_order_by_product,
count(*) over(partition by CustomerId) total_order_by_customer
from Sales.Orders


/*find total number of customers and provide all details.
  And find total number of scores for the customers. */
select *,
count(*) over() total_num_customer,
count(score) over() total_score
from Sales.Customers


--Count can be used to identify duplicates 
--Check weather the tables 'order' and 'OrdersArchive' contains any duplicates value
-- show only duplicates 
select 
	orderId,
	count(*) over(partition by orderId) checkPK
from Sales.Orders


select 
	orderId,
	count(*) over(partition by orderId) checkPK
from Sales.OrdersArchive


select * 
from (
	select orderId,
	count(*) over(partition by orderId) checkPK
	from Sales.OrdersArchive
)t
where checkPK>1

------------------------------------------------------------------------------------------------
--Sum--
select
	orderID,orderDate,productId,Sales,
	sum(sales) over()  total_sales,
	sum(sales) over(partition by productId) total_sales_by_product
from Sales.Orders


--Find the percentage contribution of each prduct's sales to the total sales.
Select 
	OrderID,ProductID,Sales,
	sum(sales) over() total_sales,
	round((cast(sales as float) / sum(sales) over()) * 100,2)  percentage_of_total_sales
from Sales.Orders

------------------------------------------------------------------------------------------------
--Average--

/* Find the avg sales across all orders
   and the avg of sales of each product
   provide details such as order id and order daete */

   select
	   OrderID,OrderDate,ProductID,sales,
	   avg(coalesce(sales,0)) over () AVG_sales,
	   avg(coalesce(sales,0)) over (partition by productId) AVG_sales_by_product
   from Sales.Orders

--Find the avg of scores of customers and provide details of customers.
select
	CustomerID,LastName,score,
	coalesce(score,0) handle_null,
	avg(coalesce(score,0)) over () AVG_Score
from Sales.Customers


--Find all orders where sales are higher than the avg sales across all orders
select * from (
	select
		OrderID,Sales,
		avg(sales) over() AVG_Sales
	from Sales.Orders
)t
where sales >AVG_Sales


------------------------------------------------------------------------------------------------
--Min - Max--

--Find the lowest and highest sales for all orders and each product.
select 
	OrderID,OrderDate,Sales,productId,
	max(sales) over() high_sales,
	min(sales) over() lowest_sales,
	max(sales) over(partition by productId) high_sale_by_product,
	min(sales) over(partition by productId) lowest_sale_by_product
from Sales.Orders

--Show employee who have highest salaries.

select * from (
	select
	*,
	max(Salary) over() high_salary
	from Sales.Employees 
)t
where Salary=high_salary


--Calc the deviation of each sales from the min and max sales amount
select
	OrderID,OrderDate,Sales,productId,
	max(sales) over() high_sales,
	min(sales) over() lowest_sales,
	sales - min(sales) over() deviation_from_min,
	max(sales) over() - sales deviation_from_max
from Sales.Orders

------------------------------------------------------------------------------------------------