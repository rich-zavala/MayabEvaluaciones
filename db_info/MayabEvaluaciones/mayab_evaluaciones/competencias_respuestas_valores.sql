DROP VIEW IF EXISTS competencias_respuestas_valores;
CREATE VIEW competencias_respuestas_valores AS
SELECT
cv.evaluacion,
cp.competencia,
cv.valor,
cv.etiqueta,
titulo,
cp.id id_valor
FROM
cuestionarios_competencias_secciones_valores_posibles AS cp
INNER JOIN cuestionarios_valores_posibles AS cv ON cp.valor = cv.id
ORDER BY competencia, valor