SELECT DISTINCT evaluacion, j.nivel, j.nivel_n
FROM jefes_iniciales j
UNION
SELECT DISTINCT evaluacion, s.nivel, s.nivel_n
FROM subordinados s
ORDER BY evaluacion, nivel