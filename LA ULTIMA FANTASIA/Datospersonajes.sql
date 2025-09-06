use Laultimafantasia;

insert ignore into Heroes(Nombre, Edad, Genero, Clase, Nivel, Puntosdeexperiencia, Activo) 
values
('Mold', 20, 'M', 'Caballero', 1, 0, true),
('Erde', 18, 'F', 'Mago', 1, 0, true),
('Hola', 20, 'M', 'Paladin', 1, 0, true);

insert ignore into Heroeestadisticas(Heroeid, Nivel, Ataque, Defensa, Velocidad, Podermagico, Espiritu, Suerte) 
values
(1, 1, 15, 10, 12, 5, 7, 3),  -- Mold
(2, 1, 8, 6, 10, 12, 9, 4),   -- Erde
(3, 1, 8, 6, 10, 12, 9, 4);   -- Hola

insert ignore into Heroeobjetos(Heroeid, Objetoid, Cantidad) 
values
(1, 1, 1),  -- Mold tiene 1 Baya Zreza
(2, 2, 1),  -- Erde tiene 1 Éter Máximo
(2, 3, 3);  -- Erde tiene 3 Pociones

insert ignore into HeroeMagia(Heroeid, Magiaid, NivelHechizo) 
values
(1, '00000001', 0),  -- Mold tiene Chispa
(2, '00000004', 0);  -- Erde tiene Hielo

insert ignore into Enemigos(Nombreenemigo, Genero, Puntosdeexperiencia) 
values
('Gollum', 'M', 5000),
('Malenia', 'F', 100000);

insert ignore into Clasedeenemigo(Enemigoclaseid, Enemigoid) 
values
(5, 1),  -- Gollum es Humano
(2, 2),	 -- Malenia es Demonio
(6,2 );  -- Malenia es Semidiosa