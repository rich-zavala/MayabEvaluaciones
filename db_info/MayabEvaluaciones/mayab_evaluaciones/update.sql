ALTER TABLE `reportes_templates`
ADD COLUMN `tipo_01`  text NULL AFTER `tipo_0`,
ADD COLUMN `tipo_11`  text NULL AFTER `tipo_1`;

ALTER TABLE `reportes_templates`
DROP COLUMN `tipo_11`,
MODIFY COLUMN `tipo_0`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'Evaluaciones + Personal' AFTER `evaluacion`,
MODIFY COLUMN `tipo_01`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'Evaluaciones + Grupal' AFTER `tipo_0`,
MODIFY COLUMN `tipo_1`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'Autoevaluación' AFTER `tipo_01`;

