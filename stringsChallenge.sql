-- String functions challenge
 -- Reverse and uppercase this: "Why does my cat look at me with such hatred?"
 SELECT REVERSE(UPPER('Why does my cat look at me with such hatred?'));

 -- What does this print out?
 SELECT
  REPLACE
  (
  CONCAT('I', ' ', 'like', ' ', 'cats'),
  ' ',
  '-'
  ); -- It prints out: I-like-cats

 -- Replace spaces in titles with "->"
 SELECT REPLACE(title, ' ', '->') AS title FROM books;
 
 -- Print the last name of each author "forwards" and "backwards"
 SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards FROM books;

 -- Get the full name in caps from all authors
 SELECT CONCAT_WS(' ', UPPER(author_fname), UPPER(author_lname)) AS 'full name in caps' FROM books;

 -- Print each title and release date like so: title was released in released_year
 SELECT CONCAT_WS(' ', title, 'was released in', released_year) AS blurb FROM books;

 -- Print book titles and length of each title 
 SELECT title, CHAR_LENGTH(title) as 'character count' FROM books;

 -- Print the short title, author full name and book quantity
 SELECT CONCAT(SUBSTR(title, 1, 10), '...') AS 'short title', 
  CONCAT_WS(',', author_lname, author_fname) AS author,
  CONCAT_WS(' ', stock_quantity, 'in', 'stock') AS quantity FROM books;
