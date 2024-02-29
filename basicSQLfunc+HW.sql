select 
	year, 
	exp_level as level,
 	emp_type as type
from salaries
where 
	year != 2022
	and exp_level = 'SE'
order by year desc
limit 20;

-- top 5 Data Science salaries in 2023
select 
	year
	, job_title
	, salary_in_usd
from salaries
where 
	year = 2023
	and job_title = 'Data Scientist'
order by salary_in_usd desc
limit 5;

_______________________

select
	1 as nmb_1
	,2 as nmb_2
	,5+5 as nmb_3

select 
	count(*) as cnt_all
	, count(exp_level) as cnt_level
	, count(distinct exp_level)
from salaries
limit 10;
	
________
select
	round(avg(salary_in_usd), 2) as salary_avg
	, min(salary_in_usd) as salary_min
	, max(salary_in_usd) as salary_max
from salaries
where year = 2023
limit 10;

select
	year
	, exp_level
	, salary_in_usd
	, salary_in_usd * 38 as salary_in_uah
	-- 'SE' - Senior
	-- 'MI' - Middle
	-- Other
	, case 
		when exp_level = 'SE'
		then 'Senior'
		when exp_level = 'MI'
		then 'Middle'
		else 'Other' end as full_level
from salaries
limit 20;

---
Вивести з/п спеціалістів ML Engineer в 2023 році, відфільтрована за зростанням
select 
	year
	, job_title
	, salary_in_usd
from salaries
where 
	year = '2023'
	and job_title = 'ML Engineer'
order by salary_in_usd asc;


select 
	salary_in_usd
from salaries
where 
	year = '2023'
	and job_title = 'ML Engineer'
order by 1 asc;

-----
Назвати країну (company_location), 
в якій зафіксована найменша з/п спеціаліста 
в сфері Data Scientist в 2023 році

select
	year,
	job_title,
	comp_location,
	salary_in_usd as salary_min
from salaries
where year = '2023'
	and job_title = 'Data Scientist'
order by 4 asc
limit 1;


select 
	comp_location,
	salary_in_usd as salary_min
from salaries
order by salary_in_usd asc
limit 1;

select 
	job_title,
    comp_location,
    min(salary_in_usd) as salary_min
from salaries
group by comp_location, job_title
order by salary_min asc
limit 1;

----
Вивести топ 5 з/п серед усіх спеціалістів, 
які працюють повністю віддалено (remote_ratio = 100)
select*
from salaries
limit 10;

select 
	salary_in_usd as top_salary,
	remote_ration
from salaries
where remote_ration = 100
order by 1 desc
limit 5;

---
Вивести кількість унікальних значень для кожної колонки, 
що містить текстові значення.

SELECT count(distinct(exp_level)) as unique_exp_level,
	count(distinct(emp_type)) as unique_emp_type,
	count(distinct(job_title)) as unique_job_title,
	count(distinct(salary_curr)) as unique_salary_curr,
	count(distinct(emp_location)) as unique_emp_location,
	count(distinct(comp_location)) as unique_comp_location,
	count(distinct(comp_size)) as unique_comp_size
from salaries;
-----
Вивести унікальні значення для кожної колонки, 
що містить текстові значення. 
(SELECT DISTINCT column_name FROM salaries)

select
	distinct(exp_level) as unique_exp_level
from salaries;

select
	distinct(emp_type) as unique_emp_type
from salaries;

select
	distinct(job_title) as unique_job_title
from salaries;

select
	distinct(salary_curr) as unique_salary_curr
from salaries;

select
	distinct(emp_location) as unique_emp_location
from salaries;

select
	distinct(comp_location) as unique_comp_location
from salaries;

select
	distinct(comp_size) as unique_comp_size
from salaries;

SELECT exp_level as unique_exp_level
FROM salaries
GROUP BY exp_level;

____
Вивести з/п українців (код країни UA), 
додати сортування за зростанням з/п

select salary_in_usd,
	emp_location
from salaries
where emp_location = 'UA'
order by salary_in_usd asc;


-----
Вивести середню, мінімальну та максимальну з/п (salary_in_usd) 
для кожного року (окремими запитами, 
в кожному з яких впроваджено фільтр відповідного року)

select distinct(year)
from salaries;
--- 2021
select 
	round(avg(salary_in_usd),2) as salary_avg,
	min(salary_in_usd) as salary_min,
	max(salary_in_usd) as salary_max
from salaries
where year = '2021';

--- 2022
select 
	round(avg(salary_in_usd),2) as salary_avg,
	min(salary_in_usd) as salary_min,
	max(salary_in_usd) as salary_max
from salaries
where year = '2022';

--- 2020
select 
	year,
	round(avg(salary_in_usd),2) as salary_avg,
	min(salary_in_usd) as salary_min,
	max(salary_in_usd) as salary_max
from salaries
where year = '2020'
group by year;

select 
	round(avg(salary_in_usd),2) as salary_avg,
	min(salary_in_usd) as salary_min,
	max(salary_in_usd) as salary_max
from salaries
where year = '2020';

--- 2023
select 
	round(avg(salary_in_usd),2) as salary_avg,
	min(salary_in_usd) as salary_min,
	max(salary_in_usd) as salary_max
from salaries
where year = '2023';

-----
Вивести середню з/п (salary_in_usd) для 2023 року 
по кожному рівню досвіду працівників 
(окремими запитами, в кожному з яких впроваджено фільтр року та досвіду).
select distinct(exp_level)
from salaries
limit 10;

select 
	avg(salary_in_usd),
	year,
	exp_level
from salaries
where year = '2023'
	and exp_level = 'EX'
group by year, exp_level;

select 
	avg(salary_in_usd),
	year,
	exp_level
from salaries
where year = '2023'
	and exp_level = 'MI'
group by year, exp_level;

select 
	avg(salary_in_usd),
	year,
	exp_level
from salaries
where year = '2023'
	and exp_level = 'EN'
group by year, exp_level;

select 
	round(avg(salary_in_usd), 2),
	year,
	exp_level
from salaries
where year = '2023'
	and exp_level = 'SE'
group by year, exp_level;


------
Вивести 5 найвищих заробітних плат в 2023 році 
для представників спеціальності ML Engineer. 
Заробітні плати перевести в гривні

select 
	salary_in_usd as top_salary_in_usd,
	salary_in_usd * 38 as top_salary_in_uah,
	year,
	job_title
from salaries
where year = '2023'
	and job_title = 'ML Engineer'
order by 1 desc
limit 5;

----
Вивести Унікальні значення колонки remote_ratio, 
формат даних має бути дробовим з двома знаками після коми, 
приклад: значення 50 має відображатись в форматі 0.50
select*
from salaries
limit 10;

select distinct round((remote_ration/100.0),2) as remote_frac
from salaries;

----
Вивести дані таблиці, додавши колонку 'exp_level_full' 
з повною назвою рівнів досвіду працівників 
відповідно до колонки exp_level. 
Визначення: Entry-level (EN), Mid-level (MI), 
Senior-level (SE), Executive-level (EX)

select *, 
	case 
		when exp_level = 'EN' then 'Entry-level'
		when exp_level = 'MI' then 'Mid-level'
		when exp_level = 'SE' then 'Senior-level'
		when exp_level = 'EX' then 'Executive-level'
	end 											as exp_level_full
from salaries;


----
Додатки колонку "salary_category', 
яка буде відображати різні категорії заробітних плат 
відповідно до їх значення в колонці 'salary_in_usd'. 
Визначення: з/п менша за 20 000 - Категорія 1, 
з/п менша за 50 000 - Категорія 2, 
з/п менша за 100 000 - Категорія 3, 
з/п більша за 100 000 - Категорія 4

select 
	*,
	case 
		when salary_in_usd < 20000 then 'category1'
		when salary_in_usd < 50000 then 'category2'
		when salary_in_usd < 100000 then 'category3'
		when salary_in_usd > 10000 then 'category4'
		end											as salary_category
from salaries;

----
Дослідити всі колонки на наявність відсутніх значень, 
порівнявши кількість рядків таблиці з кількістю значень 
відповідної колонки
select*
from salaries;

select count(*)
from salaries

select count(*) - count(year) as miss_value
from salaries

select count(*) - count(exp_level) as miss_value
from salaries

select count(*) - count(emp_type) as miss_value
from salaries

select count(*) - count(job_title) as miss_value
from salaries

select count(*) - count(salary) as miss_value
from salaries

select count(*) - count(salary_curr) as miss_value
from salaries

select count(*) - count(salary_in_usd) as miss_value
from salaries

select count(*) - count(emp_location) as miss_value
from salaries

select count(*) - count(remote_ration) as miss_value
from salaries

select count(*) - count(comp_location) as miss_value
from salaries

select count(*) - count(comp_size) as miss_value
from salaries