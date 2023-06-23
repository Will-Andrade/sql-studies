-- Aggregate Functions Challenge
USE book_shop;
SELECT COUNT(*) FROM books;

--
SELECT released_year, COUNT(*) FROM books GROUP BY released_year;

--
SELECT SUM(stock_quantity) FROM books;

--
SELECT author_lname, AVG(released_year) FROM books GROUP BY author_lname;

--
-- SELECT CONCAT(author_fname, ' ', author_lname) AS longest_book_author FROM books
--   WHERE pages = (SELECT MAX(pages) FROM books);
SELECT CONCAT(author_fname, ' ',  author_lname) AS author FROM books 
  ORDER BY pages DESC LIMIT 1;

--
SELECT released_year AS year, COUNT(*) AS '# books', AVG(pages) AS 'avg pages'
  FROM books GROUP BY year ORDER BY year;
