SELECT
cc.titulo AS competencia,
ccs.titulo AS seccion,
ccsc.descripcion AS conducta,
ccsc.orden
FROM
cuestionarios_competencias AS cc
INNER JOIN cuestionarios_competencias_secciones AS ccs ON ccs.competencia = cc.id
INNER JOIN cuestionarios_competencias_secciones_conductas AS ccsc ON ccsc.seccion = ccs.id
ORDER BY
cc.orden ASC,
ccs.orden ASC,
ccsc.orden ASC
