select *
from Invoice i
limit 100

select *
from InvoiceLine il 
limit 100

select InvoiceLineId 
	, InvoiceId 
from InvoiceLine il 
order by InvoiceLineId DESC 

select *
from Track t 
limit 100

select *
from Album a 
limit 100

select *
from Track t 
join Album a on t.AlbumId = a.AlbumId 
limit 10

select t.TrackId
	, t.Name 
	, a.Title 
	, a. ArtistId 
	, art.Name 
from Track t 
join Album a on t.AlbumId = a.AlbumId 
join Artist art on a.ArtistId = art.ArtistId 
limit 10

select 
	 art.Name 
	 , count (t.TrackId)
from Track t 
join Album a on t.AlbumId = a.AlbumId 
join Artist art on a.ArtistId = art.ArtistId 
where art.Name like 'A%'
group by 1
order by 2 desc
limit 10


-- practice

select 
	il.InvoiceId 
	, g.GenreId 
	, c.CustomerId 
	, c.FirstName 
	, c.LastName 
from InvoiceLine il 
left join Track t on il.TrackId = t.TrackId 
left join Genre g on t.GenreId = g.GenreId 
left join Invoice i on il.InvoiceId = i.InvoiceId 
left join Customer c on i.CustomerId = c.CustomerId 

select 
	c.CustomerId 
	, c.FirstName 
	, c.LastName 
	, count(distinct g.GenreId) as nmb_genres
from InvoiceLine il 
left join Track t on il.TrackId = t.TrackId 
left join Genre g on t.GenreId = g.GenreId 
left join Invoice i on il.InvoiceId = i.InvoiceId 
left join Customer c on i.CustomerId = c.CustomerId 
group by 1,2,3
having count(distinct g.GenreId) >= 3


---
union
SELECT email
from Customer c 

union 

select email
from Employee e 


--
select
	'customer' as type
	, email
from Customer c 

union 

select 
	'employee' as type
	, email
from Employee e 

---
select
	'customer' as type
	, email
from Customer c 

union all

select 
	'employee' as type
	, email
from Employee e 

---
select
	'customer' as type
	, email
from Customer c 

intersect

select 
	'employee' as type
	, email
from Employee e 


---
select
	'customer' as type
	, email
from Customer c 

except

select 
	'employee' as type
	, email
from Employee e 


