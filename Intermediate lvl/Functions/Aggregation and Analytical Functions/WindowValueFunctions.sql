use SalesDB

--LEAD - LAG -- 
/* Analyze the month-over-month performance by finding the percentage
   change in sales between the current and pervious month */

select *,
CurrentMonthSales - PreviousMonthSales As MOMChange ,
round(cast((CurrentMonthSales - PreviousMonthSales) as Float)/PreviousMonthSales*100,1) MOM_Per
from (
	select
		Month(OrderDate ) OrderMonth,
		sum(sales) CurrentMonthSales,
		LAG(sum(sales)) over (order by Month(OrderDate )) PreviousMonthSales
	from Sales.Orders
	Group By Month(OrderDate )
	)t




/*Analyze customer loyalty by ranking customers based on the average
number of days between orders */
select
	customerId ,
	AVG(DaysUntilNextOrder) AVGDays,
	Rank() over(order By Coalesce(AVG(DaysUntilNextOrder),99999)) RangAvg
from(
	select
		orderId,customerId,orderDate as CurrentOrder ,
		LEAD(OrderDate) over(partition by customerId order by orderDate) as NextOrder,
		DateDiff(day,orderDate,LEAD(OrderDate) over(partition by customerId order by orderDate)) DaysUntilNextOrder
	from Sales.Orders
)t
Group By customerId
-----OR-------
SELECT
    CustomerID,
    COUNT(*) over() AS TotalOrders,
    AVG(DaysBetweenOrders) AS AvgDaysBetweenOrders,
    DENSE_RANK() OVER (ORDER BY AVG(DaysBetweenOrders)) AS LoyaltyRank
FROM (
    SELECT
        CustomerID,
        OrderDate,
        DATEDIFF(
            DAY,
            LAG(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate),
			OrderDate
        ) AS DaysBetweenOrders
    FROM Sales.Orders
) t
WHERE DaysBetweenOrders IS NOT NULL
GROUP BY CustomerID





--First and Last Value--
--Find The lowest and highest sales for each product 
--First means lowest , highest means last
--Compare current sales with lowest sales
select
	orderID,ProductID,Sales,
	FIRST_VALUE(sales) over(partition by productId order by sales) LowestValue1,
	MIN(sales) over(partition by productId) LowestValue2,
	LAST_VALUE(sales) over(partition by productId order by sales
			ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestValue1,
	First_VALUE(sales) over(partition by productId order by sales DESC) HighestValue2,
	MAX(sales) over(partition by productId) HighestValue3,
	sales - 	FIRST_VALUE(sales) over(partition by productId order by sales) SalesDifference
from Sales.Orders
