SELECT
	j.evaluacion AS evaluacion,
	j.jefe AS jefe,
	e.*
FROM jerarquias j
INNER JOIN empleados_formato e ON j.subordinado = e.empleado
WHERE jefe is not null ORDER BY e.n