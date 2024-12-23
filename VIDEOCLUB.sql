 CREATE DATABASE VIDEOCLUB
    USE VIDEOCLUB

--CREACION TABLAS
CREATE TABLE Cliente(
    ID_Cliente int primary key identity(10,1),
    nombre varchar(30),
    email varchar(30),
    contacto varchar(10),
    direccion varchar(40),
    fecha_nacimiento date, --Atributo derivado en consulta o en atributo edad?
    edad varchar(2)
)

CREATE TABLE Membresia(
    ID_Membresia int primary key identity(10,1),
    tipo varchar(30),
    descuento int,
    costo_mensual money
)

CREATE TABLE Proveedor(
    ID_Proveedor int PRIMARY KEY identity(10,1),
    nombre varchar(30),
    email varchar(30),
    tipo varchar(10)
)


CREATE TABLE Empleado(
	ID_Empleado int primary key identity(10,1),
	nombre varchar(30),
	cargo varchar(30),
	contacto varchar(30)
)

CREATE TABLE Alquiler(
	ID_Alquiler int  PRIMARY KEY identity(10,1),
	fecha_alquiler DATE,
	fecha_devolucion DATE,
	monto AS (DATEDIFF(DAY,fecha_alquiler,fecha_devolucion)*12.0) PERSISTED,
    ID_Cliente int,
    ID_Empleado int
)

CREATE TABLE Pelicula(
	ID_Pelicula int primary key identity(10,1),
	titulo varchar(30),
	genero varchar(50),
	duracion TIME,
	año_lanzamiento DATE,
	clasificacion varchar(5),
	director varchar(30)
)

CREATE TABLE Inventario(
    ID_Inventario int PRIMARY KEY identity(10,1),
	fecha_adquisicion DATE,
    estado varchar(15),
    ID_Pelicula int	
)

CREATE TABLE Alquiler_Inventario(
    ID_Alquiler int,
    ID_Inventario int,
    cantidad int
)

CREATE TABLE Proveedor_Pelicula(
    ID_Proveedor int,
    ID_Pelicula int,
    precio money,
    fecha_proveedor DATE
)

CREATE TABLE Cliente_Membresia(
    ID_Membresia int,
    ID_Cliente int,
    codigo_barras varchar(30)
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

--Restricciones para Proveedor
ALTER TABLE Proveedor
    ADD CONSTRAINT CK_Email CHECK (
        email LIKE '%_@gmail.com' OR
        email LIKE '%_@yahoo.com' OR
        email LIKE '%_@outlook.com' OR
        email LIKE '%_@gmail.es' OR
        email LIKE '%_@yahoo.es' OR
        email LIKE '%_@outlook.es'
    )
	
--Restricciones para Alquiler
ALTER TABLE Alquiler
    ADD CONSTRAINT CK_FechaAlquiler CHECK(fecha_alquiler<=GETDATE())  --fecha real para alquiler
                                                                                
ALTER TABLE Alquiler
    ADD CONSTRAINT CK_FechaDevolucion CHECK(fecha_devolucion<=GETDATE()) --fecha real devolucion

ALTER TABLE Membresia
    ADD CONSTRAINT CK_Membresia CHECK(tipo in ('Basica','VIP','Premium')) 

--MODELO RELACIONAL
ALTER TABLE Inventario
    ADD FOREIGN KEY (ID_Pelicula) REFERENCES Pelicula(ID_Pelicula) 

ALTER TABLE Alquiler
    ADD FOREIGN KEY (ID_Empleado) REFERENCES Empleado(ID_Empleado) 

ALTER TABLE Alquiler
    ADD FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente) 

ALTER TABLE Alquiler_Inventario
    ADD FOREIGN KEY (ID_Alquiler) REFERENCES Alquiler(ID_Alquiler) 

ALTER TABLE Alquiler_Inventario
    ADD FOREIGN KEY (ID_Inventario) REFERENCES Inventario(ID_Inventario) 

ALTER TABLE Proveedor_Pelicula
    ADD FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor(ID_Proveedor)

ALTER TABLE Proveedor_Pelicula
    ADD FOREIGN KEY (ID_Pelicula) REFERENCES Pelicula(ID_Pelicula)

ALTER TABLE Cliente_Membresia
    ADD FOREIGN KEY (ID_Membresia) REFERENCES Membresia(ID_Membresia)

ALTER TABLE Cliente_Membresia
    ADD FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)

--AGREGAR VALORES
INSERT INTO Cliente (nombre, email, contacto, direccion, fecha_nacimiento, edad) VALUES
('Carlos Perez', 'carlos.perez@gmail.com', '5512345678', 'Av. Central 123', '1995-05-12', '29'),
('Maria Lopez', 'maria.lopez@yahoo.com', '5567891234', 'Calle Sur 456', '1988-08-20', '36'),
('Juan Torres', 'juan.torres@outlook.com', '5534567890', 'Calle Norte 789', '2000-12-15', '23'),
('Ana Garcia', 'ana.garcia@gmail.es', '5543219876', 'Av. Oriente 321', '1993-03-10', '31'),
('Pedro Sanchez', 'pedro.sanchez@gmail.com', '5519876543', 'Calle Poniente 987', '1985-11-02', '39'),
('Laura Martinez', 'laura.martinez@yahoo.es', '5523456789', 'Av. Revolución 654', '1990-07-19', '34'),
('Sofia Fernandez', 'sofia.fernandez@gmail.com', '5565432198', 'Calle Progreso 432', '1998-10-25', '26'),
('Diego Ramirez', 'diego.ramirez@outlook.es', '5532198765', 'Av. Libertad 876', '1983-09-30', '41'),
('Valeria Gomez', 'valeria.gomez@gmail.com', '5521987654', 'Calle Unión 765', '1992-04-17', '32'),
('Miguel Herrera', 'miguel.herrera@yahoo.com', '5545678912', 'Av. Paz 567', '1997-06-05', '27'),
('Fernanda Morales', 'fernanda.morales@gmail.com', '5534567891', 'Calle Luz 234', '1994-02-28', '30'),
('Luis Dominguez', 'luis.dominguez@outlook.com', '5561237890', 'Av. Horizonte 123', '1991-01-01', '33'),
('Gloria Alvarez', 'gloria.alvarez@yahoo.com', '5556781234', 'Calle Lluvia 321', '1989-11-11', '35'),
('Sebastian Vega', 'sebastian.vega@gmail.es', '5543218765', 'Calle Brisa 654', '2002-03-21', '22'),
('Natalia Ruiz', 'natalia.ruiz@gmail.com', '5576543219', 'Av. Rayo 987', '1987-10-18', '37');

INSERT INTO Membresia (tipo, descuento, costo_mensual) VALUES
('Basica', 10, 99.99),
('VIP', 20, 199.99),
('Premium', 30, 299.99),
('Basica', 10, 99.99),
('VIP', 20, 199.99),
('Premium', 30, 299.99),
('Basica', 10, 99.99),
('VIP', 20, 199.99),
('Premium', 30, 299.99),
('Basica', 10, 99.99),
('VIP', 20, 199.99),
('Premium', 30, 299.99),
('Basica', 10, 99.99),
('VIP', 20, 199.99),
('Premium', 30, 299.99);

INSERT INTO Proveedor (nombre, email, tipo) VALUES
('CineDistribuidora', 'contacto@cinedistribuidora.gmail.com', 'Digital'),
('ProVideo', 'ventas@provideoyahoo.com', 'DVD'),
('MegaPeliculas', 'info@megapeliculasoutlook.com', 'Blu-ray'),
('StreamCorp', 'soporte@streamcorpgmail.es', 'Digital'),
('FilmProvider', 'contacto@filmprovideryahoo.com', 'DVD'),
('DistribuidoresMX', 'ventas@distribuidoresmxgmail.com', 'Digital'),
('PelisNow', 'info@pelisnowgmail.com', 'Blu-ray'),
('CineMex', 'ventas@cinemexyahoo.com', 'DVD'),
('Filmoteca', 'info@filmotecagmail.com', 'Blu-ray'),
('PeliculasGlobal', 'contacto@peliculasglobaloutlook.com', 'Digital'),
('BluShop', 'ventas@blushopgmail.com', 'Blu-ray'),
('CinemaWorld', 'soporte@cinemaworldoutlook.com', 'DVD'),
('StreamingLatino', 'ventas@streaminglatinogmail.com', 'Digital'),
('FilmNation', 'contacto@filmnationyahoo.com', 'Blu-ray'),
('VideoPlus', 'info@videoplusoutlook.com', 'DVD');

INSERT INTO Empleado (nombre, cargo, contacto) VALUES
('Luis Gomez', 'Gerente', '5532145678'),
('Ana Perez', 'Cajero', '5545678932'),
('Maria Torres', 'Administrador', '5538765432'),
('Juan Sanchez', 'Supervisor', '5523456789'),
('Carla Fernandez', 'Encargado', '5545678943'),
('Diego Ramirez', 'Cajero', '5556789210'),
('Laura Alvarez', 'Supervisor', '5549876543'),
('Pedro Vega', 'Gerente', '5521123456'),
('Sofia Morales', 'Administrador', '5543219876'),
('Fernando Lopez', 'Encargado', '5567894321'),
('Miguel Herrera', 'Supervisor', '5523456123'),
('Natalia Garcia', 'Cajero', '5565432198'),
('Sebastian Cruz', 'Administrador', '5545678910'),
('Valeria Ruiz', 'Encargado', '5551234567'),
('Gloria Dominguez', 'Cajero', '5532147896');

INSERT INTO Inventario (fecha_adquisicion, estado, ID_Pelicula) VALUES
('2024-01-10', 'Disponible', 10),
('2024-02-15', 'Disponible', 11),
('2024-03-20', 'Rentado', 12),
('2024-04-05', 'Rentado', 13),
('2024-05-10', 'En Reparación', 14),
('2024-06-25', 'Disponible', 15),
('2024-07-14', 'Disponible', 16),
('2024-08-01', 'Rentado', 17),
('2024-09-18', 'Rentado', 18),
('2024-10-22', 'En Reparación', 19),
('2024-11-05', 'Disponible', 20),
('2024-11-12', 'Disponible', 21),
('2024-11-17', 'Rentado', 22),
('2024-11-18', 'Rentado', 23),
('2024-11-19', 'Disponible', 24);

INSERT INTO Alquiler (fecha_alquiler, fecha_devolucion, ID_Cliente, ID_Empleado) VALUES
('2024-11-01', '2024-11-05', 10, 10),
('2024-11-02', '2024-11-06', 11, 11),
('2024-11-03', '2024-11-07', 12, 12),
('2024-11-04', '2024-11-08', 13, 13),
('2024-11-05', '2024-11-09', 14, 14),
('2024-11-06', '2024-11-10', 15, 15),
('2024-11-07', '2024-11-11', 16, 10),
('2024-11-08', '2024-11-12', 17, 11),
('2024-11-09', '2024-11-13', 18, 12),
('2024-11-10', '2024-11-14', 19, 13),
('2024-11-11', '2024-11-15', 20, 14),
('2024-11-12', '2024-11-16', 21, 15),
('2024-11-13', '2024-11-17', 22, 10),
('2024-11-14', '2024-11-18', 23, 11),
('2024-11-15', '2024-11-19', 24, 12);



-- Tabla Pelicula
INSERT INTO Pelicula (titulo, genero, duracion, año_lanzamiento, clasificacion, director) VALUES
('El Padrino', 'Drama/Crimen', '02:55:00', '1972-03-24', 'R', 'Francis Ford Coppola'),
('El Señor de los Anillos', 'Fantasía/Aventura', '03:48:00', '2001-12-19', 'PG-13', 'Peter Jackson'),
('Pulp Fiction', 'Drama/Crimen', '02:34:00', '1994-10-14', 'R', 'Quentin Tarantino'),
('Forest Gump', 'Drama/Romance', '02:22:00', '1994-07-06', 'PG-13', 'Robert Zemeckis'),
('Matrix', 'Ciencia Ficción/Acción', '02:16:00', '1999-03-31', 'R', 'Lana Wachowski, Lilly Wachowski'),
('Jurassic Park', 'Ciencia Ficción/Aventura', '02:07:00', '1993-06-11', 'PG-13', 'Steven Spielberg'),
('Titanic', 'Drama/Romance', '03:14:00', '1997-12-19', 'PG-13', 'James Cameron'),
('Gladiador', 'Acción/Drama', '02:35:00', '2000-05-01', 'R', 'Ridley Scott'),
('Inception', 'Ciencia Ficción/Thriller', '02:28:00', '2010-07-16', 'PG-13', 'Christopher Nolan'),
('Star Wars: Una Nueva Esperanza', 'Fantasía/Aventura', '02:01:00', '1977-05-25', 'PG', 'George Lucas'),
('El Caballero de la Noche', 'Acción/Crimen', '02:32:00', '2008-07-18', 'PG-13', 'Christopher Nolan'),
('Avengers: Endgame', 'Acción/Ciencia Ficción', '03:01:00', '2019-04-26', 'PG-13', 'Anthony Russo, Joe Russo'),
('Coco', 'Animación/Familia', '01:45:00', '2017-10-27', 'PG', 'Lee Unkrich, Adrian Molina'),
('Toy Story', 'Animación/Familia', '01:21:00', '1995-11-22', 'G', 'John Lasseter'),
('Avatar', 'Ciencia Ficción/Aventura', '02:42:00', '2009-12-18', 'PG-13', 'James Cameron');

INSERT INTO Alquiler_Inventario (ID_Alquiler, ID_Inventario, cantidad) VALUES
(10, 10, 1),
(11, 11, 1),
(12, 12, 1),
(13, 13, 1),
(14, 14, 1),
(15, 15, 1),
(16, 16, 1),
(17, 17, 1),
(18, 18, 1),
(19, 19, 1),
(20, 20, 1),
(21, 21, 1),
(22, 22, 1),
(23, 23, 1),
(24, 24, 1);

INSERT INTO Proveedor_Pelicula (ID_Proveedor, ID_Pelicula, precio, fecha_proveedor) VALUES
(10, 10, 120.00, '2024-01-10'),
(11, 11, 130.00, '2024-02-15'),
(12, 12, 140.00, '2024-03-20'),
(13, 13, 150.00, '2024-04-05'),
(14, 14, 160.00, '2024-05-10'),
(15, 15, 170.00, '2024-06-25'),
(16, 16, 180.00, '2024-07-14'),
(17, 17, 190.00, '2024-08-01'),
(18, 18, 200.00, '2024-09-18'),
(19, 19, 210.00, '2024-10-22'),
(20, 20, 220.00, '2024-11-05'),
(21, 21, 230.00, '2024-11-12'),
(22, 22, 240.00, '2024-11-17'),
(23, 23, 250.00, '2024-11-18'),
(24, 24, 260.00, '2024-11-19');

INSERT INTO Cliente_Membresia (ID_Membresia, ID_Cliente, codigo_barras) VALUES
(10, 10, '123456789012345'),
(11, 11, '123456789112345'),
(12, 12, '123456789212345'),
(13, 13, '123456789312345'),
(14, 14, '123456789412345'),
(15, 15, '123456789512345'),
(16, 16, '123456789612345'),
(17, 17, '123456789712345'),
(18, 18, '123456789812345'),
(19, 19, '123456789912345'),
(20, 20, '123456789013245'),
(21, 21, '123456789113245'),
(22, 22, '123456789213245'),
(23, 23, '123456789313245'),
(24, 24, '123456789413245');

--CONSULTAS