USE MyDatabase

--Retrieve All col 
select *
from customers

--Retrieve specific col 
select first_name,country,score
from customers

--Where
select *
from customers where score>500

select *
from customers where country='Germany'

--Order By  (default ASC->Low to High ,  DESC->High to Low)
select *
from customers order by score DESC

--nested sort
select *
from customers 
order by country ASC , score DESC


--Group By
--find total score for each country
select country  ,sum(score) as total_score
from customers
Group By country

--find total score and total number of customer for each country
select country,
       count(id) as total_customer,
       sum(score) as total_score
from customers
Group By country


--Having (used only with Group by)
select country, sum(score) as total_score
from customers
Group By country
Having sum(score)>800

--Having and where
select country, sum(score) as total_score
from customers
where score>500 --filter before aggregation
Group By country
Having sum(score)>800 --filter after aggregation

/* task ->Fing the avg score for each country 
considering only customers with a score not equal to 0
and return only those countries with an avg score greater than 430
*/
select country,AVG(score) as avg_score
from customers
where score !=0
Group by country
Having AVG(score)>430

--Distinct (Remove DuPlicate)
select distinct country
from customers

--Top (Restrict num of row returned)
select  top 3 *
from customers

--Retrive top 3 customers with the hight scores
select top 3 *
from customers
order by score DESC;

--Retrive lowest 2 customers based on  scores
select top 2 *
from customers
order by score ASC ;

--Get two most recent orders  (TASK)  most recent == high to low
select top 2 *
from orders
order by order_date DESC ;   -- ; in the end of block of query to separate queries


--static values 
select
     id,
     first_name,
     'new customer' as customer_type --thses added in queries only 
from customers;