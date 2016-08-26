DROP VIEW IF EXISTS respuestas_opciones;
CREATE VIEW respuestas_opciones AS
SELECT
re.evaluacion,
ree.empleado,
cmipo.descripcion titulo,
cmipor.titulo respuesta_booleana,
cmipo.manual_input,
remo.valor_manual respuesta_manual
FROM
respuestas_evaluacion AS re
INNER JOIN respuestas_evaluacion_empleados AS ree ON ree.id_respuestas_evaluacion = re.id
INNER JOIN respuestas_evaluacion_manual_opciones AS remo ON remo.id_evaluacion_empleado = ree.id
INNER JOIN cuestionarios_manual_input_preguntas_opciones AS cmipo ON remo.id_opciones_input_manual = cmipo.id
INNER JOIN cuestionarios_manual_input_preguntas_opciones_respuestas AS cmipor ON cmipor.input_opciones = cmipo.id AND remo.id_opcion_respuesta = cmipor.id
