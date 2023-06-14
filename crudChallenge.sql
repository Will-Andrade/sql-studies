-- Spring Cleaning CRUD Challenge
  -- Create a database called shirts_db and a table called shirts ✅
  -- Create 5 columns: ✅
    -- shirt_id: Primary key, auto increment;
    -- article: the type of shirt, string;
    -- color: color of shirt, string;
    -- shirt_size: size of shirt, string;
    -- last_worn: how many days since I last wore the shirt, number;
  -- Insert all of this data in one go: ✅
    -- ('t-shirt', 'white', 'S', 10),
    -- ('t-shirt', 'green', 'S', 200),
    -- ('polo shirt', 'black', 'M', 10),
    -- ('tank top', 'blue', 'S', 50),
    -- ('t-shirt', 'pink', 'S', 0),
    -- ('polo shirt', 'red', 'M', 5),
    -- ('tank top', 'white', 'S', 200),
    -- ('tank top', 'blue', 'M', 15) 
  -- Add a new shirt: purple, polo shirt, size m, last worn 50 days ago ✅
  -- Select all shirts and print their article and color ✅
  -- Select all medium shirts, print out everything but the shirt_id ✅
  -- Update all polo shirts, changing their size to L ✅
  -- Update the shirt last worn 15 days ago to today ✅
  -- Update all white shirts, changing their size to XS and color to off white ✅
  -- Delete all old shirts (last_worn === 200 days) ✅
  -- Delete all tank tops ✅
  -- Delete all shirts ✅
  -- Drop the shirts table ✅

--
CREATE DATABASE shirts_db;
USE shirts_db;
CREATE TABLE shirts (shirt_id INT auto_increment, 
 article VARCHAR(255) NOT NULL, 
 color VARCHAR(255) NOT NULL, 
 shirt_size VARCHAR(255) NOT NULL, 
 last_worn INT NOT NULL, 
 PRIMARY KEY(shirt_id)
);
DESC shirts;

--
INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES 
  ('t-shirt', 'white', 'S', 10), 
  ('t-shirt', 'green', 'S', 200),
  ('polo shirt', 'black', 'M', 10), 
  ('tank top', 'blue', 'S', 50), 
  ('t-shirt', 'pink', 'S', 0), 
  ('polo shirt', 'red', 'M', 5), 
  ('tank top', 'white', 'S', 200), 
  ('tank top', 'blue', 'M', 15)
;
SELECT * FROM shirts;

--
INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES ('polo shirt', 'purple', 'M', 50);
SELECT * FROM shirts WHERE color='purple';

--
SELECT article, color FROM shirts;

--
SELECT article, color, shirt_size, last_worn FROM shirts WHERE shirt_size='M';

--
UPDATE shirts SET shirt_size='L' WHERE article='polo shirt';
SELECT * FROM shirts WHERE article='polo shirt';

--
UPDATE shirts SET last_worn=0 WHERE last_worn=15;
SELECT * FROM shirts WHERE last_worn=0;

--
UPDATE shirts SET shirt_size='XS', color='off white' WHERE color='white';
SELECT * FROM shirts WHERE color='off white';

--
DELETE FROM shirts WHERE last_worn=200;
SELECT * FROM shirts;

--
DELETE FROM shirts WHERE article='tank top'
SELECT * FROM shirts;

--
DELETE FROM shirts;

--
DROP TABLE shirts;
DROP DATABASE shirts_db;
