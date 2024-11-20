CREATE DATABASE GYM
USE GYM

CREATE TABLE Clientes(
    ID_Cliente int primary key IDENTITY(10,1),
    Nombre varchar(20),
    Apellido varchar(20),
    Edad tinyint,
    Membresia varchar(10) 
)

CREATE TABLE Entrenadores(
    ID_Entrenador int primary key identity(1,1),
    Especialidad varchar(30) NOT NULL
)

CREATE TABLE Clases(
    ID_Clase int primary key identity(100,1),
    Nombre_Clase varchar(20),
    Dia varchar(10),
    Hora time,
    ID_Entrenador int
)


CREATE TABLE Asistencias(
    ID_Asistencia int primary key identity(5,1),
    ID_Cliente int,
    ID_Clase int,
    Fecha DATE
)

--LLAVES FORÁNEAS
ALTER TABLE Clases
    ADD FOREIGN KEY (ID_Entrenador) REFERENCES Entrenadores(ID_Entrenador)

ALTER TABLE Asistencias
    ADD FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)

ALTER TABLE Asistencias
    ADD FOREIGN KEY (ID_Clase) REFERENCES Clase(ID_Clase)

--RESTRICCIONES
ALTER TABLE Asistencias
    ADD CONSTRAINT CK_Fecha CHECK(Fecha<=GETDATE())

ALTER TABLE Clientes
    ADD CONSTRAINT CK_Edad CHECK(Edad >= 18)

ALTER TABLE Clases
    ADD CONSTRAINT CK_Hora CHECK (Hora BETWEEN '6:00:00' AND '22:00:00')

--CONSULTAS

SELECT COUNT(DISTINCT(Especialidad))as Especialidades FROM Entrenadores

--Contar el número de clases impartidas por cada entrenador, ordenadas de mayor a menor.
SELECT COUNT(DISTINCT(ID_Entrenador)) FROM Clases ORDER BY ID_Clases DESC

--Listar los entrenadores que imparten más de 5 clases por semana.
SELECT ID_Entrenador,Dia, COUNT(*) AS total_clases_dia FROM Clases GROUP BY ID_Entrenador HAVING COUNT(*)>5

--Calcular la edad promedio de los clientes para cada tipo de membresía y mostrar solo el tipo de membresía y la edad promedio.
SELECT Membresia, AVG(Edad) as Promedio_Edad FROM CLientes GROUP BY Membresia

--Mostrar el total de asistencias acumuladas de cada cliente a lo largo del mes actual (un atributo derivado a partir de los datos de asistencia).
SELECT ID_Cliente, COUNT(*) AS Total_Asistencias_Mes FROM Asistencias WHERE 
    MONTH(Fecha) = MONTH(GETDATE()) AND 
    YEAR(Fecha) = YEAR(GETDATE())
GROUP BY ID_Cliente;

--Definir una variable temporal para calcular el número de clases a las que asiste cada cliente y luego filtrar para mostrar solo aquellos que asistieron a más de 10 clases.
DECLARE @NumClases INT
SELECT @NumClases = COUNT(ID_Clase) FROM Asistencias
SELECT ID_Clase, @NumClases FROM Asistencias GROUP BY ID_Cliente HAVING @NumClases>10
--CHATGPT :)
SELECT 
    ID_Cliente, 
    COUNT(ID_Clase) AS Total_Clases 
FROM 
    Asistencias
GROUP BY 
    ID_Cliente
HAVING 
    COUNT(ID_Clase) > 10;

--Mostrar los nombres de los clientes junto con el nombre de la clase y el nombre del entrenador de cada clase a la que asistieron.
SELECT 
    Cliente.Nombre AS Nombre_Cliente, 
    Clientes.Apellido AS Apellido_Cliente,
    Clases.ID_Clases, 
    Entrenadores.ID_Entrenador
FROM 
    Asistencias
JOIN 
    Clientes ON Asistencias.ID_Cliente = Clientes.ID_Cliente
JOIN 
    Clases ON Asistencias.ID_Clase = Clases.ID_Clase
JOIN 
    Entrenadores ON Clases.ID_Entrenador = Entrenadores.ID_Entrenador;

--Mostrar el nombre de cada clase junto con los clientes que asistieron a ella.
SELECT Clases.Nombre_Clase, Clientes.Nombre FROM Clases INNER JOIN Asistencias ON Clases.ID_Clase = Asistencias.ID_Clase

--Mostrar todas las clases con el nombre del entrenador, e incluir aquellas clases que aún no tienen entrenadores asignados.
select Clases.ID_Clases, Entrenadores.ID_Entrenador from Clases LEFT JOIN Entrenadores ON 
Clases.ID_Entrenador = Entrenadores.ID_Entrenador

--Mostrar todos los entrenadores y, en caso de que alguno no tenga clases asignadas, también incluirlos en el resultado.



--Mostrar una lista completa de todos los clientes y entrenadores, relacionando los que tienen asignaciones de clases en común e incluyendo aquellos que no tienen relaciones.