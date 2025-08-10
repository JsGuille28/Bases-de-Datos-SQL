/*

DESARROLLADO POR:
RANSÉS

*/

--Uso del IDENTITY (1,1) para que aumente automáticamente de 1 en 1.
--Utilicé la Función GetDate para obtener la fecha actual, pero se puede poner fechas personalizadas


--Crear la BD
CREATE DATABASE Veterinaria;
USE VETERINARIA;

--Tabla por si se hace un CRUD se pueda iniciar sesión desde aquí
CREATE TABLE Cuentas(
	CU_Codigo INT IDENTITY(1,1) PRIMARY KEY, --ID de la cuenta
	CU_Usuario VARCHAR(20) NOT NULL UNIQUE, --MNombre de usuario
	CU_Password VARCHAR(255) NOT NULL, --Contraseña
	CU_TipoCuenta VARCHAR(13) NOT NULL, --Tipo de cuenta para roles: ADMIN, Empleado y Cliente. 
	CU_FechaCracion Date NOT NULL,  --Fecha de creación de la cuenta
	CU_Estado Varchar(1) NOT NULL --Estado de la cuenta: A (Activo), I (Inactivo)

);


CREATE TABLE Medicos (
	MED_Cuenta INT,
	MED_Codigo INT IDENTITY(1, 1) PRIMARY KEY,
	MED_Nombres VARCHAR(25) NOT NULL,
	MED_Apellidos VARCHAR(25) NOT NULL,
	MED_Cedula NUMERIC(15, 0) NOT NULL,
	MED_Sexo VARCHAR (1),
	MED_Fecha_Nacimiento DATE NOT NULL,
	MED_Pais INT NOT NULL,
	MED_Estado varchar(1) NOT NULL

);


CREATE TABLE Mascota(
	MASC_Codigo INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	MASC_Nombres VARCHAR(25) NOT NULL,
	MASC_Tipo VARCHAR(25),
	MASC_Afeccion varchar(50) NOT NULL,
	MASC_Sintomas varchar(50) NOT NULL,
	MASC_Sexo VARCHAR(1) NOT NULL,
	MASC_Fecha_Nac VARCHAR(10) NOT NULL,
	MASC_Estado varchar(1) NOT NULL,

);


CREATE TABLE Cliente (
	CLI_Cuenta INT,
	CLI_Codigo INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	CLI_Nombres VARCHAR(25) NOT NULL,
	CLI_Apellidos VARCHAR(25) NOT NULL,
	CLI_Cedula NUMERIC(15),
	CLI_Sexo VARCHAR(1) NOT NULL,
	CLI_Fecha_Nac VARCHAR(10),
	CLI_Pais INT NOT NULL,
	CLI_Correo VARCHAR (30), 
	CLI_Telefono NUMERIC(13),
	CLI_Estado varchar(1) NOT NULL
);

CREATE TABLE Cliente_Mascota(
	CLM_Codigo INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	CLM_Cliente INT NOT NULL,
	CLM_Mascota INT NOT NULL,
	CLM_Descripcion VARCHAR(50) 
);


CREATE TABLE Productos (
	PROD_Codigo INT NOT NULL PRIMARY KEY,
	PROD_Nombre VARCHAR(25) NOT NULL,
	PROD_Descripcion VARCHAR(100) NOT NULL,
	PROD_Cantidad_Disponible numeric(5, 0),
	PROD_PRECIO NUMERIC(13, 2) NOT NULL,
	PROD_Fecha_Entrada varchar(8) NOT NULL,
	PROD_Proveedor INT NOT NULL,
	PROD_Estado VARCHAR(1) NOT NULL
);


CREATE TABLE Proveedor (
	PROVE_Codigo INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	PROVE_Nombre VARCHAR(25) NOT NULL,
	PROVE_Descripcion VARCHAR(100) NOT NULL,
	PROVE_Pais VARCHAR(25) NOT NULL,
	PROVE_Estado VARCHAR(1) NOT NULL
);

CREATE TABLE Factura(
	FACT_Codigo BIGINT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	FACT_Cliente INT NOT NULL,
	FACT_Producto INT NOT NULL,
	FACT_Fecha DATE NOT NULL,
	FACT_Precio INT NOT NULL,
	FACT_Cantidad NUMERIC(3), 
	FACT_Total INT NOT NULL
);


CREATE TABLE Pais(
	PAIS_Codigo INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	PAIS_Nombre VARCHAR(60) NOT NULL
);


--Relacionando mis tablas

ALTER TABLE Cliente ADD FOREIGN KEY (CLI_Cuenta) REFERENCES Cuentas(CU_Codigo);
ALTER TABLE Medicos ADD FOREIGN KEY (MED_Cuenta) REFERENCES Cuentas(CU_Codigo);

ALTER TABLE Cliente ADD FOREIGN KEY (CLI_Pais) REFERENCES Pais(PAIS_Codigo);
ALTER TABLE Medicos ADD FOREIGN KEY (MED_Pais) REFERENCES Pais(PAIS_Codigo);

ALTER TABLE Cliente_Mascota ADD FOREIGN KEY (CLM_Cliente) REFERENCES Cliente(CLI_Codigo);
ALTER TABLE Cliente_Mascota ADD FOREIGN KEY (CLM_Mascota) REFERENCES Mascota(MASC_Codigo);

ALTER TABLE Productos ADD FOREIGN KEY (PROD_Proveedor) REFERENCES Proveedor(PROVE_Codigo);
ALTER TABLE Factura ADD FOREIGN KEY (FACT_Producto) REFERENCES Productos(PROD_Codigo);
ALTER TABLE Factura ADD FOREIGN KEY (FACT_Cliente) REFERENCES Cliente(CLI_Codigo);

--Insertando Datos (Mismo orden por las relaciones )
INSERT INTO Pais VALUES ('República Dominicana');
INSERT INTO Pais VALUES ('Estados Unidos');
INSERT INTO Pais VALUES ('China');
INSERT INTO Pais VALUES ('Venezuela');
INSERT INTO Pais VALUES ('Colombia');
INSERT INTO Pais VALUES ('Brasil');
INSERT INTO Pais VALUES ('España');
INSERT INTO Pais VALUES ('Alemania');
INSERT INTO Pais VALUES ('México');
SELECT *FROM Pais;


--Tabla Cuentas
Insert INTO Cuentas VALUES('Ricardio', '1234', 'Cliente', GetDate(), 'A');
Insert INTO Cuentas VALUES('Pedrito', '1234', 'Cliente', GetDate(), 'A');
Insert INTO Cuentas VALUES('Carlito', '1234', 'Cliente', GetDate(), 'I');
Insert INTO Cuentas VALUES('Daysi', '1234', 'Cliente', GetDate(), 'A');
Insert INTO Cuentas VALUES('Arianna', '1234', 'Cliente', GetDate(), 'I');
Insert INTO Cuentas VALUES('MED_1', '1234', 'Medico', GetDate(), 'A');
Insert INTO Cuentas VALUES('MED_2', '1234', 'Medico', GetDate(), 'A');
Insert INTO Cuentas VALUES('MED_3', '1234', 'Medico', GetDate(), 'A');
Insert INTO Cuentas VALUES('MED_4', '1234', 'Medico', GetDate(), 'A');
Insert INTO Cuentas VALUES('MED_6', '1234', 'Medico', GetDate(), 'A');
SELECT *FROM Cuentas;
--Tabla Clientes
--El primer dato a ingresar es el código de la cuenta asignada y es opcional porque no todos los clientes tendrán una cuenta.
Insert INTO Cliente VALUES(1, 'Ricardio', 'Pineda', 4021231, 'M', '2001-03-28', 1, 'Ricardio@ricardio.com' , 823422, 'A');
Insert INTO Cliente VALUES(2, 'Carlos', 'Pimentel', 4021231, 'M', '2005-03-06', 1, 'Carlos@Carlos.com' , 823422, 'A');
Insert INTO Cliente VALUES(3, 'Pedro', 'Santana', 4021231, 'M', '2006-03-18', 1, 'Pedro@Pedro.com' , 823422, 'A');
Insert INTO Cliente VALUES(4, 'Daysi', 'Alcántara', 4021231, 'M', '2002-03-12', 1, 'Daysi@Daysi.com' , 823422, 'A');
Insert INTO Cliente VALUES(5, 'Arianna', 'Urbáez', 4021231, 'M', '2004-03-01', 1, 'Arianna@Arianna.com' , 823422, 'A');
SELECT *FROM Cliente;

--Tabla Médicos
Insert INTO Medicos VALUES(6, 'Nayelis', 'Rubio', 4021231, 'F', '2001-03-28', 1, 'A');
Insert INTO Medicos VALUES(7, 'Guillermo', 'Alcántara', 4021231, 'M', '1990-03-28', 6, 'A');
Insert INTO Medicos VALUES(8, 'Anna', 'Pineda', 4021231, 'F', '2001-03-28', 4, 'A');
Insert INTO Medicos VALUES(9, 'Genaro', 'González', 4021231, 'M', '1995-03-28', 5, 'A');
Insert INTO Medicos VALUES(10, 'Dionisia', 'Ferrera', 4021231, 'F', '2000-03-28', 8, 'A');
SELECT *FROM Medicos;



--Mascotas
Insert INTO Mascota VALUES('Goldie', 'Pez Dorado', 'Hinchazón', 'Dolor', 'H', '2002-04-12', 'S');
Insert INTO Mascota VALUES('Pluto', 'Perro', 'Verrugas', 'Picazón', 'M', '2002-04-12', 'S');
Insert INTO Mascota VALUES('Chechi', 'Perro', 'Neumonía', 'Exceso de Mucosidad', 'M', '2016-02-09', 'S');
Insert INTO Mascota VALUES('Francois', 'Perro', 'Hinchazón', 'Dolor', 'H', '2002-04-12', 'S');
Insert INTO Mascota VALUES('Michi', 'Gato', 'Hinchazón', 'Dolor', 'H', '2020-01-12', 'S');
Insert INTO Mascota VALUES('Metiche', 'Perro', 'Rabia', 'Babeo', 'H', '2020-01-12', 'V');
SELECT *FROM Mascota;


--Cliente Mascota: Esta tabla funciona como temporal para asignar a cada cliente su mascota y hacer consultas entre las 3 tablas
--Los datos a ingresar son: Código del cliente, Código de la mascota y una breve descripción
Insert INTO Cliente_Mascota VALUES(1, 1, 'Pez Dorado Joven');
Insert INTO Cliente_Mascota VALUES(2, 3, 'Perro Chihuahua');
Insert INTO Cliente_Mascota VALUES(3, 5, 'Gata Adulta');
Insert INTO Cliente_Mascota VALUES(1, 4, 'Perro Chihuahua');
Insert INTO Cliente_Mascota VALUES(4, 2, 'Perro Salchicha');
Insert INTO Cliente_Mascota VALUES(5, 6, 'Perro Chihuahua');

SELECT *FROM Cliente_Mascota;


--Tabla de Proveedores
Insert INTO Proveedor VALUES('Pedigree', 'Distribuidor de Comida de Perros y Gatos', 2, 'A');
Insert INTO Proveedor VALUES('Zooplies', 'Distribuidor de Comida de Perros y Gatos', 1, 'A');
Insert INTO Proveedor VALUES('Whiskas', 'Distribuidor de Comida de Perros', 2, 'A');
Insert INTO Proveedor VALUES('Gourmet', 'Distribuidor de Comida de Perros y Gatos', 2, 'A');
Insert INTO Proveedor VALUES('Wildtier Herz', 'Distribuidor de Comida Aves', 7, 'A');
SELECT *FROM Proveedor;


--Tabla de Productos
Insert INTO Productos VALUES(1, 'Pedigree M', 'Comida de Perros 200gr', 50, 250, GetDate(), 1, 'D');
Insert INTO Productos VALUES(2, 'Whiskas M', 'Comida de Gatos 250gr', 20, 450, GetDate(), 1, 'D');
Insert INTO Productos VALUES(3, 'Gourmet P', 'Comida de Gatos 150gr', 15, 150, GetDate(), 1, 'D');
Insert INTO Productos VALUES(4, 'Wildtier', 'Comida de Aves 200gr', 10, 350, GetDate(), 1, 'D');
Insert INTO Productos VALUES(5, 'Pedigree P', 'Comida de Perros 100gr', 30, 150, GetDate(), 1, 'D');
SELECT *FROM Productos;


--Datos a ingresar
--Código del Cliente, Código del producto, Fecha Sysdatetime pone la fecha y hora de la insersión,
---precio del producto, cantidad, y todal 
Insert INTO Factura VALUES(1, 1, SYSDATETIME(), 250, 2, 500);
Insert INTO Factura VALUES(2, 3, SYSDATETIME(), 150, 2, 300);
Insert INTO Factura VALUES(3, 5, SYSDATETIME(), 150, 2, 300);
Insert INTO Factura VALUES(4, 4, SYSDATETIME(), 350, 3, 1050);
Insert INTO Factura VALUES(5, 2, SYSDATETIME(), 450, 2, 900);
SELECT *FROM Factura;


--Haciendo algunas consultas
--Traer Mascotas con su respectivo cliente, la afección que tenía, síntomas y su estado actual

SELECT c.CLI_Nombres + ' ' +c.CLI_Apellidos AS 'Cliente',
	   c.CLI_Telefono AS 'Teléfono',
	   cm.CLM_Mascota AS 'ID Mascota',
	   m.MASC_Nombres AS 'Mascota',
	   m.MASC_Afeccion AS 'Afección',
	   m.MASC_Sintomas AS 'Síntomas',
	   m.MASC_Estado AS 'Estado Actual'

FROM Cliente c, Mascota m, Cliente_Mascota cm
WHERE cm.CLM_Cliente = c.CLI_Codigo 
AND m.MASC_Codigo = cm.CLM_Mascota;

SELECT *FROM Cliente;
SELECT *FROM Productos;
SELECT *FROM Factura;



--Listado de Clientes con Productos Adquiridos
SELECT c.CLI_Nombres + c.CLI_Apellidos AS 'Cliente',
	   c.CLI_Telefono AS 'Teléfeno',
	   p.PROD_Descripcion AS 'Producto',
	   f.FACT_Cantidad AS 'Cantidad',
	   f.FACT_Precio AS 'Precio',
	   f.FACT_Total AS 'Total',
	   f.FACT_Fecha AS 'Fecha de Compra'
FROM Cliente c, Productos p, Factura f
WHERE c.CLI_Codigo = f.FACT_Cliente
AND p.PROD_Codigo = f.FACT_Producto;