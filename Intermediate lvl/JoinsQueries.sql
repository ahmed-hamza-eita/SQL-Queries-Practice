USE MyDatabase
-- Joins Types --
-- we use (On) for conditions
--(in joins must define the matching cols in both table)

---------------------------------------------------------------------------------------------
--Basic joins (inner,left,right,full)--
---------------------------------------------------------------------------------------------

--No join--
/* Retrieve all data from customer and order as a separate result */
SELECT * FROM customers
SELECT * FROM orders

---------------------------------------------------------------------------------------------

/*INNER Join ->Return only matching raws from both tables
               Orders tables doesn't matter*/
/*Task-> Get All customers along with their order
but only for customers who have placed an order*/
SELECT * FROM customers as c
INNER JOIN orders as o
ON c.id = o.customer_id


---------------------------------------------------------------------------------------------

/*Left Join ->Return all the rows from left
  and only matching the right table
  Oerder here is important */
/*Task-< Get All customers along with their order
  including those without order*/
 SELECT * FROM customers as c
 LEFT JOIN orders as o
 ON c.id = o.customer_id

 ---------------------------------------------------------------------------------------------
 /*Right Join ->Return all the rows from right
  and only matching the left table
  Oerder here is important */
/*Task-< Get All customers(A) along with their order(B)
  including those without customer (NO A so need B which right)*/
 SELECT * FROM customers as c
 RIGHT JOIN orders as o
 ON c.id = o.customer_id

---------------------------------------------------------------------------------------------

/*Full Join ->Return all  rows from both tables
  Oerder here doesn't matter */
/*task->Get all customers and oreders data
        even if there is no match*/
SELECT * FROM customers as c
FULL JOIN orders as o
ON c.id = o.customer_id


---------------------------------------------------------------------------------------------
--Advanced joins (left anti, right anti, full anti, cross--
---------------------------------------------------------------------------------------------


/*Lfet Anti Join-> Return the rows from left that unmatching in right
                   return only unmatching rows
                   order is important */
/* task-> get all customers that not placed in any order */
SELECT * FROM customers as c
LEFT JOIN orders as o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL

---------------------------------------------------------------------------------------------

/*Right Anti Join-> Return the rows from right that unmatching in right
                   return only unmatching rows
                   order is important */
/* task-> get all orders without matching customers */
--solve with left anti join
SELECT * FROM orders as o
LEFT JOIN customers as c
ON o.customer_id = c.id
WHERE c.id IS NULL

--solve with right anti join
SELECT * FROM customers as c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL

--left such right with replace the order of table--

---------------------------------------------------------------------------------------------

/*Full Anti Join-> Return the only rows that don't match in either tables              
                   order doesn't matter */
/* task-> Find customers without order 
          and orders without customers */
SELECT * FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL

/*Task-> Get All customers along with their order
but only for customers who have placed an order  (without using inner join) */
--Using Full join
SELECT * FROM customers as c
FULL JOIN orders as o
ON c.id = o.customer_id
WHERE c.id IS NOT NULL AND o.customer_id IS NOT NULL

--Using Left join
SELECT * FROM customers as c
LEFT JOIN orders as o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL


---------------------------------------------------------------------------------------------

/*Cross Join-> Combine all rows from left with all rows from right
               Cartesian join
               order doesn't matter
               No need conditions */
/* task-> Generate all possible combinations of customers and order */
SELECT * FROM customers
CROSS JOIN orders

---------------------------------------------------------------------------------------------

--How to join multi tables--
/* task ->Using salesDB, Retrieve a list of all orders, along with
          the related customer, product and employee details
          display: orderID, customer's name, product name, price, sales person's name */
USE SalesDB

SELECT
o.OrderID,
o.Sales,
c.FirstName AS CustomerFirstName,
c.LastName AS CustomerLastName,
p.Product AS ProductName,
p.Price,
e.FirstName AS EmployeeFirstName,
e.LastName AS EmployeeLastName
FROM Sales.Orders AS  o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID


