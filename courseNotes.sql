-- To create, use and drop dabatases
SHOW DATABASES;
USE database_name;
DROP DATABASE database_name;

-- To create, drop, use and show tables
SHOW TABLES;
DESC table_name;
DROP TABLE table_name;
CREATE TABLE table_name (column data_type, ...);

-- How to insert and retrieve data from tables
INSERT INTO table_name (column, ...) VALUES (value, ...); ... VALUES (value), (value), ...;
SELECT * FROM table_name;

-- What is null in SQL? It means no value or the value being unknown
CREATE TABLE cats (column data_type NOT NULL);

-- Default values
CREATE TABLE cats4 (name VARCHAR(100), NOT NULL DEFAULT 'unnamed', age INT NOT NULL DEFAULT 99);

-- Primary Keys and Auto Increment (not null with pkeys is redundant) / AUTO_INCREMENT auto increments ids
CREATE TABLE unique_cats (cat_id INT NOT NULL PRIMARY KEY, name VARCHAR(100), age INT); ... (... PRIMARY KEY(cat_id));
CREATE TABLE unique_cats (cat_id INT AUTO_INCREMENT, name VARCHAR(100), age INT, PRIMARY KEY(cat_id));

-- CRUD Basics
  -- Creating
  INSERT INTO table_name (row, row) VALUES (val, val);
  -- Reading, WHERE clause and Aliases
  SELECT rowName, rowName / * (everything) from tableName;
  SELECT name, age FROM cats WHERE age = 5;
  SELECT cat_id AS id, name AS kitty_name, breed AS something FROM cats;
  -- Updating
  UPDATE tableName SET row = 'newValue' WHERE row = 'oldValue';
  -- Deleting
  DELETE FROM tableName WHERE row = 'value';

-- String functions
source file.sql -- Executes the sql script
SELECT database(); -- Shows what database I'm using
SELECT CONCAT ('x','y','z') FROM tableName; -- Concatenates one or more stuff
SELECT CONCAT_WS(' ', 'x', 'y', 'z') FROM tableName; -- Concatenates with a separator between items
SELECT SUBSTRING/SUBSTR('the string', startPosition, end) from tableName; -- Gets a piece of the string from the start pos to the end pos
SELECT REPLACE('string', 'what to replace', 'what to replace with') FROM tableName; -- Replaces a piece of the string with something else
SELECT REVERSE('string'); -- Reverses a string
SELECT CHAR_LENGTH('Hello!'); -- Gets the number os characters on the string
SELECT LENGTH('Hello!'); -- Gets the size of the characters in bytes
SELECT UCASE/UPPER('string'); -- Returns the string in uppercase
SELECT LCASE/LOWER('string'); -- Returns the string in lowercase
SELECT INSERT('string', begin, quantityToReplace, 'whatToReplaceWith'); -- Replaces a piece of the string
SELECT LEFT/RIGHT('string', numberOfChars); -- Returns the leftmost and rightmost chars of a string
SELECT REPEAT('string', amountOfTimes); -- Repeats a string n times

-- Refining Selections
SELECT DISTINCT row FROM tableName; -- Returns only the unique values from the query
SELECT row1, row2 FROM tableName ORDER BY row2; -- Orders the results based on the argument. 
 -- It orders in ascending order by default and to change it, I need to add DESC after the order by: SELECT row1, row2 FROM tableName ORDER BY row2 DESC;
 -- I can also use a shorter syntax for it: ORDER BY number. It will order by the number of the column passed.
 -- Finally, I can sort by multiple columns: ORDER BY col1, col2, col3; Also, I can ascend or descend each order filter: ORDER BY col1 DESC, col2 ASC;
 -- I can also order by columns that doesn't exist:
 SELECT CONCAT(author_fname, ' ', author_lname) AS author FROM books ORDER BY author;
 -- Here I am ordering by the alias

SELECT row FROM tableName LIMIT X; -- Limits the amount of results
SELECT row FROM tableName LIMIT X, Y; -- With this I can get just a piece of the results, from the first to the second

SELECT row FROM tableName WHERE row LIKE 'string'/'%string%'; -- This allows me to search for a specific pattern in a column. The % is a wild card that means any number of chars and used like that means any number of chars before and after the string
SELECT row FROM tableName WHERE row LIKE '____'; -- This is another wild card. Each one of these "_" means a single character

-- I can escape wild cards with back slash
SELECT title WHERE title LIKE '%\_%';

-- Aggregate functions
SELECT COUNT(*) FROM book; -- Select the number of rows from books
SELECT row1 FROM tableName GROUP BY row1; -- This summarizes or aggregates identical data into single rows
-- WHAT HAPPENS IS that in memory SQL will group everything on that row based on the one used for GROUP BY. With this I can query things based on these groups created.
SELECT author_lname FROM books GROUP BY author_lname; -- This will create individual groups of books based on their author
SELECT author_lname AS Author, COUNT(*) AS 'Books Written' FROM books GROUP BY author_lname; -- Then, by leveraging the grouped response, I can count the amount of books that each author has written
SELECT author_lname AS Author, COUNT(*) AS books_written FROM books GROUP BY author_lname ORDER BY books_written DESC;
-- So, I should group by some column and maybe have it in the select then have an aggregate function in the same query
SELECT MIN(row)/MAX(row) FROM tableName; -- Get the minimum and maximum value of a query
SELECT CONCAT(author_fname, ' ', author_lname) AS author, COUNT(*) FROM books GROUP BY author; -- I can group by multiple rows, including ones created in the query itself
SELECT CONCAT_WS(' ', author_lname, author_fname) AS author,
  COUNT(*) AS books_written,
  MIN(released_year) AS earliest_release,
  MAX(released_year) AS latest_release,
  MAX(pages) AS page_count
FROM books GROUP BY author; -- I can do the same with MIN/MAX functions by leveraging a group made with some other row
SELECT SUM(row) FROM tableName; -- I can sum anything with this
SELECT AVG(row) FROM tableName; -- I can get the average from a collection of data with this

-- More on data types
 -- Varchar stores text of different sizes in the best possible way. It's used for variating lengths of strings
 -- Char has a fixed length and every new string is optimized to always store that amount
 CREATE TABLE states (abbr CHAR(2));
 -- Also, if whatever I put inside this row doesn't reach the specified char amount, MySQL will automatically pad the string to the amount
 -- So CHAR() is good when I want a fixed length string
 INTEGER / INT / SMALLINT / TINYINT / MEDIUMINT / BIGINT -- What varies is the maximum integer value I can store in each one
 -- Also, I can use UNSIGNED and SIGNED with them to tell sql to only work with positive numbers and negative numbers respectively
 CREATE TABLE parent (ID INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT);
 DECIMAL(5, 2); -- With this I can use decimal values. The first number is the total amount of digits and the second is the digits AFTER the decimal
  -- For example, this would allow the number: 999.99
  INSERT INTO products (price) VALUES (8347.1); -- This doesn't work
  INSERT INTO products (price) VALUES (5.026); -- This works and will round/truncate the value after the dot
FLOAT / DOUBLE -- Used for very large numbers, take less space in memory but have precision issues. Also, float takes less space but have precision issues with around 7 digits, double takes the double space and have issues around 15 digits
DATE('YYYY-MM-DD') -- Is used for dates but not for time
TIME('HH:MM:SS') -- Represents time but not dates
DATETIME('YYYY-MM-DD HH:MM:SS') -- Is used for both!
SELECT CURTIME()/CURRENT_TIME(); -- Returns the current time
SELECT CURDATE()/CURRENT_DATE(); -- Returns the current date
SELECT NOW()/CURRENT_TIMESTAMP(); -- Returns the current date and time
SELECT DAY(row) FROM tableName; -- Extracts the day from a valid DATE data type
SELECT DAYOFWEEK(row) FROM tableName; -- Extracts the day of the week from a valid DATE. 1 is sunday and 7 is saturday
SELECT DAYOFYEAR(row) FROM tableName; -- Extracts the day of the year from a valid DATE
SELECT DAYOFMONTH() FROM tableName; -- Extracts the day of the month from a valid DATE
SELECT HOUR()/MINUTE()/SECOND() FROM tableName; -- Extract the hours, minutes and seconds from a valid DATE
SELECT TIME() FROM tableName; -- Extracts the entire time from a valid DATE
SELECT DATE_FORMAT(input, format)/ TIME_FORMAT(input, format) FROM tableName; -- Extracts the date and time respectively in the format used
SELECT DATEDIFF(date1, date2); -- Gives the difference in days between the two dates
SELECT DATE_ADD(date1, INTERVAL X YEAR/MONTH/DAY); -- With this I can add something to a date
SELECT DATE_SUB(date1, INTERVAL X YEAR/MONTH/DAY); -- With this I can subtract from a date
TIMEDIFF() / ADDTIME() / SUBTIME() -- The same but for time
SELECT date - / + date2; -- To subtract and sum dates
TIMESTAMP(); -- Works just like the datetime() format but with less range, 1970 ish to 2038.
CREATE TABLE tableName (name type TIMESTAMP DEFAULT CURRENT_TIMESTAMP); -- With this I tell mysql that the default value on create will be the exact current time and date
CREATE TABLE tableName (name type TIMESTAMP ON UPDATE CURRENT_TIMESTAMP); -- With this I tell mysql that whenever ANY row on the table is updated, this will also get update with exact current time and date

-- Comparison and logical operators
SELECT title FROM books WHERE year != 2017; -- This will select any books that have a released year not equal to 2017
SELECT title FROM books WHERE title NOT LIKE '% %'; -- This will select all books that are not like the pattern passed. In this case, that do not contain spaces
SELECT title, author_lname FROM books WHERE released_year > 2000; -- This will get all books released after the year 2000
SELECT title, pages FROM books WHERE pages < 200; -- This will get all books with pages under 200
SELECT * FROM books WHERE released_year >= 2010; -- Gets all books released after 2010, including the ones released in 2010
SELECT * FROM books WHERE released_year <= 2000; -- Gets all books released before the year 2000, including the ones released in 2000
SELECT * FROM books WHERE author_lname = 'Eggers' AND released_year > 2010; -- SQL's && operator.
SELECT * FROM books WHERE pages < 200 OR title LIKE '%stories%'; -- It gets the books if one or the other or both conditions are true
SELECT * FROM books WHERE released_year BETWEEN 2004 AND 2015; -- This eliminates the need of two conditionals at once.
SELECT * FROM books WHERE pages NOT BETWEEN 200 AND 300; -- This works as the opposite of BETWEEN
CAST(someValue AS someType); -- This is how I type cast a value into another data type. String != DATE
SELECT * FROM tableName WHERE row IN (val1, val2, val3, ...); -- IN helps me select values based on a set of values
 -- I can also use NOT IN.
 -- I can also use module in SQL, for example:
SELECT title, released_year FROM books 
  WHERE released_year >= 2000 AND released_year % 2 != 0; -- Select all books with the year greater than 2000 and year not even
SELECT title, released_year, 
  CASE
   WHEN released_year >= 2000 THEN 'Modern Lit'
   ELSE '20th century lit' 
  END AS genre 
FROM books;

SELECT 
  title, 
  stock_quantity, 
  CASE 
    WHEN stock_quantity BETWEEN 0 AND 40 THEN '*' 
    WHEN stock_quantity BETWEEN 41 AND 70 THEN '**' 
    WHEN stock_quantity BETWEEN 71 AND 100 THEN '***' 
    WHEN stock_quantity BETWEEN 101 AND 140 THEN '****' 
    ELSE '*****' 
  END AS stock 
FROM books;
CASE 
 WHEN receipts = 'voucher' THEN ''
 WHEN receipts = 'magcard credit' THEN ''
 ELSE ''
end

SELECT 
  title, 
  stock_quantity, 
  CASE 
    WHEN stock_quantity <= 40 THEN '*' 
    WHEN stock_quantity <= 70 THEN '**' 
    WHEN stock_quantity <= 100 THEN '***' 
    WHEN stock_quantity <= 140 '****' 
    ELSE '*****' 
  END AS stock 
-- These are cases in SQL. They are like switch cases and I can implement complex logic with them: SELECT something CASE WHEN condition THEN returnVal ELSE returnVal END;

-- In SQL I can't directly compare values to null. What I can, however is use IS NULL and IS NOT NULL:
SELECT * FROM books WHERE title IS NULL/IS NOT NULL;

-- More constraints 
CREATE TABLE contacts (name VARCHAR(100) NOT NULL, phone VARCHAR(15) NOT NULL UNIQUE);
 -- UNIQUE as a constraint does not allow me to repeat the same value for the same row
CREATE TABLE users (username VARCHAR(20) NOT NULL, age INT CHECK (age > 0));
 -- CHECK allows me to create special validation of column data. The values only get added to the database if the check returns true
CREATE TABLE users2 (username VARCHAR(20) NOT NULL, age INT, CONSTRAINT age_not_negative CHECK (age >=0));
 -- With the CONSTRAINT keyword I can create names for constraints in the DB columns and name them
CREATE TABLE companies (
  -- supplier_id INT AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  -- phone VARCHAR(15) NOT NULL UNIQUE,
  address VARCHAR(255) NOT NULL,
  -- PRIMARY KEY (supplier_id),
  CONSTRAINT name_address UNIQUE (name, address)
);
 -- Constraints can also use multiple columns, in this case it needs the name and address to be unique
CREATE TABLE houses (
  purchase_price INT NOT NULL,
  sale_price INT NOT NULL,
  CONSTRAINT saleprice_greaterthan_purchaseprice CHECK(sale_price >= purchase_price)
);
 -- This one needs the sale_price to be greater than or equal to purchase_price 

-- Alter Table
ALTER TABLE companies ADD COLUMN city VARCHAR(25); -- This wil create a new column in that table.
 -- What happens when you add a new column to a table that already has values? It's values are set to null by default.
 -- What if I don't want null values? I can avoid null values and/or give a default value.
ALTER TABLE companies ADD COLUMN employee_count INT NOT NULL DEFAULT 1;
ALTER TABLE tableName DROP COLUMN columnName; -- This will drop a column from the table
RENAME TABLE tableName TO newTBName;
ALTER TABLE tableName RENAME TO newTBName; -- Both of these will rename the table
ALTER TABLE tableName RENAME COLUMN colName TO newColName; -- Will rename a column
ALTER TABLE tableName MODIFY columnName TYPE; -- Will change the column type
ALTER TABLE tableName CHANGE oldColName newColName TYPE; -- Will change the name and type
ALTER TABLE tableName ADD CONSTRAINT constraintName CHECK(constraint); -- will add a new constraint to the table after creation
ALTER TABLE tableName DROP CONSTRAINT constraintName; -- Will delete a constraint

-- One to Many & Joins
 -- Different ways data can be related: One to One; One to Many; Many to Many
  -- One to One: One customer row to One customer_details row 
  -- One to Many: Books have many reviews but all of them relate to a single book
  -- Many to Many: A book can have many authors and authors can have many books
 -- 1:MANY
 Table1: Customers    Table2: Orders
 * customer_id <-     * order_id
 * firstName     \    * order_date
 * last_name      \   * amount
 * email           \__* customer_id -> A reference to the Customers table
 -- Primary key means that a particular column will always be unique
 -- Foreign keys are references to another table in a table
 CREATE TABLE tableName (..., columnName FOREIGN KEY REFERENCES someTable(someCol));
 CREATE TABLE table (columnName INT, FOREIGN KEY (columnName) REFERENCES someTable(col));
 -- Both of these create foreign keys and attribute to them a reference on a != table

 -- Cross join, takes everything from both tables and cross multiply them
 SELECT * FROM customers, orders;

 -- Inner join
  -- This will only select the overlaping rows from the two tables
 SELECT * FROM table1 JOIN table2 ON table2.column = table1.column;

 SELECT
	CONCAT_WS(' ', first_name, last_name) AS name,
	SUM(amount) AS total
 FROM
  customers
 JOIN orders ON
  orders.customer_id = customers.id
 GROUP BY
  name
 ORDER BY
  total; -- Example of an inner join with group by

 -- Left join
  -- This selects all rows from the left side and what overlaps between. The rest is null
 SELECT rows FROM table1LeftSide LEFT JOIN table2RightSide ON tabl2/1.FK = table1/2.key; 
  -- This will select everything from table 1 and all overlaps from t2. Whatever is not overlapped, gets a null value 
 SELECT rows FROM table2RS LEFT JOIN table1LS ON table2.FK = customers.id;
  -- If I change the order of the join, I get the same result as an inner join, in the case of the foreign key always matching a row on the "left side table"
 SELECT
	CONCAT_WS(' ', first_name, last_name) AS full_name,
	order_date,
	IFNULL(SUM(amount), 0) AS money_spent -- This tests a query for null. If it is, the result in question receives the value passed as 2nd argument
 FROM
	customers
 LEFT JOIN orders ON
	orders.customer_id = customers.id
 GROUP BY
	full_name;
 -- Right join
  -- This selects all rows from the right side and what overlaps between. The rest is null
 SELECT first_name, last_name, order_date, amount FROM customers RIGHT JOIN orders ON orders.customer_id = customers.id;
  -- Adding the ON DELETE CASCADE constraint to a foreign key makes it so that whenever I try to delete a row that has data related to it on another table, it will delete everything related to it from all tables
  ... FOREIGN KEY (fk) REFERENCES parentTable (parentRow) ON DELETE CASCADE

-- Many to Many
 -- Examples of data using many to many relationships: books - authors; blog posts - tags; students - classes;
 -- A table that conects two or more tables is called a join or union table. Example:
 Reviewers
 - id <-_____________________________________
 - first_name                                 \
 - last_name                     Reviews       \     -- This is going to be the join/union table
                                 - id           \
                                 - rating        \
                             _-> - series_id      \
 Series                     /    - reviewer_id <-_/
 - id <-___________________/
 - title
 - released_year
 - genre

 CREATE TABLE reviewers (
  id INT PRIMARY KEY AUTO_INCREMENT, 
  first_name VARCHAR(50) NOT NULL, 
  last_name VARCHAR(50) NOT NULL
 );

 CREATE TABLE series (
  id INT PRIMARY KEY AUTO_INCREMENT, 
  title VARCHAR(150), 
  released_year YEAR, -- This data type represents years with 'YYYY'
  genre VARCHAR(100)
 );

 CREATE TABLE reviews (
  id INT PRIMARY KEY AUTO_INCREMENT,
  rating DECIMAL(2, 1),
  series_id INT,
  reviewer_id INT,
  FOREIGN KEY (series_id) REFERENCES series(id),
  FOREIGN KEY (reviewer_id) REFERENCES reviewers(id)
 );

SELECT ROUND(value, digits); -- This function either rounds the value to the nearest int or to the nearest floating point if passed a 2nd arg
IF (condition, trueCase, falseCase) AS resultName; 
-- If there is only two options as a result, I can do this, use a short IF statement

-- Views, Modes & More
 -- Views are queries that I can give a name to and store. When they are executed, 
 -- I get the result of the stored query, like a stored table
 CREATE VIEW viewName AS queryIWantToSave; -- Then, I can treat this as if it were a table
 -- However, I can't update or delete views if the view contains any of the following:
  -- Aggregate or window functions;
  -- distinct
  -- group by
  -- having
  -- union or union all
  -- subquery
  -- some types of Joins
  -- reference to nonupdatable view in the FROM clause
  -- suquery in WHERE clause that referes to a table in the FROM clause
  -- refers only to literal values
  -- multiple references to any column of a base table

 CREATE OR REPLACE VIEW viewName AS query; -- This either create a new view or replace an existing one
 ALTER VIEW view AS query; -- This alters the view
 DROP VIEW view; -- Deletes a view

 SELECT * FROM tableName GROUP BY clause HAVING something; 
  -- Having helps me filter groups created by GROUP BY and control the output

 SELECT colName FROM tableName GROUP BY colName WITH ROLLUP; -- OR
 SELECT colName FROM tableName GROUP BY colName, colName2 WITH ROLLUP;
  -- WITH ROLLUP helps me generate multiple grouping sets based on the columns or 
  -- expressions specified in the group by. If there is more than one column for grouping
  -- it generates grouping columns to each end row of the results and the total aggregate

 -- SQL Modes are settings I can manage to change the behaviour and validation from mysql
 SELECT @@SESSIONORGLOBAL.sql_mode; -- Show current set sql modes for the session or globally
 SET GLOBAL sql_mode = 'insertInAllModes,'; -- Updates the global sql modes
 SET SESSION sql_mode = 'insertInAllModes,'; -- Updates the session sql modes

 STRICT_TRANS_TABLES -- Affects quite a few number of things in sql like inserting a different type of value than the programmed to into a table

-- Window functions
 -- Similar to group by but they produce results for each row in the "window"
 SELECT AVG(salary) OVER() FROM employees; 
 -- This tells mysql to find the avg for all the rows, create an empty window and throw
 -- everything there and put this max avg alongside each row. It works for all agg funcs!
 -- Basically, it aggregates a lot of data together and outputs a single value

 -- If I want a window function to work with multiple windows, I need PARTITION BY
 -- Windows are the same, in concept, to groups
 SELECT AVG(salary) OVER(PARTITION BY someCondition), SUM(something) OVER(PARTITION BY ...) FROM employees;

 -- If I use ORDER BY inside an OVER(), I tell mysql to change the order of the rows 
 -- inside each window
 SELECT 
  emp_no, 
  department, 
  salary, 
  SUM(salary) OVER(PARTITION BY department ORDER BY salary) AS rolling_dept_salary,
  SUM(salary) OVER(PARTITION BY department) AS total_dept_salary
 FROM employees;
 -- What happens in this query is getting the total department salary and create a window
 -- for the sum of each employee salary in ascending order by default

 -- Window only functions
  -- RANK literally ranks the data in ascending or descending order and if there is any 
  -- duplicate data, they get the same rank # and skip a number for the amount of 
  -- duplicates present
  SELECT emp_no, department, salary, RANK() OVER(ORDER BY salary DESC) AS overall_salar_rank FROM employees;
  
  -- DENSE_RANK() functions exactly like RANK except that duplicates share the rank and the
  -- next non duplicate is the current rank + 1 not skipping anything.
  SELECT 
   emp_no, 
   department, 
   salary, 
   ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_row_number, 
   RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank, 
   RANK() OVER(ORDER BY salary desc) AS overall_rank, 
   DENSE_RANK() over(order by salary desc) as overall_dense_rank,
   row_number() OVER(order by salary desc) as overall_num 
  FROM employees ORDER BY overall_rank;
  -- ROW_NUMBER() just gives me the count of the number of rows

  -- NTILE takes a # to be used as a quarter and divides all values in each of the quarters 
  SELECT 
   emp_no,
   department,
   salary,
   NTILE(4) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_quartile,
   NTILE(4) OVER(ORDER BY salary DESC) AS salary_quartile
  FROM employees;
  -- This gets the salary of each employee in each of the quartiles and in which quartile
  -- position they are related to their department

  -- FIRST_VALUE/LAST_VALUE/NTH_VALUE takes the first, last or nth value from the first row
  -- of the window frame and returns it. So after ordering and partitioning everything, I
  -- use this to get the highest paid employee, for example
  SELECT emp_no, department, salary, FIRST_VALUE (emp_no) OVER (ORDER BY salary DESC) 
   FROM employees;
  -- Or the highest paid employee in each department
  SELECT 
   emp_no, 
   department, 
   salary, 
   FIRST_VALUE(emp_no) OVER (PARTITION BY department ORDER BY salary DESC) AS highest_paid_in_dept,
   FIRST_VALUE(emp_no) OVER (ORDER BY salary DESC) AS highest_paid_overall
   FROM employees;

  -- LEAD receives an expression as argument and returns the value of it from the next row
  -- LAG receives the expression and returns the value of the previous row
  SELECT emp_no, department, salary, LAG(salary) OVER(ORDER BY salary DESC) FROM employees; 
  -- This brings the salary of the previous employee on the current one. 
  SELECT emp_no, department, salary, LEAD(salary) OVER(ORDER BY salary DESC) FROM employees;
  -- This brings the salary of the next employee on the current one

  -- I can give it a 2nd argument telling the function to bring n previous or next values
  SELECT emp_no, department, salary, LEAD(salary, n) OVER(ORDER BY salary DESC) FROM employees;

-- Instagram schema clone section
 -- 1st, create some way to store users; ✔️
 -- 2nd, create some way to store photos. Be mindful about this being just URLs to them; ✔️
 -- 3rd, create some way to store likes. There can only be one like from a user per photo; ✔️
 -- 4th, create some way to store hashtags; ✔️
 -- 5th, create some way to store comments. Every post can have multiple (1 to many); ✔️
 -- 6th, create some way to relate users in the context of followers and followees; ✔️
  -- keeping in mind that this is a one way relationship: I can follow someone and don't -- get followed back and vice versa
 -- So, the entities are: users, photos, comments for photos, likes for photos, hashtags & followers/followees
 
 DROP DATABASE IF EXISTS snapshotz;
 CREATE DATABASE snapshotz;
 USE snapshotz;

 CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255),
  username VARCHAR(30) NOT NULL UNIQUE,
  full_name VARCHAR(255) NOT NULL,
  passwd VARCHAR(255) NOT NULL,
  verified_user TINYINT NOT NULL,
  phone_number VARCHAR(32),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
 );

 CREATE TABLE photos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  img_url VARCHAR(500) NOT NULL,
  poster_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (poster_id) REFERENCES users(id)
 );

 CREATE TABLE comments (
  id INT PRIMARY KEY AUTO_INCREMENT,
  content VARCHAR(200) NOT NULL,
  commenter_id INT NOT NULL,
  photo_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (commenter_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE
 );

 CREATE TABLE likes (
  user_id INT NOT NULL,
  photo_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE,
  PRIMARY KEY (user_id, photo_id) -- Another way to prevent non unique entries, both need to be unique
 );

 CREATE TABLE follows ( -- I don't need an id since I'm not referencing this table anywhere else
  user_id INT NOT NULL,
  following_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT prevent_self_follow CHECK (user_id != following_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (following_id) REFERENCES users(id) ON DELETE CASCADE
 );

 CREATE TABLE tags (
  id INT PRIMARY KEY AUTO_INCREMENT,
  tag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
 );

 CREATE TABLE photo_tags (
  photo_id INT NOT NULL,
  tag_id INT NOT NULL,
  FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (photo_id, tag_id)
 );

 -- The pattern is: when I'm pulling data from tableA without needing data from tableB, I don't need a join
  -- If I need it, I have to join. If I use a subquery for the first case, it'll either transform itself
  -- into a semi-join or anti-join under the hood thanks to MySQL 8.0.17
