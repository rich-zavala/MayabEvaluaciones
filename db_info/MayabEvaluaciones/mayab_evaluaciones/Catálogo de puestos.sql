SELECT DISTINCT * FROM (
SELECT puesto puesto_id,
puesto_n puesto_nombre
FROM
evaluaciones_jefes

UNION 
SELECT puesto,  puesto_n FROM
subordinados
) v ORDER BY puesto_nombre