select * 
into #Base2
from 
##BaseEmpleados

select * from #Base2

select *
into #Base1
from 
##BaseEmpleados

select * from #Base1

Truncate table #Base1
-- pRIMERO VA DESTINO

MERGE #Base1 as tb1 --Destino
USING #Base2 as tb2 -- Origen
ON(tb1.NationalIDNumber = tb2.NationalIDNumber)
--WHEN MATCHED 
--THEN 
--UPDATE SET NOMBRE = 'raton'
WHEN NOT MATCHED -- Cuando no haiga concidencia
THEN 
INSERT VALUES(tb2.NOMBRE,tb2.NationalIDNumber,tb2.BirthDate,tb2.HireDate);


CREATE TABLE #Tb_Ejercicio(Id_Cliente Int,Nom_Cliente varchar(100),Fecha_Nacimiento Date,Sexo varchar(50),Meses_en_Empresa Float)


drop table #Tb_Ejercicio

set DATEFORMAT dmy -- Formato de fecha dia- mes y año

BULK INSERT
#Tb_Ejercicio -- Destino
fROM 'C:\Users\Usuario\Downloads\Librddadsdasd.txt'
With-- TIPO FILTRO
(FIRSTROW = 2) -- PARA QUE TOMA APARTIR DE LA FILA 2


SELECT * FROM #Tb_Ejercicio
SELECT * FROM #Tb_Eje

CREATE TABLE #Tb_Eje(Id_Cliente Int,Nom_Cliente varchar(100),Fecha_Nacimiento Date,Sexo varchar(50),Meses_en_Empresa Float)

delete from #Tb_Eje

BULK INSERT
#Tb_Eje -- Destino
fROM 'C:\Users\Usuario\Downloads\dadsdasd.txt'
With-- TIPO FILTRO
(FIRSTROW = 2) -- PARA QUE TOMA APARTIR DE LA FILA 2



MERGE #Tb_Ejercicio as tb1 
USING #Tb_Eje as tb2 
on(tb1.Id_Cliente = tb2.Id_Cliente)

WHEN NOT MATCHED -- Cuando no haiga concidencia
THEN 
INSERT VALUES(tb2.Id_Cliente,tb2.Nom_Cliente,tb2.Fecha_Nacimiento,tb2.Sexo,tb2.Meses_en_Empresa);






Insert into #Tb_Ejercicio VALUES (6,'Juana','05/05/2000','Femenino',12)

select * 
into TableEjemplo1
from 
Person.Person

select * from Person.Person

select * from TableEjemplo1


select * 
from TableEjemplo1
where BusinessEntityID in (2,701,1699)
update TableEjemplo set  PersonType =  'SP' where BusinessEntityID in (2,701,1699,3335)

SELECT *
FROM (


select BusinessEntityID,FirstName,MiddleName,LastName
from Person.Person
where PersonType = 'EM'
) AS a

INSERT INTO TableEjemplo1 select *  from Person.Person where EmailPromotion = 2 

select * 
from Person.Person
where BusinessEntityID in(SELECT DISTINCT BusinessEntityID From Sales.SalesPerson)


--ROW_NUMBER LOS PARTICIONA Y ORDENA LA FILA
-- CUANDO LO AAGRUPAS EN COLUMNAS SEPARADAS

SELECT 
row_number() over (partition by a.Nombre Order by a.Nombre) as 'Contador',
a.Nombre
FROM (
SELECT 'ivan' as Nombre 
Union all 
select 'ivan' as Nombre
Union all
select 'ivan' as Nombre
Union all
select 'alex' as Nombre
Union all
select 'alex' as Nombre
) as a


select *
from(

select ROW_NUMBER() OVER (ORDER BY SalesYTD DESC) AS Contador,BusinessEntityID,SalesYTD
from Sales.SalesPerson) as a 
-- where Contador like 


-- SCHEMA - ESQUEMAS  -- esquemas mas ordenado
select *
from sys.schemas

create table Person.prueba12(id int)

create table Local.pr12(id int)

drop table schema2.prueba1

create table Person.pr(id  int)


create table prueba1(ID int)
alter schema Production transfer prueba1



select * from Production.prueba1

-- USUARIOS

CREATE SCHEMA schema2
CREATE SCHEMA schema4

create table schema4.prueb(ID int)

select * from schema4.prueb

--GENERICOUNICO

CREATE TABLE Tabla1(ID int)

-- cREANDO uSARIO pr master


CREATE LOGIN UsuarioIvan with password = '1234'

-- use utiliza ese base de datos (lo este) porque no tiene permiso
use AdventureWorks2017

create user UsuarioIvan for login UsuarioIvan with default_schema=schema2 

--grant para dar permiso
grant select on HumanResources.Department to UsuarioIvan 
-- primero dar permiso al esquema y de ahi permiso a la tabla
-- :: indicar
grant control on schema :: schema2  to UsuarioIvan


grant create table to UsuarioIvan
-- dar permiso al contenido de la tabla borrar
grant delete  to  UsuarioIvan

grant delete on HumanResources.Department to UsuarioIvan

grant update  to UsuarioIvan

grant update on HumanResources.Department to UsuarioIvan

-- para quitar permiso

revoke select on HumanResources.Department  to UsuarioIvan



--Primero Eliminar la tabla y de ahi el esquema

drop schema scheme2
