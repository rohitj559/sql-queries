-- 2. Creating altering and dropping a database 

--CREATE DATABASE Sample

--ALTER DATABASE Sample MODIFY NAME = SAMPLE1
--EXECUTE sp_renamedb'SAMPLE1', 'SAMPLE2'

--DROP DATABASE SAMPLE2
-- ---------------------------------------------------------
-- 3. Creating and working with Tables

--use Sample
--go
--create table tblPerson
--(
-- Id int not null  primary key,
-- Name nvarchar(50) not null,
-- Email nvarchar(50) not null,
-- GenderId int,
-- Age int
--)

--create table tblGender
--(
-- ID int not null  primary key,
-- Gender nvarchar(10) not null
--)

--drop table tblPerson

-- To add a foreign key reference using a query
--Alter table tblPerson 
--add constraint tblPerson_GenderId_FK FOREIGN KEY (GenderId) references tblGender(ID)

-- ---------------------------------------------------------------------------------
-- Default constraint in sql server - Part 4

--ALTER TABLE tblPerson
--ADD CONSTRAINT DF_tblPerson_GenderId
--DEFAULT 3 FOR GenderId

--select * from tblPerson
--Insert into tblPerson(ID,Name,Email, GenderId) values(9,'Robo','ro@ro.com', null)

--ALTER TABLE tblPerson 
--DROP CONSTRAINT DF_tblPerson_GenderId

------------------------------------------------------------------------------------
-- Cascading referential integrity constraint - Part 5

--delete from tblPerson where GenderId = 3

------------------------------------------------------------------------------------
--Check constraint in SQL Server - Part 6

--insert into tblPerson values(1,'Robo','r@r.com', null, 12)
--insert into tblPerson values(2,'Aobo','a@a.com', null, 13)
--insert into tblPerson values(3,'mobo','m@m.com', null, 14)
--insert into tblPerson values(4,'tobo','t@t.com', null, 15)
--insert into tblPerson values(5,'lobo','l@l.com', null, 16)
--insert into tblPerson values(7,'sobo','s@s.com', null, 17)

--ALTER TABLE tblPerson
--ADD CONSTRAINT CK_tblPerson_Age CHECK (Age > 0 AND Age < 150)

--Testing
--insert into tblPerson values(8,'sobo','s@s.com', null, 175)

--ALTER TABLE tblPerson
--DROP CONSTRAINT CK_tblPerson_Age

-------------------------------------------------------------------
-- Identity column in SQL Server - Part 7

--Create Table tblPerson1
--(
--PersonId int Identity(1,1) Primary Key,
--Name nvarchar(20)
--)

--select * from tblPerson1

--Insert into tblPerson1 values ('Sam')
--Insert into tblPerson1 values ('Sara')

--select * from tblPerson1

--Insert into tblPerson1 values (1,'Todd')

--Insert into tblPerson1 values ('Todd')

--select * from tblPerson1

--delete from tblPerson1 where PersonId = 1
--select * from tblPerson1

--SET Identity_Insert tblPerson1 ON
--Insert into tblPerson1(PersonId, Name) values(1, 'John')
--select * from tblPerson1

--delete  from tblPerson1
--select * from tblPerson1
--SET Identity_Insert tblPerson1 OFF
--Insert into tblPerson1 values ('Todd')
--select * from tblPerson1

--DBCC CHECKIDENT(tblPerson1, RESEED, 0)
--select * from tblPerson1
--Insert into tblPerson1 values ('Todd')
--select * from tblPerson1

-----------------------------------------------------------------------------
-- How to get the last generated identity column value in SQL Server - Part 8

--SCOPE_IDENTITY() - returns the last identity value that is created in the same session and in the same scope.
--@@IDENTITY - returns the last identity value that is created in the same session and across any scope.
--IDENT_CURRENT('TableName') - returns the last identity value that is created for a specific table across any session and any scope.

------------------------------------------------------------------------------
-- Unique key constraint - Part 9

--create table tblPerson3 
--(
--	ID int primary key,
--	Name varchar(10)
--)
--insert into tblPerson3 values (1, 'roro')

--Alter Table tblPerson3
--Add Constraint UN_tblPerson3_Name Unique(Name)

--insert into tblPerson3 values (1, 'roro')
--insert into tblPerson3 values (2, 'poro')
--select * from tblPerson3

---------------------------------------------------------------------------------

--Select statement - Part 10




















