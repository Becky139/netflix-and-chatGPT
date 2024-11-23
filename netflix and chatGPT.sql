DESCRIBE cast;
DESCRIBE category;
DESCRIBE countries;
DESCRIBE directors;
DESCRIBE netflix_titles;
DESCRIBE rating;
DESCRIBE show_cast;
DESCRIBE show_category;
DESCRIBE show_country;
DESCRIBE show_director;

SELECT 'cast' AS table_name, COUNT(*) AS row_count FROM cast
UNION ALL
SELECT 'category', COUNT(*) FROM category
UNION ALL
SELECT 'countries', COUNT(*) FROM countries
UNION ALL
SELECT 'directors', COUNT(*) FROM directors
UNION ALL
SELECT 'netflix_titles', COUNT(*) FROM netflix_titles
UNION ALL
SELECT 'rating', COUNT(*) FROM rating
UNION ALL
SELECT 'show_cast', COUNT(*) FROM show_cast
UNION ALL
SELECT 'show_category', COUNT(*) FROM show_category
UNION ALL
SELECT 'show_country', COUNT(*) FROM show_country
UNION ALL
SELECT 'show_director', COUNT(*) FROM show_director;

