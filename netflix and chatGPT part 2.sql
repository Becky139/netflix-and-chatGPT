-- 1. The cast members who appear in the most shows
-- Finds cast members who have appeared in the highest number of shows and sorts by count in descending order
SELECT 
    c.Name AS cast_member, 
    COUNT(sc.show_id) AS total_shows
FROM show_cast sc
JOIN cast c ON sc.Cast_ID = c.Cast_ID
GROUP BY c.Name
ORDER BY total_shows DESC;

-- 2. The count of TV shows and movies available in each country
-- Groups the number of TV Shows and Movies in each country by type and sorts by country
SELECT 
    co.Country AS country, 
    nt.type, 
    COUNT(nt.show_id) AS total_count
FROM show_country sc
JOIN countries co ON sc.Country_ID = co.Country_ID
JOIN netflix_titles nt ON sc.show_id = nt.show_id
GROUP BY co.Country, nt.type
ORDER BY co.Country, nt.type;

-- 3. The percentage of movies in each category, broken down by country
-- Calculates the percentage of movies in each category for each country
SELECT 
    co.Country AS country,
    cat.Category AS category,
    COUNT(nt.show_id) AS total_movies,
    ROUND(
        (COUNT(nt.show_id) / 
         (SELECT COUNT(nt2.show_id) 
          FROM netflix_titles nt2
          JOIN show_country sc2 ON nt2.show_id = sc2.show_id
          WHERE nt2.type = 'Movie' AND sc2.Country_ID = sc.Country_ID
         )
        ) * 100, 2) AS percentage
FROM netflix_titles nt
JOIN show_category sca ON nt.show_id = sca.show_id
JOIN category cat ON sca.Cat_ID = cat.Cat_ID
JOIN show_country sc ON nt.show_id = sc.show_id
JOIN countries co ON sc.Country_ID = co.Country_ID
WHERE nt.type = 'Movie'
GROUP BY co.Country, cat.Category
ORDER BY co.Country, percentage DESC;

-- 4. The percentage of movies and TV shows in each rating, broken down by country
-- Calculates the percentage of Movies and TV Shows in each rating for each country
SELECT 
    co.Country AS country,
    nt.type,
    r.rating AS content_rating,
    COUNT(nt.show_id) AS total_titles,
    ROUND(
        (COUNT(nt.show_id) / 
         (SELECT COUNT(nt2.show_id) 
          FROM netflix_titles nt2
          JOIN show_country sc2 ON nt2.show_id = sc2.show_id
          WHERE sc2.Country_ID = sc.Country_ID
         )
        ) * 100, 2) AS percentage
FROM netflix_titles nt
JOIN rating r ON nt.Rating_ID = r.Rating_ID
JOIN show_country sc ON nt.show_id = sc.show_id
JOIN countries co ON sc.Country_ID = co.Country_ID
GROUP BY co.Country, nt.type, r.rating
ORDER BY co.Country, nt.type, percentage DESC;

-- 5. The most popular director and cast member in each country
-- Finds the director and cast member with the highest number of titles in each country
SELECT 
    co.Country AS country,
    'Director' AS role,
    d.`Director Name` AS name,
    COUNT(nt.show_id) AS total_titles
FROM show_director sd
JOIN directors d ON sd.Director_ID = d.Director_ID
JOIN netflix_titles nt ON sd.show_id = nt.show_id
JOIN show_country sc ON nt.show_id = sc.show_id
JOIN countries co ON sc.Country_ID = co.Country_ID
GROUP BY co.Country, d.`Director Name`
ORDER BY co.Country, total_titles DESC;

SELECT 
    co.Country AS country,
    'Cast Member' AS role,
    c.Name AS name,
    COUNT(nt.show_id) AS total_titles
FROM show_cast sca
JOIN cast c ON sca.Cast_ID = c.Cast_ID
JOIN netflix_titles nt ON sca.show_id = nt.show_id
JOIN show_country sc ON nt.show_id = sc.show_id
JOIN countries co ON sc.Country_ID = co.Country_ID
GROUP BY co.Country, c.Name
ORDER BY co.Country, total_titles DESC;

-- 6. The most popular director and cast member in each category
-- Finds the director and cast member with the highest number of titles in each category
SELECT 
    cat.Category AS category,
    'Director' AS role,
    d.`Director Name` AS name,
    COUNT(nt.show_id) AS total_titles
FROM show_director sd
JOIN directors d ON sd.Director_ID = d.Director_ID
JOIN netflix_titles nt ON sd.show_id = nt.show_id
JOIN show_category sc ON nt.show_id = sc.show_id
JOIN category cat ON sc.Cat_ID = cat.Cat_ID
GROUP BY cat.Category, d.`Director Name`
ORDER BY cat.Category, total_titles DESC;

SELECT 
    cat.Category AS category,
    'Cast Member' AS role,
    c.Name AS name,
    COUNT(nt.show_id) AS total_titles
FROM show_cast sca
JOIN cast c ON sca.Cast_ID = c.Cast_ID
JOIN netflix_titles nt ON sca.show_id = nt.show_id
JOIN show_category sc ON nt.show_id = sc.show_id
JOIN category cat ON sc.Cat_ID = cat.Cat_ID
GROUP BY cat.Category, c.Name
ORDER BY cat.Category, total_titles DESC;
