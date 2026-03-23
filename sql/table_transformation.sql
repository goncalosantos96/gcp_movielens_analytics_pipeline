CREATE SCHEMA IF NOT EXISTS `dpt-challenge-movielens.movielens_analytics_dataset` OPTIONS (location = 'europe-southwest1');

CREATE OR REPLACE TABLE `dpt-challenge-movielens.movielens_analytics_dataset.dim_movies` AS
SELECT
  SAFE_CAST(movieId AS NUMERIC) as movieId,
  REGEXP_REPLACE(title, r'\((\d{4})\)', '') as title,
  COALESCE(genres,'(no genres listed)') as genres,
  SAFE_CAST(REGEXP_EXTRACT(title, r'\d{4}') AS NUMERIC) as release_year
FROM `dpt-challenge-movielens.movielens_raw_dataset.movies`;

CREATE OR REPLACE TABLE `dpt-challenge-movielens.movielens_analytics_dataset.fact_ratings` AS
WITH deduped_ratings_history AS (
  SELECT 
    SAFE_CAST(userId AS NUMERIC) AS userId,
    SAFE_CAST(movieId AS NUMERIC) AS movieId,
    SAFE_CAST(rating AS FLOAT64) AS rating,
    SAFE_CAST(tstamp AS TIMESTAMP) AS tstamp,
    ROW_NUMBER() OVER(PARTITION BY userId, movieId ORDER BY rating ASC NULLS LAST, SAFE_CAST(tstamp AS TIMESTAMP) DESC NULLS LAST) AS rn
  FROM `dpt-challenge-movielens.movielens_raw_dataset.user_rating_history`
)
SELECT
  userId,
  movieId,
  rating,
  tstamp
FROM deduped_ratings_history
WHERE rn = 1

UNION ALL

SELECT
  SAFE_CAST(userId AS NUMERIC) AS userId,
  SAFE_CAST(movieId AS NUMERIC) AS movieId,
  SAFE_CAST(rating AS FLOAT64) AS rating,
  SAFE_CAST(tstamp AS TIMESTAMP) as tstamp
FROM `dpt-challenge-movielens.movielens_raw_dataset.ratings_for_additional_users`;


