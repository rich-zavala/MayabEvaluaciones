SELECT DISTINCT
	`j`.`evaluacion` AS `evaluacion`,
	`e`.`empleado` AS `empleado`,
	`e`.`nombre` AS `nombre`,
	`e`.`apellido` AS `apellido`,
	concat(
		`e`.`nombre`,
		' ',
		`e`.`apellido`
	) AS `n`,
	`e`.`departamento` AS `departamento`,
	`e`.`puesto` AS `puesto`,
	`e`.`email` AS `email`
FROM `jerarquias` `j`
INNER JOIN `empleados` `e` ON (`j`.`subordinado` = `e`.`empleado`)
WHERE j.subordinado NOT IN (SELECT empleado FROM subordinados)
ORDER BY
	concat(
		`e`.`nombre`,
		' ',
		`e`.`apellido`
	)