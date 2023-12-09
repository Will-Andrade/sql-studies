-- Instagram DB clone challenge
 -- We want to reward our users who have been around the longest. Find the 5 oldest users;
 SELECT * FROM users ORDER BY created_at LIMIT 5;

 -- What day of the week do most users register on? We need to figure out when to schedule an ad campaign;
 SELECT DAYNAME(created_at) as day, COUNT(*) AS total FROM users GROUP BY day ORDER BY total DESC LIMIT 1;
 -- LIMIT to n if there is more than one day

 SELECT DAYNAME(MAX(created_at)) FROM users;

 -- For any # of tied values
 SELECT 
  DAYNAME(created_at) AS day, 
  COUNT(*) AS total_reg
 FROM users 
 GROUP BY day
 HAVING total_reg = 
  (SELECT COUNT(*)  -- This gets the total registrations per day and selects only the day with the most registrations
    FROM users 
    GROUP BY DAYNAME(created_at) 
    ORDER BY COUNT(*) DESC 
    LIMIT 1
  )
 ;

 -- We want to target our inactive users with an email campaign. Find the users who have never posted a photo
 SELECT username FROM users LEFT JOIN photos ON photos.user_id = users.id WHERE photos.user_id IS NULL;

 SELECT username FROM users WHERE id NOT IN (SELECT DISTINCT user_id FROM photos);

 -- We're running a new contest to see who can get the most likes on a single photo. Who won?
 SELECT 
  photos.image_url, 
  photo_id, 
  COUNT(*) AS total_likes,
  username 
  FROM photos 
  INNER JOIN likes 
    ON likes.photo_id = photos.id 
  INNER JOIN users 
    ON users.id = photos.user_id 
  GROUP BY photos.id 
  ORDER BY total DESC 
 LIMIT 1;

 -- Our investors want to know: How many times does the average user post?
 SELECT (SELECT COUNT(*) FROM photos)  / (SELECT COUNT(*) FROM users);

 SELECT COUNT(*) / (SELECT COUNT(*) FROM users) FROM photos;

 -- A brand wants to know which hashtags to use in a post. What are the top 5 most commonly used hashtags?
 SELECT 
  tag_id,
  tag_name, 
  COUNT(*) AS uses 
 FROM tags 
  JOIN photo_tags ON photo_tags.tag_id = tags.id 
  GROUP BY tag_id 
  ORDER BY uses DESC 
  LIMIT 5
 ;

 SELECT 
  tag_id,
  tag_name, 
  COUNT(*) AS uses 
 FROM tags 
  JOIN photo_tags ON photo_tags.tag_id = tags.id 
  GROUP BY tag_name 
  ORDER BY uses DESC 
  LIMIT 5
 ;

 -- We have a small problem with bots on our site. Find users who have liked every single photo on the site
 SELECT 
  username, 
  COUNT(*) AS num_likes 
 FROM users 
  JOIN likes ON likes.user_id = users.id 
 GROUP BY users.id 
 HAVING num_likes = (SELECT COUNT(*) FROM photos)
 ;
