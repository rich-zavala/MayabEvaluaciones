DROP VIEW IF EXISTS evaluaciones_puestos_listado;
CREATE VIEW evaluaciones_puestos_listado AS
SELECT
en.*,
IF(rch.usuarioRegistrante IS NULL, 0, 1) clave_registrada,
u.nombre usuario_n,
rch.fechaRegistro
FROM evaluacion_puestos en
LEFT JOIN respuestas_clave_historico_puestos rch ON rch.evaluacion = en.evaluacion AND rch.puesto = en.nivel
LEFT JOIN usuarios u ON u.usuario = rch.usuarioRegistrante
GROUP BY en.evaluacion, en.nivel ORDER BY en.evaluacion, en.nivel ASC, rch.fechaRegistro DESC