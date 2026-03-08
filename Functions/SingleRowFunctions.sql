/* String Functions ->Manipulation - Calculation - string extraction */

use MyDatabase

----------------------------------------------------------------------------
--A: Manipulation--
----------------------------------------------------------------------------
--Concat-> combine multi string into one--
-- task-> combine first name and country into one column --

SELECT  CONCAT(first_name,' ',country) AS NameCountry FROM customers 

-- UPPER - LOWER --
SELECT  CONCAT(first_name,' ',country) AS NameCountry,
LOWER(first_name)  ,UPPER(country)
FROM customers 

--TRIM -> Remove spaces 
-- Find customers whose first name contains lrading or trailing spaces then remove it.
SELECT TRIM(first_name) ,
LEN(first_name) len_name,
LEN(TRIM(first_name)) len_trim_name,
LEN(first_name) - LEN(TRIM(first_name)) flag
FROM customers
WHERE LEN(first_name) <> LEN(TRIM(first_name))


--REPLACE ->replcae specific char with a new char
select replace(first_name,' ','') from customers

select 'report.txt' as oldFile,
replace('report.txt','.txt','.csv') as NewFile

--LEFT ->extract specific num of char from START of string value
--RIGHT ->extract specific num of char from END of string value

select left(first_name,3) from customers as first_3_char
select right(first_name,3) from customers as last_3_char


--SubString ->Extract a part of string at a specific position --
--Retrieve a list of customer's first name after removing the first char--
SELECT first_name,
substring(first_name,2,len(first_name)) as sub_name
from customers
