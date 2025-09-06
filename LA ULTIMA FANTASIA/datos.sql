use Laultimafantasia;

insert ignore into Enemigoclases(Nombre)
values
('Dragon'),
('Fantasma'),
('Demonio'),
('Pez'),
('Humano'),
('Entre otros');

insert ignore into Elemento(elementonombre)
values
('Fuego'),
('Agua'),
('Tierra'),
('Hielo'),
('Viento'),
('Electricidad');

insert ignore into Magia(Magiaid, Nombremagia, elementoid, Potencia, Precisionmagia) 
values
('00000001','Colmillo Rayo',6,50,95),
('00000002','Impactrueno',6,120,85),
('00000003','Giro Fuego',1,80,90),
('00000004','Ventisca',4,100,80);

INSERT ignore INTO Objetos(Nombre, Efecto, Peso) 
values
('Baya Zreza', 'Aumenta el ataque', 5.50),
('Éter Máximo', 'Aumenta el poder mágico', 3.20),
('Poción', 'Restaura vida', 0.50);

insert ignore into Debilidades(Enemigoclaseid, elementoid, danio) 
values
(1, 4, 230),  -- Dragón débil a Hielo (230% daño)
(1, 1, 40);   -- Dragón resiste Fuego (40% daño)

insert ignore into Rol(Rolid,Rolnombre)
values
(1,'Here'),
(2,'Enemigo');