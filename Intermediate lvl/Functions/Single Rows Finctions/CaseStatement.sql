use SalesDB

--Case Statement--
--Evaluates a list of conditions an return a value when the first condition is met



--use case -> 1- categorizing data
/* task  -> create report show toatal sales for each of following catergories:-
high (sales over 50),medium(sales 21-50), and low(sales 20 or less)
sort categories feom highest to low */


select
OrderID, Sales ,
CASE 
	WHEN Sales > 50 THEN 'High'
	WHEN Sales <= 50  AND Sales >= 21 THEN 'Medium'
	WHEN Sales <= 20 THEN 'Low'
	ELSE 'n/a'
END Category
from Sales.Orders
order by Sales DESC

-- Group Categories--

select
Category,
sum(Sales) as total_sales
from (
select OrderID, Sales,
CASE 
	WHEN Sales > 50 THEN 'High'
	WHEN Sales <= 50  AND Sales >= 21 THEN 'Medium'
	WHEN Sales <= 20 THEN 'Low'
	ELSE 'n/a'
END Category
from Sales.Orders
)t 
group by Category
order by total_sales DESC


--use case -> 2- Mapping Values
/* task -> retrive employees details with gender displayed as fulltext */
select EmployeeID,
FirstName,
Gender,
case
	when Gender ='M' then 'Male'
	when Gender ='F' then 'Female'
	else 'n/a'
end [Gender Full Text]
from Sales.Employees




select  Distinct Country from Sales.Customers; --to show all countries without repitation

select  CustomerID,
FirstName,
Country,
case Country
	when 'Germany' then 'DE'
	when 'USA'     then 'US'
else 'n/a'
end [Country Code]
from Sales.Customers ;

--use case -> 3- Handle Nulls
/* task-> find avg scores of customers and treat nulls as 0 */

select
customerId,
FirstName + ' '+LastName as [Full Name],
score,

case
	when score is null then 0
	else score                  --must handle this
end [clean score],

AVG(score) over() [avgCustomer_with_null],

AVG(
	case
		when score is null then 0
	    else score 
	end) over() AVGCustomerClean 
from Sales.Customers ;



--use case -> 4- Conditional Aggregation
/* task-> count how many times each customer has made an order with sales greater than 30 */
select CustomerID,
count(*) TotalOrders,
sum(case 
	when sales >30 then 1
	else 0
end) TotalOrderHighSales
from Sales.Orders
group by CustomerID


