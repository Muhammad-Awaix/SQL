-- DML

create database intermediate;
create table perosn1 (
	id int primary key auto_increment, 
    f_name varchar(20) not null,
    l_name varchar(20), 
    email varchar(30) not null,
    dob date not null
);

insert into perosn1 
values (
	1,'muhammad','awais', 'mawais10@gmail.com', '2000-10-21');
    
-- change the table name
rename table perosn1 to person1;
-- change the column names
alter table person1 rename column f_name to fname;
alter table person1 rename column l_name to lname;

select * from person1;

-- adding new column to a database
alter table person1 
add column is_placed bool not null default false;

alter table person1
add column phone int (20) unique;

-- Delete columns in table 
alter table person1 
drop column phone;

insert into person1 (fname, lname, email, dob, is_placed)
values ('ali', 'raza', '   aliraza@gmail.com', '2003-01-10',false),
	   ('  hamza', '', 'hamza@gmail','2001-10-30',true),
       ('murtza','saeed','murtza10@gmail.com', '2002-12-30', true),
       ('muhammad  ', 'rizwan','rizwan.com', '1996-01-23',false),
       ('sayed', '', 'sayed20@gmail.com', '1999-07-12', false);

select * from person1;

insert into person1 (fname, lname, email, dob, is_placed)
values 
       ('zeeshan', null, 'zeeshan20@.com', '2004-07-12', true);

select * from person1;

update person1 
set fname  = trim(upper(fname));

update person1
set lname = trim(upper(lname)),
email = trim(email);

-- show the table structure
describe person1;

create table person2 like 
person1;

show databases;
use intermediate;
-- copy data from other database
create table intermediate.person3 like basics.person1;
insert into intermediate.person3 (select * from basics.person1);
select * from person3;

drop table basics.person2;
drop table basics.person1;

use intermediate;
rename table person3 to employee;

select * from employee;

update employee
set lname = upper('ahsan')
where id = 6;

alter table employee add column correct_info bool not null default false;

update employee
set correct_info = true
where lname is not null;

alter table employee 
drop column correct_info;

-- use of like 
select *,
case
	when email like '%@gmail.com' then 1
    else 0
end as is_gmail
from employee;

delete from employee 
where lname  = '';

select * from employee;

select count(is_placed) from employee
group by is_placed;

