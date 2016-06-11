DROP VIEW IF EXISTS evaluacion_puestos;
CREATE VIEW evaluacion_puestos AS
SELECT DISTINCT
	j.evaluacion  AS evaluacion,
	j.puesto AS nivel,
	j.puesto_n AS nivel_n
FROM
	jefes_iniciales j
UNION

SELECT DISTINCT
	s.evaluacion AS evaluacion,
	s.puesto AS nivel,
	s.puesto_n AS nivel_n
FROM
	subordinados s ;