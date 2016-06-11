DROP VIEW IF EXISTS respuestas_evaluacion_detalles;
CREATE VIEW respuestas_evaluacion_detalles AS
SELECT
ef.*,
MD5(n) clave,
j.evaluacion,
re.evaluadosTotales,
re.avance,
re.fechaRegistro,
ra.fechaRegistro autoFecha
FROM
evaluacion_empleados_info AS ef
INNER JOIN jerarquias j ON j.subordinado = ef.empleado
LEFT JOIN respuestas_evaluacion AS re ON ef.empleado = re.evaluador AND j.evaluacion = re.evaluacion
LEFT JOIN respuestas_autoevaluacion AS ra ON ef.empleado = ra.empleado AND j.evaluacion = ra.evaluacion;