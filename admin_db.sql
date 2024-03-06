select *
from information_schema.columns;


create table test (
	col_1 text,
	col_2 int
);

alter table test 
add column col_3 text;

alter table test 
rename column col_3 to col_4;

alter table test 
drop column col_4;

insert into test(col_1, col_2)
values ('text', 1)

create table text_copy as
select * from test t 

drop table text_copy 

drop table test 