use Laultimafantasia;

insert ignore into Personaje (Rolid, Genero, Puntosdeexperiencia)
values
(1, 'M', 0),  -- Mold
(1, 'F', 0),  -- Erde
(1, 'M', 0),  -- Hola
(2, 'M', 5000),  -- Gollum
(2, 'F', 100000); -- Malenia

insert ignore into Heroeinfo (Heroeid, Nombre, Clase, Nivel, Edad, Activo)
values
(1, 'Mold', 'Caballero', 1, 20, true),
(2, 'Erde', 'Mago', 1, 18, true),
(3, 'Hola', 'Paladin', 1, 20, true);


-- Insertar estadísticas base
insert ignore into Estadistica (Estadisticaid, Ataque, Defensa, Velocidad, Podermagico, Espiritu, Suerte)
values
(1, 15, 10, 12, 5, 7, 3),  -- Mold
(2, 8, 6, 10, 12, 9, 4),   -- Erde
(3, 8, 6, 10, 12, 9, 4);   -- Hola

-- Relacionar héroes con sus estadísticas
insert ignore into Heroeestadisticas (Heroeid, Nivel, Estadisticaid)
values
(1, 1, 1),
(2, 1, 2),
(3, 1, 3);

insert ignore into Heroeobjetos(Heroeid, Objetoid, Cantidad) 
values
(1, 1, 1),  -- Mold tiene 1 Baya Zreza
(2, 2, 1),  -- Erde tiene 1 Éter Máximo
(2, 3, 3);  -- Erde tiene 3 Pociones

insert ignore into HeroeMagia(Heroeid, Magiaid, NivelHechizo) 
values
(1, '00000001', 0),  -- Mold tiene Chispa
(2, '00000004', 0);  -- Erde tiene Hielo

-- Insertar en Enemigoinfo
insert ignore into Enemigoinfo (Enemigoid, Nombreenemigo)
values
(4, 'Gollum'),
(5, 'Malenia');

insert ignore into Clasedeenemigo(Enemigoid,Enemigoclaseid) 
values
(4, 5),  -- Gollum es Humano
(5, 2),	 -- Malenia es Demonio
(5, 6);  -- Malenia es Semidiosa