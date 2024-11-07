create database EjemploTienda

create table Producto(
	id_producto int identity (20,2),
	nombre varchar(20),
	precio decimal(5,2),
	descuento int,
	precio_final AS (precio-precio*descuento/100),
)


insert into Producto values ('Pepitas',15.20,5)
insert into Producto values ('Celulares',15.20,8,'Electronica')
insert into Producto values ('Ajedrez',120.50,20)
insert into Producto values ('Monitor',548.29,10)
insert into Producto values ('Teclado',552.70,15)
insert into Producto values ('Galletas Oreo',22.50,20)

select * from Producto
select nombre,cast(precio_final as numeric(5,2)) from Producto

alter table Producto
	add departamento varchar(20)

update Producto set departamento = 'Electronica' where id_producto = 20
update Producto set departamento = 'Embutidos' where id_producto = 22
update Producto set departamento = 'Lacteos' where id_producto = 24
update Producto set departamento = 'Ropa' where id_producto = 28
update Producto set departamento = 'Juegueteria' where id_producto = 30

select count(distinct(departamento))from Producto

select departamento, count(*) as Numero_Productos from Producto group by departamento

select departamento, count(*) as Numero_Productos from Producto where precio_final>200 group by departamento

select departamento, count(*) from Producto where descuento>5 group by departamento HAVING count(*)>=2 

select cast(max(precio_final)as numeric(5,2))as maximo,cast(min(precio_final)as numeric(5,2))as minimo from Producto

select cast(min(precio_final) as numeric(5,2))as minimo from Producto where departamento = 'Electronica' 

select departamento,cast(min(precio_final) as numeric(5,2))as minimo from Producto where departamento = 'Electronica' group by departamento

select departamento,cast(min(precio_final) as numeric(5,2))as minimo from Producto group by departamento 

drop table Producto

create Table Producto(
	ID_producto int,
	nombre varchar(20),
	precio decimal(6,2),
	descuento int,
)

insert into Producto values (2,'Pepitas',15.20,5)
insert into Producto values (3,'Ajedrez',120.50,20)
insert into Producto values (4,'Monitor',548.29,10)
insert into Producto values (5,'Teclado',552.70,15)
insert into Producto values (6,'Galletas Oreo',22.50,20)

select * from Producto
select nombre, precio, descuento,cast((precio-precio*descuento/100)as numeric(5,2))as Precio_Descuento from Producto
select nombre,precio,avg(precio) from Producto --NO SIRVE PORQUE NO PUEDE MOSTRAR 5 COLUMNAS CON 1 COLUMNA
select nombre,precio,(select cast(avg(precio)as numeric(5,2)) from Producto)as Promedio from Producto --SOLUCION AL PROBLEMA