use SalesDB
--Extraction Functions-> Extract part of the dates--

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


--task-> Get total orders in all months
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
cast (DATETRUNC(MONTH,CreationTime) AS Date) StartOfMonth
from Sales.Orders	
