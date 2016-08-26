DROP VIEW IF EXISTS empleados_formato;
CREATE VIEW empleados_formato AS
SELECT
empleado,
CONCAT(IFNULL(nombre, ''), ' ', IFNULL(apellido_paterno, ''), ' ', IFNULL(apellido_materno, '')) n,
nombre,
apellido_paterno,
apellido_materno,
e.departamento departamento,
d.titulo departamento_n,
e.puesto puesto,
p.titulo puesto_n,
e.area area,
a.titulo area_n,
e.nivel,
n.titulo nivel_n,
email,
e.fechaRegistro,
fechaAlta,
IF(
	e.fechaAlta IS NOT NULL,
	IF(
		FROM_DAYS(DATEDIFF(NOW(),e.fechaAlta)) = 0,
		CONCAT(PERIOD_DIFF( DATE_FORMAT(CURDATE(), '%Y%m') , DATE_FORMAT(fechaAlta, '%Y%m') ), ' meses'),
		CONCAT( YEAR(FROM_DAYS(DATEDIFF(NOW(),e.fechaAlta))),' años, ', MONTH(FROM_DAYS(DATEDIFF(NOW(),e.fechaAlta))),' meses')
	),
	'Indefinido'
) antiguedad,
status
FROM empleados e
INNER JOIN departamentos d ON e.departamento = d.codigo
INNER JOIN puestos p ON e.puesto = p.codigo
INNER JOIN areas a ON e.area = a.codigo
INNER JOIN niveles n ON e.nivel= n.codigo;