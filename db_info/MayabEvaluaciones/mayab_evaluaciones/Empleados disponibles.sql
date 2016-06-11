SELECT
	`e`.`empleado` AS `empleado`,
	`e`.`nombre` AS `nombre`,
	`e`.`apellido_paterno` AS `apellido_paterno`,
	`e`.`apellido_materno` AS `apellido_materno`,
CONCAT(IFNULL(nombre, ''), ' ', IFNULL(apellido_paterno, ''), ' ', IFNULL(apellido_materno, '')) n,
	`e`.`departamento` AS `departamento`,
	`e`.`nivel` AS `nivel`,
	`e`.`puesto` AS `puesto`,
	`e`.`area` AS `area`,
	`e`.`email` AS `email`,
	`e`.`status` AS `status`,
	`e`.`fechaRegistro` AS `fechaRegistro`
FROM
	empleados_formato e
WHERE
	(`e`.`status` = 0)