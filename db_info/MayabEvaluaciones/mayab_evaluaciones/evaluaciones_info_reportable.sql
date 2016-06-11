DROP VIEW IF EXISTS evaluaciones_info_reportable;
CREATE VIEW evaluaciones_info_reportable AS
SELECT
id, titulo, fechaRegistro, jefesTotales, empleadosTotales,

IFNULL(cartas_eval_fecha, 0) cartas_eval_fecha,
IFNULL(cartas_eval_avance, 0) cartas_eval_avance,
eval_contador,
CASE WHEN eval_contador / empleadosTotales > 0 AND eval_contador / empleadosTotales < 1
	THEN 1
	ELSE ROUND(eval_contador / empleadosTotales, 2)
END eval_avance,
reporte_eval_fecha,
reporte_eval_contador,

IFNULL(cartas_auto_fecha, 0) cartas_auto_fecha,
IFNULL(cartas_auto_avance, 0) cartas_auto_avance,
auto_contador,
ROUND(eval_contador / empleadosTotales, 2) auto_avance,
reporte_auto_fecha,
reporte_auto_contador,

texto_bienvenida_evaluacion,
texto_bienvenida_autoevaluacion,
usuarioRegistrante,
usuarioRegistranteNombre,
status,
statusValor
FROM evaluaciones_info;