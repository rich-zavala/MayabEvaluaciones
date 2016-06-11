SELECT DISTINCT
	j.evaluacion AS evaluacion,
	e.*
FROM jerarquias j
INNER JOIN empleados_formato e ON (j.subordinado = e.empleado)
WHERE j.subordinado NOT IN (SELECT empleado FROM subordinados)
ORDER BY e.n