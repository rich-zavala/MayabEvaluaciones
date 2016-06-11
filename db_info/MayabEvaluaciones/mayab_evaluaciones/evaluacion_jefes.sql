SELECT
	s.evaluacion AS evaluacion,
	s.jefe AS jefe,
	s.empleado AS empleado,
	s.n AS n,
	s.nombre AS nombre,
	s.apellido_paterno AS apellido_paterno,
	s.apellido_materno AS apellido_materno,
	s.departamento AS departamento,
	s.departamento_n AS departamento_n,
	s.puesto AS puesto,
	s.puesto_n AS puesto_n,
	s.area AS area,
	s.area_n AS area_n,
	s.nivel AS nivel,
	s.nivel_n AS nivel_n,
	s.email AS email,
	s.fechaRegistro AS fechaRegistro,
	s.status AS status
FROM subordinados s
WHERE empleado IN (SELECT jefe FROM subordinados)
UNION
SELECT
	j.evaluacion AS evaluacion,
	null jefe,
	j.empleado AS empleado,
	j.n AS n,
	j.nombre AS nombre,
	j.apellido_paterno AS apellido_paterno,
	j.apellido_materno AS apellido_materno,
	j.departamento AS departamento,
	j.departamento_n AS departamento_n,
	j.puesto AS puesto,
	j.puesto_n AS puesto_n,
	j.area AS area,
	j.area_n AS area_n,
	j.nivel AS nivel,
	j.nivel_n AS nivel_n,
	j.email AS email,
	j.fechaRegistro AS fechaRegistro,
	j.status AS status
FROM jefes_iniciales j
