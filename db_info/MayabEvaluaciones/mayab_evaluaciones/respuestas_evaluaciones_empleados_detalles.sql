DROP VIEW IF EXISTS respuestas_evaluaciones_empleados_detalles;
CREATE VIEW respuestas_evaluaciones_empleados_detalles AS
SELECT
s.evaluacion,
s.jefe,
s.empleado,
s.n,
s.departamento_n,
s.puesto,
s.puesto_n,
s.area_n,
s.nivel,
s.nivel_n,
IFNULL(ree.id, 0) AS respuesta,
ree.fechaRegistro
FROM
subordinados AS s
LEFT JOIN respuestas_evaluacion_empleados AS ree ON s.evaluacion = ree.evaluacion AND s.jefe = ree.evaluador AND s.empleado = ree.empleado
