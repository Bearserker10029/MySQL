-- =================================================================
-- Inserción de Datos Maestros y de Enemigos
-- =================================================================

-- Usar la base de datos creada
Use laultimafantasia;

-- =================================================================
-- Datos Maestros (Tablas de Look-up)
-- =================================================================

-- Clases para los Héroes
insert into clases_heroe (id_clase_heroe, nombre) values
(1, 'Caballero de la Luz'),
(2, 'Maga Elemental'),
(3, 'Paladín Sagrado'),
(4, 'doma Dragones');

-- Clases para los Enemigos
insert into clases_enemigo (nombre) values
('Dragon'),
('Fantasma'),
('Demonio'),
('Pez'),
('Humano'),
('Bestia');

-- Elementos
insert into elementos (id_elemento, nombre) values
(1, 'fuego'),
(2, 'agua'),
(3, 'tierra'),
(4, 'hielo'),
(5, 'viento'),
(6, 'electricidad'),
(7, 'luz'),
(8, 'oscuridad'),
(9, 'ninguno');

-- Hechizos (todos)
insert into hechizos (id_hechizo, nombre, id_elemento, potencia, precision_hechizo) values
('ElEC0001', 'chispa', 6, 20, 95),
('ElEC0002', 'rayo', 6, 60, 90),
('ElEC0003', 'tormenta', 6, 150, 80),
('FiRE0001', 'piro', 1, 25, 95),
('FiRE0002', 'piro+', 1, 70, 90),
('HeAL0001', 'cura', 7, 50, 100),
('HeAL0002', 'cura+', 7, 120, 100),
('DaRK0001', 'sombra', 8, 40, 90),
('DaRK0002', 'sombra+', 8, 90, 85);

-- Objetos (todos)
insert into objetos (id_objeto, nombre, efecto_uso, peso_kg) values
(1, 'poción', 'Restaura 50 puntos de vida', 0.2),
(2, 'éter', 'Restaura 20 puntos de magia', 0.2),
(3, 'antídoto', 'Cura el estado veneno', 0.1),
(4, 'Pluma Fénix', 'Revive a un aliado caído', 0.5),
(5, 'escama de Dragón', 'Material de fabricación raro', 1.5),
(6, 'polvo de espectro', 'Material de fabricación mágico', 0.1);

-- ataques físicos de enemigos
insert into ataques_fisicos (nombre, potencia) values
('Garra', 30),
('Mordisco', 40),
('Golpe oscuro', 70),
('Embestida', 25);

-- Evolución de hechizos
insert into hechizo_evolucion (id_hechizo_origen, nivel_requerido, id_hechizo_desbloqueado) values
('ELEc0001', 10, 'ELEC0002'),
('ELEC0002', 55, 'ELEC0003'),
('FIRE0001', 12, 'FIRE0002'),
('HEAL0001', 15, 'HEAL0002');

-- =================================================================
-- Datos de Enemigos
-- =================================================================

insert into enemigos (nombre, genero, ataque, defensa, velocidad, poder_magico, espiritu, suerte, experiencia_otorgada) values
('Goblin', 'm', 25, 15, 20, 0, 5, 10, 15),
('wyvern', 'm', 80, 65, 70, 40, 45, 30, 250),
('espectro', NuLL, 30, 50, 60, 75, 80, 20, 180),
('forond', 'm', 150, 120, 110, 180, 130, 80, 5000);

-- relaciones de Enemigos
insert into enemigo_clases (id_enemigo, id_clase_enemigo) values (1, 6), (2, 1), (3, 2), (4, 5), (4, 3);
insert into clase_elemento (id_clase_enemigo, id_elemento, multiplicador_dano) values (1, 1, 0.40), (1, 4, 2.30), (2, 7, 1.80), (2, 8, 0.25), (3, 7, 2.00);
insert into enemigo_ataques_fisicos (id_enemigo, id_ataque_fisico) values (1, 4), (2, 1), (2, 2), (4, 3);
insert into enemigo_hechizos (id_enemigo, id_hechizo) values (3, 'dArk0001'), (4, 'FIRE0002'), (4, 'DARK0002');
insert into enemigo_drops (id_enemigo, id_objeto, probabilidad_drop) values (1, 1, 25), (2, 5, 50), (3, 6, 40);