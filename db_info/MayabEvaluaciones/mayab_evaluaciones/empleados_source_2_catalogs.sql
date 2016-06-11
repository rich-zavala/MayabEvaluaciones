update empleados_source set departamento = trim(replace(departamento, '  ', ' '));

/*
Automatizador de contenidos desde "empleados_source"
*/
DELETE FROM empleados;

# Crear catálogos
DELETE FROM departamentos;
ALTER TABLE departamentos AUTO_INCREMENT=1;
INSERT IGNORE INTO departamentos SELECT DISTINCT
TRIM(substring_index(departamento,'-',1)),
TRIM(REPLACE(REPLACE(departamento, substring_index(departamento,'-',1), ''), '-', '')),
TRIM(departamento)
FROM empleados_source WHERE empleado IS NOT NULL AND
departamento <> ''
ORDER BY REPLACE(REPLACE(departamento, substring_index(departamento,'-',1), ''), '-', '');

DELETE FROM puestos;
ALTER TABLE puestos AUTO_INCREMENT=1;
INSERT INTO puestos (titulo) VALUES ('Rector');
INSERT INTO puestos (titulo) VALUES ('Vicerector');
INSERT INTO puestos SELECT DISTINCT
NULL,
TRIM(puesto)
FROM empleados_source WHERE empleado IS NOT NULL AND
puesto <> ''
ORDER BY TRIM(puesto);

DELETE FROM areas;
ALTER TABLE areas AUTO_INCREMENT=1;
INSERT INTO areas SELECT DISTINCT
NULL,
TRIM(area)
FROM empleados_source WHERE empleado IS NOT NULL AND
area <> ''
ORDER BY TRIM(area);

DELETE FROM niveles;
ALTER TABLE niveles AUTO_INCREMENT=1;
INSERT INTO niveles (titulo) VALUES ('Autoridades 1');
INSERT INTO niveles SELECT DISTINCT
NULL,
TRIM(nivel)
FROM empleados_source WHERE empleado IS NOT NULL AND
nivel <> ''
ORDER BY TRIM(nivel);

INSERT INTO empleados 
(empleado,
nombre,
apellido_paterno,
apellido_materno,
email,
departamento,
puesto,
area,
nivel
)
SELECT
empleado, nombre, apellido_paterno, apellido_materno, email,
TRIM(substring_index(departamento,'-',1)),
(SELECT codigo FROM puestos x WHERE TRIM(e.puesto) = x.titulo),
(SELECT codigo FROM areas x WHERE TRIM(e.area) = x.titulo),
(SELECT codigo FROM niveles x WHERE TRIM(e.nivel) = x.titulo)
FROM empleados_source e WHERE empleado IS NOT NULL AND
nivel <> ''
ORDER BY TRIM(empleado);

INSERT INTO empleados (empleado, nombre, apellido_paterno, apellido_materno, departamento, puesto, area, nivel, email)
VALUES
('1', 'Rafael', 'Pardo', '	Hervás', 'MXB0034601',
(SELECT codigo FROM puestos WHERE titulo = 'Rector'),
(SELECT codigo FROM areas WHERE titulo = 'Rectoría'),
(SELECT codigo FROM niveles WHERE titulo = 'Autoridades 1'),
'rafael.pardo@anahuac.mx');

INSERT INTO empleados (empleado, nombre, apellido_paterno, apellido_materno, departamento, puesto, area, nivel, email)
VALUES
('2', 'Ulises', 'Peñúñuri', '	Munguía', 'MXB0034601',
(SELECT codigo FROM puestos WHERE titulo = 'Vicerector'),
(SELECT codigo FROM areas WHERE titulo = 'Rectoría'),
(SELECT codigo FROM niveles WHERE titulo = 'Autoridades 1'),
'ulises.penunuri@anahuac.mx');

DELETE FROM jerarquias;
ALTER TABLE jerarquias AUTO_INCREMENT=1;

INSERT INTO jerarquias (evaluacion, subordinado, usuarioRegistrante)
SELECT 1, empleado, 'admin'
FROM empleados WHERE empleado IN (1,2);

INSERT IGNORE INTO jerarquias (evaluacion, jefe, subordinado, usuarioRegistrante)
SELECT 1, id_jefe, empleado, 'admin' FROM empleados_source WHERE empleado IS NOT NULL AND empleado > 0
GROUP BY id_jefe, empleado ORDER BY id_jefe;