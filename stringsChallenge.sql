-- Practicing SQL's string functions
SELECT REVERSE(UCASE('Why does my cat look at me with such hatred?'));

--
SELECT REPLACE(CONCAT('I', ' ', 'like', ' ', 'cats'), ' ', '-'); -- I-like-cats

--
USE book_shop;
SHOW TABLES;
SELECT * FROM books;
SELECT REPLACE(title, ' ', '->') AS title FROM books;

--
SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards FROM books;

--
SELECT CONCAT(UPPER(author_fname), ' ', UPPER(upper_lname)) AS 'full name in caps' FROM books;

--
SELECT CONCAT(title, ' ', 'was released in', ' ' , released_year) AS blurb FROM books;

--
SELECT title AS title, CHAR_LENGTH(title) AS 'character count';

--
SELECT CONCAT(SUBSTR(title, 1, 10), '...') AS 'short title',
  CONCAT(author_lname, ',', author_fname) AS author,
  CONCAT(stock_quantity, ' ', 'in stock') AS quantity
  FROM books;
