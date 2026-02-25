show databases;
use projects;
show tables;
select * from movies limit 5;

select * from movies
where 
score = (select max(score) from movies);

-- top 3 directors 
select director from movies
group by director
order by sum(gross) desc limit 3;
 
-- top 3 directors movies
with top_directors as (select director 
	from movies
	group by director
	order by sum(gross) desc limit 3)
select * from movies where director in (select * from top_directors)
order by director;

-- 
select star from movies
where votes>25000
group by star having
avg(Score) >8.5;


-- find the movie with the highest profit
select  *, (gross-budget) as profit 
from movies 
order by profit desc limit 1;

select * from movies 
where (gross-budget) = (select max(gross-budget) from movies);

-- find the above average rating movies
select count(*) as good_movies
from movies
where score > (select avg(score) from movies);

-- find the highest rating movie of 2000
select * from movies
where year = 2000
order by score desc limit 1; 

-- find the highest rated movie amoung all 
select * from movies
where votes>(select avg(votes) from movies)
order by votes desc limit 1;



-- every genre has its own highest rating movies
select genre, max(score) as highest_rating from movies
group by genre;

-- using window functions top movies by every genre
SELECT *
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY genre ORDER BY score DESC) AS rnk
    FROM movies
) t
WHERE rnk = 1;

-- top movies by every rating
select name, rating, genre, year, score
from (select name, rating, genre, year, score,
rank() over(partition by rating order by score desc) as rating_rank
from movies)m
where rating_rank=1;

-- top movies by every year
select name, rating, year, score,genre
from (select name, rating, year, score,genre,
rank() over (partition by year order by score desc) as year_top
from movies)m
where year_top = 1;

-- flop movies
select name, rating, year, score,genre
from (select name, rating, year, score,genre,
rank() over (partition by year order by score asc) as year_top
from movies)m
where year_top = 1;

-- every year max profit
select * from movies limit 1;
select * from movies 
where (year, gross-budget) in (
select year, max(gross-budget) from movies 
group by year);









