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
-- B- Format and Casting part->

--Format--
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

----------------------------------------------------------------------------------------------------------
-- C- Calculation Part or mathematical operations on date ---

--DateAdd-> Add or subtract a specific time interval to/from date
select OrderDate,
DateAdd(YEAR,2,OrderDate) AS [Add NewYear],
DateAdd(YEAR,-2,OrderDate) AS [Sub Year]
from Sales.Orders

select OrderDate,
DateAdd(YEAR,2,OrderDate) AS [Add NewYear],
DateAdd(YEAR,-2,DateAdd(YEAR,2,OrderDate)) AS [Sub Year]
from Sales.Orders

--DateDiff-> difference between two dates
select OrderDate,ShipDate,
DATEDIFF(YEAR,OrderDate,ShipDate)
from Sales.Orders

select
EmployeeID,BirthDate,
DATEDIFF(year,BirthDate,GETDATE()) AS AGE
from Sales.Employees


--IMP--
--task-> Find the avg shipping duration in days for each month
select  MONTH(OrderDate),
AVG(DateDiff(day,OrderDate,ShipDate))as  [AVG Shipping Duration]
from Sales.Orders
group by MONTH(OrderDate)

--IMP--
--Time Gap Analysis
--Find the num of days between each order and previous order
select
OrderID,
OrderDate currentDate,
LAG(OrderDate) over (order by(OrderDate)) PreviousDate,
DATEDIFF(DAY,LAG(OrderDate) over (order by(OrderDate)),OrderDate) numOfDays
from Sales.Orders

----------------------------------------------------------------------------------------------------------

--Validation Part--
--IsDate-> check the value is a date 
-- return 1 if the value is a date

select IsDate('2025-08-12') ,Isdate('123') 
