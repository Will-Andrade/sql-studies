-- More data types challenge
 -- What is a good use case for CHAR? 
  -- To represent states acronyms, in general: things that need a fixed length

 -- Fill the blanks, price is < 1,000.000,00 CREATE TABLE inventory (item_name, price, quantity);
 CREATE TABLE inventory (item_name VARCHAR(150), price DECIMAL(7, 2), quantity INT);

 -- What's the difference between DATETIME and TIMESTAMP? 
  -- Timestamp has a limited range of dates, from 1971 to 2038 and uses less memory,
  -- while DATETIME goes from the year 1000 to 9999.

 -- Print out the current time
 SELECT CURTIME();

 -- Print out the current date
 SELECT CURDATE():

 -- Print out the current day of the week as a number
 SELECT DAYOFWEEK(CURDATE());

 -- Print out the current day of the week name
 SELECT DAYNAME(CURDATE());
 
 SELECT DATE_FORMAT(NOW(), '%W');

 -- Print out the current day and time using this format: mm/dd/yyyy
 SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');

 -- Do the same but in this format: January 2nd at 3:15
 SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i');
 
 -- Create a tweets table that stores the tweet content (180 characters), username, time the tweet was created
 CREATE TABLE tweets (
  tweet_content VARCHAR(180), 
  username VARCHAR(15), 
  created_at TIMESTAMP DEFAULT NOW()
 );
