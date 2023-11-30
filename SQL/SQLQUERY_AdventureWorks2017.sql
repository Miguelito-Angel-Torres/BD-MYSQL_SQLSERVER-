-- PESO DEL DATO
EXEC sp_spaceused
-- SACAR BACK UP (GUARDA)
-- tasks -> back up
use AdventureWorks2017

-- Consulta 1 forma:
select * from Person.Person
go
	
select * from Person.EmailAddress
go

select * from Person.Password
go

select 
a.BusinessEntityID,
a.PersonType,
a.NameStyle
from Person.Person as a


select 
Person.Person.BusinessEntityID,
Person.Person.PersonType,
Person.Person.NameStyle
from Person.Person 
go

select BusinessEntityID,PersonType
from Person.Person 
go

select
*
from Person.Person as a
where 
a.LastName =  'Sánchez' and a.EmailPromotion = 1
go

select
*
from Person.Person as a
where 
a.LastName =  'Sánchez' and a.ModifiedDate = '2013-11-05 00:00:00.000'
go

select
*
from Person.Person as a
where 
 a.ModifiedDate = '2013-11-05 00:00:00.000'
go

--Group by :Cuando utiliza funciones de agregacion (count,sum.min,max,avg)
-- Da en otro campo
--No alias adentro del group by

select 
a.Color,SUM(a.ListPrice) as ' Sumatoria',SUM(a.ListPrice * a.StandardCost ) AS 'DSAD',a.ListPrice
from Production.Product as a
group by a.Color
having Sum(a.ListPrice) >=10000 
ORDER by  Sum(a.ListPrice) DESC, DSAD ASC

go
//68560477,8352 , 2605501072,9773
sum(a.ListPrice) * sum(a.StandardCost)

SELECT *  FROM Production.Product
 -- having  : cuando existe funcion de agregacion group by 
select Color ,SUM(ListPrice) as 'Sumatoria'
from Production.Product
group by Color
having SUM(ListPrice)>=1000
order by SUM(ListPrice) DESC

go


select * from Production.Product	
where ProductID  >= 1 and ProductID <=2
go


-- TOP indica que quiero ver a ese top 
-- TOP 25 PERCENT  : PORCENTAJE
select TOP  50 PERCENT
*
FROM Production.Product


select JobTitle, count(*) as 'Cantidad de Cargos'
from HumanResources.Employee
group by JobTitle 
order by JobTitle desc
go

 select *  from HumanResources.Employee

-- Distinct : muestra la data sin duplicado
select Distinct a.JobTitle , count(*) as 'Cantidad de Cargos'
from HumanResources.Employee as a
group by a.JobTitle
order by a.JobTitle desc
go

-- inner join - on
select  PersonType,NameStyle,FirstName ,PhoneNumber ,Name as ' Nombre de Celular'
from Person.Person as tb1 join Person.PersonPhone as tb2

on  (tb1.BusinessEntityID = tb2.BusinessEntityID) join Person.PhoneNumberType as tb3
on(tb2.PhoneNumberTypeID = tb3.PhoneNumberTypeID)


go



select * 
from Person.Person
go


select * 
from Person.PersonPhone
go

select * 
from Person.BusinessEntity
GO

select * from Person.Person;
select * from Person.PersonPhone;
select * from Person.PhoneNumberType;

select *
--a.FirstName,b.PhoneNumber, c.Name

from Person.Person as a join Person.PersonPhone as b
on(a.BusinessEntityID = b.BusinessEntityID) join Person.PhoneNumberType as c
on(b.PhoneNumberTypeID = c.PhoneNumberTypeID)
go

select * From Person.PersonPhone
go

select * From Person.PhoneNumberType
go

-- join left - te trae lo que se repite en la segunda tabla y que no concide lo deja un espacio nulo
select * from Person.Person
select  * from HumanResources.Employee
-- tb1 todo completito , en el tb2 no completo y lo pone null
select FirstName,JobTitle
from Person.Person as tb1 left join HumanResources.Employee as tb2 
on(tb1.BusinessEntityID =  tb2.BusinessEntityID)
go


select JobTitle,FirstName
from HumanResources.Employee as tb1 right join Person.Person as tb2
on(tb1.BusinessEntityID=tb2.BusinessEntityID)
go

--Agregacion(sum) -- dos catregorias(nodeterministas y deterministas)

select *
from Production.ProductInventory

select * 
from Production.Product

select Name as 'Nombre Producto' ,Sum(Quantity)as 'Cantidad'
from Production.ProductInventory as tb1 join Production.Product as tb2
on(tb1.ProductID = tb2.ProductID)
where Name = 'Headset Ball Bearings'
group by  Name
go

-- no determinista
select getdate()

SELECT * FROM 
select EmailPromotion,COUNT(EmailPromotion) as 'Cantidad'
from Person.Person as tb1
group by
EmailPromotion


select *  from Person.Person


select Title,count(Title) as 'Cantidad'
from Person.Person as tb1
where Title is not  null
group by Title 


go

--  having Title is not null


select Title,count(isnull(Title,0)) as 'Cantidad'
from Person.Person as tb1

group by Title 


go

select LastName ,count(LastName) as Cantidad 
from Person.Person as tb1
group by LastName


select  * from Production.Product

select Color , Count(Color) as 'promeido'
from Production.Product
group by Color


select
MIN(ModifiedDate) as 'Minimo',
MAX(ModifiedDate) as 'Maximo'
from Person.Password 
go

--Ejercicios
-- 1 Genere un Select a la tabla [Person].[Person]

select * 
from Person.Person
go

-- 2 Genere un Select a la tabla [Person].[Person] ,unicamente de los campos -->


select BusinessEntityID , PersonType,FirstName,LastName
from Person.Person
go
-- 3 Genere un Query con los mismos campos del punto numero 2 donde PersonType sea igual a EM

select BusinessEntityID as 'ID' , PersonType,FirstName,LastName
from Person.Person
where PersonType ='EM'
go

-- 4 Genere una consulta sobre  la tabla [HuamanResources].[Employee] que muestre BussinesEntityID,NationalNumber,Jobtitle de mayor a menor

select BusinessEntityID,NationalIDNumber,JobTitle
from HumanResources.Employee 
order by BusinessEntityID desc
go

-- 9 Realiza una consulta de la tabla [HumanResources].[Employee] la cual indica el promedio 
--del campo VacationHours donde el Jobtitle sea production Technician -wsc50,
--el campo resultado del promedio debe llamarse Promedio

select JobTitle , avg(VacationHours)  as 'Promedio'
from HumanResources.Employee
where  JobTitle = 'Production Technician - WC50' 
group by JobTitle
go


select
AVG(a.VacationHours) as 'Promedio'
from HumanResources.Employee as a
where a.JobTitle = 'Production Technician - WC50'

select  * 
from HumanResources.Employee

--10 Realice una consulta de la tabla[Sales].[SalesPerson]
--la cual indique la suma total del campo SalesYtd, el nuevo campo debe llamarse Suamtotal



select  sum(SalesYTD) as  'Sumatotal'
from Sales.SalesPerson
go
-- 11 Realice una consulta de la tabla[Sales].[SalesPerson] la cual indique la suma total del
-- campoSalesYtd donde el campo Territory no sea null,el nuevo campo resultante debe llamarse
--Suma total


select  SUM(SalesYTD)  as 'SumaTotal'
from Sales.SalesPerson
where TerritoryID is not null

go


select 
Sum(tb1.SalesYTD) as 'SumaTotal'
from Sales.SalesPerson as tb1
where tb1.TerritoryID is not null
go


select  * 
from Sales.SalesPerson

--12 Genere una consulta a la tabla  [Sales].[SalesPerson] que indique el valor Maximo
-- y minimo del bloque bonus


select  max(Bonus)  as  'Maximo', min(Bonus) as 'Minimo'
from Sales.SalesPerson	
	

--  CAST() = CAMBIA EL FORMATO DEL BLOQUE (EL TIPO DE DATOS) 

select * 
from Production.Product 

-- de Datatime lo paso a Time

select
CAST(ModifiedDate as Date) as 'NuevaFecha'
from Production.Product

--flag son valores de 0 y 1
select 
Cast(MakeFlag as float) as 'NuevoValorDecimal',
Cast(ModifiedDate as date) as 'NuevaFecha',
Cast(MakeFlag as int) as 'NuevoValorEntero',
Cast(MakeFlag as varbinary) as 'NuevoValorVarchar'
from Production.Product


--
select
*
from Production.Product 
where
Cast(ModifiedDate as date ) = '2014-02-08'

select
*
from Production.Product 
where
Cast(ModifiedDate as time) = ' 10:03:55.510 '

select * 
from Production.Product
where
CONVERT(time,ModifiedDate) = ' 10:03:55.510 '

--CONVERT --

SELECT
CONVERT(varchar ,ModifiedDate) as Fecha,
CONVERT(VARCHAR,MakeFlag) as NuevoValor,
CONVERT(BIGINT ,StandardCost) as NUmeroGrandeEnteros
from Production.Product
--PARSE()
--SOLO SE UTILIZA DE CADENA A FECHA
select Parse('Friday, 14 December 2018' as date ) as 'PasadodeFehca'


SELECT GETDATE()
select cast(getDATE() AS DATE)


SELECT DATEADD(MONTH, -1,GETDATE())

SELECT DATEADD(YEAR, +1,GETDATE())
SELECT DATEADD(HOUR, + 5,GETDATE()) AS 'CAMBIO'


SELECT DATEADD(MINUTE, + 5,GETDATE())	

--mOSTAR DE DATOS ENTRE FECHAS DE UN AÑO

SELECT convert(date,SellEndDate)  AS  'fECHA'
FROM Production.Product
where SellEndDate like  '2014-02-08 10:01:36.827' 
go

select * from Production.Product

select *
from Production.Product
where 
cast(SellStartDate as date) BETWEEN '2012-05-30' AND DATEADD(YEAR,2,'2012-05-30')
go

Select *
from Production.Product
where (SellStartDate BETWEEN  '2008-04-30' AND GETDATE())

SELECT * 
FROM Production.Product as tb1
where CAST (tb1.SellStartDate as date) BETWEEN '2012-05-30' AND DATEADD(YEAR,1,'2012-05-30')

SELECT SYSDATETIME()


select *
from Production.Product


-- FUNCION PARA TRABAJAR ATRAS LO CONVIRTE ENLETRAS NUMERO LO PASA A LETRA DATENAME 


select DATENAME(MONTH,GETDATE()) as 'PasadodeFehca'


 



SET language SPANISH select DATENAME(MONTH,GETDATE()) as 'MES'
Select DATENAME(day,getdate()) as 'DIA'
SELECT DATENAME(HOUR,GETDATE()) as 'HORA'
SELECT DATENAME(WEEKDAY,GETDATE()) as 'dia laborable'

select Name,SellStartDate,DATENAME(MONTH,SellStartDate) as 'MES' ,
DATENAME(WEEKDAY,SellStartDate) as 'DIA LABORABLE',
DATENAME(HOUR,SellStartDate) as 'HORA',
DATENAME(DAY,SellStartDate) as 'DIA',
DATENAME(YEAR,SellStartDate) as 'AÑO'
from Production.Product
WHERE DATENAME(MONTH,SellStartDate)= DATENAME(MONTH,GETDATE()) 

--bota en numeros las fechas

SELECT DATEPART(YEAR,GETDATE())
SELECT DATEPART(MONTH,GETDATE())
SELECT DATEPART(DAY,GETDATE())
SELECT DATEPART(HOUR,GETDATE())
SELECT DATEPART(WEEKDAY,GETDATE())
SELECT DATEPART(WEEK,GETDATE())


SELECT YEAR(GETDATE())
SELECT MONTH(GETDATE())
SELECT DAY(GETDATE())

select * from Person.Person


select concat(FirstName , ' ' , LastName) as 'CONCAT'
from Person.Person
go

select Title,FirstName,MiddleName,LastName,CONCAT(Title,' ',FirstName,' ',MiddleName,' ',LastName) as 'Nombres',
len(CONCAT(Title,FirstName,MiddleName,LastName)) as 'Cantidad'
from Person.Person
-- hermano de concat 

select Title,FirstName,MiddleName,LastName,CONCAT_WS(' ',Title,FirstName,MiddleName,LastName) as 'Nombres'
from Person.Person

select Title,FirstName,MiddleName,LastName+' '  + Title+' ' + FirstName+ ' ' +MiddleName+ ' ' + LastName as 'Nombres'
from Person.Person


select CONCAT_WS('  ',Title,FirstName,MiddleName,LastName) as 'Nombres',
len(CONCAT_WS('',Title,FirstName,MiddleName,LastName)) as 'CANTIDAD_NOMBRE_2'
from Person.Person

select left(rowguid,(5)) as NuevaColum 
from Person.EmailAddress
go

select *  from Person.EmailAddress


select DISTINCT RIGHT(EmailAddress,20) as 'Nuevo' 
FROM Person.EmailAddress
group by EmailAddress
go

-- quitar espacios ltrim()izquierdo , rtrim()derecho
 select
 RTRIM(LTRIM(a.Nombre)) AS nuevo
 FROM(
 select 
 concat('          ',a.Title,' ' ,a.FirstName,' ',a.MiddleName) as Nombre
 from 
 Person.Person as a) as a

 -- reemplazo(pones a quien quieres reemplzar , nuevo)
 select EmailAddress,ModifiedDate,
 REPLACE(EmailAddress,'@adventure-works.com','@nuevo_correo.com') as NuevoCorreo,
 REPLACE(ModifiedDate,'2007','2001') as 'reEMPLAZO'

 from
 Person.EmailAddress

 select  * from Person.PhoneNumberType

 -- reemplazo - agregacion creo
select stuff('Miguel Angel',5,0,'Juana Maria Santa Rosa')


select *
from Production.Product 
where Color = 'Black' or  Size = '58' and StandardCost  <350

-- considencias 
select * from Person.Person


select *
from Person.Person
where FirstName like 'terri'

select * 
from Production.Product
where name like '[Hex Nut]%' and ProductNumber like '%[62]'

select * 
from Production.Product
where name like '_%ace'


select * 
from Production.Product
where name not like '%[a_n]ring'

CREATE TABLE tb_telefono(
	id_Tel int Primary key,
	Numero int null)

CREATE TABLE tb_personal(
	Id int primary key,
	Nombre varchar(100),
	Cedula int not null,
	Id_tel int foreign key references tb_telefono(id_Tel)
)

-- last tablas temporales se guarda en memorias , y de esa memoria sale los datos y esa manera ganas velocidad

-- # tabla temporal local
-- ## tabla temporal global

-- la copie de la original para ganar velocidad 

CREATE TABLE #tb_telefono(
	id_Tel int Primary key,
	Numero int null
)
/*ALTER TABLE CLIENTE ADD CONSTRAINT Chk_Correo CHECK(Correo like '%[^@]@%[^.].[a-z][a-z][a-z]');*/
/*ALTER TABLE CLIENTE ADD CONSTRAINT Chk_Telefono CHECK(Contacto like '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%');*/

CREATE TABLE ##tb_personal(
	Id int primary key,
	Nombre varchar(100),
	Cedula int not null,
	Id_tel int foreign key references tb_telefono(id_Tel)
)

select *
from tempdb..sysobjects As a
where a.name like '%tb_telefono%' or a.name like '%tb_personal%'

--Eliminar la table
-- pero no puede estar asociado con un key foreigh
drop table tb_personal 
drop table tb_telefono

drop table  ##tb_personal
drop table #tb_telefono

CREATE TABLE tb_telefono(
	Id_Tel int Primary key,
	Nombre varchar(100))



CREATE TABLE tb_personal(
	Id int primary key,
	Nombre varchar(100),
	Cedula int not null,
	Id_Tel int foreign key references tb_telefono(Id_Tel)
)

INSERT INTO tb_telefono values
	(1,'Celular'),
	(2,'Casa'),
	(3,'Oficina')
go
INSERT INTo tb_telefono values(2,'Casa') 

INSERT INTO tb_personal values
	(1,'Alex',123,1),
	(2,'Diana',124,2),
	(3,'Cristian',125,3)
	
go
INSERT INTO tb_personal (Nombre,Id,Cedula,Id_Tel) VALUES('Lucas',4,126,2)

INSERT INTo tb_personal values(5,'',89,1) 


SELECT * FROM tb_personal	
select * from tb_telefono




SELECT  tb1.Id,tb1.Nombre,tb1.Cedula,tb2.Nombre ,tb3.EmailPromotion
FROM tb_personal as tb1 join tb_telefono as tb2
ON(tb1.Id_Tel=tb2.Id_Tel) join tbEjemplo as tb3
ON(tb1.id =  tb3.BusinessEntityID)
GO

-- truncate pero si esta asociado con un foreign no va poder eliminar datos y delete borra el contenido de la tabla
-- truncate de golpe y delete especifica a quien borrar

truncate table tb_personal -- borra los datos 
truncate table tb_telefono
--
delete from tb_personal where Id = 5 -- borrar un dato especifico
delete from tb_telefono where Id_Tel = 2

SELECT *
FROM Person.Person as a 
where a.EmailPromotion = 1

-- creando una tabla nueva con el contenido que tu especifica (NO EXISTE)
DROP TABLE  tbEjemplo1234
SELECT * 
INTO tbEjemplo1234
FROM Person.Person as a 
where a.EmailPromotion = 1

select *  from  tbEjemplo123

-- INSERT VALORES A UNA TABLA QUE EXISTE 

INSERT INTO tbEjemplo123 select *  from Person.Person  as tb1 where tb1.PersonType = 'SC'
truncate table tbEjemplo123

INSERT INTO tbEjemplo select  * from Person.Person where EmailPromotion=0

CREATE TABLE tb_eje3(BusinessEntityID int primary key,



SELECT  tb1.Id,tb1.Nombre,tb1.Cedula,tb2.Nombre ,tb3.EmailPromotion
FROM tb_personal as tb1 join tb_telefono as tb2
ON(tb1.Id_Tel=tb2.Id_Tel) join tbEjemplo as tb3
ON(tb1.id =  tb3.BusinessEntityID)
GO

--Merge() permite inserta informacion y tambien te permite eliminar , actualizar 
-- tambienagarra datos de la primera tabla  y inserta a otra tabla pero ingresa datos nuevos no duplicados

select 
CONCAT_WS(' ',FirstName,MiddleName,LastName) as 'NOMBRE',NationalIDNumber,BirthDate,HireDate
into ##BaseEmpleados
from HumanResources.Employee as tb1  join Person.Person as tb2
on(tb1.BusinessEntityID = tb2.BusinessEntityID)
where HireDate between '2008-01-01' and '2008-06-30'
order by HireDate ASC
go

select * from ##BaseEmpleados

--IMPORTAR DE MI EXCEL A BASE DE DATOS CON BULK INSERT



-- VIEW (VISTAS) ES DEFINIDA POR UNA TABLA VIRTUAL QUE ES CREADA POR UNA CONSULTA
-- PERMITIR LO QUE QUIERA VER -1024

SELECT * 
FROM sys.views


SELECT * 
FROM Sales.SalesPerson as a
-- viws -> clik drecho ->script viwew .> alter to

CREATE VIEW vw_SalesPerson as
SELECT *		
FROM Sales.SalesPerson as a
where a.Bonus = '300000,00'
DROP VIEW vw_SalesPerson
SELECT * FROM vw_SalesPerson

-- LOS PARAMETROS NOS PERMITE CAMBIAR DATOS ENTRE FUNCIONES Y PROCEDIMIENTO ALMACENADOS
--LOS PARAMETROS SON COMO FUERA VARIABLE 
--OBJET_ID

SELECT * 
FROM sys.all_parameters



SELECT * 
FROM sys.all_objects
WHERE 
object_id in (select distinct object_id 
from sys.all_parameters
where name != '' )


SELECT * 
FROM SYS.all_parameters
WHERE  object_id= -1073624922

DECLARE @Parametrol int = 1


if (@Parametrol !=0)
	set @Parametrol = 2
else
	set @Parametrol = 5
	

print @Parametrol






DECLARE @Parametro25 int
set @Parametro25= 1
print @Parametro25

DECLARE @Parametrol int = 1
print @Parametrol

set @Parametrol = 2
print @Parametrol


DECLARE @Parametro1 int = 1
print @Parametro1

select *
from Person.PersonPhone as a 
where a.PhoneNumberTypeID = @Parametro1

 -- Parametro con consulta
DECLARE @Parametro1 int = 1
print @Parametro1

select *
from Person.PersonPhone as a 
where a.BusinessEntityID = @Parametro1


--Procedimiento almacenados
-- es un espacio almacenado en la base de datos que contiene una estructura almacenada
select * 
from sys.procedures

-- creamos utilizando plantillas  es empaquetados
-- click en  programmability -store procedures -- new --strode produce
-- parametros EXTERNOS

select a.BusinessEntityID,a.NationalIDNumber,a.LoginID,a.JobTitle,a.MaritalStatus
from HumanResources.Employee as a 
where a.MaritalStatus = 's'

exec sp_Employee  's'

-- INTERNOPS
select * 
from HumanResources.Employee as a
where a.HireDate = '2009-01-14'

exec sp_Employee2

-- set Nocount 
-- contador que cuenta los requistros afectados -- estan obtimidando recursos el proceseo de bajo no va parecer
-- un a taba nueva

select BusinessEntityID,NationalIDNumber,LoginID,HireDate ,JobTitle
INTO Employee_Borrador
from HumanResources.Employee
where  HireDate between xxxx and xxxx

 
exec sp_Employee3 '2009-01-14' ,'2019-08-11'

drop table Employee_Borrador
SELECT  BusinessEntityID,NationalIDNumber,LoginID,HireDate ,JobTitle into Employee_Borrador FROM HumanResources.Employee
select * from Employee_Borrador

-- xml puede llevar inforamcion , un formate metalenguaje
-- guardamos la tabla en xml  

CREATE TABLE persona(Nombre varchar(100) ,Apellido varchar(200), Telefono int)

INSERT INTO persona  values
('richard','livise',456789123),
('miguel','mallqui',956789123),
('angel','torres',655789123)


SELECT * FROM persona

--enviar el xml 
SELECT * FROM persona
for xml auto 

select * from persona 
for xml raw,elements,root

select * from persona
for xml raw('Registro'),elements,root('XML')


--- para pasar a un tabla 
 declare @mydoc xml, @i int 

 set @mydoc = '<root>
 <person LastName="whire" FirtName = "Lucas"/>
 <person LastName="Torrez" FirtName = "Maria"/>
 <person LastName="Guadalupe" FirtName = "Juana"/>
 </root>'
 Exec sp_xml_preparedocument @i output, @mydoc -- salida y entrada

 select * from openxml(@i,'/root/person')  with (LastName nvarchar(50),FirtName nvarchar(50))

 --procedimiento (de manera virtual)almacenado temporal

 -- concurrencias(transacciones)
 -- winth noclock(desbloquea las tablas desbloqueada)
 -- rubincasaocion puedes revertirlo con el cpy no puedes revertirlo

 create table Prueba_transaction(id int )

 insert into Prueba_transaction values
	(1),(2),(3)

select *  from Prueba_transaction
truncate table Prueba_transaction

-- crear transacciones) begin = abre la transaction para actualizar
-- si la transaction esta abierta nadie podra utilizar la taba porque esta abierta la transaction porque se 
-- haciendo una update
begin transaction
update Prueba_Transaction set id = 6 where id =2


--forma de revertirlo
rollback transaction -- relaza al iniciom de la transaction

commit transaction -- para aceptar los cambios de la transaction

select *
from Person.Person as a
where 
a.EmailPromotion=1

begin transaction -- set es asignar que voy hacer
update Person.Person  set Title = 'Nuevo'
where EmailPromotion = 1

ROLLBACK TRANSACTION

commit transaction

with -- utilizar

-- TRIGGER ENCADENADRO DE UN OBJETO , HACE UN PROCESO SE PUEDE ACTICAR UNA ACCION UNA UPDATE 
--PUEDES LOS LOT Y QUIEN HIZO ESE CAMBIO O ELIMIANCION DE DATOS (MONITORE)

--ALFERT -> DESPUES DE 
-- ON -> EN QUE TALBA
-- BEGIN -> INICIO
-- END .> FIN 

CREATE TABLE BaseCiudades(CodigoCiudad int,NombreCiudad varchar(100),NombreDepart varchar(100))

select * from BaseCiudades

insert into BaseCiudades values 
	(1,'Medellin','Antioquia'),
	(2,'Madrid','Atlantico'),
	(3,'Barcelona','DC'),
	(4,'Bogota','Bolivar')

delete from BaseCiudades

--trigger un evento  que haga algo despues del insert

create trigger tr_Ciudades_Insert
on BaseCiudades
after Insert  
as 
Begin -- aca la accion
--xxxxxxxxxxxxxxxxxxxxxxxxx
print 'Se realizo una accion de INSERT'
End

drop trigger tr_Ciudades_Insert

insert into BaseCiudades values 
	(5,'Medn','Anti')

select *  from BaseCiudades

--PARA SABER QUE ESTA ACIENDO
select * from Logs_BaseCiudades
create table Logs_BaseCiudades(fecha DATE , Hora Time, Nombre varchar(100),Descripcion varchar(100))

create trigger tr_Ciudades_Insert2
on BaseCiudades
After insert  
as 
Begin
print 'Se realizo una accion de INSERT'
set Nocount on 
insert into Logs_BaseCiudades(Fecha,Hora,Nombre,Descripcion)
select
Getdate(),
Sysdatetime(),
@@SERVERNAME,
Descripcion = 'iNSERTAR'
End



create trigger tr_Ciudades_
on BaseCiudades
After update 
as
Begin 
print 'Se realizo una accion Delete'
set Nocount on 
insert into Logs_BaseCiudades(Fecha,Hora,Nombre,Descripcion)
select
Getdate(),
Sysdatetime(),
@@SERVERNAME,
Descripcion = 'Update'
End

create trigger tr_Ciudade
on BaseCiudades
After delete 
as
Begin 
print 'Se realizo una accion Delete'
set Nocount on 
insert into Logs_BaseCiudades(Fecha,Hora,Nombre,Descripcion)
select
Getdate(),
Sysdatetime(),
@@SERVERNAME,
Descripcion = 'Delete'
End

delete 

insert into BaseCiudades values 
	(6,'Mednss','Antsssi')

delete from BaseCiudades where CodigoCiudad = 6
update BaseCiudades  set NombreCiudad ='Lima' where  CodigoCiudad = 4

insert into BaseCiudades values 
	(7,'Mednss','Antsoosi')
insert into BaseCiudades values 
	(15,'Mednss','Antsoosi')

drop trigger tr_Ciudades_Insert2