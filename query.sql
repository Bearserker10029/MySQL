/*
Mostrar a los empleados donde el nombre o apellido comienza con S.
Mostrar el número de empleados que se incorporaron después del 15 del cada mes
*/

drop database if exists Planilla;
create database Planilla;
use Planilla;

-- Crear tabla

create table Empleado(
	user_id int not null auto_increment,
    nombre varchar(255) not null,
    apellido varchar(255) not null,
    fecha date not null,
    primary key (user_id)
);

-- Insertar datos

insert into Empleado(nombre,apellido,fecha)
values 
('Kent','Lin', '2025-05-25'),
('Pablo','Montero', '2020-05-25'),
('Miguel','Alvizuri', '2021-05-20'),
('Pedro','Picapiedra', '1990-05-19'),
('Sergio','Ramos', '2025-05-05'),
('Nicolás','Miranda', '2022-05-12'),
('Juan', 'Perez', '2024-05-26'),
('Santiago', 'López', '2015-05-26'),
('Julio', 'Sandoval', '2023-04-13'),
('Alejandro', 'Sánchez', '2022-04-10'),
('Diego', 'Palomino', '2022-04-09');

-- Query 1

select nombre, apellido
from Empleado
where apellido like 'S%'
	or nombre like 'S%';
	-- order by fecha asc

-- Query 2

select count(*) as 'Número de empleados después del día 15'
from Empleado
where day(fecha)>15;