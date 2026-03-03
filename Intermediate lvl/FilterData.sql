USE MyDatabase
-- Comparsion Operators (=, != ,>,>=, <,<=) --

--equal (=)
--Retrieve all customers from germany  
SELECT * FROM customers 
WHERE country = 'germany'

-- not equal (!= or <>)
--Retrieve all customers  who are not from germany  
SELECT * FROM customers
WHERE country <> 'germany'

--greater than (>)
--Retrieve all customer with a score greater than 500
SELECT * FROM customers
WHERE score >500

--greater than or equal (>=)
--Retrieve all customer with a score of 500 or more
SELECT * FROM customers
WHERE score >=500

------------------------------------------------------------------------------------

-- Logical operators (AND - OR - NOT) --

-- AND -> All conditions must be true
/* REtrieve all customers who are from USA
    and have score greater than 500 */
SELECT * FROM customers
WHERE country = 'USA' AND score >500

-- OR ->At least one condition must be true
/* REtrieve all customers who are from USA
    or have score greater than 500 */
SELECT * FROM customers
WHERE country = 'USA' OR score >500

--NOT -> reverse, Exclude matching values
/* Retrieve all customers with a score not less than 500 */
SELECT * FROM customers
WHERE NOT score <500  --or write as score>=500 without not

------------------------------------------------------------------------------------

-- Range Operators (Between) --
--Between -> check if a value in specific range
/*Retrieve all customer whose score falls
  in the range between 100 and 500 */
SELECT * FROM customers
WHERE score BETWEEN 100 AND 500 /* or write using comparsion such
                                   WHERE score >=100 AND score <=500
                                   Tip -> the comparsion is best way 
                                   bescause the explicit comparison clearly show
                                   that both boundaries are included */
                                   
                                   
------------------------------------------------------------------------------------
-- Membership Operators (IN - NOT IN) --
-- IN -> check a value in specific range
/*REtrieve all customer from either germany or USA */
SELECT * FROM customers
WHERE country IN ('germany' , 'USA'); --write in other way-> country='germany OR country='USA

------------------------------------------------------------------------------------
-- Search Operator (LIKE) --
--Like -> search for a specific pattern in txt
/*Retrieve all customers whose first name start with "M" */
SELECT * FROM customers
WHERE first_name LIKE 'M%'

/*Retrieve all customers whose first name end with "n" */
SELECT * FROM customers
WHERE first_name LIKE '%n'


/*(IMP) Retrieve all customers whose first name contains "r" */
SELECT * FROM customers
WHERE first_name LIKE '%r%'

/*(IMP) Retrieve all customers whose first name has
  "r" in the 3rd position */
SELECT * FROM customers
WHERE first_name LIKE '__r%'

