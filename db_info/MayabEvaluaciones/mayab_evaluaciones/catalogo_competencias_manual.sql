SELECT evaluacion, id, titulo, orden, 'competencia' tipo FROM cuestionarios_competencias
UNION
SELECT evaluacion, id, titulo, orden, 'manual' FROM cuestionarios_manual_input
ORDER BY orden, evaluacion