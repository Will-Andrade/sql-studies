-- Many to Many exercises
 -- Get the title and rating from every tv show
 SELECT title, rating FROM series JOIN reviews ON reviews.series_id = series.id;

 -- Get the average rating for each tv show sorted from lowest to highest
 SELECT title, ROUND(AVG(rating), 2) AS avg_rating FROM series 
  JOIN reviews ON reviews.series_id = series.id GROUP BY title ORDER BY avg_rating;

 -- Select first_name & last_name of every reviewer paired with their reviews
 SELECT first_name, last_name, rating FROM reviewers
  JOIN reviews ON reviewers.id = reviews.reviewer_id;

 -- Select all series with no reviews and name the result "unreviewed_series"
 SELECT title AS unreviewed_series FROM series 
  LEFT JOIN reviews ON reviews.series_id = series.id WHERE rating IS NULL;

 SELECT title AS unreviewed_series FROM reviews
  RIGHT JOIN series ON series.id = reviews.series_id WHERE rating IS NULL;

 -- Select the average rating for each of the genres and name this avg_rating
 SELECT genre, ROUND(AVG(rating), 2) AS avg_rating FROM reviews 
  LEFT JOIN series ON series.id = reviews.series_id GROUP BY genre;

 SELECT genre, ROUND(AVG(rating), 2) AS avg_rating FROM reviews 
  RIGHT JOIN series ON series.id = reviews.series_id GROUP BY genre;

 SELECT genre, ROUND(AVG(rating), 2) AS avg_rating FROM reviews
  JOIN series ON series.id = reviews.series_id GROUP BY genre;

 -- Select first and last name of each reviewer, # of reviews they left, min & max review,
 -- average and status that varies based on whether or not they left a review
 SELECT 
  first_name, 
  last_name, 
  COUNT(rating) AS COUNT, 
  IFNULL(ROUND(MIN(rating), 1), 0) AS MIN,
  IFNULL(ROUND(MAX(rating), 1), 0) AS MAX,
  ROUND(IFNULL(AVG(rating), 0), 2) AS AVG,
  CASE
    WHEN COUNT(rating) >= 1 THEN 'ACTIVE'
    ELSE 'INACTIVE'
  END AS 'STATUS'
 FROM reviewers
 LEFT JOIN reviews ON reviewers.id = reviews.reviewer_id GROUP BY first_name ORDER BY 'STATUS';

 SELECT 
  first_name, 
  last_name, 
  COUNT(rating) AS COUNT, 
  IFNULL(ROUND(MIN(rating), 1), 0) AS MIN,
  IFNULL(ROUND(MAX(rating), 1), 0) AS MAX,
  ROUND(IFNULL(AVG(rating), 0), 2) AS AVG,
  IF (COUNT(rating) > 0, 'ACTIVE', 'INACTIVE') AS 'STATUS'
 FROM reviewers
 LEFT JOIN reviews ON reviewers.id = reviews.reviewer_id GROUP BY first_name ORDER BY 'STATUS';

 -- Take each review, add its title, rating and reviewer full name (two joins)
 SELECT title, rating, CONCAT_WS(' ', first_name, last_name) AS reviewer FROM reviews 
  LEFT JOIN series ON reviews.series_id = series.id
  LEFT JOIN reviewers ON reviews.reviewer_id = reviewers.id;

 SELECT title, rating, CONCAT_WS(' ', first_name, last_name) AS reviewer FROM reviews 
  INNER JOIN series ON reviews.series_id = series.id 
  INNER JOIN reviewers ON reviews.reviewer_id = reviewers.id;

 -- Get the total aggregate of avg ratings
 SELECT released_year, avg(rating) FROM full_review GROUP BY released_year WITH ROLLUP;

 -- Get the avg rating by year and total of the query
 SELECT released_year, genre, avg(rating) from full_review 
  GROUP by released_year, genre WITH ROLLUP;

 -- Select the min and max salary from the table
 SELECT emp_no, department, salary, MIN(salary) OVER(), MAX(salary) OVER() FROM employees;

 -- Select the minimum salary by department
 SELECT 
  emp_no, 
  department, 
  salary, 
  MIN(salary) OVER(PARTITION BY department) AS dpt_average 
 FROM employees;

 SELECT department, AVG(salary) FROM employees GROUP BY department; 
 -- Different type of result, no way to compare to what each member makes

 -- Select the same plus the average company wide
 SELECT emp_no, department, AVG(salary) OVER(PARTITION BY department) AS dept_avg, AVG(salary) OVER() AS company_avg FROM employees;

 -- Select how many employees are in each department
 SELECT emp_no, department, salary, COUNT(emp_no) OVER(PARTITION BY department) AS department_count FROM employees;

 -- Get the total payroll for each department
 SELECT department, salary, SUM(salary) OVER(PARTITION BY department) AS dept_payroll, SUM(salary) OVER() AS total_payroll FROM employees;

 -- Get the overall rank for every employee based on their salary
 SELECT emp_no, department, salary RANK() OVER(ORDER BY salary DESC) AS overall_salar_rank FROM employees;

 -- Get the same as before but also based on their department
 SELECT  
  emp_no, 
  department, 
  salary,
  ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_row_number,
  RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank, 
  RANK() OVER(ORDER BY salary desc) AS overall_salary_rank 
 FROM employees ORDER BY department;
 
 -- Calculate the salary difference between employees
 SELECT 
  emp_no, 
  department, 
  salary, 
  salary - LAG(salary) OVER(ORDER BY salary DESC) AS salary_diff
 FROM employees;
 
 -- Calculate the salary difference  by department
 SELECT
  emp_no,
  department,
  salary,
  salary - LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_diff
 FROM employees;
 