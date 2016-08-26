DROP VIEW IF EXISTS empleados_disponibles;
CREATE VIEW empleados_disponibles AS
SELECT
	e.empleado,
	e.n,
	e.nombre,
	e.apellido_paterno,
	e.apellido_materno,
	e.departamento,
	departamento_n,
	e.nivel,
	e.puesto,
	puesto_n,
	e.area,
	e.email,
	e.status,
	e.fechaRegistro fechaRegistro
FROM
	empleados_formato e
WHERE e.status = 0;