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