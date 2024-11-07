CREATE DATABASE VIDEOCLUB
USE VIDEOCLUB

--CREACION TABLAS
CREATE TABLE Cliente(
    ID_Cliente int identity(10,1),
    nombre varchar(30),
    email varchar(30),
    contacto varchar(10),
    direccion varchar(40),
    fecha_nacimiento date, --Atributo derivado en consulta o en atributo edad?
    edad varchar(2)
)

CREATE TABLE Membresia(
    ID_Membresia int identity(10,1),
    tipo varchar(30),
    descuento int,
    costo_mensual money
)

CREATE TABLE Proveedor(
    ID_Proveedor int identity(10,1),
    nombre varchar(30),
    email varchar(30),
    tipo varchar(10)
)

CREATE TABLE Empleado(
	ID_Empleado int identity(10,1),
	nombre varchar(30),
	cargo varchar(30),
	contacto varchar(30)
)

CREATE TABLE Alquiler(
	ID_Alquiler int identity(10,1),
	fecha_alquiler DATE,
	fecha_devolucion DATE,
	monto money --Atributo derivado o en consulta??
)

CREATE TABLE Pelicula(
	ID_Pelicula int identity(10,1),
	titulo varchar(30),
	genero varchar(50),
	duracion TIME,
	año_lanzamiento DATE,
	clasificacion varchar(5),
	director varchar(30)
)

CREATE TABLE Inventario(
    ID_Inventario int identity(10,1),
	fecha_adquisicion DATE,
    estado varchar(15)	
)

--RESTRICCIONES
--Restriccion para Empleado
ALTER TABLE Empleado
	ADD CONSTRAINT CK_Emplea_Cargo UNIQUE (ID_Empleado, cargo) --Empleado solo 1 cargo

--Resticciones para Cliente
 ALTER TABLE Cliente
    ADD CONSTRAINT CK_Nombre CHECK(nombre NOT LIKE '%[^A-Za-z]%'); --Nombre solo letras min y mayus

ALTER TABLE Cliente
    ADD CONSTRAINT CK_Contacto CHECK(contacto NOT LIKE '%[^0-9]%') --Contacto solo numeros(cel)

--Restriccion para Inventario
ALTER TABLE Inventario
	ADD CONSTRAINT CK_Fecha_Adquisicion CHECK(fecha_adquisicion<=GETDATE()) --La fecha de adquisicion no pase de la fecha actual

--Restriccion para Pelicula
ALTER TABLE Pelicula
    ADD CONSTRAINT CK_Duracion CHECK(duracion BETWEEN '01:00:00' AND '04:00:00') --Rango de duracion

--Restriccion para Proveedor
ALTER TABLE Proveedor
ADD CONSTRAINT CK_Email CHECK(email LIKE '%_@__%.__%')
	
--Restricciones para Alquiler
ALTER TABLE Alquiler
    ADD CONSTRAINT CK_FechaAlquiler CHECK(fecha_alquiler<=GETDATE())  --fecha real para alquiler
                                                                                
ALTER TABLE Alquiler
    ADD CONSTRAINT CK_FechaDevolucion CHECK(fecha_devolucion<=GETDATE()) --fecha real devolucion


--AGREGAR VALORES


--MODELO RELACIONAL


--CONSULTAS