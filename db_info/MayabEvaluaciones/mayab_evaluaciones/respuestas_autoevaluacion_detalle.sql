DROP VIEW IF EXISTS respuestas_autoevaluacion_detalle;
CREATE VIEW respuestas_autoevaluacion_detalle AS
SELECT
ef.empleado,
ef.n empleado_nombre,
ra.fechaRegistro,
cc.titulo competencia,
ccs.titulo seccion,
ccsc.descripcion pregunta,
cvp.etiqueta respuesta_etiqueta,
cvp.titulo respuesta_valor
FROM
respuestas_autoevaluacion AS ra
INNER JOIN respuestas_autoevaluacion_competencias AS rac ON rac.id_evaluacion_empleado = ra.id
INNER JOIN cuestionarios_competencias_secciones_conductas AS ccsc ON rac.id_conducta = ccsc.id
INNER JOIN cuestionarios_competencias_secciones AS ccs ON ccsc.seccion = ccs.id
INNER JOIN cuestionarios_competencias AS cc ON ccs.competencia = cc.id
INNER JOIN empleados_formato AS ef ON ra.empleado = ef.empleado
INNER JOIN cuestionarios_competencias_secciones_valores_posibles AS ccsvp ON ccsvp.competencia = cc.id AND rac.id_valor = ccsvp.id
INNER JOIN cuestionarios_valores_posibles AS cvp ON ccsvp.valor = cvp.id
#WHERE ef.empleado = 32150470