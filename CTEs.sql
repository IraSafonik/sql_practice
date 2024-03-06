with melomaniacs as (

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
)

select *
from melomaniacs

--
with melomaniacs as (

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
)

, invoices as (
	select *
	from Invoice i 
	where InvoiceDate BETWEEN '2008-01-01' and '2009-01-01'
)

select *
FROM melomaniacs m
left join invoices i on m.CustomerId = i.CustomerId
where i.CustomerId is not null


--
with melomaniacs as (

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
)

, invoices as (
	select *
	from Invoice i 
	where InvoiceDate BETWEEN '2008-01-01' and '2009-01-01'
)

select *
FROM melomaniacs m
where m.CustomerId in (select CustomerID from Invoices)

