-- Retrieve all cat_ids from the cats table
SELECT cat_id FROM cats;

-- Retrieve all names and breeds from the cats table
SELECT name, breed FROM cats;

-- Retrieve the name and age of all Tabby cats from the cats table
SELECT name, age FROM cats WHERE breed = 'Tabby';

-- Retrieve the cat_id and age from the cats which have them as the same value
SELECT cat_id, age FROM cats WHERE cat_id = age;

-- Change Jackson's name to "Jack"
UPDATE cats SET name = 'Jack' WHERE name = 'Jackson';

-- Change Ringo's breed to "British Shorthair"
UPDATE cats SET breed = 'British Shorthair' where name = 'Ringo';

-- Update Maine Coons' ages to 12
UPDATE cats SET age = 12 WHERE breed = 'Maine Coon';

-- Delete all 4 year old cats
DELETE FROM cats WHERE age = 4;

-- Delete cats whose age is the same as their cat_id
DELETE FROM cats WHERE age = cat_id;

-- Delete all cats
DELETE FROM cats;

-- Format all book title to a length of 10 characters and with ellipsis at the end
SELECT CONCAT(SUBSTR(title, 1, 10), '...') AS short_title FROM books;

-- Select all book authors initials
SELECT CONCAT(SUBSTR(author_fname, 1, 1), '.', SUBSTR(author_lname, 1, 1) , '.') AS author_initials 
   FROM books;

-- Replace all spaces on the book names with dashes
SELECT REPLACE(title, ' ', '-') FROM books;

-- Turn every name into a palindrome
SELECT CONCAT(author_fname, REVERSE(author_fname)) FROM books;

-- Create this sentence for every book title: I LOVE bookTitle !!!
SELECT CONCAT('I LOVE ', title, ' !!!') FROM books;

-- Get all authors initials
SELECT CONCAT(LEFT(author_fname, 1), '.', RIGHT(author_lname, 1), '.') FROM books;

-- Get all distinct full names
SELECT DISTINCT CONCAT_WS(' ', author_fname, author_lname) FROM books;

SELECT DISTINCT author_fname, author_lname FROM books;

-- Get the 5 earliest released books
SELECT book_id title, released_year FROM books ORDER BY ASC LIMIT 5;

-- Get all books with a column on their title
SELECT * FROM books WHERE title LIKE '%:%';

-- Get all books that have a author_fname as being one char, an a, and another char
SELECT * FROM books WHERE author_fname LIKE '_a_';

-- Get all books where the author's first name has an "a" anywhere in it
SELECT * FROM books WHERE author_fname LIKE '%a%';

-- Get all books where the author's first name ends with "n"
SELECT * FROM books WHERE author_fname LIKE '%n';

-- Count all distinct first names
SELECT COUNT(DISTINCT author_fname) FROM books;

-- Select all titles that contain "the"
SELECT COUNT(*) FROM books WHERE title LIKE '%the%';

-- Find out how many books were released in each year
SELECT released_year, COUNT(*) FROM books GROUP BY released_year;

-- Find out how many books were released in a certain year
SELECT released_year, COUNT(*) FROM books WHERE released_year = yearWanted GROUP BY released_year;

-- Find the earliest released book
SELECT MIN(released_year) FROM books;

-- Find the longest book
SELECT MAX(pages) FROM books;

-- Find the title of the longest book
SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;

SELECT title, pages FROM books WHERE pages = (SELECT MAX(pages) FROM books); -- Get multiple values, if there are any duplicates rows for pages amount

-- Find the earliest released book
SELECT MIN(released_year) FROM books;

SELECT title, released_year FROM books WHERE released_year = (SELECT MIN(released_year) FROM books);

-- Find the year each author published their first book
SELECT CONCAT_WS(' ', author_fname, author_lname) AS author, MIN(released_year) FROM books GROUP BY author ORDER BY released_year;

-- Find the year each author published their latest book
SELECT CONCAT_WS(' ', author_fname, author_lname) AS author, MAX(released_year) FROM books GROUP BY author;

-- What about both?
SELECT CONCAT_WS(' ', author_lname, author_fname) AS author, MIN(released_year), MAX(released_year) FROM books GROUP BY author;

-- Count all books released by each author
SELECT CONCAT_WS(' ', author_lname, author_fname) AS author, 
   COUNT(*) AS books_written, 
   MIN(released_year) AS earliest_release, 
   MAX(released_year) AS latest_release 
FROM books GROUP BY author;

-- Get the logest page count of the books
SELECT CONCAT_WS(' ', author_lname, author_fname) AS author,
   COUNT(*) AS books_written,
   MIN(released_year) AS earliest_release,
   MAX(released_year) AS latest_release,
   MAX(pages) AS page_count
FROM books GROUP BY author;

-- Sum all pages each writer has written
SELECT CONCAT_WS(', ', author_lname, author_fname) AS author, SUM(pages) FROM books GROUP BY author;

-- Calculate the average released_year across all books
SELECT AVG(released_year) FROM books;

-- Calculate the average amount of pages from all books
SELECT AVG(pages) FROM books;

-- Calculate the average stock quantity from all books
SELECT AVG(stock_quantity) FROM books;

-- Calculate the average stock quantity for books released in the same year
SELECT released_year, AVG(stock_quantity), COUNT(*) FROM books GROUP BY released_year;

-- Select all birth dates from people as 'April 11 1986'
SELECT CONCAT_WS(' ', MONTHNAME(birthdate), DAY(birthdate), YEAR(birthdate)) AS formatted_date FROM people;

-- Get the day in wich every person will have their 18th birthday
SELECT birthdate, DAY(DATE_ADD(birthdate, INTERVAL 18 YEAR)) AS 18th_birthday FROM people;

-- Select all books not written by Neil Gaiman
SELECT title, author_lname FROM books WHERE author_lname != 'Gaiman';

-- Select any book titles that don't contain the letter 'e'
SELECT title FROM books WHERE title NOT LIKE '%e%';

-- Select all short books
SELECT title, released_year FROM books WHERE pages < 200;

-- Find all books released after 2010 including 2010
SELECT title, author_lname, released_year FROM books WHERE released_year >= 2010;

-- Finda all books released before 2000, including 2000
SELECT title, author_lname, released_year FROM books WHERE released_year <= 2000;

-- Get all Eggers books released after 2010 with "novel" in their titles
SELECT * FROM books WHERE author_lname = 'Eggers' AND released_year > 2010 AND title LIKE '%novel%';

-- Select all books with at last 15 characters on their title and a large number of pages, > 500
SELECT * FROM books WHERE CHAR_LENGTH(title) >= 15 AND pages > 500;

-- Select all books published between 2004 and 2015
SELECT * FROM books WHERE released_year >= 2004 AND released_year <= 2015;

SELECT * FROM books WHERE released_year BETWEEN 2004 AND 2015;

-- Select all books that are between 200 and 300 pages
SELECT * FROM books WHERE pages BETWEEN 200 AND 300;

SELECT * FROM books WHERE pages >= 200 AND pages <= 300;

-- Select all books that are not between 200 and 300 pages
SELECT * FROM books WHERE pages NOT BETWEEN 200 AND 300;

-- Select all books from Carver, Lahiri or Smith
SELECT * FROM books WHERE author_lname = 'Carver' OR author_lname = 'Lahiri' OR author_lname = 'Smith';

SELECT * FROM books WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');

-- Now do the opposite!
SELECT * FROM books WHERE author_lname NOT IN ('Carver', 'Lahiri', 'Smith');

-- Select all books not published in 2002, 04, 06, 08, 10, 12, 14, 16
SELECT title, released_year FROM books WHERE released_year NOT IN (2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016);

-- Select all books released after the year 2000 but not in the years from the previous exercise
SELECT title, released_year FROM books WHERE released_year >= 2000 
  AND released_year NOT IN (2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016);

SELECT title, released_year FROM books 
  WHERE released_year >= 2000 AND released_year % 2 != 0;

-- One to Many exercises
 -- Write a query to select all orders placed by 'Boy George'
 SELECT id FROM customers WHERE last_name = 'George';
 SELECT * FROM orders WHERE customer_id = 1;

 SELECT * FROM orders WHERE customer_id = (
  SELECT id FROM customers WHERE last_name = 'George'
 );

 SELECT * FROM orders join customers on customers.id = order.customer_id;

 -- Get the total amount spent by each customer
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
  total;
