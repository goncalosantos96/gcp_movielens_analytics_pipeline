CREATE SCHEMA IF NOT EXISTS `dpt-challenge-movielens.movielens_raw_dataset` OPTIONS (location = 'europe-southwest1');

CREATE EXTERNAL TABLE `dpt-challenge-movielens.movielens_raw_dataset.belief_data` (

  userId STRING,
  movieId STRING,
  isSeen STRING,
  watchDate STRING,
  userElicitRating STRING,
  userPredictRating STRING,
  userCertainty STRING,
  tstamp STRING,
  movie_idx STRING,
  `source` STRING,
  systemPredictRating STRING

)
OPTIONS (
  format = 'CSV',
  uris = ['gs://movielens-challenge-bucket/bronze/belief_data.csv'],
  skip_leading_rows = 1
);


CREATE EXTERNAL TABLE `dpt-challenge-movielens.movielens_raw_dataset.movie_elicitation_set` (

  movieId STRING,
  month_idx STRING,
  `source` STRING,
  tstamp STRING

)
OPTIONS (

  format = 'CSV',
  uris = ['gs://movielens-challenge-bucket/bronze/movie_elicitation_set.csv'],
  skip_leading_rows = 1

);

CREATE EXTERNAL TABLE `dpt-challenge-movielens.movielens_raw_dataset.movies` (

  movieId STRING,
  title STRING,
  genres STRING

)
OPTIONS (

  format = 'CSV',
  uris = ['gs://movielens-challenge-bucket/bronze/movies.csv'],
  skip_leading_rows = 1

);


CREATE EXTERNAL TABLE `dpt-challenge-movielens.movielens_raw_dataset.ratings_for_additional_users` (

  userId STRING,
  movieId STRING,
  rating STRING,
  tstamp STRING

)
OPTIONS (

  format = 'CSV',
  uris = ['gs://movielens-challenge-bucket/bronze/ratings_for_additional_users.csv'],
  skip_leading_rows = 1
);


CREATE EXTERNAL TABLE `dpt-challenge-movielens.movielens_raw_dataset.user_rating_history` (

  userId STRING,
  movieId STRING,
  rating STRING,
  tstamp STRING

)
OPTIONS (

  format = 'CSV',
  uris = ['gs://movielens-challenge-bucket/bronze/user_rating_history.csv'],
  skip_leading_rows = 1

);

CREATE EXTERNAL TABLE `dpt-challenge-movielens.movielens_raw_dataset.user_recommendation_history` (

  userId STRING,
  tstamp STRING,
  movieId STRING,
  predictedRating STRING

)
OPTIONS (
  
  format = 'CSV',
  uris = ['gs://movielens-challenge-bucket/bronze/user_recommendation_history.csv'],
  skip_leading_rows = 1
);
