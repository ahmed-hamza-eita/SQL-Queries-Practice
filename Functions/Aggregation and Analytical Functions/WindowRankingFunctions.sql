use SalesDB

/*Row Number: Assign unique num for each row 
			  It doesn't handle ties That means if two rows sharing	the same value , will not share same rank
			  No gaps
			  */


/*Rank: Assign a rank to each row
		It handle ties That means if two rows sharing the same value , will share same rank
		It leaves gaps */


 	 
/*Dense Rank-> Assign a rank to each row with in a window, but does not leave gaps in the ranking,	
			   It handle ties */


--Task->Rank the orders based on sales from highest to lowest 
select 
	OrderID,Sales,productId,
	row_number() over(order by sales desc) SalesRank_Row,
	rank() over(order by sales desc) SalesRank_Rank,
	dense_rank() over(order by sales desc) SalesRank_DenseRank
from Sales.Orders

--Use Cases--

--TOP-N Analysis--
--Find The top highest sales for (each) product--
select * from(
	select
		OrderID,Sales,productId,
		row_number() over(partition by productId order by sales desc) RankByProduct 
	from Sales.Orders)t
where RankByProduct =1

--Bottom-N Analysis--
--Find The lowest 2 customers based on their total sales--
select * from (select
    CustomerID, 
	sum(sales) total_sales,
	row_number() over(order by sum(sales)) ranking_customer
from Sales.Orders
group by CustomerID
)t
where ranking_customer <= 2

--Generate Unique IDs--
--Assign unique ids to the rows of 'Order Archive' table.
select 
	ROW_NUMBER() over(order by orderID) uniqueID,*
from Sales.OrdersArchive


--Identify Duplicates--
--Identify duplicates row of 'Order Archive' table and return a clean result without any Duplicates
select * from (
	select 
		ROW_NUMBER() over(partition by orderId order by CreationTime Desc) flag,
		*
	from Sales.OrdersArchive)t
where flag=1
