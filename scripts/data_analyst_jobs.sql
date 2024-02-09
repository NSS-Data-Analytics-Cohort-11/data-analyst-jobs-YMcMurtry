SELECT *
FROM data_analyst_jobs;

-- 1.	How many rows are in the data_analyst_jobs table?

SELECT COUNT(*)
FROM data_analyst_jobs;

--Answer: 1793

-- 2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- Answer: ExxonMobil

-- 3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT *
FROM data_analyst_jobs
WHERE location IN('TN');

SELECT *
FROM data_analyst_jobs
WHERE location IN('TN','KY');

-- Answer: TN has 21, TN and KY have 27

-- 4.	How many postings in Tennessee have a star rating above 4?

SELECT *
FROM data_analyst_jobs
WHERE location IN ('TN')
	AND star_rating > 4.0;
	
-- Answer: 3

-- 5.	How many postings in the dataset have a review count between 500 and 1000?

SELECT *
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 and 1000;

-- Answer: 151

-- 6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY AVG(star_rating) DESC;

-- Answer: Nevada at 4.1999998090000000

-- 7.	Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

-- Answer: 881

-- 8.	How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location IN ('CA');

-- Answer: 230

-- 9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT DISTINCT(company), location, review_count, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE review_count >5000
GROUP BY company, location, review_count;

-- Answer: 83

-- 10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT DISTINCT(company), location, review_count, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE review_count >5000
GROUP BY company, location, review_count
ORDER BY avg_rating DESC;

-- Answer: American Express with rating of 4.1999998090000000

-- 11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 

SELECT DISTINCT *
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%';

-- Answer: 1636 job titles-1567 are unique titles


-- 12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT DISTINCT *
FROM data_analyst_jobs
WHERE title NOT ILIKE '%analyst%'
	AND title NOT ILIKE '%analytics%';
	
-- Answer: All 4 show Tableau
	

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 

SELECT COUNT(domain)
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%';

SELECT *
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%';

-- Answer: 1090 jobs require SQL

-- 	Disregard any postings where the domain is NULL. 

SELECT *
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%'
	AND domain IS NOT null;
	
-- Answer: 707 total where domain is not 'null'

-- 	- Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top.

SELECT *
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%'
	AND domain IS NOT null
ORDER BY days_since_posting DESC;

-- 	  - Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

SELECT *
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%'
	AND domain IS NOT null
ORDER BY days_since_posting DESC
LIMIT 5;

-- Answer: Government, Education and Schools, Consumer Goods and Services, Restaurants, Travel and Leisure

-- 	How many jobs have been listed for more than 3 weeks for each of the top 4?

SELECT title, days_since_posting, domain
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%'
	AND domain IS NOT null
	AND domain ILIKE '%government%'
GROUP BY title, days_since_posting, domain
HAVING days_since_posting > 21
ORDER BY days_since_posting DESC;

SELECT title, days_since_posting, domain
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%'
	AND domain IS NOT null
	AND domain ILIKE '%education%'
GROUP BY title, days_since_posting, domain
HAVING days_since_posting > 21
ORDER BY days_since_posting DESC;

SELECT title, days_since_posting, domain
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%'
	AND domain IS NOT null
	AND domain ILIKE '%consumer%'
GROUP BY title, days_since_posting, domain
HAVING days_since_posting > 21
ORDER BY days_since_posting DESC;

SELECT title, days_since_posting, domain
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%'
	AND domain IS NOT null
	AND domain ILIKE '%restaurant%'
GROUP BY title, days_since_posting, domain
HAVING days_since_posting > 21
ORDER BY days_since_posting DESC;


-- Answer: Government- 9, Education and Schools- 12, Consumer Goods and Services- 8, Restaurant Travel and Leisure- 8


