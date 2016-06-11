SELECT
cc.principal AS nivel_puesto,
cc.titulo competencia_titulo,
ccs.titulo AS seccion_titulo,
ccs.descripcion_eval AS seccion_evaluacion,
ccs.descripcion_auto AS seccion_autoevaluacion,
ccsc.descripcion_eval AS pregunta_evaluacion,
ccsc.descripcion_auto AS pregunta_autoevaluacion,
cc.id id_cc,
ccs.id id_ccs,
ccsc.id id_ccsc
FROM
cuestionarios_competencias AS cc
INNER JOIN cuestionarios_competencias_secciones AS ccs ON ccs.competencia = cc.id
INNER JOIN cuestionarios_competencias_secciones_conductas AS ccsc ON ccsc.seccion = ccs.id
