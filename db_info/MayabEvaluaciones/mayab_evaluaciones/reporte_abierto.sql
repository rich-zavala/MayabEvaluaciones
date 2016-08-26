SELECT
em_eval.empleado AS Evaluador,
em_eval.n AS Evaluador_nombre,
em_colab.empleado AS Colaborador,
em_colab.n AS Colaborador_nombre,
rema_0_fortalezas.valor AS Fortaleza_1,
rema_1_fortalezas.valor AS Fortaleza_2,
rema_0_area.valor AS Area_de_oportunidad_1,
rema_1_area.valor AS Area_de_oportunidad_2,
rema_0_curso.valor AS Curso_recomendado_1,
rema_1_curso.valor AS Curso_recomendado_2,
cmipo_1.descripcion Pregunta_1,
cmipor_1.titulo Pregunta_1_Respuesta,
remo_1.valor_manual Pregunta_1_Motivo,
cmipo_2.descripcion Pregunta_2,
cmipor_2.titulo Pregunta_2_Respuesta,
remo_2.valor_manual Pregunta_2_Motivo
FROM
respuestas_evaluacion_empleados AS ree
LEFT JOIN respuestas_evaluacion_manual_abierto AS rema_0_fortalezas ON rema_0_fortalezas.id_evaluacion_empleado = ree.id AND rema_0_fortalezas.indice = 0 AND rema_0_fortalezas.id_manual_input_pregunta = 1
LEFT JOIN respuestas_evaluacion_manual_abierto AS rema_1_fortalezas ON rema_1_fortalezas.id_evaluacion_empleado = ree.id AND rema_1_fortalezas.indice = 1 AND rema_1_fortalezas.id_manual_input_pregunta = 1
LEFT JOIN respuestas_evaluacion_manual_abierto AS rema_0_area ON rema_0_area.id_evaluacion_empleado = ree.id AND rema_0_area.indice = 0 AND rema_0_area.id_manual_input_pregunta = 2
LEFT JOIN respuestas_evaluacion_manual_abierto AS rema_1_area ON rema_1_area.id_evaluacion_empleado = ree.id AND rema_1_area.indice = 1 AND rema_1_area.id_manual_input_pregunta = 2
LEFT JOIN respuestas_evaluacion_manual_abierto AS rema_0_curso ON rema_0_curso.id_evaluacion_empleado = ree.id AND rema_0_curso.indice = 0 AND rema_0_curso.id_manual_input_pregunta = 4
LEFT JOIN respuestas_evaluacion_manual_abierto AS rema_1_curso ON rema_1_curso.id_evaluacion_empleado = ree.id AND rema_1_curso.indice = 1 AND rema_1_curso.id_manual_input_pregunta = 4
LEFT JOIN empleados_formato AS em_eval ON em_eval.empleado = ree.evaluador
LEFT JOIN empleados_formato AS em_colab ON em_colab.empleado = ree.empleado
INNER JOIN respuestas_evaluacion_manual_opciones AS remo_1 ON remo_1.id_evaluacion_empleado = ree.id
INNER JOIN cuestionarios_manual_input_preguntas_opciones_respuestas AS cmipor_1 ON remo_1.id_opcion_respuesta = cmipor_1.id
INNER JOIN cuestionarios_manual_input_preguntas_opciones AS cmipo_1 ON remo_1.id_opciones_input_manual = cmipo_1.id AND cmipor_1.input_opciones = cmipo_1.id AND cmipo_1.id = 1

INNER JOIN respuestas_evaluacion_manual_opciones AS remo_2 ON remo_2.id_evaluacion_empleado = ree.id
INNER JOIN cuestionarios_manual_input_preguntas_opciones_respuestas AS cmipor_2 ON remo_2.id_opcion_respuesta = cmipor_2.id
INNER JOIN cuestionarios_manual_input_preguntas_opciones AS cmipo_2 ON remo_2.id_opciones_input_manual = cmipo_2.id AND cmipor_2.input_opciones = cmipo_2.id AND cmipo_2.id = 2
GROUP BY
ree.id
