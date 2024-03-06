select *
from invoice

select 
	InvoiceDate 
	, Total 
	, sum(Total) over(order by invoicedate) as cum_sum
from invoice

--
select 
	invoiceid, 
	customerid,
	total,
	row_number() over(order by total desc) as invoice_nmb,
	rank() over(order by total desc) as invoice_rank,
	DENSE_RANK() over(order by total desc) as invoice_rank
from Invoice i 
order by customerid

--
with cte as (
select 
	invoiceid, 
	customerid,
	total,
	row_number() 	over(PARTITION by customerid order by total desc) as invoice_nmb,
	rank() 			over(PARTITION by customerid order by total desc) as invoice_rank,
	DENSE_RANK() 	over(PARTITION by customerid order by total desc) as invoice_rank
from Invoice i 
order by customerid
)
select*
from cte
where invoice_nmb = 2


--

select 
	InvoiceId 
	, CustomerId 
	, InvoiceDate 
	, Total 
	, LAG(total, 1) over(PARTITION by CustomerId ORDER by invoicedate) as lag_total
	, LAG(invoicedate, 1) over(PARTITION by CustomerId ORDER by invoicedate) as lag_total
	, JULIANDAY(invoicedate) -  JULIANDAY(LAG(invoicedate, 1) over(PARTITION by CustomerId ORDER by invoicedate)) as diff_in_day 
	, LEAD(total, 1) over(PARTITION by CustomerId ORDER by invoicedate) as lead_total
from invoice
order by CustomerId 


--
select 
	InvoiceId 
	, CustomerId 
	, InvoiceDate 
	, Total 
	, FIRST_VALUE(Total) over(PARTITION by CustomerId ORDER by invoicedate asc) as first_amount
	, LAST_VALUE(Total) over(PARTITION by CustomerId ORDER by invoicedate asc) as last_amount
from invoice
