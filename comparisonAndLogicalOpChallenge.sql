-- Comparison & logical operatos challenge
 -- Evaluate these queries
 SELECT 10 != 10; -- 0/false
 SELECT 15 > 14 AND 99 - 5 <= 94; -- 1/true
 SELECT 1 IN (5,3) OR 9 BETWEEN 8 AND 10; -- 1/true

 -- Select all books written before 1980
 SELECT * FROM books WHERE released_year < 1980;

 -- Select all books written by Eggers or Chabon
 SELECT * FROM books WHERE author_lname IN ('Eggers', 'Chabon');
 
 SELECT * FROM books WHERE author_lname = 'Eggers' OR author_lname = 'Chabon';

 -- Select all books written by Lahiri, published after 2000
 SELECT * FROM books WHERE author_lname = 'Lahiri' AND released_year > 2000;

 -- Select all books with page counts between 100 and 200
 SELECT * FROM books WHERE pages BETWEEN 100 AND 200;
 
 SELECT * FROM books WHERE pages >= 100 AND pages <= 200;

 -- Select all books where author_lname starts with a 'C' or an 'S'
 SELECT * FROM books WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';
 
 SELECT * FROM books WHERE LEFT(author_lname, 1) = 'C' OR LEFT(author_lname, 1) = 'S';
 
 SELECT * FROM books WHERE LEFT(author_lname, 1) IN ('C', 'S');

 -- Select title and author_lname from books. If the title contains "stories", 
  -- the type should be "Short Stories", if the title is "Just Kids" or "A 
  -- Heartbreaking Work of Staggering Genius", it should be "Memoir". Anything 
  -- else, "Novel"
 SELECT title, author_lname,
  CASE
    WHEN title IN ('Just Kids', 'A Heartbreaking Work of Staggering Genius') THEN 'Memoir'
    WHEN title LIKE '%stories%' THEN 'Short Stories'
    ELSE 'Novel'
  END AS 'TYPE'
 FROM books;

 -- Bonus exercise: select author_fname and _lname from books. For each grouping
 -- of the author full name, create a new column named "COUNT" with how many books
 -- they wrote followed by "book" or "books"
 SELECT  
  author_fname,
  author_lname,
  CASE
    WHEN COUNT(CONCAT_WS(' ', author_fname, author_lname)) > 1 THEN CONCAT(COUNT(*), ' ', 'books')
    ELSE CONCAT(COUNT(*),
      ' ',
      'book
      ')
  END AS 'COUNT'
 FROM
     books
 GROUP BY CONCAT_WS(' ', author_fname, author_lname);
 
 SELECT
  author_fname,
  author_lname,
  CASE
    WHEN COUNT(*) > 1 THEN CONCAT(COUNT(*), ' books')
    ELSE CONCAT(COUNT(*), ' books')
  END AS COUNT
 FROM books
 GROUP BY CONCAT(author_fname, ' ', author_lname);
