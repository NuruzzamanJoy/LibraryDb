-- LIBRARY PROJECT --
-- DDL --

drop database LibraryDB
create database LibraryDB
on primary
(Name= 'LibraryDB_Data_1',
filename= 'J:\C#\1277673\LibraryDB_Data_1.mdf',
size= 25mb,
maxsize= 100mb,
filegrowth= 5% )

log on
(Name= 'LibraryDB_Log_1',
filename= 'J:\C#\1277673\LibraryDB_Log_1.ldf',
size= 25mb,
maxsize= 100mb,
filegrowth= 5% );

use LibraryDB

create table authors
(authorid int primary key,
authorname varchar (50) );

create table books
(bookid int primary key,
bookname varchar (50) );

create table Publishers
(publisherid int primary key,
publishername varchar (50) );

create table titles
( titleid int primary key,
titlename varchar (50) ,
authorid int references authors(authorid),
bookid int references books(bookid),
publisherid int references publishers(publisherid),
borrowingdate date,
returndate date,
available varchar (50) );

--  view of author information - create view with encryption--
create view vw_authors
with encryption
as
select * from authors

select * from vw_authors

--  view of books information - create view with schemabinding --
create view vw_books
with schemabinding
as
select bookname from dbo.books

select * from vw_books

--  view of titles information - create view with enryption schemabinding together --
create view vw_titles
with encryption, schemabinding
as
select titleid, titlename from dbo.titles

select * from vw_titles

-- Remove Author Information --
select * into authorx from authors
select * from authorx
delete  authorx where authorid= 2

drop table authorx

-- Update Book Name --
Update books set bookname= 'C#' where bookname= 'Programming, C#'



--  Remove publishername  --
Alter table publishers
drop column publishername

-- backup books information- Trigger --
create table bookstbl
(bookid int primary key,
bookname varchar (50) );

create table backtblbooks
(bookid int primary key,
bookname varchar (50) );

create trigger tr_books on bookstbl
after insert, update
as
insert into backtblbooks
(bookid ,bookname )
select 
i. bookid, i.bookname from inserted i;



select * from bookstbl
select * from backtblbooks

