-- Find the top 10 countries with the most Netflix content
SELECT c.Country, COUNT(*) AS total_titles
FROM show_country sc
JOIN countries c ON sc.Country_ID = c.Country_ID
GROUP BY c.Country
ORDER BY total_titles DESC
LIMIT 10;

-- Get the most common content ratings and their counts
SELECT r.rating, COUNT(*) AS total_count
FROM netflix_titles nt
JOIN rating r ON nt.Rating_ID = r.Rating_ID
GROUP BY r.rating
ORDER BY total_count DESC;

-- Identify the top 5 most popular content categories/genres
SELECT cat.Category, COUNT(*) AS total_count
FROM show_category sc
JOIN category cat ON sc.Cat_ID = cat.Cat_ID
GROUP BY cat.Category
ORDER BY total_count DESC
LIMIT 5;

-- Determine the oldest and newest release years in the database
SELECT 
    MIN(release_year) AS oldest_year, 
    MAX(release_year) AS newest_year
FROM netflix_titles;

-- Find the actors who appear in the most Netflix titles
SELECT c.Name AS actor_name, COUNT(*) AS total_shows
FROM show_cast sc
JOIN cast c ON sc.Cast_ID = c.Cast_ID
GROUP BY c.Name
ORDER BY total_shows DESC
LIMIT 10;

-- Find the directors with the highest number of Netflix titles
SELECT d.`Director Name` AS director_name, COUNT(*) AS total_titles
FROM show_director sd
JOIN directors d ON sd.Director_ID = d.Director_ID
GROUP BY d.`Director Name`
ORDER BY total_titles DESC
LIMIT 10;

-- Find the directors with the highest number of Netflix titles
SELECT d.`Director Name` AS director_name, COUNT(*) AS total_titles
FROM show_director sd
JOIN directors d ON sd.Director_ID = d.Director_ID
GROUP BY d.`Director Name`
ORDER BY total_titles DESC
LIMIT 10;

-- Analyze the trend of content added by month (based on the date_added field)
SELECT 
    MONTH(STR_TO_DATE(date_added, '%M %d, %Y')) AS month,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY month
ORDER BY month;

-- Count the number of Netflix titles released each year
SELECT release_year, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year DESC;

-- Find pairs of directors and actors who have collaborated most frequently
SELECT 
    d.`Director Name` AS director_name, 
    c.Name AS actor_name, 
    COUNT(*) AS total_collaborations
FROM show_director sd
JOIN directors d ON sd.Director_ID = d.Director_ID
JOIN show_cast sc ON sd.show_id = sc.show_id
JOIN cast c ON sc.Cast_ID = c.Cast_ID
GROUP BY d.`Director Name`, c.Name
ORDER BY total_collaborations DESC
LIMIT 5;


