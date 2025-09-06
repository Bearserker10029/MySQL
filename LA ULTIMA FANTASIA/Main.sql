/*
Kent Lin Chan
20202132
*/

drop database if exists Laultimafantasia;

create database if not exists Laultimafantasia;

use Laultimafantasia;

create table Elemento(
	elementoid int auto_increment,
    elementonombre varchar(20) not null,
    primary key (elementoid)
);

create table Magia(
	Magiaid char(8) not null,
    Nombremagia varchar(15) not null,
    elementoid int,
    Potencia int not null,
    Precisionmagia int not null,
    Tipo varchar(15) not null default 'Magico',
    foreign key (elementoid) references Elemento(elementoid),
    primary key (Magiaid)
);

alter table Magia
add constraint checkpotencia
check(Potencia between 0 and 255),
add constraint checkprecision
check(Precisionmagia between 0 and 100),
add constraint checktipo
check(Tipo='Fisico' or Tipo='Magico');

create table if not exists Rol(
	Rolid int,
    Rolnombre varchar(20),
    primary key (Rolid)
);

create table if not exists Personaje(
	Personajeid int auto_increment,
    Rolid int not null,
    Genero char(1) not null,
    Puntosdeexperiencia int not null,
    foreign key (Rolid) references Rol(Rolid),
    primary key (Personajeid)
);
alter table Personaje
add constraint checkgenero
check(Genero = 'F' or Genero = 'M' or Genero = 'O'),
add constraint checkpuntos
check(Puntosdeexperiencia>=0);

create table if not exists Heroeinfo(
	Heroeid int auto_increment,
    Nombre varchar(10) not null default 'Heroe',
    Clase varchar(50) not null,
    Nivel int not null default 1,
    Edad int not null,
    Parejaid int,
    Activo boolean not null default false,
    foreign key (Heroeid) references Personaje(Personajeid),
    foreign key (Parejaid) references Personaje(Personajeid),
    primary key (Heroeid)
);

alter table Heroeinfo
add constraint checkedad
check(Edad between 10 and 999),
add constraint checknivel
check(Nivel between 1 and 100),
add constraint checkClase
check(Clase regexp '^[^0-9]+$');

create table Estadistica(
	Estadisticaid int,
    Ataque int default 0,
    Defensa int default 0,
    Velocidad int default 0,
    Podermagico int default 0,
    Espiritu int default 0,
    Suerte int default 0,
    primary key (Estadisticaid)
);

create table Heroeestadisticas(
	Heroeid int,
	Nivel int,
    Estadisticaid int not null,
    foreign key (Estadisticaid) references Estadistica(Estadisticaid),
    foreign key (Heroeid) references Heroeinfo(Heroeid),
    primary key (Heroeid,Nivel)
);

alter table Heroeestadisticas
add constraint checknivelHeroeestadisticas
check(Nivel between 1 and 100);

create table Objetos(
	Objetoid int auto_increment,
    Nombre varchar(50) not null,
    Efecto text not null,
    Peso decimal(5,2) not null,
    primary key(Objetoid)
);
alter table Objetos
add constraint checkpeso 
check(Peso>0);

create table Heroeobjetos(
	Heroeid int,
    Objetoid int,
    Cantidad int default 0,
    foreign key (Heroeid) references Heroeinfo(Heroeid),
    foreign key (Objetoid) references Objetos(Objetoid),
    primary key (Heroeid,Objetoid)
);

alter table Heroeobjetos
add constraint checkcantidad
check(Cantidad >=0);

create table HeroeMagia(
    Heroeid int,
    Magiaid char(8),
    NivelHechizo int default 0,
    foreign key (Heroeid) references Heroeinfo(Heroeid),
    foreign key (Magiaid) references Magia(Magiaid),
    primary key(Heroeid,Magiaid)
);

create table Enemigoinfo(
	Enemigoid int auto_increment,
    Nombreenemigo varchar(10) not null default 'Enemigo',
    foreign key (Enemigoid) references Personaje(Personajeid),
    primary key (Enemigoid)
);

create table Enemigostadisticas(
	Enemigoid int,
    Estadisticaid int,
    foreign key (Estadisticaid) references Estadistica(Estadisticaid),
    foreign key (Enemigoid) references Enemigoinfo(Enemigoid),
    primary key (Enemigoid)
);

create table Enemigoclases(
	Enemigoclaseid int auto_increment,
    Nombre varchar(20) not null,
    primary key (Enemigoclaseid)
);

create table Clasedeenemigo(
	Enemigoclaseid int,
    Enemigoid int,
    foreign key (Enemigoid) references Enemigoinfo(Enemigoid),
    foreign key (Enemigoclaseid) references Enemigoclases(Enemigoclaseid),
    primary key(Enemigoid,Enemigoclaseid)
);

create table Debilidades(
	Enemigoclaseid int,
    elementoid int,
    danio int not null,
    foreign key (elementoid) references Elemento(elementoid),
    foreign key (Enemigoclaseid) references Enemigoclases(Enemigoclaseid),
    primary key (Enemigoclaseid, elementoid)
);

alter table Debilidades
add constraint checkdanio
check (danio>0);

create table EnemigoMagia(
	Enemigoid int,
    Magiaid char(8),
    foreign key (Enemigoid) references Enemigoinfo(Enemigoid),
    foreign key (Magiaid) references Magia(Magiaid),
    primary key(Enemigoid,Magiaid)
    
);

create table Enemigoobjetos(
	Enemigoid int,
    Objetoid int,
    probabilidad INT,
    foreign key (Enemigoid) references Enemigoinfo(Enemigoid),
    foreign key (Objetoid) references Objetos(Objetoid),
    primary key (Enemigoid,Objetoid)
);

alter table Enemigoobjetos
add constraint checkprob
check(probabilidad between 1 and 100);

CREATE VIEW InventarioPesoTotal AS
SELECT h.Heroeid, SUM(o.Peso * ho.Cantidad) AS PesoTotal
FROM Heroeinfo h
JOIN Heroeobjetos ho ON h.Heroeid = ho.Heroeid
JOIN Objetos o ON ho.Objetoid = o.Objetoid
GROUP BY h.Heroeid;

CREATE VIEW BonusPareja AS
SELECT h.Heroeid, h.Parejaid,
       e.Ataque * 1.5 AS AtaqueBonus,
       e.Defensa * 1.5 AS DefensaBonus
FROM Heroeinfo h
JOIN Heroeestadisticas he ON h.Heroeid = he.Heroeid
JOIN Estadistica e ON he.Estadisticaid = e.Estadisticaid
WHERE h.Parejaid IS NOT NULL;

create table EvolucionMagia(
    MagiaOrigen char(8),
    NivelRequerido int,
    MagiaDestino char(8),
    foreign key (MagiaOrigen) references Magia(Magiaid),
    foreign key (MagiaDestino) references Magia(Magiaid),
    PRIMARY KEY (MagiaOrigen, NivelRequerido)
);

/*
Recursos utilizados:
Materiales de clase
Video de midulive: https://www.youtube.com/watch?v=96s2i-H7e0w
CHATGPT

*/