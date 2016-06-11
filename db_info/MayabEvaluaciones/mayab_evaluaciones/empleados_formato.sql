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
email,
e.fechaRegistro,
status
FROM empleados e
INNER JOIN departamentos d ON e.departamento = d.codigo
INNER JOIN puestos p ON e.puesto = p.codigo
INNER JOIN areas a ON e.area = a.codigo
WHERE empleado = 32124350
ORDER BY n