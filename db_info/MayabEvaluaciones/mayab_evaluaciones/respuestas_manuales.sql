DROP VIEW IF EXISTS respuestas_manuales;
CREATE VIEW respuestas_manuales AS
SELECT
re.evaluacion,
ree.empleado,
cmip.id,
cmip.titulo,
rema.indice AS manual_indice,
rema.valor AS manual_valor
FROM
respuestas_evaluacion AS re
INNER JOIN respuestas_evaluacion_empleados AS ree ON ree.id_respuestas_evaluacion = re.id
INNER JOIN respuestas_evaluacion_manual_abierto AS rema ON rema.id_evaluacion_empleado = ree.id
INNER JOIN empleados_formato AS ef ON ef.empleado = ree.empleado
INNER JOIN cuestionarios_manual_input_preguntas AS cmip ON rema.id_manual_input_pregunta = cmip.id