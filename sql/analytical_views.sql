CREATE SCHEMA IF NOT EXISTS `dpt-challenge-movielens.movielens_consumption_dataset` OPTIONS (location = 'europe-southwest1');


CREATE VIEW IF NOT EXISTS `dpt-challenge-movielens.movielens_consumption_dataset.vw_movies_kpis` AS
SELECT 
  (SELECT COUNT(*)
  FROM `dpt-challenge-movielens.movielens_analytics_dataset.dim_movies`) AS total_movies,

  (SELECT COUNT(rating)
   FROM`dpt-challenge-movielens.movielens_analytics_dataset.fact_ratings`) AS total_ratings,

  (SELECT ROUND(AVG(rating), 2)
   FROM `dpt-challenge-movielens.movielens_analytics_dataset.fact_ratings`) AS global_avg_rating,

  (SELECT COUNT(DISTINCT userId) as total_users
   FROM `dpt-challenge-movielens.movielens_analytics_dataset.fact_ratings`) AS total_users;


CREATE VIEW IF NOT EXISTS `dpt-challenge-movielens.movielens_consumption_dataset.vw_top_movies` AS
SELECT 
  dm.title,
  COUNT(fr.rating) AS total_ratings,
  ROUND(AVG(fr.rating), 2) AS avg_ratings
FROM `dpt-challenge-movielens.movielens_analytics_dataset.fact_ratings` fr
JOIN `dpt-challenge-movielens.movielens_analytics_dataset.dim_movies` dm
ON fr.movieId = dm.movieId
WHERE rating > 0
GROUP BY dm.title
HAVING COUNT(fr.rating) >= 1000
ORDER BY avg_ratings DESC
LIMIT 10;



CREATE VIEW IF NOT EXISTS `dpt-challenge-movielens.movielens_consumption_dataset.vw_ratings_heatmap` AS
SELECT 
  FORMAT_DATE('%Y-%b',DATE_TRUNC(tstamp, month)) AS year_month,
  COUNT(rating) as total_ratings
FROM `dpt-challenge-movielens.movielens_analytics_dataset.fact_ratings`
GROUP BY 1
ORDER BY year_month;



CREATE VIEW IF NOT EXISTS `dpt-challenge-movielens.movielens_consumption_dataset.vw_scatter_popularity_vs_quality` AS
SELECT 
  dm.title,
  COUNT(dm.title) AS total_ratings,
  ROUND(AVG(fr.rating), 2) AS avg_rating
FROM `dpt-challenge-movielens.movielens_analytics_dataset.fact_ratings` fr
JOIN `dpt-challenge-movielens.movielens_analytics_dataset.dim_movies` dm
ON fr.movieId = dm.movieId
WHERE rating > 0
GROUP BY dm.title;

SELECT *
FROM `dpt-challenge-movielens.movielens_consumption_dataset.vw_scatter_popularity_vs_quality`
ORDER BY avg_rating DESC
LIMIT 10;



CREATE VIEW IF NOT EXISTS `dpt-challenge-movielens.movielens_consumption_dataset.vw_user_activity` AS
SELECT
  userId,
  COUNT(rating) AS n_ratings_provided,
  ROUND(AVG(rating), 2) AS avg_rating_provided,
  MIN(tstamp) AS first_rating,
  MAX(tstamp) AS last_rating
FROM `dpt-challenge-movielens.movielens_analytics_dataset.fact_ratings`
WHERE rating > 0
GROUP BY userId;



CREATE VIEW IF NOT EXISTS `dpt-challenge-movielens.movielens_consumption_dataset.vw_genre_performance` AS
SELECT
  genre,
  COUNT(rating) as total_ratings,
  ROUND(AVG(rating), 2) as avg_rating_genre
FROM `dpt-challenge-movielens.movielens_analytics_dataset.fact_ratings` fr
JOIN `dpt-challenge-movielens.movielens_analytics_dataset.dim_movies` dm
ON fr.movieId = dm.movieId,
UNNEST(SPLIT(dm.genres, '|')) as genre
WHERE rating > 0
GROUP BY genre;
