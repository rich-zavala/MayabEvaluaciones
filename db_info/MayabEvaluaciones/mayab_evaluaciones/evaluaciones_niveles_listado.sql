DROP VIEW IF EXISTS evaluaciones_niveles_listado;
CREATE VIEW evaluaciones_niveles_listado AS
SELECT
en.*,
IF(rch.usuarioRegistrante IS NULL, 0, 1) clave_registrada,
u.nombre usuario_n,
rch.fechaRegistro
FROM evaluacion_niveles en
LEFT JOIN respuestas_clave_historico_niveles rch ON rch.evaluacion = en.evaluacion AND rch.nivel = en.nivel
LEFT JOIN usuarios u ON u.usuario = rch.usuarioRegistrante
GROUP BY en.evaluacion, en.nivel ORDER BY en.evaluacion, en.nivel ASC, rch.fechaRegistro DESC