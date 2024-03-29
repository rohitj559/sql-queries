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

--To Select distinct rows use DISTINCT keyword
--SELECT DISTINCT Column_List
--FROM Table_Name

--Example: Select distinct city from tblPerson

--Filtering rows with WHERE clause
--SELECT Column_List
--FROM Table_Name
--WHERE Filter_Condition

--------------------------------------------------------------------------------
-- Group By - Part 11
use Sample 
GO
drop table tblEmployee

use Sample 
GO
create table tblEmployee
(
	ID int Identity(1,1) primary key,
	Name nvarchar(20),
	Gender nvarchar(10),
	Salary int,
	City nvarchar(20)
)

SET Identity_Insert tblEmployee OFF

insert into tblEmployee values ('aoro', 'male', 4500, 'hongkong');
insert into tblEmployee values ('porp', 'female', 7500, 'london');
insert into tblEmployee values ('xoro', 'male', 3500, 'massachussets');
insert into tblEmployee values ('uoro', 'female', 2500, 'japan');
insert into tblEmployee values ('poro', 'female', 5500, 'florida');
insert into tblEmployee values ('boro', 'female', 1100, 'chicago');
select * from tblEmployee

select city, sum(salary) as Salary 
from tblEmployee
group by city

select City, Gender, sum(Salary) as Salary 
from tblEmployee
group by City, Gender
order by City

select Gender, City, sum(Salary) as Salary 
from tblEmployee
group by City, Gender
order by City

select count(ID) from tblEmployee
select Gender, City, sum(Salary) as Salary, count(ID) as [No of Employees]
from tblEmployee
group by City, Gender
order by City

select count(ID) from tblEmployee
select Gender, City, sum(Salary) as Salary, count(ID) as [No of Employees]
from tblEmployee
where Gender = 'female'
group by City, Gender

select count(ID) from tblEmployee
select Gender, City, sum(Salary) as Salary, count(ID) as [No of Employees]
from tblEmployee
group by City, Gender
having Gender = 'female'

-----------------------------------------------------------------------------------
--Joins in sql server - Part 12

drop table tblEmployee

create table tblEmployee
(
	ID int Identity(1,1) primary key,
	Name nvarchar(20),
	Gender nvarchar(20),
	Salary int,
	DepartmentId int
)

create table tblDepartment
(
	Id int Identity(1,1) primary key,
	DepartmentName nvarchar(20),
	Location nvarchar(20),
	DepartmentHead nvarchar(20)
)

Alter table tblEmployee 
add constraint tblEmployee_DepartmentId_FK FOREIGN KEY (DepartmentId) references tblDepartment(Id)

insert into tblDepartment values ('IT', 'London', 'Rick')
insert into tblDepartment values ('Payroll', 'Delhi', 'Ron')
insert into tblDepartment values ('HR', 'New York', 'Christie')
insert into tblDepartment values ('Other Department', 'Sydney', 'Cindrella')

select * from tblDepartment
select * from tblEmployee

drop table tblDepartment
drop table tblEmployee


insert into tblEmployee values ('Tom', 'Male', 4000, 1)
insert into tblEmployee values ('Pam', 'Female', 3000, 3)
insert into tblEmployee values ('John', 'Male', 3500, 1)
insert into tblEmployee values ('Sam', 'Male', 4500, 2)
insert into tblEmployee values ('Todd', 'Male', 2800, 2)
insert into tblEmployee values ('Ben', 'Male', 7000, 1)
insert into tblEmployee values ('Sara', 'Female', 4800, 3)
insert into tblEmployee values ('Valarie', 'Female', 5500, 1)
insert into tblEmployee values ('James', 'Male', 6500, NULL)
insert into tblEmployee values ('Russell', 'Male', 8800, NULL)

select Name, Gender, Salary, DepartmentName
from tblEmployee emp
inner join tblDepartment dept
on emp.DepartmentId = dept.Id

select Name, Gender, Salary, DepartmentName
from tblEmployee emp
left outer join tblDepartment dept
on emp.DepartmentId = dept.Id

select Name, Gender, Salary, DepartmentName
from tblEmployee emp
right outer join tblDepartment dept
on emp.DepartmentId = dept.Id

select Name, Gender, Salary, DepartmentName
from tblEmployee emp
full join tblDepartment dept
on emp.DepartmentId = dept.Id

select Name, Gender, Salary, DepartmentName
from tblEmployee emp
cross join tblDepartment dept

----------------------------------------------------------------------
--Self join in sql server - Part 14

create table tblEmployee1
(
	ID int Identity(1,1) primary key,
	Name nvarchar(20),
	ManagerID int
)

insert into tblEmployee1 values ('Mike', 3)
insert into tblEmployee1 values ('Rob', 1)
insert into tblEmployee1 values ('Todd', NULL)
insert into tblEmployee1 values ('Ben', 1)
insert into tblEmployee1 values ('Sam', 1)

select * from tblEmployee1

select emp.Name as Employee, mgr.Name as Manager
from tblEmployee1 emp
join tblEmployee1 mgr
on emp.ManagerID = mgr.ID

----------------------------------------------------------------
--Different ways to replace NULL in sql server - Part 15

select emp.Name as Employee, mgr.Name as Manager
from tblEmployee1 emp
left outer join tblEmployee1 mgr
on emp.ManagerID = mgr.ID

select emp.Name as Employee, ISNULL(mgr.Name, 'No Manager') as Manager
from tblEmployee1 emp
left outer join tblEmployee1 mgr
on emp.ManagerID = mgr.ID

select emp.Name as Employee, ISNULL(mgr.Name, 'No Manager') as Manager
from tblEmployee1 emp
left outer join tblEmployee1 mgr
on emp.ManagerID = mgr.ID

select emp.Name as Employee, 
	case 
		when mgr.Name is null then 'No Manager' else mgr.Name
	end
from tblEmployee1 emp
left outer join tblEmployee1 mgr
on emp.ManagerID = mgr.ID

select emp.Name as Employee, COALESCE(mgr.Name, 'No Manager') as Manager
from tblEmployee1 emp
left outer join tblEmployee1 mgr
on emp.ManagerID = mgr.ID

------------------------------------------------------------------------------
--Coalesce() function in sql server - Part 16

create table tblEmployee3
(
	Id int Identity(1,1) primary key,
	FirstName nvarchar(20),
	MiddleName nvarchar(20),
	LastName nvarchar(20),
)

insert into tblEmployee3 values ('Sam', NULL, NULL)
insert into tblEmployee3 values (NULL, 'Todd', 'Tanzan')
insert into tblEmployee3 values (NULL, NULL, 'Sara')
insert into tblEmployee3 values ('Ben', 'Parker', NULL)
insert into tblEmployee3 values ('James', 'Nick', 'Nancy')

select * from tblEmployee3

select COALESCE(FirstName, MiddleName, LastName)
from tblEmployee3

-------------------------------------------------------------------------
-- Union and union all in sql server - Part 17

create table tblIndiaCustomers
(
	Id int Identity(1,1) primary key,
	Name nvarchar(20),
	Email nvarchar(20),
)

create table tblUKCustomers
(
	Id int Identity(1,1) primary key,
	Name nvarchar(20),
	Email nvarchar(20),
)

insert into tblIndiaCustomers values ('Raj', 'r@r.com')
insert into tblIndiaCustomers values ('sam', 's@s.com')
insert into tblUKCustomers values ('Ben', 'b@b.com')
insert into tblUKCustomers values ('sam', 's@s.com')

select * from tblIndiaCustomers
select * from tblUKCustomers

delete from  tblIndiaCustomers
delete from tblUKCustomers

select * from tblIndiaCustomers
UNION ALL
select * from tblUKCustomers

select * from tblIndiaCustomers
UNION
select * from tblUKCustomers

-----------------------------------------------------------------------------
-- Stored procedures - Part 18
use sample
go
create procedure spGetEmployees
as
begin
	select * from tblEmployee
end

exec spGetEmployees


create proc spGetEmployeeByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentID int
as
begin
	select name, gender, DepartmentId 
	from tblEmployee 
	where Gender = @Gender
	and DepartmentID = @DepartmentID
end

exec spGetEmployeeByGenderAndDepartment @Gender = 'male', @DepartmentID = 1
exec spGetEmployeeByGenderAndDepartment @Gender = 'female', @DepartmentID = 1

sp_helptext spGetEmployeeByGenderAndDepartment

use sample
go
alter procedure spGetEmployees
as
begin
	select * from tblEmployee 
	order by name
end

exec spGetEmployees
drop proc spGetEmployees

use sample
go
alter procedure spGetEmployees
with encryption
as
begin
	select * from tblEmployee 
	order by name
end

sp_helptext spGetEmployees

-----------------------------------------------------------
-- Stored procedures with output parameters - Part 19

Create Procedure spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int Output
as
Begin
 Select @EmployeeCount = COUNT(Id) 
 from tblEmployee 
 where Gender = @Gender
End 

Declare @EmployeeTotal int
Execute spGetEmployeeCountByGender 'Female', @EmployeeTotal output
Print @EmployeeTotal

Declare @EmployeeTotal int
Execute spGetEmployeeCountByGender 'Female', @EmployeeTotal
if(@EmployeeTotal is null)
 Print '@EmployeeTotal is null'
else
 Print '@EmployeeTotal is not null'

Declare @EmployeeTotal int
Execute spGetEmployeeCountByGender @EmployeeCount = @EmployeeTotal OUT, @Gender = 'Male'
Print @EmployeeTotal

sp_help spGetEmployeeCountByGender
sp_depends spGetEmployeeCountByGender

------------------------------------------------------------------------------------------
-- Stored procedure output parameters or return values - Part 20

create Procedure spGetTotalCountOfEmployees1
@TotalCount int output
as
Begin
 Select @TotalCount = COUNT(ID) from tblEmployee
End			

Declare @TotalEmployees int
Execute spGetTotalCountOfEmployees1 @TotalEmployees Output
Select @TotalEmployees

Create Procedure spGetTotalCountOfEmployees2
as
Begin
 return (Select COUNT(ID) from Employees)
End

alter Procedure spGetTotalCountOfEmployees2
as
Begin
 return (Select COUNT(ID) from tblEmployee)
End

Declare @TotalEmployees int
Execute @TotalEmployees = spGetTotalCountOfEmployees2
Select @TotalEmployees

Create Procedure spGetNameById1
@Id int,
@Name nvarchar(20) Output
as
Begin
 Select @Name = Name from tblEmployee Where Id = @Id
End

Declare @EmployeeName nvarchar(20)
Execute spGetNameById1 3, @EmployeeName out
Print 'Name of the Employee = ' + @EmployeeName

Create Procedure spGetNameById2
@Id int
as
Begin
 Return (Select Name from tblEmployee Where Id = @Id)
End

Declare @EmployeeName nvarchar(20)
Execute @EmployeeName = spGetNameById2 1
Print 'Name of the Employee = ' + @EmployeeName

------------------------------------------------------------------------------
--Built in string functions in sql server 2008 - Part 22

Select ASCII('A')

Declare @Number int
Set @Number = 1
While(@Number <= 255)
Begin
 Print CHAR(@Number)
 Set @Number = @Number + 1
End

Declare @Number int
Set @Number = 65
While(@Number <= 90)
Begin
 Print CHAR(@Number)
 Set @Number = @Number + 1
End

Declare @Number int
Set @Number = 97
While(@Number <= 122)
Begin
 Print CHAR(@Number)
 Set @Number = @Number + 1
End

Declare @Number int
Set @Number = 65
While(@Number <= 90)
Begin
 Print LOWER(CHAR(@Number))
 Set @Number = @Number + 1
End

Select LTRIM('   Hello')

Select RTRIM('Hello   ')

Select LTRIM(RTRIM('   Hello   '))

Select LOWER('CONVERT This String Into Lower Case')

Select UPPER('CONVERT This String Into upper Case')

Select REVERSE('ABCDEFGHIJKLMNOPQRSTUVWXYZ')

Select LEN('SQL Functions   ')

-------------------------------------------------------------------
--LEFT, RIGHT, CHARINDEX and SUBSTRING functions - Part 23

Select LEFT('ABCDE', 3)
Select RIGHT('ABCDE', 3)
CHARINDEX('@','sara@aaa.com',1)
Select SUBSTRING('John@bbb.com',6, 7)
Select SUBSTRING('John@bbb.com',(CHARINDEX('@', 'John@bbb.com') + 1), (LEN('John@bbb.com') - CHARINDEX('@','John@bbb.com')))

select * from tblPerson
insert into tblPerson values (14,'Robo', 'a@a.com', null, 10)

select SUBSTRING(Email,(CHARINDEX('@', Email) + 1), (LEN(Email) - CHARINDEX('@',Email))) as EmailDomain, 
count(*) as Total
from tblPerson
group by Email

-----------------------------------------------------------------------------------------------------------------
--Replicate, Space, Patindex, Replace and Stuff functions - Part 24

SELECT REPLICATE('Pragim', 3)

declare @email nvarchar(50)
set @email = 'ram@aaa.com'
select CHARINDEX('@',@email)+1
select LEN(@email) - CHARINDEX('@',@email)+1
select SUBSTRING(@email, CHARINDEX('@',@email), LEN(@email) - CHARINDEX('@',@email)+1)

select (SUBSTRING(@email, 1, 2) + REPLICATE('*',5) + 
SUBSTRING(@email, CHARINDEX('@',@email), LEN(@email) - CHARINDEX('@',@email)+1))

select 'rohit' + space(5) + 'jagannath'

select * from tblPerson
Select Email, PATINDEX('%@a.com', Email) as FirstOccurence 
from tblPerson
Where PATINDEX('%@a.com', Email) > 0

Select Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
from  tblPerson

Select Email, STUFF(Email, 2, 3, '*****') as StuffedEmail
From tblPerson

------------------------------------------------------------------------------------------
--DateTime functions in SQL Server - Part 25

CREATE TABLE [tblDateTime]
(
 [c_time] [time](7) NULL,
 [c_date] [date] NULL,
 [c_smalldatetime] [smalldatetime] NULL,
 [c_datetime] [datetime] NULL,
 [c_datetime2] [datetime2](7) NULL,
 [c_datetimeoffset] [datetimeoffset](7) NULL
)

select * from [tblDateTime]

INSERT INTO tblDateTime VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())

---------------------------------------------------------------------------------------------
--IsDate, Day, Month, Year and DateName DateTime functions in SQL Server - Part 26






















