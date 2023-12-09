-- One to Many & Joins exercises
 -- Write this schema: 
 -- STUDENTS         PAPERS
 -- id   <-----      title
 -- first_name \     grade
 --             \___ student_id
 CREATE TABLE students (id INT PRIMARY KEY AUTO_INCREMENT, first_name VARCHAR(50) NOT NULL);
 CREATE TABLE papers (title VARCHAR(150) NOT NULL, grade INT NOT NULL, student_id INT NOT NULL, FOREIGN KEY (student_id) REFERENCES students(id));
 
 -- Insert this data into the tables
  INSERT INTO students (first_name) VALUES 
  ('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

  INSERT INTO papers (student_id, title, grade ) VALUES
  (1, 'My First Book Report', 60),
  (1, 'My Second Book Report', 75),
  (2, 'Russian Lit Through The Ages', 94),
  (2, 'De Montaigne and The Art of The Essay', 98),
  (4, 'Borges and Magical Realism', 89);

 -- Print the first name, title of the paper and grade for each student that submitted one
 SELECT first_name, title, grade FROM students 
  JOIN papers ON students.id = papers.student_id ORDER BY grade DESC;
 
 -- Print the first name, title and grade for all students, even the ones that did not submit any
 SELECT first_name, title, grade FROM students 
  LEFT JOIN papers ON papers.student_id = students.id;

 SELECT first_name, title, grade FROM papers 
  RIGHT JOIN students ON students.id = papers.student_id;

 -- Print the same as before but now adding "MISSING" as a default value to the title and 0 to the grade
 SELECT first_name, IFNULL(title, 'MISSING'), IFNULL(grade, 0) FROM students 
  LEFT JOIN papers ON papers.student_id = students.id;

 SELECT first_name, IFNULL(title, 'MISSING'), IFNULL(grade, 0) FROM papers 
  RIGHT JOIN students ON students.id = papers.student_id;

 -- Print the first name and average grade for all students
 SELECT first_name, IFNULL(AVG(grade), 0) AS average FROM students
  LEFT JOIN papers ON papers.student_id = students.id GROUP BY first_name 
  ORDER BY average DESC;

 -- Print the first name, average and "passing_status" for each student
 SELECT
	first_name,
	IFNULL(AVG(grade), 0) AS average,
	CASE
		WHEN IFNULL(AVG(grade), 0) >= 75 THEN 'PASSING'
		ELSE 'FAILING'
	END AS passing_status
  FROM
    students
  LEFT JOIN papers ON
    papers.student_id = students.id
  GROUP BY
    first_name
  ORDER BY
    average DESC;
