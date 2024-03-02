select*
from salaries
limit 10

select
	count(*)
from salaries


select
	count(*)
	, count(*) - count(salary_in_usd) as missing_values
from salaries

select
	job_title
	, count(*)
from salaries
group by 1
order by 2 desc
limit 10

select
	job_title
	, exp_level
	, min(salary_in_usd)
	, max(salary_in_usd)
	, round(avg(salary_in_usd), 2) as avg
	, stddev(salary_in_usd)
from salaries
group by 1, 2

select
	trunc(salary_in_usd, -1)
	, count(*)
from salaries
group by 1

select
	case 
		when salary_in_usd <=10000 then 'A'
		when salary_in_usd <=20000 then 'B'
		when salary_in_usd <=50000 then 'C'
		when salary_in_usd <=100000 then 'D'
		when salary_in_usd <=200000 then 'E'
		else 'F' end as salary_category
	, count(*)
from salaries
group by 1

select 
	corr(remote_ration, salary_in_usd)
from salaries
