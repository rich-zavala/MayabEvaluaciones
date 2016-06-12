#Esta vista tiene dos partes

DROP VIEW IF EXISTS a1_reporte_respuestas_evaluacion;
CREATE VIEW a1_reporte_respuestas_evaluacion AS
SELECT ree.evaluacion, ree.empleado, ree.fechaRegistro, ree.empleado evaluador, ef1.n evaluador_n
FROM respuestas_evaluacion_empleados AS ree
INNER JOIN empleados_formato AS ef1 ON ree.evaluador = ef1.empleado;

DROP VIEW IF EXISTS reporte_respuestas_evaluacion;
CREATE VIEW reporte_respuestas_evaluacion AS
SELECT
j.evaluacion,
j.subordinado,
ef.n empleado_n,
IF(ev.fechaRegistro IS NULL, 0, 1) ev,
ev.evaluador,
ev.evaluador_n ev_evaluador_n,
ev.fechaRegistro ev_fecha,
IF(aev.fechaRegistro IS NULL, 0, 1) aev,
aev.fechaRegistro aev_fecha
FROM
jerarquias AS j
INNER JOIN empleados_formato ef ON ef.empleado = j.subordinado
LEFT JOIN a1_reporte_respuestas_evaluacion ev ON ev.empleado = j.subordinado AND ev.evaluacion = j.evaluacion
LEFT JOIN respuestas_autoevaluacion aev ON aev.empleado = j.subordinado AND aev.evaluacion = j.evaluacion