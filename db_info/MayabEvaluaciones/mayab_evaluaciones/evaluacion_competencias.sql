DROP VIEW IF EXISTS evaluacion_competencias;
CREATE VIEW evaluacion_competencias AS 
SELECT
	cc.evaluacion AS evaluacion,
	cc.id AS id,
	cc.titulo AS titulo,
	cc.orden AS orden,
	'competencia' AS tipo,
	cc.principal AS principal,
	cc.importante,
	cc.vinculaPuestos AS vinculaPuestos
FROM
	cuestionarios_competencias cc
UNION
	SELECT
		cmi.evaluacion AS evaluacion,
		cmi.id AS id,
		cmi.titulo AS titulo,
		cmi.orden AS orden,
		'manual' AS manual,
		1,
		0,
		0
	FROM
		cuestionarios_manual_input cmi ;
