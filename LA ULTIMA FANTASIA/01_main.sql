drop database if exists laultimafantasia;
create database laultimafantasia;
use laultimafantasia;

create table elementos (
    id_elemento int auto_increment primary key,
    nombre varchar(50) not null unique
);

create table objetos (
    id_objeto int auto_increment primary key,
    nombre varchar(50) not null,
    efecto_uso text not null,
    peso_kg decimal(10, 2) not null
);

create table clases_heroe (
    id_clase_heroe int auto_increment primary key,
    nombre varchar(50) not null unique
);

create table clases_enemigo (
    id_clase_enemigo int auto_increment primary key,
    nombre varchar(50) not null unique
);

create table hechizos (
    id_hechizo char(8) primary key, -- Identificador hexadecimal
    nombre varchar(15) not null,
    id_elemento int not null,
    potencia decimal(5, 2) not null,
    precision_hechizo decimal(5, 2) not null,
    foreign key (id_elemento) references elementos(id_elemento),
    check (potencia > 0 and potencia <= 255),
    check (precision_hechizo > 0 and precision_hechizo <= 100)
);

create table heroes (
    id_heroe int auto_increment primary key,
    nombre varchar(10) not null default 'Heroe',
    edad int not null,
    genero char(1) not null,
    id_clase_heroe int not null,
    nivel int not null,
    puntos_experiencia int not null,
    pareja_id int null unique,
    activo boolean not null default false,
    foreign key (id_clase_heroe) references clases_heroe(id_clase_heroe),
    foreign key (pareja_id) references heroes(id_heroe),
    check (edad between 10 and 999),
    check (genero in ('M', 'F', 'O')),
    check (nivel between 1 and 100)
);

create table enemigos (
    id_enemigo int auto_increment primary key,
    nombre varchar(50) not null,
    genero char(1) null,
    ataque int not null,
    defensa int not null,
    velocidad int not null,
    poder_magico int not null,
    espiritu int not null,
    suerte int not null,
    experiencia_otorgada int not null,
    check (genero in ('M', 'F', 'O'))
);

create table ataques_fisicos (
    id_ataque_fisico int auto_increment primary key,
    nombre varchar(50) not null,
    potencia int not null
);

create table heroe_estadisticas_por_nivel (
    id_heroe_estadistica int auto_increment primary key,
    id_heroe int not null,
    nivel_alcanzado int not null,
    aumento_ataque int not null default 0,
    aumento_defensa int not null default 0,
    aumento_velocidad int not null default 0,
    aumento_poder_magico int not null default 0,
    aumento_espiritu int not null default 0,
    aumento_suerte int not null default 0,
    foreign key (id_heroe) references heroes(id_heroe)
);

create table heroe_inventario (
    id_heroe int not null,
    id_objeto int not null,
    cantidad int not null,
    primary key (id_heroe, id_objeto),
    foreign key (id_heroe) references heroes(id_heroe),
    foreign key (id_objeto) references objetos(id_objeto),
    check (cantidad > 0)
);

create table heroe_hechizos (
    id_heroe int not null,
    id_hechizo char(8) not null,
    nivel_del_hechizo int not null default 0,
    primary key (id_heroe, id_hechizo),
    foreign key (id_heroe) references heroes(id_heroe),
    foreign key (id_hechizo) references hechizos(id_hechizo)
);

create table enemigo_clases (
    id_enemigo int not null,
    id_clase_enemigo int not null,
    primary key (id_enemigo, id_clase_enemigo),
    foreign key (id_enemigo) references enemigos(id_enemigo),
    foreign key (id_clase_enemigo) references clases_enemigo(id_clase_enemigo)
);

create table clase_elemento (
    id_clase_enemigo int not null,
    id_elemento int not null,
    multiplicador_dano decimal(5, 2) not null,
    primary key (id_clase_enemigo, id_elemento),
    foreign key (id_clase_enemigo) references clases_enemigo(id_clase_enemigo),
    foreign key (id_elemento) references elementos(id_elemento)
);

create table enemigo_hechizos (
    id_enemigo int not null,
    id_hechizo char(8) not null,
    primary key (id_enemigo, id_hechizo),
    foreign key (id_enemigo) references enemigos(id_enemigo),
    foreign key (id_hechizo) references hechizos(id_hechizo)
);

create table enemigo_ataques_fisicos (
    id_enemigo int not null,
    id_ataque_fisico int not null,
    primary key (id_enemigo, id_ataque_fisico),
    foreign key (id_enemigo) references enemigos(id_enemigo),
    foreign key (id_ataque_fisico) references ataques_fisicos(id_ataque_fisico)
);

create table enemigo_drops (
    id_enemigo int not null,
    id_objeto int not null,
    probabilidad_drop int not null,
    primary key (id_enemigo, id_objeto),
    foreign key (id_enemigo) references enemigos(id_enemigo),
    foreign key (id_objeto) references objetos(id_objeto),
    check (probabilidad_drop between 1 and 100)
);

create table hechizo_evolucion (
    id_hechizo_origen char(8) not null,
    nivel_requerido int not null,
    id_hechizo_desbloqueado char(8) not null,
    primary key (id_hechizo_origen, id_hechizo_desbloqueado),
    foreign key (id_hechizo_origen) references hechizos(id_hechizo),
    foreign key (id_hechizo_desbloqueado) references hechizos(id_hechizo)
);
