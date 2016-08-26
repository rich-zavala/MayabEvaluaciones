SELECT
evaluador_id,
evaluador_nombre,
eva.colaborador,
colaborador_nombre,
fechaEvaluacion,
depto, puesto, nivel,
antiguedad,
AVG(IFNULL(eva.competencia_promedio, 0)) promedio_evaluacion,
AVG(IFNULL(auto.competencia_promedio, 0)) promedio_autoevaluacion
FROM (
	SELECT
	ef_jef.empleado evaluador_id,
	ef_jef.n evaluador_nombre,
	ef_emp.empleado colaborador,
	ef_emp.n colaborador_nombre,
	ree.fechaRegistro fechaEvaluacion,
	ef_emp.departamento_n depto,
	ef_emp.puesto_n puesto,
	ef_emp.nivel_n nivel,
	ef_emp.antiguedad,
	cvp.etiqueta,
	cvp.titulo,
	cvp.descripcion,
	cvp.valor,
	ROUND(SUM(cvp.valor) / COUNT(cvp.id), 2) competencia_promedio
	FROM
	respuestas_evaluacion_empleados AS ree
	INNER JOIN empleados_formato AS ef_jef ON ef_jef.empleado = ree.evaluador
	INNER JOIN empleados_formato AS ef_emp ON ef_emp.empleado = ree.empleado
	INNER JOIN respuestas_evaluacion_competencias AS rec ON rec.id_evaluacion_empleado = ree.id
	INNER JOIN cuestionarios_competencias_secciones_valores_posibles AS ccsvp ON rec.id_valor = ccsvp.id
	INNER JOIN cuestionarios_valores_posibles AS cvp ON ccsvp.valor = cvp.id
	INNER JOIN cuestionarios_competencias AS cc ON ccsvp.competencia = cc.id
	INNER JOIN cuestionarios_competencias_secciones AS ccs ON ccs.competencia = cc.id
	INNER JOIN cuestionarios_competencias_secciones_conductas AS ccsc ON ccsc.seccion = ccs.id AND rec.id_conducta = ccsc.id
	GROUP BY
	ree.empleado,
	ccs.id
	ORDER BY
	ef_jef.empleado ASC,
	ef_emp.empleado ASC
) eva
LEFT JOIN (
	SELECT
	ef_emp.empleado colaborador,
	ROUND(SUM(cvp.valor) / COUNT(cvp.id), 2) competencia_promedio
	FROM
	respuestas_autoevaluacion AS ree
	INNER JOIN empleados_formato AS ef_emp ON ef_emp.empleado = ree.empleado
	INNER JOIN respuestas_autoevaluacion_competencias AS rec ON rec.id_evaluacion_empleado = ree.id
	INNER JOIN cuestionarios_competencias_secciones_valores_posibles AS ccsvp ON rec.id_valor = ccsvp.id
	INNER JOIN cuestionarios_valores_posibles AS cvp ON ccsvp.valor = cvp.id
	INNER JOIN cuestionarios_competencias AS cc ON ccsvp.competencia = cc.id
	INNER JOIN cuestionarios_competencias_secciones AS ccs ON ccs.competencia = cc.id
	INNER JOIN cuestionarios_competencias_secciones_conductas AS ccsc ON ccsc.seccion = ccs.id AND rec.id_conducta = ccsc.id
	GROUP BY
	ree.empleado,
	ccs.id
	ORDER BY
	ef_emp.empleado ASC
) auto ON auto.colaborador = eva.colaborador
GROUP BY evaluador_id, colaborador