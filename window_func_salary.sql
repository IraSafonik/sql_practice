select *
from salaries s 

select job_title
	, round(avg(salary_in_usd),0) as avg_salary
from salaries s 
group by 1

--
select 
	job_title
		, salary_in_usd
		, avg(salary_in_usd) over(partition by job_title)
		, min(salary_in_usd) over(partition by job_title)
		, max(salary_in_usd) over(partition by job_title)
from salaries s 

--
with cte as (
select 
	job_title
		, salary_in_usd
		, avg(salary_in_usd) over(partition by job_title) as avg_salary
		, min(salary_in_usd) over(partition by job_title) as min_salar
		, max(salary_in_usd) over(partition by job_title) as max_salar
from salaries s
)

select *
from cte


--
with cte as (
select 
	job_title
		, salary_in_usd
		, avg(salary_in_usd) over(partition by job_title) as avg_salary
		, min(salary_in_usd) over(partition by job_title) as min_salary
		, max(salary_in_usd) over(partition by job_title) as max_salary
		, count(salary_in_usd) over(partition by job_title) as job_cnt
		, sum(salary_in_usd) over(partition by job_title) as sum_salary
from salaries s
where year = 2023
)

select *
	, salary_in_usd::float / max_salary as ratio_max --cast()
	, salary_in_usd::float / min_salary as ratio_min
	, salary_in_usd/avg_salary as ratio_avg
from cte

--
with cte as (
select 
	job_title
		, salary_in_usd
		, avg(salary_in_usd) over(partition by job_title order by salary_in_usd) as avg_salary
from salaries s
where year = 2023
)

select *
from cte


-- задача
with cte as (
select 
	job_title
		, salary_in_usd
		, avg(salary_in_usd) over(partition by job_title) as avg_salary
from salaries s
where year = 2023
)

select *
from cte
where salary_in_usd > avg_salary
