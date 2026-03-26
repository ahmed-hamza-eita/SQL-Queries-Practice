use SalesDB

-- count - sum - average - max - min --

select Country,
count(score) num_of_score,
sum(score) total_score,
avg(score) avg_score,
max(score) high_score,
min(score) low_score
from sales.Customers
group by Country 

select * from sales.Customers
 