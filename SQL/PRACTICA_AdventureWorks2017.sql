--Practica:
use AdventureWorks2017
--Consulta
select * from Person.Person
select x.BusinessEntityID,x.PersonType,x.NameStyle
from Person.Person as x
select Person.Person.BusinessEntityID
from Person.Person
select *
from Person.Person as a
where a.LastName = 'Sánchez' and a.EmailPromotion = 1
select *
from Person.Person as a 
where a.LastName = 'Sánchez' and  a.ModifiedDate = '2013-11-05 00:00:00.000'
-- Cuando usas funciones de agregacion(count,sum,min,max,avg) siempre se va usar  el group by y having
select a.Color , SUM(a.ListPrice) as 'Sumatoria x colores'
from Production.Product as a
group by a.Color
having SUM(a.ListPrice) >=10000
order by SUM(a.ListPrice) DESC
select * from Production.Product
select * 
from Production.Product as a
where a.ProductID >= 1 and a.ProductID <= 2
-- Top indica visualizar el top 
select TOP 50 PERCENT *
From Production.Product
select a.JobTitle,COUNT(*) as 'Cantidad de Personas que trabajan'
from HumanResources.Employee AS a
group by a.JobTitle
order by a.JobTitle desc
select * from HumanResources.Employee
-- inner join :Uniones de Tablas:
select tb1.PersonType,tb1.NameStyle,tb1.FirstName,tb1.LastName,tb2.PhoneNumber as 'Nombre Celular',tb3.Name
from Person.Person as tb1 join Person.PersonPhone as tb2
on(tb1.BusinessEntityID = tb2.BusinessEntityID)  join Person.PhoneNumberType as tb3
on(tb2.BusinessEntityID = tb3.PhoneNumberTypeID)
select *  from Person.Person
select *  from Person.PersonPhone
select *  from HumanResources.Employee
-- join left :
select tb1.BusinessEntityID,tb2.BusinessEntityID,tb1.FirstName,tb2.JobTitle
from Person.Person as tb1 left join HumanResources.Employee as tb2
on (tb1.BusinessEntityID = tb2.BusinessEntityID)
-- join rigth:
select tb1.JobTitle ,tb2.FirstName
from HumanResources.Employee as tb1 right  join Person.Person as tb2
on(tb2.BusinessEntityID = tb1.BusinessEntityID)
--Agregacion(Sum) --categorias(nodeterminista e determinista)
select * from Production.ProductInventory
select * from Production.Product
select tb2.ProductModelID,tb2.Name,SUM(tb1.Quantity) as 'Cantidad de Venta de Producto'
from Production.ProductInventory as tb1 join Production.Product as tb2
on(tb1.ProductID = tb2.ProductID)
group by tb2.Name
--
select tb1.EmailPromotion , COUNT(tb1.EmailPromotion) AS 'Cantidad de Email de los Empleados'
from Person.Person as tb1 
group by tb1.EmailPromotion
--Funcion para obtener la fecha y la hora del servidor:
select GETDATE()
select * from Person.Person as tb1

select tb1.Title,COUNT(tb1.Title) as 'Cantidad' 
from Person.Person as tb1
group by tb1.Title
having tb1.Title is not null 
select tb1.LastName,COUNT(tb1.LastName) as Cantidad
from Person.Person as tb1
group by tb1.LastName
select tb1.Title,COUNT(isnull(Title,0)) as Cantidad
from Person.Person as tb1
group by tb1.Title
select tb1.Color,COUNT(tb1.Color) AS 'Promedio'
from Production.Product as tb1
group by tb1.Color
having tb1.Color is not null
select MIN(tb1.ModifiedDate) as Minimo,
Max(tb1.ModifiedDate) as Maximo
from Person.Password as tb1

select tb1.JobTitle , AVG(tb1.VacationHours) as 'Promedio'
from HumanResources.Employee as tb1
group by tb1.JobTitle
having tb1.JobTitle = 'Production Technician - WC50'

select SUM(tb1.SalesYTD) as 'SumaTotal'
from Sales.SalesPerson as tb1
having TerritoryID is not null 
select Max(tb1.Bonus) as Maximo,MIN(tb1.Bonus) as Minimo 
from  Sales.SalesPerson as tb1
--Cast = cambia el tipo de dato
select CAST(tb1.ModifiedDate as Date) as Fecha,
CAST(tb1.MakeFlag as float) as 'Decimal',
Cast(tb1.MakeFlag as varbinary) as Varbinary
from Production.Product as tb1
select * 
from Production.Product
where CAST(ModifiedDate as Date) ='2014-02-08'
select CONVERT(Date,tb1.ModifiedDate) as 'Fecha',
Convert(varchar,tb1.MakeFlag) as CambiodeDatoAVarchar
from Production.Product as tb1
--Funcion para cambiar tipo de datos en date
select PARSE('Friday,14 December 2018' as date) as  Fecha 

select GETDATE()
select cast(getdate() as date) as Fecha
select dateadd(Month,-1,GETDATE()) as CambiodeMesDeFechaActual
select DATEADD(day,+5,getdate())
select DATEADD(year,+1,getdate())
select DATEADD(MINUTE,+5,getdate())
select DATEADD(HOUR,+5,getdate())

select *
from Production.Product as tb1
where cast(tb1.SellEndDate as date) between '2012-05-30' and DATEADD(year,2,'2012-05-30')

select SYSDATETIME()
set language SPANISH SELECT DATENAME(MONTH,GETDATE()) as Fecha
SELECT DATENAME(WEEKDAY,GETDATE()) as Dia

SELECT  YEAR(tb1.SellStartDate) as Años
FROM Production.Product AS tb1
SELECT MONTH(GETDATE())
SELECT DAY(GETDATE())

SELECT Concat(tb1.FirstName,' ',tb1.LastName) as 'Nombre  y Apellidos'
FROM Person.Person as tb1
select tb1.Title,CONCAT(tb1.Title,' ',tb1.FirstName,' ',tb1.MiddleName) as Nombres,
LEN(concat(tb1.Title,tb1.FirstName)) as Cantidad
from Person.Person as tb1
select CONCAT_WS(' ',tb1.FirstName,tb1.MiddleName) as 'NomyAp'
from Person.Person as tb1
select left(tb1.rowguid,(10)) as Informacion
from Person.EmailAddress as tb1

select * from Person.EmailAddress
select distinct right(tb1.EmailAddress,20) as Email 
from Person.EmailAddress as tb1
group by  tb1.EmailAddress
--para quitar espacios ltrim() = izquierda rtrim()derecha
select LTRIM(tb.Nombre) as Nuevo
from(
select concat('          ',a.Title,' ' ,a.FirstName,' ',a.MiddleName) as Nombre
from Person.Person as a) as tb
select replace(tb1.EmailAddress,'@adventure-works.com','@nuevo_correo.com') as Cambio
from Person.EmailAddress as tb1
select * from Production.Product as tb1
where tb1.Size = '58' and tb1.StandardCost < 350
select *
from Person.Person as tb1
where tb1.FirstName like 'terri'
select *
from Production.Product as tb1
where tb1.Name like '[HexNut]%' and tb1.ProductNumber like '%[62]'
select *
from Production.Product as tb1
where tb1.Name like '%ace'
select *
from Production.Product as tb1
where tb1.Name not like '%[a_n]ring'
create table #tb_telefono(
	id_Tel int Primary key,
	Nombre varchar(100))
create table #tb_personal(
	Id int primary key,
	Nombre varchar(100),
	Cedula int not null,
	Id_Tel int foreign key references tb_telefono(id_Tel))
drop table #tb_personal
drop table #tb_telefono
insert into tb_telefono values
	(1,'Celular'),
	(2,'Casa'),
	(3,'Oficina')
select * from tb_telefono
select * from tb_personal
insert into tb_personal values
	(1,'Alex',123,1),
	(2,'Diana',145,2)
insert into tb_personal(Id,Nombre,Cedula,Id_Tel)values(8,'Lucas',4,2)
select tb1.Nombre,tb2.Nombre as NombredelTelefono ,tb3.FirstName
from tb_personal as tb1 join tb_telefono as tb2
on(tb1.Id_Tel = tb2.Id_Tel) join tbEjemplo as tb3
on(tb1.Id = tb3.BusinessEntityID)
--	truncate eliminar datos de la tabla (en general)
truncate table tb_personal
drop table tb_personal
delete from tb_personal where  Nombre = 'Diana'
select * from Person.Person as  tb1
where tb1.EmailPromotion = 1
--creacion de tabla con un contenido que ya existe
select *
into tbEjemplo45
from Person.Person as tb1
where tb1.EmailPromotion = 1
select * from tbEjemplo45
-- insert valores de otra tabla
insert into tbEjemplo45 select * from Person.Person as tb1 where tb1.EmailPromotion = 1
truncate table tbEjemplo45
select CONCAT_WS(' ',tb2.FirstName,tb2.MiddleName) as 'Nombre',tb1.NationalIDNumber,tb1.HireDate
into ##Base
from HumanResources.Employee as tb1 join Person.Person as tb2
on(tb1.BusinessEntityID = tb2.BusinessEntityID)
where tb1.HireDate between  '2008-01-01' and '2008-06-30'
order by tb1.HireDate asc
select * from ##Base
-- views tu consulta se convierte en una tabla
SELECT * FROM sys.views
create view v_TablaPersona as 
select *
from Person.Person as tb1 where tb1.PersonType = 'EM'
select * from  v_TablaPersona

select * from sys.procedures
drop procedure sp_Employee89
create procedure sp_Employee89
@Marital varchar(10)
as
begin
	select tb1.BusinessEntityID,tb1.NationalIDNumber,tb1.LoginID,tb1.MaritalStatus
	from HumanResources.Employee as tb1
	where tb1.MaritalStatus = @Marital

end
exec sp_Employee89 'S'
drop procedure sp_Employe56
create procedure sp_Employe56
as
declare @Fecha Date
set @Fecha = '2009-01-14'
begin
	select *
	from HumanResources.Employee as tb1
	where tb1.HireDate = @Fecha
end
exec sp_Employe56
--Set Nocount 
drop procedure sp_Employe96368
create procedure sp_Employe96368 @fecha1 date,@fecha2 date
as
set NOCOUNT ON 
begin 
	truncate table Employee
	INSERT INTO Employee
	select tb1.BusinessEntityID,tb1.NationalIDNumber,tb1.LoginID
	from HumanResources.Employee as tb1
	where tb1.HireDate between @fecha1 and @fecha2	
end
exec sp_Employe96368 '2009-01-14' ,'2019-08-11'

select tb1.BusinessEntityID,tb1.NationalIDNumber,tb1.LoginID
into Employee
from HumanResources.Employee as tb1
select * from Employee

CREATE TABLE pers(
	Nombre Varchar(100),
	Apellido varchar(100),
	Telefono int)
insert into pers values
	('miguel','mallqui',9874561),
	('angel','mallqui',795426123)
-- formato metalenguaje
select * 
from pers for xml auto 
select * from pers for  xml raw,elements,root
select * from pers for xml raw('Registro') , elements, root('Raiz')

create table Prueba(id int)
insert into Prueba values(10),(12)
select * from Prueba
begin transaction 
update Prueba set id = 20 where id = 10
rollback transaction 
commit transaction
begin transaction
update Person.Person set Title  = 'Nuevo' where EmailPromotion = 1 
select * from Person.Person
rollback transaction
commit transaction 
--trigger
create table Base(Codigo int , NombreCiudad varchar(100),NombreDepartamente varchar(100))
insert into Base values
	(1,'Comas','Lima'),
	(2,'Libertad','Lima')
select * from Base
create trigger Base_Insertar
on Base
after insert 
as
begin
set nocount  on 
select * from  Base
end
drop trigger Base_Insertar
insert into Base values(9,'Callao','Lima')
create table Logs(fecha Date,Hora Time,Nombre varchar(100),Descriocpion varchar(100))
create trigger Logsx
on Base
after insert 
as
begin
	 print ' Se realizo una accion de Insert'
	 set Nocount on 
	 insert into Logs(fecha,Hora,Nombre,Descriocpion)values (GETDATE(),SYSDATETIME(),@@SERVERNAME,'Inserto')
	 select * from Logs
end
drop  trigger Logsx
select * from Logs
insert into Base values(12,'Olivos','Lima')
create trigger Actu
on Base
after update
as
begin
	print 'Se realizo una accion de Update'
	set Nocount on
	insert into Logs(fecha,Hora,Nombre,Descriocpion)values (GETDATE(),SYSDATETIME(),@@SERVERNAME,'Update')
	select * from Logs

end
update Base set NombreCuidad = 'Centro de Lima' where Codigo = 1





