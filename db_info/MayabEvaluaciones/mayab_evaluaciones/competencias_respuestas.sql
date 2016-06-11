DROP VIEW IF EXISTS competencias_respuestas;
CREATE VIEW competencias_respuestas AS
SELECT
cv.evaluacion AS evaluacion,
cp.competencia AS competencia,
cv.valor AS valor,
cv.etiqueta AS etiqueta,
cv.titulo AS titulo,
cv.descripcion,
cp.id AS id_valor
FROM
cuestionarios_competencias_secciones_valores_posibles AS cp
INNER JOIN cuestionarios_valores_posibles AS cv ON cp.valor = cv.id
ORDER BY competencia, valor