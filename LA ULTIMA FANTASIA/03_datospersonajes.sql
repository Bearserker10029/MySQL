-- =================================================================
-- Inserción de datos específicos de Héroes
-- =================================================================

-- Usar la base de datos creada
use laultimafantasia;

-- =================================================================
-- Héroes Principales
-- =================================================================

insert into heroes (id_heroe, nombre, edad, genero, id_clase_heroe, nivel, puntos_experiencia, activo) values
(1, 'mold', 17, 'm', 1, 1, 0, true),
(2, 'erde', 16, 'f', 2, 1, 0, true),
(3, 'kain', 25, 'm', 3, 10, 8500, false);

-- =================================================================
-- Relaciones de Héroes
-- =================================================================

-- Hechizos iniciales de los héroes
-- Prerrequisito: La tabla `hechizos` debe estar poblada desde `02_datos.sql`
insert into heroe_hechizos (id_heroe, id_hechizo, nivel_del_hechizo) values
(1, 'Elec0001', 0), -- mold conoce Chispa
(2, 'Fire0001', 0), -- erde conoce Piro
(2, 'Heal0001', 0); -- erde conoce Cura

-- Inventario inicial de los héroes
-- Prerrequisito: La tabla `objetos` debe estar poblada desde `02_datos.sql`
insert into heroe_inventario (id_heroe, id_objeto, cantidad) values
(1, 1, 5), -- 5 pociones para Mold
(1, 3, 2), -- 2 antídotos para Mold
(2, 1, 3), -- 3 pociones para Erde
(2, 2, 4); -- 4 éteres para Erde

-- Progresión de estadísticas por nivel para Mold (id_heroe = 1)
insert into heroe_estadisticas_por_nivel (id_heroe, nivel_alcanzado, aumento_ataque, aumento_defensa, aumento_velocidad, aumento_poder_magico, aumento_espiritu, aumento_suerte) values
(1, 2, 3, 2, 1, 0, 1, 1),
(1, 3, 3, 3, 1, 0, 1, 1),
(1, 4, 4, 3, 2, 0, 2, 1),
(1, 5, 4, 4, 2, 0, 2, 1),
(1, 15, 10, 8, 5, 2, 5, 3),
(1, 16, 11, 9, 5, 2, 5, 3),
(1, 17, 13, 10, 6, 2, 6, 4);

-- progresión de estadísticas por nivel para Erde (id_heroe = 2)
insert into heroe_estadisticas_por_nivel (id_heroe, nivel_alcanzado, aumento_ataque, aumento_defensa, aumento_velocidad, aumento_poder_magico, aumento_espiritu, aumento_suerte) values
(2, 2, 1, 2, 2, 4, 3, 2),
(2, 3, 1, 2, 2, 5, 4, 2),
(2, 4, 2, 3, 3, 5, 4, 3),
(2, 5, 2, 3, 3, 6, 5, 3);