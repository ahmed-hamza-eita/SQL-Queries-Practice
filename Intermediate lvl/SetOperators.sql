use SalesDB


SELECT * from Sales.Employees
SELECT * from Sales.Customers


-- UNION ->Return all rows without duplicate, each rows appear once
--Task-> combine data from employee and customer in one table
SELECT c.FirstName,c.LastName FROM Sales.Customers AS c
UNION 
SELECT e.FirstName, e.LastName FROM Sales.Employees AS e


-- UNION ALL ->Return all rows including duplicates
--Task-> combine data from employee and customer in one table including duplicates.
SELECT c.FirstName,c.LastName FROM Sales.Customers AS c
UNION ALL 
SELECT e.FirstName, e.LastName FROM Sales.Employees AS e
/* Except -> Return the distinct rows from first query
			 that are not found in secondary query
			 order is important
			 called minus*/
/* task-> find the employees who are not cutomers at the same time */
SELECT e.FirstName, e.LastName FROM Sales.Employees AS e
EXCEPT
SELECT c.FirstName,c.LastName FROM Sales.Customers AS c


--Intersect-> REturn only common rows in both queries
--task-> Find employee who are also customers.
SELECT e.FirstName, e.LastName FROM Sales.Employees AS e
INTERSECT
SELECT c.FirstName,c.LastName FROM Sales.Customers AS c

 --task -> combine all orders in one report without duplicates and order the result
 SELECT 'Order' AS SourceTable, * FROM Sales.Orders as o
 UNION
 SELECT 'OrdersArchive' AS SourceTable, * FROM Sales.OrdersArchive as oa
 ORDER BY o.OrderID