-- =================================================================
-- Creación de la base de datos
-- =================================================================
DROP DATABASE IF EXISTS laultimafantasia;
CREATE DATABASE laultimafantasia;
USE laultimafantasia;

-- =================================================================
-- Tablas de Look-up (Independientes)
-- =================================================================

CREATE TABLE elementos (
    id_elemento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE objetos (
    id_objeto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    efecto_uso TEXT NOT NULL,
    peso_kg DECIMAL(10, 2) NOT NULL
);

CREATE TABLE clases_heroe (
    id_clase_heroe INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE clases_enemigo (
    id_clase_enemigo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- =================================================================
-- Módulo de Magia
-- =================================================================

CREATE TABLE hechizos (
    id_hechizo CHAR(8) PRIMARY KEY, -- Identificador hexadecimal
    nombre VARCHAR(15) NOT NULL,
    id_elemento INT NOT NULL,
    potencia DECIMAL(5, 2) NOT NULL,
    precision_hechizo DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (id_elemento) REFERENCES elementos(id_elemento),
    CHECK (potencia > 0 AND potencia <= 255),
    CHECK (precision_hechizo > 0 AND precision_hechizo <= 100)
);

-- =================================================================
-- Módulo de Héroes
-- =================================================================

CREATE TABLE heroes (
    id_heroe INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(10) NOT NULL DEFAULT 'Heroe',
    edad INT NOT NULL,
    genero CHAR(1) NOT NULL,
    id_clase_heroe INT NOT NULL,
    nivel INT NOT NULL,
    puntos_experiencia INT NOT NULL,
    pareja_id INT NULL UNIQUE,
    activo BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_clase_heroe) REFERENCES clases_heroe(id_clase_heroe),
    FOREIGN KEY (pareja_id) REFERENCES heroes(id_heroe),
    CHECK (edad BETWEEN 10 AND 999),
    CHECK (genero IN ('M', 'F', 'O')),
    CHECK (nivel BETWEEN 1 AND 100)
);

-- =================================================================
-- Módulo de Enemigos
-- =================================================================

CREATE TABLE enemigos (
    id_enemigo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    genero CHAR(1) NULL,
    ataque INT NOT NULL,
    defensa INT NOT NULL,
    velocidad INT NOT NULL,
    poder_magico INT NOT NULL,
    espiritu INT NOT NULL,
    suerte INT NOT NULL,
    experiencia_otorgada INT NOT NULL,
    CHECK (genero IN ('M', 'F', 'O'))
);

CREATE TABLE ataques_fisicos (
    id_ataque_fisico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    potencia INT NOT NULL
);

-- =================================================================
-- Tablas de Relaciones (Muchos a Muchos y Relaciones Complejas)
-- =================================================================

-- Relación: Estadísticas que gana un héroe al subir de nivel
CREATE TABLE heroe_estadisticas_por_nivel (
    id_heroe_estadistica INT AUTO_INCREMENT PRIMARY KEY,
    id_heroe INT NOT NULL,
    nivel_alcanzado INT NOT NULL,
    aumento_ataque INT NOT NULL DEFAULT 0,
    aumento_defensa INT NOT NULL DEFAULT 0,
    aumento_velocidad INT NOT NULL DEFAULT 0,
    aumento_poder_magico INT NOT NULL DEFAULT 0,
    aumento_espiritu INT NOT NULL DEFAULT 0,
    aumento_suerte INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_heroe) REFERENCES heroes(id_heroe)
);

-- Relación: Inventario de un héroe
-- NOTA: La restricción del peso (SUM(peso) <= ataque^2) debe ser manejada por la lógica de la aplicación.
CREATE TABLE heroe_inventario (
    id_heroe INT NOT NULL,
    id_objeto INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_heroe, id_objeto),
    FOREIGN KEY (id_heroe) REFERENCES heroes(id_heroe),
    FOREIGN KEY (id_objeto) REFERENCES objetos(id_objeto),
    CHECK (cantidad > 0)
);

-- Relación: Hechizos aprendidos por un héroe
CREATE TABLE heroe_hechizos (
    id_heroe INT NOT NULL,
    id_hechizo CHAR(8) NOT NULL,
    nivel_del_hechizo INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id_heroe, id_hechizo),
    FOREIGN KEY (id_heroe) REFERENCES heroes(id_heroe),
    FOREIGN KEY (id_hechizo) REFERENCES hechizos(id_hechizo)
);

-- Relación: Clases de un enemigo
CREATE TABLE enemigo_clases (
    id_enemigo INT NOT NULL,
    id_clase_enemigo INT NOT NULL,
    PRIMARY KEY (id_enemigo, id_clase_enemigo),
    FOREIGN KEY (id_enemigo) REFERENCES enemigos(id_enemigo),
    FOREIGN KEY (id_clase_enemigo) REFERENCES clases_enemigo(id_clase_enemigo)
);

-- Relación: Modificadores elementales (debilidad/resistencia) de una clase de enemigo
CREATE TABLE clase_elemental_modificador (
    id_clase_enemigo INT NOT NULL,
    id_elemento INT NOT NULL,
    multiplicador_dano DECIMAL(5, 2) NOT NULL,
    PRIMARY KEY (id_clase_enemigo, id_elemento),
    FOREIGN KEY (id_clase_enemigo) REFERENCES clases_enemigo(id_clase_enemigo),
    FOREIGN KEY (id_elemento) REFERENCES elementos(id_elemento)
);

-- Relación: Hechizos que puede usar un enemigo
CREATE TABLE enemigo_hechizos (
    id_enemigo INT NOT NULL,
    id_hechizo CHAR(8) NOT NULL,
    PRIMARY KEY (id_enemigo, id_hechizo),
    FOREIGN KEY (id_enemigo) REFERENCES enemigos(id_enemigo),
    FOREIGN KEY (id_hechizo) REFERENCES hechizos(id_hechizo)
);

-- Relación: Ataques físicos que puede usar un enemigo
CREATE TABLE enemigo_ataques_fisicos (
    id_enemigo INT NOT NULL,
    id_ataque_fisico INT NOT NULL,
    PRIMARY KEY (id_enemigo, id_ataque_fisico),
    FOREIGN KEY (id_enemigo) REFERENCES enemigos(id_enemigo),
    FOREIGN KEY (id_ataque_fisico) REFERENCES ataques_fisicos(id_ataque_fisico)
);

-- Relación: Objetos que puede dropear un enemigo
CREATE TABLE enemigo_drops (
    id_enemigo INT NOT NULL,
    id_objeto INT NOT NULL,
    probabilidad_drop INT NOT NULL,
    PRIMARY KEY (id_enemigo, id_objeto),
    FOREIGN KEY (id_enemigo) REFERENCES enemigos(id_enemigo),
    FOREIGN KEY (id_objeto) REFERENCES objetos(id_objeto),
    CHECK (probabilidad_drop BETWEEN 1 AND 100)
);

-- Relación: Evolución de hechizos
CREATE TABLE hechizo_evolucion (
    id_hechizo_origen CHAR(8) NOT NULL,
    nivel_requerido INT NOT NULL,
    id_hechizo_desbloqueado CHAR(8) NOT NULL,
    PRIMARY KEY (id_hechizo_origen, id_hechizo_desbloqueado),
    FOREIGN KEY (id_hechizo_origen) REFERENCES hechizos(id_hechizo),
    FOREIGN KEY (id_hechizo_desbloqueado) REFERENCES hechizos(id_hechizo)
);
