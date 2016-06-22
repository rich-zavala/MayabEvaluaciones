DROP VIEW IF EXISTS reportes_envios_relacion;
CREATE VIEW reportes_envios_relacion AS
SELECT
ce.evaluacion,
cee.envio,
ce.tipo,
cee.empleado,
cee.email,
cee.carta,
cee.fechaRegistro
FROM
reportes_envios AS ce
INNER JOIN reportes_envios_empleados AS cee ON ce.id = cee.envio
