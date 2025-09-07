-- =================================================================
-- Inserción de Datos Maestros y de Enemigos
-- =================================================================

-- Usar la base de datos creada
USE laultimafantasia;

-- =================================================================
-- Datos Maestros (Tablas de Look-up)
-- =================================================================

-- Clases para los Héroes
INSERT INTO clases_heroe (id_clase_heroe, nombre) VALUES
(1, 'Caballero de la Luz'),
(2, 'Maga Elemental'),
(3, 'Paladín Sagrado'),
(4, 'Doma Dragones');

-- Clases para los Enemigos
INSERT INTO clases_enemigo (nombre) VALUES
('Dragon'),
('Fantasma'),
('Demonio'),
('Pez'),
('Humano'),
('Bestia');

-- Elementos
INSERT INTO elementos (id_elemento, nombre) VALUES
(1, 'Fuego'),
(2, 'Agua'),
(3, 'Tierra'),
(4, 'Hielo'),
(5, 'Viento'),
(6, 'Electricidad'),
(7, 'Luz'),
(8, 'Oscuridad'),
(9, 'Ninguno');

-- Hechizos (todos)
INSERT INTO hechizos (id_hechizo, nombre, id_elemento, potencia, precision_hechizo) VALUES
('ELEC0001', 'Chispa', 6, 20, 95),
('ELEC0002', 'Rayo', 6, 60, 90),
('ELEC0003', 'Tormenta', 6, 150, 80),
('FIRE0001', 'Piro', 1, 25, 95),
('FIRE0002', 'Piro+', 1, 70, 90),
('HEAL0001', 'Cura', 7, 50, 100),
('HEAL0002', 'Cura+', 7, 120, 100),
('DARK0001', 'Sombra', 8, 40, 90),
('DARK0002', 'Sombra+', 8, 90, 85);

-- Objetos (todos)
INSERT INTO objetos (id_objeto, nombre, efecto_uso, peso_kg) VALUES
(1, 'Poción', 'Restaura 50 puntos de vida', 0.2),
(2, 'Éter', 'Restaura 20 puntos de magia', 0.2),
(3, 'Antídoto', 'Cura el estado veneno', 0.1),
(4, 'Pluma Fénix', 'Revive a un aliado caído', 0.5),
(5, 'Escama de Dragón', 'Material de fabricación raro', 1.5),
(6, 'Polvo de espectro', 'Material de fabricación mágico', 0.1);

-- Ataques físicos de enemigos
INSERT INTO ataques_fisicos (nombre, potencia) VALUES
('Garra', 30),
('Mordisco', 40),
('Golpe Oscuro', 70),
('Embestida', 25);

-- Evolución de hechizos
INSERT INTO hechizo_evolucion (id_hechizo_origen, nivel_requerido, id_hechizo_desbloqueado) VALUES
('ELEC0001', 10, 'ELEC0002'),
('ELEC0002', 55, 'ELEC0003'),
('FIRE0001', 12, 'FIRE0002'),
('HEAL0001', 15, 'HEAL0002');

-- =================================================================
-- Datos de Enemigos
-- =================================================================

INSERT INTO enemigos (nombre, genero, ataque, defensa, velocidad, poder_magico, espiritu, suerte, experiencia_otorgada) VALUES
('Goblin', 'M', 25, 15, 20, 0, 5, 10, 15),
('Wyvern', 'M', 80, 65, 70, 40, 45, 30, 250),
('Espectro', NULL, 30, 50, 60, 75, 80, 20, 180),
('Forond', 'M', 150, 120, 110, 180, 130, 80, 5000);

-- Relaciones de Enemigos
INSERT INTO enemigo_clases (id_enemigo, id_clase_enemigo) VALUES (1, 6), (2, 1), (3, 2), (4, 5), (4, 3);
INSERT INTO clase_elemental_modificador (id_clase_enemigo, id_elemento, multiplicador_dano) VALUES (1, 1, 0.40), (1, 4, 2.30), (2, 7, 1.80), (2, 8, 0.25), (3, 7, 2.00);
INSERT INTO enemigo_ataques_fisicos (id_enemigo, id_ataque_fisico) VALUES (1, 4), (2, 1), (2, 2), (4, 3);
INSERT INTO enemigo_hechizos (id_enemigo, id_hechizo) VALUES (3, 'DARK0001'), (4, 'FIRE0002'), (4, 'DARK0002');
INSERT INTO enemigo_drops (id_enemigo, id_objeto, probabilidad_drop) VALUES (1, 1, 25), (2, 5, 50), (3, 6, 40);