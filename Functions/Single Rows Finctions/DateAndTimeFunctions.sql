use SalesDB
-- A- Extraction Functions-> Extract part of the dates--

--Day-> returns the day from date
--Month-> returns the month from date
--year-> returns the year from date

select OrderID,
CreationTime,
YEAR(CreationTime) AS Year,
MONTH(CreationTime) AS Month,
DAY(CreationTime) AS Day
from Sales.Orders


----------------------------------------------------------------------------------------------------------

--DatePart -> Extarct a specific part of a date as a number
select OrderID,
CreationTime,
DATEPART(YEAR,CreationTime) as year_datePart,
DATEPART(MONTH,CreationTime) as month_datePart,
DATEPART(DAY,CreationTime) as day_datePart,
DATEPART(HOUR,CreationTime) as hours_datePart,
DATEPART(QUARTER,CreationTime) as quarter_datePart,
YEAR(CreationTime) AS Year,
MONTH(CreationTime) AS Month,
DAY(CreationTime) AS Day
from Sales.Orders

----------------------------------------------------------------------------------------------------------

--DateName -> Return name of specific part of date
select OrderID,
CreationTime,
DATENAME(YEAR,CreationTime) as YearName,
DATENAME(MONTH,CreationTime) as MonthName,
DATENAME(WEEKDAY,CreationTime) as WeekDay
from Sales.Orders

----------------------------------------------------------------------------------------------------------

--DateTrunk-> turncates the date to specific part (Reset a specific part of date or time)
select OrderID,
CreationTime,
DATETRUNC(HOUR,CreationTime) AS HourTrunk,
DATETRUNC(YEAR,CreationTime) AS YearTrunk
from Sales.Orders


--task-> Get total number of orders in all months
select 
DATETRUNC(MONTH,CreationTime),
count(*) as NumOfOrders
from Sales.Orders
Group by DATETRUNC(MONTH,CreationTime)

----------------------------------------------------------------------------------------------------------

--End of the month (EOMonth) -> return last day of month
select OrderID,
CreationTime,
YEAR(CreationTime) AS Year,
MONTH(CreationTime) AS Month,
DAY(CreationTime) AS Day,
EOMONTH(CreationTime) AS EndOfMonth,
cast(DATETRUNC(MONTH,CreationTime) AS Date) StartOfMonth
from Sales.Orders	

----------------------------------------------------------------------------------------------------------

--Use Cases of Extraction Functions--

--Data Aggergation--
--task-> how many orders in each month?
select 
DATENAME(MONTH,CreationTime) as MonthName,
count(*) as NumberOfOrder
from Sales.Orders
group by DATENAME(MONTH,CreationTime) 
order by DATENAME(MONTH,CreationTime) DESC

--Data Filtering--
--task-> get num of orders that were placed during the month of march?
select 
DATENAME(MONTH,CreationTime) as month_name,
count(*) as NumberOfOrder
from Sales.Orders
group by DATENAME(MONTH,CreationTime)
having DATENAME(MONTH,CreationTime) = 'march'

--task-> show all orders that were placed during the month of march?
select * from Sales.Orders
where month(CreationTime)=3 --DATENAME(MONTH,CreationTime) ='march'  -> in filter always use the intger that faster while searching
order by OrderID ASC

----------------------------------------------------------------------------------------------------------
-- B- Format->

select OrderID, CreationTime,
format(CreationTime,'dd MMM yyyy')
from Sales.Orders

/*task-> show creationTime such as following format:
         Day wed Jan Q1 2025 12:55:33 PM
*/
select CreationTime,
'Day ' + format(CreationTime,'ddd MMM') +
' Q'+DATENAME(QUARTER,CreationTime) +
FORMAT(CreationTime,' yyyy hh:mm:ss tt')
from Sales.Orders

--Formatting use case-> data aggregation--
select FORMAT(OrderDate, 'MMM yyy'),
count(*)
from Sales.Orders
group by FORMAT(OrderDate,'MMM yyy')

--Convert -> convert data type of data
select CreationTime,
convert(date,CreationTime,34) AS [DateTime to Date]
from Sales.Orders

--C- Cast-> convert data type of data
select CreationTime,
cast(CreationTime as date) AS [DateTime to Date]
from Sales.Orders


/* Difference between convert and cast ?
cast-> ANSI standard and not allow style (date formatting)
convert-> allow style
*/