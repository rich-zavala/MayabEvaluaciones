SELECT
ce.evaluacion,
cee.envio,
ce.tipo,
cee.empleado,
cee.email,
cee.carta,
cee.fechaRegistro
FROM
cartas_envios AS ce
INNER JOIN cartas_envios_empleados AS cee ON ce.id = cee.envio
