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


--the WHERE clause----------------------------------------

--In a SELECT, the WHERE clause helps us filter results

--SELECT all roles where the salary is equals to 100,000 (=)
SELECT * FROM roles WHERE role_salary = 100000;

--SELECT all roles where the salary is less than 100,000 (<)
SELECT * FROM roles WHERE role_salary < 100000;
--This is a SUBQUERY - "Select all roles where the salary is less than the manager's salary)
SELECT * FROM roles WHERE role_salary < (SELECT role_salary FROM roles WHERE role_title = 'Manager')

--all roles with a salary between 40,000 and 90,000 (BETWEEN & AND)
SELECT * FROM roles WHERE role_salary BETWEEN 40000 AND 90000 

--all employees with names starting with 'S' (LIKE & %)
SELECT * FROM employees WHERE first_name LIKE 'S%'

--The % can be used anywhere to denote values that don't matter
--all employees with an 'e' in their first name
SELECT * FROM employees WHERE first_name LIKE '%e%'

--Employees named Eugene or Sheldon (OR)
SELECT * FROM employees WHERE first_name = 'Eugene' OR first_name = 'Sheldon'

--Same thing as above, but using the IN operator instead (which could be shorter, depending on # of checks)
--In checks for records with columns that have a match IN the values in parenthesis
SELECT * FROM employee WHERE first_name IN ('Eugene', 'Sheldon')





--We can use UPDATE to update records - let's say cashiers got a raise
UPDATE roles SET role_salary = 45000 WHERE role_title = 'Cashier';

SELECT * FROM roles; --NOTE: we could just run the previous select from above

--We can use DELETE to delete records - squidward is making too much money now - let's fire him
DELETE FROM employees WHERE first_name = 'Squidward';

SELECT * FROM employees;







