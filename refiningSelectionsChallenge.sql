-- Refining selections challenge
 -- Select all titles that contain "stories"
 SELECT title FROM books WHERE title LIKE '%stories%';

 -- Find the longest book's title and page count
 SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;
 
 -- Print a summary with title and year of the 3 most recent books
 SELECT DISTINCT CONCAT_WS(' - ', title, released_year) AS summary FROM books ORDER BY released_year DESC LIMIT 3;

 -- Find all books with an author last name that has a space " "
 SELECT title, author_lname FROM books where author_lname LIKE '% %';

 -- Find the 3 books with the lowest stock
 SELECT title, released_year, stock_quantity FROM books ORDER BY stock_quantity LIMIT 3;

 -- Print title and author_lname sorted 1st by author_lname and then title
 SELECT title, author_lname FROM books ORDER BY author_lname, title;

 -- Create a yell table with "MY FAVORITE AUTHOR IS author full name!", sorted by last name
 SELECT CONCAT(
  'MY FAVORITE AUTHOR IS ', 
  UPPER(author_fname), 
  ' ', 
  UPPER(author_lname), 
  '!'
 ) AS yell FROM books ORDER BY author_lname;