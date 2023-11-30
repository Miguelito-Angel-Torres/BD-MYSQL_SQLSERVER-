drop database if exists CusquiTrabajoO; -- ELIMINAR BASE DE DATOS SI EXISTE ' CusquiTrabajo'
CREATE DATABASE CusquiTrabajoO;  -- CREAR BASE DE DATOS SI NO EXISTE ' CusquiTrabajo'
USE CusquiTrabajoO; -- USO DE LA BASE DE DATOS
#----------------------CREACION DE LAS TABLAS ---------------
drop table if exists Usuario;  -- ELIMINAR LA TABLA SI EXISTE ' Usuario'
Create table if not exists Usuario (
codigo int not null auto_increment primary key,
nombre varchar(100)  not null unique,
correo varchar(100) not null Unique,
contraseña varchar(100) not null
CHECK (CHAR_LENGTH(contraseña)>9 ));


drop table if exists Proveedor;
CREATE TABLE Proveedor (
codigo int not null auto_increment primary key,
nombre nvarchar(100) not null,
imagen blob not null,
categoria nvarchar(100) not null,
codigo_usuario int not null,
foreign key (codigo_usuario) references Usuario(codigo)
);

drop table if exists Suscripcion;
CREATE TABLE Suscripcion (
codigo int not null auto_increment primary key,
fechaInicio date,
recordatorio nvarchar(100) not null,
fechaExpiracion date,
monto double not null,
moneda nvarchar(10) not null,
ciclo nvarchar(50) not null,
codigo_proveedor int not null,
codigo_usuario int not null,
foreign key (codigo_proveedor) references Proveedor(codigo),
foreign key(codigo_usuario) references Usuario(codigo)
);

#----------------------INSERTARCORRECTO------------------------
drop procedure if exists sp_CrearUsuario;
delimiter //
create procedure sp_CrearUsuario( In nom nvarchar(100),
                                   corr nvarchar(100),
                                   contra varchar(100),
                                   out respuesta varchar(100)
                                   ,out estado boolean)
	BEGIN
		SET estado = False;
		IF (char_length(nom)=0 or isnull(nom)) THEN
			SET  respuesta = 'Nombre incorrecto';		 
		ELSEIF ((char_length(corr)=0) or (isnull(corr)) or (corr  NOT LIKE '__%@__%.___' and corr  NOT LIKE '__%@__%.__') )THEN
			SET  respuesta = 'Correo inválido,Verifique su Correo';	
		ELSEIF (char_length(contra)=0 or isnull(contra)) THEN 
			SET  respuesta = 'Contraseña inválida';
		ELSEIF (char_length(contra)<7 ) THEN
			SET  respuesta = 'La contraseña debe contener 7 caracteres';
		ELSEIF (exists(select * from Usuario where  nombre = nom  or correo = corr))THEN
			 set respuesta= "El usuario ya existe ";
		ELSE
			INSERT Usuario (Nombre,Correo,Contraseña) Values (nom, corr,contra);
			set respuesta = 'Registro correcto';
            SET estado = True;
		end if;
END //
call sp_CrearUsuario('Alex','alex@hotmail.pe','1234s1234',@mensaje,@estad);
select @mensaje;
select @estad

drop procedure if exists sp_ListarUsuario;
delimiter //
create procedure sp_ListarUsuario(In cod int,
								out respuesta varchar(100), 
                                out estado boolean )
BEGIN
	SET estado = False;
	IF(not exists(select codigo from Usuario where codigo = cod  ))THEN
         set respuesta = "Usuario no Encontrado "   ;
	ELSE		 
		 select * from Usuario  where codigo  = cod; 
		 set respuesta = "Usuario Encontrado" ;
         SET estado = True;
	end if;    
END //
set SQL_SAFE_UPDATES = 0;
call sp_ListarUsuario('0',@msg,@estado);
select @msg;
select @estado;

drop procedure if exists sp_ActualizarUsuario;
delimiter //
create procedure sp_ActualizarUsuario(In cod int, nom nvarchar(100), corr nvarchar(100),contra nvarchar(100), out respuesta varchar(100), out estado boolean)
BEGIN
	SET estado = False;
	IF (char_length(nom)=0 or isnull(nom)) THEN
		SET respuesta = 'Nombre incorrecto';		 
	ELSEIF ((char_length(corr)=0) or (isnull(corr)) or (corr  NOT LIKE '__%@__%.___' and corr  NOT LIKE '__%@__%.__') )THEN
		SET respuesta = 'Correo incorrecto';		
	ELSEIF (char_length(contra)=0 or isnull(contra)) THEN
		SET respuesta = 'Contraseña incorrecta';
	ElSEIF (not exists(select codigo from Usuario where codigo = cod  ))THEN
		 set respuesta = "!Usuario no existente¡";
	ELSEIF (char_length(contra)<7) THEN
			SET  respuesta = 'La contraseña debe contener 7 caracteres';
	ELSEIF((select contraseña from Usuario where codigo = cod)<=>contra )then
		 set respuesta = "!Debes colocar una contraseña diferente¡";
	ELSEIF (exists(select * from Usuario where  nombre = nom  or correo = corr))THEN
			 set respuesta= "El usuario ya existe ";
	ELSE
		 set estado = True;
		 update Usuario set nombre = nom, correo = corr,contraseña = contra where codigo = cod;
         SET respuesta = '!Actualizado correctamente';
	end if;
END //
set SQL_SAFE_UPDATES = 0;
call sp_ActualizarUsuario('1',"Alex",'juan@hotmail.com',"maria123456",@msg,@estado);
select @msg;
select @estado;
#-----------Eliminar
drop procedure if exists sp_EliminarUsuario;
delimiter //
create procedure sp_EliminarUsuario(In cod int, out respuesta varchar(100), out estado boolean)
BEGIN
	set estado = false;
	IF (not exists(select codigo from Usuario where codigo = cod  ))THEN
		 set respuesta = " ¡Usuario no existente¡";
	else
		set estado = true;
		delete from Usuario where codigo   =  cod;
         set respuesta = "¡Eliminacion Exitosa!";
    end if;
END //
set SQL_SAFE_UPDATES = 0;
call sp_EliminarUsuario('',@msg,@estado);
select @msg;
select @estado;

#PROVEEDOR-------------------
#-----------------INSERTAR

drop procedure if exists sp_CrearProveedor;
delimiter //
create procedure sp_CrearProveedor(in nom nvarchar(100), img Blob, categ varchar(100), codUsu int, out respuesta varchar(100), out estado boolean)
BEGIN
	set estado = false;
    IF (char_length(categ )=0 or isnull(categ)) THEN
		SET respuesta = 'Error Categoria';
	ELSEIF (char_length(nom)=0 or isnull(nom)) THEN
		SET respuesta = 'Nombre incorrecto';
	ELSEIF (char_length(img)=0 or isnull(img)) THEN
		SET respuesta = 'Error Imagen';
	ElSEIF (not exists(select codigo from Usuario where codigo = codUsu  ))THEN
		 set respuesta = "!Usuario no encontrado para el registro¡";
	ELSE
		set estado = true;
		INSERT Proveedor (nombre, imagen, categoria, codigo_usuario) Values (nom, img, categ, codUsu);    
		SET respuesta= 'Registro correcto';
	end if;
END //
call sp_CrearProveedor('AmazonPrime','imagen.jpg','entretenimiento','6',@msg,@estado);
select @msg;
select @estado;
#--Actualizar
drop procedure if exists sp_ActualizarProveedor;
delimiter //
create procedure sp_ActualizarProveedor(In cod int, nom nvarchar(100), img blob, categ nvarchar(100), out respuesta varchar(100), out estado boolean)
BEGIN
	set estado = False;
	IF (char_length(nom)=0 or isnull(nom))  THEN
		SET respuesta = '!Nombre Incorrecto¡';
    ELSEIF (char_length(categ)=0 or isnull(categ)) THEN
		SET respuesta = 'Categoria Incorrecto';
	ELSEIF (char_length(img)=0 or isnull(img)) THEN
		SET respuesta = 'Error de Imagen';
	ElSEIF (not exists(select codigo from proveedor where codigo = cod))THEN
		 set respuesta = "!Proveedor no encontrado¡";
    ELSE
		set estado = True;
		update Proveedor set nombre = nom, imagen = img, categoria = categ where codigo = cod;
        SET respuesta = 'Actualizado correctamente';
	end if;
END //
set SQL_SAFE_UPDATES = 0;
call sp_ActualizarProveedor('1234',"Discord Nitro","imagen.jpg","Entretenimiento",@msg,@estado);
select @msg;
select @estado;

drop procedure if exists sp_EliminarProveedor;
delimiter //
create procedure sp_EliminarProveedor(In cod int, out respuesta varchar(100), out estado boolean)
BEGIN
	set estado = False;
	IF( not exists(select codigo from proveedor where codigo = cod  ))then
		 set respuesta = "¡Proveedor no existente! ";
	ELSE
		 set estado = True;
		 delete from proveedor where codigo = cod;
         set respuesta = "¡Eliminacion Exitosa!" ;		
    end if;
END //
set SQL_SAFE_UPDATES = 0;
call sp_EliminarProveedor(1,@msg,@estado);
select @msg;
select @estado


drop procedure if exists sp_ListaProveedorx;
delimiter //
create procedure sp_ListaProveedorx(In codUsuario int, out  respuesta varchar(100))
BEGIN
	declare a INT;
    declare b INT;
    SET a  = (select count(*) from proveedor where codigo_usuario = codUsuario );
    set b = (select count(*) from proveedor where codigo_usuario = 1);
		
        if(a = 0)then
			set respuesta = "proveedor no Encontrado";
		elseif(b > 0 and a > 0 )then 
			select p.nombre , p.imagen , p.categoria
            from Proveedor P JOIN Usuario u
            on p.codigo_usuario = u.codigo
            where u.codigo = codUsuario or u.codigo = 1;
            set respuesta = "Proveedor Encontrados";
end if;
END //
set SQL_SAFE_UPDATES = 0;
call sp_ListaProveedorx('50',@msgs); select @msgs

#----------------------------------SUSCRIPCION
drop procedure if exists sp_CrearSuscripcion;
delimiter //
create procedure sp_CrearSuscripcion(in fechaIni date, record varchar(100), fechaExpira date , mont double, moned varchar(100), cic varchar(100), codPro int,codUsu int , out respuesta varchar(100),out estado boolean)
BEGIN
	set estado = False;
    IF (char_length(fechaIni)=0 or isnull(fechaIni)) THEN
		SET respuesta= '!Inicio de suscripción no válido¡';        
	ELSEIF (char_length(fechaExpira )=0 or isnull(fechaExpira)) THEN
		SET respuesta= '!Fecha de Expiracion no válido¡';        
	ELSEIF (char_length(cic)=0 or isnull(cic)) THEN
		SET respuesta = '¡Ciclo de pago no válido!';        
	ELSEIF (char_length(record)=0 or isnull(record)) THEN
		SET respuesta = '¡Recordatorio no válido!';
    ELSEIF (char_length(mont )=0 or mont  is null) THEN
		SET respuesta = '¡Monto no válido!';
	ELSEIF(not exists(select codigo from Usuario where codigo = codUsu  ))then 
		set respuesta = "¡No existe el Usuario!";
	ELSEIF( not exists(select codigo from Proveedor where codigo = codPro  ))then 
		set respuesta = "¡No existe el Proveedor!";
	ELSE
		set estado = True;
		INSERT suscripcion (fechaInicio, recordatorio,fechaExpiracion, monto, moneda, ciclo, codigo_proveedor,codigo_usuario) Values (fechaIni, record,fechaExpira, mont, moned, cic, codPro,codUsu); 
		SET respuesta = 'Registro correcto';
	end if;
END //
call sp_CrearSuscripcion('2021-09-05','5 dias','2021-09-12',12.33,'PEN','Semanal',"1","7",@msg,@estado);
select @msg;
select @estado;

drop procedure if exists sp_ActualizarSuscripcion;
delimiter //
create procedure sp_ActualizarSuscripcion(in cod int,fechaIni date, record varchar(100),fechaExpira date, mont double, moned varchar(100), cic varchar(100), out respuesta varchar(100),out estado boolean)
BEGIN
	set estado = false;
	IF (char_length(fechaIni)=0 or isnull(fechaIni)) THEN
		SET respuesta = '!Inicio de suscripción no válido¡';
	ELSEIF (char_length(fechaExpira)=0 or  isnull(fechaExpira)) THEN
		SET respuesta = '!Fecha Expiracion no válido¡';		
    ELSEIF (char_length(cic)=0 or  isnull(cic)) THEN
		SET respuesta = '!Ciclo de pago no válido¡';        
	ELSEIF (char_length(moned)=0 or isnull(moned)) THEN
		SET respuesta = '!Tipo de moneda no válido¡';
	ELSEIF (char_length(record)=0 or isnull(record)) THEN
		SET respuesta = '!Recordatorio no válido¡';
    ELSEIF (mont=0 or isnull(mont)) THEN
		SET respuesta = '!Monto no válido¡';
	ELSEIF( not exists(select codigo from  Suscripcion where codigo = cod  ))then 
		set respuesta = "¡Suscripcion no Existente!";
	ELSE
		set estado =true;
		update Suscripcion set fechaInicio = fechaIni ,fechaExpiracion =fechaExpira ,monto = mont,moneda=moned,ciclo=cic where codigo = cod;
        SET respuesta = 'Actualizado correctamente';
	end if;
END //
set SQL_SAFE_UPDATES = 0;
call sp_ActualizarSuscripcion("1","2020-05-00","5 dias","2020-05-30",'12.33','PEN','Mensual',@msg,@estado);
select @msg;
select @estado;
#Lista ----------
DROP PROCEDURE IF EXISTS sp_ListarSuscripcionesx;
DELIMITER //
CREATE PROCEDURE sp_ListarSuscripcionesx(
IN codig INT,
OUT respuesta VARCHAR(50))
BEGIN
DECLARE a INT;
DECLARE b INT;
SET a = (select count(*) from Usuario where codigo=codig);
SET b = (Select count(*) from  Suscripcion where codigo_usuario=codig);
    IF (a=0) THEN
		SET respuesta = 'El usuario no existe';	
    ELSEIF (b=0) THEN
		SET respuesta = 'Sin registros de suscripciones';
    ELSE
		select C.nombre, C.categoria, A.fechaInicio, A.fechaExpiracion	, A.ciclo, A.monto, A.moneda,A.recordatorio 
        from Suscripcion as A INNER JOIN Usuario as B
        ON A.codigo_usuario=B.codigo  INNER JOIN Proveedor as C 
        ON A.codigo_proveedor=C.Codigo
        WHERE  A.codigo_usuario = codig;
        set respuesta = "Suscripcion lista ";	
    END IF;	
END//
DELIMITER ;
set SQL_SAFE_UPDATES = 0;
call sp_ListarSuscripcionesx('12',@msg);
select @msg;
select @estado;
CREATE INDEX id_ListaSuscripciones 
on Suscripcion(codigo,IdUsuario,CodProveedor,Inicio, EstadoPago, CicloPago, TipoMoneda, RecordatorioPago, Monto);
#Eliminacion------------------------------------------------------------
drop procedure if exists sp_EliminarSuscripcion;
delimiter //
create procedure sp_EliminarSuscripcion(In cod int, out respuesta varchar(100),out estado boolean)
BEGIN
	set estado = false;
	IF(not exists(select * from Suscripcion where codigo = cod  ))then
		 set respuesta = "¡Suscripcion no existente!";		 		 
	ELSE
		 set estado = true;
		 delete from Suscripcion where codigo = cod;
         set respuesta = "Eliminacion Exitosa!";
    end if;
END //
set SQL_SAFE_UPDATES = 0;
call sp_EliminarSuscripcion(456,@msg,@estado);
select @msg;
select @estado;

#---------INICIO  DE SESION:
drop procedure if exists sp_InicioSesion;
delimiter //
create procedure sp_InicioSesion(in corre nvarchar(100),contra varchar(100),out codigos int,out nombres  nvarchar(100),out respuesta varchar(100))
	BEGIN
		set codigos = 0;
        set nombres = 's';
        if(char_length(corre) = 0 or isnull(corre))then
			set respuesta = "Correo vacio o null";
		elseif(char_length(contra)=0 or isnull(contra))	then
			set respuesta = "Contraseña vacio o null";
		elseif(exists(select * from Usuario where correo = corre and contraseña != contra))then
			 set respuesta = "La contraseña es incorrecta";
		elseif(not exists(select * from Usuario where correo = corre))then
			 set respuesta = "El correo no existe";
		else
			set codigos = (select codigo from usuario where correo = corre and contraseña = contra);
            set nombres = (select nombre  from usuario where correo= corre and contraseña = contra);
            set respuesta = "Bienvenido a la Pagina";				
		end if;
END //
call sp_InicioSesion('juanaMar@gmail.com','juana1234',@codig,@nombre,@msg);
select @msg;
select @codig;
select @nombre;
#-----USUARIO:
call sp_CrearUsuario('Miguel','miguel12345@gmail.com','123456angel',@msg,@estad);
call sp_CrearUsuario('Vigilio','vigi12345@hotmail.com','vig123479',@msg,@estad);
call sp_CrearUsuario('Marco','marco123@hotmail.com','mototaxi123',@msg,@estad);
call sp_CrearUsuario('Juana','juanaMar@gmail.com','juana1234',@msg,@estad);
call sp_CrearUsuario('Ana','ana1234@outlook.es','anMre1234',@msg,@estad);
call sp_CrearUsuario('Flor','1245789@outlook.es','florcita45789',@msg,@estad);
call sp_CrearUsuario('Dalila','dal12346@outlook.es','perd46545789',@msg,@estad);
call sp_CrearUsuario('Katy','katwer@outlook.es','kat1236y',@msg,@estad);
call sp_CrearUsuario('Simeon','sime154@outlook.es','sim912365',@msg,@estad);
call sp_CrearUsuario('Lucas','Luc154@outlook.es','lucas912365',@msg,@estad);
call sp_CrearUsuario('Norma','Nor145654@gmail.com','nor912ma365',@msg,@estad);
call sp_CrearUsuario('Eloy','Eloy654@gmail.com','eloy1234',@msg,@estad);
call sp_CrearUsuario('Anasta','654A789@gmail.com','Ata12347',@msg,@estad);
call sp_CrearUsuario('Rufo','Ru789fo@gmail.com','jjpld6pl9yiyi',@msg,@estad);
call sp_CrearUsuario('Armando','muco142arm@gmail.com','plsrts1234',@msg,@estad);
call sp_CrearUsuario('Estefany','fany456@gmail.com','esteri789',@msg,@estad);
call sp_CrearUsuario('Nicol','nic789@hotmail.com','nii7ss89col',@msg,@estad);
call sp_CrearUsuario('Oscar','osc789@hotmail.com','as466546789',@msg,@estad);

select *  from Usuario

#-----Proveedor:
select *  from Proveedor
call sp_CrearProveedor('AmazonPrime','imagen.jpg','entretenimiento','1' ,@msg,@estado);
call sp_CrearProveedor('Neflix','imagen.jpg','Entretenimiento','2' ,@msg,@estado);
call sp_CrearProveedor('Disney','imagen.jpg','Entretenimiento','1' ,@msg,@estado);
call sp_CrearProveedor('Youtube Premium','imagen.jpg','Entretenimiento','3' ,@msg,@estado);
call sp_CrearProveedor('Youtube Music','imagen.jpg','Musica','4' ,@msg,@estado);
call sp_CrearProveedor('Spotify','imagen.jpg','Musica','5' ,@msg,@estado);
call sp_CrearProveedor('Movistar','imagen.jpg','Servicio','6' ,@msg,@estado);
call sp_CrearProveedor('Claro','imagen.jpg','Servicio','7' ,@msg,@estado);
call sp_CrearProveedor('HBO','imagen.jpg','Entretenimiento','8' ,@msg,@estado);
call sp_CrearProveedor('BBCP','imagen.jpg','Banco','9' ,@msg,@estado);
call sp_CrearProveedor('Dropbox','imagen.jpg','Productividad','10' ,@msg,@estado);
call sp_CrearProveedor('Box','imagen.jpg','Productividad','9' ,@msg,@estado);
call sp_CrearProveedor('!Cloud','imagen.jpg','Productividad','12' ,@msg,@estado);
call sp_CrearProveedor('Orange','imagen.jpg','Suministro','13' ,@msg,@estado);
call sp_CrearProveedor('Banco Continental','imagen.jpg','Banco','15' ,@msg,@estado);
call sp_CrearProveedor('Apple Music','imagen.jpg','Musica','16' ,@msg,@estado);
call sp_CrearProveedor('Banco Continental','imagen.jpg','Banco','9' ,@msg,@estado);
#-----Suscripcion:
select *  from Suscripcion
drop table Suscripcion
call sp_CrearSuscripcion('2020-05-04','1 semana','2020-05-30',12.33,'PEN','Mensual',"3","1",@msg,@estado);
call sp_CrearSuscripcion('2020-06-08','3 dias','2020-07-08',24.33,'PEN','Mensual',"1","1",@msg,@estado);
call sp_CrearSuscripcion('2021-12-05','1 semana','2021-12-20',20.00,'PEN','Quincenal',"2","2",@msg,@estado);
call sp_CrearSuscripcion('2021-12-10','1 semana','2021-12-25',20.00,'PEN','Quincenal',"17","2",@msg,@estado);
call sp_CrearSuscripcion('2021-12-05','1 semana','2021-12-20',20.00,'PEN','Quincenal',"18","2",@msg,@estado);
call sp_CrearSuscripcion('2020-02-20','2 semana ','2021-03-20',30.00,'PEN','Mensual',"4","3",@msg,@estado);
call sp_CrearSuscripcion('2019-09-15','5 dias','2019-10-15',27.00,'PEN','Mensual',"5","4",@msg,@estado);
call sp_CrearSuscripcion('2020-01-09','1 semana','2020-01-24',12.00,'PEN','Quincenal',"6","5",@msg,@estado);
call sp_CrearSuscripcion('2019-08-12','1 semana','2019-08-27',15.00,'PEN','Quincenal',"7","6",@msg,@estado);
call sp_CrearSuscripcion('2020-07-01','1 semana','2020-07-16',30.00,'PEN','Quincenal',"8","7",@msg,@estado);
call sp_CrearSuscripcion('2021-11-22','2 dias','2021-12-22',50.00,'PEN','Mensual',"9","8",@msg,@estado);
call sp_CrearSuscripcion('2019-10-24','5 dias','2019-10-31',34.50,'PEN',"Semanal","10","9",@msg,@estado);
call sp_CrearSuscripcion('2019-10-24','5 dias','2019-11-24',50.50,'PEN',"Mensual","12","9",@msg,@estado);
call sp_CrearSuscripcion('2019-10-24','5 dias','2019-10-31',23.50,'PEN',"Semanal","11","10",@msg,@estado);
call sp_CrearSuscripcion('2019-10-24','5 dias','2019-11-24',50.50,'PEN',"Mensual","13","12",@msg,@estado);
call sp_CrearSuscripcion('2019-10-24','5 dias','2019-10-31',40.50,'PEN',"Semanal","14","13",@msg,@estado);
call sp_CrearSuscripcion('2019-10-24','5 dias','2019-11-24',20.50,'PEN',"Mensual","15","15",@msg,@estado);
call sp_CrearSuscripcion('2019-10-24','5 dias','2019-10-31',50.50,'PEN',"Semanal","16","16",@msg,@estado);
call sp_CrearSuscripcion('2019-10-24','5 dias','2019-10-31',50.50,'PEN',"Semanal","10","9",@msg,@estado);
call sp_CrearSuscripcion('2020-10-24','5 dias','2019-10-31',20.00,'PEN',"Semanal","15","9",@msg,@estado);
#---------------------------------------------

create index Id_ListaUsuario on Usuario(codigo,nombre,correo,contraseña);
explain select codigo,nombre, correo , contraseña from Usuario;
show warnings;

explain select p.codigo,p.nombre,p.imagen,p.categoria , u.nombre  
from Proveedor p join Usuario u 
on (p.codigo_usuario = u.codigo);
show warnings;

drop procedure if exists sp_ListaMontoPorUsuario;
create procedure sp_ListaMontoPorUsuario(in nom varchar(100))
select u.nombre Nombre_Usuario, round(sum(s.monto),2) MontoTotal
from usuario u
inner join suscripcion s
on (u.codigo = s.codigo_usuario)
where u.nombre like nom ;
call sp_ListaMontoPorUsuario('Miguel');

drop procedure if exists sp_ListaMontoPorUsuarioAño;
create procedure sp_ListaMontoPorUsuarioAño(in nom varchar(100) , año year)
select u.nombre Nombre_Usuario, round(sum(s.monto),2) MontoTotal_Año
from usuario u
inner join suscripcion s
on u.codigo = s.codigo_usuario
where u.nombre = nom and (year(s.fechaInicio) = año );
call sp_ListaMontoPorUsuarioAño('Simeon',2019);

drop procedure if exists sp_ListaMontoPorUsuarioAñoandMes;
create procedure sp_ListaMontoPorUsuarioAñoandMes(in nom varchar(100) , año int , mes int )
select u.nombre nombre_usuario, round(sum(s.monto),2) Monto_Año_Fecha
from usuario u
inner join suscripcion s
on u.codigo = s.codigo_usuario
where u.nombre = nom and (year(s.fechaInicio) = año  and month(s.fechaInicio) = mes);
call sp_ListaMontoPorUsuarioAñoandMes('Miguel',2020,5);


drop procedure if exists sp_ListaMontoPorTotalPorCategoria;
create procedure sp_ListaMontoPorTotalPorCategoria(in nom varchar(100) , catego varchar(100) )
select u.nombre Nombre_usuario, round(sum(s.monto),2) MontoTotal_Categoria
from usuario u
inner join  suscripcion s
on u.codigo = s.codigo_usuario join proveedor e
on e.codigo = s.codigo_proveedor
where u.nombre  = nom and e.categoria  = catego ; 
call sp_ListaMontoPorTotalPorCategoria('Simeon','Banco');

drop procedure if exists sp_ListaUsuarioporCategoria;
create procedure sp_ListaUsuarioporCategoria(in codigo int,nom varchar(20))
select p.codigo_usuario, p.nombre ,p.imagen , p.categoria
from Proveedor p 
where p.codigo_usuario = codigo and p.categoria like concat(nom, '%');
call sp_ListaUsuarioporCategoria('4','Musica');

#-- FUNCION
--Numeros primos
create function primo(@num int)
returns varchar(50)
as
begin
declare @cont int
declare @i int
declare @resto int
declare @mensaje varchar(50)

if @num>1
begin
set @cont=0
set @i=2

	while @i<@num and @cont=0
		begin
		set @resto=@num%@i
		
		if @resto=0
		begin
		set @cont=@cont+1
		end
		set @i=@i+1
		end
	if @cont=0
	begin
	set @mensaje='es numero primo'
	end
	else
	begin
	set @mensaje='no es numero primo'
	end
end
else
begin
set @mensaje='no es numero primo'
end

return @mensaje
end

select dbo.primo(5)
// TRIGGER 
drop trigger eliminar
CREATE TRIGGER eliminar
on Alumnos
for delete
as
begin
set Nocount on 
declare  @nombre varchar(50)
select @nombre = nombre from deleted
insert into Auditoria values(GETDATE(),@nombre,'Se elimino')

delete from Alumnos1 where nombre = @nombre
end

delete from Alumnos where nombre = 'M456aria'