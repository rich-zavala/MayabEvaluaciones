DROP VIEW IF EXISTS respuestas_evaluacion_detalle;
CREATE VIEW respuestas_evaluacion_detalle AS
SELECT
ef.empleado,
ef.n empleado_nombre,
ree.fechaRegistro,
cc.titulo competencia,
ccs.titulo seccion,
ccsc.descripcion pregunta,
cvp.etiqueta respuesta_etiqueta,
cvp.titulo respuesta_valor
FROM
respuestas_evaluacion_empleados AS ree
INNER JOIN respuestas_evaluacion_competencias AS rec ON rec.id_evaluacion_empleado = ree.id
INNER JOIN cuestionarios_competencias_secciones_conductas AS ccsc ON rec.id_conducta = ccsc.id
INNER JOIN cuestionarios_competencias_secciones AS ccs ON ccsc.seccion = ccs.id
INNER JOIN cuestionarios_competencias AS cc ON ccs.competencia = cc.id
INNER JOIN empleados_formato AS ef ON ree.empleado = ef.empleado
INNER JOIN cuestionarios_competencias_secciones_valores_posibles AS ccsvp ON ccsvp.competencia = cc.id AND rec.id_valor = ccsvp.id
INNER JOIN cuestionarios_valores_posibles AS cvp ON ccsvp.valor = cvp.id
#WHERE ef.empleado = 32150470