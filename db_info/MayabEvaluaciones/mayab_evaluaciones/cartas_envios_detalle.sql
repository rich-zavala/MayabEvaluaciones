SELECT
ce.id,
ce.evaluacion,
ce.tipo,
ce.usuarioRegistrante,
ce.fechaRegistro,
ce.empleadosTotales,
ce.avance,
u.nombre usuario_n,
u.email
FROM
cartas_envios AS ce
INNER JOIN usuarios AS u ON ce.usuarioRegistrante = u.usuario
