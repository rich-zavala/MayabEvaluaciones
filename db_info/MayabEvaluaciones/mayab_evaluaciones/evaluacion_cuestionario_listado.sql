DROP VIEW IF EXISTS evaluacion_cuestionario_listado;
CREATE VIEW evaluacion_cuestionario_listado AS
SELECT
ecu.id, ecu.evaluacion, ecu.nivel, ecu.tipo, ecu.id_competencia, ecu.id_manual, eco.titulo, orden, 0 nivelPuesto, vinculaPuestos
FROM evaluaciones_cuestionario_niveles AS ecu
INNER JOIN evaluacion_competencias AS eco ON ecu.id_competencia = eco.id
AND ecu.tipo = 'competencia' AND eco.tipo = 'competencia' AND ecu.evaluacion = eco.evaluacion

UNION

SELECT
ecu.id, ecu.evaluacion, ecu.nivel, ecu.tipo, ecu.id_competencia, ecu.id_manual, eco.titulo, orden, 0, 0
FROM evaluaciones_cuestionario_niveles AS ecu
INNER JOIN evaluacion_competencias AS eco ON ecu.id_manual = eco.id
AND ecu.tipo = 'manual' AND eco.tipo = 'manual' AND ecu.evaluacion = eco.evaluacion

UNION

/* Los cuestionarios por puesto sólo pueden ser de tipo competencia, no manual */
SELECT
ecu.id, ecu.evaluacion, ecu.nivel, ecu.tipo, ecu.id_competencia, ecu.id_manual, eco.titulo, orden, 1, 0
FROM evaluaciones_cuestionario_puestos AS ecu
INNER JOIN evaluacion_competencias AS eco ON ecu.id_competencia = eco.id
AND ecu.tipo = 'competencia' AND eco.tipo = 'competencia' AND ecu.evaluacion = eco.evaluacion

ORDER BY evaluacion, nivel, orden;