DROP DATABASE IF EXISTS DB_OLX;
CREATE DATABASE DB_OLX;
USE DB_OLX;
DROP TABLE IF EXISTS CLIENTE;  
 CREATE TABLE IF NOT EXISTS CLIENTE 
 (
	id_Cliente int not null auto_increment ,
	Nombre_Cliente varchar(100) not null,
	Apellido_Cliente varchar(100) not null,
	Edad_Cliente smallint,
	Correo varchar(100) not null,
	Contacto char(20),
    Img nvarchar(250) not null,
    Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    PRIMARY KEY (id_Cliente) 
);
DROP TABLE IF EXISTS MEDIOPAGO;
CREATE TABLE IF NOT EXISTS MEDIOPAGO
(
	id_MedioPago int not null auto_increment,
	id_Cliente int not null,
	MedioPago nvarchar(100) not null,
    NumeroTarjeta char(50) not null,
    CVV char(3) not null,
    FechaVencimiento date not null,
	Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    PRIMARY KEY(id_MedioPago),
    CONSTRAINT Fk_Mediopago_Cliente
    FOREIGN KEY (id_Cliente) 
    REFERENCES CLIENTE(id_Cliente)
);
DROP TABLE IF EXISTS PAIS;
CREATE TABLE IF NOT EXISTS PAIS
(
	id_Pais int not null auto_increment,
	Uk_Pais nvarchar(100),
    Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    PRIMARY KEY(id_Pais)    
);
DROP TABLE IF EXISTS CIUDAD;
CREATE TABLE IF NOT EXISTS CIUDAD 
(	
	id_Ciudad int not null auto_increment,
	id_Pais int not null,
	Uk_Nombre nvarchar(50) not null,
    Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    PRIMARY KEY(id_Ciudad),
    CONSTRAINT  Fk_Pais_Ciudad 
    FOREIGN KEY (id_Pais) 
    REFERENCES PAIS(id_Pais)
);
DROP TABLE IF EXISTS DIRECCIONES;
CREATE TABLE IF NOT EXISTS DIRECCIONES
(
	id_Direct int not null auto_increment,
	id_Cliente int not null,
	Direccion nvarchar(500) not null,
	id_Ciudad int not null,
    Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    PRIMARY KEY(id_Direct),
	CONSTRAINT Fk_Direcciones_Cliente
    FOREIGN KEY (id_Cliente)
    REFERENCES CLIENTE(id_Cliente),
    CONSTRAINT Fk_Direcciones_Ciudad
    FOREIGN KEY (id_Ciudad)
    REFERENCES CIUDAD(id_Ciudad)
);
DROP TABLE IF EXISTS ROLL;
CREATE TABLE IF NOT EXISTS ROLL
(
	id_Roll int not null auto_increment,
	Descript_Roll nvarchar (50) not null,
    _Value char(6) not null,
	Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    PRIMARY KEY(id_Roll)
);
DROP TABLE IF EXISTS USER_;
CREATE TABLE IF NOT EXISTS USER_
(
	id_Cliente int not null,
	id_Roll int not null,
	_Username nvarchar(20) not null,
	_Password nvarchar(100) not null,
	_Status bool,
    Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
	CONSTRAINT Fk_User_Cliente
    FOREIGN KEY (id_Cliente)
    REFERENCES CLIENTE(id_Cliente),
    CONSTRAINT Fk_User_Roll
    FOREIGN KEY (id_Roll)
    REFERENCES  ROLL(id_Roll)
);
DROP TABLE IF EXISTS CATEGORIA;
CREATE TABLE IF NOT EXISTS CATEGORIA
(
	id_Categoria int not null auto_increment,
	Nom_Category nvarchar(100) not null,
    Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    PRIMARY KEY(id_Categoria)
);
DROP TABLE IF EXISTS SUBCATEGORIAS;
CREATE TABLE IF NOT EXISTS SUBCATEGORIAS
(
	id_SubCategory int not null auto_increment ,
	id_Category int not null,
	Nom_SubCategory nvarchar(100) not null,
    Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    PRIMARY KEY(id_SubCategory),
    CONSTRAINT  Fk_Categoria_SubCategorias
    FOREIGN KEY  (id_Category)
    REFERENCES CATEGORIA (id_Categoria)
);
DROP TABLE IF EXISTS MARCA;
CREATE TABLE IF NOT EXISTS MARCA
(
	id_Marca int not null auto_increment,
    Nom_Marca nvarchar(100) not null,
    Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    PRIMARY KEY(id_Marca)
);
DROP TABLE IF EXISTS PRODUCTOS;
CREATE TABLE IF NOT EXISTS PRODUCTOS
(
	id_Product int not null auto_increment,
    Nombre_Product nvarchar(500) not null,
    id_Marca int not null,
	id_SubCategory int not null,
	Descript_Product nvarchar(1000) not null,
	Precio decimal(7,2) not null,
	Stock smallint not null,
    Unidad nvarchar(10) not null,
    Moneda nvarchar(20) not null,
	Img1 nvarchar(250),
    Img2 nvarchar(250),
    Img3 nvarchar(250),
    Img4 nvarchar(250),
    Img5 nvarchar(250),
    NDescuento smallint not null,
	_Status bool,
    Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    PRIMARY KEY(id_Product),
    CONSTRAINT  Fk_Productos_SubCategoria
    FOREIGN KEY  (id_SubCategory)
    REFERENCES SUBCATEGORIAS (id_SubCategory),
    CONSTRAINT  Fk_Productos_Marca
    FOREIGN KEY  (id_Marca)
    REFERENCES MARCA (id_Marca)
);
DROP TABLE IF EXISTS PEDIDO;
CREATE TABLE IF NOT EXISTS PEDIDO
(
	id_Cliente int not null,
	N_Pedido smallint not null,
	FechaEmision date not null,
	Emp_Envio nvarchar(100) not null,
	Sub_Total decimal(7,2) not null,
    Descuento decimal(7,2) not null,
	Diret_Envio nvarchar(100) not null,
	Total smallint not null,
	TotalPagar decimal(7,2) not null,
	_Status bool,
    Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    primary key (N_Pedido),
	CONSTRAINT Fk_Pedido_Cliente 
    FOREIGN KEY (id_Cliente)
    REFERENCES CLIENTE(id_Cliente)
);
DROP TABLE IF EXISTS CARRITOCOMPRA;
CREATE TABLE IF NOT EXISTS CARRITOCOMPRA
(
	N_Pedido smallint not null,
	id_Product int not null,
	Car_Cantidad decimal(7,2) not null,
	Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    CONSTRAINT Fk_CarritoCompra_Productos
    FOREIGN KEY  (id_Product)
    REFERENCES PRODUCTOS(id_Product),
    CONSTRAINT Fk_CarritoCompra_Pedido
    FOREIGN KEY (N_Pedido)
    REFERENCES  PEDIDO(N_Pedido)
);
DROP TABLE IF EXISTS HISTORIALCOMPRA;
CREATE TABLE IF NOT EXISTS HISTORIALCOMPRA
(
	N_Pedido smallint not null,
	Cliente nvarchar(100) not null,
	FechaEmision date not null,
	DirecEnvio nvarchar(100) not null,
	SubTotal decimal(7,2) not null,
	Total smallint not null,
	TotalPagar decimal(7,2) not null,
    Descuento decimal(7,2) not null,
    Fecha_Created datetime not null,
    Fecha_Updated datetime not null
);
DROP TABLE IF EXISTS DESCUENTO;
CREATE TABLE IF NOT EXISTS DESCUENTO
(
	id_Product int not null,
    dscto1 smallint ,
    dscto2 smallint ,
    dscto3 smallint ,
    dscto4 smallint ,
	Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    CONSTRAINT Fk_Descuento_Productos
    FOREIGN KEY  (id_Product)
    REFERENCES productos(id_Product)
);
DROP TABLE IF EXISTS CARACTERISTICAS;
CREATE TABLE IF NOT EXISTS CARACTERISTICAS
(
	id_Product int not null,
    Caracteristicas_product nvarchar(1500),
    Fecha_Created datetime not null,
    Fecha_Updated datetime not null,
    CONSTRAINT Fk_Caracterisitcas_Productos
    FOREIGN KEY (id_Product)
    REFERENCES productos(id_Product)
);
#################################################################################################################################
#ALTER TABLE CIUDAD DROP CONSTRAINT Uk_Nombre_Ciudad;
ALTER TABLE CIUDAD ADD CONSTRAINT Uk_Nombre_Ciudad UNIQUE (Uk_Nombre);
#ALTER TABLE PAIS DROP CONSTRAINT Uk_Nombre_Pais;
ALTER TABLE PAIS ADD CONSTRAINT Uk_Nombre_Pais UNIQUE (Uk_Pais);
#ALTER TABLE CLIENTE DROP CONSTRAINT Chk_Correo;
ALTER TABLE CLIENTE ADD CONSTRAINT Chk_Correo CHECK(Correo like '__%@__%.%___');
###############################################PROCEDIMIENTOSALMACENADOS##########################################################
################################################CATEGORIA#########################################################################	
DROP PROCEDURE IF EXISTS sp_InsertCategoria;
DELIMITER $$
CREATE PROCEDURE sp_InsertCategoria
(IN nomCategory VARCHAR(100)
)
sp: BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        rollback;
        SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA CATEGORIA' as message;
    END;
    IF (LENGTH(nomCategory) = 0 or nomCategory = " ")
    THEN
        SELECT 'EL nombre de la categoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
        INSERT INTO CATEGORIA (`Nom_Category`,`Fecha_Created`,`Fecha_Updated`) VALUES (nomCategory,DAT,DAT);
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_UpdateCategoria;
DELIMITER $$
CREATE PROCEDURE sp_UpdateCategoria
(
IN idCategory int,
IN nomCategory NVARCHAR(100)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR UNA CATEGORIA' as message;
	END;
	IF (LENGTH(nomCategory) = 0 or nomCategory = " ")
    THEN
		SELECT 'EL nombre de la categoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idCategory = 0 OR idCategory is null)
    THEN
		SELECT 'EL id de la categoria no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE CATEGORIA SET `Nom_Category`= nomCategory,`Fecha_Updated` = DAT WHERE `id_Categoria` = idCategory;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteCategoria;
DELIMITER $$
CREATE PROCEDURE sp_DeleteCategoria
(
IN categoriaid int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE DELETE UNA CATEGORIA' as message;
	END;
    IF (categoriaid = 0 or categoriaid is null)
    THEN
		SELECT 'EL id de la categoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Categoria FROM categoria WHERE id_Categoria= categoriaid))
    THEN
		SELECT 'No existente Id Categoria para el Delete.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE CAR from subcategorias S join categoria C on(S.id_Category = C.id_Categoria) join productos P on(P.id_SubCategory = S.id_SubCategory) join caracteristicas CAR on(CAR.id_Product = P.id_Product) where C.id_Categoria = categoriaid;
		DELETE DE from subcategorias S join categoria C on(S.id_Category = C.id_Categoria) join productos P on(P.id_SubCategory = S.id_SubCategory) join descuento DE on(DE.id_Product = P.id_Product) where C.id_Categoria = categoriaid;
		DELETE CA from subcategorias S join categoria C on(S.id_Category = C.id_Categoria) join productos P on(P.id_SubCategory = S.id_SubCategory) join carritocompra CA on(CA.id_Product = P.id_Product) where C.id_Categoria = categoriaid;
		DELETE P from subcategorias S join categoria C on(S.id_Category = C.id_Categoria) join productos P on(P.id_SubCategory = S.id_SubCategory) where C.id_Categoria = categoriaid; 
		DELETE S from subcategorias S join categoria C on(S.id_Category = C.id_Categoria) where C.id_Categoria = categoriaid;
		DELETE C FROM categoria C WHERE C.`id_Categoria` = categoriaid;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectCategoryId;
DELIMITER $$
CREATE PROCEDURE sp_SelectCategoryId
(
IN idCategory int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECIONAR CATEGORIA' as message;
	END;
    IF (idCategory = 0 OR idCategory is null)
    THEN
		SELECT 'EL id de la categoria no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		SELECT CA.`id_Categoria` ,CA.`Nom_Category`,CA.`Fecha_Created`,CA.`Fecha_Updated` FROM CATEGORIA AS CA  WHERE CA.`id_Categoria` = idCategory;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sCantidadCategory;
CREATE VIEW v_sCantidadCategory
AS SELECT COUNT(*) CANTIDAD_CATEGORY FROM categoria;

DROP VIEW IF EXISTS v_sSelectCategoria;
CREATE VIEW v_sSelectCategoria
AS SELECT CA.`id_Categoria`,CA.`Nom_Category`,CA.`Fecha_Created`,CA.`Fecha_Updated` FROM CATEGORIA AS CA  LIMIT 30
select * from  v_sSelectCategoria;
#######################################################SUBCATEGORIA ###########################################################################
DROP PROCEDURE IF EXISTS sp_InsertSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_InsertSubCategoria
(
IN idCategory int,
IN nomSubCategory nvarchar(100)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA SUBCATEGORIA' as message;
	END;
	IF (idCategory = 0 or idCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(nomSubCategory) = 0 or nomSubCategory = " ")
    THEN
		SELECT 'EL nombre de la Subcategoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO SUBCATEGORIAS (`id_Category`,`Nom_SubCategory`,`Fecha_Created`,`Fecha_Updated`) VALUES (idCategory,nomSubCategory,DAT,DAT);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_UpdateSubCategoria
(
IN idSubCategory int,
IN idCategory int,
IN NombreSubCategory nvarchar(100)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE SUBCATEGORIA' as message;
	END;
    IF (idSubCategory = 0 or idSubCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
	IF (idCategory = 0 or idCategory is null)
    THEN
		SELECT 'EL id de la Categoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(NombreSubCategory) = 0 or NombreSubCategory = " ")
    THEN
		SELECT 'EL nombre de la Subcategoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE subcategorias SET id_Category = idCategory ,Nom_SubCategory =NombreSubCategory,Fecha_Updated=DAT WHERE id_SubCategory = idSubCategory;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_DeleteSubCategoria
(
IN SubCategory int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL DELETE UNA SUBCATEGORIA' as message;
	END;
    IF (SubCategory = 0 or SubCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_SubCategory FROM subcategorias WHERE id_SubCategory= SubCategory))
    THEN
		SELECT 'No existente Id SubCategoria para el Delete.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE CAR from subcategorias S join productos P on(P.id_SubCategory = S.id_SubCategory) join caracteristicas CAR on(CAR.id_Product = P.id_Product) where S.`id_SubCategory` = SubCategory;
		DELETE DE from subcategorias S join productos P on(P.id_SubCategory = S.id_SubCategory) join descuento DE on(DE.id_Product = P.id_Product) where S.`id_SubCategory` = SubCategory;
		DELETE CA from subcategorias S join productos P on(P.id_SubCategory = S.id_SubCategory) join carritocompra CA on(CA.id_Product = P.id_Product) where S.`id_SubCategory` = SubCategory;
		DELETE P from subcategorias S join productos P on(P.id_SubCategory = S.id_SubCategory) where S.`id_SubCategory` = SubCategory;
		DELETE S from  subcategorias S WHERE S.`id_SubCategory` = SubCategory;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectSubCategoryId;
DELIMITER $$
CREATE PROCEDURE sp_SelectSubCategoryId
(
IN SubCategory int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR UNA SUBCATEGORIA' as message;
	END;
    IF (SubCategory = 0 or SubCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT SUB.`id_SubCategory`,CAT.`Nom_Category` ,SUB.`Nom_SubCategory`,SUB.`Fecha_Created`,SUB.`Fecha_Updated` FROM SUBCATEGORIAS AS SUB
        JOIN CATEGORIA AS CAT
        ON(SUB.`id_Category` = CAT.`id_Categoria`)
        WHERE SUB.`id_SubCategory` = SubCategory;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectSubCategoryXCategory;
DELIMITER $$
CREATE PROCEDURE sp_SelectSubCategoryXCategory
(
IN category smallint
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
    DECLARE a INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (category = 0)
    THEN
		SELECT 'La category de la Subcategoria no puede ser nula.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET a = ( SELECT count(*) from SUBCATEGORIAS SUB JOIN CATEGORIA CA ON(SUB.id_Category = CA.id_Categoria) WHERE CA.id_Categoria = category);
        IF (a>0)
        THEN
			SELECT SUB.id_SubCategory,SUB.Nom_SubCategory
            FROM SUBCATEGORIAS SUB JOIN CATEGORIA CA
            ON(SUB.id_Category = CA.id_Categoria)
            WHERE CA.id_Categoria = category
            GROUP BY SUB.Nom_SubCategory;
        ELSEIF(a=0)THEN 
			SELECT 'No encontrado registro de SubCategorias de la Categoria.' as message;
        END IF;
    COMMIT; 
END;
DROP VIEW IF EXISTS v_sCantidadSubCategory;
CREATE VIEW v_sCantidadSubCategory
AS SELECT COUNT(*) CANTIDAD_SUBCATEGORY FROM subcategorias;

DROP VIEW IF EXISTS v_sSelectSubCategoria;
CREATE VIEW v_sSelectSubCategoria
AS SELECT SUB.`id_SubCategory`,CAT.`Nom_Category`,SUB.`Nom_SubCategory`,SUB.`Fecha_Created`,SUB.`Fecha_Updated` FROM
SUBCATEGORIAS AS SUB JOIN CATEGORIA AS CAT ON(SUB.`id_Category` = CAT.`id_Categoria`) LIMIT 30
##########################################################MARCA##########################################################################
DROP PROCEDURE IF EXISTS sp_InsertMarca;
DELIMITER $$
CREATE PROCEDURE sp_InsertMarca
(
IN NomMarca nvarchar(100)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA MARCA' as message;
	END;
    IF (LENGTH(NomMarca) = 0 or NomMarca = " ")
    THEN
		SELECT 'EL nombre de la Marca no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (exists(SELECT Nom_Marca FROM MARCA  WHERE Nom_Marca = NomMarca))
    THEN
		SELECT 'Existente Marca.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO MARCA (`Nom_Marca`,`Fecha_Created`,`Fecha_Updated`) VALUES (NomMarca,DAT,DAT);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateMarca;
DELIMITER $$
CREATE PROCEDURE sp_UpdateMarca
(
IN idMarca int,
IN NomMarca nvarchar(100)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE MARCA' as message;
	END;
    IF (idMarca = 0 or idMarca is null)
    THEN
		SELECT 'EL id de la Marca no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(NomMarca) = 0 or NomMarca = " ")
    THEN
		SELECT 'EL nombre de la Marca no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE Marca SET Nom_Marca = NomMarca,Fecha_Updated=DAT WHERE id_Marca= idMarca;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteMarca;
DELIMITER $$
CREATE PROCEDURE sp_DeleteMarca
(
IN idMarca int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL DELETE UNA MARCA' as message;
	END;
    IF (idMarca = 0 or idMarca is null)
    THEN
		SELECT 'EL id de la Marca no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Marca FROM MARCA WHERE id_Marca= idMarca))
    THEN
		SELECT 'No existente Marca para el Delete.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE CAR from marca M join productos P on(P.id_Marca = M.id_Marca) join caracteristicas CAR on(CAR.id_Product = P.id_Product) where M.`id_Marca` = idMarca;
		DELETE DE from marca M join productos P on(P.id_Marca = M.id_Marca) join descuento DE on(DE.id_Product = P.id_Product) where M.`id_Marca` = idMarca;
		DELETE CA from marca M join productos P on(P.id_Marca = M.id_Marca) join carritocompra CA on(CA.id_Product = P.id_Product) where M.`id_Marca` = idMarca;
		DELETE P from marca M join productos P on(P.id_Marca = M.id_Marca) where M.`id_Marca` = idMarca;
        DELETE M from  marca M WHERE M.`id_Marca` = id_Marca;
    COMMIT; 
    
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectMarcaId;
DELIMITER $$
CREATE PROCEDURE  sp_SelectMarcaId
(
IN idMarca int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR UNA MARCA' as message;
	END;
    IF (idMarca = 0 or idMarca is null)
    THEN
		SELECT 'EL id de la Marca no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT M.`id_Marca`,M.`Nom_Marca` ,M.`Fecha_Created`,M.`Fecha_Updated` FROM MARCA AS M
        WHERE M.`id_Marca` = idMarca;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sCantidadMarca;
CREATE VIEW v_sCantidadMarca
AS SELECT COUNT(*) CANTIDAD_MARCA FROM marca;

DROP VIEW IF EXISTS v_sSelectMarca;
CREATE VIEW v_sSelectMarca
AS  SELECT M.`id_Marca`,M.`Nom_Marca` ,M.`Fecha_Created`,M.`Fecha_Updated` FROM MARCA AS M LIMIT 30
##########################################################PRODUCTOS#####################################################################
DROP PROCEDURE IF EXISTS sp_InsertProductos;
DELIMITER $$
CREATE PROCEDURE sp_InsertProductos
(
IN NombreProduct nvarchar(100),
IN idMarca int,
IN idSubCategory int,
IN descripcion nvarchar(500),
IN precio decimal(7,2),
IN stock smallint,
IN unidad nvarchar(10),
IN moneda nvarchar(20),
IN image1 nvarchar(250),
IN image2 nvarchar(250),
IN image3 nvarchar(250), 
IN image4 nvarchar(250), 
IN image5 nvarchar(250), 
IN NDescuento smallint,
IN _Status bool
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO PRODUCTO' as message;
	END;
    IF (LENGTH(NombreProduct) = 0 or NombreProduct= " ")
    THEN
		SELECT 'El nombre del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idMarca = 0 or idMarca= " ")
    THEN
		SELECT 'El id de la Marca no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
	IF (idSubCategory = 0 or idSubCategory is null)
    THEN
		SELECT 'El id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (NDescuento = 0 or NDescuento is null)
    THEN
		SELECT 'El NDescuento del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(descripcion) = 0 or descripcion= " ")
    THEN
		SELECT 'La descripción del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (precio < 0 or precio is null)
    THEN
		SET precio = 0;
		SELECT 'El precio del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (stock < 0 or stock is null)
    THEN
		SET stock = 0;
		SELECT 'El stock del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(unidad) = 0 or unidad= " ")
    THEN
		SELECT 'La unidad del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(moneda) = 0 or moneda= " ")
    THEN
		SELECT 'La moneda del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (_Status < 0 or _Status is null)
    THEN
		SET _Status = 0;
        SELECT 'El Status del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO PRODUCTOS (`Nombre_Product`,`id_Marca`,`id_SubCategory`,`Descript_Product`,`Precio`,`Stock`,`Unidad`,`Moneda`,`Img1`,`Img2`,`Img3`,`Img4`,`Img5`,`NDescuento`,`_Status`,`Fecha_Created`,`Fecha_Updated`) VALUES (NombreProduct,idMarca,idSubCategory,descripcion,precio,stock,unidad,moneda,image1,image2,image3,image4,image5,NDescuento,_Status,DAT,DAT);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateProducto;
DELIMITER $$
CREATE PROCEDURE sp_UpdateProducto
(
IN idproduct int,
IN NombreProduct nvarchar(100),
IN idMarca int,
IN idSubCategory int,
IN descripcion nvarchar(500),
IN precio decimal(7,2),
IN stock smallint,
IN unidad nvarchar(10),
IN moneda nvarchar(20),
IN image1 nvarchar(250),
IN image2 nvarchar(250),
IN image3 nvarchar(250), 
IN image4 nvarchar(250), 
IN image5 nvarchar(250),
IN NDescuento smallint,
IN _Status bool
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR UN NUEVO PRODUCTO' as message;
	END;
    IF (LENGTH(NombreProduct) = 0 or NombreProduct= " ")
    THEN
		SELECT 'El nombre del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idMarca = 0 or idMarca= " ")
    THEN
		SELECT 'El id de la Marca no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
	IF (idSubCategory = 0 or idSubCategory is null)
    THEN
		SELECT 'El id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (NDescuento = 0 or NDescuento is null)
    THEN
		SELECT 'El NDescuento del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(descripcion) = 0 or descripcion= " ")
    THEN
		SELECT 'La descripción del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (precio < 0 or precio is null)
    THEN
		SET precio = 0;
		SELECT 'El precio del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (stock < 0 or stock is null)
    THEN
		SET stock = 0;
		SELECT 'El stock del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(unidad) = 0 or unidad= " ")
    THEN
		SELECT 'La unidad del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(moneda) = 0 or moneda= " ")
    THEN
		SELECT 'La moneda del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (_Status < 0 or _Status is null)
    THEN
		SET _Status = 0;
        SELECT 'El Status del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE Productos SET `Nombre_Product`=NombreProduct,`id_Marca`=idMarca,`id_SubCategory`=idSubCategory,`Descript_Product`=descripcion,`Precio`=precio,`Stock`=stock,`Unidad`=unidad,`Moneda`=moneda,`Img1`=image1,`Img2`=image2,`Img3`=image3,`Img4`=image4,`Img5`=image5,`NDescuento` = NDescuento ,`_Status` = _Status,`Fecha_Updated`= DAT WHERE `id_Product` = idproduct; 
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteProducto;
DELIMITER $$
CREATE PROCEDURE sp_DeleteProducto
(
IN idproduct int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE DELETE UN PRODUCTO' as message;
	END;
    IF (idproduct = 0 or idproduct is null)
    THEN
		SELECT 'EL id del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Product FROM productos WHERE id_Product= idproduct))
    THEN
		SELECT 'No existente Id Producto para el Delete.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE CAR from productos P join caracteristicas CAR on(CAR.id_Product = P.id_Product) where P.`id_Product` = idproduct;
		DELETE DE from productos P join descuento DE on(DE.id_Product = P.id_Product) where P.`id_Product` = idproduct;
		DELETE CA from productos P join carritocompra CA on(CA.id_Product = P.id_Product) where P.`id_Product` = idproduct;
		DELETE P FROM productos AS P WHERE P.`id_Product` = idproduct;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectProductoId;
DELIMITER $$
CREATE PROCEDURE sp_SelectProductoId
(
IN idproducto int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECIONAR PRODUCTO' as message;
	END;
    IF (idproducto = 0 OR idproducto is null)
    THEN
		SELECT 'EL id del producto no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SELECT PD.`id_Product`,PD.`Nombre_Product`,M.`Nom_Marca`,PD.`Descript_Product`,PD.`Precio`,PD.`Stock`,PD.`Unidad`,PD.`Moneda`,SUB.`Nom_SubCategory`,CAT.`Nom_Category`,PD.`Img1`,PD.`Img2`,PD.`Img3`,PD.`Img4`,PD.`Img5`,PD.`NDescuento`,PD.`_Status`,DE.`dscto1`,DE.`dscto2`,DE.`dscto3`,DE.`dscto4`,CAR.`Caracteristicas_product`,PD.`Fecha_Created`,PD.`Fecha_Updated`
		FROM PRODUCTOS as PD
		JOIN SUBCATEGORIAS as SUB
		ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
		JOIN CATEGORIA AS CAT
		ON(SUB.`id_Category` = CAT.`id_Categoria`)
        JOIN DESCUENTO AS DE
        ON(DE.id_Product = PD.id_Product)
        JOIN caracteristicas AS CAR
        ON(CAR.id_Product = PD.id_Product)
        JOIN Marca as M
        ON(PD.id_Marca = M.id_Marca)
        WHERE PD.`id_Product`=idproducto;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectProdXSubCategory;
DELIMITER $$
CREATE PROCEDURE sp_SelectProdXSubCategory
(
IN subcategory smallint
)
sp:BEGIN
    DECLARE a INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (LENGTH(subcategory) = 0 )
    THEN
		SELECT 'La subcategory del producto no puede ser nula.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET a = (select count(*) from productos PRO JOIN SUBCATEGORIAS SUB ON(PRO.id_SubCategory = SUB.id_SubCategory)  WHERE SUB.id_SubCategory = subcategory);
        IF (a>0)
        THEN
            SELECT PD.`id_Product`,PD.Nombre_Product,M.`Nom_Marca`,PD.`Descript_Product`,PD.`Precio`,PD.`Stock`,PD.`Unidad`,PD.`Moneda`,PD.`Fecha_Created`,CAT.`Nom_Category`,PD.`Img1`,PD.`Img2`,PD.`Img3`,PD.`Img4`,PD.`Img5`,PD.`NDescuento`,PD.`_Status`,DE.`dscto1`,DE.`dscto2`,DE.`dscto3`,DE.`dscto4`
            FROM PRODUCTOS as PD
            JOIN SUBCATEGORIAS as SUB
            ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
            JOIN CATEGORIA AS CAT
            ON(SUB.`id_Category` = CAT.`id_Categoria`)JOIN DESCUENTO AS DE
            ON(DE.id_Product = PD.id_Product)JOIN Marca as M
            ON(PD.id_Marca = M.id_Marca)
            WHERE SUB.id_SubCategory = subcategory
            AND PD._Status = 1
            GROUP BY PD.Nombre_Product;
		ELSEIF(a=0)THEN 
			SELECT 'No encontrado registro de Productos de la SubCategoria' as message;
        END IF;
    COMMIT; 
END;
DROP PROCEDURE IF EXISTS sp_SelectProdXSubCategoryXPrecio;
DELIMITER $$
CREATE PROCEDURE sp_SelectProdXSubCategoryXPrecio
(
IN subcategory nvarchar(50),
IN precio decimal(7,2) 
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
    DECLARE a INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (LENGTH(subcategory) = 0 or subcategory = " ")
    THEN
		SELECT 'La subcategory del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT_WS(' ',subcategory);
        SET a = (select count(*) from productos PRO JOIN SUBCATEGORIAS SUB ON(PRO.id_SubCategory = SUB.id_SubCategory)  WHERE SUB.Nom_SubCategory = _consultalike and PRO.Precio = precio); 
        IF (a>0)
        THEN
			SELECT PD.`id_Product`,PD.Nombre_Product,M.`Nom_Marca`,PD.`Descript_Product`,PD.`Precio`,PD.`Stock`,PD.`Unidad`,PD.`Moneda`,SUB.`Nom_SubCategory`,CAT.`Nom_Category`,PD.`Img1`,PD.`Img2`,PD.`Img3`,PD.`Img4`,PD.`Img5`,PD.`NDescuento`,PD.`_Status`,DE.`dscto1`,DE.`dscto2`,DE.`dscto3`,DE.`dscto4`
			FROM PRODUCTOS as PD
			JOIN SUBCATEGORIAS as SUB
			ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
			JOIN CATEGORIA AS CAT
			ON(SUB.`id_Category` = CAT.`id_Categoria`)JOIN DESCUENTO AS DE
			ON(DE.id_Product = PD.id_Product) JOIN Marca as M
			ON(PD.id_Marca = M.id_Marca)
            WHERE SUB.Nom_SubCategory = _consultalike AND PD.Precio = precio
			GROUP BY PD.Nombre_Product;
		ELSEIF(a=0)THEN
			SELECT PD.`id_Product`,PD.Nombre_Product,M.`Nom_Marca`,PD.`Descript_Product`,PD.`Precio`,PD.`Stock`,PD.`Unidad`,PD.`Moneda`,SUB.`Nom_SubCategory`,CAT.`Nom_Category`,PD.`Img1`,PD.`Img2`,PD.`Img3`,PD.`Img4`,PD.`Img5`,PD.`NDescuento`,PD.`_Status`,DE.`dscto1`,DE.`dscto2`,DE.`dscto3`,DE.`dscto4`
			FROM PRODUCTOS as PD
			JOIN SUBCATEGORIAS as SUB
			ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
			JOIN CATEGORIA AS CAT
			ON(SUB.`id_Category` = CAT.`id_Categoria`)JOIN DESCUENTO AS DE
			ON(DE.id_Product = PD.id_Product)JOIN Marca as M
			ON(PD.id_Marca = M.id_Marca)
            WHERE SUB.Nom_SubCategory = _consultalike 
			GROUP BY PD.Nombre_Product;
        END IF;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectConsultaProd;
DELIMITER $$
CREATE PROCEDURE sp_SelectConsultaProd
(
IN consulta nvarchar(500)
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(500) ;
    DECLARE a INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (LENGTH(consulta) = 0 or consulta = " ")
    THEN
		SELECT 'La consulta del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT('%',consulta,'%');
        SET a =(select count(*) from productos PRO JOIN SUBCATEGORIAS SUB ON(PRO.id_SubCategory = SUB.id_SubCategory) JOIN CATEGORIA CA ON(SUB.id_Category = CA.id_Categoria) JOIN MARCA M ON(PRO.id_Marca =M.id_Marca) WHERE CA.Nom_Category like _consultalike or SUB.Nom_SubCategory like _consultalike or PRO.Nombre_Product like _consultalike or M.Nom_Marca like _consultalike or PRO.Descript_Product like _consultalike);
        IF (a>0)
        THEN
			SELECT PD.`id_Product`,PD.Nombre_Product,M.Nom_Marca,PD.`Descript_Product`,PD.`Precio`,PD.`Stock`,PD.`Unidad`,PD.`Moneda`,SUB.`Nom_SubCategory`,CAT.`Nom_Category`,PD.`Img1`,PD.`Img2`,PD.`Img3`,PD.`Img4`,PD.`Img5`,PD.`NDescuento`,PD.`_Status`,DE.`dscto1`,DE.`dscto2`,DE.`dscto3`,DE.`dscto4`
			FROM PRODUCTOS as PD
			JOIN SUBCATEGORIAS as SUB
			ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
			JOIN CATEGORIA AS CAT 
			ON(SUB.`id_Category` = CAT.`id_Categoria`)
            JOIN DESCUENTO AS DE
			ON(DE.id_Product = PD.id_Product)JOIN Marca as M
			ON(PD.id_Marca = M.id_Marca)
            WHERE CAT.Nom_Category like _consultalike OR
			SUB.Nom_SubCategory like _consultalike OR
			PD.Nombre_Product like _consultalike OR
            M.Nom_Marca like _consultalike OR
            PD.Descript_Product like _consultalike 
            limit 30;
		ELSEIF(a=0)THEN 
			SELECT 'SIN SUGERENCIAS' as message;
        END IF;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sCantidadProduct;
CREATE VIEW v_sCantidadProduct
AS SELECT COUNT(*) CANTIDAD_PRODUCTOS FROM productos;

DROP VIEW IF EXISTS v_sSelectProducto;
CREATE VIEW v_sSelectProducto
AS 	SELECT PD.`id_Product`,PD.Nombre_Product,M.Nom_Marca,PD.`Descript_Product`,
	PD.`Precio`,PD.`Stock`,PD.`Unidad`,PD.`Moneda`,SUB.`Nom_SubCategory`,CAT.`Nom_Category`,
    PD.`Img1`,PD.`Img2`,PD.`Img3`,PD.`Img4`,PD.`Img5`,PD.`NDescuento`,PD.`_Status`,PD.`Fecha_Created`,PD.`Fecha_Updated`
	FROM PRODUCTOS as PD JOIN SUBCATEGORIAS as SUB ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
	JOIN CATEGORIA AS CAT ON(SUB.`id_Category` = CAT.`id_Categoria`) JOIN DESCUENTO AS DE ON(DE.id_Product = PD.id_Product)
    JOIN Marca as M ON(PD.id_Marca = M.id_Marca) LIMIT 30;
############################################################ PAIS ################################################################################################
DROP PROCEDURE IF EXISTS sp_InsertPais;
DELIMITER $$
CREATE PROCEDURE sp_InsertPais
(IN nom_Pais NVARCHAR(100))
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO PAIS' as message;
	END;
    IF (LENGTH(nom_Pais) = 0 or nom_Pais = " ")
     THEN 
     	SELECT 'EL nombre del pais no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
	END IF; 
    START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO PAIS (`Uk_Pais`,`Fecha_Created`,`Fecha_Updated`) VALUES (nom_Pais,DAT,DAT);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdatePais;
DELIMITER $$
CREATE PROCEDURE sp_UpdatePais
(
IN idCountry int,
IN nomCountry NVARCHAR(100)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE UN PAIS' as message;
	END;
	IF (LENGTH(nomCountry) = 0 or nomCountry = " ")
    THEN
		SELECT 'EL nombre del pais no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
	END IF;
    IF (idCountry = 0 OR idCountry is null)
    THEN
		SELECT 'EL id del pais no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE pais SET Uk_Pais = nomCountry,Fecha_Updated=DAT WHERE id_Pais = idCountry;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeletePais;
DELIMITER $$
CREATE PROCEDURE sp_DeletePais
(
IN Countryid int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE DELETE UN PAIS' as message;
	END;
    IF (Countryid = 0 OR Countryid is null)
    THEN
		SELECT 'EL id del pais no puede ser nula o igual a cero.' as message;
        LEAVE sp;
	END IF;
    IF (not exists(SELECT id_Pais FROM PAIS WHERE id_Pais= Countryid))
    THEN
		SELECT 'No existente Id Pais para el Delete.' as message;
        LEAVE sp;
	END IF;
    START TRANSACTION;
		DELETE D from PAIS P JOIN CIUDAD C ON(C.id_Pais = P.id_Pais) JOIN DIRECCIONES D ON(D.id_Ciudad =C.id_Ciudad) WHERE P.`id_Pais` = Countryid;
		DELETE C from PAIS P JOIN CIUDAD C ON(C.id_Pais = P.id_Pais) WHERE P.`id_Pais` = Countryid;
		DELETE P from PAIS P WHERE P.`id_Pais` = Countryid;
	COMMIT;
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectPaisId;
DELIMITER $$
CREATE PROCEDURE sp_SelectPaisId
(
IN paisid int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECIONAR COUNTRY' as message;
	END;
    IF (paisid = 0 or paisid is null)
    THEN
		SELECT 'EL id del country no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT id_Pais,Uk_Pais,Fecha_Created,Fecha_Updated FROM PAIS WHERE id_Pais = paisid;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sCantidadCountry;
CREATE VIEW v_sCantidadCountry AS SELECT COUNT(*) CANTIDAD_COUNTRY FROM pais;

DROP VIEW IF EXISTS v_SelectPais;
CREATE VIEW v_SelectPais
AS SELECT PS.id_Pais,PS.`Uk_Pais`,PS.`Fecha_Created`,PS.`Fecha_Updated` FROM PAIS AS PS LIMIT 30;
###########################################################CIUDAD############################################################################################
DROP PROCEDURE IF EXISTS sp_InsertCiudad;
DELIMITER $$
CREATE PROCEDURE sp_InsertCiudad
(IN idPais int,
IN nomCiudad NVARCHAR(100)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO CIUDAD' as message;
	END;
    IF ((idPais = 0 or idPais is null))
     THEN 
     	SELECT 'EL id de la ciudad no puede ser nula o igual a cero.' as message;
        LEAVE sp;
	END IF;  
	IF (LENGTH(nomCiudad) = 0 or nomCiudad = " ")
    THEN
		 SELECT 'EL nombre de la ciudad no puede ser nula o con valor en blanco.' as message;
         LEAVE sp;
	END IF; 	
	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO CIUDAD (`id_Pais`,`Uk_Nombre`,`Fecha_Created`,`Fecha_Updated`) VALUES (idPais,nomCiudad,DAT,DAT);
	COMMIT;    	
END;

DROP PROCEDURE IF EXISTS sp_UpdateCiudad;
DELIMITER $$
CREATE PROCEDURE sp_UpdateCiudad
(
IN idCiudad int,
IN idPais int,
IN nomCiudad NVARCHAR(100)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE UNA CIUDAD' as message;
	END;
	IF (LENGTH(idCiudad) = 0 or idCiudad = " ")
    THEN
		SELECT 'EL id de la Ciudad no puede ser nula o cero.' as message;
        LEAVE sp;
	END IF;
	IF (LENGTH(idPais) = 0 or idPais = " ")
    THEN
		SELECT 'EL id del Pais no puede ser nula o cero..' as message;
        LEAVE sp;
	END IF;
    IF (LENGTH(nomCiudad) = 0 or nomCiudad = " ")
    THEN
		SELECT 'EL nombre de la ciudad no puede ser nula o con valor en blanco.'  as message;
        LEAVE sp;
	END IF;
	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE CIUDAD SET id_Pais = idPais , Uk_Nombre = nomCiudad,Fecha_Updated=DAT  WHERE id_Ciudad= idCiudad;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteCiudad;
DELIMITER $$
CREATE PROCEDURE sp_DeleteCiudad
(
IN idCiudad int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE DELETE UNA CIUDAD' as message;
	END;
    IF (idCiudad = 0 OR idCiudad is null)
    THEN
		SELECT 'EL id de la ciudad no puede ser nula o igual a cero.' as message;
        LEAVE sp;
	END IF;
     IF (not exists(SELECT id_Ciudad FROM CIUDAD WHERE id_Ciudad = idCiudad))
    THEN
		SELECT 'No existente id Ciudad para el Delete.' as message;
        LEAVE sp;
	END IF;
	START TRANSACTION;
		DELETE D from CIUDAD C JOIN DIRECCIONES D ON(D.id_Ciudad =C.id_Ciudad) WHERE C.`id_Ciudad` = idCiudad;
		DELETE C from CIUDAD C WHERE C.`id_Ciudad` = idCiudad;
	COMMIT;
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectCiudadId;
DELIMITER $$
CREATE PROCEDURE sp_SelectCiudadId
(
IN ciudadid int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR UNA CIUDAD' as message;
	END;
    IF (ciudadid= 0 or ciudadid  is null)
    THEN
		SELECT 'EL id de la Ciudad no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        select C.id_Ciudad,P.Uk_Pais,C.Uk_Nombre,C.Fecha_Created,C.Fecha_Updated
        from ciudad C join pais P on(C.id_Pais = P.id_Pais) WHERE id_Ciudad = ciudadid;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectCiudadesXPais;
DELIMITER $$
CREATE PROCEDURE sp_SelectCiudadesXPais
(
IN NombreCountry nvarchar(100)
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
    DECLARE a INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (LENGTH(NombreCountry) = 0 or NombreCountry = " ")
    THEN
		SELECT 'El Nombre del country no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT_WS(' ',NombreCountry);
        SET a = ( select count(*) from ciudad CI JOIN pais P ON(CI.id_Pais = P.id_Pais) WHERE P.Uk_Pais = _consultalike);
        IF (a>0)
        THEN
			SELECT CI.id_Ciudad,CI.Uk_Nombre FROM 
            ciudad CI JOIN pais P ON(CI.id_Pais = P.id_Pais) WHERE P.Uk_Pais =  _consultalike
			GROUP BY CI.Uk_Nombre;
		ELSEIF(a=0)THEN 
			SELECT 'No encontrado registro de Ciudades del Country' as message;
        END IF;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sCantidadCity;
CREATE VIEW v_sCantidadCity AS SELECT COUNT(*) CANTIDAD_CITY FROM ciudad;

DROP VIEW IF EXISTS v_sSelectCiudad;
CREATE VIEW v_sSelectCiudad
AS SELECT CIU.`id_Ciudad`,PS.`Uk_Pais`,CIU.`Uk_Nombre`,CIU.`Fecha_Created`,CIU.`Fecha_Updated` FROM CIUDAD AS CIU JOIN PAIS AS PS ON(CIU.`id_Pais` = PS.`id_Pais`) LIMIT 30
#############################################CLIENTE###############################################################################
DROP PROCEDURE IF EXISTS sp_InsertCliente;
DELIMITER $$
CREATE PROCEDURE sp_InsertCliente
(
IN Nombre_Cliente nvarchar(250),
IN Apellido_Cliente nvarchar(250),
IN Edad_Cliente smallint,
IN Correo nvarchar(250),
IN Contacto char(20),
IN Img nvarchar(250) 
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR CLIENTE' as message;
	END;
    IF (LENGTH(Nombre_Cliente) = 0 or Nombre_Cliente= " ")
    THEN
		SELECT 'El nombre del cliente no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
     IF (LENGTH(Apellido_Cliente) = 0 or Apellido_Cliente= " ")
    THEN
		SELECT 'El apellido del cliente no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (Edad_Cliente= 0 or Edad_Cliente is null)
    THEN
		SELECT 'La edad del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Contacto) = 0 or Contacto= " ")
    THEN
		SELECT 'El contacto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO CLIENTE(`Nombre_Cliente`,`Apellido_Cliente`,`Edad_Cliente`,`Correo`,`Contacto`,`Img`,`Fecha_Created`,`Fecha_Updated`) VALUES (Nombre_Cliente,Apellido_Cliente,Edad_Cliente,Correo,Contacto,Img,DAT,DAT);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateCliente;
DELIMITER $$
CREATE PROCEDURE sp_UpdateCliente
(
IN idCliente int,
IN NombreCliente nvarchar(250),
IN ApellidoCliente nvarchar(250),
IN EdadCliente smallint,
IN Correo nvarchar(250),
IN Contacto char(20),
IN Img nvarchar(250) 
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR CLIENTE' as message;
	END;
    IF (idCliente= 0 or idCliente is null)
    THEN
		SELECT 'EL id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(NombreCliente) = 0 or NombreCliente= " ")
    THEN
		SELECT 'El nombre del cliente no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
     IF (LENGTH(ApellidoCliente) = 0 or ApellidoCliente= " ")
    THEN
		SELECT 'El apellido del cliente no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (EdadCliente= 0 or EdadCliente is null)
    THEN
		SELECT 'La edad del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Contacto) = 0 or Contacto= " ")
    THEN
		SELECT 'El contacto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE CLIENTE SET `Nombre_Cliente`=NombreCliente,`Apellido_Cliente`=ApellidoCliente,`Edad_Cliente`= EdadCliente,`Correo`= Correo,`Contacto`= Contacto,`Img` = Img ,`Fecha_Updated`=DAT WHERE `id_Cliente` = idCliente;
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_DeleteCliente;
DELIMITER $$
CREATE PROCEDURE sp_DeleteCliente
(
IN idCliente int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR CLIENTE' as message;
	END;
    IF (idCliente= 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
			DELETE S FROM CLIENTE C JOIN PEDIDO P ON(P.id_Cliente= C.id_Cliente) JOIN CARRITOCOMPRA S ON(S.N_Pedido = P.N_Pedido) WHERE C.id_Cliente = idCliente;
			DELETE P FROM CLIENTE C JOIN PEDIDO P ON(P.id_Cliente= C.id_Cliente) WHERE C.id_Cliente = idCliente;
			DELETE M FROM CLIENTE C JOIN MEDIOPAGO M ON(M.id_Cliente= C.id_Cliente) WHERE C.id_Cliente = idCliente;
			DELETE U FROM CLIENTE C JOIN USER_ U ON(U.id_Cliente = C.id_Cliente) WHERE C.id_Cliente = idCliente;
			DELETE D FROM CLIENTE C JOIN DIRECCIONES D ON(D.id_Cliente = C.id_Cliente) WHERE C.id_Cliente = idCliente;
			DELETE C FROM CLIENTE C WHERE C.id_Cliente = idCliente;
	COMMIT;
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectClientsId;
DELIMITER $$
CREATE PROCEDURE sp_SelectClientsId
(
IN idCliente int
)
sp:BEGIN
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'EL id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT CL.`id_Cliente`,CL.`Nombre_Cliente`,CL.`Apellido_Cliente`,CL.`Edad_Cliente`,CL.`Correo`,CL.`Contacto`,CL.`Img`,CL.`Fecha_Created`,CL.`Fecha_Updated`
        FROM CLIENTE AS CL
        WHERE CL.`id_Cliente` = idCliente;
    COMMIT; 
END;	

DROP VIEW IF EXISTS v_sCantidadClients;
CREATE VIEW v_sCantidadClients AS SELECT COUNT(*) CANTIDAD_CLIENTE FROM cliente;

DROP VIEW IF EXISTS v_sSelectCliente;
CREATE VIEW v_sSelectCliente
AS 	SELECT CL.`id_Cliente`,CL.`Nombre_Cliente`,CL.`Apellido_Cliente`,CL.`Edad_Cliente`,CL.`Correo`,CL.`Contacto`,CL.Img,
CL.`Fecha_Created`,CL.`Fecha_Updated` FROM CLIENTE AS CL LIMIT 30

select * from v_sSelectCliente;
#################################################################### DIRECCIONES ############################################################################
DROP PROCEDURE IF EXISTS sp_InsertDireccion;
DELIMITER $$
CREATE PROCEDURE sp_InsertDireccion
(
IN idCliente int,
IN Direccion nvarchar(50),
IN idCiudad int
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA DIRECCIÓN' as message;
	END;
	IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Direccion) = 0 or Direccion= " ")
    THEN
		SELECT 'La direccion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idCiudad = 0 or idCiudad is null)
    THEN
		SELECT 'El id de la ciudad no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO DIRECCIONES (`id_Cliente`,`Direccion`,`id_Ciudad`,`Fecha_Created`,`Fecha_Updated`) VALUES (idCliente,Direccion,idCiudad,DAT,DAT);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateDireccion;
DELIMITER $$
CREATE PROCEDURE sp_UpdateDireccion
(
IN idDirec int,
IN Direccion nvarchar(50),
IN idCiudad int
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE LA DIRECCIÓN' as message;
	END;
    IF (idDirec = 0 or idDirec is null)
    THEN
		SELECT 'El id de la direccion no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Direccion) = 0 or Direccion= " ")
    THEN
		SELECT 'La direccion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idCiudad = 0 or idCiudad is null)
    THEN
		SELECT 'El id de la ciudad no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE DIRECCIONES SET `Direccion` = Direccion ,`id_Ciudad` = idCiudad,`Fecha_Updated`=DAT  WHERE `id_Direct` = idDirec; 
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteDireccion;
DELIMITER $$
CREATE PROCEDURE sp_DeleteDireccion
(
IN idDirect int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DELETE UNA DIRECCION' as message;
	END;
    IF (idDirect = 0 or idDirect is null)
    THEN
		SELECT 'EL id de la direccion no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Direct FROM direcciones WHERE id_Direct = idDirect))
    THEN
		SELECT 'No existente id Direccion para el Delete.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM DIRECCIONES WHERE `id_Direct` = idDirect ;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectDireccionId;
DELIMITER $$
CREATE PROCEDURE sp_SelectDireccionId
(
IN idDirect int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR DIRECCION' as message;
	END;
    IF (idDirect = 0 or idDirect is null)
    THEN
		SELECT 'EL id del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT DIR.`id_Direct`,CONCAT_WS(' ',CLI.Nombre_Cliente,CLI.Apellido_Cliente) AS Cliente,DIR.`Direccion`,CIU.`Uk_Nombre`,PS.`Uk_Pais` ,DIR.`Fecha_Created`,DIR.`Fecha_Updated`
		FROM DIRECCIONES as DIR
		JOIN CLIENTE as CLI
		ON (DIR.`id_Cliente` = CLI.`id_Cliente`)
		JOIN CIUDAD AS CIU
		ON(DIR.`id_Ciudad` = CIU.`id_Ciudad`)
		JOIN PAIS AS PS
		ON(CIU.id_Pais  = PS.`id_Pais`)
        WHERE DIR.`id_Direct` = idDirect ;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sSelectDireccion;
CREATE VIEW v_sSelectDireccion
AS
	SELECT DIR.`id_Direct`,CLI.`id_Cliente`,CONCAT_WS(' ',CLI.Nombre_Cliente,CLI.Apellido_Cliente) AS Cliente,
    DIR.`Direccion`,CIU.id_Ciudad,CIU.`Uk_Nombre`,PS.`Uk_Pais`,DIR.`Fecha_Created`,DIR.`Fecha_Updated`
	FROM DIRECCIONES as DIR JOIN CLIENTE as CLI ON (DIR.`id_Cliente` = CLI.`id_Cliente`)
	JOIN CIUDAD AS CIU ON(DIR.`id_Ciudad` = CIU.`id_Ciudad`) JOIN PAIS AS PS
	ON(CIU.id_Pais  = PS.`id_Pais`) LIMIT 30;
DROP VIEW IF EXISTS v_sCantidadDireccion;
CREATE VIEW v_sCantidadDireccion
	AS SELECT COUNT(*) CANTIDAD_DIRECCION FROM direcciones;
###################################################################ROL##############################################################################
DROP PROCEDURE IF EXISTS sp_InsertRoll;
DELIMITER $$
CREATE PROCEDURE sp_InsertRoll
(
IN DescriptRoll nvarchar(50),
IN Value_ char(6)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO ROL' as message;
	END;
    IF (LENGTH(DescriptRoll) = 0 or DescriptRoll= " ")
    THEN
		SELECT 'La descripcion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Value_) = 0 or Value_= " ")
    THEN
		SELECT 'El Valor no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO ROLL (`Descript_Roll`,`_Value`,`Fecha_Created`,`Fecha_Updated`) VALUES (DescriptRoll,Value_,DAT,DAT);
    COMMIT; 
END;
DROP PROCEDURE IF EXISTS sp_UpdateRoll;
DELIMITER $$
CREATE PROCEDURE sp_UpdateRoll
(
IN idRoll int,
IN DescriptRoll nvarchar(50),
IN Value_ char(6)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE EL ROLL' as message;
	END;
    IF (idRoll = 0 or idRoll is null)
    THEN
		SELECT 'El id del rol no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(DescriptRoll) = 0 or DescriptRoll=" ")
    THEN
		SELECT 'La descripcion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Value_) = 0 or Value_= " ")
    THEN
		SELECT 'El Valor no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE ROLL SET `Descript_Roll` = DescriptRoll,`_Value` = Value_,`Fecha_Updated`=DAT WHERE `id_Roll` = idRoll; 
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteRoll;
DELIMITER $$
CREATE PROCEDURE sp_DeleteRoll
(
IN idRoll int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR UN ROL' as message;
	END;
    IF (idRoll = 0 or idRoll is null)
    THEN
		SELECT 'EL id del rol no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Roll FROM ROLL WHERE id_Roll = idRoll))
    THEN
		SELECT 'No existente id Roll.' as message;
        LEAVE sp;
	END IF;
	START TRANSACTION;
		DELETE U FROM ROLL R JOIN USER_ U ON(U.id_Roll = R.id_Roll) WHERE R.id_Roll = idRoll;
		DELETE R FROM ROLL R WHERE R.`id_Roll` = idRoll;
	COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectWhereRollId;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereRollId
(
IN idRoll int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR ROL' as message;
	END;
    IF (idRoll = 0 or idRoll is null)
    THEN
		SELECT 'EL id del roll no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT RL.id_Roll,RL.Descript_Roll,RL._Value,RL.Fecha_Created,RL.Fecha_Updated
        FROM ROLL as RL
        WHERE RL.`id_Roll` = idRoll;
    COMMIT;     
END;

CREATE VIEW v_sCantidadRol
AS SELECT COUNT(*) CANTIDAD_ROL FROM ROLL;

DROP VIEW IF EXISTS v_sSelectRoll;
CREATE VIEW v_sSelectRoll
AS SELECT RL.id_Roll,RL.Descript_Roll,RL._Value,RL.Fecha_Created,RL.Fecha_Updated FROM ROLL as RL LIMIT 30;
####################################################################USER###################################################################
DROP PROCEDURE IF EXISTS sp_InsertUser;
DELIMITER $$
CREATE PROCEDURE sp_InsertUser
(
IN idCliente int,
IN idRoll int,
IN Username nvarchar(250),
IN _Password nvarchar(250),
IN _Status bool
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN USER' as message;
	END;
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
	IF (idRoll = 0 or idRoll is null)
    THEN
		SELECT 'El id del rol no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Username) = 0 or Username= " ")
    THEN
		SELECT 'El username no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(_Password) = 0 or _Password = " ")
    THEN
		SELECT 'El password no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (_Status < 0 or _Status is null)
    THEN
		SET _Status = 0;
        SELECT 'El Status del User no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (exists(SELECT id_Cliente FROM user_ WHERE id_Cliente = idCliente))
    THEN
		SELECT 'Cliente Existente en el User .' as message;
        LEAVE sp;
	END IF;
    IF (exists(SELECT _Username FROM user_ WHERE _Username = Username))
    THEN
		SELECT 'Username Existente .' as message;
        LEAVE sp;
	END IF;
    IF (LENGTH(_Password)<7)
    THEN
		SELECT 'Password debe contener 7 caracteres .' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO USER_ (id_Cliente,id_Roll,_Username,_Password,_Status,Fecha_Created,Fecha_Updated) VALUES (idCliente,idRoll,Username,_Password,_Status,DAT,DAT);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateUser;
DELIMITER $$
CREATE PROCEDURE sp_UpdateUser
(
IN idCliente int,
IN _Password nvarchar(250)

)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR USER' as message;
	END;
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(_Password) = 0 or _Password = " ")
    THEN
		SELECT 'El password no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(_Password)<7)
    THEN
		SELECT 'Password debe contener 7 caracteres .' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE USER_ SET `_Password` = _Password,`Fecha_Updated`=DAT WHERE `id_Cliente` = idCliente;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteUser;
DELIMITER $$
CREATE PROCEDURE sp_DeleteUser
(
IN idCliente int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR USER' as message;
	END;
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
	IF (not exists(SELECT id_Cliente FROM User_ WHERE id_Cliente =  idCliente))
    THEN
		SELECT 'No existente id User para el Delete.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM USER_ WHERE `id_Cliente` = idCliente;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectUserId;
DELIMITER $$
CREATE PROCEDURE sp_SelectUserId
(
IN idCliente int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA USER' as message;
	END;
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT CLI.id_Cliente,CONCAT_WS(' ',CLI.Nombre_Cliente,CLI.Apellido_Cliente) Cliente ,Descript_Roll,US._Username,US._Password,US._Status,US.Fecha_Created,US.Fecha_Updated
		FROM USER_ as US
		JOIN CLIENTE as CLI
		ON (US.`id_Cliente` = CLI.`id_Cliente`)
		JOIN ROLL AS RL
		ON(US.`id_Cliente`= RL.`id_Roll`)
        WHERE  CLI.`id_Cliente` = idCliente;
    COMMIT; 
END;
CREATE VIEW v_sCantidadUser
AS SELECT COUNT(*) CANTIDAD_USER FROM USER_;

DROP VIEW IF EXISTS v_sSelectUser;
CREATE VIEW v_sSelectuser
AS
	SELECT CLI.id_Cliente,CONCAT_WS(' ',CLI.Nombre_Cliente,CLI.Apellido_Cliente) Cliente ,RL.Descript_Roll,US._Username,US._Password,US._Status,US.Fecha_Created,US.Fecha_Updated
	FROM USER_ as US JOIN CLIENTE as CLI ON (US.`id_Cliente` = CLI.`id_Cliente`) JOIN ROLL AS RL
	ON(US.`id_Cliente`= RL.`id_Roll`) LIMIT 30;
##############################################################MEDIODEPAGO###############################################################
DROP PROCEDURE IF EXISTS sp_InsertMedioPago;
DELIMITER $$
CREATE PROCEDURE sp_InsertMedioPago
(
IN idCliente int,
IN MedioPago nvarchar(250),
IN NumeroTarjeta char(50),
IN CVV char(3),
IN FechaVencimiento date
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN MEDIO DE PAGO' as message;
	END;
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(MedioPago) = 0 or MedioPago= " ")
    THEN
		SELECT 'El medio de pago no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(NumeroTarjeta) = 0 or NumeroTarjeta= " ")
    THEN
		SELECT 'El numero de tarjeta no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(CVV) = 0 or CVV = " ")
    THEN
		SELECT 'El CVV no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO MEDIOPAGO (`id_Cliente`,`MedioPago`,`NumeroTarjeta`,`CVV`,`FechaVencimiento`,`Fecha_Created`,`Fecha_Updated`) VALUES (idCliente,MedioPago,NumeroTarjeta,CVV,FechaVencimiento,DAT,DAT);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateMedioPago;
DELIMITER $$
CREATE PROCEDURE sp_UpdateMedioPago
(
IN idMedioPago int,
IN NumeroTarjeta char(50),
IN CVV char(3),
IN FechaVencimiento date
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR EL PEDIO DE PAGO' as message;
	END;
    IF (idMedioPago= 0 or idMedioPago is null)
    THEN
		SELECT 'El id del medio de pago no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(NumeroTarjeta) = 0 or NumeroTarjeta= " ")
    THEN
		SELECT 'El numero de tarjeta no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(CVV) = 0 or CVV = " ")
    THEN
		SELECT 'El CVV no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE MEDIOPAGO SET `NumeroTarjeta`=NumeroTarjeta,`CVV` = CVV,`FechaVencimiento`=FechaVencimiento,`Fecha_Updated`=DAT  WHERE `id_MedioPago` = idMedioPago;
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_DeleteMedioPago;
DELIMITER $$
CREATE PROCEDURE sp_DeleteMedioPago
(
IN idMedioPago int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR MEDIO DE PAGO' as message;
	END;
    IF (idMedioPago= 0 or idMedioPago is null)
    THEN
		SELECT 'El id del medio de pago no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_MedioPago FROM mediopago WHERE id_MedioPago =  idMedioPago))
    THEN
		SELECT 'No existente id MedioPago.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM MEDIOPAGO WHERE `id_MedioPago` = idMedioPago ;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectMedioPagoId;
DELIMITER $$
CREATE PROCEDURE sp_SelectMedioPagoId
(
IN pagoid int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE BUSCAR' as message;
	END;
    IF (pagoid= 0 or pagoid  is null)
    THEN
		SELECT 'EL id del mediopago no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT M.id_MedioPago,C.Nombre_Cliente,C.Apellido_Cliente,M.MedioPago,M.NumeroTarjeta,M.CVV,M.FechaVencimiento,M.Fecha_Created,M.Fecha_Updated
        FROM mediopago M JOIN cliente C on(M.id_Cliente = C.id_Cliente)
        where M.id_MedioPago = pagoid;
    COMMIT; 
END;

AS SELECT COUNT(*) CANTIDAD_PAYMENT FROM  mediopago;

DROP VIEW IF EXISTS v_sSelectMedioPago;
CREATE VIEW v_sSelectMedioPago
AS SELECT M.id_MedioPago,C.Nombre_Cliente,C.Apellido_Cliente,M.MedioPago,M.NumeroTarjeta,M.CVV,M.FechaVencimiento,M.Fecha_Created,M.Fecha_Updated
		FROM mediopago M JOIN cliente C on(M.id_Cliente = C.id_Cliente) LIMIT 30;
#################################################PEDIDO#################################################################DSD
DROP PROCEDURE IF EXISTS sp_InsertPedido;
DELIMITER $$
CREATE PROCEDURE sp_InsertPedido
(
IN idCliente smallint,
IN NPedido smallint,
IN FeEmision date,
IN EmpEnvio nvarchar(100),
IN SubTotal decimal(7,2),
IN Descuento decimal(7,2),
IN DiretEnvio nvarchar(100),
IN Total smallint,
IN TotalPagar decimal(7,2),
IN Statu bool
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INSERTAR PEDIDO' as message;
	END;
    IF (idCliente= 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF  (char_length(FeEmision )=0 or isnull(FeEmision))
    THEN
		SELECT 'La fecha de Emision no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(EmpEnvio) = 0 or EmpEnvio= " ")
    THEN
		SELECT 'La empresa no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (SubTotal = 0 or SubTotal is null)
    THEN
		SELECT 'El subtotal no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(DiretEnvio) = 0 or DiretEnvio= " ")
    THEN
		SELECT 'La direccion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (Total= 0 or Total is null)
    THEN
		SELECT 'El total no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (TotalPagar= 0 or TotalPagar is null)
    THEN
		SELECT 'El total a pagar no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (NPedido = 0 or NPedido is null)
    THEN
		SELECT 'El pedido no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
	END IF;
	IF (Statu< 0 or Statu is null)
    THEN
		SET Statu = 0;
        LEAVE sp;
    END IF;
    IF (Descuento= 0 or Descuento is null)
    THEN
		SELECT 'El descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (exists(SELECT N_Pedido FROM pedido WHERE N_Pedido =  NPedido))
    THEN
		SELECT 'Existente NPedido.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO PEDIDO(id_Cliente,N_Pedido,FechaEmision,Emp_Envio,Sub_Total,Descuento,Diret_Envio,Total,TotalPagar,_Status,Fecha_Created,Fecha_Updated)VALUES(idCliente,NPedido,FeEmision,EmpEnvio,SubTotal,Descuento,DiretEnvio,Total,TotalPagar,Statu,DAT,DAT);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdatePedido;
DELIMITER $$
CREATE PROCEDURE sp_UpdatePedido
(
IN NPedido smallint,
IN FeEmision date,
IN EmpEnvio nvarchar(100),
IN SubTotal decimal(7,2),
IN Descuento decimal(7,2),
IN DiretEnvio nvarchar(100),
IN Total smallint,
IN TotalPagar decimal(7,2),
IN Statu bool
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR EL PEDIDO' as message;
	END;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE pedido SET `FechaEmision` = FeEmision,`Emp_Envio`= EmpEnvio,`Sub_Total` = SubTotal,`Descuento`=Descuento,`Diret_Envio` = DiretEnvio,`Total` = Total ,`TotalPagar` = TotalPagar,`_Status` = Statu,`Fecha_Updated`=DAT WHERE `N_Pedido` = NPedido;
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_DeletePedido;
DELIMITER $$
CREATE PROCEDURE sp_DeletePedido
(
IN NPedido smallint
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR PEDIDO' as message;
	END;
    IF (NPedido= 0 or NPedido is null)
    THEN
		SELECT 'El N_Pedido no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Cliente FROM pedido WHERE N_Pedido = NPedido))
    THEN
		SELECT 'No existente N_Pedido.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE C FROM pedido P JOIN carritocompra C on(C.N_Pedido = P.N_Pedido) WHERE P.N_Pedido = NPedido;
		DELETE P FROM pedido P WHERE P.N_Pedido = NPedido;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectPedidoId;
DELIMITER $$
CREATE PROCEDURE sp_SelectPedidoId
(
IN NPedido smallint
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE BUSCAR' as message;
	END;
    IF (NPedido= 0 or NPedido is null)
    THEN
		SELECT 'EL NPedido no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT C.id_Cliente,C.Nombre_Cliente,C.Apellido_Cliente,C.Edad_Cliente,C.Correo,C.Contacto,P.N_Pedido,
        P.FechaEmision,P.Sub_Total,P.Total,P.TotalPagar,P.Emp_Envio,P.Diret_Envio,P._Status,P.Fecha_Created,P.Fecha_Updated
        FROM PEDIDO P JOIN CLIENTE C ON(P.id_Cliente = C.id_Cliente)
        where P.N_Pedido = NPedido;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sSelectPedido;
CREATE VIEW v_sSelectPedido
AS SELECT C.id_Cliente,C.Nombre_Cliente,C.Apellido_Cliente,C.Edad_Cliente,C.Correo,C.Contacto,P.N_Pedido,
        P.FechaEmision,P.Sub_Total,P.Total,P.TotalPagar,P.Emp_Envio,P.Diret_Envio,P._Status,P.Fecha_Created,P.Fecha_Updated
        FROM PEDIDO P JOIN CLIENTE C ON(P.id_Cliente = C.id_Cliente)  LIMIT 30

CREATE VIEW v_sCantidadPedido
AS SELECT COUNT(*) CANTIDAD_PEDIDO FROM  PEDIDO;
################################################################CARRITOCOMPRA############################################
DROP PROCEDURE IF EXISTS sp_InsertCarritoCompra;
DELIMITER $$
CREATE PROCEDURE sp_InsertCarritoCompra
(
IN NPedido smallint,
IN idProduct smallint,
IN CarCantidad decimal(7,2)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR AL CARRITO DE COMPRA' as message;
	END;
    IF (NPedido = 0 or NPedido is null)
    THEN
		SELECT 'El NPedido no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idProduct = 0 or idProduct is null)
    THEN
		SELECT 'El id del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (CarCantidad = 0 or CarCantidad is null)
    THEN
		SELECT 'La Cantidad del CarritoCompra no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (exists(SELECT id_Product FROM CARRITOCOMPRA WHERE id_Product= idProduct and N_Pedido=NPedido))
    THEN
		SELECT 'Existente en el Carrito Compra.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO CARRITOCOMPRA(N_Pedido,id_Product,Car_Cantidad,Fecha_Created,Fecha_Updated)VALUES(NPedido,idProduct,CarCantidad,DAT,DAT);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateCarritoCompra;
DELIMITER $$
CREATE PROCEDURE sp_UpdateCarritoCompra
(
IN NPedido smallint,
IN idProduct smallint,
IN CarCantidad decimal(7,2)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR EL CARRITO DE COMPRA' as message;
	END;
    IF (NPedido = 0 or NPedido is null)
    THEN
		SELECT 'El NPedido no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idProduct = 0 or idProduct is null)
    THEN
		SELECT 'El id del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (CarCantidad = 0 or CarCantidad is null)
    THEN
		SELECT 'La Cantidad del CarritoCompra no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE carritocompra SET `Car_Cantidad` = CarCantidad,`Fecha_Updated` = DAT WHERE `id_Product` = idProduct and `N_Pedido` = NPedido ;
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_DeleteCarritoCompra;
DELIMITER $$
CREATE PROCEDURE sp_DeleteCarritoCompra
(
IN NPedido smallint,
IN idProduct smallint
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR CARRITO DE COMPRA' as message;
	END;
    IF (NPedido = 0 or NPedido is null)
    THEN
		SELECT 'El NPedido no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idProduct = 0 or idProduct is null)
    THEN
		SELECT 'El id del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT * FROM carritocompra WHERE id_Product =  idProduct and N_Pedido = NPedido))
    THEN
		SELECT 'No existente en el carrito de compra.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM carritocompra WHERE `id_Product` = idProduct and N_Pedido = NPedido ;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectCarritoCompraId;
DELIMITER $$
CREATE PROCEDURE sp_SelectCarritoCompraId
(
IN NPedido int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE BUSCAR' as message;
	END;
    IF (NPedido = 0 or NPedido is null)
    THEN
		SELECT 'El NPedido no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT C.N_Pedido,P.Nombre_Product,MAR.Nom_Marca,P.Descript_Product,P.Precio,P.Img1,C.Car_Cantidad,C.Fecha_Created,C.Fecha_Updated
		FROM CARRITOCOMPRA C JOIN PRODUCTOS P ON(C.id_Product = P.id_Product) join descuento as D
		on(P.id_Product=D.id_Product) JOIN PEDIDO AS PA
		on(PA.N_Pedido = C.N_Pedido) JOIN MARCA AS MAR
        on(P.id_Marca = MAR.id_Marca)
        where C.N_Pedido = NPedido;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS v_sSelectCarritoCompra;
DELIMITER $$
CREATE PROCEDURE v_sSelectCarritoCompra
()
sp:BEGIN
    DECLARE a INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR' as message;
	END;
 	START TRANSACTION;
        SET a = (select count(*) from CARRITOCOMPRA); 
        IF (a>0)
        THEN
			SELECT C.N_Pedido,P.Nombre_Product,MAR.Nom_Marca,P.Descript_Product,P.Precio,P.Img1,C.Car_Cantidad,C.Fecha_Created,C.Fecha_Updated
			FROM CARRITOCOMPRA C JOIN PRODUCTOS P ON(C.id_Product = P.id_Product) join descuento as D
			on(P.id_Product=D.id_Product) JOIN PEDIDO AS PA
            on(PA.N_Pedido = C.N_Pedido) JOIN MARCA AS MAR
			on(P.id_Marca = MAR.id_Marca);
		ELSEIF(a=0)THEN 
			SELECT 'No contiene producto' as message;
        END IF;
    COMMIT; 
END;
#################################HistorialdeCompra###############################################################
DROP PROCEDURE IF EXISTS sp_InsertHistorialCompra
DELIMITER $$
CREATE PROCEDURE sp_InsertHistorialCompra
(
IN NPedido smallint,
IN Cliente nvarchar(100),
IN FeEmision date,
IN DirecEnvio nvarchar(100),
IN SubTotal decimal(7,2),
IN Total smallint,
IN TotalPagar decimal(7,2),
IN Descuento decimal(7,2)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INSERTAR HISTORIAL PEDIDO' as message;
	END;
    IF (exists(SELECT N_Pedido FROM historialcompra WHERE N_Pedido = NPedido ))
    THEN
		SELECT 'Ya existente N_Pedido.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO historialcompra(N_Pedido,Cliente,FechaEmision,DirecEnvio,SubTotal,Total,TotalPagar,Descuento,Fecha_Created,Fecha_Updated)VALUES(NPedido,Cliente,FeEmision,DirecEnvio,SubTotal,Total,TotalPagar,Descuento,DAT,DAT);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateHistorialCompra;
DELIMITER $$
CREATE PROCEDURE sp_UpdateHistorialCompra
(
IN NPedido smallint,
IN Clien nvarchar(100),
IN FeEmision date,
IN DirecEnvio nvarchar(100),
IN SubTotal decimal(7,2),
IN Total smallint,
IN TotalPagar decimal(7,2),
IN Descuento decimal(7,2)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR EL HISTORIAL PEDIDO' as message;
	END;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE historialcompra SET Cliente=Clien,FechaEmision=FeEmision,DirecEnvio= DirecEnvio,SubTotal=SubTotal,Total=Total,TotalPagar=TotalPagar,Descuento=Descuento,Fecha_Updated=DAT WHERE N_Pedido = NPedido;
    COMMIT;
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_DeleteHistorial;
DELIMITER $$
CREATE PROCEDURE sp_DeleteHistorial
(
IN NPedido smallint
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR HISTORIAL PEDIDO' as message;
	END;
    IF (NPedido= 0 or NPedido is null)
    THEN
		SELECT 'El NPedido no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT N_Pedido FROM historialcompra WHERE N_Pedido =  NPedido))
    THEN
		SELECT 'No existente id N_PEDIDO.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM historialcompra WHERE N_Pedido = NPedido;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectHistorialId;
DELIMITER $$
CREATE PROCEDURE sp_SelectHistorialId
(
IN NPedido int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR HISTORIAL' as message;
	END;
    IF (NPedido= 0 or NPedido  is null)
    THEN
		SELECT 'EL NPedido no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SELECT H.N_Pedido,H.Cliente,H.FechaEmision,H.DirecEnvio,H.SubTotal,H.Total,H.TotalPagar,H.Fecha_Created,H.Fecha_Updated
		FROM HISTORIALCOMPRA H 
        where H.N_Pedido = NPedido;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS v_sSelectHistorial;
DELIMITER $$
CREATE PROCEDURE v_sSelectHistorial
()
sp:BEGIN
    DECLARE a INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR' as message;
	END;
 	START TRANSACTION;
        SET a = (select count(*) from historialcompra); 
        IF (a>0)
        THEN
			SELECT H.N_Pedido,H.Cliente,H.FechaEmision,H.DirecEnvio,H.SubTotal,H.Total,H.TotalPagar,H.Fecha_Created,H.Fecha_Updated
			FROM HISTORIALCOMPRA H ;
		ELSEIF(a=0)THEN 
			SELECT 'No contiene compras' as message;
        END IF;
    COMMIT; 
END;
##################################################DESCUENTO############################################################
DROP PROCEDURE IF EXISTS sp_InsertDescuento
DELIMITER $$
CREATE PROCEDURE sp_InsertDescuento
(
IN idProduct smallint,
IN dscto1 smallint,
IN dscto2 smallint,
IN dscto3 smallint,
IN dscto4 smallint
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INSERTAR DESCUENTO' as message;
	END;
    IF (idProduct= 0 or idProduct is null)
    THEN
		SELECT 'El id del producto del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto1= 0 or dscto1 is null)
    THEN
		SELECT 'El dscto1 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto2= 0 or dscto2 is null)
    THEN
		SELECT 'El dscto2 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto3= 0 or dscto3 is null)
    THEN
		SELECT 'El dscto3 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto4= 0 or dscto4 is null)
    THEN
		SELECT 'El dscto4 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (exists(SELECT id_Product FROM descuento  WHERE id_Product = idProduct))
    THEN
		SELECT '  Descuento Existente del Producto.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO descuento(id_Product,dscto1,dscto2,dscto3,dscto4,Fecha_Created,Fecha_Updated)VALUES(idProduct,dscto1,dscto2,dscto3,dscto4,DAT,DAT);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateDescuento;
DELIMITER $$
CREATE PROCEDURE sp_UpdateDescuento
(
IN idProduct smallint,
IN dscto1 float,
IN dscto2 float,
IN dscto3 float,
IN dscto4 float
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR EL DESCUENTO' as message;
	END;
     IF (idProduct= 0 or idProduct is null)
    THEN
		SELECT 'El id del producto de descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto1= 0 or dscto1 is null)
    THEN
		SELECT 'El dscto1 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto2= 0 or dscto2 is null)
    THEN
		SELECT 'El dscto2 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto3= 0 or dscto3 is null)
    THEN
		SELECT 'El dscto3 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto4= 0 or dscto4 is null)
    THEN
		SELECT 'El dscto4 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE descuento SET dscto1=dscto1 ,dscto2=dscto2 ,dscto3=dscto3,dscto4=dscto4,Fecha_Updated=DAT WHERE id_Product = idProduct ;
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_DeleteDescuento;
DELIMITER $$
CREATE PROCEDURE sp_DeleteDescuento
(
IN idProduct smallint
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR DESCUENTO' as message;
	END;
    IF (idProduct = 0 or idProduct  is null)
    THEN
		SELECT 'El id del producto de descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Product FROM DESCUENTO WHERE id_Product =  idProduct))
    THEN
		SELECT 'No existente IdProducto del Descuento.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM DESCUENTO WHERE id_Product = idProduct;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectDescuentoId;
DELIMITER $$
CREATE PROCEDURE sp_SelectDescuentoId
(
IN idProduct int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR DESCUENTO' as message;
	END;
    IF (idProduct = 0 or idProduct  is null)
    THEN
		SELECT 'El id del producto de descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SELECT P.id_Product,D.dscto1,D.dscto2,D.dscto3,D.dscto4,P.Fecha_Created,P.Fecha_Updated
        FROM DESCUENTO D JOIN 
        PRODUCTOS P ON(P.id_Product =D.id_Product) JOIN SUBCATEGORIAS S
        ON(S.id_SubCategory = P.id_SubCategory) JOIN CATEGORIA CA
        ON(CA.id_Categoria = S.id_Category) JOIN MARCA MAR
        ON(P.id_Marca=MAR.id_Marca)
        where D.id_Product = idProduct;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sSelectDescuento;
CREATE VIEW v_sSelectDescuento
AS
		SELECT P.id_Product,D.dscto1,D.dscto2,D.dscto3,D.dscto4,P.Fecha_Created,P.Fecha_Updated
        FROM DESCUENTO D JOIN PRODUCTOS P ON(P.id_Product =D.id_Product) JOIN SUBCATEGORIAS S
        ON(S.id_SubCategory = P.id_SubCategory) JOIN CATEGORIA CA ON(CA.id_Categoria = S.id_Category) JOIN MARCA MAR
        ON(P.id_Marca=MAR.id_Marca) LIMIT 30
#####################################################CARACTERISTICAS############################################################################
DROP PROCEDURE IF EXISTS sp_InsertCaracteristicas
DELIMITER $$
CREATE PROCEDURE sp_InsertCaracteristicas
(
IN idProduct smallint,
IN Caracteristicas nvarchar(1500)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INSERTAR CARACTERISTICAS' as message;
	END;
    IF (idProduct= 0 or idProduct is null)
    THEN
		SELECT 'El id del producto de la caracteristicas no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Caracteristicas) = 0 or Caracteristicas= " ")
    THEN
		SELECT 'La caracteristicas no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (exists(SELECT id_Product FROM caracteristicas WHERE id_Product = idProduct))
    THEN
		SELECT 'Caracteristicas Existente del Producto.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		INSERT INTO caracteristicas(id_Product,Caracteristicas_product,Fecha_Created,Fecha_Updated)VALUES(idProduct,Caracteristicas,DAT,DAT);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateCaracteristicas;
DELIMITER $$
CREATE PROCEDURE sp_UpdateCaracteristicas
(
IN idProduct smallint,
IN Caracteristicas nvarchar(1500)
)
sp:BEGIN
	DECLARE DATE_ DATETIME;
	DECLARE DAT DATETIME;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR LA CARACTERISTICASS' as message;
	END;
    IF (idProduct= 0 or idProduct is null)
    THEN
		SELECT 'El id del producto de la caracteristicas no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Caracteristicas) = 0 or Caracteristicas= " ")
    THEN
		SELECT 'La caracteristicas no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET DATE_ = NOW();
        SET DAT = CONVERT(DATE_,DATETIME);
		UPDATE caracteristicas SET Caracteristicas_product=Caracteristicas,Fecha_Updated= DAT  WHERE id_Product = idProduct ;
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_DeleteCaracteristicas;
DELIMITER $$
CREATE PROCEDURE sp_DeleteCaracteristicas
(
IN idProduct smallint
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR CARACTERISTICAS' as message;
	END;
    IF (idProduct = 0 or idProduct  is null)
    THEN
		SELECT 'El id del producto de la caracteristicas no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Product FROM caracteristicas WHERE id_Product =  idProduct))
    THEN
		SELECT 'No existente IdProducto de la Caracteristicas.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM caracteristicas WHERE id_Product = idProduct;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectCaracteristicasId;
DELIMITER $$
CREATE PROCEDURE sp_SelectCaracteristicasId
(
IN idProduct int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR CARACTERISTICAS' as message;
	END;
    IF (idProduct = 0 or idProduct  is null)
    THEN
		SELECT 'El id del producto de la caracteristicas no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SELECT P.id_Product,C.Caracteristicas_product,C.Fecha_Created,C.Fecha_Updated
        FROM CARACTERISTICAS C JOIN 
        PRODUCTOS P ON(P.id_Product =C.id_Product) JOIN SUBCATEGORIAS S
        ON(S.id_SubCategory = P.id_SubCategory) JOIN CATEGORIA CA
        ON(CA.id_Categoria = S.id_Category)
        where C.id_Product = idProduct;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sSelectCaracteristicas;
CREATE VIEW v_sSelectCaracteristicas
AS
		SELECT P.id_Product,C.Caracteristicas_product,C.Fecha_Created,C.Fecha_Updated
        FROM CARACTERISTICAS C JOIN  PRODUCTOS P ON(P.id_Product =C.id_Product) JOIN SUBCATEGORIAS S
        ON(S.id_SubCategory = P.id_SubCategory) JOIN CATEGORIA CA ON(CA.id_Categoria = S.id_Category)LIMIT 30
        

DROP VIEW IF EXISTS v_onlydscts;
CREATE VIEW v_onlydscts
AS
		select `pd`.`id_Product` AS `id_Product`,`pd`.`Nombre_Product` AS `Nombre_Product`,`m`.`Nom_Marca` AS `Nom_Marca`,`pd`.`Descript_Product` AS `Descript_Product`,`pd`.`Precio` AS `Precio`,`pd`.`Stock` AS `Stock`,`pd`.`Unidad` AS `Unidad`,`pd`.`Moneda` AS `Moneda`,`sub`.`Nom_SubCategory` AS `Nom_SubCategory`,`cat`.`Nom_Category` AS `Nom_Category`,`pd`.`Img1` AS `Img1`,`pd`.`Img2` AS `Img2`,`pd`.`Img3` AS `Img3`,`pd`.`Img4` AS `Img4`,`pd`.`Img5` AS `Img5`,`pd`.`NDescuento` AS `NDescuento`,`pd`.`_Status` AS `_Status`,`de`.`dscto1` AS `dscto1`,`de`.`dscto2` AS `dscto2`,`de`.`dscto3` AS `dscto3`,`de`.`dscto4` AS `dscto4`,`car`.`Caracteristicas_product` AS `Caracteristicas_product`,`pd`.`Fecha_Created` AS `Fecha_Created`,`pd`.`Fecha_Updated` AS `Fecha_Updated`
        from (((((`productos` `pd` join `subcategorias` `sub` on((`pd`.`id_SubCategory` = `sub`.`id_SubCategory`))) join `categoria` `cat` on((`sub`.`id_Category` = `cat`.`id_Categoria`))) join `descuento` `de` on((`de`.`id_Product` = `pd`.`id_Product`))) join `caracteristicas` `car` on((`car`.`id_Product` = `pd`.`id_Product`))) join `marca` `m` on((`pd`.`id_Marca` = `m`.`id_Marca`))) where ((`pd`.`NDescuento` > 0) and (`pd`.`_Status` = 1)) limit 10
select * from v_onlydscts;

DROP PROCEDURE IF EXISTS sp_Buscador;
DELIMITER $$
CREATE PROCEDURE sp_Buscador
(
IN querys VARCHAR(250)
)
sp:BEGIN
	DECLARE consulta VARCHAR(100);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR CARACTERISTICAS' as message;
	END;
 	START TRANSACTION;
		SET consulta = CONCAT('%',querys,'%');
		SELECT PD.`id_Product`,PD.`Nombre_Product`,M.`Nom_Marca`,PD.`Descript_Product`,PD.`Precio`,PD.`Stock`,PD.`Unidad`,PD.`Moneda`,SUB.`Nom_SubCategory`,CAT.`Nom_Category`,PD.`Img1`,PD.`Img2`,PD.`Img3`,PD.`Img4`,PD.`Img5`,PD.`NDescuento`,PD.`_Status`,DE.`dscto1`,DE.`dscto2`,DE.`dscto3`,DE.`dscto4`,PD.`Fecha_Created`,PD.`Fecha_Updated`,CAR.`Caracteristicas_product`
		FROM PRODUCTOS as PD
		JOIN SUBCATEGORIAS as SUB
		ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
		JOIN CATEGORIA AS CAT
		ON(SUB.`id_Category` = CAT.`id_Categoria`)
		JOIN DESCUENTO AS DE
		ON(DE.id_Product = PD.id_Product)
		JOIN caracteristicas AS CAR
		ON(CAR.id_Product = PD.id_Product)
		JOIN Marca as M
		ON(PD.id_Marca = M.id_Marca)
		WHERE SUB.Nom_SubCategory LIKE consulta 
		OR M.Nom_Marca LIKE consulta 
		OR PD.Nombre_Product LIKE consulta 
		OR PD.Descript_Product LIKE consulta
		OR PD.Moneda LIKE consulta;
    COMMIT; 
END;

##########################################INSERTACIÓNDEDATOS##########################################################################
CALL sp_InsertCategoria("Electrónicos")
CALL sp_InsertSubCategoria(1,"Accesorios y Suministros")
select * from user_
select * from cliente
select * from roll
select * from direcciones
SELECT * FROM PRODUCTOS
SELECT * FROM SUBCATEGORIAS
CALL sp_InsertProductos('AirPods de Apple con funda de carga (cableado).',1,1,'Los Apple EarPods son unos audífonos in ear que te aseguran la mejor calidad de sonido en todo momento. Un producto original de Apple, compatible con dispositivos con entrada Lightning.',149.90,100,'UND','SOL','https://m.media-amazon.com/images/I/71djnhmfy-L._AC_SX342_.jpg','img2','img3','img4','img5',1,1)
CALL SP_InsertDescuento(2,10,20,30,40)
CALL sp_InsertCaracteristicas(2,'Tipo:In Ear Longitud de cable:1.20m Conexión Bluetooth:No Inalámbrico:No Micrófono:Sí Conexión Auxiliar:No Controles:Control de música y llamadas')
CALL sp_InsertProductos('TAKAGI - Cable Lightning de nailon trenzado de 5.9 ft.',2,1,'Conecta tu celular a tu laptop y comparte tus archivos importantes. También podrás cargar tus dispositivos de forma rápida y muy segura.',89.90,100,'UND','SOL','https://m.media-amazon.com/images/I/71m-EsCA2aL._SL1500_.jpg','img2','img3','img4','img5',1,1)
CALL SP_InsertDescuento(2,10,20,30,40)
CALL sp_InsertCaracteristicas(2,'Compatible:Apple Velocidad de transferencia:480 Mbps Largo cable Lightning:1 m Voltaje:20W')
CALL sp_InsertProductos('Cable divisor de cable en Y con carcasa de aleación de zinc para iPhone.',3,1,'Los cables de audio UCEC son ideales para conectar dispositivos con conectores de audio de 0.138 in y dispositivos equipados con conectores de 0.250 in.',41.00,100,'UND','SOL','https://m.media-amazon.com/images/I/71ygl5n7oSL._SX342_.jpg','img2','img3','img4','img5',1,1)
CALL SP_InsertDescuento(3,15,18,20,22)
CALL sp_InsertCaracteristicas(3,'Código UNSPSC:26121500 Dispositivos compatibles:Laptop,Speaker,Personal Computer Longitud del cable:10 feet pies')
CALL sp_InsertProductos('Adaptador Apple Lightning a 0.14 pulgadas para auriculares',1,1,'Este adaptador le permite conectar dispositivos que utilicen un conector de audio de 0.14 pulgadas a sus dispositivos de relámpago
Requisitos del sistema Funciona con todos los dispositivos que tienen un conector relámpago y admiten iOS 10 o posterior, incluido iPod touch, iPad y iPhone.',60.00,100,'UND','SOL','https://m.media-amazon.com/images/I/41gxUa2r3BL._AC_SY445_.jpg','img2','img3','img4','img5',1,1)
CALL SP_InsertDescuento(4,0,10,20,30)
CALL sp_InsertCaracteristicas(4,'Dispositivos compatibles:IPad,IPod,IPhone Tipo de conector:Auxiliary,Lighting Género del conector:Female-to-Male')
CALL sp_InsertProductos('Soundcore - Audífonos híbridos modelo Anker Life Q20 inalámbricos.',4,1,'Certificado de audio de alta resolución: controladores dinámicos de 1.575 in de tamaño personalizado producen audio de alta resolución, una certificación que solo se otorga a dispositivos de audio capaces de producir un sonido excepcional. Los auriculares Life Q20 con
cancelación de ruido activa reproducen tu música con frecuencias altas extendidas que alcanzan hasta 40 kHz para una claridad y detalle extraordinarios.',211.90,100,'UND','SOL','https://m.media-amazon.com/images/I/61fU3njgzZL._AC_SL1500_.jpg','img2','img3','img4','img5',1,1)
CALL SP_InsertDescuento(5,0,5,20,30)
CALL sp_InsertCaracteristicas(5,'Marca:Soundcore Color:Negro Tecnología de conectividad:Bluetooth,RF Nombre del modelo:AK-A3025011 Factor de forma:Over Ear')

CALL sp_InsertSubCategoria(1,"Cámaras y Fotografía")
CALL sp_InsertProductos('Wyze Cam v3 con visión nocturna a color, cámara de video HD de 1080p con cable para interiores y exteriores',5,2,'Visión nocturna a color: un nuevo sensor Starlight graba vídeos nocturnos en colores vivos y completos. El Starlight Sensor puede ver todo color en entornos hasta 25 veces más oscuros que las cámaras de vídeo tradicionales y la nueva apertura f/1.6 captura 2 veces más luz.',139.50,50,'UND','SOL','https://m.media-amazon.com/images/I/61Jqml2u9qL._AC_SL1500_.jpg','img2','img3','img4','img5',1,1)
CALL SP_InsertDescuento(6,10,20,30,40)
CALL sp_InsertCaracteristicas(6,'Uso en interiores y exteriores:Interiores, Exteriores Marca:WYZE Tecnología de conectividad:Wired Usos Recomendados Para Producto:Indoor/Outdoor')
CALL sp_InsertProductos('Security Camera 2K, blurams Baby Monitor Dog Camera 360-degree for Home Security',6,2,'Cobertura de 360 ° con resolución 2K: la cámara de seguridad Blurams rastrea automáticamente el movimiento si detecta movimiento. Cuenta con la función IR-CUT para capturar videos y fotos nítidos del día a la noche, incluso en condiciones de poca luz. Active el modo de privacidad para proteger su privacidad.',150.00,100,'UND','SOL','	https://m.media-amazon.com/images/I/61cF4wXICDL._AC_SL1500_.jpg','img2','img3','img4','img5',1,1)
CALL SP_InsertDescuento(7,10,25,30,40)
CALL sp_InsertCaracteristicas(7,'Uso en interiores y exteriores:Interiores Marca:Blurams Tecnología de conectividad:Wireless Usos Recomendados Para Producto:Surveillance,Monitor Babies')
CALL sp_InsertProductos('',6,2,'Cobertura de 360 ° con resolución 2K: la cámara de seguridad Blurams rastrea automáticamente el movimiento si detecta movimiento. Cuenta con la función IR-CUT para capturar videos y fotos nítidos del día a la noche, incluso en condiciones de poca luz. Active el modo de privacidad para proteger su privacidad.',150.00,100,'UND','SOL','	https://m.media-amazon.com/images/I/61cF4wXICDL._AC_SL1500_.jpg','img2','img3','img4','img5',1,1)
CALL SP_InsertDescuento(8,10,25,30,40)
CALL sp_InsertCaracteristicas(8,'Uso en interiores y exteriores:Interiores Marca:Blurams Tecnología de conectividad:Wireless Usos Recomendados Para Producto:Surveillance,Monitor Babies')


CALL sp_InsertSubCategoria(1,"Teléfonos celulares y accesorios")
CALL sp_InsertSubCategoria(1,"Audífonos")
CALL sp_InsertSubCategoria(1,"Televisión y video")
select * from categoria
select * from subcategorias


CALL sp_InsertCategoria("Computadoras")
CALL sp_InsertSubCategoria(2,"Componentes de computadoras")
CALL sp_InsertSubCategoria(2,"Almacenamiento de datos")
CALL sp_InsertSubCategoria(2,"Computadoras y tablets")
CALL sp_InsertSubCategoria(2,"Escáneres")
CALL sp_InsertSubCategoria(2,"Monitores")


CALL sp_InsertCategoria("Arte y Artesanías")
CALL sp_InsertSubCategoria(3,"Artesanías")
CALL sp_InsertSubCategoria(3,"Tela")
CALL sp_InsertSubCategoria(3,"Bordado")
CALL sp_InsertSubCategoria(3,"Estampado")
CALL sp_InsertSubCategoria(3,"Costura")

CALL sp_InsertCategoria("Bebé")
CALL sp_InsertSubCategoria(4,"Cuidado de bebés")
CALL sp_InsertSubCategoria(4,"Vestimenta y accesorios")
CALL sp_InsertSubCategoria(4,"Juguetes para bebés")
CALL sp_InsertSubCategoria(4,"Cochecitos y accesorios")


CALL sp_InsertCategoria("Belleza y Cuidado Personal")
CALL sp_InsertSubCategoria(5,"Maquillaje")
CALL sp_InsertSubCategoria(5,"Cuidado de la piel")
CALL sp_InsertSubCategoria(5,"Cuidado del cabello")
CALL sp_InsertSubCategoria(5,"Fragancia")
CALL sp_InsertSubCategoria(5,"Cuidado de pies y manos")

CALL sp_InsertCategoria("Moda Mujer")
CALL sp_InsertSubCategoria(6,"Ropa")
CALL sp_InsertSubCategoria(6,"Calzado")
CALL sp_InsertSubCategoria(6,"Relojes")
CALL sp_InsertSubCategoria(6,"Bolsos")
CALL sp_InsertSubCategoria(6,"Accesorios")

CALL sp_InsertCategoria("Moda Hombre")
CALL sp_InsertSubCategoria(7,"Ropa")
CALL sp_InsertSubCategoria(7,"Calzado")
CALL sp_InsertSubCategoria(7,"Relojes")
CALL sp_InsertSubCategoria(7,"Accesorios")

CALL sp_InsertCategoria("Moda ñina")
CALL sp_InsertSubCategoria(8,"Ropa")
CALL sp_InsertSubCategoria(8,"Calzado")
CALL sp_InsertSubCategoria(8,"Relojes")
CALL sp_InsertSubCategoria(8,"Uniforme escolares")
CALL sp_InsertSubCategoria(8,"Accesorios")

CALL sp_InsertCategoria("Moda niño")
CALL sp_InsertSubCategoria(9,"Ropa")
CALL sp_InsertSubCategoria(9,"Calzado")
CALL sp_InsertSubCategoria(9,"Relojes")
CALL sp_InsertSubCategoria(9,"Uniforme escolares")
CALL sp_InsertSubCategoria(9,"Accesorios")

CALL sp_InsertCategoria("Películas y Televisión")
CALL sp_InsertSubCategoria(10,"Peliculas")
CALL sp_InsertSubCategoria(10,"Programas de TV")
CALL sp_InsertSubCategoria(10,"Blu-ray")
CALL sp_InsertSubCategoria(10,"4K Ultra HD")


CALL sp_InsertCategoria("Videojuegos")
CALL sp_InsertSubCategoria(11,"Videojuegos")
CALL sp_InsertSubCategoria(11,"PlayStation4")
CALL sp_InsertSubCategoria(11,"PlayStation3")
CALL sp_InsertSubCategoria(11,"Xbox One")
CALL sp_InsertSubCategoria(11,"Nintendo Switch")


CALL sp_InsertCategoria("Juguetes y Juegos")
CALL sp_InsertSubCategoria(12,"Muñecos de acción")
CALL sp_InsertSubCategoria(12,"Arte y Artesanías")
CALL sp_InsertSubCategoria(13,"Disfraces")
CALL sp_InsertSubCategoria(14,"Rompecabezas")
CALL sp_InsertSubCategoria(15,"Juguestes para Construir")

CALL sp_InsertMarca('Apple')
CALL sp_InsertMarca('Takagi')
CALL sp_InsertMarca('UCEC')
CALL sp_InsertMarca('Soundcore')
CALL sp_InsertMarca('WYZE')
CALL sp_InsertMarca('Blurams')
select * from cliente
select * from pais
select * from ciudad
select * from direcciones
CALL sp_InsertCategoria('Computación')
CALL sp_InsertCategoria('ElectroHogar')
CALL sp_InsertCategoria('Moda Mujer')
CALL sp_InsertCategoria('Moda Hombre')
CALL sp_InsertSubCategoria(1,'Tablets')
CALL sp_InsertSubCategoria(1,'Laptops')
CALL sp_InsertSubCategoria(4,'Poleras')
CALL sp_InsertProductos('Laptop Huawei MateBook D15 15.6 FHD IPS i5-10210U 512GB SSD 8GB RAM Windows Home + Antivirus','Huawei',2,'Antivirus Norton de Regalo - se enviará un correo electrónico con el código para activar la licencia de 60 días totalmente gratis. Condiciones: la activación debe ser durante los 7 primeros días de la recepción del correo, caso contrario se inactivará y se considerará en desuso.',2399.00,100,'UND','SOL','imagen1.png','imagen2.png','imagen3.png','imagen4.png','imagen5.png',1,1)
CALL sp_InsertPais('Perú')
CALL sp_InsertPais('Argentina')
CALL sp_InsertCiudad(1,'Arequipa')
CALL sp_InsertCiudad(1,'Trujillo')
CALL sp_InsertCiudad(2,'Rosario')
CALL sp_InsertCliente('Maria Juana','Oscar Jara',30,'Jara1233@gmail.com',956412374,'imagen.png')
CALL sp_InsertCliente('Marco Jerson','Quispe Mamani',40,'123Quispe@gmail.com',964578941,'imagen.png')
CALL sp_InsertDireccion(1,'Calle Palmeras 123',2)
CALL sp_InsertDireccion(2,'Calle Pinos 45',3)
CALL sp_InsertRoll('Administrador','ADM')
CALL sp_InsertRoll('Usuario','USU')
select * from cliente
SELECT * FROM USER_
select * from roll
SELECT * FROM PEDIDO
SELECT * FROM CARRITOCOMPRA
SELECT * FROM USER_
SELECT * FROM DIRECCIONES
CALL sp_InsertUser(2,2,'Mallqui123','jjpld6pl9yiy',1)
CALL sp_InsertUser(2,2,'Quispe123','jlosertiser123',1)
CALL sp_InsertMedioPago(1,'Visa','1234-4564-7894-4561','456','2027-01-31')
CALL sp_UpdateUser(1,2,'Quispe123','miguel123',1)
SELECT * FROM PEDIDO
SELECT * FROM PRODUCTOS
CALL sp_InsertPedido(1,1,'2022-01-31','EmpresaOlx',2399,1.199,'Calle Palmeras 123',1,1.200,1)
CALL sp_InsertCarritoCompra(1,2,1)
INSERT INTO DESCUENTO(id_Product,dscto1,dscto2,dscto3,dscto4)VALUES(1,50,10,15,20)
INSERT INTO DESCUENTO(id_Product,dscto1,dscto2,dscto3,dscto4)VALUES(2,80,30,10,30)
INSERT INTO DESCUENTO(id_Product,dscto1,dscto2,dscto3,dscto4)VALUES(3,60,20,40,30)
CALL sp_InsertCaracteristicas(1,'Windows 11 with 6-core AMD Ryzen 5 5500U ProcessorFast charge laptop computer for school or home')
CALL sp_InsertCaracteristicas(2,'Windows 11 with 6-core AMD Ryzen 5 5500U ProcessorFast charge laptop computer for school or home')
CALL sp_InsertCaracteristicas(3,'Windows 11 with 6-core AMD Ryzen 5 5500U ProcessorFast charge laptop computer for school or home')
CALL sp_InsertHistorialCompra(1,'Torres Miguel','2022-06-04','DirecEnvio',10000,1,1000,10)
#################################################################################################################################
CALL sp_SelectProdXSubCategory('Laptops')
CALL sp_SelectProdXSubCategoryXPrecio('Laptops',1899)
cALL sp_SelectConsultaProd('Huawei')
CALL sp_SelectCiudadesXPais('Perú')
select *  from roll
SELECT * FROM CATEGORIA
#https://www.amazon.com/s?i=specialty-aps&bbn=16225009011&rh=n%3A%2116225009011%2Cn%3A281407&language=es&ref=nav_em__nav_desktop_sa_intl_accessories_and_supplies_0_2_5_2
#https://www.linio.com.pe/c/portatiles/laptops?price=1000-37539
#https://www.coolbox.pe/radiosfsfssfsfsddffsfsfsfdsf?_q=radiosfsfssfsfsddffsfsfsfdsf&map=ft

