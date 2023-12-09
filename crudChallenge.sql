-- CRUD Challenge
  -- Create a new database
  CREATE DATABASE shirts_db;
  USE shirts_db;

  -- Create a new "shirts" table
  CREATE TABLE shirts (
  shirt_id INT PRIMARY KEY AUTO_INCREMENT, 
  article VARCHAR(100) NOT NULL, 
  color VARCHAR(100) NOT NULL, 
  shirt_size VARCHAR(100) NOT NULL, 
  last_worn VARCHAR(100) NOT NULL
  );

  -- Insert some shirts into the table
  INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES
  ('t-shirt', 'white', 'S', 10),
  ('t-shirt', 'green', 'S', 200),
  ('polo shirt', 'black', 'M', 10),
  ('tank top', 'blue', 'S', 50),
  ('t-shirt', 'pink', 'S', 0),
  ('polo shirt', 'red', 'M', 5),
  ('tank top', 'white', 'S', 200),
  ('tank top', 'blue', 'M', 15);

  -- Add a new shirt
  INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES ('Polo shirt', 'Purple', 'M', 50);

  -- Select all shirts but print out only the article and color
  SELECT article, color FROM shirts;

  -- Select all medium shirts with every row but the shirt_id
  SELECT article, color, shirt_size, last_worn FROM shirts;

  -- Update all polo shirts by changing their size to L
  UPDATE shirts SET shirt_size = 'L' WHERE article = 'Polo shirt';

  -- Set the shirt last worn 15d/ago to today
  UPDATE shirts SET last_worn = 0 WHERE last_worn = 15;

  -- Update all white shirts to XS and 'off white'
  UPDATE shirts SET shirt_size = 'XS', color = 'off white' WHERE color = 'white';

  -- Delete all old shirts
  DELETE from shirts WHERE last_worn = 200;

  -- Delete all tank tops
  DELETE from shirts WHERE article = 'tank top';

  -- Delete all shirts
  DELETE from shirts;

  -- Drop the entire shirts table
  DROP TABLE shirts;