show databases;
use projects;
show tables;
select * from movies limit 2;
delete from movies
where rating = '';
select distinct(rating) from movies;
select distinct(score) from movies order by score desc;
select distinct(company) from movies;

-- movies with rating > 8
select * from movies where score > 8;
select * from movies where year = 1980;
-- top 3 movies by votes
select * from movies order by votes desc limit 3;
-- gross> budget
select * from movies where gross>budget;
-- count movies per genre
select genre,count(*) as movies_count from movies 
group by genre
order by movies_count desc;

-- top directors with avg rating movies
select director, avg(score)as avg_rating from movies 
group by director
order by avg_rating desc
limit 5;

-- most profitable movie 
select *,(gross-budget) as profit 
from movies
order by profit desc limit 1;

-- Count how many movies of each genre are released per year.
select genre, year, count(*) as movies_count
from movies
group by genre, year
order by year desc, movies_count desc; 

-- Top 5 actors by total movie votes
select star, sum(votes) as total_votes from movies
group by star
order by total_votes desc
limit 5;

-- Find movies where gross < budget and score < 5.
select name,score, budget, gross, (gross-budget)as total_profit from movies 
where
gross<budget and score<5
order by score;

-- Identify the longest movies in each genre for special screenings.
-- SELECT name, genre, runtime
-- FROM (
--     SELECT name, genre, runtime,
--            RANK() OVER (PARTITION BY genre ORDER BY runtime DESC) as rank_num
--     FROM movies
-- ) AS ranked_movies
-- WHERE rank_num = 1;

-- Average budget per genre
select genre, avg(budget) as avg_budget
from movies
group by genre
order by avg_budget desc;

-- Movies released in summer with high ratings

-- Directors with most hit movies
SELECT director, COUNT(*) AS hit_movies_count
FROM movies
WHERE score > 8 
  AND gross > budget
GROUP BY director
ORDER BY hit_movies_count DESC;

-- Country-wise box office performance total gross per country
select country, sum(gross) as total_gross from movies 
group by country
order by total_gross
desc;

-- Yearly trends in movie ratings
select year, round(avg(score),2) as avg_score from movies 
group by year
order by year desc;

-- Actors who often work with the same director Which actors frequently appear in movies by the same director?
select director,star, count(star) as actor_count
from movies
group by director, star
having actor_count >1
order by actor_count desc;

