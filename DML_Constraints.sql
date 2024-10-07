--I want to create two tables with a relationship
--I can accomplish this with primary keys and foreign keys
--The Foreign Key of one table points to the Primary Key of another table. This is how we establish relationships!!

--This schema will track employees and their roles

--roles table
CREATE TABLE roles(

	role_id serial PRIMARY KEY, --The primary key UNIQUELY IDENTIFIES each record in the table
	--serial is an auto-incrementing int datatype - perfect for primary keys which must be unique
	--whenever we insert a new record, the primary key will get automatically generated and incremented for us
	
	role_title TEXT UNIQUE, -- now, every role record must have a UNIQUE value for role_title
	role_salary int CHECK(role_salary > 20000) --thanks to the check constraint, salaries cannot be < 20,000

);

--employees table (has a FOREIGN KEY to the roles table!) "Every Employee has a Role"
CREATE TABLE employees(

	employee_id serial PRIMARY KEY, --remember, the PK is like a unique identifier for a record 
	first_name TEXT NOT NULL, --every employee must have a value for first name
	last_name TEXT NOT NULL,
	role_id_fk int REFERENCES roles(role_id) --This is a FOREIGN KEY. (note the "references" keyword)
	--THIS IS HOW WE ESTABLISH RELATIONSHIPS BETWEEN TABLES. Now every Employee has a Role
	--Every Employee must have a Role, but Role doesn't necessarily depend on Employee

);


--Data Manipulation Language (DML)-------------------------

--SELECT, INSERT, UPDATE, DELETE


/*INSERT some data into my tables 
 
 We specify what table and columns we're inserting data into
 We don't need to add values for any auto-incrementing fields (like serial primary keys)
 
 Each pair of parenthesis will be a different record in the table */

INSERT INTO roles(role_title, role_salary)
VALUES ('Manager', 100000), ('Cashier', 40000), ('Fry Cook', 35000), ('Marketing Director', 100000); 

--we can use SELECT to view data in the table
SELECT * FROM roles; -- * means "everything"... "select everything from the roles tables"

INSERT INTO employees(first_name, last_name, role_id_fk)
VALUES ('Spongebob', 'Squarepants', 3), ('Squidward', 'Tentacles', 2), 
('Eugene', 'Krabs', 1), ('Sheldon', 'Plankton', 4);

SELECT * FROM employees;


-----------------(Stuff we need to talk about before update/delete)


--We can use UPDATE to update records - let's say cashiers got a raise
UPDATE roles SET role_salary = 45000 WHERE role_title = 'Cashier';

SELECT * FROM roles; --NOTE: we could just run the previous select from above

--We can use DELETE to delete records - squidward is making too much money now - let's fire him
DELETE FROM employees WHERE first_name = 'Squidward';

SELECT * FROM employees;







