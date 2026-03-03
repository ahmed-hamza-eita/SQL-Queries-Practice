CREATE TABLE persons(
id INT NOT NULL,
person_name VARCHAR(50) NOT NULL,
birth_date DATE,
phone VARCHAR(15) NOT NULL,
CONSTRAINT pk_persons PRIMARY KEY (id)
)

select * from persons

--Add a new col aclled email to persons table
ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL

--Remove the phone col from person table
ALTER TABLE persons
DROP COLUMN phone

--Remove preson table
DROP TABLE persons