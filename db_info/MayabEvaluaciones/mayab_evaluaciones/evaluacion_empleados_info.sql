DROP VIEW IF EXISTS evaluacion_empleados_info;
CREATE VIEW evaluacion_empleados_info AS
SELECT
j.evaluacion,
e.empleado, e.n, apellido_paterno, apellido_materno,
e.nivel, n.titulo nivel_n, e.puesto, p.titulo puesto_n, email
FROM empleados_formato e
INNER JOIN jerarquias j ON j.subordinado = e.empleado
INNER JOIN niveles n ON n.codigo = j.nivel
INNER JOIN puestos p ON p.codigo = j.puesto;