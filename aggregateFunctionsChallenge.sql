-- Aggregate functions challenge
 -- Print the total number of books in the database
 SELECT COUNT(*) AS total_books FROM books;

 -- Print how many books were released in each year
 SELECT released_year AS year, COUNT(*) AS 'Released this year' FROM books GROUP BY year;

 -- Print out the total number of books in stock
 SELECT SUM(stock_quantity) FROM books;

 -- Find the average released_year for each author
 SELECT CONCAT_WS(' ', author_fname, author_lname) AS author, AVG(released_year) AS average FROM books GROUP BY author;

 -- Find the full name of the author who wrote the longest book
 SELECT CONCAT_WS(' ', author_fname, author_lname) AS author, pages FROM books WHERE pages = (SELECT MAX(pages) FROM books);
 
 SELECT CONCAT_WS(' ', author_fname, author_lname) AS author, pages FROM books ORDER BY pages DESC LIMIT 1;

 -- Create a table with each year there was a release, how many books were released and the average pages from them
 SELECT released_year AS 'year', COUNT(*) AS '# books', AVG(pages) AS 'avg pages' FROM books GROUP BY year;
 