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

create table if not exists Heroes(
	Heroeid int auto_increment,
    Nombre varchar(10) not null default 'Heroe',
    Edad int not null,
    Genero char(1) not null,
    Clase varchar(50) not null,
    Nivel int not null default 1,
    Puntosdeexperiencia int not null,
    Parejaid int,
    Activo boolean not null default false,
    primary key (Heroeid)
);

alter table Heroes
add constraint checkedad
check(Edad between 10 and 999),
add constraint checkgenero
check(Genero = 'F' or Genero = 'M' or Genero = 'O'),
add constraint checknivel
check(Nivel between 1 and 100),
add constraint Pareja
foreign key (Parejaid) references Heroes(Heroeid),
add constraint checkClase
check(Clase regexp '^[^0-9]+$');

create table Heroeestadisticas(
	Heroeid int,
	Nivel int,
    Ataque int default 0,
    Defensa int default 0,
    Velocidad int default 0,
    Podermagico int default 0,
    Espiritu int default 0,
    Suerte int default 0,
    foreign key (Heroeid) references Heroes(Heroeid),
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
    foreign key (Heroeid) references Heroes(Heroeid),
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
    foreign key (Heroeid) references Heroes(Heroeid),
    foreign key (Magiaid) references Magia(Magiaid),
    primary key(Heroeid,Magiaid)
);

create table Enemigos(
	Enemigoid int auto_increment,
    Nombreenemigo varchar(10) not null default 'Enemigo',
    Genero varchar(1) null,
    Puntosdeexperiencia int not null,
    primary key (Enemigoid)
);

alter table Enemigos
add constraint checkgeneroEnemigos
check(Genero = 'F' or Genero = 'M' or Genero = 'O');

create table Enemigostadisticas(
	Enemigoid int,
    Ataque int default 0,
    Defensa int default 0,
    Velocidad int default 0,
    Podermagico int default 0,
    Espiritu int default 0,
    Suerte int default 0,
    foreign key (Enemigoid) references Enemigos(Enemigoid),
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
    foreign key (Enemigoid) references Enemigos(Enemigoid),
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

CREATE TABLE EnemigoMagia(
	Enemigoid int,
    Magiaid char(8),
    foreign key (Enemigoid) references Enemigos(Enemigoid),
    foreign key (Magiaid) references Magia(Magiaid),
    primary key(Enemigoid,Magiaid)
    
);

alter table Enemigos
add constraint checkpuntos
check(Puntosdeexperiencia>=0);

create table Enemigoobjetos(
	Enemigoid int,
    Objetoid int,
    probabilidad INT,
    foreign key (Enemigoid) references Enemigos(Enemigoid),
    foreign key (Objetoid) references Objetos(Objetoid),
    primary key (Enemigoid,Objetoid)
);

alter table Enemigoobjetos
add constraint checkprob
check(probabilidad between 1 and 100);

CREATE VIEW InventarioPesoTotal AS
SELECT h.Heroeid, SUM(o.Peso * ho.Cantidad) AS PesoTotal
FROM Heroes h
JOIN Heroeobjetos ho ON h.Heroeid = ho.Heroeid
JOIN Objetos o ON ho.Objetoid = o.Objetoid
GROUP BY h.Heroeid;

CREATE VIEW BonusPareja AS
SELECT h.Heroeid, h.Parejaid,
       he.Ataque * 1.5 AS AtaqueBonus,
       he.Defensa * 1.5 AS DefensaBonus
FROM Heroes h
JOIN Heroeestadisticas he ON h.Heroeid = he.Heroeid
WHERE h.Parejaid IS NOT NULL;

CREATE TABLE EvolucionMagia(
    MagiaOrigen char(8),
    NivelRequerido int,
    MagiaDestino char(8),
    FOREIGN KEY (MagiaOrigen) REFERENCES Magia(Magiaid),
    FOREIGN KEY (MagiaDestino) REFERENCES Magia(Magiaid),
    PRIMARY KEY (MagiaOrigen, NivelRequerido)
);