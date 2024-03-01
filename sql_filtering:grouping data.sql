select*
from salaries
limit 20

-- не дорівнює
select*
from salaries
where
	year <> 2023
limit 20

--or 

select*
from salaries
where
	year != 2023
limit 20

--

select*
from salaries
where 
	exp_level = 'MI'
	and (exp_level != 'MI'
	or exp_level != 'MI')
limit 20

--

select distinct year
from salaries
where 1=1
-- 	and year >= 2020
-- 	and year <= 2023
-- 	and year not between 2021 and 2023
 	and year between 2020 and 2023
limit 20

--
select distinct year
from salaries
where 1=1
-- 	and year in (2020, 2021)
	and year not in (2020, 2021)
-- 	and year >= 2020
-- 	and year <= 2023
limit 20

--
select distinct job_title
from salaries
where 1=1
	and job_title in ('Data Analyst', 'Data Scientist')
limit 20

--
select distinct job_title
from salaries
where 1=1
	and job_title like ('%Data%')
limit 20

select distinct job_title
from salaries
where 1=1
	and job_title like ('Data Sc%')
limit 20

select distinct job_title
from salaries
where 1=1
	and job_title like ('Data_A%')
limit 20

select distinct job_title
from salaries
where 1=1
	and job_title not like ('Data%')
limit 20

-- не відчутний до регістру (бере і великі і маленькі значення)
select distinct job_title
from salaries
where 1=1
	and job_title ilike ('data_A%')
limit 20

--пусті значення
select *
from salaries
where 1=1
	and year is null
limit 20

select *
from salaries
where 1=1
	and year is not null
limit 20

select count(*)
from salaries
where 1=1
	and year is not null
limit 20

-- count(колонка) рахує тільки не пусті значення
select count(year)
from salaries
where 1=1
-- 	and year is not null
limit 20

--ГРУПУВАННЯ ДАНИХ (агрегація, блок group by, оператор having)
select *
from salaries
where 1=1
limit 20

select distinct(job_title)
from salaries

select job_title
	, count(*) as job_nmb
	, round(avg(salary_in_usd), 2) as year_salary_usd_avg
	, round(avg(salary_in_usd)/12, 0) as month_salary_usd_avg
	, round(avg(salary_in_usd)*38, 2) as year_salary_uah_avg
from salaries
group by job_title
order by 3 desc

select job_title
	, count(*) as job_nmb
	, round(avg(salary_in_usd), 2) as year_salary_usd_avg
	, round(avg(salary_in_usd)/12, 0) as month_salary_usd_avg
	, round(avg(salary_in_usd)*38, 2) as year_salary_uah_avg
from salaries
group by job_title
order by 2 desc

select job_title
	, exp_level
	, count(*) as job_nmb
	, round(avg(salary_in_usd), 2) as year_salary_usd_avg
	, round(avg(salary_in_usd)/12, 0) as month_salary_usd_avg
	, round(avg(salary_in_usd)*38, 2) as year_salary_uah_avg
from salaries
where year = 2023
group by job_title, exp_level
order by 1, 2;


--
select job_title
-- 	, count(*) as job_nmb
	, round(avg(salary_in_usd)*37, 2) as year_salary_uah_avg
from salaries
where year = 2023
group by job_title
having count(*) = 1
	and round(avg(salary_in_usd)*37, 2) > 4000000
order by 2

---
👉 Вивести всіх спеціалістів в яких зп вище середньої в таблиці 
select*
from salaries
where salary_in_usd > 
(
	select avg(salary_in_usd)
	from salaries
);

👉 Вивести всіх спеціалістів в яких зп вище середньої в таблиці
у 2023 році

select*
from salaries
where salary_in_usd >  -- порівняння зп з середньою у 2023 році
(
	select avg(salary_in_usd) -- Обчислення середньої зарплати за 2023 рік
	from salaries
	where year = 2023
)
	and year = 2023;
--
👉 Вивести всіх спеціалістів, які живуть в країнах де середня зп 
вища за середню серед усіх країн
select
	emp_location
	, salary_in_usd 
	, comp_location
from salaries

-- 1.Пошук середньої зп серед усіх країн 
-- 2. Пошук середньої зп по кожній країні
-- 3. Порівнюємо, виводимо перелік країн
-- 4. Cпеціалісти що проживають в цих країнах

-- 1
select 
 	round(avg(salary_in_usd), 2) as avg_salary
from salaries

-- 2 
select 
	comp_location
 	, round(avg(salary_in_usd), 2) as avg_salary
from salaries
group by 1

-- 3
select comp_location
 	, round(avg(salary_in_usd), 2) as avg_salary
from salaries
group by 1
having round(avg(salary_in_usd), 2) >
(	select 
 		round(avg(salary_in_usd), 2)
 	from salaries
);

-- дод у 2023 році
select comp_location
from salaries
where year = 2023
group by 1
having round(avg(salary_in_usd), 2) >
(	select 
 		round(avg(salary_in_usd), 2)
 	from salaries
 	where year = 2023
);

-- 4
select * -- 3 всі спеціалісти в країнах де сер зп > за сер серед усіх країн
from salaries
where emp_location in 
(
	select comp_location -- 2 пошук компаній по сер зп
	from salaries
	where year = 2023
	group by 1
	having round(avg(salary_in_usd), 2) >
	
(	select -- 1 пошук сер зп
 		round(avg(salary_in_usd), 2)
 	from salaries
 	where year = 2023
))

👉 Знайти мін зп серед макс зп по країнах 
-- 1 макс зп по країнах
-- 2 мін зп 

select 
	comp_location
	, max(salary_in_usd) as max_salary
from salaries
group by 1

-- 1
select 
	min(t.salary_in_usd) as max_salary
from 
(	
	select 
	comp_location
	, max(salary_in_usd) as salary_in_usd
	from salaries
	group by 1
) as t;

-- простіший варіант вирішення 
select 
	comp_location
	, max(salary_in_usd) as salary_in_usd
from salaries
group by 1
order by 2 asc
limit 1

👉 По кожній професії вивести різницю між сер зп та макс зп усіх спеціалістів
-- 1 Макс зп
-- 2 Таблиця професій і середніх зп
-- 3 Результат

-- 1
select max(salary_in_usd)
from salaries

--2 
select 
	job_title,
	avg(salary_in_usd),
	(select max(salary_in_usd)
	from salaries)
from salaries
group by job_title

-- 3
select 
	job_title,
	round(avg(salary_in_usd),2) - 
(	select max(salary_in_usd)
	from salaries
) as fiff
from salaries
group by job_title

👉 Вивести дані по співробітнику який отримує другу по розміру зп в таблиці

select *
from
(
	select*
	from salaries
	order by salary_in_usd desc
	limit 2
) as t
order by salary_in_usd asc
limit 1

-- альтернатива
select*
from salaries
order by salary_in_usd desc
limit 1 offset 1
	
👉 Дослідити всі колонки на наявність відсутніх значень, 
порівнявши кількість рядків таблиці з кількістю значень 
відповідної колонки

select count(*) as total_rows - к-сть рядків у таблиці
from salaries

select count(*) - count(salary_in_usd)
from salaries

👉 Порахувати кількість працівників в таблиці, які в 2023 році 
працюють на компанії розміру "М" і отримують з/п вищу 
за $100 000

select *
from salaries
limit 5

select count(*)
from salaries
where year = 2023
	and comp_size = 'M'
	and salary_in_usd > 100000

👉 Вивести всіх співробітників, які в 2023 отримували з/п 
більшу за $300тис

select 
	year 
	, salary_in_usd
from salaries
where year = 2023
	and salary_in_usd > 300000

👉 Вивести всіх співробітників, які в 2023 отримували з/п 
більшу за $300тис. та не працювали в великих компаніях

select*
from salaries

select distinct(comp_size)
from salaries

select *
from salaries
where year = 2023
	and salary_in_usd > 300000
	and comp_size != 'L'

👉 Чи є співробітники, які працювали на Українську компанію 
повністю віддалено?

select*
from salaries

select *
from salaries 
where remote_ration = 100
	and comp_location = 'UA'


👉 Вивести всіх співробітників, які в 2023 році 
працюючи в Німеччині (company_location = 'DE') 
отримували з/п більшу за $100тис

select *
from salaries
where 
	comp_location = 'DE'
	and year = 2023
	and salary_in_usd > 100000
	

👉 Доопрацювати попередній запит: Вивести з результатів 
тільки ТОП 5 співробітників за рівнем з/п

select *
from salaries
where 
	comp_location = 'DE'
	and year = 2023
	and salary_in_usd > 100000
order by salary_in_usd desc
limit 5

👉 Додати в попередню таблицю окрім спеціалістів з 
Німеччини спеціалістів з Канади (CA)

select *
from salaries
where 
	1=1
	and (comp_location = 'DE'
	or comp_location = 'CA')
	and year = 2023
	and salary_in_usd > 100000
order by salary_in_usd desc
limit 5

👉 Надати перелік країн, в яких в 2021 році 
спеціалісти "ML Engineer" та "Data Scientist" 
отримувати з/п в діапазоні між $50тис і $100тис

select comp_location
from salaries
where year = 2021
	and (job_title = 'ML Engineer'
	or job_title = 'Data Scientist')
	and salary_in_usd between 50000 and 100000
group by comp_location

👉 Порахувати кількість спеціалістів, які працюючи 
в середніх компаніях (company_size = M) та в великих 
компаніях (company_size = L) працювали віддалено 
(remote_ratio=100 або remote_ratio=50)

select count(*)
from salaries
where 1=1
	and comp_size in ('M', 'L')
	and (remote_ration=100
	or remote_ration=50)

👉 Вивести кількість країн, які починаються на "С"

select count(distinct comp_location) 
from salaries 
where comp_location like 'C%'

👉 Вивести професії, назва яких не складається з трьох слів
select job_title
from salaries
where job_title not like '% % %'

-- з 4 слів
select job_title
from salaries
where job_title like '% % % %'
