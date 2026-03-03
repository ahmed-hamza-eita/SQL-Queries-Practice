  use MyDatabase
 
 --write the cols of customer table is optional (id,first_name,country,score)
INSERT INTO customers  
VALUES (6,'Ahmed','EGY',null),
	   (7,'ALI','EGY',0)

select * from customers

--write the cols of customer table is not optional
--if we need fill some cols not all cols
INSERT INTO customers (id,first_name)   
VALUES (8,'Ahmed')

INSERT INTO customers (id,first_name,country) 
VALUES (10 ,'SARA','EGY')



--IMP--
--copy data from table to another table this way called (Insert using select)
--Task -> Copy data from customer table into persons table
/*
first look on target table (persons) it takes id,name,birth,phone
start write query from source table (customer) slect from it 
notes null=country and unknown=score these will put in birth and phone 
*/
INSERT INTO persons (id,person_name,birth_date,phone)
SELECT id ,first_name,NULL,'UNKNOWN'
FROM customers
 
select * from customers

--update -> "change content of existing raws"
--task 1-> change the score of customer 6 to 0
UPDATE customers
SET score =0
WHERE id=6 --without where all rows will updated

--task 2-> change the score of customer with id =10 to 0 and update the countery to UK
select * from customers
UPDATE customers
	SET score=0 ,
	country = 'UK'
WHERE id=10

--task 3-> update all customer with null score to 0 score
UPDATE customers
SET score=0
WHERE score is NULL
--
SELECT *FROM customers

UPDATE customers
SET country = 'UNKNOWN'
WHERE country is NULL

--Delete -> "Remove raws from our table"
--task 1-> remove all customers that IDs greater than 5
DELETE FROM customers --to here delete all raws of customer
WHERE id>5

--task 2-> delete all data from person table (these are true but truncate is faster)
SELECT * FROM persons
DELETE FROM persons
TRUNCATE TABLE persons
	   