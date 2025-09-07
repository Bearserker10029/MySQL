-- =================================================================
-- Inserción de datos específicos de Héroes
-- =================================================================

-- Usar la base de datos creada
USE laultimafantasia;

-- =================================================================
-- Héroes Principales
-- =================================================================

INSERT INTO heroes (id_heroe, nombre, edad, genero, id_clase_heroe, nivel, puntos_experiencia, activo) VALUES
(1, 'Mold', 17, 'M', 1, 1, 0, TRUE),
(2, 'Erde', 16, 'F', 2, 1, 0, TRUE),
(3, 'Kain', 25, 'M', 3, 10, 8500, FALSE);

-- =================================================================
-- Relaciones de Héroes
-- =================================================================

-- Hechizos iniciales de los héroes
-- Prerrequisito: La tabla `hechizos` debe estar poblada desde `02_datos.sql`
INSERT INTO heroe_hechizos (id_heroe, id_hechizo, nivel_del_hechizo) VALUES
(1, 'ELEC0001', 0), -- Mold conoce Chispa
(2, 'FIRE0001', 0), -- Erde conoce Piro
(2, 'HEAL0001', 0); -- Erde conoce Cura

-- Inventario inicial de los héroes
-- Prerrequisito: La tabla `objetos` debe estar poblada desde `02_datos.sql`
INSERT INTO heroe_inventario (id_heroe, id_objeto, cantidad) VALUES
(1, 1, 5), -- 5 Pociones para Mold
(1, 3, 2), -- 2 Antídotos para Mold
(2, 1, 3), -- 3 Pociones para Erde
(2, 2, 4); -- 4 Éteres para Erde

-- Progresión de estadísticas por nivel para Mold (id_heroe = 1)
INSERT INTO heroe_estadisticas_por_nivel (id_heroe, nivel_alcanzado, aumento_ataque, aumento_defensa, aumento_velocidad, aumento_poder_magico, aumento_espiritu, aumento_suerte) VALUES
(1, 2, 3, 2, 1, 0, 1, 1),
(1, 3, 3, 3, 1, 0, 1, 1),
(1, 4, 4, 3, 2, 0, 2, 1),
(1, 5, 4, 4, 2, 0, 2, 1),
(1, 15, 10, 8, 5, 2, 5, 3),
(1, 16, 11, 9, 5, 2, 5, 3),
(1, 17, 13, 10, 6, 2, 6, 4);

-- Progresión de estadísticas por nivel para Erde (id_heroe = 2)
INSERT INTO heroe_estadisticas_por_nivel (id_heroe, nivel_alcanzado, aumento_ataque, aumento_defensa, aumento_velocidad, aumento_poder_magico, aumento_espiritu, aumento_suerte) VALUES
(2, 2, 1, 2, 2, 4, 3, 2),
(2, 3, 1, 2, 2, 5, 4, 2),
(2, 4, 2, 3, 3, 5, 4, 3),
(2, 5, 2, 3, 3, 6, 5, 3);