CREATE DATABASE Biblioteca
USE Biblioteca
CREATE TABLE Libros(
    ID_Libro int primary key identity(1,1),
    Titulo varchar(20) NOT NULL,
    Autor varchar(20),
    Fecha_Publicacion date NOT NULL,
    Genero varchar(20) NOT NULL,
    Cantidad_Disponible int NOT NULL
)

CREATE TABLE Usuario(
    ID_Usuario int PRIMARY KEY identity (100,1),
    Nombre_Usuario varchar(20)
)

CREATE TABLE Prestamos(
    ID_Prestamo int PRIMARY KEY identity(10,1),
    ID_Libro int,
    Fecha_Prestamo date NOT NULL,
    Fecha_Devolucion date,
    ID_Usuario int
)

ALTER TABLE Libros
    ADD CONSTRAINT CK_Titulo UNIQUE (ID_Libro, Titulo)

ALTER TABLE Libros
    ADD CONSTRAINT CK_Cantidad_Disponible CHECK (Cantidad_Disponible>=0)

ALTER TABLE Prestamos
    ADD FOREIGN KEY (ID_Libro) REFERENCES Libros (ID_Libro)

ALTER TABLE Prestamos
    ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario (ID_Usuario)

SELECT * FROM Libros
SELECT * FROM Prestamos
SELECT * FROM Usuario


INSERT INTO Libros VALUES ('Cien años de Soledad','Garcia Marquez','2005-07-01','Poesia',2)
INSERT INTO Libros VALUES ('Amor luz','Yo merengues','2022-12-25','Novela',100)
INSERT INTO Libros VALUES ('Te amo mi Amor','Yo merengues','2024-11-08','Me encantas',100000)
INSERT INTO Libros VALUES ('Harry Potter','J-K Rowling','2001-04-12','Novela',8)

INSERT INTO Usuario VALUES ('Carlangas')
INSERT INTO Usuario VALUES ('Celeste')
INSERT INTO Usuario VALUES ('Mamá Bere')

INSERT INTO Prestamos VALUES(1,'2024-11-08',NULL,101)
INSERT INTO Prestamos VALUES(4,'2024-11-04','2024-11-08',102)
INSERT INTO Prestamos VALUES(3,'2015-01-04','2015-01-06',100)
INSERT INTO Prestamos VALUES(5,'2015-01-04',NULL,100)
INSERT INTO Prestamos VALUES(3,'2017-01-04','2017-01-05',101)
INSERT INTO Prestamos VALUES(1,'2020-01-04','2020-01-06',100)


ALTER TABLE Libros
 ADD CONSTRAINT CK_NombreTitulo CHECK (Titulo NOT LIKE '%[^A-Za-z]%')



--Muestra el libro más antiguo de la biblioteca
SELECT TOP 1 Titulo, Fecha_Publicacion FROM Libros ORDER BY Fecha_Publicacion ASC

--Cuenta cuántos préstamos se han hecho en el último mes.
SELECT COUNT(*) TotalPrestamos FROM Prestamos WHERE MONTH(Fecha_Prestamo) = MONTH(GETDATE()-1) AND YEAR(Fecha_Prestamo) = YEAR(GETDATE())
SELECT COUNT(*) AS Total_Prestamos_Ultimo_Mes FROM Prestamos WHERE Fecha_Prestamo >= DATEADD(MONTH, -1, GETDATE());

--Muestra todos los libros con menos de 3 ejemplares disponibles.
SELECT Titulo, Cantidad_Disponible FROM Libros WHERE Cantidad_Disponible <3

--Actualiza la cantidad disponible de un libro al devolverlo.
UPDATE Libros SET Cantidad_Disponible = Cantidad_Disponible + 1 WHERE ID_Libro = (SELECT ID_Libro FROM Prestamos WHERE ID_Prestamo = 10)

--Elimina los registros de préstamos que se realizaron hace más de 2 años y no tienen fecha de devolución.
DELETE FROM Prestamos WHERE YEAR(Fecha_Prestamo)<YEAR(GETDATE()) AND Fecha_Devolucion IS NULL

--Calcula el número total de libros prestados en un rango de fechas específico.
SELECT Fecha_Prestamo, COUNT(*) AS TOTAL_LIBROS_PRESTADOS FROM Prestamos WHERE YEAR(Fecha_Prestamo) >= '2015' AND YEAR(Fecha_Prestamo)<='2020' GROUP BY Fecha_Prestamo


