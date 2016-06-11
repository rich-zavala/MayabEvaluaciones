DROP VIEW IF EXISTS evaluaciones_info;
CREATE VIEW evaluaciones_info AS
SELECT
e.id AS id,
e.titulo AS titulo,
e.usuarioRegistrante AS usuarioRegistrante,
e.fechaRegistro AS fechaRegistro,

(SELECT COUNT(1) FROM evaluaciones_jefes WHERE evaluacion = e.id) jefesTotales,
(SELECT COUNT(1) FROM jerarquias WHERE evaluacion = e.id) empleadosTotales,

(SELECT c.fechaRegistro FROM cartas_envios AS c WHERE evaluacion = e.id ORDER BY c.fechaRegistro AND tipo = 0 ASC LIMIT 1) cartas_eval_fecha,
(SELECT ROUND((avance / empleadosTotales) * 100) FROM cartas_envios WHERE evaluacion = e.id AND tipo = 0 ORDER BY fechaRegistro DESC LIMIT 1) cartas_eval_avance,
0 reporte_eval_fecha,
0 AS reporte_eval_contador,
(SELECT COUNT(1) FROM respuestas_evaluacion WHERE evaluacion = e.id)  AS eval_contador,

(SELECT c.fechaRegistro FROM cartas_envios AS c WHERE evaluacion = e.id ORDER BY c.fechaRegistro AND tipo = 1 ASC LIMIT 1) cartas_auto_fecha,
(SELECT ROUND((avance / empleadosTotales) * 100) FROM cartas_envios WHERE evaluacion = e.id AND tipo = 1 ORDER BY fechaRegistro DESC LIMIT 1) cartas_auto_avance,
0 reporte_auto_fecha,
0 AS reporte_auto_contador,
(SELECT COUNT(1) FROM respuestas_autoevaluacion WHERE evaluacion = e.id) AS auto_contador,

texto_bienvenida_evaluacion,
texto_bienvenida_autoevaluacion,
e.status AS status,
u1.nombre AS usuarioRegistranteNombre,
CASE e.status
	WHEN 0 THEN 'Cerrado'
	WHEN 1 THEN 'Evaluación activa'
	WHEN 2 THEN 'Autoevaluación activa'
END AS statusValor
FROM evaluaciones e
JOIN usuarios u1 ON e.usuarioRegistrante = u1.usuario