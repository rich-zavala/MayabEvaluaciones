
-- ----------------------------
-- View structure for jefes_iniciales
-- ----------------------------
DROP VIEW IF EXISTS `jefes_iniciales`;
CREATE VIEW `jefes_iniciales` AS select distinct `j`.`evaluacion` AS `evaluacion`,0 AS `jefe`,`e`.`empleado` AS `empleado`,`e`.`n` AS `n`,`e`.`nombre` AS `nombre`,`e`.`apellido_paterno` AS `apellido_paterno`,`e`.`apellido_materno` AS `apellido_materno`,`e`.`departamento` AS `departamento`,`e`.`departamento_n` AS `departamento_n`,`e`.`puesto` AS `puesto`,`e`.`puesto_n` AS `puesto_n`,`e`.`area` AS `area`,`e`.`area_n` AS `area_n`,`e`.`nivel` AS `nivel`,`e`.`nivel_n` AS `nivel_n`,`e`.`email` AS `email`,`e`.`fechaRegistro` AS `fechaRegistro`,`e`.`status` AS `status` from (`jerarquias` `j` join `empleados_formato` `e` on((`j`.`subordinado` = `e`.`empleado`))) where (not(`j`.`subordinado` in (select `subordinados`.`empleado` from `subordinados`))) ;


-- ----------------------------
-- View structure for subordinados
-- ----------------------------
DROP VIEW IF EXISTS `subordinados`;
CREATE VIEW `subordinados` AS select `j`.`evaluacion` AS `evaluacion`,`j`.`jefe` AS `jefe`,`e`.`empleado` AS `empleado`,`e`.`n` AS `n`,`e`.`nombre` AS `nombre`,`e`.`apellido_paterno` AS `apellido_paterno`,`e`.`apellido_materno` AS `apellido_materno`,`e`.`departamento` AS `departamento`,`e`.`departamento_n` AS `departamento_n`,`e`.`puesto` AS `puesto`,`e`.`puesto_n` AS `puesto_n`,`e`.`area` AS `area`,`e`.`area_n` AS `area_n`,`e`.`nivel` AS `nivel`,`e`.`nivel_n` AS `nivel_n`,`e`.`email` AS `email`,`e`.`fechaRegistro` AS `fechaRegistro`,`e`.`status` AS `status` from (`jerarquias` `j` join `empleados_formato` `e` on((`j`.`subordinado` = `e`.`empleado`))) where (`j`.`jefe` is not null) ;


-- ----------------------------
-- View structure for evaluaciones_jefes
-- ----------------------------
DROP VIEW IF EXISTS `evaluaciones_jefes`;
CREATE VIEW `evaluaciones_jefes` AS select `s`.`evaluacion` AS `evaluacion`,`s`.`jefe` AS `jefe`,`s`.`empleado` AS `empleado`,`s`.`n` AS `n`,`s`.`nombre` AS `nombre`,`s`.`apellido_paterno` AS `apellido_paterno`,`s`.`apellido_materno` AS `apellido_materno`,`s`.`departamento` AS `departamento`,`s`.`departamento_n` AS `departamento_n`,`s`.`puesto` AS `puesto`,`s`.`puesto_n` AS `puesto_n`,`s`.`area` AS `area`,`s`.`area_n` AS `area_n`,`s`.`nivel` AS `nivel`,`s`.`nivel_n` AS `nivel_n`,`s`.`email` AS `email`,`s`.`fechaRegistro` AS `fechaRegistro`,`s`.`status` AS `status` from `subordinados` `s` where `s`.`empleado` in (select `subordinados`.`jefe` from `subordinados`) union select `j`.`evaluacion` AS `evaluacion`,NULL AS `jefe`,`j`.`empleado` AS `empleado`,`j`.`n` AS `n`,`j`.`nombre` AS `nombre`,`j`.`apellido_paterno` AS `apellido_paterno`,`j`.`apellido_materno` AS `apellido_materno`,`j`.`departamento` AS `departamento`,`j`.`departamento_n` AS `departamento_n`,`j`.`puesto` AS `puesto`,`j`.`puesto_n` AS `puesto_n`,`j`.`area` AS `area`,`j`.`area_n` AS `area_n`,`j`.`nivel` AS `nivel`,`j`.`nivel_n` AS `nivel_n`,`j`.`email` AS `email`,`j`.`fechaRegistro` AS `fechaRegistro`,`j`.`status` AS `status` from `jefes_iniciales` `j` ;


-- View structure for evaluaciones_info
-- ----------------------------
DROP VIEW IF EXISTS `evaluaciones_info`;
CREATE VIEW `evaluaciones_info` AS select `e`.`id` AS `id`,`e`.`titulo` AS `titulo`,`e`.`usuarioRegistrante` AS `usuarioRegistrante`,`e`.`fechaRegistro` AS `fechaRegistro`,(select count(1) from `evaluaciones_jefes` where (`evaluaciones_jefes`.`evaluacion` = `e`.`id`)) AS `jefesTotales`,(select count(1) from `jerarquias` where (`jerarquias`.`evaluacion` = `e`.`id`)) AS `empleadosTotales`,(select `c`.`fechaRegistro` from `cartas_envios` `c` where (`c`.`evaluacion` = `e`.`id`) order by (`c`.`fechaRegistro` and (`c`.`tipo` = 0)) limit 1) AS `cartas_eval_fecha`,(select round(((`cartas_envios`.`avance` / `cartas_envios`.`empleadosTotales`) * 100),0) from `cartas_envios` where ((`cartas_envios`.`evaluacion` = `e`.`id`) and (`cartas_envios`.`tipo` = 0)) order by `cartas_envios`.`fechaRegistro` desc limit 1) AS `cartas_eval_avance`,0 AS `reporte_eval_fecha`,0 AS `reporte_eval_contador`,(select count(1) from `respuestas_evaluacion` where (`respuestas_evaluacion`.`evaluacion` = `e`.`id`)) AS `eval_contador`,(select `c`.`fechaRegistro` from `cartas_envios` `c` where (`c`.`evaluacion` = `e`.`id`) order by (`c`.`fechaRegistro` and (`c`.`tipo` = 1)) limit 1) AS `cartas_auto_fecha`,(select round(((`cartas_envios`.`avance` / `cartas_envios`.`empleadosTotales`) * 100),0) from `cartas_envios` where ((`cartas_envios`.`evaluacion` = `e`.`id`) and (`cartas_envios`.`tipo` = 1)) order by `cartas_envios`.`fechaRegistro` desc limit 1) AS `cartas_auto_avance`,0 AS `reporte_auto_fecha`,0 AS `reporte_auto_contador`,(select count(1) from `respuestas_autoevaluacion` where (`respuestas_autoevaluacion`.`evaluacion` = `e`.`id`)) AS `auto_contador`,`e`.`texto_bienvenida_evaluacion` AS `texto_bienvenida_evaluacion`,`e`.`texto_bienvenida_autoevaluacion` AS `texto_bienvenida_autoevaluacion`,`e`.`status` AS `status`,`u1`.`nombre` AS `usuarioRegistranteNombre`,(case `e`.`status` when 0 then 'Cerrado' when 1 then 'Evaluación activa' when 2 then 'Autoevaluación activa' end) AS `statusValor` from (`evaluaciones` `e` join `usuarios` `u1` on((`e`.`usuarioRegistrante` = `u1`.`usuario`))) ;

-- ----------------------------
-- View structure for evaluaciones_info_reportable
-- ----------------------------
DROP VIEW IF EXISTS `evaluaciones_info_reportable`;
CREATE VIEW `evaluaciones_info_reportable` AS select `evaluaciones_info`.`id` AS `id`,`evaluaciones_info`.`titulo` AS `titulo`,`evaluaciones_info`.`fechaRegistro` AS `fechaRegistro`,`evaluaciones_info`.`jefesTotales` AS `jefesTotales`,`evaluaciones_info`.`empleadosTotales` AS `empleadosTotales`,ifnull(`evaluaciones_info`.`cartas_eval_fecha`,0) AS `cartas_eval_fecha`,ifnull(`evaluaciones_info`.`cartas_eval_avance`,0) AS `cartas_eval_avance`,`evaluaciones_info`.`eval_contador` AS `eval_contador`,(case when (((`evaluaciones_info`.`eval_contador` / `evaluaciones_info`.`empleadosTotales`) > 0) and ((`evaluaciones_info`.`eval_contador` / `evaluaciones_info`.`empleadosTotales`) < 1)) then 1 else round((`evaluaciones_info`.`eval_contador` / `evaluaciones_info`.`empleadosTotales`),2) end) AS `eval_avance`,`evaluaciones_info`.`reporte_eval_fecha` AS `reporte_eval_fecha`,`evaluaciones_info`.`reporte_eval_contador` AS `reporte_eval_contador`,ifnull(`evaluaciones_info`.`cartas_auto_fecha`,0) AS `cartas_auto_fecha`,ifnull(`evaluaciones_info`.`cartas_auto_avance`,0) AS `cartas_auto_avance`,`evaluaciones_info`.`auto_contador` AS `auto_contador`,round((`evaluaciones_info`.`eval_contador` / `evaluaciones_info`.`empleadosTotales`),2) AS `auto_avance`,`evaluaciones_info`.`reporte_auto_fecha` AS `reporte_auto_fecha`,`evaluaciones_info`.`reporte_auto_contador` AS `reporte_auto_contador`,`evaluaciones_info`.`texto_bienvenida_evaluacion` AS `texto_bienvenida_evaluacion`,`evaluaciones_info`.`texto_bienvenida_autoevaluacion` AS `texto_bienvenida_autoevaluacion`,`evaluaciones_info`.`usuarioRegistrante` AS `usuarioRegistrante`,`evaluaciones_info`.`usuarioRegistranteNombre` AS `usuarioRegistranteNombre`,`evaluaciones_info`.`status` AS `status`,`evaluaciones_info`.`statusValor` AS `statusValor` from `evaluaciones_info` ;


-- ----------------------------
-- View structure for evaluacion_niveles
-- ----------------------------
DROP VIEW IF EXISTS `evaluacion_niveles`;
CREATE VIEW `evaluacion_niveles` AS select distinct `j`.`evaluacion` AS `evaluacion`,`j`.`nivel` AS `nivel`,`j`.`nivel_n` AS `nivel_n` from `jefes_iniciales` `j` union select distinct `s`.`evaluacion` AS `evaluacion`,`s`.`nivel` AS `nivel`,`s`.`nivel_n` AS `nivel_n` from `subordinados` `s` ;


-- ----------------------------
-- View structure for evaluaciones_niveles_listado
-- ----------------------------
DROP VIEW IF EXISTS `evaluaciones_niveles_listado`;
CREATE VIEW `evaluaciones_niveles_listado` AS select `en`.`evaluacion` AS `evaluacion`,`en`.`nivel` AS `nivel`,`en`.`nivel_n` AS `nivel_n`,if(isnull(`rch`.`usuarioRegistrante`),0,1) AS `clave_registrada`,`u`.`nombre` AS `usuario_n`,`rch`.`fechaRegistro` AS `fechaRegistro` from ((`evaluacion_niveles` `en` left join `respuestas_clave_historico_niveles` `rch` on(((`rch`.`evaluacion` = `en`.`evaluacion`) and (`rch`.`nivel` = `en`.`nivel`)))) left join `usuarios` `u` on((`u`.`usuario` = `rch`.`usuarioRegistrante`))) group by `en`.`evaluacion`,`en`.`nivel` order by `en`.`evaluacion`,`en`.`nivel`,`rch`.`fechaRegistro` desc ;

-- ----------------------------
-- View structure for evaluacion_puestos
-- ----------------------------
DROP VIEW IF EXISTS `evaluacion_puestos`;
CREATE VIEW `evaluacion_puestos` AS select distinct `j`.`evaluacion` AS `evaluacion`,`j`.`puesto` AS `nivel`,`j`.`puesto_n` AS `nivel_n` from `jefes_iniciales` `j` union select distinct `s`.`evaluacion` AS `evaluacion`,`s`.`puesto` AS `nivel`,`s`.`puesto_n` AS `nivel_n` from `subordinados` `s` ;

-- ----------------------------
-- View structure for evaluaciones_puestos_listado
-- ----------------------------
DROP VIEW IF EXISTS `evaluaciones_puestos_listado`;
CREATE VIEW `evaluaciones_puestos_listado` AS select `en`.`evaluacion` AS `evaluacion`,`en`.`nivel` AS `nivel`,`en`.`nivel_n` AS `nivel_n`,if(isnull(`rch`.`usuarioRegistrante`),0,1) AS `clave_registrada`,`u`.`nombre` AS `usuario_n`,`rch`.`fechaRegistro` AS `fechaRegistro` from ((`evaluacion_puestos` `en` left join `respuestas_clave_historico_puestos` `rch` on(((`rch`.`evaluacion` = `en`.`evaluacion`) and (`rch`.`puesto` = `en`.`nivel`)))) left join `usuarios` `u` on((`u`.`usuario` = `rch`.`usuarioRegistrante`))) group by `en`.`evaluacion`,`en`.`nivel` order by `en`.`evaluacion`,`en`.`nivel`,`rch`.`fechaRegistro` desc ;

-- ----------------------------
-- View structure for evaluacion_competencias
-- ----------------------------
DROP VIEW IF EXISTS `evaluacion_competencias`;
CREATE VIEW `evaluacion_competencias` AS select `cc`.`evaluacion` AS `evaluacion`,`cc`.`id` AS `id`,`cc`.`titulo` AS `titulo`,`cc`.`orden` AS `orden`,'competencia' AS `tipo`,`cc`.`principal` AS `principal`,`cc`.`importante` AS `importante`,`cc`.`vinculaPuestos` AS `vinculaPuestos` from `cuestionarios_competencias` `cc` union select `cmi`.`evaluacion` AS `evaluacion`,`cmi`.`id` AS `id`,`cmi`.`titulo` AS `titulo`,`cmi`.`orden` AS `orden`,'manual' AS `manual`,1 AS `1`,0 AS `0`,0 AS `My_exp_0` from `cuestionarios_manual_input` `cmi` ;

-- ----------------------------
-- View structure for evaluacion_cuestionario_listado
-- ----------------------------
DROP VIEW IF EXISTS `evaluacion_cuestionario_listado`;
CREATE VIEW `evaluacion_cuestionario_listado` AS select `ecu`.`id` AS `id`,`ecu`.`evaluacion` AS `evaluacion`,`ecu`.`nivel` AS `nivel`,`ecu`.`tipo` AS `tipo`,`ecu`.`id_competencia` AS `id_competencia`,`ecu`.`id_manual` AS `id_manual`,`eco`.`titulo` AS `titulo`,`eco`.`orden` AS `orden`,0 AS `nivelPuesto`,`eco`.`vinculaPuestos` AS `vinculaPuestos` from (`evaluaciones_cuestionario_niveles` `ecu` join `evaluacion_competencias` `eco` on(((`ecu`.`id_competencia` = `eco`.`id`) and (`ecu`.`tipo` = 'competencia') and (`eco`.`tipo` = 'competencia') and (`ecu`.`evaluacion` = `eco`.`evaluacion`)))) union select `ecu`.`id` AS `id`,`ecu`.`evaluacion` AS `evaluacion`,`ecu`.`nivel` AS `nivel`,`ecu`.`tipo` AS `tipo`,`ecu`.`id_competencia` AS `id_competencia`,`ecu`.`id_manual` AS `id_manual`,`eco`.`titulo` AS `titulo`,`eco`.`orden` AS `orden`,0 AS `0`,0 AS `My_exp_0` from (`evaluaciones_cuestionario_niveles` `ecu` join `evaluacion_competencias` `eco` on(((`ecu`.`id_manual` = `eco`.`id`) and (`ecu`.`tipo` = 'manual') and (`eco`.`tipo` = 'manual') and (`ecu`.`evaluacion` = `eco`.`evaluacion`)))) union select `ecu`.`id` AS `id`,`ecu`.`evaluacion` AS `evaluacion`,`ecu`.`nivel` AS `nivel`,`ecu`.`tipo` AS `tipo`,`ecu`.`id_competencia` AS `id_competencia`,`ecu`.`id_manual` AS `id_manual`,`eco`.`titulo` AS `titulo`,`eco`.`orden` AS `orden`,1 AS `1`,0 AS `0` from (`evaluaciones_cuestionario_puestos` `ecu` join `evaluacion_competencias` `eco` on(((`ecu`.`id_competencia` = `eco`.`id`) and (`ecu`.`tipo` = 'competencia') and (`eco`.`tipo` = 'competencia') and (`ecu`.`evaluacion` = `eco`.`evaluacion`)))) order by `evaluacion`,`nivel`,`orden` ;

-- ----------------------------
-- View structure for evaluacion_empleados_info
-- ----------------------------
DROP VIEW IF EXISTS `evaluacion_empleados_info`;
CREATE VIEW `evaluacion_empleados_info` AS select `e`.`empleado` AS `empleado`,`e`.`n` AS `n`,`e`.`apellido_paterno` AS `apellido_paterno`,`e`.`apellido_materno` AS `apellido_materno`,`e`.`nivel` AS `nivel`,`n`.`titulo` AS `nivel_n`,`e`.`puesto` AS `puesto`,`p`.`titulo` AS `puesto_n`,`e`.`email` AS `email` from (((`empleados_formato` `e` join `jerarquias` `j` on((`j`.`subordinado` = `e`.`empleado`))) join `niveles` `n` on((`n`.`codigo` = `j`.`nivel`))) join `puestos` `p` on((`p`.`codigo` = `j`.`puesto`))) ;

-- ----------------------------
-- View structure for respuestas_evaluaciones_empleados_detalles
-- ----------------------------
DROP VIEW IF EXISTS `respuestas_evaluaciones_empleados_detalles`;
CREATE VIEW `respuestas_evaluaciones_empleados_detalles` AS select `s`.`evaluacion` AS `evaluacion`,`s`.`jefe` AS `jefe`,`s`.`empleado` AS `empleado`,`s`.`n` AS `n`,`s`.`departamento_n` AS `departamento_n`,`s`.`puesto` AS `puesto`,`s`.`puesto_n` AS `puesto_n`,`s`.`area_n` AS `area_n`,`s`.`nivel` AS `nivel`,`s`.`nivel_n` AS `nivel_n`,ifnull(`ree`.`id`,0) AS `respuesta`,`ree`.`fechaRegistro` AS `fechaRegistro` from (`subordinados` `s` left join `respuestas_evaluacion_empleados` `ree` on(((`s`.`evaluacion` = `ree`.`evaluacion`) and (`s`.`jefe` = `ree`.`evaluador`) and (`s`.`empleado` = `ree`.`empleado`)))) ;

-- ----------------------------
-- View structure for respuestas_evaluacion_detalles
-- ----------------------------
DROP VIEW IF EXISTS `respuestas_evaluacion_detalles`;
CREATE VIEW `respuestas_evaluacion_detalles` AS select `ef`.`empleado` AS `empleado`,`ef`.`n` AS `n`,`ef`.`apellido_paterno` AS `apellido_paterno`,`ef`.`apellido_materno` AS `apellido_materno`,`ef`.`nivel` AS `nivel`,`ef`.`nivel_n` AS `nivel_n`,`ef`.`puesto` AS `puesto`,`ef`.`puesto_n` AS `puesto_n`,`ef`.`email` AS `email`,md5(`ef`.`n`) AS `clave`,`j`.`evaluacion` AS `evaluacion`,`re`.`evaluadosTotales` AS `evaluadosTotales`,`re`.`avance` AS `avance`,`re`.`fechaRegistro` AS `fechaRegistro`,`ra`.`fechaRegistro` AS `autoFecha` from (((`evaluacion_empleados_info` `ef` join `jerarquias` `j` on((`j`.`subordinado` = `ef`.`empleado`))) left join `respuestas_evaluacion` `re` on(((`ef`.`empleado` = `re`.`evaluador`) and (`j`.`evaluacion` = `re`.`evaluacion`)))) left join `respuestas_autoevaluacion` `ra` on(((`ef`.`empleado` = `ra`.`empleado`) and (`j`.`evaluacion` = `ra`.`evaluacion`)))) ;

-- ----------------------------
-- Procedure structure for eliminarRespuestasCompetenciaNivel
-- ----------------------------
DROP PROCEDURE IF EXISTS `eliminarRespuestasCompetenciaNivel`;
DELIMITER ;;
CREATE PROCEDURE `eliminarRespuestasCompetenciaNivel`(IN `_evaluacion` int,IN `_nivel` int,IN `_competencia` int)
BEGIN
	#Elimina respuestas de clave de una competencia en NIVELES
	DECLARE v_finished INTEGER DEFAULT 0;
	DECLARE seccion INTEGER DEFAULT 0;

	DEClARE curs CURSOR FOR
	SELECT id FROM cuestionarios_competencias_secciones WHERE competencia = _competencia LIMIT 1;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

	OPEN curs;
	secLoop: LOOP
	FETCH curs INTO seccion;

		IF v_finished = 1 THEN 
			LEAVE secLoop;
		END IF;

		DELETE FROM respuestas_clave_competencias_niveles WHERE evaluacion = _evaluacion AND nivel = _nivel
		AND id_conducta IN (SELECT id FROM cuestionarios_competencias_secciones_conductas WHERE seccion = seccion);

	END LOOP secLoop;
	CLOSE curs;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for eliminarRespuestasCompetenciaPuesto
-- ----------------------------
DROP PROCEDURE IF EXISTS `eliminarRespuestasCompetenciaPuesto`;
DELIMITER ;;
CREATE PROCEDURE `eliminarRespuestasCompetenciaPuesto`(IN `_evaluacion` int,IN `_nivel` int,IN `_competencia` int)
BEGIN
	#Elimina respuestas de clave de una competencia en puestos
	DECLARE v_finished INTEGER DEFAULT 0;
	DECLARE seccion INTEGER DEFAULT 0;

	DEClARE curs CURSOR FOR
	SELECT id FROM cuestionarios_competencias_secciones WHERE competencia = _competencia LIMIT 1;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

	OPEN curs;
	secLoop: LOOP
	FETCH curs INTO seccion;

		IF v_finished = 1 THEN 
			LEAVE secLoop;
		END IF;

		DELETE FROM respuestas_clave_competencias_puestos WHERE evaluacion = _evaluacion AND nivel = _nivel
		AND id_conducta IN (SELECT id FROM cuestionarios_competencias_secciones_conductas WHERE seccion = seccion);

	END LOOP secLoop;
	CLOSE curs;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for remover_jefe
-- ----------------------------
DROP PROCEDURE IF EXISTS `remover_jefe`;
DELIMITER ;;
CREATE PROCEDURE `remover_jefe`(IN `_evaluacion` int,IN `_empleado` int)
BEGIN
	DELETE FROM jerarquias WHERE jefe = _empleado AND evaluacion = _evaluacion;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for reset_respuestas_clave
-- ----------------------------
DROP PROCEDURE IF EXISTS `reset_respuestas_clave`;
DELIMITER ;;
CREATE PROCEDURE `reset_respuestas_clave`(IN `_evaluacion` int,IN `_nivel` int, IN _tipo int)
BEGIN
	IF _tipo = 0 THEN
		DELETE FROM respuestas_clave_competencias_niveles WHERE evaluacion = _evaluacion AND nivel = _nivel;
	ELSE
		DELETE FROM respuestas_clave_competencias_puestos WHERE evaluacion = _evaluacion AND nivel = _nivel;
	END IF;

	DELETE FROM respuestas_clave_manual_abierto WHERE evaluacion = _evaluacion AND nivel = _nivel;
	DELETE FROM respuestas_clave_manual_opciones WHERE evaluacion = _evaluacion AND nivel = _nivel;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for respuestas_evaluacion_totales
-- ----------------------------
DROP PROCEDURE IF EXISTS `respuestas_evaluacion_totales`;
DELIMITER ;;
CREATE PROCEDURE `respuestas_evaluacion_totales`(IN `_evaluacion` int,IN `_evaluador` int)
BEGIN
	UPDATE respuestas_evaluacion SET evaluadosTotales = (SELECT COUNT(id) FROM subordinados WHERE jefe = _evaluador AND evaluacion = _evaluacion);

END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for UC_Words
-- ----------------------------
DROP FUNCTION IF EXISTS `UC_Words`;
DELIMITER ;;
CREATE FUNCTION `UC_Words`(str VARCHAR(255)) RETURNS varchar(255) CHARSET utf8
BEGIN  
  DECLARE c CHAR(1);  
  DECLARE s VARCHAR(255);  
  DECLARE i INT DEFAULT 1;  
  DECLARE bool INT DEFAULT 1;  
  DECLARE punct CHAR(17) DEFAULT ' ()[]{},.-_!@;:?/';  
  SET s = LCASE( str );  
  WHILE i < LENGTH( str ) DO  
     BEGIN  
       SET c = SUBSTRING( s, i, 1 );  
       IF LOCATE( c, punct ) > 0 THEN  
        SET bool = 1;  
      ELSEIF bool=1 THEN  
        BEGIN  
          IF c >= 'a' AND c <= 'z' THEN  
             BEGIN  
               SET s = CONCAT(LEFT(s,i-1),UCASE(c),SUBSTRING(s,i+1));  
               SET bool = 0;  
             END;  
           ELSEIF c >= '0' AND c <= '9' THEN  
            SET bool = 0;  
          END IF;  
        END;  
      END IF;  
      SET i = i+1;  
    END;  
  END WHILE;  
  RETURN s;  
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `fecha_reg`;
DELIMITER ;;
CREATE TRIGGER `fecha_reg` BEFORE INSERT ON `cartas_envios` FOR EACH ROW SET NEW.fechaRegistro = NOW()
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `cart_env_fech`;
DELIMITER ;;
CREATE TRIGGER `cart_env_fech` BEFORE INSERT ON `cartas_envios_empleados` FOR EACH ROW SET NEW.fechaRegistro = NOW()
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `avance_ins`;
DELIMITER ;;
CREATE TRIGGER `avance_ins` AFTER INSERT ON `cartas_envios_empleados` FOR EACH ROW UPDATE cartas_envios SET avance = avance + 1 WHERE id = NEW.envio
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `avance_del`;
DELIMITER ;;
CREATE TRIGGER `avance_del` AFTER DELETE ON `cartas_envios_empleados` FOR EACH ROW UPDATE cartas_envios SET avance = avance - 1 WHERE id = OLD.envio
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `em_fec`;
DELIMITER ;;
CREATE TRIGGER `em_fec` BEFORE INSERT ON `empleados` FOR EACH ROW SET NEW.fechaRegistro = NOW()
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `ap_fecha`;
DELIMITER ;;
CREATE TRIGGER `ap_fecha` BEFORE INSERT ON `evaluaciones` FOR EACH ROW SET NEW.fechaRegistro = NOW()
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `eval_cue_res_clean`;
DELIMITER ;;
CREATE TRIGGER `eval_cue_res_clean` AFTER DELETE ON `evaluaciones_cuestionario_niveles` FOR EACH ROW BEGIN
	IF OLD.tipo = 'competencia' THEN
		CALL eliminarRespuestasCompetenciaNivel(OLD.evaluacion, OLD.nivel, OLD.id_competencia);
	ELSEIF OLD.tipo = 'manual' THEN
		DELETE FROM respuestas_clave_manual_abierto WHERE evaluacion = OLD.evaluacion AND nivel = OLD.nivel;
		DELETE FROM respuestas_clave_manual_opciones WHERE evaluacion = OLD.evaluacion AND nivel = OLD.nivel;
	END IF;
	DELETE FROM respuestas_clave_historico_niveles WHERE evaluacion = OLD.evaluacion AND nivel = OLD.nivel;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `eval_cue_resp_clean`;
DELIMITER ;;
CREATE TRIGGER `eval_cue_resp_clean` AFTER DELETE ON `evaluaciones_cuestionario_puestos` FOR EACH ROW BEGIN
	CALL eliminarRespuestasCompetenciaPuesto(OLD.evaluacion, OLD.nivel, OLD.id_competencia);
	DELETE FROM respuestas_clave_historico_puestos WHERE evaluacion = OLD.evaluacion AND puesto = OLD.nivel;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `jer_fecha`;
DELIMITER ;;
CREATE TRIGGER `jer_fecha` BEFORE INSERT ON `jerarquias` FOR EACH ROW SET NEW.fechaRegistro = NOW()
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `fecha_reg_copy_copy`;
DELIMITER ;;
CREATE TRIGGER `fecha_reg_copy_copy` BEFORE INSERT ON `respuestas_autoevaluacion` FOR EACH ROW SET NEW.fechaRegistro = NOW()
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `reclahis`;
DELIMITER ;;
CREATE TRIGGER `reclahis` BEFORE INSERT ON `respuestas_clave_historico_niveles` FOR EACH ROW SET NEW.fechaRegistro = NOW()
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `reclahis_copy`;
DELIMITER ;;
CREATE TRIGGER `reclahis_copy` BEFORE INSERT ON `respuestas_clave_historico_puestos` FOR EACH ROW SET NEW.fechaRegistro = NOW()
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `fecha_reg_copy`;
DELIMITER ;;
CREATE TRIGGER `fecha_reg_copy` BEFORE INSERT ON `respuestas_evaluacion` FOR EACH ROW SET NEW.fechaRegistro = NOW()
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `reevfech`;
DELIMITER ;;
CREATE TRIGGER `reevfech` BEFORE INSERT ON `respuestas_evaluacion_empleados` FOR EACH ROW SET NEW.fechaRegistro = NOW()
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `reev_avance_ins`;
DELIMITER ;;
CREATE TRIGGER `reev_avance_ins` AFTER INSERT ON `respuestas_evaluacion_empleados` FOR EACH ROW UPDATE respuestas_evaluacion SET avance = avance + 1 WHERE id = NEW.id_respuestas_evaluacion
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `reev_avance_del`;
DELIMITER ;;
CREATE TRIGGER `reev_avance_del` AFTER DELETE ON `respuestas_evaluacion_empleados` FOR EACH ROW UPDATE respuestas_evaluacion SET avance = avance - 1 WHERE id = OLD.id_respuestas_evaluacion
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `usuario_now`;
DELIMITER ;;
CREATE TRIGGER `usuario_now` BEFORE INSERT ON `usuarios` FOR EACH ROW SET NEW.fechaRegistro = NOW()
;;
DELIMITER ;
