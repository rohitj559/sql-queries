-- 2. Creating altering and dropping a database 

--CREATE DATABASE Sample

--ALTER DATABASE Sample MODIFY NAME = SAMPLE1
--EXECUTE sp_renamedb'SAMPLE1', 'SAMPLE2'

--DROP DATABASE SAMPLE2
-- ---------------------------------------------------------
-- 3. Creating and working with Tables

use Sample
go
create table tblPerson
(
 Id int not null  primary key,
 Name nvarchar(50) not null,
 Email nvarchar(50) not null,
 GenderId int
)

create table tblGender
(
 ID int not null  primary key,
 Gender nvarchar(10) not null
)

drop table tblPerson

-- To add a foreign key reference using a query
Alter table tblPerson 
add constraint tblPerson_GenderId_FK FOREIGN KEY (GenderId) references tblGender(ID)

-- ---------------------------------------------------------------------------------







