/*
Navicat MySQL Data Transfer

Source Server         : MayabEvaluaciones
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : mayab_evaluaciones

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2016-05-27 21:56:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for areas
-- ----------------------------
DROP TABLE IF EXISTS `areas`;
CREATE TABLE `areas` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `areakey` (`titulo`),
  KEY `areid` (`codigo`),
  KEY `areti` (`titulo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of areas
-- ----------------------------
INSERT INTO `areas` VALUES ('1', 'Rectoría');
INSERT INTO `areas` VALUES ('2', 'Vicerrectoría  de Formación Integral');
INSERT INTO `areas` VALUES ('3', 'Vicerrectoría Académica');
INSERT INTO `areas` VALUES ('4', 'Vicerrectoría de Administración y Finanzas');
INSERT INTO `areas` VALUES ('5', 'Vicerrectoría de Formación Integral');

-- ----------------------------
-- Table structure for cartas_envios
-- ----------------------------
DROP TABLE IF EXISTS `cartas_envios`;
CREATE TABLE `cartas_envios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) DEFAULT '0' COMMENT '0: Jefe, 1: Autoevaluación',
  `tipo` int(11) DEFAULT '0' COMMENT '0: Evaluaciones, 1: Autoevaluaciones',
  `usuarioRegistrante` varchar(255) DEFAULT NULL,
  `fechaRegistro` datetime DEFAULT NULL,
  `empleadosTotales` int(11) DEFAULT '0',
  `avance` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cart_indexes` (`id`,`evaluacion`,`usuarioRegistrante`,`tipo`),
  KEY `car_ev` (`evaluacion`),
  KEY `car_usu` (`usuarioRegistrante`),
  CONSTRAINT `car_ev` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `car_usu` FOREIGN KEY (`usuarioRegistrante`) REFERENCES `usuarios` (`usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cartas_envios
-- ----------------------------

-- ----------------------------
-- Table structure for cartas_envios_empleados
-- ----------------------------
DROP TABLE IF EXISTS `cartas_envios_empleados`;
CREATE TABLE `cartas_envios_empleados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `envio` int(11) DEFAULT NULL,
  `empleado` int(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `carta` varchar(255) DEFAULT NULL,
  `fechaRegistro` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `caenem_ema` (`envio`,`empleado`),
  KEY `carenvempindex` (`id`,`envio`,`empleado`) USING BTREE,
  KEY `caenem_emp` (`empleado`),
  CONSTRAINT `caenem_emp` FOREIGN KEY (`empleado`) REFERENCES `empleados` (`empleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `caenem_env` FOREIGN KEY (`envio`) REFERENCES `cartas_envios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=716 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cartas_envios_empleados
-- ----------------------------

-- ----------------------------
-- Table structure for cartas_templates
-- ----------------------------
DROP TABLE IF EXISTS `cartas_templates`;
CREATE TABLE `cartas_templates` (
  `evaluacion` int(11) DEFAULT NULL,
  `tipo_0` text,
  `tipo_1` text,
  UNIQUE KEY `cartemp_ev` (`evaluacion`),
  CONSTRAINT `cartempev` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cartas_templates
-- ----------------------------
INSERT INTO `cartas_templates` VALUES ('1', '<p>Apreciable [empleado_nombre]:</p>\r\n<p>Ha llegado el momento de valorar el desempeño de nuestros colaboradores (a cargo) en la realización de sus <b>funciones</b>  cotidianas, <b>actitudes</b> predominantes y  el grado de desarrollo de sus <b>competencias</b> de acuerdo a sus características personales y las requeridas  para el puesto.</p>\r\n \r\n<p>Es una oportunidad de tener un <b>contacto directo</b> con cada uno y juntos analizar sus fortalezas y áreas de oportunidad a seguir desarrollando en beneficio del área y de acuerdo a nuestra <b>misión</b> institucional.</p>\r\n\r\n<p>La evaluación se llevará acabo en las siguientes fechas:</p>\r\n<ul>\r\n	<li>Inicio: <b>Lunes 25 de abril de 2016</b>.</li>\r\n	<li>Cierre: <b>Miércoles 3 de mayo de 2016 a las 20:00 horas</b>.</li>\r\n	<li>Resultados:\r\n		<ul>\r\n			<li>El <b>lunes 6 y martes 7 de junio de 2016</b> se entregarán a <b>cada Evaluador</b> los <b>resultados impresos</b>.</li>\r\n			<li>El <b>lunes 27 de junio de 2016</b> se enviarán por correo electrónico a cada colaborador.</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n<p>Recomendaciones:</p>\r\n<ol>\r\n  <li>Una vez iniciada la sesión de evaluación intenta terminarla (no te tomara más de 15 minutos).</li>\r\n  <li>El proceso de evaluación consta de 4 partes, las cuales se deben de contestar al 100%:\r\n		<ol type=\"a\">\r\n			<li><b>Valoración de las competencias institucionales:</b> asistencia y puntualidad, actitud de servicio,comunicación asertiva,responsabilidad/compromiso institucional, creatividad e innovación,proactividad e identidad institucional (para todo el personal).</li>\r\n			<li><b>Valoración de las competencias directivas:</b> liderazgo, toma de decisiones y manejo de estrés (sólo para puestos directivos).</li>\r\n			<li><b>Valoración de competencias del nivel:</b> Las cuales abarcan las funciones generales de cada nivel y algunas especificaciones del puesto (para todo el personal).</li>\r\n			<li><b>Redacción libre:</b> fortalezas, áreas de oportunidad, cursos de capacitación y comentarios.</li>\r\n		</ol>\r\n	</li>\r\n	<li>En caso de tener alguna duda, por favor, dirígete al correo <br><a href=\"maailto:evaluacion.desempeno@anahuac.mx\">evaluacion.desempeno@anahuac.mx</a></li>\r\n</ol>\r\n\r\n<p>Finalmente, te invitamos a ingresar al siguiente link desde tu pc o dispositivo móvil, en cualquier lugar que cuente con conexión a internet:<br>\r\n<a href=\"[vinculo]\">[vinculo]</a></p>\r\n<p>\r\n	Muchas gracias por tu interés y colaboración.<br><br>\r\n	Atentamente,<br><br>\r\n	<b>Alejandrina Acevedo Vales.</b>\r\n</p>', '<p>No hay un texto definido...</p>\r\n<p><a href=\"[vinculo]\">[vinculo]</a></p>');

-- ----------------------------
-- Table structure for ci_sessions
-- ----------------------------
DROP TABLE IF EXISTS `ci_sessions`;
CREATE TABLE `ci_sessions` (
  `id` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0',
  `data` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_sessions_timestamp` (`timestamp`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ci_sessions
-- ----------------------------
INSERT INTO `ci_sessions` VALUES ('7e201131d210042bebffee0a3ed4a509363b61dc', '127.0.0.1', '1464222220', 0x5F5F63695F6C6173745F726567656E65726174657C693A313436343134323731303B61636365736F7C623A313B686F72614C6F6775656F7C733A31393A22323031362D30352D32352030343A31383A3332223B7573756172696F7C733A353A2261646D696E223B706173737C733A34303A2264303333653232616533343861656235363630666332313430616563333538353063346461393937223B6E6F6D6272657C733A32343A2241646D696E6973747261646F722064652073697374656D61223B656D61696C7C733A31383A2261646D696E4062636F72652E636F6D2E6D78223B6665636861526567697374726F7C733A31393A22323031352D30392D30372032303A35383A3333223B7374617475737C733A313A2230223B);
INSERT INTO `ci_sessions` VALUES ('8e7abba370bbd7e1b10908d6d6c002c2f487dad3', '127.0.0.1', '1464233714', 0x5F5F63695F6C6173745F726567656E65726174657C693A313436343233333731343B);

-- ----------------------------
-- Table structure for cuestionarios_competencias
-- ----------------------------
DROP TABLE IF EXISTS `cuestionarios_competencias`;
CREATE TABLE `cuestionarios_competencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `principal` int(1) DEFAULT '1' COMMENT 'Indica si el cuestionario se mostrará con sus preguntas (Principal) o si forma parte de los cuestionarios de puestos (Secundario)\r\n1: Principal, 0: Secundario',
  `vinculaPuestos` int(1) DEFAULT '0' COMMENT 'Indica si este cuestionario mostrará los cuestionarios de puestos.\r\nSólo debería haber un registro marcado con 1 por nivel.',
  `orden` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc_id` (`id`),
  KEY `cc_ev` (`evaluacion`),
  KEY `cc_sort` (`orden`),
  CONSTRAINT `cc_ev` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COMMENT='Catálogo de competencias en el cuestionario.\r\nEstas son las partes que se eligen mostrar según el nivel del empleado.';

-- ----------------------------
-- Records of cuestionarios_competencias
-- ----------------------------
INSERT INTO `cuestionarios_competencias` VALUES ('1', '1', 'Competencias institucionales', '1', '0', '0');
INSERT INTO `cuestionarios_competencias` VALUES ('2', '1', 'Competencias directivas', '1', '0', '1');
INSERT INTO `cuestionarios_competencias` VALUES ('3', '1', 'Rector', '1', '0', '2');
INSERT INTO `cuestionarios_competencias` VALUES ('4', '1', 'Mandos medios', '1', '0', '3');
INSERT INTO `cuestionarios_competencias` VALUES ('5', '1', 'Profesores', '1', '0', '4');
INSERT INTO `cuestionarios_competencias` VALUES ('6', '1', 'Operativos 1 (Personal administrativo)', '1', '0', '5');
INSERT INTO `cuestionarios_competencias` VALUES ('7', '1', 'Operativos 2 (Secretarias y asistentes)', '1', '0', '6');
INSERT INTO `cuestionarios_competencias` VALUES ('8', '1', 'Operativos 3 (Servicios generales)', '1', '0', '7');
INSERT INTO `cuestionarios_competencias` VALUES ('9', '1', '<i class=\"fa fa-fw fa-info-circle\"></i> Mostrar cuestionario de puestos', '1', '1', '8');
INSERT INTO `cuestionarios_competencias` VALUES ('10', '1', 'Asesor De Desarrollo Humano (Nivel Mandos Medios 2)', '0', '0', '1');
INSERT INTO `cuestionarios_competencias` VALUES ('11', '1', 'Asesor Preuniversitario (Nivel Mandos Medios 2)', '0', '0', '2');
INSERT INTO `cuestionarios_competencias` VALUES ('12', '1', 'Asistente Académico (Nivel Mandos Medios 2)', '0', '0', '3');
INSERT INTO `cuestionarios_competencias` VALUES ('13', '1', 'Asistente De Dirección (Nivel Mandos Medios 2)', '0', '0', '4');
INSERT INTO `cuestionarios_competencias` VALUES ('14', '1', 'Asistente Ejecutivo De Rectoría (Nivel Mandos Medios 1)', '0', '0', '5');
INSERT INTO `cuestionarios_competencias` VALUES ('15', '1', 'Contralor (Nivel Direcciones 2)', '0', '0', '6');
INSERT INTO `cuestionarios_competencias` VALUES ('16', '1', 'Coodinador De Servicio Y Acción Social (Nivel Mandos Medios 2)', '0', '0', '7');
INSERT INTO `cuestionarios_competencias` VALUES ('17', '1', 'Coordinación De Atención A Alumnos (Nivel Mandos Medios 2)', '0', '0', '8');
INSERT INTO `cuestionarios_competencias` VALUES ('18', '1', 'Coordinación De Comunicación (Nivel Mandos Medios 1)', '0', '0', '9');
INSERT INTO `cuestionarios_competencias` VALUES ('19', '1', 'Coordinador De Becas Alumnos (Nivel Mandos Medios 2)', '0', '0', '10');
INSERT INTO `cuestionarios_competencias` VALUES ('20', '1', 'Coordinador De Calidad Académica (Nivel Mandos Medios 1)', '0', '0', '11');
INSERT INTO `cuestionarios_competencias` VALUES ('21', '1', 'Coordinador De Campos Clínicos (Nivel Mandos Medios 2)', '0', '0', '12');
INSERT INTO `cuestionarios_competencias` VALUES ('22', '1', 'Coordinador De Difusión Cultural (Nivel Mandos Medios 1)', '0', '0', '13');
INSERT INTO `cuestionarios_competencias` VALUES ('23', '1', 'Coordinador De Investigación (Nivel Mandos Medios 1)', '0', '0', '14');
INSERT INTO `cuestionarios_competencias` VALUES ('24', '1', 'Coordinador De Operación De  Posgrados Y Extensión (Nivel Mandos Medios 1)', '0', '0', '15');
INSERT INTO `cuestionarios_competencias` VALUES ('25', '1', 'Coordinador De Operación De Licenciatura (Mandos Medios 1)', '0', '0', '16');
INSERT INTO `cuestionarios_competencias` VALUES ('26', '1', 'Coordinador De Programa Académico (Nivel Mandos Medios 1)', '0', '0', '17');
INSERT INTO `cuestionarios_competencias` VALUES ('27', '1', 'Coordinador De Programa De Egresados (Nivel Mandos Medios 2)', '0', '0', '18');
INSERT INTO `cuestionarios_competencias` VALUES ('28', '1', 'Coordinador De Programas De Liderazgo (Nivel Mandos Medios 1) : Vértice, Red Misión', '0', '0', '19');
INSERT INTO `cuestionarios_competencias` VALUES ('29', '1', 'Coordinador De Relaciones Académicas (Nivel Mandos Medios 1)', '0', '0', '20');
INSERT INTO `cuestionarios_competencias` VALUES ('30', '1', 'Coordinador De Selecciones Y Academias Deportivas (Nivel Mandos Medios 1)', '0', '0', '21');
INSERT INTO `cuestionarios_competencias` VALUES ('31', '1', 'Coordinador De Servicios De Tecnología', '0', '0', '22');
INSERT INTO `cuestionarios_competencias` VALUES ('32', '1', 'Coordinador De Tutorías Y Apoyo Académico (Nivel Mandos Medios 1)', '0', '0', '23');
INSERT INTO `cuestionarios_competencias` VALUES ('33', '1', 'Coordinador De Vinculación Y Recaudación De Fondos (Nivel Mandos Medios 1)', '0', '0', '24');
INSERT INTO `cuestionarios_competencias` VALUES ('34', '1', 'Coordinador Del Centro De Lenguas (Nivel Mandos Medios 1)', '0', '0', '25');
INSERT INTO `cuestionarios_competencias` VALUES ('35', '1', 'Coordinador General De Humanidades (Direcciones 2)', '0', '0', '26');
INSERT INTO `cuestionarios_competencias` VALUES ('36', '1', 'Del Director De Pastoral Universitaria (Nivel Direcciones 2)', '0', '0', '27');
INSERT INTO `cuestionarios_competencias` VALUES ('37', '1', 'Dirección De Comunicación (Nivel Mandos Medios 1)', '0', '0', '28');
INSERT INTO `cuestionarios_competencias` VALUES ('38', '1', 'Director De Administración Escolar Y Normatividad     (Nivel Direcciones2)', '0', '0', '29');
INSERT INTO `cuestionarios_competencias` VALUES ('39', '1', 'Director De Atención Preuniversitaria Y Mercadotecnia (Direccciones 2)', '0', '0', '30');
INSERT INTO `cuestionarios_competencias` VALUES ('40', '1', 'Director De Desarrollo Académico (Nivel Direccciones 2) ', '0', '0', '31');
INSERT INTO `cuestionarios_competencias` VALUES ('41', '1', 'Director De Desarrollo Institucional ( Nivel Direcciones 2)', '0', '0', '32');
INSERT INTO `cuestionarios_competencias` VALUES ('42', '1', 'Director De División (Nivel Direccciones 1)', '0', '0', '33');
INSERT INTO `cuestionarios_competencias` VALUES ('43', '1', 'Director De Programa Académico( Nivel Mandos Medios 1)', '0', '0', '34');
INSERT INTO `cuestionarios_competencias` VALUES ('44', '1', 'Director De Programas De Posgrado Y Extensión (Nivel Direcciones 2)', '0', '0', '35');
INSERT INTO `cuestionarios_competencias` VALUES ('45', '1', 'Director De Servicios Institucionales Y Planeación (Nivel Direcciones 1)', '0', '0', '36');
INSERT INTO `cuestionarios_competencias` VALUES ('46', '1', 'Entrenador De Selecciones Y Academias Deportivas (Nivel Mandos Medios 2)', '0', '0', '38');
INSERT INTO `cuestionarios_competencias` VALUES ('47', '1', 'Especialista De Certificación Y Titulación (Nivel Mandos Medios 2)', '0', '0', '39');
INSERT INTO `cuestionarios_competencias` VALUES ('48', '1', 'Especialista De Orientación Vocacional (Nivel Mandos Medios 2)', '0', '0', '40');
INSERT INTO `cuestionarios_competencias` VALUES ('49', '1', 'Especialista De Presupuestos (Nivel Mandos Medios 2)', '0', '0', '41');
INSERT INTO `cuestionarios_competencias` VALUES ('50', '1', 'Especialista De Recursos Humanos (Nivel Mandos Medios 2)', '0', '0', '42');
INSERT INTO `cuestionarios_competencias` VALUES ('51', '1', 'Especialista De Soporte A Sistemas (Nivel Mandos Medios 2)', '0', '0', '43');
INSERT INTO `cuestionarios_competencias` VALUES ('52', '1', 'Especialista En Desarrollo De Medios (Nivel Mandos Medios 2)', '0', '0', '44');
INSERT INTO `cuestionarios_competencias` VALUES ('53', '1', 'Gerente De Recursos Humanos (Nivel Mandos Medios 1)', '0', '0', '45');
INSERT INTO `cuestionarios_competencias` VALUES ('54', '1', 'Jefe De Admisiones (Nivel Mandos Medios 1)', '0', '0', '46');
INSERT INTO `cuestionarios_competencias` VALUES ('55', '1', 'Jefe De Biblioteca (Nivel Mandos Medios 1)', '0', '0', '47');
INSERT INTO `cuestionarios_competencias` VALUES ('56', '1', 'Jefe De Compras (Nivel Mandos Medios 2)', '0', '0', '48');
INSERT INTO `cuestionarios_competencias` VALUES ('57', '1', 'Jefe De Contabilidad (Nivel Mandos Medios 2)', '0', '0', '49');
INSERT INTO `cuestionarios_competencias` VALUES ('58', '1', 'Jefe De Crédito Y Cobranza (Nivel Mandos Medios 2)', '0', '0', '50');
INSERT INTO `cuestionarios_competencias` VALUES ('59', '1', 'Jefe De Infraestructura Tecnológica (Nivel Mandos Medios 1)', '0', '0', '51');
INSERT INTO `cuestionarios_competencias` VALUES ('60', '1', 'Jefe De Servicios Computacionales (Nivel Mandos Medios 1)', '0', '0', '52');
INSERT INTO `cuestionarios_competencias` VALUES ('61', '1', 'Jefe De Servicios Escolares Externos (Nivel Mandos Medios 1)', '0', '0', '53');
INSERT INTO `cuestionarios_competencias` VALUES ('62', '1', 'Jefe De Servicios Escolares Internos Y Auditoria (Nivel Mandos Medios 1)', '0', '0', '54');
INSERT INTO `cuestionarios_competencias` VALUES ('63', '1', 'Jefe De Servicios Generales (Nivel Mandos Medios 2)', '0', '0', '55');
INSERT INTO `cuestionarios_competencias` VALUES ('64', '1', 'Profesor Universitario (Nivel Mandos Medios 2)', '0', '0', '56');
INSERT INTO `cuestionarios_competencias` VALUES ('65', '1', 'Se Aplicará Para Personal Administrativo (Nivel Operativo 1-2)', '0', '0', '57');
INSERT INTO `cuestionarios_competencias` VALUES ('66', '1', 'Secretarias Y Asistentes (Nivel Operativo 2)', '0', '0', '58');
INSERT INTO `cuestionarios_competencias` VALUES ('67', '1', 'Servicios Generales (Nivel Operativo 2)', '0', '0', '59');
INSERT INTO `cuestionarios_competencias` VALUES ('68', '1', 'Supervisor De Servicios Al Público (Nivel Mandos Medios 2)', '0', '0', '60');
INSERT INTO `cuestionarios_competencias` VALUES ('69', '1', 'Vicerrector Académico (Nivel Autoridades 2) ', '0', '0', '61');
INSERT INTO `cuestionarios_competencias` VALUES ('70', '1', 'Vicerrector De Administración Y Finanzas (Nivel Autoridades 2)', '0', '0', '62');
INSERT INTO `cuestionarios_competencias` VALUES ('71', '1', 'Vicerrector De Formación Integral (Nivel Autoridades 2)', '0', '0', '63');
INSERT INTO `cuestionarios_competencias` VALUES ('72', '1', 'Director Del Centro De Investigación (Nivel Direcciones 2)', '0', '0', '37');

-- ----------------------------
-- Table structure for cuestionarios_competencias_secciones
-- ----------------------------
DROP TABLE IF EXISTS `cuestionarios_competencias_secciones`;
CREATE TABLE `cuestionarios_competencias_secciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `competencia` int(11) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `descripcion` text,
  `mostrar_titulo` int(1) DEFAULT '1' COMMENT '0: Invisible, 1: Visible',
  `orden` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccs_id` (`id`),
  KEY `ccs_sec` (`competencia`),
  KEY `ccs_sort` (`orden`),
  CONSTRAINT `ccs_c` FOREIGN KEY (`competencia`) REFERENCES `cuestionarios_competencias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COMMENT='Cada competencia se divide en secciones.\r\nEstas secciones tienen sus preguntas y estas a su vez tienen asignados posibles valores que se pueden tomar como respuesta.\r\nAlgunas secciones no muestran el título. Esto se define con el campo "mostrar_titulo".';

-- ----------------------------
-- Records of cuestionarios_competencias_secciones
-- ----------------------------
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('1', '1', 'Asistencia y puntualidad', '<b>Asistencia:</b> La concurrencia que realiza el trabajador  en forma cotidiana a su centro de trabajo durante todos los días laborales que se espera que asista y dentro de su horario laboral.<br>\r\n<b>Puntualidad:</b> La concurrencia al puesto de trabajo antes o en la hora de entrada que se tiene establecida en una organización.', '1', '1');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('2', '1', 'Actitud de servicio', 'La disposición que se muestra hacia la realización de diversas situaciones durante el trabajo, tales como el ser amable tanto al inicio como al final de la presentación de un servicio, demostrar interés legítimo en resolver la necesidad o problema y realizar actividades de recuperación en casos de incumplimiento del servicio.\r\n', '1', '2');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('3', '1', 'Comunicación asertiva', 'La capacidad de comunicar (expresar) de una forma clara, concisa y firme nuestro punto de vista, ideas y valores de lo que queremos lograr, sin temor a lo que los demás piensen, sin permitir que otros decidan por nosotros o el ser agresivos. Logrando que el mensaje transmitido sea interpretado tal y como queremos que sea interpretado.', '1', '3');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('4', '1', 'Responsabilidad / Compromiso institucional', 'Al cumplimiento de las obligaciones y cuidado al hacer o decidir algo, sabiendo que las cosas deben de hacerse bien desde el principio hasta el final logrando la confianza de la gente.  Tener conciencia acerca de las consecuencias que tiene todo lo que hacemos o dejamos de hacer sobre nosotros mismos o sobre los demás.', '1', '4');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('5', '1', 'Creatividad e innovación', '<b>Creatividad:</b> Es la generación de nuevas ideas o conceptos, o de nuevas presentaciones entre ideas o conceptos ya conocidos que producen soluciones originales.\r\n<b>Innovación:</b> Es la capacidad de crear algo nuevo,  modificar o ver las cosas de manera diferente  e introducirlo y difundirlo de manera exitosa en el área laboral.', '1', '5');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('6', '1', 'Proactividad', 'Tener iniciativa  y asumir la responsabilidad de hacer que las cosas sucedan; decidir en cada momento lo que queremos hacer y cómo lo vamos a hacer centrando los esfuerzos a las cosas donde se puede hacer algo y con actitud positiva, ampliando su círculo de influencia.Se mueven por valores,saben lo que necesitan y actúan en consecuencia.', '1', '6');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('7', '1', 'Identidad institucional', 'Conjunto de rasgos colectivos que identifican a la Institución, replanteando de manera consistente lo que somos, lo que queremos y a dónde vamos. El sentirse pertenenciente a la institución. Es una mezcla entre lo que los demás dicen que somos y lo que nosotros construimos sobre nosotros mismos. Nace de nuestra historia como institución, de las expectativas y necesidades, conocimientos y experiencias de toda la comunidad educativa y de nuestra cultura.              ', '1', '7');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('8', '2', 'Liderazgo', 'Consiste en la capacidad de influir en las personas para que se unan en la consecución de ciertas metas en común.Tener visión de futuro, habilidad para conducir grupos buscando el bien particular y el de la empresa. Ser persuasivo,entusiasta ,exigente, carismático , perseverante y ejemplo para los demás.', '1', '8');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('9', '2', 'Toma de decisiones', 'Proceso mediante el cual se elige  una conducta adecuada entre distintas alternativas para resolver una situación problemática, una vez que se ha detectado una amenaza. Acción que debe tomarse cuando ya no hay más tiempo para recoger información. ', '1', '9');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('10', '2', 'Manejo de estrés', 'Implica enfrentarse a las situaciones de estrés o difíciles y creer que es posible manejar e influir en dichas situaciones de manera positiva. Teniendo flexibilidad para adaptar las emociones, pensamientos y comportamiento ante circunstancias e ideas desconocidas, impredecibles y dinámicas.', '1', '10');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('11', '3', 'Rector (Nivel Autoridades 1)', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('12', '4', 'Mandos medios', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('13', '5', 'Profesores', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('14', '6', 'Operativos 1', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('15', '7', 'Operativos 2', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('16', '8', 'Operativos 3', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('17', '43', 'Director De Programa Académico', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('18', '69', 'Vicerrector Académico ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('19', '70', 'Vicerrector De Administración Y Finanzas ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('20', '71', 'Vicerrector De Formación Integral ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('21', '42', 'Director De División ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('22', '45', 'Director De Servicios Institucionales Y Planeación ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('23', '41', 'Director De Desarrollo Institucional ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('24', '40', 'Director De Desarrollo Académico ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('25', '52', 'Especialista En Desarrollo De Medios ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('26', '48', 'Especialista De Orientación Vocacional ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('27', '27', 'Coordinador De Programa De Egresados ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('28', '10', 'Asesor De Desarrollo Humano ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('29', '16', 'Coodinador De Servicio Y Acción Social ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('30', '46', 'Entrenador De Selecciones Y Academias Deportivas ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('31', '13', 'Asistente De Dirección ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('32', '50', 'Especialista De Recursos Humanos ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('33', '21', 'Coordinador De Campos Clínicos ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('34', '64', 'Profesor Universitario ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('35', '68', 'Supervisor De Servicios Al Público ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('36', '51', 'Especialista De Soporte A Sistemas ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('37', '49', 'Especialista De Presupuestos ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('38', '56', 'Jefe De Compras ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('39', '57', 'Jefe De Contabilidad ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('40', '58', 'Jefe De Crédito Y Cobranza ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('41', '63', 'Jefe De Servicios Generales ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('42', '12', 'Asistente Académico ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('43', '47', 'Especialista De Certificación Y Titulación ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('44', '11', 'Asesor Preuniversitario ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('45', '19', 'Coordinador De Becas Alumnos ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('46', '17', 'Coordinación De Atención A Alumnos ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('47', '65', 'Se Aplicará Para Personal Administrativo ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('48', '66', 'Secretarias Y Asistentes ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('49', '67', 'Servicios Generales ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('50', '36', 'Del Director De Pastoral Universitaria ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('51', '39', 'Director De Atención Preuniversitaria Y Mercadotecnia ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('52', '15', 'Contralor ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('53', '35', 'Coordinador General De Humanidades ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('54', '44', 'Director De Programas De Posgrado Y Extensión ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('55', '31', 'Coordinador De Servicios De Tecnología', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('56', '38', 'Director De Administración Escolar Y Normatividad     ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('57', '29', 'Coordinador De Relaciones Académicas ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('58', '28', 'Coordinador De Programas De Liderazgo ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('59', '30', 'Coordinador De Selecciones Y Academias Deportivas ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('60', '24', 'Coordinador De Operación De  Posgrados Y Extensión ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('61', '25', 'Coordinador De Operación De Licenciatura ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('62', '14', 'Asistente Ejecutivo De Rectoría ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('63', '61', 'Jefe De Servicios Escolares Externos ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('64', '20', 'Coordinador De Calidad Académica ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('65', '23', 'Coordinador De Investigación ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('66', '54', 'Jefe De Admisiones ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('67', '32', 'Coordinador De Tutorías Y Apoyo Académico ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('68', '34', 'Coordinador Del Centro De Lenguas ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('69', '55', 'Jefe De Biblioteca ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('70', '33', 'Coordinador De Vinculación Y Recaudación De Fondos ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('71', '53', 'Gerente De Recursos Humanos ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('72', '62', 'Jefe De Servicios Escolares Internos Y Auditoria ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('73', '60', 'Jefe De Servicios Computacionales ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('74', '59', 'Jefe De Infraestructura Tecnológica ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('75', '22', 'Coordinador De Difusión Cultural ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('76', '18', 'Coordinación De Comunicación ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('77', '37', 'Dirección De Comunicación ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('78', '26', 'Coordinador De Programa Académico ', null, '0', '0');
INSERT INTO `cuestionarios_competencias_secciones` VALUES ('79', '72', 'Diector Del Centro De Investigación', null, '0', '0');

-- ----------------------------
-- Table structure for cuestionarios_competencias_secciones_conductas
-- ----------------------------
DROP TABLE IF EXISTS `cuestionarios_competencias_secciones_conductas`;
CREATE TABLE `cuestionarios_competencias_secciones_conductas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seccion` int(11) DEFAULT NULL,
  `descripcion` text,
  `orden` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccsc_id` (`id`),
  KEY `ccsc_sec` (`seccion`),
  KEY `ccsc_sort` (`orden`),
  CONSTRAINT `ccsc_sec` FOREIGN KEY (`seccion`) REFERENCES `cuestionarios_competencias_secciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=741 DEFAULT CHARSET=utf8 COMMENT='Catálogo de preguntas que se asignan a una sección.\r\nCada pregunta puede ser respondida con determinados valores.\r\nEstos valores se asignan con la tabla "cuestionarios_competencias_secciones_valores_posibles".';

-- ----------------------------
-- Records of cuestionarios_competencias_secciones_conductas
-- ----------------------------
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('1', '1', 'Cumple con su horario establecido de trabajo. (Entrada, salida y tiempo de trabajo).', '0');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('2', '1', 'Asiste puntualmente a sus reuniones y citas programadas.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('3', '1', 'Solicita y entrega las tareas o proyectos encomendados en el tiempo indicado.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('7', '2', 'Trata cordialmente y escucha con atención a los clientes internos. (Sostiene la mirada, deja hablar, evita interrupciones de personas/teléfono).', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('8', '2', 'Trata cordialmente y escucha con atención a los clientes externos.(Sostiene la mirada, deja hablar, evita interrupciones de personas/teléfono).', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('9', '2', 'En caso de no tener respuesta a la solicitud, canaliza al cliente con la persona indicada y se asegura que sea atendido.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('10', '2', 'Resuelve la solicitud o da seguimiento a la misma hasta concluirla.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('11', '3', 'Tiene la capacidad de crear un juicio de valor a partir de la comunicación no verbal que observa de sus clientes y de su equipo de trabajo y es congruente entre lo que dice y lo que expresa con sus gestos.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('12', '3', 'Tiene la habilidad de escuchar activamente, no sólo lo que la persona está expresando directamente, sino también los sentimientos, ideas o pensamientos que subyacen a lo que se está diciendo.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('13', '3', 'Tiene la habilidad de preguntar con expresiones adecuadas y mostrando interés y empatía con el objetivo de recoger información.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('14', '3', 'Es específico y logra transmitir con claridad sus ideas de tal forma que permita a su equipo de trabajo comprender su papel dentro de la organización y de motivarse para realizar mejor su trabajo para beneficio propio y de la empresa en general.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('15', '3', 'Sabe trabajar en equipo y por lo tanto: Realiza acciones que permitan generar autonomía y responsabilidad en los miembros del equipo.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('16', '4', 'Tiene la capacidad de establecer metas y objetivos congruentes con las capacidades del equipo de trabajo y al mismo tiempo desafiantes por encima de los estándares, mejorando y manteniendo altos niveles de rendimiento.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('17', '4', 'Es capaz de realizar las funciones que tiene autorizadas sin supervisión.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('18', '4', 'Capacidad de planear el logro de las metas y objetivos dirigiendo adecuadamente los recursos.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('19', '4', 'Genera sinergia contribuyendo con las diferentes áreas de la empresa con el fin de alcanzar los objetivos organizacionales.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('20', '4', 'Se compromete con los proyectos institucionales que no son necesariamente de su área, se suma y apoya genuinamente.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('21', '5', 'Propone ideas novedosas para la mejora continua de su área de trabajo.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('22', '5', 'Es innovador, busca nuevas y mejores maneras de lograr los objetivos por medio de la investigación y aprovechando los cambios tecnológicos en un ambiente competitivo.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('23', '5', 'Sus opiniones enseñan puntos de vista que no habían considerado para resolver las cosas.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('24', '5', 'Ha implementado en su área nuevos procesos y/o servicios innovadores con éxito.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('26', '6', 'Toma la iniciativa en la realización de su trabajo cotidiano.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('27', '6', 'Demuestra capacidad de adaptación a los cambios del entorno.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('28', '6', 'Se interesa por su desarrollo profesional y personal dentro de la institución. (Talleres, capacitación,etc.)', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('29', '6', 'Se compromete con las metas de su área y realiza un plan de acción para lograrlas.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('30', '6', 'Mantiene una actitud positiva ante las dificultades que se le presentan.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('31', '7', 'Se presenta a trabajar de acuerdo al código de vestimenta e imagen de la institución.(Evita pantalones de mezclilla, escotes, sandalias,bermudas,etc).', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('32', '7', 'Su discurso y actuar está de acuerdo con los valores y principios de la institución.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('33', '7', 'Muestra congruencia entre su discurso y su actuar.(Valores)', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('34', '7', 'Fomenta un agradable ambiente en su área de trabajo y dentro de la institución.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('35', '7', 'Participa activamente en las diferentes actividades que organiza la institución.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('36', '8', 'Involucra a su equipo de trabajo para conseguir las metas de su área.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('37', '8', 'Reconoce y retroalimenta las fortalezas y áreas de oportunidad de los miembros de su equipo.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('38', '8', 'Motiva y convence a su equipo en situaciones que no son de su agrado o están fuera de su control.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('39', '8', 'Enseña y da oportunidades de diálogo ente su equipo.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('40', '8', 'Mantiene un ambiente laboral armonioso y motivante en su departamento.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('41', '9', 'Considera o toma en cuenta las diferentes opciones que se le presentan analizando los pros y contras para tomar una decisión.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('42', '9', 'Analiza entre pros y contras de las diferentes opciones presentadas.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('43', '9', 'Elección de alternativas de solución  de manera objetiva procurando el beneficio de las personas involucradas y la empresa.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('44', '9', 'Agilidad para decidir y afrontar situaciones problemáticas que se presentan de manera inesperada que requieren rápida resolución.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('45', '9', 'Asume las consecuencias de sus decisiones y sabe reconocer sus errores.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('46', '10', 'Muestra flexibilidad ante los cambios de circunstancias o etapas de vida de los miembros de su equipo.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('47', '10', 'Permite que los cambios laborales y/o personales le afecten en su estado de ánimo.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('48', '10', 'Suele afrontar las situaciones problemáticas e inesperadas sin perder el control y la armonía de su equipo.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('49', '10', 'Logra recuperar el control de alguna situación sin descargarse en su equipo de trabajo.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('50', '10', 'Es adaptable o flexible a situaciones fuera de su control manteniendo una actitud positiva.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('51', '11', 'Dirigir la operación de la Universidad para lograr los fines de su misión.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('52', '11', 'Dirigir los esfuerzos de planeación y presupuestación de la Universidad, para dar seguimiento al cumplimiento de planes y presupuestos en general.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('53', '11', 'Propiciar y alentar un ambiente propositivo que promueva el crecimiento y desarrollo de nuestra “identidad católica” dentro de la universidad.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('54', '11', 'Cumplir las disposiciones de sus superiores (DG, VP, DT, DOR) del Consejo de Administración y su Comité Ejecutivo.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('55', '11', 'Velar por el cumplimiento de los reglamentos, de los planes y programas de trabajo y, en general de las disposiciones y acuerdos que normen la estructura y funcionamiento de la Universidad vigilando en todo momento el cumplimiento de lineamientos globales establecidos por la División Universidades, el Grupo Integer la División Territorial o la Dirección General establecidos por la División Universidades, el Grupo Integer la División Territorial o la Dirección General', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('56', '11', 'Buscar la integración del personal a la Institución, y el logro de un alto nivel profesional y humano alineado a la misión.', '6');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('57', '11', 'Presentar ante sus superiores y ante el Consejo de Administración, vía el Comité Ejecutivo, el Plan General de Desarrollo de la universidad, y el programa y presupuesto anuales, para su aprobación.', '7');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('58', '11', 'Rendir un informes ante sus superiores y al Consejo de Administración y al Comité Ejecutivo abarcando todos los aspectos del gobierno de su universidad', '8');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('59', '11', 'Expedir y firmar documentación oficial: títulos profesionales, diplomas de especialidad y grados académicos que otorga la Institución, acuerdos con instituciones tanto gubernamentales como privadas y de educación.', '9');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('60', '11', 'Tener la representación de la Universidad, o delegar, cuando lo estime conveniente ya para casos concretos, su propia representación.', '10');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('61', '12', 'Propicia y alenta un ambiente propositivo que promueve el crecimiento y desarrollo de nuestra “identidad católica” especialmente en las actividades relacionadas con la formación humana, tanto de los alumnos como de los colaboradores.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('62', '12', 'Conoce la realidad del departamento en sus procesos críticos: académico, comunicación, promoción, administrativo y de capital humano.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('63', '12', 'Establece relaciones con distintas dependencias y organismos de gobierno y del sector privado y social que favorezcan el desarrollo y la imagen de la Universidad.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('64', '12', 'Mantiene una estrecha comunicación con el Rector o Vicerrector sobre todos los aspectos del cargo, que influyen directa  o indirectamente en el cumplimiento de la Misión de la Universidad.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('65', '12', 'Cumple y hace cumplir el Estatuto de la Universidad, sus Reglamentos, los Planes y Programas de Trabajo y, en general, las disposiciones y acuerdos que normen la estructura y funcionamiento de la Universidad.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('66', '12', 'Supervisa y evalúa el desempeño del personal que le reporta directamente.', '6');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('67', '12', 'Propone al Rector o Vicerrector los candidatos para cubrir los puestos ejecutivos del área.', '7');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('68', '12', 'Cuida de la óptima utilización de los recursos tanto humanos como materiales asignados al área.', '8');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('69', '12', 'Elaborar el presupuesto anual del área y lo entrega en tiempo y forma.', '9');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('70', '12', 'Propone plan de trabajo adecuado en base a la planeación estratégica.', '10');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('71', '13', 'Elabora programas de clase en base al programa académico.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('72', '13', 'Mantiene una relación positiva con sus alumnos.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('73', '13', 'Elabora exámenes de acuerdo con el contenido de la asignatura.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('74', '13', 'Continúa con su formación docente', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('75', '13', 'Participa en cursos o seminarios que le sean asignados y/o programados por las autoridades de la Universidad.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('76', '13', 'Atiende oportunamente las inquietudes de los alumnos.', '6');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('77', '13', 'Se asesora con la autoridad correspondiente para la pronta solución de problemas de sus alumnos.', '7');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('78', '13', 'Utiliza eficientemente la tecnología como apoyo de la práctica docente.', '8');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('79', '13', 'Realiza el seguimiento académico y personal de sus alumnos tutoriados.', '9');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('80', '13', 'Entrega informes de seguimiento al Director de su escuela.', '10');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('81', '14', 'Mantiene una estrecha comunicación con su jefe sobre todos los aspectos  del cargo que influyen directa  o indirectamente en el cumplimiento de la Misión de la Universidad.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('82', '14', 'Cumple y hace cumplir las políticas y lineamientos definidos por los superiores, así como el Estatuto de la Universidad, sus reglamentos, planes y programas de trabajo y, en general, las disposiciones y acuerdos que normen la estructura y funcionamiento de la Universidad.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('83', '14', 'Organiza y mantiene actualizados los sistemas y procedimientos del área.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('84', '14', 'Apoya al Director del área en el desarrollo del Plan Estratégico a corto, mediano y largo plazo, de acuerdo con el Plan Estratégico de la Universidad, coordinando la elaboración de los planes y programas anuales de trabajo.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('85', '14', 'Propicia y alenta un ambiente propositivo que promueva el crecimiento y desarrollo de nuestra “identidad católica” dentro de la institución, con los alumnos, padres de familia, egresados y en especial dentro del personal de su área.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('86', '14', 'Conocimiento de los lineamientos, procesos, procedimientos y regulaciones bajo las que opera el área', '6');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('87', '14', 'Buscar promover y difundir la misión de “identidad católica” de la institución, actuando con rectitud y congruencia en todas las actividades asignadas a su cargo', '7');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('88', '14', 'Conocer y apoyar los proyectos, objetivos y misión del área en la que desempeña sus funciones', '8');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('89', '14', 'Conocer los clientes y proveedores de servicio del área en la que trabaja, con el fin de ofrecer una calidad de atención adecuada y oportuna.', '9');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('90', '14', 'Buscar su desarrollo y crecimiento personal capacitándose en tareas y funciones propias del área.', '10');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('91', '15', 'Realiza tareas de captura, redacción y mecanografía de documentos, archivo y organización de eventos; control de agenda, control de viajes y en general apoya al área en todo lo referente a cuestiones administrativas', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('92', '15', 'Atiende a usuarios, personal del área, proveedores y prestadores de servicio.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('93', '15', 'Apoya al control de gastos, elaboración de reportes de viaje y reservaciones.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('94', '15', 'Recepción y registro de documentos recibidos y enviados por el área.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('95', '15', 'Recepción, registro y direccionamiento de llamadas.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('96', '15', 'Solicita y administra: papelería, artículos de oficina, caja chica, suministros para operación de equipos de computación etc.', '6');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('97', '15', 'Trámites de pago a proveedores.', '7');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('98', '15', 'Conocimiento y apoyo a los objetivos del área, y la misión de la institución.', '8');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('99', '15', 'Apoya en la organización de juntas y eventos del área.', '9');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('100', '15', 'Control de archivo.', '10');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('101', '16', 'Alertar a sus superiores sobre fallas o problemas que requieran los servicios del área de mantenimiento.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('102', '16', 'Realiza mantenimiento preventivo y correctivo a las instalaciones de la institución.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('103', '16', 'Atiende los requerimiento de reparación, corrigiendo el daño en el menor tiempo.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('104', '16', 'Solicitar los materiales que se requieran para los trabajos a realizar.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('105', '16', 'Elaborar elementos sencillos (mobiliario y equipo) de carpintería, herrería ,albañilería o jardinería.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('106', '16', 'Ejecutar las actividades a realizar diariamente del área, a la recepción del reporte correspondiente.', '6');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('107', '16', 'Proponer al jefe del área las mejoras que considere pertinentes para cumplir con las responsabilidades asignadas.', '7');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('108', '16', 'Conocer los objetivos del área y la misión de la institución.', '8');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('109', '16', 'Realizar actividades de apoyo dentro del área.', '9');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('110', '16', 'Conocer los sistemas de seguridad de la institución.', '10');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('111', '16', 'Cuidar del buen uso de los equipos y herramientas que se le asignen.', '11');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('112', '17', 'Promueve constantemente la misión institucional y los valores universitarios en su trabajo de supervisión de las labores académicas y administrativas del personal a su cargo.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('113', '17', 'Mantiene una supervisión constante de la calidad de las cátedras impartidas y revisa al término de cada período escolar los resultados arrojados por los procesos de evaluación docente para alinear aspectos que sean necesarios.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('114', '17', 'Atiende y resuelve con prontitud y actitud de servicio las necesidades y solicitudes de los estudiantes y docentes.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('115', '17', 'Demuestra una preocupación genuina y permanente por la optimización del uso de los recursos humanos y materiales asignados a su programa académico.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('116', '17', 'Valida constantemente mediante el sector empresarial y social el perfil del egresado formado en la Licenciatura y establece programas que mejoren la percepción y respondan a las necesidades de la sociedad.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('117', '17', 'Da un seguimiento cercano a cada uno de sus profesores y personal buscando generar un buen ambiente, la colaboración en equipo, la integración con la universidad y dando respuesta a sus intereses e inquietudes. ', '6');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('118', '17', 'Colabora permanentemente con las labores de promoción de su escuela hacia los diversos públicos: egresados, empresas,instituciones privadas y gubernamentales entre otros.', '7');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('119', '17', 'Da un seguimiento puntual al Plan Operativo Anual y asegura su cumplimiento en el tiempo establecido y con la calidad requerida. ', '8');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('120', '17', 'Se preocupa por tener y retener a docentes de excelencia para licencitatura y posgrados con experiencia profesional y calidad académica.', '9');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('121', '17', 'Busca proponer, desarrollar, implementar y actualizar los programas de posgrados y educación continua.', '10');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('122', '18', 'Promueve activamente el desarrollo de nuestra misión e \"identidad católica\" dentro de la Institución y entre el personal que depende de él.', '11');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('123', '18', 'Establece y supervisa la realización de las prioridades de operación y quehacer académico de las áreas a su cargo.', '12');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('124', '18', 'Procura la máxima calidad académica y busca implementar los sistemas necesarios para conseguirla, de modo que dé respuesta a las inquietudes de estudiantes y profesores. ', '13');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('125', '18', 'Analizar y propone los programas académicos que debe de ofrecer la Universidad manteniédolos actualizados.', '14');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('126', '18', 'Procura la máxima calidad académica certificada de la universidad a partir de los procesos de acreditación que la institución ha decidido emprender y renovar tanto en licenciatura como en Posgrados', '15');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('127', '18', 'Ha establecido nuevas relaciones académicas y mantiene una relación cercana con otras instituciones nacionales e internacionales de prestigio.', '16');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('128', '18', 'Desarrolla y da seguimiento al Plan Estratégico y de Presupuesto del área a corto, mediano y largo plazo de acuerdo al Plan Estratégico de la Universidad asegurando su cumplimiento.', '17');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('129', '18', 'Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.', '18');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('130', '18', 'Procura y fomenta una colaboración estrecha con las vicerrectorias de la Universidad', '19');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('131', '18', 'Fomenta y busca la innovación en todas sus áreas, en especial en el proceso de enseñanza aprendizaje y en los métodos. Buscando una estrecha relación con el departamento de innovación de la Universidad. ', '20');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('132', '19', 'Promueve activamente el desarrollo de nuestra misión e \"identidad católica\" dentro de la Institución y entre el personal que depende de él.', '21');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('133', '19', 'Desarrolla y da seguimiento al Plan Estratégico y de Presupuesto del área a corto, mediano y largo plazo de acuerdo al Plan Estratégico de la Universidad asegurando su cumplimiento.', '22');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('134', '19', 'Da seguimiento y busca el cumplimiento ágil de los proyectos de la Universidad en el ámbito de su competencia.', '23');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('135', '19', 'Supervisa el correcto registro y en los tiempos establecidos las operaciones económicas de la Universidad.', '24');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('136', '19', 'Propone al Comité Rectoral los procedimientos administrativos, modificaciones requeridas al presupuesto y cuotas escolares en beneficio de la Institución para presentar a la RUA con las gestiones correspondientes ante la junta de gobierno.', '25');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('137', '19', 'Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.', '26');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('138', '19', 'Integra en tiempo y forma junto con el Comité Rectoral y Rector el presupuesto anual de la Universidad, se encarga de darle seguimiento y vela por el cumplimiento del mismo', '27');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('139', '19', 'Comprende y comunica los objetivos a cumplir y motiva a los miembros del equipo al cumplimiento de los mismos.', '28');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('140', '19', 'Se asegura de proporcionar servicios de alta calidad a los estudiantes y clientes internos tanto en la atención, trato y vanguardia de los servicios que tienen relación a su área de competencia.', '29');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('141', '19', 'Diseña y ejecuta las medidas financieras que aseguren la óptima utilización de los recursos financieros y administrativos de la Institución.Diseña y ejecuta las medidas financieras que aseguren la óptima utilización de los recursos financieros y administrativos de la Institución.', '30');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('142', '20', 'Promueve activamente el desarrollo de nuestra misión e \"identidad católica\" dentro de la Institución y entre el personal que depende de él.', '31');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('143', '20', 'Propicia y coordina de manera permanente las actividades de las áreas de Difusión Cultural y Deportes.', '32');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('144', '20', 'Propicia y coordina de manera permanente las actividades de los Programas de Acción y Servicio Social que apoyan la formación integral de los estudiantes.', '33');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('145', '20', 'Vela por la adecuada implantación, operación y evaluación del modelo educativo Anáhuac de formación integral.', '34');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('146', '20', 'Propone y desarrolla constantemente programas relacionados con la promoción del liderazgo de acción positiva ante la comunidad universitaria.', '35');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('147', '20', 'Fomenta actividades de acción social incrementando consistentemente la participación activa de alumnos, profesores y personal universitario.', '36');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('148', '20', 'Desarrolla y da seguimiento al Plan Estratégico y de Presupuesto del área a corto, mediano y largo plazo de acuerdo al Plan Estratégico de la Universidad asegurando su cumplimiento.', '37');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('149', '20', 'Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.', '38');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('150', '20', 'Fomenta la identidad institucional, apostolados y acción social en los alumnos de posgrados.', '39');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('151', '20', 'Cuenta con un plan pastoral y se asegura de su avance y cumplimiento.', '40');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('152', '21', 'Promueve activamente el desarrollo de nuestra \"identidad católica\" especialmente en las actividades relacionadas con la formación humana y académica de los alumnos.', '41');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('153', '21', 'Trabaja junto con la Vicerrectoría Académica, en el alcance y funciones de la división estableciendo planes y programas actualizados a corto,mediano y largo plazo.', '42');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('154', '21', 'Busca la máxima calidad dentro del aula (puntualidad y asistencia de profesores, cumplimiento del programa, participación de los alumnos, innovación en las cátedras, etc)', '43');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('155', '21', 'Busca la máxima calidad académica reconocida tanto en Licenciatura como en Posgrados.', '44');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('156', '21', 'Constantemente desarrolla, implementa y actualiza los programas de posgrados y educación continua.', '45');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('157', '21', 'Mantiene una supervisión constante de la calidad de las cátedras impartidas en la Divisón y revisa al término de cada período escolar los resultados arrojados por los procesos de evaluación docente para alinear aspectos que sean necesarios.', '46');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('158', '21', 'Establece y mantiene relaciones de colaboración con: Instituciones académicas de prestigio,nacionales o extranjeras, con el medio profesional correspondiente y con los egresados de la facultad.', '47');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('159', '21', 'Elabora el Plan y Presupuesto Anual de Operación de su División dando seguimiento a la realización del mismo en el tiempo y calidad requerida.', '48');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('160', '21', 'Da un seguimiento cercano a cada uno de sus profesores buscando generar un buen ambiente, la colaboración en equipo, la integración con la universidad y dando respuesta a sus intereses e inquietudes. ', '49');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('161', '21', 'Valida constantemente mediante el sector empresarial y social el perfil del egresado formado en la División y establece programas que mejoren la percepción y respondan a las necesidades de la sociedad.', '50');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('162', '22', 'Elabora y presenta al comité rectoral para su aprobación, el plan estratégico y los programas anuales acordados con las autoridades y directivos de las diferentes áreas de la universidad. ', '51');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('163', '22', 'Asesora al comité rectoral para desarrollar, actualizar y dar seguimiento a la aplicación del plan estratégico y su programa anual. ', '52');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('164', '22', 'Da un seguimiento cercano a los programas anuales y brinda una retroalimentación clara y estratégica a los responsables. ', '53');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('165', '22', 'Brinda constantemente información estadística fidedígna que sirva para las determinaciones de desarrollo y crecimiento universitario', '54');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('166', '22', 'Orienta y coordina de forma permanente a el área de Administración Escolar logrando un servicio óptimo para los usuarios de la institución.', '55');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('167', '22', 'Orienta y coordina de forma permanente al área de Servicios Tecnológicos logrando un servicio óptimo para los usuarios de la institución.', '56');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('168', '22', 'Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.', '57');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('169', '22', 'Analiza y propone las acciones y procesos que se basan en la medición, diagnóstico, evaluación, diseño y propuestas de intervención para el mejoramiento continuo de procesos y servicios. Ha propuesto mejoras que se han implementado con éxito en el último año.', '58');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('170', '22', 'Apoya y propone al comité rectoral el diseño, implantación y mecanismos de evaluación institucional. ', '59');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('171', '22', 'Coordina de manera eficaz los procesos de certificación y acreditación nacionales e internacionales logrando mantener la excelencia académica de la institución. Da un seguimiento a las recomendaciones u observaciones de los sistemas de acreditación.', '60');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('172', '23', 'Promueve activamente el desarrollo de nuestra \"identidad católica\" dentro de la Institución y en especial dentro del personal de su área,egresados y bienhechores.', '61');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('173', '23', 'Desarrolla e implementa Estrategias de Financiamiento para el crecimiento de la institución basándose en apoyos filantrópicos individuales,grupales y empresariales.', '62');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('174', '23', 'Recauda Recursos Económicos y en Especie (independietes de la operación ordinaria de la Universidad) para el desarrollo de la Institución.', '63');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('175', '23', 'Supervisa la correcta aplicación de los recursos económicos y en especie recaudados de acuerdo a la asignación inicial. ', '64');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('176', '23', 'De manera continua realiza planes y proyectos que fomentan el apoyo y colaboración de los egresados en las actividades institucionales.', '65');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('177', '23', 'Evalúa constantemente la percepción de los públicos a quienes son dirigidos sus eventos y actividades (egresados, alumnos, empresas,etc), y realiza propuestas para su mejoramiento.', '66');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('178', '23', 'Establece relaciones permanentes con distintas dependencias de gobierno,del sector privado y social que favorecen el desarrollo e imagen de la Universidad.', '67');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('179', '23', 'Desarrolla y da seguimiento al Plan Estratégico y de Presupuesto del área a corto, mediano y largo plazo de acuerdo al Plan Estratégico de la Universidad asegurando su cumplimiento.', '68');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('180', '23', 'Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.', '69');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('181', '23', 'Comprende y comunica los objetivos a cumplir y motiva a los miembros del equipo al cumplimiento de los mismos.', '70');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('182', '24', 'Promueve activamente el desarrollo de nuestra \"identidad católica\" especialmente en la formación docente y tutorías.', '71');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('183', '24', 'De manera consistente y junto con sus coordinadores diseña,supervisa y evalúa la ejecución de procesos de excelencia académica e investigación y propone acciones para el mejoramiento continuo de los mismos.', '72');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('184', '24', 'Se asegura de tener un modelo eficaz de atención personal a los estudiantes, particularmente a través de los programas de tutoría, y busca su mejora contínua.', '73');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('185', '24', 'Da seguimiento al cumplimiento efectivo de diversos indicadores de desempeño académico y realiza estudios que permitan conocer los requerimientos de acreditación institucional y de programas académicos ante diferentes instancias(ANUES, FIMPES, ETC).', '74');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('186', '24', 'Conduce el análisis e interpretación de la Práctica de Evaluación Docentes a nivel Institucional, propone acciones para el mejoramiento y se asegura del cumplimiento de las mismas.', '75');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('187', '24', 'Procura la máxima calidad académica certificada de la universidad según los planes de la misma, en especial busca mejorar en las evaluaciones del EGEL.', '76');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('188', '24', 'Apoya los procesos, proyectos e iniativas relacionadas con la Capacitación del Personal Docente.', '77');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('189', '24', 'Busca la máxima calidad dentro del aula (puntualidad y asistencia de profesores, cumplimiento del programa, participación de los alumnos, innovación en las cátedras, etc).', '78');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('190', '24', 'Funge permanentemente como auditor en las diferentes escuelas con la finalidad de el logro de las certificaciones de programas académicos.', '79');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('191', '24', 'Conduce eficientemente los procesos relacionados con la selección y el desarrollo de profesores de planta y de honorarios.', '80');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('192', '25', 'Integra eficientemente de páginas Web de los cursos del Proyecto @prende, de acuerdo a las indicaciones del especialista en Diseño Instruccional, requerimientos de los profesores, tipo de contenido y área de conocimiento.', '81');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('193', '25', 'Diseña de objetos de aprendizaje \"a la medida\", materiales de apoyo y recursos multimedia innovadores.', '82');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('194', '25', 'Desarrolla y aplica con éxito estándares SCORM a los recursos multimedia, objetos e integración de contenidos en WebCT.', '83');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('195', '25', 'Digitaliza en forma y tiempo documentos, imágenes, audios, videos,etc, para la integración de los cursoso del Programa @prende.', '84');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('196', '25', 'Asesora satisfactoriamente a profesores y alumnos, en cuanto al uso de herramientas, software especializado o aplicaciones que se requieren para la impartición de las materias en WebCT y Blackboard.', '85');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('197', '25', 'Supervisa el funcionamiento de todos los recuros que contien cada materia integrada en WebCat, de acuerdo a las indicaciones del Especialista en Diseño Instruccional o del prrofesor.', '86');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('198', '25', 'Estructura y actualiza adecuadamente los archivos y directorios de cursos abiertos en WebCT y Blackboard.', '87');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('199', '25', 'Actualiza y usa la galería de objetos de aprendizaje y recursos multimedia desarrollada para el Programa @prende.', '88');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('200', '25', 'Respalda de forma permanente los documentos originales de los maestros, así como los materiales desarrollados por los enlaces del Programa @prende en cada Universidad.', '89');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('201', '25', 'Cumple eficientemente con los objetivos del Programa @prende en la Red de Universidades Anáhuac.', '90');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('202', '26', 'Orienta apropiadamente a los candidatos a postulantes que solicitan ingreso a la Institución, para que elijan una profesión adecuada,tomando en cuenta sus habilidades, aptitudes, intereses y características de personalidad.', '91');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('203', '26', 'Aplica pruebas psicológicas a los candidatos a ingresar a la institución y elabora adecuadamente los perfiles vocacionales de cada uno de ellos.', '92');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('204', '26', 'Entrevista a cada uno de los candidatos y elabora en tiempo y forma los reportes psicológicos que se envían al área de admisiones.', '93');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('205', '26', 'Mantiene contacto con los directores de las escuelas y conoce el grado de adaptación de los alumnos de nuevo ingreso a la escuela y a la Institución.', '94');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('206', '26', 'Mantiene contacto con los alumnos en casos de bajo rendimiento, problemas de motivación u otros y los canaliza debidamente a instituciones externas que les puedan brindar ayuda.', '95');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('207', '26', 'Reorienta satisfactoriamente a los alumnos que solicitan cambio de carrera.', '96');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('208', '26', 'Realiza entrevistas y mantiene un adecuado contacto con padres de familia.', '97');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('209', '26', 'Determina con precisión la conveniencia o no de ingreso de cada aspirante a través de un reporte.', '98');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('210', '26', 'Controla, revisa y entrega en tiempo y forma los exámenes y reportes psicológicos a las áreas correspondientes.', '99');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('211', '27', 'Propone a la Dirección planes y políticas para estrechar las relaciones de la Universidad con sus egresados fomentando su apoyo y colaboración en actividades institucionales.', '100');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('212', '27', 'Establece vínculos permanentes con empresas de sectores públicos y privados,que permiten que nuestros egresados puedan integrarse al ambiente laboral en forma rápida y con oportunidades de acuerdo a su perfil y aspiraciones profesionales.', '101');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('213', '27', 'Propicia con éxito encuentros, ferias y seminarios que ponen en contacto a nustros alumnos de últimos semestres con las oportunidades laborales a fines a sus perfiles académicos.', '102');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('214', '27', 'Administra, supervisa y evalúa con eficiencia las herraminetas (administrativas y electrónicas) que se presentan a los egresados como alternativas de búsqueda de oportunidades laborales (bolsa de trabajo).', '103');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('215', '27', 'Fomenta satisfactoriamente eventos: comidas, foros,encuentros, seminarios, etc., de integración y reencuentro de grupos de egresados. ', '104');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('216', '27', 'Mantiene constante relación con egresados que colaboran en empresas líderes logrando que participen con la Universidad en proyectos sociales,foros y conferencias siendo modelos a seguir en la vida profesional para nuestros alumnos.', '105');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('217', '27', 'Cuenta con un programa o proceso de retroalimentación efectivo (sugerencias/encuestas) por parte de los egresados, que permiten realinear los proyectos, planes y programas en base a las necesidades y expectativas reales de los mismos.', '106');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('218', '27', 'Establece negociaciones permanantes con proveedores y prestadores de servicios logrando acuerdos que apoyan la economía de nuestros egresados (descuentos, promociones,etc).', '107');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('219', '27', 'Administra y vigila constantemente que se encuentren actualizadas la base de datos con la información personal de los egresados.', '108');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('220', '27', 'Supervisa con eficiencia que todos los medios de contacto con los egresados (cartas, correo electrónico, publicaciones, revistas,etc) cumplan con los contenidos alineados a los valores y misión de la institución.', '109');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('221', '28', 'Brinda atención personalizada a alumnos que le sean canalizados ya sea por áreas académicas vía tutores, por la coordinación de relaciones estudiantiles o por alguna otra instancia.', '110');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('222', '28', 'Evalúa las condiciones, características y actitudes de alumnos asignados a su atención valuando si requiere la atención de un especialista y/o le establece u programa de adaptación.', '111');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('223', '28', 'Alerta en tiempo y forma al Vicerrector de Formación Integral sobre alumnos que presentan problemas que ameriten citar a los padres o tutores.', '112');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('224', '28', 'Apoya apropiadamente a los profesores de tutorías en cuanto a la forma que deben manejar o canalizar casos que ameriten atención personalizada.', '113');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('225', '28', 'En coordinación con relaciones estudiantiles organiza con eficiencia cursos, y conferencias de formación hacia los alumnos manejando temas como: alcoholismo, drogadicción, depresión, anorexia, bulimia, etc.', '114');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('226', '28', 'Trabaja en conjunto con el Director de Pastoral Universitaria apoyándole en el diagnóstico.', '115');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('227', '28', 'Atiende con actitud de servicio a todo alumno o persona de la Institución que se acerque a solicitar sus servicios.', '116');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('228', '28', 'Conoce y está familiarizado con los centros y grupos de apoyo con los que cuenta la Ciudad en la que se ubica la Universidad.', '117');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('229', '28', 'Participa activamente en actividades estudiantiles (Megamisión, actividades culturales,etc) que le permiten interactuar con los alumnos detectando problemas reales o potenciales ya sea a nivel individual o grupal.', '118');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('230', '28', 'Mantiene estricta confidencialidad de la información que le confíen tanto los alumnos, el personal y padres de familia.', '119');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('231', '29', 'Promueve y coordina eficientemente el programa de acción social universitario, asegurando su función formativa alineada a nuestra misión.', '120');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('232', '29', 'Propicia y alienta un ambiente propositivo que promueve el desarrollo de nuestra \"identidad católica\" entre alumnos, egresados y personal en general.', '121');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('233', '29', 'Vigila debidamente que las actividades se realicen de acuerdo a la normatividad vigente.', '122');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('234', '29', 'Recauda con éxito fondos y bienes para programas de ayuda para zonas de desastre.', '123');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('235', '29', 'Coordina eficientemente brigadas y proyectos especiales que surjan como resultado del apoyo de la comunidad u iversitaria ante grandes desastres (huracanes, inundaciones, incendios, etc.).', '124');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('236', '29', 'Mantiene un registro actualizado de las fundaciones o instituciones de asistencia social en las que los alumnos puedan realizar su actividad.', '125');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('237', '29', 'Promueve,coordina y administra satisfactoriamente el proceso de Servicio Social de los alumnos.', '126');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('238', '29', 'Da tutorías, apoyo y orientación adecuada a los alumnos que se encuentran realizando su servicio social.', '127');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('239', '29', 'Promueve con éxito a nuestros estudiantes ante las instituciones altruistas o de beneficiencia creando espacios que permiten que nuestros alumnos realicen su servicio social.', '128');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('240', '29', 'Define apropiadamente las políticas y lineamientos que deben cumplir las empresas, instituciones o fundaciones que buscan cubrir sus necesidades de recursoso humanos, con apoyo de los alumnos de la Universidad.', '129');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('241', '30', 'Entrena con exigencia y disciplina a los equipos que le sean asignados.', '130');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('242', '30', 'Selecciona adecuadamente a los integrantes para los equipos según categorías y habilidades de los candidatos.', '131');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('243', '30', 'Establece programas y rutinas de entrenamiento personal y grupal que mejoran el desempeño deportivo.', '132');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('244', '30', 'Vigila consistentemente que se lleven a cabo las rutinas de calentamiento para la prevención de lesiones.', '133');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('245', '30', 'Colabora con el Coordinador en el diseño y elaboración de programas de entrenamiento para los equipos representativos.', '134');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('246', '30', 'Promueve con éxito partidos de competencia entre equipos de diferentes facultades, entre equipos de empleados de diferentes áreas y con equipos externos.', '135');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('247', '30', 'Vigila que se de buen uso de las instalaciones.', '136');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('248', '30', 'Vigila de manera permanenete que se cuente con apoyo médico y arbitraje adecuado en los partidos que se realicen.', '137');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('249', '30', 'Coordina satisfactoriamente actividades con entidades gubernamentales y privadas que promuevan el deporte juvenil.', '138');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('250', '30', 'Apoya con eficiencia en la coordinación de viajes cuando sea necesario.', '139');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('251', '31', 'Apoya satisfactoriamente al desarrollo de el Plan Estratégico y Presupuesto Anual del área a corto, mediano y pargo plazo y supervisa su aplicación.', '140');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('252', '31', 'Apoya con eficiencia al Vicerrector o Director en el seguimiento a los objetivos del área.', '141');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('253', '31', 'Elabora en tiempo y forma informes sobre la operación del área e informa a su superior de las actividades realizadas.', '142');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('254', '31', 'Recibe y direcciona adecuadamente la documentación interna dirigida al Vicerrector o Director.', '143');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('255', '31', 'Atiende con actitud de servicio a personas internas que requieran apoyo de su jefe inmediato.', '144');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('256', '31', 'Analiza con eficiencia diversos asuntos recibidos dando: solución directa, elabora una propuestas o delega los asuntos al área correspondiente.', '145');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('257', '31', 'Da seguimiento a los asuntos, y en su caso participa activamente cuando se requiere.', '146');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('258', '31', 'Atiende los asuntos que su jefe le delegue y lo representa dignamente en actividades especiales.', '147');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('259', '31', 'Maneja apropiadamente las comunicaciones del Vicerrector o Director, tanto interna como externamente.', '148');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('260', '31', 'Apoya al Vicerrector o Director en la implementación, seguimiento y control de las iniciativas de la Red Anáhuac.', '149');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('261', '32', 'Atiende con actitud de servicio al personal de la Institución en todo lo referente a recursos humanos.', '150');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('262', '32', 'En forma conjunta con el área de finanzas,apoya con eficacia en los procesos de liquidación y finiquito del personal.', '151');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('263', '32', 'Apoya satisfactoriamente en el proceso de reclutamiento y selección al personal.', '152');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('264', '32', 'Recibe, revisa y registra en tiempo y forma las incidencias de la nómina,impuestos, IMSS, entre otras.', '153');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('265', '32', 'Da el seguimiento adecuado a la entrega de documentación del personal respecto a títulos y certificados de estudios o cursos de capacitación.', '154');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('266', '32', 'Apoya eficientemente en eventos de integración (día de la madre, día del maestro, cumpleaños, posada, etc).', '155');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('267', '32', 'Apoya en la elaboración de estadísticas y reportes útiles que dan seguimiento a los objetivos y proyectos del área.', '156');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('268', '32', 'Apoya debidamente a la Gerencia en los procesos de evaluación del personal.', '157');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('269', '32', 'Apoyo en los procesos de certificación y acreditación ante entidades públicas y privadas (FIMPES entre otras).', '158');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('270', '32', 'Conocimiento y apoyo constante a los objetivos del área y la misión institucional.', '159');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('271', '33', 'Asesora debidamente a los maestros en la estructuración y/o actualización de los programas correspondientes a las distintas asignaturas del ciclo clínico.', '160');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('272', '33', 'Asegura que los maestros entreguen el programa desglosado de las asignaturas del ciclo anterior.', '161');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('273', '33', 'Apoya con eficiencia en la búsqueda de los campos clínicos idóneos.', '162');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('274', '33', 'Supervisa el programa de avance académico de cada materia de cada sede hospitalaria y en el adecuado desarrollo de los cursos complementarios.', '163');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('275', '33', 'Realiza reuniones debidamente programadas con los titutales de las asignaturas,después de cada periodo de exámenes parciales.', '164');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('276', '33', 'Fija el sistema de evaluación por módulo en conjunto con los maestros del ciclo, aplica y evalúa los exámenes de cada módulo.', '165');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('277', '33', 'Da a conocer la forma, tipo y manera de evaluar de cada profesor de forma anticipada permitiendo que tanto alumnos como maestros puedan agendar con anticipación sus fechas de exámenes.', '166');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('278', '33', 'Completa satisfactoriamente la evaluación del personal docente y comunica los resultados de dicha evaluación con el fin de mejorar la calidad de los mismos.', '167');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('279', '33', 'Motiva con éxito la realización y participación de los alumnos en eventos especiales como: Misiones Médicas, Jornadas de Salud, Seminario de Bioética, entre otras.', '168');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('280', '33', 'Solicita en tiempo y forma a los maestros de ciclo clínicos el banco de reactivos necesarios para estructurar la evaluación final.', '169');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('281', '34', 'Elabora el contenido de sus clases con información actualizada en base al programa académico establecido y autorizado por las autoridades académicas correspondientes.', '170');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('282', '34', 'Establece una interacción positiva con los alumnos facilitando el aprendizaje y la formación integral del estudiante.', '171');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('283', '34', 'Prepara y aplica en tiempo y forma los exámenes para la valoración del aprendizaje de su materia.', '172');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('284', '34', 'De manera permenente busca continuar con su formación profesional y docente.', '173');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('285', '34', 'Participa activamente en cursos o seminarios que le sean asignados y/o programados por el área de formación docente.', '174');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('286', '34', 'Atiende y da seguimiento oportuno a las inquietudes de los alumnos.', '175');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('287', '34', 'Se asesora con la autoridad correspondiente para la pronta solución de problemas de sus alumnos.', '176');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('288', '34', 'Utiliza eficientemente la tecnología como apoyo dela práctica docente.', '177');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('289', '34', 'Realiza con eficiencia el seguimiento académico y personal de sus alumnos tutoriados.', '178');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('290', '34', 'Entrega informes útiles de seguimiento al Director de su escuela.', '179');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('291', '35', 'Establece contacto permanente con los usuarios obteniendo retroalimentación acerca de los servicios que se proporcionan.', '180');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('292', '35', 'Supervisa eficientemente el funcionamiento y desarrollo de los módulos de circulación y Opac Web del sistema de administración de biblioteca.', '181');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('293', '35', 'Coordina y supervisa debidamente las actividades referentes a la organizacipon, control, prestación, difusión de servicios y recursos de la biblioteca.', '182');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('294', '35', 'Establece de manera continua contactos con Instituciones logrando convenios de cooperación bibliotecaria.', '183');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('295', '35', 'Coordina reuniones periódicas con el personal del área y mantiene una constante comunicación con los miembros de la misma.', '184');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('296', '35', 'Presenta con éxito planes y programas de trabajo y vigila su cumplimiento.', '185');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('297', '35', 'Apoya satisfactoriamente en la elaboración del programa anual de la biblioteca.', '186');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('298', '35', 'Organiza y mantiene actualizados los sistemas y procedimientos del área.', '187');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('299', '35', 'En forma cconjunta con el jefe de área, elabora el presupuesto anual de operación del área y presenta reportes periódicos de avance.', '188');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('300', '35', 'Participa activamente en las visitas guiadas para usuarios de la biblioteca.', '189');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('301', '36', 'Garantiza la correcta operación del SIU de los sistemas (SW) institucionales asignados al área.', '190');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('302', '36', 'Proporciona a la Comunidad Universitaria la información necesaria localizada en el SIU y en otros sistemas (SW) institucionales asignados al área, para la operación de sus áreas de trabajo.', '191');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('303', '36', 'Canaliza y da seguimeinto hasta su solución a los problemas relacionados con la División de Universidades, así como da respuesta de ello a la Comunidad Universitaria.', '192');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('304', '36', 'Genera en tiempo y forma la información requerida por los usuarios a través de reportes.', '193');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('305', '36', 'Procura la entera satisfacción de todos los usuarios,promoviendo la comunicación y estando atento a sus necesidades.', '194');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('306', '36', 'Mantiene sus procedimientos con estándares elevados de seguridad para su correcta operación.', '195');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('307', '36', 'Cuenta con mecanismos de evaluación (encuestas, entrevistas,etc) que le permiten monitorear el grado de satisfacción de sus clientes.', '196');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('308', '36', 'Reporta oportunamente los resultados del área y el nivel de satisfacción de sus clientes tomenado las medidas necesarias.', '197');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('309', '36', 'Apoya eficientemente a la División de Universidades y AGS (Área Global de Sistemas), en los procesos de implementación, dimensionamiento y migración.', '198');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('310', '36', 'Trabaja en forma conjunta con la División de Universidades y AGS, en la actualización de las versiones de Banner y de cualquier otro sistema (SW) institucional que opera en la Universidad.', '199');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('311', '37', 'Controla y supervisa adecuadamente los registros de gastos mensuales de cada área.', '200');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('312', '37', 'Revisa eficaz y continuamente los gastos reales vs. presupuestados.', '201');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('313', '37', 'Mantiene actualizado el sistema de asignación y seguimiento del ejercicio presupuestal.', '202');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('314', '37', 'Elabora en tiempo y forma los reportes mensuales de gastos.', '203');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('315', '37', 'Realiza adecuadamente las evaluaciones financieras.', '204');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('316', '37', 'Revisa de manera consistente las solicitudes de gastos para asegurar la suficiencia de fondos.', '205');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('317', '37', 'Mantiene actualizado el presupuesto de sueldos y salarios de la Institución.', '206');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('318', '37', 'Monitorea continuamente los ingresos y egresos de cada una de las áreas.', '207');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('319', '37', 'Genera de manera constante información estadística útil y proyecciones.', '208');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('320', '37', 'Apoya con actitud de servicio a las áreas en la elaboración y seguimiento de sus presupuestos.', '209');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('321', '38', 'Contacta y selecciona proveedores gestionando los trámites de compras que se autoricen e investiga la costeablilidad y valor de los artículos que se adquieren.', '210');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('322', '38', 'Integra y maneja con eficiencia el consecutivo de compras.', '211');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('323', '38', 'Administra debidamente la cartera de proveedores.', '212');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('324', '38', 'Controla adecuadamente las órdenes de entrega a almacén por concepto de compras autorizadas.', '213');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('325', '38', 'Recaba en tiempo y forma las facturas o comprobantes fiscales correspondientes a las compras realizadas. ', '214');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('326', '38', 'En conjunto con las autoridades correspondientes, implementa las políticas y procedimientos de compras, así como su difusión y cumplimiento de los mismos.', '215');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('327', '38', 'Da el seguimiento adecuado a convenios y contratos realizados.', '216');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('328', '38', 'Gestiona y da el debido seguimiento a garantías de productos o servicios adquiridos por el área.', '217');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('329', '38', 'Elabora reportes e información estadística útil para el área.', '218');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('330', '38', 'Desarrolla y capacita adecuadamente al personal de su área.', '219');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('331', '39', 'Supervisa y realiza con eficiencia los registros de operaciones económicas, contables y financieras de la Institución de acuerdo a los lineamientos y políticas establecidas.', '220');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('332', '39', 'Aplica o registra con precisión las operaciones económicas de la Universidad.', '221');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('333', '39', 'Efectúa los pagos fiscales y tributarios, cumpliendo en todo momento con las obligaciones fiscales.', '222');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('334', '39', 'Elabora y presenta con puntualidad la declaración anual y los estados financieros.', '223');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('335', '39', 'Da un adecuado seguimiento a las auditorías y dictámenes contables que ', '224');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('336', '39', 'Cumple debidamente con el pago de obligaciones gubernamentales IMSS, ISPT, INFONAVIT.', '225');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('337', '39', 'Registra con precisión las operaciones diarias de bancos, manteniendo actualizados los saldos e informando diariamente al Contralor y Vicerrector de Administración y Finanazas.', '226');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('338', '39', 'Vigila que los pagos de nómina se efectúen correcta y oportunamente.', '227');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('339', '39', 'Efectúa eficientemente el registro contable de pólizas derivadas de las nóminas de empleados y profesores.', '228');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('340', '39', 'Verifica con exactitud los registros auxiliares,mayor y balance mensual de saldos.', '229');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('341', '40', 'Genera y mantiene actualizada la lista de sujetos de crédito y sus montos correspondientes.', '230');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('342', '40', 'Verifica el cumplimiento de los vencimientos de todos los acuerdos de crédito.', '231');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('343', '40', 'En base a los lineamientos y políticas establecidas, facilita el apoyo financiero a los alumnos que lo requieran,dando seguimiento oportuno al pago de financiamiento y becas.', '232');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('344', '40', 'Analiza pertinentemente los créditos educativos que se van a otorgar y los presenta ante las autoridades.', '233');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('345', '40', 'Atiende con actitud de servicio a alumnos y padres de familia sobre temas de becas y financiamientos.', '234');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('346', '40', 'Fomenta con éxito un ambiente de cumplimiento en los temas de crédito.', '235');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('347', '40', 'Elabora y concilia con precisión los movimientos contables que afecten el área.', '236');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('348', '40', 'Controla eficientemente la cobranza y emite reportes de alumnos morosos.', '237');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('349', '40', 'Elabora y propone a sus superiores, planes de pago de alumnos con dificultades.', '238');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('350', '40', 'Da seguimiento correcto y oportuno a los pagos de financiamiento y becas.', '239');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('351', '41', 'Coordina adecuadamente al servicio de mantenimiento y limpieza de la Institución.', '240');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('352', '41', 'Coordina el servicio del conmutador y atiende las necesidades del personal de inmediato.', '241');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('353', '41', 'Supervisa y da el seguimiento apropiado al servicio de vigilancia y jardinería de la Institución.', '242');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('354', '41', 'Propone y realiza programas de mantenimiento preventivo y de seguridad para todas las áreas de la Institución.', '243');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('355', '41', 'Apoya con recurso y logística a los departamentos que así lo soliciten para la realización de eventos.', '244');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('356', '41', 'Coordina con eficiencia los servicios médico,de recolección y entrega de documentos (mensajería interna) entre las diferentes áreas de la Institución.', '245');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('357', '41', 'Coordina adecuadamente a los proveedores en las remodelaciones, adecuaciones, ampliaciones de instalaciones y mobiliario.', '246');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('358', '41', 'Efectúa diariamente sesiones con los responsables directos de las áreas bajo su cargo y selectivamente todos los días efectúa recorridos de supervisión y muestro de cumplimiento de servicios.', '247');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('359', '41', 'Elabora políticas y procedimientos de operación propias de su área y reportes sobre los resultados obtenidos.', '248');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('360', '41', 'Supervisa, evalúa y capacita debidamente al personal a su cargo.', '249');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('361', '42', 'Realiza apropiadamente las actividades que su jefe le asigne,apoyando al área en tareas o proyectos especiales.', '250');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('362', '42', 'Apoya eficientemente en la programación y aplicación de exámenes de los diferentes cursos.', '251');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('363', '42', 'Apoya en los procesos de evaluación y auditoría del área, para comprobar y asegurar el buen funcionamiento de la misma. ', '252');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('364', '42', 'Apoya de manera servicial en la comunicación a profesores y alumnos sobre horarios, programación académica,etc.', '253');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('365', '42', 'Da atención personal a los alumnos y los apoya para resolver problemas que puedan surgir en la selección de clases o en cualquier otra actividad que realice el área.', '254');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('366', '42', 'Da atención personalizada a profesores canalizando a las instancias correspondientes inquietudes o problemas planteados por los mismos.', '255');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('367', '42', 'Apoya con eficiencia en la búsqueda de candidatos y en la integración de expedientes de personas que se vayan a incorporar como profesores ya sea de planta u honorarios.', '256');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('368', '42', 'Vigila que tanto alumnos como profesores cumplan con los lineamientos y procedimientos establecidos, alertando a su superior sobre desviacioneso anomalías.', '257');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('369', '42', 'Propone y desarrolla propuestas de mejora que cumplan con los objetivos del área.', '258');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('370', '42', 'Busca su desarrollo y crecimiento personal capacitándose en tareas y funciones propias de su área.', '259');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('371', '43', 'Mantiene estrecha relación con la Secretaría de Educación Pública (SEP) para la autenticación y legalización de documentos.', '260');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('372', '43', 'Gestiona debidamente ante la SEO las revisiones de estudios.', '261');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('373', '43', 'Está al tanto de nuevas disposiciones oficiales e informa oportunamente de las mismas.', '262');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('374', '43', 'Recibe con amabilidad los documentos necesarios de parte de los estudiantes para realizar los trámites.', '263');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('375', '43', 'Conoce y difunde eficientemente información relevante de los procesos de titulación tanto a los académicos como a los estudiantes.', '264');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('376', '43', 'Asesora a los estudiantes en la realización de sus trámites de titulación.', '265');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('377', '43', 'Redacta y programa las actas de los exámenes profesionales de manera adecuada.', '266');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('378', '43', 'Efectúa con precisión el proceso de revisión de estudios sobre los antecedentes escolares y la trayectoria académica de los estudiantes, para iniciar su proceso de titulación.', '267');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('379', '43', 'Emite en tiempo y forma la convocatoria controlando el registro de candidatos a obtener el título profesional.', '268');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('380', '43', 'Elabora y controla con eficiencia la información estadística que se genera en el área. ', '269');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('381', '44', 'Detecta áreas de oportunidad para la promoción universitaria y participa en la realización de planes de acción correspondientes.', '270');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('382', '44', 'Cumple con las metas de captación de matrícula de nuesvos ingresos de acuerdo a las establecidas por: colegios meta y carreras asignadas.', '271');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('383', '44', 'Orienta de manera personal a los preuniversitarios en sus necesidades de información para la elección de universidad y les da seguimiento logrando su inscripción a algún programa de licenciatura.', '272');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('384', '44', 'Difunde y gestiona los diversos esquemas de becas y apoyos económicos para asegurar que los alumnos de alto potencial académico y/o humano, se logren incorporar a la Universidad.', '273');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('385', '44', 'Promueve en el segmento meta de preuniversitarios, las ventajas competitivas que ofrece la Universidad y la Red Anáhuac a través de diversas estrategias y actividades.', '274');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('386', '44', 'Persuade a través de presentaciones en grupo o individual sobre los beneficios qu', '275');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('387', '44', 'Mantiene, cuida y eleva el prestigio de la imagen de las Universidades de la Red Anáhuac, a través de un código de valores, de discurso, de atención y de vestimenta.', '276');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('388', '44', 'Fomenta las relaciones institucionales con las preparatorias meta, mediante un programa de acercamiento y de servicio permanente, y a través de los alumnos egresados de las mismas.', '277');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('389', '44', 'Organiza actividades que faciliten el acercamiento de preuniversitarios a las diversas licenciaturas y que permitan que conozcan las instalaciones y servicios.', '278');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('390', '44', 'Orienta adecuadamente a estudiantes foráneos en todo lo relacionado con trámites de ingreso y programas que ofrecen las Universidades de la Red.', '279');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('391', '45', 'Entrevista a los solicitantes de beca y determina en base a políticas y mediante un estudio socieconómico adecuado, si la ayuda económica solicitada es necesaria y viable.', '280');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('392', '45', 'En coordinación con el Jefe de Admisiones,valora dedidamente a los aspirantes a becas turnando la información de los candidatos a las instancias correspondientes (Comité de Becas o su equivalente).', '281');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('393', '45', 'Analiza la situación académica de cada candidato y propone a los candidatos idóneos en base a los lineamientos y políticas establecidas por las autoridades.', '282');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('394', '45', 'Brinda de manera servicial la información a los candidatos acerca de los requisitos para solicitud de beca y crédito educativo.', '283');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('395', '45', 'En conjunto con los asesores preuniversitarios,promueve con éxito las becas y apoyos entre los candidatos a ingresar a la Universidad.', '284');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('396', '45', 'Apoya y da seguimiento a los candidatos en el trámite y elaboración de documentos para el otorgamiento de becas y financiamientos.', '285');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('397', '45', 'Supervisa eficientemente que los becados cumplan con los compromisos que aceptaron.', '286');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('398', '45', 'Da el correcto y continuo seguimiento a los beneficiarios de crédito educativo o becas en lo que se refiere al cumplimiento de requisitos para el otorgamiento continuado del mismo.', '287');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('399', '45', 'Informa satisfactoriamente a las áreas de administración y finanzas sobre c´reditos educativos, turnando la información correspondiente', '288');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('400', '45', 'Genera en tiempo y forma información estadística del área.', '289');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('401', '46', 'Administra en forma óptima, el único punto de contacto para prospectos y alumnos de la Universidad, ofreciendo sus servicios de manera presencial, web y telefónicamente.', '290');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('402', '46', 'Maximiza los servicios y productos que se ofrecen con el menor gasto posible, logrando altos niveles de sinergias con las diferentes áraes de la Universidad.', '291');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('403', '46', 'Logra y mantiene sinergias con las áreas de admisión, becas, finanzas, proveedores y cualquier prestador de servicios que este relacionado con productos demandados por loa alumnos/prospectos.', '292');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('404', '46', 'Posiciona con éxito a la coordinación de atención a alumnos como un área líder de calidad y servicios en la Comunidad Universitaria.', '293');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('405', '46', 'Genera mediaciones y estadísticas que permiten monitorear el nivel de satisfacción en el servicio proporcionado y reporta resultados en forma periódica a la dirección.', '294');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('406', '46', 'Firma acuerdos y documenta procesos operativos con las áreas relacionadas al servicio dentro de la Institución y le da seguimiento.', '295');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('407', '46', 'Desarrolla procesos estandarizados que optimizan los recursos del área sin demeritar los niveles de servicio ofrecidos.', '296');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('408', '46', 'Da segumiento a problemas críticos o situaciones especiales apoyando al personal de su área en la resolución de conflictos.', '297');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('409', '46', 'Monitorea continuamente los resultados obtenidos buscando la mejora continua y la búsqueda de mejores prácticas del mercado, en lo que a atención a clientes se refiere.', '298');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('410', '46', 'Supervisa y propicia el desarrollo y capacitación del personal del área para que cumpla satisfactoriamente con su función.', '299');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('411', '47', 'Mantiene una estrecha comunicación con su jefe sobre todos los aspectos del cargo que influyen directa o indirectamente en el cumplimiento de la Misión de la Universidad.', '300');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('412', '47', 'Organiza y mantiene actualizados los sistemas y procedimientos del área.', '301');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('413', '47', 'Apoya al Director del área en el desarrollo del Plan Estratégico a corto, mediano y largo plazo, de acuerdo con el Plan Estratégico de la Universidad, coordinando la elaboración de los planes y programas anuales de trabajo y dando el seguimiento adecuado.', '302');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('414', '47', 'Promueve y difunde la misión de \"identidad católica\" de la institución, actuando con rectitud y congruencia en todas las actividades asignadas a su cargo.', '303');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('415', '47', 'Conoce y apoya satisfactoriamente los proyectos, objetivos y misión del área en la que desempeña sus funciones.', '304');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('416', '47', 'Conoce a los clientes y proveedores de servicio del área en la que trabaja y ofrece una calidad de atención adecuada y oportuna.', '305');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('417', '47', 'Busca continuamente su desarrollo y crecimiento personal capacitándose en tareas y funciones propias del área.', '306');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('418', '47', 'Apoya satisfactoriamente en proyectos especiales, así como en tareas de grupo que puedan no estar relacionadas directamente con sus funciones cotidianas.', '307');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('419', '47', 'Alerta al jefe inmediato superior sobre problemas o dificultades detectadas en el área.', '308');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('420', '47', 'Propone y desarrolla propuestas de mejora que cumplan con los objetivos del área.', '309');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('421', '48', 'Realiza con eficiencia tareas de captura, redacción de documentos, archivo y organización de eventos; control de agenda, control de viajes y en general apoya al área en todo lo referente a cuestiones administrativas.', '310');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('422', '48', 'Atiende con actitud de servicios a usuarios, personal del área, proveedores y prestadores de servicio.', '311');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('423', '48', 'Apoya en tiempo y forma al control de gastos, elaboración de reportes de viaje y reservaciones.', '312');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('424', '48', 'Lleva a cabo una adecuada recepción y registro de documentos recibidos y enviados por el área.', '313');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('425', '48', 'Realiza la recepción, registro y direccionamiento de llamadas con eficiencia y actitud de servicio.', '314');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('426', '48', 'Solicita y administra en el tiempo y forma requerido: papelería, artículos de oficina, caja chica, suministros para operación de equipos de computación etc.', '315');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('427', '48', 'Ejecuta debidamente los trámites de pago a proveedores.', '316');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('428', '48', 'Tiene un adecuado conocimiento de los objetivos del área y apoya la misión de la institución.', '317');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('429', '48', 'Apoya con diligencia en la organización de juntas y eventos del área.', '318');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('430', '48', 'Mantiene un adecuado control y orden del archivo.', '319');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('431', '49', 'Alerta a sus superiores sobre fallas o problemas que requieran los servicios del área de mantenimiento o jardinería.', '320');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('432', '49', 'Realiza mantenimiento preventivo y correctivo a las instalaciones de la institución.', '321');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('433', '49', 'Atiende los requerimiento de reparación, corrigiendo el daño en el menor tiempo.', '322');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('434', '49', 'Solicita con anticipación los materiales que se requieran para los trabajos a realizar.', '323');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('435', '49', 'Ejecuta con eficiencia las actividades a realizar diariamente del área con el reporte correspondiente.', '324');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('436', '49', 'Propone al jefe del área las mejoras que considere pertinentes para cumplir con las responsabilidades asignadas.', '325');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('437', '49', 'Conoce los objetivos del área y la misión de la institución.', '326');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('438', '49', 'Realiza actividades de apoyo dentro del área ', '327');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('439', '49', 'Conoce y lleva acabo los sistemas de seguridad de la institución.', '328');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('440', '49', 'Cuida del buen uso de los equipos y herramientas que se le asignen.', '329');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('441', '50', 'Promueve activamente el desarrollo de nuestra misión e \"identidad católica\" especialmente en las actividades relacionadas con la formación humana de los alumnos.', '330');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('442', '50', 'Ofrece un servicio de atención personalizada en lo espiritual y humano a toda la comunidad universitaria.', '331');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('443', '50', 'Realiza permanentemente actividades complementarias de formación humana y religiosa.', '332');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('444', '50', 'Preside de manera permanente y logra aumentar la asistencia de alumnos a las siguientes actividades: misas, confesiones, retiros, misiones, etc.', '333');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('445', '50', 'Promociona actividades propias del área por medio de posters, trípticos, visitas, etc.', '334');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('446', '50', 'Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.', '335');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('447', '50', 'Coordina eficientemente la acción apostólica.', '336');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('448', '50', 'Encausa las inquietudes humanitarias y apostólicas de la comunidad universitaria.', '337');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('449', '50', 'Organiza encuentros de reflexión y seminarios o cursos de formación.', '338');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('450', '50', 'Revisa al término de cada actividad de formación una evaluación de los resultados obtenidos para alinear aspectos que sean necesarios.', '339');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('451', '51', 'Alcanza las metas de crecimiento de la matrícula de la licenciatura que solicite la Institución de acuerdo al Plan de Mercadotécnia Estratégica que desarrolla anualmente.', '340');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('452', '51', 'Desarrolla y da seguimiento al Plan Estratégico y de Presupuesto del área a corto, mediano y largo plazo de acuerdo al Plan Estratégico de la Universidad asegurando su cumplimiento.', '341');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('453', '51', 'Tiene un conocimiento objetivo del mercado en que participa la institución, y logra traducirlo traducirlo en un plan integral de mercadotecnia y promoción.', '342');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('454', '51', 'Planea, coordina y evalúa de manera constante los cursos de capacitación para profesores de preparatoria, asesores preuniversitarios, directores y coordinadores de promoción de escuelas y facultades.', '343');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('455', '51', 'Coordina los servicios de Orientación Vocacional de la Universidad para la decisión de admisión de alumnos y otorga un servicio al público con la finalidad de detectar prospectos con el perfil ideal.', '344');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('456', '51', 'Garantiza los medios y aplicación de criterios para elevar la calidad en el perfil de alumnos admitidos.', '345');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('457', '51', 'Organiza eventos de promoción y atención dirigidos a nuestros mercados meta, buscando una mejora continua en los mismos.', '346');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('458', '51', 'Atiende de manera personalizada y con altos estándares de servicio a preparatorias meta, candidatos y solicitantes para los programas de licenciatura.', '347');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('459', '51', 'Dirige los esfuerzos del departamento de becas para asegurar el mayor número de preuniversitarios con un alto perfil académico y humano.', '348');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('460', '51', 'Desarrolla y analiza reportes estadísticos de utilidad para diversas áreas y escuelas.', '349');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('461', '52', 'Proporciona información financiera, clara, veraz y oportuna a las autoridades.', '350');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('462', '52', 'Analiza y evalua desde el punto de vista financiero, tanto los proyectos ya existentes como los nuevos que se propongan y realiza informes y propuestas a las autoridades.', '351');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('463', '52', 'Controla e informa mensualmente sobre la afectación al presupuesto del mes y el acumulado. Realizando las propuestas de ajustes adecuadas para su cumplimiento.', '352');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('464', '52', 'Realiza estudios de aumento de cuotas y elabora su respectiva propuesta.', '353');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('465', '52', 'Atiende y da opciones de resolución a los alumnos y padres de familia con complicaciones en sus obligaciones de pago.', '354');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('466', '52', 'Elabora en el tiempo establecido el presupuesto de ingresos.Elabora en el tiempo establecido el presupuesto de ingresos.', '355');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('467', '52', 'Elabora semestralmente informe detallado sobre:\na) Gastos efectuados durante el semestre, así como de las partidas ya presupuestadas y pendientes de aplicar\nb) Cobranza.\nc) Pagos pendientes (comprometidos).\nd) Análisis comparativo de presupuesto aprobado contra presupuesto consumido.', '356');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('468', '52', 'Mantiene una estrecha comunicación con el Vicerrector de Administración y Finanzas sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.', '357');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('469', '52', 'Atiende y da opciones de resolución a los alumnos y padres de familia con complicaciones en sus obligaciones de pago.', '358');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('470', '52', 'Revisa y controla todas las declaraciones gubernamentales (IMSS, ISPT, INFONAVIT, etc), cuentas y conciliaciones bancarias,cartera de cobranza y pólizas de cheques (semanal).', '359');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('471', '53', 'Promueve activamente el desarrollo de nuestra misión e \"identidad católica\" dentro de la Institución y en especial dentro del personal de su área y alumnos.', '360');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('472', '53', 'Integra de manera eficaz la formación humanística como elemento central de la educación universitaria.', '361');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('473', '53', 'Coordina con la División de Universidades y directores de escuela el desarrollo de planes y programas para el logro de los fines institucionales en el área de formación humana.', '362');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('474', '53', 'Desarrolla continuamente los programas y materiales de las materias del área de humanidades.', '363');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('475', '53', 'Administra y coordina con eficiencia a los profesores del área:reclutamiento,asignación de grupos,evaluación, capacitación y desarrollo.', '364');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('476', '53', 'Supervisa de manera continua la oferta académica de las materias y la calidad de las cátedras impartidas de su área.', '365');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('477', '53', 'Evalúa el logro de los objetivos de las materias mediante la revisión de calificaciones y contenido de los exámenes.', '366');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('478', '53', 'Mantiene relaciones de colaboración con escuelas afines de otras instituciones académicas de prestigio nacionales y extranjeras.', '367');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('479', '53', 'Define líneas de investigación y asigna profesores de tiempo completo que determinen el alcance, tiempo y resultados esperados de la investigación.', '368');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('480', '53', 'Promueve los programas de Posgrado y Educación Contínua entre egresados y organizaciones del área.', '369');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('481', '54', 'Alcanza las metas de crecimiento de la matrícula de posgrado que solicite la Institución de acuerdo al Plan de Mercadotécnia Estratégica que desarrollada anualmente.', '370');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('482', '54', 'Desarrolla y ejecuta un adecuado Programa de Atención a Empresas e Instituciones con potencial a convertirse en clientes.', '371');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('483', '54', 'Mantiene una estrecha comunicación con el Vicerrector de Académico, Directores de Escuela, Coordinadores de Posgrados y su personal acargo.', '372');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('484', '54', 'Busca la máxima calidad dentro del aula (calidad de los profesores, metódo de enseñanza, cumplimiento del programa, participación de los alumnos, innovación en las cátedras, etc)', '373');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('485', '54', 'Realiza adecuadamente la promoción hacia los Egresados, Empresas, Instituciones privadas y gubernamentales, etc.', '374');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('486', '54', 'Vigila la correcta integración de los expedientes de los alumnos para apoyarlos en su proceso de titulación.', '375');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('487', '54', 'Supervisa continuamente la calidad académica de los cursos ofrecidos en su programa.', '376');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('488', '54', 'Atiende y resuelve con actitud de servicio las necesidades y solicitudes de los estudiantes y docentes.', '377');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('489', '54', 'Promueve activamente el desarrollo de nuestra \"identidad católica\" especialmente en las actividades relacionadas con la formación humana y académica de los alumnos.', '378');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('490', '54', 'Revisa al término de cada período escolar los resultados arrojados por los procesos de evaluación docente, monitorea la calidad académica y alinea aspectos que sean necesarios.', '379');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('491', '55', 'Coordina constantemente las actividades que mantienen actualizada la infraestructura tecnológica de cómputo, informática, comunicaciones y telecomunicacciones de la universidad.', '380');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('492', '55', 'Proporciona el equipo tecnológico necesario para la operación eficiente de las salas de cómputo.', '381');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('493', '55', 'Supervisa la adecuada prestración de servicios de soporte técnico tanto a áreas académicas como administrativas.', '382');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('494', '55', 'Planea, administra y controla los recursos materiales que garantizan la máxima disponibilidad de servicios tecnológicos a la comunidad universitaria.', '383');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('495', '55', 'Planea y administra los recursos humanos que garantizan un adecuado servicio a los alumnos.', '384');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('496', '55', 'Elabora eficientemente y da seguimiento al presupuesto anual de operación del área.', '385');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('497', '55', 'Implementa sistemas de información que agilicen los procesos acdémicos, administrativos y operativos de la Institución.', '386');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('498', '55', 'Asesora a las diferentes áreas acerca de las mejores soluciones tecnológicas para su desarrollo.', '387');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('499', '55', 'Supervisa la operación y mantenimiento eficiente de los servicios de telecomunicaciones y telefonía de la institución.', '388');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('500', '55', 'Propone soluciones tecnológicas que optimicen los recursos universitarios y coadyuden al logro de un servicio eficiente.', '389');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('501', '56', 'Obtiene y controla eficientemente la información escolar de la universidad en relación a los planes de estudio y avance escolar del alumnado de licenciatura y posgrado.', '390');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('502', '56', 'Verifica adecuadamente la autenticidad de los documentos escolares que expide la institución.', '391');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('503', '56', 'Mantiene y coordina eficientemente las labores de servicios internos, externos y auditoria escolar.', '392');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('504', '56', 'Organiza, innova y mantiene actulizada la estructura, sistemas y procedimientos del trabajo del área: Servicios Internos, Externos y Auditoria Escolar.', '393');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('505', '56', 'Vigila el cumplimiento de las políticas y lineamientos establecidos por la Universidad para la certificación, acreditaciones, programas de estudio,etc.', '394');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('506', '56', 'Dirige el adecuado intercambio de información sobre datos y registros de estudiantes en las escuelas y facultades.', '395');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('507', '56', 'Proporciona en tiempo y forma a las instituciones oficiales la información requerida sobre la operación escolar de la Universidad.', '396');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('508', '56', 'Mantiene una estrecha comunicación con el Director de Servicios Institucionales y Planeación sobre los aspectos del cargo que influyen directa o indirectamente en el cumplimiento de la Misión de la Universidad.', '397');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('509', '56', 'Presenta a su Director y al Rector las estadísticas escolares y las requeridas por organismos oficiales y extraoficiales de manera contínua y oportuna.', '398');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('510', '56', 'Supervisa de manera eficiente el desempeño de las personas a su cargo.', '399');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('511', '57', 'Constantemente logra convenios de intercambio con instituciones de enseñanza superior tanto a nivel nacional como internacional.', '400');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('512', '57', 'Mantiene relaciones con instituciones privadas, sociales y públicas que promueven actividades académicas de intercambio a nivel licenciatura y posgrado.', '401');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('513', '57', 'Participa en eventos culturales especialmente los convocados por embajadas y organizaciones internacionales logrando ampliar nuestras opciones de intercambio académico.', '402');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('514', '57', 'Coordina eficientemente los procesos de equivalencias de estudios de los alumnos de intercambio con las diferentes escuelas y servicios escolares.', '403');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('515', '57', 'Consolida los programas de intercambio académico existentes manteniendo la calidad y el prestigio logrado.', '404');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('516', '57', 'Evalúa los resultados obtenidos en los programas de intercambio e implementa programas de mejoramiento a los procedimientos existentes.', '405');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('517', '57', 'Se preocupa, promueve y se asegura de incrementar el número de estudiantes en intercambio académico internacional bidireccionalmente.', '406');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('518', '57', 'Atiende satisfactoriamente y con un sistema personalizado a los visitantes externos y alumnos de intercambio internacional para que cumplan sus objetivos.', '407');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('519', '57', 'Tiene el control y seguimiento adecuado de los alumnos que se encuentran de intercambio en otras universidades o en nuestra propia institución.', '408');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('520', '57', 'Difunde y propicia un ambiente propositivo para que las instituciones con las que mantenemos intercambio nos perciban como una universidad de \"identidad católica\" que promueve los valores.', '409');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('521', '58', 'Elabora el plan estratégico que asegure la permanencia del programa y el logro de los objetivos establecidos.', '410');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('522', '58', 'Promueve el desarrollo de nuestra \"identidad católica\" especialmente en las actividades relacionadas con el programa de liderazgo que maneja.', '411');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('523', '58', 'Busca y logra el apoyo de líderes positivos y de personalidades distinguidas en pro del beneficio social para la participación en algún evento y/o colaboración en especie para los proyectos.', '412');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('524', '58', 'En conjunto con las áreas académicas selecciona e integra a los alumnos a programas de liderazgo.', '413');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('525', '58', 'Apoya a la VFI y a la comunidad universeitaria en genral, en proyectos especiales de ayuda derivados de desastres naturales.', '414');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('526', '58', 'Escucha y canaliza las iniciativas de los estudiantes a través de los comités establecidos.', '415');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('527', '58', 'Organiza satisfactoriamente al grupo que asistirá a la Megamisión.', '416');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('528', '58', 'Al término de cada actividad realiza una evaluación de los resultados obtenidos alineando aspectos que son necesarios.', '417');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('529', '58', 'Coordina favorablemente las tutorías a los alumnos de vértice.', '418');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('530', '59', 'Elabora y controla el Plan de Desarrollo Estratégico del departamento.', '419');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('531', '59', 'De manera permanente planea y promueve encuentros deportivos internos que logran la asistencia planeada y fomentan la integración de grupos.', '420');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('532', '59', 'De manera permanente planea y promueve encuentros deportivos externos que logran la asistencia planeada y fomentan la integración de grupos.', '421');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('533', '59', 'Mantiene adecuadas relaciones con otras instituciones educativas y consejos deportivos.', '422');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('534', '59', 'Coordina y evalúa semestralmente al personal del área buscando su desarrollo y capacitación.', '423');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('535', '59', 'Supervisa y evalúa los resultados de las campañas informativas de los eventos deportivos en búsqueda de la mejora continua.', '424');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('536', '59', 'Vigila que las instalaciones y equipo para las actividades deportivas se conserven en estado óptimo de funcionamiento y uso.', '425');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('537', '59', 'Colabora de manera activa y frecuentemente con el programa de becarios, con los alumnos asignados al área de deportes.', '426');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('538', '59', 'Diseña e implementa programas y actividades que promuevan la participación deportiva de alumnos, profesores y colaboradores.', '427');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('539', '59', 'Coordina adecuadamente a los alumnos que realizan su servicio social dentro del área.', '428');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('540', '60', 'Supervisa y coordina satisfactoriamente el área académica y administrativa de los programas a su cargo.', '429');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('541', '60', 'Diseña y renueva el plan de estudios de los programas de posgrado y extensión de acuerdo a las necesidades del área.', '430');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('542', '60', 'Supervisa eficazmente la contratación docente de acuerdo al nivel requerido y los tiempos establecidos.', '431');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('543', '60', 'Realiza adecuadamente la promoción hacia los Egresados, Empresas, Instituciones privadas y gubernamentales, etc.', '432');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('544', '60', 'Realiza en tiempo y forma la programación académica del área.', '433');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('545', '60', 'Vigila la correcta integración de los expedientes de los alumnos para apoyarlos en su proceso de titulación.', '434');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('546', '60', 'Supervisa continuamente la calidad académica de los cursos ofrecidos en su programa.', '435');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('547', '60', 'Atiende con actitud de servicio las necesidades y solicitudes de los estudiantes y docentes.', '436');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('548', '60', 'Promueve activamente el desarrollo de nuestra \"identidad católica\" especialmente en las actividades relacionadas con la formación humana y académica de los alumnos.', '437');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('549', '60', 'Revisa al término de cada período escolar los resultados arrojados por los procesos de evaluación docente, monitorea la calidad académica y alinea aspectos que sean necesarios.', '438');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('550', '61', 'Organiza,coordina y supervisa permanentemente la adecuada aplicación de los procedimientos establecidos en la ejecución de la operación académica.', '439');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('551', '61', 'Cumple y hace cumplir las políticas y lineamientos definidos por superiores, así como el estatuto de la Universidad, su reglamento, planes y programas de trabajo y, en general, las dispocisiones y acuerdos que normen la estructura y funcionamiento de la universidad.', '440');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('552', '61', 'Mantiene un registro actualizado de las actividades del personal académico que se llevan acabo en la Institución y coordina la aplicación de los exámenes departamentales.', '441');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('553', '61', 'Se asegura de que la oferta académica de asignaturas sea la adecuada para la demanda de cursos de los estudiantes y acorde al avance de su plan de estudios.', '442');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('554', '61', 'Analiza y propone soluciones a los alumnos que presentan problemas académicos.', '443');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('555', '61', 'Apoya las labores de programación anual de cada dirección de escuela y verifica la correcta aplicación de los planes de estudio.', '444');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('556', '61', 'Coordina la Operación Académica, negocia requerimientos con otros sectores de la institución, elabora alteraciones del sistema en orden al mejoramiento de la eficiencia de la labor académica.', '445');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('557', '61', 'Optimiza la utilización de los espacios físicos y realiza reportes para su análisis.', '446');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('558', '61', 'Apoya las labores de programación académica de todas las escuelas y verifica la correcta aplicación de los planes de estudio. Mantiene una abierta comunicación con las Escuelas.', '447');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('559', '61', 'Apoya con eficiencia a la planeación y coordinación de eventos especiales y actividades de la licenciatura: Reconocimientos de excelencia académica, graduaciones, etc.', '448');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('560', '62', 'Apoya al Rector en el desarrollo del Plan estratégico a corto, mediano y largo plazo.', '449');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('561', '62', 'Apoya al Rector en el seguimiento a objetivos y proyectos buscando su cumplimiento de todas las áreas y vicerrectorías que dependen del Rector.', '450');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('562', '62', 'Apoya al Rector en el presupuesto anual de operación de Rectoría y supervisa el presupuesto de las áreas de los departamentos que dependen del Rector.', '451');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('563', '62', 'Atiende con actitud de servicio y continuamente a personas internas, alumnos, o padres de familia que requieren apoyo de la Rectoría.', '452');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('564', '62', 'Da seguimiento a los asuntos, y en su caso, participa activamente haciendo propuestas de solución al Rector o a los responsables de las áreas.', '453');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('565', '62', 'Participa en proyectos que el Rector encomiende, es proactivo y propositivo.', '454');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('566', '62', 'Apoya con eficiencia al Rector en la organización de reuniones que involucren tanto autoridades de la Universidad como personalidades de instituciones hermanas, empresas o entidades gubernamentales.', '455');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('567', '62', 'En general, facilita al Rector la operación de la dirección de la Universidad.', '456');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('568', '62', 'Apoya al Rector en la implementación, seguimiento y control de las iniciativas de la Red Anáhuac.', '457');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('569', '62', 'Mantiene una estrecha comunicación con el Rector sobre todos los aspectos del cargo que influyen directa o indirectamente en el cumplimiento de la Misión de la Universidad.', '458');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('570', '63', 'Realiza con eficiencia los trámites ordinarios que mantienen el reconocimiento de estudios ante las instituciones oficiales.', '459');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('571', '63', 'Prepara en los tiempos establecidos la información requerida sobre la operación escolar de la Universidad.', '460');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('572', '63', 'Da fe sin valor oficial, de los documentos que no requieren legalización, en los tiempos y casos requeridos.', '461');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('573', '63', 'Realiza y supervisa los trámites de revalidación, legalización y registro de títulos, así como la obtención de cédulas profesionales en forma y tiempo.', '462');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('574', '63', 'Por indicaciones del Director de administración escolar y normatividad, representa dignamente a la Universidad ante las instituciones gubernamentales certificadoras para la obtención de documentos de alumnos y egresados.', '463');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('575', '63', 'Ejecuta eficientemente el proceso de certificados legalizados a la SEP.', '464');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('576', '63', 'Efectúa el adecuado control y seguimiento de estudiantes extranjeros sobre la obtención y refrendo de su documentación migratoria que les permite estudiar en la Universidad.', '465');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('577', '63', 'En coordinación con las escuelas y facultades, lleva acabo con eficiencia los procedimientos de baja por: voluntaria, falta de documentos, documentación falsa o por efectos disciplinarios de los alumnos.', '466');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('578', '63', 'Elabora, analiza y controla con eficiencia la información estadística que se genera en su área.', '467');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('579', '63', 'Atiende continuamente y con actitud de servicio los procesos de consulta sobre documentos de estudiantes que formulan diversas instancias nacionales e internacionales.', '468');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('580', '64', 'Investiga, Diseña y supervisa constantemente la calidad de los asuntos académicos relacionados con el proceso de enseñanza-aprendizaje.', '469');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('581', '64', 'Asegura la calidad de las funciones universitarias empleando sistemas de evaluación y monitoreo constantes, innovadores y confiables.', '470');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('582', '64', 'Diseña y administra satisfactoriamente los procesos de evaluación de alumnos, profesores y programas educativos.', '471');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('583', '64', 'Porpone con frecuencia políticas y procedimientos que mejoran la calidad de los servicios académicos.', '472');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('584', '64', 'Evalúa y reporta semestralmente los resultados sobre la calidad del aprendizaje por parte de los alumnos y de los servicios de apoyo académico. Propone acciones de mejora con respecto a los resultados.', '473');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('585', '64', 'Se preocupa, promueve y se asegura la puntualidad y asistencia de los docentes a sus asignaturas.', '474');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('586', '64', 'Desarrolla, implementa, da seguimiento y reporta trimestralmente los resultados de los indicadores clave de desempeño institucional. Realiza propuestas de acción para mejorarlos.', '475');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('587', '64', 'Coordina y da seguimiento al desarrollo de programas de intervención educativa conducentes a la mejora de la calidad de la docencia y del aprendizaje de los estudiantes.', '476');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('588', '64', 'Evalúa y retroalimenta cada semestre el plan rector de investigación de la universidad y reporta resultados a la Dirección.', '477');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('589', '64', 'Evalúa y retroalimenta cada semestre el plan de tutorías y reporta resultados a la Dirección.', '478');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('590', '65', 'Dirige adecuadamente la elaboración, implantación y evaluación de programas de investigación de la institución de acuerdo a la misión, valores y características del entorno.', '479');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('591', '65', 'Orienta al profesorado de la institución para el logro de niveles de excelencia en el campo de la investigación.', '480');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('592', '65', 'Establece y mantiene relaciones con organismos nacionales e internacionales de acreditación.', '481');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('593', '65', 'Participa constantemente en foros nacionales e internacionales en el campo de la educación superior representando dignamente a la Institución.', '482');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('594', '65', 'Promueve la publicación de los resultados de las investigaciones realizadas vigilando que cumplan con los lineamientos de edición e imagen Institucional.', '483');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('595', '65', 'Desarrolla diversas estrategias y actividades que impulsan la investigación y enriquecen la curricula que logran avances en el conocimiento.', '484');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('596', '65', 'Mantiene un registro confiable y actualizado de los proyectos de investigación y da seguimiento a los avances obtenidos.', '485');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('597', '65', 'Proporciona a las autoridades información objetiva y relevante sobre los resultados de la investigación y presenta indicadores de desempeño que permiten valorar los avances obtenidos.', '486');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('598', '65', 'Estimula la participación activa de profesores y estudiantes en congresos, conferencias de carácter científico y tecnológico y asociaciones educativas y de apoyo a la investigación (CONACYT, FIMPES, ANUIES, NSF, entre otras).', '487');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('599', '65', 'Establece y mantiene vínculos con medios editoriales logrando la publicación de trabajos de investigación.', '488');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('600', '66', 'Atiende con actitud de servicio a los candidatos de ingreso a la Institución a nivel licenciatura.', '489');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('601', '66', 'Está en contacto continuo con los asesores preuniversitarios dando seguimiento a candidatos o prospectos.', '490');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('602', '66', 'Recibe y procesa con eficiencia las solicitudes de admisión.', '491');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('603', '66', 'Aplica y analiza satisfactoriamente los resultados de las pruebas de aptitud académica,habilidades y psicológicas realizadas a los candidatos.', '492');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('604', '66', 'Integra en los tiempos establecidos la información de exámenes de habilidades y psicológicos en los formatos y sistemas correspondientes.', '493');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('605', '66', 'Evalúa la idoneidad del candidato, propone el ingreso e incorpora nuevo alumnado a la institución.', '494');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('606', '66', 'Aconseja asertivamente la autorización o rechazo de aspirantes y turna los casos especiales a las instancias correspondientes.', '495');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('607', '66', 'Informa en tiempo y forma a los candidatos la resolución universitaria.', '496');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('608', '66', 'Elabora estadísticas útiles del proceso de admisión y facilita la información a las escuelas y facultades, en los tiempos requeridos.', '497');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('609', '66', 'Genera reportes de información para la Dirección de atención preuniversitaria y mercadotecnia, en la forma y tiempos establecidos.', '498');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('610', '67', 'Integra eficientemente los expedientes de los participantes del Programa de Complementación Académica (PCA).', '499');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('611', '67', 'Recaba permanentemente información académica, personal y de desempeño con las diferentes fuentes de información.', '500');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('612', '67', 'Da un seguimiento adecuado al desempeño de los participantes del PCA.', '501');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('613', '67', 'Actualiza continuamente los resultados de las diferentes instancias evaluadoras de los participantes del PCA.', '502');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('614', '67', 'Canaliza y da seguimiento a cada participante con el personal que le brindará la ayuda necesaria.', '503');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('615', '67', 'Analiza detalladamente cada caso y conforma el equipo de personal adecuado para sus necesidades.', '504');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('616', '67', 'Da seguimiento y hace propuestas a la evaluación del PCA.Da seguimiento y hace propuestas a la evaluación del PCA.', '505');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('617', '67', 'Analiza los puntos detectados como áreas de oportunidad y fortalezas del programa, tomando las medidas pertinentes para mejores resultados.', '506');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('618', '67', 'Genera las intervenciones que garantizan la mejora continua del PCA.', '507');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('619', '67', 'Mantiene una estrecha y constante relación con sus alumnos tutoriales y equipo de trabajo.', '508');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('620', '68', 'Realiza en tiempo y forma la programación académica de cursos de idiomas y de bloque electivo.', '509');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('621', '68', 'Desarrolla con éxito las estrategias necesarias para lograr el crecimiento del área desde un punto de vista económico y comercial.', '510');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('622', '68', 'Prepara y promociona cursos de idiomas para los estudiantes cubriendo y manteniendo el número de alumnos requeridos por grupo.', '511');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('623', '68', 'Establece y da seguimiento continuo a las políticas que determinan si un alumno se considera aprobado en cierto idioma.', '512');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('624', '68', 'Crea y mantiene un archivo actualizado de todos los alumnos, así como de su situación escolar con respecto a los requisitos de idiomas.', '513');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('625', '68', 'Publica y hace del conocimiento del alumno el resultado de sus exámenes, dándoles una adecuada retroalimentación.', '514');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('626', '68', 'Investiga,desarrolla e implementa la capacitación y actualización necesaria para el personal docente.', '515');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('627', '68', 'Actualiza continuamente los programas a través de investigación y convenios con otras instituciones.', '516');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('628', '68', 'Supervisa e implementa el desarrollo de material didáctico y técnicas de enseñanza innovadoras para los cursos.', '517');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('629', '68', 'Previene la demanda de cursos de idiomas y asegura ofrecer los cursos demandados.', '518');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('630', '69', 'Promueve la utilización de tecnología de punta en la biblioteca.', '519');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('631', '69', 'Planea, programa y supervisa constantemente la integración de un acervo bibliográfico, audiovisual y los medios tecnológicos adecuados para su uso.', '520');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('632', '69', 'Implementa nuevos servicios que permiten agilizar el acceso a la información para el alumnado y usuarios de la biblioteca.', '521');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('633', '69', 'Promueve continua y satisfactorimante la utilización óptima de los recursos bibliográficos y audiovisuales, especialmente en las labores relacionadas con la docencia y la investigación.', '522');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('634', '69', 'Organiza cada inicio de período escolar actividades para informar a la comunidad universitaria sobre los recursos y servicios de la biblioteca.', '523');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('635', '69', 'Coordina en tiempo y forma las actividades de adquisiciones, procesos técnicos y servicios al público.', '524');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('636', '69', 'Supervisa eficientemente el desempeño de las personas a su cargo buscando su capacitación y desarrollo constante.', '525');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('637', '69', 'Lleva el adecuado control del uso de los recursos financieros que se han asignado a la biblioteca.', '526');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('638', '69', 'En forma conjunta con el Director del área, elabora el presupuesto anual de operación del área y presenta reportes periódicos de avance.', '527');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('639', '69', 'Mantiene una estrecha comunicación con el Director sobre todos los aspectos a su cargo que influyen directa o indirectamente en el cumplimiento de la misión de la Universidad.', '528');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('640', '70', 'Promueve continua y dignamente a la Institución en los distintos sectores de la sociedad (egresados, industria, gobierno,etc) tanto nacional como internacional.', '529');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('641', '70', 'Recauda los fondos acordados en el presupuesto anual para el financiamiento del desarrollo de la Institución por mecanismos distintos a las colegiaturas.', '530');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('642', '70', 'Supervisa la correcta aplicación de los fondos destinados al desarrollo de la Institución de acuerdo a la asignación inicial.', '531');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('643', '70', 'Cuenta con una base de datos actualizada de los principales líderes y referencias nacionales e internacionales en los sectores de influencia.', '532');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('644', '70', 'Desarrolla acciones de promoción y presencia sistemática con la personalidades nacionales,en especial con los que son egresados o han mantenido contacto cercano con la institucion.', '533');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('645', '70', 'En conjunto con los responsables de las escuelas selecciona líderes que sean representativos de nuestros valores con el fin de poder incluirlos dentro de nuestro grupo de invitados y/o colaboradores.', '534');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('646', '70', 'Asegura la oportuna cobertura en los medios de comunicación masiva, de las visitas o eventos relevantes, que garantiza una presencia continua que identifica a la Institución como una sede de conocimeinto académico, científico y cultural.', '535');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('647', '70', 'Aprovecha contínumente las actividades tales como:inaguraciones, congresos, foros,etc., para invitar a líderes a nuestra Institución.', '536');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('648', '70', 'Representa a la Institución en los distintos sectores de la sociedad, y promueve su imagen, su oferta educativa y sus servicios.', '537');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('649', '71', 'Impulsa y supervisa adecuadamente los procesos de búsqueda, selección y reclutamiento del personal académico y administrativo de la Universidad.', '538');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('650', '71', 'Implementa y desarrolla adecuadamente la inducción, capacitación y formación del personal de la UAM.', '539');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('651', '71', 'Vela por el cumplimiento del perfil de puesto correspondiente de cada uno de los puestos.', '540');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('652', '71', 'Se asegura constantemente de que el personal tenga una adecuada integración profesional y humana a la identidad y misión de la universidad.', '541');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('653', '71', 'Vela por el cumplimiento de la estructura orgánico-funcional y hace propuestas cuando se requiere.', '542');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('654', '71', 'Velar por el cumplimiento de la disciplina laboral de acuerdo a normas y criterios vigentes y hace propuestas cuando se requiere.', '543');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('655', '71', 'Propone e implementa normas y políticas que rijen  las relaciones del personal de la Universidad.', '544');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('656', '71', 'Dirige y supervisa debidamente todas las actividades de apoyo al área de sueldos y salarios (elaboración de nóminas y pagos diversos). Realiza estudios comparativos de sueldos y compensaciones con otras universidades para proponer mejoras en las prestaciones del personal.', '545');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('657', '71', 'Coordina el proceso de evaluaciones de desempeño, clima laboral y 360°,  etc, analizando los resultados y propone acciones de la mejora continua de del ambiente y la cultura organizacional.', '546');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('658', '71', 'Ejecuta todas las medidas necesarias para dar cumplimiento a las disposiciones oficiales y legales en materia laboral y de seguridad social y custodia la documentación correspondiente', '547');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('659', '72', 'Mantiene actualizada y en orden la base de datos de los alumnos a nivel licenciatura y posgrado, desde su ingreso hasta su egreso, resguardando los archivos de datos generales, inscripción e historia académica.', '548');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('660', '72', 'Controla y certifica que la información en la base de datos sea confiable y que se suministre de manera oportuna para facilitar los procesos, asi como mantiene el sistema mecanizado para el control de avance escolar de los alumnos.', '549');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('661', '72', 'Coordina con eficacia con las diferentes áreas de la Universidad la implementación de los sistemas integrales (SIU) en base a los lineamientos, políticas y tiempos establecidos.', '550');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('662', '72', 'Conoce la legislación universitaria y establece mecanismos que aseguran su cumplimiento.', '551');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('663', '72', 'Reporta a la Dirección de administración escolar y normatividad sobre cualquier irregularidad en el proceso escolar y de casos de estudiantes que requieran un tratamiento especial y realiza propuestas para su resolución.', '552');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('664', '72', 'Controla eficazmente el seguimiento de la entrega de documentos de alumnos de nuevo ingreso.', '553');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('665', '72', 'Coordina oportunamente la ejecución de las tareas de certificación de los estudios de alumnos de nivel licenciatura y posgrados.', '554');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('666', '72', 'Planea y dirige los procesos de inscripción y reinscripción de alumnos en cuanto a su fase de selección de cursos, de los periodos académicos.', '555');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('667', '72', 'Ejecuta en tiempo y forma el procedimiento institucional de Reingreso y Bajas voluntarias y administrativas de los estudiantes.', '556');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('668', '72', 'Elabora y controla con eficiencia la información estadística que se genera en su área.', '557');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('669', '73', 'Mantiene contacto directo y constante con los diversos usuarios de la Institución, analiza sus dificultades y realiza propuestas para la mejora continua del servicio.', '558');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('670', '73', 'Coordina y participa de manera constante en la definición e implementación de los diversos procesos y procedimientos de atención y servicio.', '559');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('671', '73', 'Reporta en tiempo y forma los avances de los diversos proyectos del área.', '560');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('672', '73', 'Coordina de forma permanente la instalación de los equipos que adquiera la institución y capacita al personal que hará uso de los mismos (computadoras,impresoras,scanner,etc).', '561');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('673', '73', 'Mantiene contacto permanente con las empresas proveedoras de equipo y gestiona garantías y procesos de mantenimiento.', '562');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('674', '73', 'Mantiene en óptimas condiciones los sistemas de información.', '563');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('675', '73', 'Brinda con actitud de servicio y de manera permanente el soporte necesario a los usuarios.', '564');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('676', '73', 'Implementa sistemas de información que agilizan los procedimientos académicos, administrativos y operativos de la Institución.', '565');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('677', '73', 'En coordinación con el área de infraestructura tecnológica crea y administra a los grupos y usuarios, establece los permisos, protege la información interna como externa, internet,etc, en el tiempo y calidad requerida.', '566');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('678', '73', 'En coordinación con el área de infraestructura tecnológica verifica semanalmente el antivirus, así como la actualización de los mismos.', '567');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('679', '74', 'Supervisa constantemente que todos los servicios de cómputo ofrecidos a través de servidores centrales hacia el personal administrativo, académico y alumnos sean de excelente calidad y con tecnología de punta.', '568');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('680', '74', 'Procura y fomenta una excelente comunicación entre su equipo de trabajo y una mejora constante en la prestación de servicios que ofrece su jefatura.', '569');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('681', '74', 'Procura la entera satisfacción de todos los usuarios, promoviendo la comunicación constante y estando atento a sus necesidades.', '570');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('682', '74', 'Protege permanentemente de ataques externos e internos a la red.', '571');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('683', '74', 'Investiga y propone constamente sobre nuevas tecnologías y avances en el área de redes proponiendo mejoras.', '572');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('684', '74', 'Instala nuevos servidores y efectúa pruebas y reparación de los mismos en caso de ser necesario con un enfoque de servicio al cliente indicado por la Institución.', '573');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('685', '74', 'Lleva un adecuado y constante control y administración de los servicios de la página web de la Universidad,servicio de correo,control de impresión,etc.', '574');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('686', '74', 'Monitorea y reporta el tráfico de la red contando con estadísticas que permitan conocer el performance de la misma y se asegura de la disponibilidad, accesibilidad, velocidad y usabilidad del servicio de internet.', '575');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('687', '74', 'Apoya constantemente y con actitud de servicio a todas las áreas que lo requieren, en el mantenimiento y actualización de sus bases de datos.', '576');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('688', '74', 'Coordina con eficiencia la configuración de los equipo inalámbricos de la Universidad.', '577');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('689', '75', 'Propone, coordina y supervisa con eficiencia eventos de integración que enriquezcan la vida estudiantil de la universidad.', '578');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('690', '75', 'Establece adecuados canales de comunicación para escuchar a los estudiantes.', '579');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('691', '75', 'Monitorea los resultados de los proyectos de integración vigentes y propone a las autoridades modificaciones y/o nuevos planes.', '580');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('692', '75', 'Verifica de manera consistente que las autoridades y programas colaboren en la formación de los estudiantes.', '581');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('693', '75', 'Evalúa sistemáticamente los logros formativos de los programas ofrecidos.', '582');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('694', '75', 'Estructura programas culturales de formación así como organiza y ofrece eventos culturales de calidad para la Comunidad Universitaria.', '583');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('695', '75', 'Establece y mantiene vínculos con organismos estatales, privados, embajadas y centros extranjeros de carácter cultural.', '584');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('696', '75', 'Promueve actividades encaminadas al fortalecimiento de relaciones estudiales intrauniversitaria.', '585');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('697', '75', 'Promueve eventos culturales externos de interés para el enriquecimiento de la Comunidad Universitaria.', '586');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('698', '75', 'Coordina y apoya en los eventos de Bienvida así como en entrega de reconocimiento de alumnos.', '587');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('699', '76', 'Cumple los lineamientos institucionales y de la RED en materia de: comunicación(interna y externa), promoción, manejo de imagen y mercadotecnia.', '588');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('700', '76', 'Administra continuamente las estrategias de comunicación y mercadotecnia de acuerdo a las necesidades y objetivos de las áreas logrando cubrir ya sea el público interno y/ó externo.', '589');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('701', '76', 'De forma permanente vigila que todo lo relacionado a comunicación, medios y mercadotecnia se encuentre alineado a los lineamientos institucionales establecidos.', '590');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('702', '76', 'Colabora activamente y mantiene relaciones con otras instituciones, organismos,agencias de publicidad,diseño y relaciones públicas.', '591');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('703', '76', 'Vigila que la imagen de la Red Anáhuac se emplee de forma adecuada en todos los medios (escritos y electrónicos) asesorando adecuadamente a las áreas que desarrollen comunicaciónes internas.', '592');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('704', '76', 'Apoya eficientemente a Divisiones,Escuelas y Facultades así como a áreas administrativas en la coordinación de campañas, eventos y programas especiales dirigidos a fomentar la imagen y las relaciones internas y externas de la institución.', '593');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('705', '76', 'Publica periódicamente la información oficial de la Institución empleando los medios institucionales (internos, generales y para egresados) y cubriendo el mercado meta.', '594');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('706', '76', 'Busca con frecuencia prestadores de servicios publicitarios e integra una cartera de proveedores confiables, que permiten utilizar productos y servicios de promoción y comunicación de calidad.', '595');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('707', '76', 'Supervisa que las herramientas electrónicas empleadas para la comunicación tanto interna como extrena se encuentren a la vanguardia en tecnología y diseño visual.', '596');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('708', '76', 'Da seguimiento a las relaciones con la prensa y los medios de comunicación el cual apoya la entrega de productos y servicios solicitados con la calidad y en los tiempos establecidos.', '597');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('709', '77', 'Propicia una comunicación efectiva entre los sectores internos y externos de la Universidad para el logro de los objetivos institucionales.', '598');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('710', '77', 'Administra continuamente las estrategias de comunicación y mercadotecnia de acuerdo a las necesidades y objetivos de las áreas logrando el impacto requerido.', '599');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('711', '77', 'Vigila que todo lo competente a comunicación Medios y mercadotecnia se encuentre alineado a los lineamientos institucionales establecidos por la División de Universidades.', '600');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('712', '77', 'Representa a la Universidad ante los medios de comunicación social en dependencia del Rector.', '601');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('713', '77', 'Se asegura de cuidar la imagen de la Universidad en el exterior (página web, eventos, medios masivos de comunicación, etc).', '602');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('714', '77', 'Mantiene una fuerte y productiva relación con todos los directivos de la Institución para apoyar proyectos de comunicación y mercadotecnia institucional.', '603');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('715', '77', 'Colabora con firmas externas, relaciones públicas, diseños y comunicación para ejecutar estrategias y acciones.', '604');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('716', '77', 'Asesora y coordina las estrategias específicas de los coordinadores del área buscando un adecuado desempeño.', '605');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('717', '77', 'Busca continuamente tener presencia en medios que sumen a la buena imagen de la Universidad.', '606');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('718', '77', 'Desarrolla y da seguimiento al Plan Estratégico y de Presupuesto del área a corto, mediano y largo plazo de acuerdo al Plan Estratégico de la Universidad asegurando su cumplimiento.', '607');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('719', '78', 'Realiza eficientemente todas las funciones de coordinación académica y administrativa del programa(s) a su cargo,promoviendo la misión y valores universitarios.', '608');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('720', '78', 'Se coordina adecuadamente con el Director del área en la selección y contratación del personal académico de acuerdo al perfil y en los tiempos establecidos.', '609');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('721', '78', 'Apoya constantemente las labores de promoción hacia los diversos públicos: preparatorias,egresados, empresas instituciones privadas y gubernamentales entre otros.', '610');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('722', '78', 'Supervisa continuamente la calidad de las cátedras impartidas alineando los planes y programas a lo establecido en la División o escuela.', '611');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('723', '78', 'Atiende continuamente y con actitud de servicio las necesidades de los estudiantes y docentes,proponiendo soluciones.', '612');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('724', '78', 'Apoya las tutorías y vigila de manera constante que se apliquen a alumnos que manifiestan alguna inquietud y a los que presentan bajo desempeño.', '613');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('725', '78', 'Revisa al término de cada período escolar los resultados arrojados por los procesos de evaluación docente para monitorear la calidad académica y alinear aspectos que sean necesarios.', '614');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('726', '78', 'Cuida de manera consistente de la óptima utilización de los recursos tanto humanos como materiales asignados a sus programas.', '615');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('727', '78', 'Cumple y hace cumplir las políticas y lineamientos definidos por los superiores y en general las disposiciones y acuerdos que normen la estructura y funcionamiento de la Universidad.', '616');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('728', '78', 'Promueve de manera continua la integración efectiva del personal y de los alumnos.', '617');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('729', '79', 'Formula e implementa el plan estratégico de emprendimiento e innovación,alineándolo al presupuesto de la Universidad, los programas de desarrollo del estado y/o de la región para que las actividades sean pertinentes a las necesidades del entorno y contribuir al posicionamiento del parque.', '1');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('730', '79', 'Negocia con eficiencia los recursos económicos que destinan las instituciones de gobierno a los proyectos de incubación, aceleración y consultoría en innovación con la finalidad de apoyar al sector empresarial para un menor desembolso de sus recursos y a su vez garantizar un ingreso mínimo de recursos para la Universidad en el año.', '2');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('731', '79', 'Define adecuadamente las estrategias de selección de proveedores, colaboradores externos, acelerados, incubados, empresas e inquilinos del parque, con base en los criterios aprobados por las autoridades de la Universidad para garantizar la operación del parque.', '3');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('732', '79', 'Proyecta el crecimiento de las instalaciones del parque tecnológico y sus servicios, promocionando las instalaciones y servicios ofrecidos para posicionarlo de forma nacional e internacional en el sector empresarial, académico y gubernamental.', '4');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('733', '79', 'Representa a la Universidad en foros, reuniones, viajes, comidas y eventos organizados por gobierno, cámaras y el sector privado, estableciendo relaciones, identificando posibles clientes y/o colaboradores que permitan establecer otras vinculaciones que beneficien a la Universidad en esta área u otras áreas.', '5');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('734', '79', 'Coordina y alinea las prioridades establecidas por la rectoría en materia de emprendimiento e innovación con diferentes áreas de la Universidad, para generar continuidad entre la adquisición del conocimiento en el aula y la aplicación del mismo.', '6');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('735', '79', 'Define los productos y/o servicios a comercializar por el parque tecnológico a las instituciones de la Red y fuera de la Red,creando productos transferibles para generar otros recursos económicos que no dependan de gobierno.', '7');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('736', '79', 'Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.', '8');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('737', '79', 'Supervisa de manera eficiente  el desempeño de las personas a su cargo.', '9');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('738', '79', 'De manera consistente y junto con sus coordinadores diseña, supervisa y evalúa la ejecución de procesos de investigación.', '10');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('739', '3', 'Sabe trabajar en equipo y por lo tanto: Define y utiliza mecanismos de comunicación abierta y clara al interior del equipo, que facilitan la circulación fluida de información.', '6');
INSERT INTO `cuestionarios_competencias_secciones_conductas` VALUES ('740', '3', 'Sabe trabajar en equipo y por lo tanto: Promueve una efectiva resolución y manejo de conflictos entre los miembros del equipo que permita mantener las buenas relaciones.', '7');

-- ----------------------------
-- Table structure for cuestionarios_competencias_secciones_valores_posibles
-- ----------------------------
DROP TABLE IF EXISTS `cuestionarios_competencias_secciones_valores_posibles`;
CREATE TABLE `cuestionarios_competencias_secciones_valores_posibles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `competencia` int(11) DEFAULT NULL,
  `valor` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccsvp_id` (`id`),
  UNIQUE KEY `ccuni` (`competencia`,`valor`),
  KEY `ccsvp_com` (`competencia`),
  KEY `ccsvp_val` (`valor`),
  CONSTRAINT `ccsvp_com` FOREIGN KEY (`competencia`) REFERENCES `cuestionarios_competencias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ccsvp_val` FOREIGN KEY (`valor`) REFERENCES `cuestionarios_valores_posibles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8 COMMENT='Catálogo de posibles respuestas (valores) con los que las preguntas de una sección puede ser contestada.\r\nLos valores se toman del catálogo de valores de la tabla "cuestionarios_valores_posibles".\r\n¡Así cada sección puede tener valores de respuesta diferentes! (Esos valores se aplican a TODAS sus preguntas).';

-- ----------------------------
-- Records of cuestionarios_competencias_secciones_valores_posibles
-- ----------------------------
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('2', '1', '1');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('4', '1', '2');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('6', '1', '3');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('8', '1', '4');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('10', '1', '5');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('13', '2', '1');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('15', '2', '2');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('17', '2', '3');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('19', '2', '4');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('21', '2', '5');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('23', '3', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('25', '3', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('27', '3', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('29', '3', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('31', '3', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('33', '4', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('35', '4', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('37', '4', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('39', '4', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('41', '4', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('48', '5', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('50', '5', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('52', '5', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('54', '5', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('56', '5', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('63', '6', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('65', '6', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('67', '6', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('69', '6', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('71', '6', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('78', '7', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('80', '7', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('82', '7', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('84', '7', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('86', '7', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('93', '8', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('95', '8', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('97', '8', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('99', '8', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('101', '8', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('105', '10', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('168', '10', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('231', '10', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('294', '10', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('357', '10', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('106', '11', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('169', '11', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('232', '11', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('295', '11', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('358', '11', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('107', '12', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('170', '12', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('233', '12', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('296', '12', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('359', '12', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('108', '13', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('171', '13', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('234', '13', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('297', '13', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('360', '13', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('109', '14', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('172', '14', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('235', '14', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('298', '14', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('361', '14', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('110', '15', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('173', '15', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('236', '15', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('299', '15', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('362', '15', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('111', '16', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('174', '16', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('237', '16', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('300', '16', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('363', '16', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('112', '17', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('175', '17', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('238', '17', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('301', '17', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('364', '17', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('113', '18', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('176', '18', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('239', '18', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('302', '18', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('365', '18', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('114', '19', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('177', '19', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('240', '19', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('303', '19', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('366', '19', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('115', '20', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('178', '20', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('241', '20', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('304', '20', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('367', '20', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('116', '21', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('179', '21', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('242', '21', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('305', '21', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('368', '21', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('117', '22', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('180', '22', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('243', '22', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('306', '22', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('369', '22', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('118', '23', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('181', '23', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('244', '23', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('307', '23', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('370', '23', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('119', '24', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('182', '24', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('245', '24', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('308', '24', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('371', '24', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('120', '25', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('183', '25', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('246', '25', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('309', '25', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('372', '25', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('121', '26', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('184', '26', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('247', '26', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('310', '26', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('373', '26', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('122', '27', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('185', '27', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('248', '27', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('311', '27', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('374', '27', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('123', '28', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('186', '28', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('249', '28', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('312', '28', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('375', '28', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('124', '29', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('187', '29', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('250', '29', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('313', '29', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('376', '29', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('125', '30', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('188', '30', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('251', '30', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('314', '30', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('377', '30', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('126', '31', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('189', '31', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('252', '31', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('315', '31', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('378', '31', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('127', '32', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('190', '32', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('253', '32', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('316', '32', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('379', '32', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('128', '33', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('191', '33', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('254', '33', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('317', '33', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('380', '33', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('129', '34', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('192', '34', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('255', '34', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('318', '34', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('381', '34', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('130', '35', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('193', '35', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('256', '35', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('319', '35', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('382', '35', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('131', '36', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('194', '36', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('257', '36', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('320', '36', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('383', '36', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('132', '37', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('195', '37', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('258', '37', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('321', '37', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('384', '37', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('133', '38', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('196', '38', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('259', '38', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('322', '38', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('385', '38', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('134', '39', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('197', '39', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('260', '39', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('323', '39', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('386', '39', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('135', '40', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('198', '40', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('261', '40', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('324', '40', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('387', '40', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('136', '41', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('199', '41', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('262', '41', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('325', '41', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('388', '41', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('137', '42', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('200', '42', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('263', '42', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('326', '42', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('389', '42', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('138', '43', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('201', '43', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('264', '43', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('327', '43', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('390', '43', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('139', '44', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('202', '44', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('265', '44', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('328', '44', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('391', '44', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('140', '45', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('203', '45', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('266', '45', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('329', '45', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('392', '45', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('141', '46', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('204', '46', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('267', '46', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('330', '46', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('393', '46', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('142', '47', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('205', '47', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('268', '47', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('331', '47', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('394', '47', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('143', '48', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('206', '48', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('269', '48', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('332', '48', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('395', '48', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('144', '49', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('207', '49', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('270', '49', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('333', '49', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('396', '49', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('145', '50', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('208', '50', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('271', '50', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('334', '50', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('397', '50', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('146', '51', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('209', '51', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('272', '51', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('335', '51', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('398', '51', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('147', '52', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('210', '52', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('273', '52', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('336', '52', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('399', '52', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('148', '53', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('211', '53', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('274', '53', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('337', '53', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('400', '53', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('149', '54', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('212', '54', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('275', '54', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('338', '54', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('401', '54', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('150', '55', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('213', '55', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('276', '55', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('339', '55', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('402', '55', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('151', '56', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('214', '56', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('277', '56', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('340', '56', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('403', '56', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('152', '57', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('215', '57', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('278', '57', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('341', '57', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('404', '57', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('153', '58', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('216', '58', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('279', '58', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('342', '58', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('405', '58', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('154', '59', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('217', '59', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('280', '59', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('343', '59', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('406', '59', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('155', '60', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('218', '60', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('281', '60', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('344', '60', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('407', '60', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('156', '61', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('219', '61', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('282', '61', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('345', '61', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('408', '61', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('157', '62', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('220', '62', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('283', '62', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('346', '62', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('409', '62', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('158', '63', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('221', '63', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('284', '63', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('347', '63', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('410', '63', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('159', '64', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('222', '64', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('285', '64', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('348', '64', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('411', '64', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('160', '65', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('223', '65', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('286', '65', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('349', '65', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('412', '65', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('161', '66', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('224', '66', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('287', '66', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('350', '66', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('413', '66', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('162', '67', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('225', '67', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('288', '67', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('351', '67', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('414', '67', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('163', '68', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('226', '68', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('289', '68', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('352', '68', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('415', '68', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('164', '69', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('227', '69', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('290', '69', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('353', '69', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('416', '69', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('165', '70', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('228', '70', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('291', '70', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('354', '70', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('417', '70', '10');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('166', '71', '6');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('229', '71', '7');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('292', '71', '8');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('355', '71', '9');
INSERT INTO `cuestionarios_competencias_secciones_valores_posibles` VALUES ('418', '71', '10');

-- ----------------------------
-- Table structure for cuestionarios_manual_input
-- ----------------------------
DROP TABLE IF EXISTS `cuestionarios_manual_input`;
CREATE TABLE `cuestionarios_manual_input` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `orden` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cmi_id` (`id`),
  KEY `cmi_eval` (`evaluacion`),
  KEY `cmi_sort` (`orden`),
  CONSTRAINT `cmi_eval` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Contenedor de conjunto de preguntas abiertas.\r\nEsto es lo que se muestra cuando se asignan "competencias" en el gestor de niveles.';

-- ----------------------------
-- Records of cuestionarios_manual_input
-- ----------------------------
INSERT INTO `cuestionarios_manual_input` VALUES ('1', '1', 'Preguntas abiertas', '100');

-- ----------------------------
-- Table structure for cuestionarios_manual_input_preguntas
-- ----------------------------
DROP TABLE IF EXISTS `cuestionarios_manual_input_preguntas`;
CREATE TABLE `cuestionarios_manual_input_preguntas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contenedor` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `tipo` enum('abierto','opciones') NOT NULL DEFAULT 'abierto',
  `inputsCantidad` int(11) DEFAULT '1' COMMENT 'Sólo para tipo "abierto".\r\nCantidad de inputs que puede registrar el usuario.',
  `orden` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cmi_id` (`id`),
  KEY `cmi_eval` (`contenedor`),
  KEY `cmi_sort` (`orden`),
  KEY `cmi_tipo` (`tipo`),
  CONSTRAINT `cmip` FOREIGN KEY (`contenedor`) REFERENCES `cuestionarios_manual_input` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Catálogo de preguntas semi-abiertas por evaluación.\r\nSi es tipo "abierto" se considera el campo "inputsCantidad" como la cantidad de veces que se mostrará el <input>.\r\nSi es tipo "opciones" se consultan las preguntas en "cuestionarios_manual_input_preguntas_opciones".';

-- ----------------------------
-- Records of cuestionarios_manual_input_preguntas
-- ----------------------------
INSERT INTO `cuestionarios_manual_input_preguntas` VALUES ('1', '1', 'Fortalezas', 'abierto', '2', '1');
INSERT INTO `cuestionarios_manual_input_preguntas` VALUES ('2', '1', 'Áreas de oportunidad\r\n<br>\r\n<small class=\"text-muted\">(Objetivos a trabajar durante el año)</small>', 'abierto', '2', '2');
INSERT INTO `cuestionarios_manual_input_preguntas` VALUES ('3', '1', 'Promoción', 'opciones', '0', '3');
INSERT INTO `cuestionarios_manual_input_preguntas` VALUES ('4', '1', 'Menciona 2 Cursos de Capacitación que recomiende para el colaborador', 'abierto', '2', '4');

-- ----------------------------
-- Table structure for cuestionarios_manual_input_preguntas_opciones
-- ----------------------------
DROP TABLE IF EXISTS `cuestionarios_manual_input_preguntas_opciones`;
CREATE TABLE `cuestionarios_manual_input_preguntas_opciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `input` int(11) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `manual_input` text,
  `orden` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cmio_id` (`id`) USING BTREE,
  KEY `cmio_input` (`input`) USING BTREE,
  CONSTRAINT `cmio` FOREIGN KEY (`input`) REFERENCES `cuestionarios_manual_input_preguntas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Catálogo de opciones múltiples para inputs manuales.\r\nLas posibles respuestas se toman de cuestionarios_manual_input_opciones_respuestas.\r\nIncluye capacidad de agregar texto manual para cada respuesta en el campo "manual_input" (Para "¿Cuál y motivo?").';

-- ----------------------------
-- Records of cuestionarios_manual_input_preguntas_opciones
-- ----------------------------
INSERT INTO `cuestionarios_manual_input_preguntas_opciones` VALUES ('1', '3', '¿Lo recomienda para un ascenso dentro de su área?', 'Cuál y motivo', '0');
INSERT INTO `cuestionarios_manual_input_preguntas_opciones` VALUES ('2', '3', '¿Lo recomendaría para otro puesto dentro de la UAM?', 'Cuál y motivo', '0');

-- ----------------------------
-- Table structure for cuestionarios_manual_input_preguntas_opciones_respuestas
-- ----------------------------
DROP TABLE IF EXISTS `cuestionarios_manual_input_preguntas_opciones_respuestas`;
CREATE TABLE `cuestionarios_manual_input_preguntas_opciones_respuestas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `input_opciones` int(11) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `orden` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cmior_id` (`id`),
  KEY `cmior_input` (`input_opciones`),
  KEY `cmior_sort` (`orden`),
  CONSTRAINT `cmipor` FOREIGN KEY (`input_opciones`) REFERENCES `cuestionarios_manual_input_preguntas_opciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Catálogo de posibles respuestas para las preguntas semi-abiertas.\r\nTODAS las respuestas son radiobuttons.';

-- ----------------------------
-- Records of cuestionarios_manual_input_preguntas_opciones_respuestas
-- ----------------------------
INSERT INTO `cuestionarios_manual_input_preguntas_opciones_respuestas` VALUES ('1', '1', 'Sí', '0');
INSERT INTO `cuestionarios_manual_input_preguntas_opciones_respuestas` VALUES ('2', '1', 'No', '1');
INSERT INTO `cuestionarios_manual_input_preguntas_opciones_respuestas` VALUES ('3', '2', 'Sí', '0');
INSERT INTO `cuestionarios_manual_input_preguntas_opciones_respuestas` VALUES ('4', '2', 'No', '1');

-- ----------------------------
-- Table structure for cuestionarios_valores_posibles
-- ----------------------------
DROP TABLE IF EXISTS `cuestionarios_valores_posibles`;
CREATE TABLE `cuestionarios_valores_posibles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) DEFAULT NULL,
  `valor` int(11) DEFAULT NULL,
  `etiqueta` varchar(255) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cvp_id` (`id`),
  KEY `cvp_eval` (`evaluacion`),
  KEY `cvp_val` (`valor`),
  CONSTRAINT `cvp_eval` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Opciones que se pueden asignar a las secciones como respuestas.\r\nSe agrupan por "titulo", así que se puede repetir, por ejemplo 1-2 pueden tener los mismos títulos y descripciones.';

-- ----------------------------
-- Records of cuestionarios_valores_posibles
-- ----------------------------
INSERT INTO `cuestionarios_valores_posibles` VALUES ('1', '1', '1', '1-2', 'Nivel muy bajo de desarrollo', 'El colaborador presenta un nivel muy bajo de aplicación de la conducta en su trabajo.');
INSERT INTO `cuestionarios_valores_posibles` VALUES ('2', '1', '3', '3-4', 'Nivel bajo de desarrollo', 'El colaborador presenta un nivel bajo de aplicación de la conducta en su trabajo.');
INSERT INTO `cuestionarios_valores_posibles` VALUES ('3', '1', '5', '5-6', 'Nivel medio de desarrollo', 'El colaborador presenta un nivel medio de aplicación de la conducta en su trabajo.');
INSERT INTO `cuestionarios_valores_posibles` VALUES ('4', '1', '7', '7-8', 'Nivel alto de desarrollo', 'El colaborador presenta un nivel alto de aplicación de la conducta en su trabajo.');
INSERT INTO `cuestionarios_valores_posibles` VALUES ('5', '1', '9', '9-10', 'Nivel superior de desarrollo', 'La conducta observada es una fortaleza que caracteriza al colaborador.');
INSERT INTO `cuestionarios_valores_posibles` VALUES ('6', '1', '1', '1-2', 'Muy bajo', 'El colaborador presenta un nivel muy bajo de aplicación de la conducta en su trabajo.');
INSERT INTO `cuestionarios_valores_posibles` VALUES ('7', '1', '3', '3-4', 'Bajo', 'El colaborador presenta un nivel bajo de aplicación de la conducta en su trabajo.');
INSERT INTO `cuestionarios_valores_posibles` VALUES ('8', '1', '5', '5-6', 'Medio', 'El colaborador presenta un nivel medio de aplicación de la conducta en su trabajo.');
INSERT INTO `cuestionarios_valores_posibles` VALUES ('9', '1', '7', '7-8', 'Alto', 'El colaborador presenta un nivel alto de aplicación de la conducta en su trabajo.');
INSERT INTO `cuestionarios_valores_posibles` VALUES ('10', '1', '9', '9-10', 'Superior', 'El colaborador presenta un nivel muy por encima de lo que se espera de aplicación de la conducta en su trabajo.');

-- ----------------------------
-- Table structure for departamentos
-- ----------------------------
DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE `departamentos` (
  `codigo` varchar(255) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `cadena` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `depkey` (`cadena`),
  KEY `depid` (`codigo`),
  KEY `depti` (`titulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of departamentos
-- ----------------------------
INSERT INTO `departamentos` VALUES ('MXB0031403', 'Ciencias de la Comunicación', 'MXB0031403 - Ciencias de la Comunicación');
INSERT INTO `departamentos` VALUES ('MXB0031404', 'Diseño', 'MXB0031404 - Diseño');
INSERT INTO `departamentos` VALUES ('MXB0031405', 'Derecho', 'MXB0031405 - Derecho');
INSERT INTO `departamentos` VALUES ('MXB0031407', 'División de Negocios', 'MXB0031407 - División de Negocios');
INSERT INTO `departamentos` VALUES ('MXB0031408', 'Psicología', 'MXB0031408 - Psicología');
INSERT INTO `departamentos` VALUES ('MXB0031410', 'División de Ingeniería', 'MXB0031410 - División de Ingeniería');
INSERT INTO `departamentos` VALUES ('MXB0031411', 'Médico Cirujano', 'MXB0031411 - Médico Cirujano');
INSERT INTO `departamentos` VALUES ('MXB0031413', 'Nutrición', 'MXB0031413 - Nutrición');
INSERT INTO `departamentos` VALUES ('MXB0031414', 'Cirujano Dentista', 'MXB0031414 - Cirujano Dentista');
INSERT INTO `departamentos` VALUES ('MXB0031415', 'Arquitectura', 'MXB0031415 - Arquitectura');
INSERT INTO `departamentos` VALUES ('MXB0031416', 'Coordinación de humanidades', 'MXB0031416 - Coordinación de humanidades');
INSERT INTO `departamentos` VALUES ('MXB0031602', 'Programas de liderazgo VERTICE', 'MXB0031602 - Programas de liderazgo VERTICE');
INSERT INTO `departamentos` VALUES ('MXB0031603', 'Relaciones Estudiatiles', 'MXB0031603 - Relaciones Estudiatiles');
INSERT INTO `departamentos` VALUES ('MXB0031604', 'Red Misión', 'MXB0031604 - Red Misión');
INSERT INTO `departamentos` VALUES ('MXB0031605', 'Servicio y Acción Social', 'MXB0031605 - Servicio y Acción Social');
INSERT INTO `departamentos` VALUES ('MXB0031606', 'Difusión Cultural', 'MXB0031606 - Difusión Cultural');
INSERT INTO `departamentos` VALUES ('MXB0031607', 'Vicerrectoría de Formación Integral', 'MXB0031607 - Vicerrectoría de Formación Integral');
INSERT INTO `departamentos` VALUES ('MXB0031609', 'Desarrollo Humano', 'MXB0031609 - Desarrollo Humano');
INSERT INTO `departamentos` VALUES ('MXB0031612', 'Coordinación de Selecciones y Ac. Deport', 'MXB0031612 - Coordinación de Selecciones y Ac. Deport');
INSERT INTO `departamentos` VALUES ('MXB0033301', 'Centro de Lenguas', 'MXB0033301 - Centro de Lenguas');
INSERT INTO `departamentos` VALUES ('MXB0033302', 'Dirección de Administraci', 'MXB0033302 - Dirección de Administraci');
INSERT INTO `departamentos` VALUES ('MXB0033303', 'Dirección Servicios Institucionales y Pl', 'MXB0033303 - Dirección Servicios Institucionales y Pl');
INSERT INTO `departamentos` VALUES ('MXB0033304', 'Coordinación de Servicios Tecnológicos', 'MXB0033304 - Coordinación de Servicios Tecnológicos');
INSERT INTO `departamentos` VALUES ('MXB0033305', 'Centro de Atención Alumnos', 'MXB0033305 - Centro de Atención Alumnos');
INSERT INTO `departamentos` VALUES ('MXB0034001', 'Vicerrectoría Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas');
INSERT INTO `departamentos` VALUES ('MXB0034101', 'Mantenimiento', 'MXB0034101 - Mantenimiento');
INSERT INTO `departamentos` VALUES ('MXB0034301', 'Promoción', 'MXB0034301 - Promoción');
INSERT INTO `departamentos` VALUES ('MXB0034401', 'Vicerrectoría Académica', 'MXB0034401 - Vicerrectoría Académica');
INSERT INTO `departamentos` VALUES ('MXB0034403', 'Operación Académica', 'MXB0034403 - Operación Académica');
INSERT INTO `departamentos` VALUES ('MXB0034404', 'Relaciones Académicas', 'MXB0034404 - Relaciones Académicas');
INSERT INTO `departamentos` VALUES ('MXB0034407', 'Desarrollo Académico', 'MXB0034407 - Desarrollo Académico');
INSERT INTO `departamentos` VALUES ('MXB0034510', 'Bloque Electivo Anahuac', 'MXB0034510 - Bloque Electivo Anahuac');
INSERT INTO `departamentos` VALUES ('MXB0034601', 'Rectoría UA Mayab', 'MXB0034601 - Rectoría UA Mayab');
INSERT INTO `departamentos` VALUES ('MXB0034602', 'Coordinación de Comunicación', 'MXB0034602 - Coordinación de Comunicación');
INSERT INTO `departamentos` VALUES ('MXB0034603', 'Coordinación de Vinculación y Recaudació', 'MXB0034603 - Coordinación de Vinculación y Recaudació');
INSERT INTO `departamentos` VALUES ('MXB0034604', 'Gerencia de Recursos humanos', 'MXB0034604 - Gerencia de Recursos humanos');
INSERT INTO `departamentos` VALUES ('MXB0034606', 'Dirección de Desarrollo Institucional', 'MXB0034606 - Dirección de Desarrollo Institucional');
INSERT INTO `departamentos` VALUES ('MXB0034608', 'Programa de Egresados', 'MXB0034608 - Programa de Egresados');
INSERT INTO `departamentos` VALUES ('MXB0034901', 'Biblioteca', 'MXB0034901 - Biblioteca');
INSERT INTO `departamentos` VALUES ('MXB0121501', 'Dirección de Posgrados y Extensión', 'MXB0121501 - Dirección de Posgrados y Extensión');
INSERT INTO `departamentos` VALUES ('MXB0121504', 'Mtria. Admon. Publica (mid)', 'MXB0121504 - Mtria. Admon. Publica (mid)');
INSERT INTO `departamentos` VALUES ('MXB0121506', 'Mtria. Alta Dirección y Neg. (mid)', 'MXB0121506 - Mtria. Alta Dirección y Neg. (mid)');
INSERT INTO `departamentos` VALUES ('MXB0121508', 'Mtria. Ciencias de la Ed. (mid)', 'MXB0121508 - Mtria. Ciencias de la Ed. (mid)');
INSERT INTO `departamentos` VALUES ('MXB0121519', 'Esp. Odontologia', 'MXB0121519 - Esp. Odontologia');
INSERT INTO `departamentos` VALUES ('MXB0121527', 'Mtria. Nutrición Clínica (mid)', 'MXB0121527 - Mtria. Nutrición Clínica (mid)');
INSERT INTO `departamentos` VALUES ('MXB0121528', 'Mtria. Terapia Familiar (mid)', 'MXB0121528 - Mtria. Terapia Familiar (mid)');
INSERT INTO `departamentos` VALUES ('MXB0121548', 'Mtria.DirTecnEnInfyTel MID', 'MXB0121548 - Mtria.DirTecnEnInfyTel MID');
INSERT INTO `departamentos` VALUES ('MXB0123203', 'Clínica Universitaria', 'MXB0123203 - Clínica Universitaria');
INSERT INTO `departamentos` VALUES ('MXB0127414', 'Oficina de Transferencia', 'MXB0127414 - Oficina de Transferencia');

-- ----------------------------
-- Table structure for empleados
-- ----------------------------
DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `empleado` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido_paterno` varchar(255) NOT NULL,
  `apellido_materno` varchar(255) DEFAULT NULL,
  `departamento` varchar(11) DEFAULT NULL,
  `puesto` int(11) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `nivel` int(11) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `fechaRegistro` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT '0: Activo\r\n1: Inactivo',
  PRIMARY KEY (`empleado`),
  UNIQUE KEY `em_code` (`empleado`),
  KEY `em_nombre` (`nombre`,`apellido_paterno`),
  KEY `em_puesto` (`puesto`),
  KEY `em_status` (`status`),
  KEY `em_dep` (`departamento`),
  KEY `em_area` (`area`),
  KEY `em_nivel` (`nivel`),
  CONSTRAINT `em_area` FOREIGN KEY (`area`) REFERENCES `areas` (`codigo`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `em_dep` FOREIGN KEY (`departamento`) REFERENCES `departamentos` (`codigo`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `em_nivel` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`codigo`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `em_puest` FOREIGN KEY (`puesto`) REFERENCES `puestos` (`codigo`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de empleados.\r\nDebería ser una copia compatible con aquella de OnTheMinute para facilitar el copy-paste, agregando el status.\r\nEl status permitirá agregar un empleado a un ciclo únicamente si está activo (0).\r\nAl desactivar a un empleado y esté dentro de una aplicación de evaluaciones activa preguntar al usuario\r\npara continuar.\r\nSi continúa se removerá de esa aplicación, mas no así de los anteriores.';

-- ----------------------------
-- Records of empleados
-- ----------------------------
INSERT INTO `empleados` VALUES ('1', 'Rafael', 'Pardo', '	Hervás', 'MXB0034601', '1', '1', '1', 'rafael.pardo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('2', 'Ulises', 'Peñúñuri', '	Munguía', 'MXB0034601', '2', '1', '1', 'ulises.penunuri@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32122411', 'Luis Oscar', 'Anguiano', 'Avila', 'MXB0034001', '7', '4', '9', 'luis.anguiano@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32123111', 'Luis Ernesto', 'Gutierrez', 'Martinez', 'MXB0034606', '50', '1', '4', 'luis.gutierrez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32123705', 'Nina Rosa', 'Allen', 'Novelo', 'MXB0034407', '5', '3', '9', 'nina.allen@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124170', 'Gaspar', 'Flores', 'May', 'MXB0034101', '15', '4', '16', 'gaspar.flores@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124172', 'David', 'Vegue', 'Corbacho', 'MXB0031416', '80', '3', '9', 'david.vegue@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124174', 'Paula Patricia', 'López', 'Rodriguez', 'MXB0031405', '84', '3', '16', 'patricia.lopez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124176', 'Martha Angelica', 'Chi', 'Canul', 'MXB0034001', '81', '4', '19', 'martha.chi@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124178', 'Lidia Maricruz', 'Rejón', 'Martínez', 'MXB0033302', '10', '1', '12', 'maricruz.rejon@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124181', 'Alejandra', 'Mendoza', 'Villalobos', 'MXB0121501', '53', '3', '4', 'alejandra.mendoza@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124183', 'Francisco Javier', 'Otero', 'Rejón', 'MXB0031416', '45', '3', '4', 'francisco.otero@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124184', 'María Cristina', 'Carrillo', 'Acosta', 'MXB0034401', '83', '3', '12', 'cristina.carrillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124185', 'Rubí Candelaria', 'Martín', 'Gómez', 'MXB0033305', '84', '1', '16', 'rubi.martin@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124186', 'Lia Regina', 'Narváez', 'Galaz', 'MXB0034604', '67', '1', '5', 'lia.narvaez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124187', 'María Del Carmen', 'Sandoval', 'Vázquez', 'MXB0031410', '10', '3', '12', 'carmen.sandoval@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124188', 'María Del Rocío', 'Chávez', 'Reyes', 'MXB0033302', '76', '1', '5', 'rocio.chavez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124189', 'Julio Antonio', 'Ontiveros', 'Velázquez', 'MXB0034001', '78', '4', '9', 'julio.ontiveros@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124190', 'María Guadalupe', 'Hernández', 'Loeza', 'MXB0031405', '10', '3', '12', 'guadalupe.hernandez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124192', 'Benjamín Ramón', 'Negroe', 'Monforte', 'MXB0031407', '52', '3', '5', 'benjamin.negroe@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124193', 'Annette Dinorah', 'Cirerol', 'León', 'MXB0031407', '10', '3', '12', 'annete.cirerol@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124194', 'María Guadalupe Del Carmen', 'Cervera', null, 'MXB0031607', '10', '5', '12', 'guadalupe.cervera@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124195', 'Martha María', 'Tello', 'Rodriguez', 'MXB0031415', '52', '3', '7', 'martha.tello@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124196', 'Mercedes', 'Zárate', 'Medina', 'MXB0034403', '10', '3', '12', 'mercedes.zarate@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124197', 'Eduardo Fernando', 'Cel', 'Briceño', 'MXB0034101', '68', '4', '16', 'eduardo.cel@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124198', 'Debora', 'Ayala', 'Fernández', 'MXB0033301', '10', '3', '12', 'debora.ayala@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124199', 'Enrique De Jesus', 'Cachón', 'Medrano', 'MXB0034001', '18', '4', '16', 'enrique.cachon@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124202', 'Antonio', 'Zaldivar', 'Álvarez', 'MXB0034001', '78', '4', '9', 'antonio.zaldivar@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124206', 'Luciano Diab', 'Dominguez', 'Cherit', 'MXB0031410', '80', '3', '8', 'luciano.dominguez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124209', 'Marisol', 'Tello', 'Rodriguez', 'MXB0031403', '52', '3', '7', 'marisol.tello@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124210', 'Francisco Gerardo', 'Barroso', 'Tanoira', 'MXB0031407', '80', '3', '9', 'francisco.barroso@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124213', 'Zolly Herlinda', 'Chin', 'Pool', 'MXB0031411', '88', '3', '12', 'zolly.chin@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124214', 'Pedro Ricardo', 'Aquino', 'Hernández', 'MXB0031411', '88', '3', '12', 'pedro.aquino@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124215', 'Katinka Elizabeth', 'Ibañez', 'Gómez', 'MXB0031411', '23', '3', '10', 'katinka.ibanez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124216', 'Karim Fernando', 'Pedro', 'Fernández', 'MXB0034601', '9', '1', '5', 'karim.pedro@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124218', 'Jorge Abraham', 'Carrillo', 'Hernández', 'MXB0034101', '15', '4', '16', 'jorge.carrillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124222', 'Marisol Guadalupe', 'Vera', 'Cardeña', 'MXB0033302', '10', '1', '12', 'marisol.vera@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124223', 'Elda Leonor', 'Pacheco', 'Pantoja', 'MXB0031411', '80', '3', '9', 'elda.pacheco@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124224', 'Florángely', 'Herrera', 'Baas', 'MXB0034602', '24', '1', '5', 'florangely.herrera@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124225', 'José Alejandro', 'González', 'Novelo', 'MXB0031408', '52', '3', '5', 'alejandro.gonzalezn@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124226', 'Juan Antonio', 'Anaya', 'Sandoval', 'MXB0031410', '51', '3', '4', 'antonio.anaya@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124227', 'Silvia Zuhalia', 'Zapata', 'Carrillo', 'MXB0031403', '80', '3', '9', 'silvia.zapata@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124229', 'Marisol', 'Achach', 'Solís', 'MXB0034401', '37', '3', '5', 'marisol.achach@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124233', 'Inocencio', 'Cohuo', 'Chin', 'MXB0034101', '68', '4', '16', 'inocencio.cohuo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124234', 'María Jazmine Del Carmen', 'Peraza', 'Rosas', 'MXB0033304', '75', '1', '5', 'jazmine.peraza@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124235', 'Antonio', 'Barrera', 'Martínez', 'MXB0034601', '9', '1', '5', 'antonio.barrera@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124236', 'Anna Karina', 'Cruz', 'López', 'MXB0034407', '63', '3', '10', 'anna.cruz@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124238', 'Fernando Antonio', 'Torreblanca', 'Rios', 'MXB0034901', '70', '3', '5', 'fernando.torreblanca@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124243', 'Eugenia Beatriz', 'Euan', 'Calderón', 'MXB0034001', '72', '4', '11', 'eugenia.euan@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124245', 'Susana Enriqueta', 'Guzmán', 'Silva', 'MXB0034407', '49', '3', '4', 'susana.guzman@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124248', 'Yngrid', 'Peniche', 'Rivero', 'MXB0034604', '10', '1', '12', 'yngrid.peniche@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124249', 'Carlos Gaspar', 'Pérez', 'Varguez', 'MXB0031403', '80', '3', '9', 'carlos.perez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124250', 'Anna Carolina', 'Vidal', 'Carrillo', 'MXB0034407', '5', '3', '9', 'anna.vidal@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124253', 'Luis Enrique', 'Santana', 'Cab', 'MXB0034101', '15', '4', '16', 'luis.santana@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124254', 'Lissett Beatriz', 'Pedrero', 'Aguilar', 'MXB0031404', '80', '3', '9', 'lissett.pedrero@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124255', 'Gretty Guadalupe', 'Escalante', 'Góngora', 'MXB0031403', '80', '3', '9', 'gretty.escalante@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124256', 'Rubí Margarita', 'Estrada', 'Medina', 'MXB0034001', '83', '4', '12', 'rubi.estrada@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124257', 'Martha Eugenia', 'Barrera', 'Bustillos', 'MXB0031413', '52', '3', '5', 'martha.barrera@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124263', 'Margarita Concepción', 'Durán', 'Yabur', 'MXB0031404', '84', '3', '16', 'margarita.duran@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124267', 'Fermín Orlando', 'Cardós', 'Santoyo', 'MXB0033303', '54', '1', '3', 'fermin.cardos@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124269', 'Argel Antonio', 'Farjat', 'Aguilar', 'MXB0034407', '63', '3', '10', 'argel.farjat@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124272', 'Alicia Del Carmen', 'Ortiz', 'Suárez', 'MXB0031408', '10', '3', '12', 'alicia.ortiz@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124274', 'Julián', 'García', 'Hinojosa', 'MXB0034101', '15', '4', '16', 'julian.garcia@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124275', 'Julia Amanda', 'Díaz', 'Aguilar', 'MXB0121504', '29', '3', '5', 'julia.diaz@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124276', 'Jose Mauricio', 'Pool', 'Pech', 'MXB0034101', '68', '4', '16', 'jose.pool@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124278', 'Fernando Enrique', 'Acevedo', 'Marentes', 'MXB0121501', '5', '3', '9', 'fernando.acevedo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124279', 'Marisol', 'Cen', 'Caamal', 'MXB0031407', '80', '3', '9', 'marisol.cen@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124281', 'María Eugenia', 'Sansores', 'Sánchez', 'MXB0034403', '84', '3', '16', 'maria.sansores@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124282', 'Andrea Josefina', 'Sansores', 'Ruz', 'MXB0033301', '80', '3', '9', 'andrea.sansores@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124284', 'Carlos Alberto', 'Castillo', 'Pompeyo', 'MXB0031413', '80', '3', '9', 'carlos.castillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124289', 'Jhoanna', 'Echazarreta', 'Montero', 'MXB0034001', '71', '4', '9', 'jhoanna.echazarreta@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124291', 'Gabriela Del Socorro', 'Herrera', 'Cámara', 'MXB0034401', '83', '3', '12', 'gabriela.herrera@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124292', 'Jose Gabriel', 'Urzaiz', 'Lares', 'MXB0031410', '80', '3', '6', 'gabriel.urzaiz@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124302', 'Francisco Santiago', 'Ruiz', 'Medina', 'MXB0034101', '15', '4', '16', 'francisco.ruiz@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124303', 'Andrea Susana', 'Urzúa', 'Navarrete', 'MXB0031407', '80', '3', '9', 'andrea.urzua@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124304', 'Beatriz Anilú', 'Mendoza', 'Noh', 'MXB0033304', '62', '1', '9', 'anilu.mendoza@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124313', 'Maria Cecilia', 'Martinez', 'Rodriguez', 'MXB0033305', '84', '1', '16', 'cecilia.martinez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124314', 'Ligia Beatriz', 'Biachi', 'Valencia', 'MXB0031404', '10', '3', '12', 'ligia.biachi@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124315', 'Astrid Marvin', 'Peniche', 'Sanguino', 'MXB0033302', '47', '1', '4', 'astrid.peniche@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124317', 'Daniel Alberto', 'Correa', 'Cruz', 'MXB0034901', '12', '3', '16', 'daniel.correa@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124320', 'Carlos Manuel', 'Hornelas', 'Pineda', 'MXB0031403', '80', '3', '9', 'carlos.hornelas@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124321', 'José Rodrigo', 'Franco', 'Calvillo', 'MXB0031612', '38', '5', '5', 'rodrigo.franco@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124328', 'Eusebio', 'Cohuo', 'Chin', 'MXB0034101', '15', '4', '16', 'eusebio.cohuo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124329', 'Gener Ricardo', 'Crespo', 'Canté', 'MXB0031411', '88', '3', '12', 'gener.crespo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124330', 'Consepción', 'Padrón', 'Chim', 'MXB0034101', '68', '4', '16', 'consepcion.padron@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124331', 'Rosa Eugenia', 'Mijangos', 'Naal', 'MXB0034901', '87', '3', '9', 'rosa.mijangos@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124333', 'Elsy Noemi', 'Centeno', 'Sarabia', 'MXB0031416', '10', '3', '12', 'elsy.centeno@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124335', 'José Guillermo', 'Fournier', 'Montiel', 'MXB0031404', '80', '3', '10', 'guillermo.fournier@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124336', 'Martha Patricia', 'Dzib', 'Chan', 'MXB0033302', '10', '1', '9', 'patricia.dzib@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124341', 'Leonor Beatriz Del Socorro', 'Martínez', 'González', 'MXB0034001', '19', '4', '4', 'leonor.martinez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124342', 'Jose Luis', 'Luna', 'Martínez', 'MXB0031411', '23', '3', '9', 'jose.lunam@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124343', 'Aurea Rosa', 'Medina', 'Lara', 'MXB0031413', '10', '3', '12', 'aurea.medina@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124344', 'María Adela', 'Escobedo', 'García', 'MXB0033305', '84', '1', '16', 'maria.escobedo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124346', 'Eric José', 'Esquivel', 'Cortés', 'MXB0031407', '80', '3', '9', 'eric.esquivel@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124348', 'Ada Luz', 'Amaya', 'Pérez', 'MXB0121501', '83', '3', '12', 'ada.amaya@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124349', 'Rocio Elizabeth', 'Rodriguez', 'Pantoja', 'MXB0031416', '80', '3', '9', 'rocio.rodriguez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124350', 'Absalón', 'Álvarez', 'Escalante', 'MXB0031405', '52', '3', '5', 'absalon.alvarez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124351', 'Andres', 'Kumán', 'Dzul', 'MXB0034101', '68', '4', '16', 'andres.kuman@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124355', 'Africa', 'San Miguel', 'Alvarado', 'MXB0127414', '84', '1', '16', 'africa.sanmiguel@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124359', 'Cándido', 'Guardia', 'Chi', 'MXB0034101', '68', '4', '16', 'candido.guardia@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124363', 'Rosa María', 'Casanova', 'López', 'MXB0034001', '10', '4', '12', 'rosa.casanova@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124365', 'Jessica Guadalupe', 'Ramos', 'Medina', 'MXB0033303', '7', '1', '9', 'jessica.ramos@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124366', 'Adrián Baltazar', 'Muñoz', 'Zetina', 'MXB0034101', '15', '4', '16', 'adrian.munoz@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124370', 'Jose  Alfredo', 'Carrillo', 'Marin', 'MXB0033304', '16', '1', '16', 'jose.carrillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124898', 'Lucy Del Carmen', 'Escamilla', 'Borges', 'MXB0031407', '10', '3', '12', 'lucy.escamilla@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124903', 'María Cristina', 'Burgos', 'Montes De Oca', 'MXB0031405', '80', '3', '9', 'cristina.burgos@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32124975', 'Mayte Eugenia', 'Rodríguez', 'Pech', 'MXB0033302', '77', '1', '5', 'mayte.rodriguez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32133083', 'Isabel Guadalupe', 'Rosado', 'Richard', 'MXB0033301', '80', '3', '9', 'isabel.rosado@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32133367', 'Marian', 'Alpizar', 'Rodríguez', 'MXB0031413', '80', '3', '9', 'marian.alpizar@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32133467', 'Raúl Armando', 'Osuna', 'Enríquez', 'MXB0031612', '56', '5', '9', 'raoe33@hotmail.com', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32136613', 'Gilda', 'Henry', 'Caretta', 'MXB0031607', '57', '5', '12', 'gilda.henry@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32136969', 'Orlando Jesús', 'Coello', 'Castañeda', 'MXB0031612', '56', '2', '9', 'orlando_coeca@hotmail.com', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32137035', 'Lucely De Los Angeles', 'Escárcega', 'Galera', 'MXB0034001', '86', '4', '12', 'lucely.escarcega@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32137036', 'José Jesús', 'Karam', 'Espósitos', 'MXB0031408', '80', '3', '9', 'jose.karam@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32137037', 'Karla Leticia', 'Mézquita', 'Gamboa', 'MXB0034001', '17', '4', '16', 'karla.mezquita@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32137040', 'Sofía Constanza', 'Fregoso', 'Lomas', 'MXB0031415', '80', '3', '9', 'sofia.fregoso@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32137041', 'Judith Margarete', 'Towle', 'Wachenheim', 'MXB0033301', '43', '3', '5', 'judith.towle@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32137185', 'Elena', 'Palomeque', 'Martínez', 'MXB0031407', '14', '3', '16', 'elena.palomeque@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32137726', 'Clara Angélica', 'Góngora', 'Bates', 'MXB0031414', '10', '3', '12', 'angelica.gongora@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32140720', 'Jaime Ermilo', 'Olivera', 'Novelo', 'MXB0034407', '41', '3', '5', 'jaime.olivera@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142235', 'Carlos Daniel', 'García', 'López', 'MXB0031609', '3', '5', '9', 'carlos.garcia@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142628', 'María José', 'Bolio', 'Romero', 'MXB0034604', '61', '1', '9', 'maria.bolio@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142632', 'Narciso Antonio', 'Acuña', 'González', 'MXB0034401', '90', '3', '2', 'narciso.acuna@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142634', 'Ileana Patricia', 'López', 'Albor', 'MXB0031407', '80', '3', '9', 'ileana.lopez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142649', 'Aida Rosa', 'Muñoz', 'Bello', 'MXB0031606', '25', '5', '5', 'aida.munoz@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142651', 'José Manuel', 'Echeverría', 'Y Eguiluz', 'MXB0031411', '52', '3', '5', 'jose.echeverria@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142652', 'Eduardo', 'Castro', 'Avila', 'MXB0033305', '20', '1', '9', 'eduardo.castro@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142653', 'Ana Beatriz', 'González', 'Encalada', 'MXB0031603', '10', '5', '12', 'ana.gonzalez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142658', 'Hansel Francisco', 'Ortiz', 'Heredia', 'MXB0031407', '52', '3', '5', 'hansel.ortiz@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142661', 'Jorge', 'Rivera', 'Rovelo', 'MXB0031410', '33', '3', '5', 'jorge.rivera@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142667', 'María Alicia', 'Castro', 'Landeros', 'MXB0031407', '52', '3', '5', 'maria.castro@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142851', 'Karla Yamile', 'Falcón', 'Rivera', 'MXB0033302', '58', '1', '9', 'karla.falcon@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142871', 'Trinidad Rebeca', 'Hernández', 'Cortés', 'MXB0034601', '85', '1', '12', 'rebeca.hernandez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142874', 'Yara Lizette', 'Torres', 'Jiménez', 'MXB0033303', '36', '1', '5', 'yara.torres@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142875', 'Arumi', 'Tuyub', 'España', 'MXB0034407', '22', '3', '5', 'arumi.tuyub@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142985', 'Francisco  Manuel', 'Kú', 'Carrillo', 'MXB0121519', '31', '3', '5', 'francisco.ku@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32142999', 'Guadalupe Nahiely', 'Ayala', 'Parra', 'MXB0031411', '10', '3', '20', 'guadalupe.ayala@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32143258', 'Freddy Juventino', 'Valle', 'Moo', 'MXB0033304', '89', '1', '12', 'freddy.valle@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32143261', 'Moctezuma', 'Peraza', 'Chuc', 'MXB0033304', '89', '1', '12', 'moctezuma.peraza@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32143366', 'Martha Georgina Del Socorro', 'Ventura', 'Sabido', 'MXB0034001', '7', '4', '9', 'martha.ventura@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32143434', 'Regina', 'Garza', 'Roche', 'MXB0127414', '48', '1', '4', 'regina.garza@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32143435', 'Rubén', 'Dominguez', 'Maldonado', 'MXB0031410', '80', '3', '8', 'ruben.dominguez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32143828', 'Georgina Maribel', 'Ojeda', 'Viana', 'MXB0034602', '24', '1', '9', 'maribel.ojeda@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32143970', 'Alfredo José', 'Solís', 'Castilla', 'MXB0031612', '56', '5', '9', 'alfredo.solis@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32144069', 'Maythe', 'Fraire', 'Torres', 'MXB0123203', '84', '4', '16', 'maythe.fraire@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32144113', 'Gladys Ruby', 'Díaz', 'Negrón', 'MXB0031415', '80', '3', '9', 'gladys.diaz@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32144114', 'José Luis', 'Escalante', 'Macías Valadez', 'MXB0031410', '33', '3', '5', 'jose.escalante@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32144190', 'Juan Gualberto', 'Puc', 'Martin', 'MXB0033302', '10', '1', '9', 'juan.puc@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32144380', 'Eric Simón', 'Murillo', 'Rodríguez', 'MXB0031411', '80', '3', '9', 'eric.murillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32144462', 'Mariela Trinidad', 'Lara', 'Martínez', 'MXB0031411', '88', '3', '12', 'mariela.lara@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32144488', 'Mario Ernesto', 'Gamboa', 'Mendez', 'MXB0121519', '31', '3', '10', 'mario.gamboa@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32144526', 'Mercedes Del Pilar', 'Piña', 'Quijano', 'MXB0031411', '5', '3', '9', 'mercedes.pina@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32144555', 'Alfonso', 'Villarreal', 'Vidal', 'MXB0121528', '29', '3', '5', 'alfonso.villarreal@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32144995', 'Sally Yolanda', 'Avilez', 'Briceño', 'MXB0034602', '24', '1', '9', 'sally.avilez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32145155', 'Alexis Mauricio', 'Palacios', 'Ruíz', 'MXB0031410', '80', '3', '8', 'alexis.palacios@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32145420', 'Adalberto Antonio', 'Martinez', 'Castillo', 'MXB0031411', '80', '3', '9', 'adalberto.martinez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32145456', 'Anevi', 'Aranda', 'Morales', 'MXB0034001', '86', '4', '12', 'anevi.aranda@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32145534', 'Andrés Gaspar', 'Quintal', 'Castillo', 'MXB0031612', '56', '5', '9', 'ossensei@yahoo.com', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32145538', 'María De La Asunción Cecilia', 'Espinosa', 'Garza', 'MXB0033301', '80', '3', '9', 'maria.espinosag@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32145548', 'Mayte José', 'González', 'Madariaga', 'MXB0034001', '10', '4', '12', 'mayte.gonzalez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32146467', 'Olga Paulina', 'Pinzón', 'Balam', 'MXB0034604', '61', '1', '9', 'olga.pinzon@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32146480', 'Edsi', 'Gomez', 'Perez', 'MXB0031413', '80', '3', '9', 'edsi.gomez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32146510', 'Gerardo Manuel', 'Alonzo', 'Medina', 'MXB0031410', '80', '3', '8', 'gerardo.alonzo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32146544', 'María Cristina', 'Osorio', 'Vázquez', 'MXB0031407', '80', '3', '9', 'maria.osoriov@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32146674', 'Eduardo Alberto', 'Ramos', 'Arevalo', 'MXB0034901', '12', '3', '16', 'eduardo.ramos@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32146961', 'Tatiana Macarena', 'Castillo', 'Salazar', 'MXB0034606', '7', '1', '9', 'tatiana.castillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32147070', 'Beatriz Gabriela', 'Flores', 'Bargas', 'MXB0031403', '84', '3', '18', 'beatriz.flores@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32147524', 'Ricardo', 'Ávila', 'Medina', 'MXB0121501', '10', '3', '12', 'ricardo.avila@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32147525', 'Carlos Andrés', 'Wabi', 'Peniche', 'MXB0031410', '33', '3', '5', 'carlos.wabi@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32147527', 'Cinddy Noemí', 'Reyes', 'Mézquita', 'MXB0034404', '10', '3', '12', 'cinddy.reyes@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32147649', 'María Guadalupe', 'Sánchez', 'Trujillo', 'MXB0031405', '80', '3', '9', 'maria.sanchezt@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32147655', 'Jesús Arturo', 'Gutiérrez', 'Barrera', 'MXB0031416', '80', '3', '9', 'jesus.gutierrez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32147656', 'Diana Patricia', 'Luna', 'Mccarthy', 'MXB0034403', '28', '3', '5', 'diana.luna@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32147708', 'María Anunciata', 'López', 'Vales', 'MXB0034301', '46', '1', '4', 'anunciata.lopez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148067', 'Lili Marlene', 'Estrada', 'Avilés', 'MXB0031411', '33', '3', '5', 'lili.estrada@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148074', 'Dora Elia', 'Martínez', 'Faz', 'MXB0034001', '73', '4', '9', 'dora.martinez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148210', 'Maribel Concepción', 'Castro', 'Flota', 'MXB0034001', '11', '4', '12', 'maribel.castro@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148278', 'Armando José', 'González', 'Solís', 'MXB0031414', '80', '3', '9', 'armando.gonzalez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148332', 'Ana Rosa', 'Puerto', 'Ávila', 'MXB0127414', '84', '1', '16', 'ana.puerto@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148606', 'Diana Carolina', 'Espinosa', 'Pérez', 'MXB0034604', '61', '1', '12', 'diana.espinosa@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148648', 'Dafne', 'Domínguez', 'Nolasco', 'MXB0123203', '8', '4', '9', 'dafne.dominguez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148701', 'Jaime Antonio', 'Zaldívar', 'Rae', 'MXB0034401', '27', '3', '5', 'jaime.zaldivar@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148709', 'Ana Lucía', 'Aysa', 'Rodríguez', 'MXB0034608', '44', '1', '9', 'ana.aysa@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148862', 'Miriam Adriana', 'Sanchez', 'Gomez', 'MXB0034001', '60', '4', '9', 'miriam.sanchez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148863', 'Ligia Natalia', 'Gonzalez', 'Gutierrez', 'MXB0031407', '80', '3', '9', 'ligia.gonzalez2@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148865', 'Antonio', 'Rodriguez', 'Alcala', 'MXB0031415', '80', '3', '9', 'antonio.rodriguez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148868', 'Claudia Lorena', 'Castillo', 'Espronceda', 'MXB0034001', '7', '4', '9', 'claudia.castillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148924', 'Fernando', 'Hernandez', 'Tello', 'MXB0031407', '80', '3', '9', 'fernando.hernandez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32148925', 'Raul Jose', 'Espejo', 'Sauri', 'MXB0034301', '4', '1', '9', 'raul.espejo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149072', 'Gilberto Ramon', 'Estrella', 'Suaste', 'MXB0034101', '15', '4', '16', 'gilberto.estrella@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149174', 'Russel Miguel', 'Sanchez', 'Pool', 'MXB0033304', '16', '1', '16', 'russel.sanchez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149175', 'Rosana Patricia', 'Navarro', 'Chim', 'MXB0031411', '88', '3', '12', 'rosana.navarro@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149211', 'José Antonio', 'Silveira', 'Bolio', 'MXB0031407', '51', '3', '3', 'jose.silveira@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149218', 'Viridiana', 'Casas', null, 'MXB0033301', '80', '3', '9', 'viridiana.casas@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149265', 'Jose Ramiro', 'Ortiz', 'Mier Y Teran', 'MXB0034001', '86', '4', '12', 'ramiro.ortiz@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149269', 'Alberto Rene', 'Bolio', 'Vales', 'MXB0121519', '80', '3', '9', 'alberto.bolio@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149485', 'Catalina', 'Palomo', 'Gasca', 'MXB0034407', '26', '3', '5', 'catalina.palomo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149706', 'Eduardo', 'Espinosa', 'Y Macin', 'MXB0031411', '33', '3', '5', 'eduardo.espinosa@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149819', 'Melina Leticia', 'Lopez', 'Acosta', 'MXB0034001', '11', '4', '12', 'melina.lopez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149869', 'Javier', 'Ortiz', 'Sauri', 'MXB0031414', '80', '3', '9', 'javier.ortiz@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149870', 'Maria Gabriela', 'Pérez', 'Bernal', 'MXB0031415', '80', '3', '9', 'gabriela.perez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149910', 'Leydi Diana', 'Lopez', 'Moreno', 'MXB0031407', '83', '3', '12', 'leydi.lopez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149970', 'Leopoldo Manuel', 'Castillo', 'Magaña', 'MXB0031416', '80', '3', '9', 'leopoldo.castillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149973', 'Gary Rusell', 'Murillo', 'Esquivel', 'MXB0033304', '74', '1', '5', 'gary.murillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149975', 'Luis Alonso', 'Vazquez', 'Cruz', 'MXB0031411', '88', '3', '12', 'luis.vazquez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32149977', 'Juliana Margarita', 'Caceres', 'Medina', 'MXB0121527', '29', '3', '9', 'juliana.caceres@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32150470', 'Linabel', 'Novelo', 'Alcocer', 'MXB0034510', '7', '5', '9', 'linabel.novelo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32150583', 'Francisco Javier', 'Rodriguez', 'Martin', 'MXB0031404', '80', '3', '9', 'javier.rodriguezm@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32150757', 'Maricarmen De Atocha', 'Parra', 'Burgos', 'MXB0031410', '84', '3', '16', 'maricarmen.parra@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32150966', 'Ileana Trinidad', 'Varguez', 'Perez', 'MXB0034001', '11', '4', '12', 'ileana.varguez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151164', 'Luisa Maria', 'Payeras', 'Sanchez', 'MXB0034301', '4', '1', '5', 'luisa.payeras@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151397', 'Marcelo', 'Canché', 'Can', 'MXB0034101', '68', '4', '16', 'marcelo.canche@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151435', 'Daniel Alberto', 'Pérez', 'Domínguez', 'MXB0031414', '80', '3', '9', 'daniel.perez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151436', 'Roberto Enrique', 'Reyes', 'Castillo', 'MXB0031411', '88', '3', '12', 'roberto.reyes@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151505', 'David', 'Medina', 'Sabido', 'MXB0031413', '23', '3', '9', 'david.medina@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151595', 'María Jesús', 'Tuyub', 'Dzul', 'MXB0034001', '11', '4', '12', 'maria.tuyub@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151597', 'José Manuel', 'Campo', 'Marrufo', 'MXB0034407', '16', '3', '16', 'jose.campo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151598', 'Wilberth Bibiano', 'Sulú', 'Balam', 'MXB0034101', '68', '4', '16', 'wilberth.sulu@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151600', 'Beatriz Alejandra', 'Castillo', 'López', 'MXB0034407', '5', '3', '9', 'beatriz.castillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151603', 'Maricela', 'Marqueda', 'Alcocer', 'MXB0034301', '69', '1', '5', 'maricela.marqueda@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151614', 'José Daniel', 'Peraza', 'Zermeño', 'MXB0034407', '16', '3', '16', 'daniel.peraza@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151615', 'Angélica Patricia', 'Argaez', 'Morales', 'MXB0031414', '88', '3', '12', 'angelica.argaez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151737', 'Lucía Del Corazón De María', 'Fernández', 'Bandini', 'MXB0031411', '80', '3', '9', 'bandini.lucia@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151835', 'Diana Celina', 'Morcillo', 'Bolio', 'MXB0031411', '10', '3', '16', 'diana.morcillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32151854', 'Sofía', 'Chávez', 'Jacquez', 'MXB0034604', '61', '1', '12', 'sofia.chavez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32152130', 'Natalia Paulina', 'Lizama', 'Dorantes', 'MXB0031612', '56', '5', '9', 'natalia.lizama@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32152177', 'Nidelvia Yolanda', 'Reyes', 'Avila', 'MXB0031411', '88', '3', '12', 'nidelvia.reyes@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32152181', 'María Guadalupe', 'Montalvo', 'López', 'MXB0031604', '10', '5', '12', 'maria.montalvol@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32152377', 'Jorge Eduardo', 'Santos', 'Villafaña', 'MXB0031607', '7', '5', '9', 'jorge.santos@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32152425', 'Orlando Humberto', 'López', 'Osorio', 'MXB0031407', '14', '3', '16', 'orlando.lopez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32152430', 'Fernando', 'Cadena', 'Mejía', 'MXB0031411', '80', '3', '9', 'fernando.cadena@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32152527', 'Porfirio Rodolfo', 'Díaz', 'Negrón', 'MXB0031404', '14', '3', '16', 'porfirio.diaz@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32152638', 'Helly Maricela', 'Burgos', 'Estrella', 'MXB0121508', '29', '3', '5', 'helly.burgos@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32152691', 'Eli Vianey', 'López', 'Ortega', 'MXB0031407', '80', '3', '9', 'eli.lopez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32152778', 'Mariela Concepción', 'Argüelles', 'Guerrero', 'MXB0034001', '13', '4', '12', 'mariela.arguelles@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153244', 'Bruno Abraham', 'López', 'Berumen', 'MXB0031404', '80', '3', '9', 'bruno.lopez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153290', 'Edesio Martin', 'Rodríguez', 'Herrera', 'MXB0031612', '56', '5', '9', 'edesio1972@hotmail.com', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153319', 'Tobías Manuel', 'Blas', 'Zapata', 'MXB0034604', '61', '1', '12', 'tobias.blas@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153323', 'Erick José', 'Poot', 'Ortega', 'MXB0034101', '15', '4', '16', 'erick.poot@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153337', 'Felipe', 'García', 'González', 'MXB0033304', '89', '1', '12', 'felipe.garcia@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153437', 'Florisela Marlene', 'Castillo', 'Quijano', 'MXB0034001', '17', '4', '16', 'florisela.castillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153479', 'Ana Paulina', 'González', 'Anaya', 'MXB0034301', '4', '1', '5', 'paulina.gonzalez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153663', 'José Fernando', 'Pineda', 'Fuentes', 'MXB0033304', '16', '1', '16', 'jose.pineda@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153664', 'Abel', 'Conde', 'Burgos', 'MXB0033305', '10', '1', '12', 'abel.conde@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153815', 'Delfina María', 'Guedimín', 'Bojórquez', 'MXB0127414', '7', '1', '9', 'delfina.guedimin@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153840', 'Niurka', 'Trujillo', 'Paredes', 'MXB0031411', '80', '3', '9', 'niurka.trujillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153844', 'Arturo Alfonso', 'Terrazas', 'Brandt', 'MXB0034601', '18', '1', '16', 'arturo.terrazas@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153871', 'Elizabeth Del Carmen', 'Pérez', 'Aguilar', 'MXB0034301', '84', '1', '16', 'elizabeth.perez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153874', 'Ernesto', 'Saldaña', 'Aportela', 'MXB0031605', '39', '5', '9', 'ernesto.saldana@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153970', 'Orfi Guadalupe', 'Aguayo', 'Rosado', 'MXB0034602', '66', '1', '12', 'orfi.aguayo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32153980', 'María Magdalena', 'Uicab', 'Che', 'MXB0031415', '10', '3', '12', 'maria.uicab@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154094', 'Elizabeth', 'Urias', 'Ibarra', 'MXB0034604', '10', '1', '12', 'elizabeth.urias@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154101', 'Greta Nikolai', 'Molina', 'Gutiérrez', 'MXB0031408', '80', '3', '9', 'greta.molina@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154166', 'Vanessa Guadalupe', 'Martínez', 'Chan', 'MXB0031403', '10', '3', '14', 'vanessa.martinez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154228', 'Jorge Hiram', 'Perez', 'Gomez', 'MXB0034901', '12', '3', '16', 'jorge.perez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154232', 'Isabel', 'Lizarraga', 'Castro', 'MXB0033302', '10', '1', '9', 'isabel.lizarraga@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154240', 'María Gabriela', 'Martín', 'Peón', 'MXB0034401', '7', '3', '9', 'gabriela.martin@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154314', 'Yazmín Orquidia', 'Sabido', 'Perera', 'MXB0031410', '88', '3', '12', 'yazmin.sabido@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154463', 'Sergio Gabriel', 'Tut', 'Aké', 'MXB0034101', '15', '4', '16', 'sergio.tut@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154516', 'Manuel Alberto', 'Navarro', 'Tec', 'MXB0034101', '68', '4', '16', 'manuel.navarro@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154574', 'Rafael', 'Lima', 'Chim', 'MXB0034101', '68', '4', '16', 'rafael.lima@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154582', 'Monica Georgina', 'León', 'Gil', 'MXB0034407', '5', '3', '9', 'monica.leon@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154629', 'Rolando Gonzalo', 'Peniche', 'Marcin', 'MXB0031414', '52', '3', '8', 'rolando.peniche@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154649', 'Wilian Ulises', 'Romero', 'Euan', 'MXB0034101', '15', '4', '16', 'wiliam.romero@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154651', 'Georgina', 'Nieves', 'Metri', 'MXB0034602', '10', '1', '12', 'georgina.nieves@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154693', 'Darling Del Carmen', 'Castillo', 'Cruz', 'MXB0031413', '14', '3', '16', 'darling.castillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154936', 'Luis David', 'Us', 'Vázquez', 'MXB0033304', '16', '1', '16', 'luis.us@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32154937', 'José Roberto', 'Medina', 'Rodriguez', 'MXB0034606', '82', '1', '12', 'jose.medina@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32155174', 'Efraín Alberto', 'Cervantes', 'Cámara', 'MXB0031612', '56', '5', '9', 'efrain.cervantes.camara@gmail.com', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32155229', 'Lourdes Jhoana', 'Solis', 'Navarrete', 'MXB0034001', '79', '4', '16', 'lourdes.solis@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32155231', 'Geovanny Rafael', 'Giorgana', 'Macedo', 'MXB0031410', '80', '3', '8', 'geovanny.giorgana@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32155512', 'María Alejandrina', 'Acevedo', 'Vales', 'MXB0034604', '61', '1', '9', 'alejandrina.acevedo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32155690', 'Aida Dayanara', 'Tamayo', 'Escalante', 'MXB0121501', '35', '3', '5', 'aida.tamayo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32155724', 'Laura Elena', 'Ortega', 'Rosado', 'MXB0121501', '35', '3', '5', 'laura.ortega@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32155726', 'Alejandrina', 'Mejia', 'Ricalde', 'MXB0034001', '72', '4', '9', 'alejandrina.mejia@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32156835', 'Yermak Alexandro', 'Duarte', 'Rosado', 'MXB0031404', '52', '3', '5', 'yermak.duarte@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157008', 'Asuncion Del Rosario', 'Dominguez', 'Ayora', 'MXB0031411', '10', '3', '16', 'asuncion.dominguez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157009', 'Fernando', 'Rodriguez', 'Vargas', 'MXB0031408', '80', '3', '9', 'fernando.rodriguez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157048', 'Ana Meybel', 'Copland', 'Amaya', 'MXB0031407', '80', '3', '9', 'ana.copland@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157288', 'Andrés Iván', 'Oliva', 'Avilés', 'MXB0031410', '80', '3', '8', 'andres.oliva@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157290', 'Jorge Carlos', 'Medina', 'Palma', 'MXB0031416', '80', '3', '9', 'jorge.medina@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157393', 'Leonardo Daniel', 'Yerbes', 'Contreras', 'MXB0031404', '88', '3', '12', 'leonardo.yerbes@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157400', 'Ana Rosa', 'Interian', 'Chuc', 'MXB0034001', '79', '4', '16', 'ana.interian@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157402', 'Ximena', 'Ampudia', 'López Cortijo', 'MXB0034301', '59', '1', '9', 'ximena.ampudia@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157411', 'Laura Rosenda', 'Hernandez', 'Moreno', 'MXB0121506', '10', '3', '12', 'laura.hernandez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157412', 'Erika Maria', 'Escalante', 'Ayuso', 'MXB0034407', '10', '3', '12', 'erika.escalante@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157498', 'Alejandro Esteban', 'Fitzmaurice', 'Cahluni', 'MXB0031403', '80', '3', '9', 'alejandro.fitzmaurice@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157535', 'Jorge Ernesto', 'Peniche', 'Rosales', 'MXB0034407', '64', '3', '12', 'jorge.peniche@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157581', 'Nancy Marlene', 'Quijano', 'Sosa', 'MXB0034604', '7', '1', '9', 'nancy.quijano@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157582', 'Fabiola', 'Echazarreta', 'Montero', 'MXB0034001', '86', '4', '12', 'fabiola.echazarreta@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157584', 'Maria Rosa', 'Pineda', 'Manzanilla', 'MXB0031606', '10', '5', '12', 'maria.pineda@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157585', 'Jossue Alejandro', 'Couoh', 'Guerra', 'MXB0034101', '15', '4', '16', 'josue.couoh@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157586', 'Maria Simoneta', 'Lara', 'Lizarraga', 'MXB0033302', '10', '1', '12', 'maria.lara@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157587', 'Ana Margarita', 'Lavalle', 'Alonso', 'MXB0034301', '10', '1', '12', 'ana.lavalle@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157650', 'Gonzalo Manuel', 'Torres', 'Montalvo', 'MXB0031410', '80', '3', '7', 'gonzalo.torres@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157686', 'Flor Marina', 'Miranda', 'Rosado', 'MXB0034602', '10', '1', '12', 'flor.miranda@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157697', 'Andres Alberto', 'Alpuche', 'Diaz', 'MXB0034101', '15', '4', '16', 'andres.alpuche@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157789', 'Luis Alberto', 'González', 'Uruñuela', 'MXB0034101', '15', '4', '16', 'luis.gonzalez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32157836', 'Nelly Genoveva', 'Garcia', 'Blackaller', 'MXB0031411', '80', '3', '9', 'nelly.garcia@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32159413', 'David Rene', 'Argüelles', 'Barrancos', 'MXB0034901', '12', '3', '16', 'david.arguelles@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32159427', 'Jorge Oswaldo', 'Gómez', 'Ortiz', 'MXB0031407', '80', '3', '9', 'jorge.gomezo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32159479', 'Yazmin Antonia', 'Zapata', 'Díaz', 'MXB0034403', '10', '3', '12', 'yazmin.zapata@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32159481', 'Maria Irene', 'Valencia', 'Cervera', 'MXB0034608', '10', '1', '12', 'maria.cervera@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32159619', 'Oscar Melesio', 'Moreno', 'Castillo', 'MXB0034606', '10', '1', '12', 'oscar.moreno@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32159728', 'Luis Miguel', 'Romero', 'Euan', 'MXB0034101', '15', '4', '16', 'luis.romero@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32159730', 'Rafael Alfonso', 'Dominguez', 'Cervera', 'MXB0121519', '31', '3', '10', 'rafael.dominguez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32159732', 'Mariana Berenice', 'González', 'Leija', 'MXB0034407', '5', '3', '9', 'mariana.gonzalez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32159785', 'Hilda Ivonne', 'Carrera', 'Pérez', 'MXB0034301', '4', '1', '9', 'hilda.carrera@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32159786', 'Joaquina Leonor', 'Dominguez', 'Maldonado', 'MXB0034603', '10', '1', '12', 'joaquina.dominguez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32159882', 'Ramón', 'Bejarano', 'Carrasco', 'MXB0034601', '7', '1', '9', 'ramon.bejarano@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32159883', 'Tania', 'López', 'Ramos', 'MXB0034404', '10', '3', '12', 'tania.lopezr@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32159906', 'Reyna Guadalupe', 'Martinez', 'Valdez', 'MXB0034602', '84', '1', '16', 'reyna.martinez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160002', 'Pamela Elizabeth', 'Cantón', 'Gamboa', 'MXB0034602', '10', '1', '12', 'pamela.canton@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160003', 'Sara Nathali', 'Rafful', 'Soberanis', 'MXB0033302', '10', '1', '12', 'sara.rafful@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160092', 'Luis Alberto', 'González', 'Cincúnegui', 'MXB0033304', '40', '1', '4', 'luis.gonzalezc@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160093', 'Alexandra', 'Pieck', 'Puerto', 'MXB0034608', '10', '1', '12', 'alexandra.pieck@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160205', 'Maricarmen', 'Sabido', 'Basteris', 'MXB0031405', '80', '3', '9', 'maricarmen.sabido@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160207', 'Virginia Meribeth', 'Oropeza', 'Gorocica', 'MXB0031404', '80', '3', '9', 'virginia.oropeza@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160208', 'Jary Davis', 'Couoh', 'Castañeda', 'MXB0031411', '5', '3', '9', 'jary.couoh@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160218', 'Miguel Ángel', 'Rocha', 'Sánchez', 'MXB0031404', '14', '3', '16', 'miguel.rocha@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160223', 'Yerani', 'Recillas', 'Ilizaliturri', 'MXB0034604', '10', '1', '12', 'yerani.recillas@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160333', 'Maria Eugenia', 'Farias', 'Fueyo', 'MXB0034301', '4', '1', '9', 'maria.farias@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160334', 'Roberto Antonio', 'Ortega', 'Rios Covian', 'MXB0034602', '55', '1', '12', 'roberto.ortega@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160335', 'Luis Andres', 'Novelo', 'Castro', 'MXB0121548', '32', '3', '5', 'luis.novelo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160340', 'Almendra Ascencion', 'Mena', 'Aranda', 'MXB0034602', '65', '1', '12', 'almendra.mena@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160391', 'Jessica Selene', 'Bleis', 'Yam', 'MXB0034301', '21', '1', '9', 'jessica.bleis@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160394', 'Jesús Alberto', 'Vázquez', 'Navarrete', 'MXB0033304', '89', '1', '12', 'jesus.vazquez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160407', 'María De Guadalupe', 'Nabté', 'Escamilla', 'MXB0031408', '88', '3', '12', 'maria.nabte@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160437', 'Manuel', 'Olea', 'Martínez', 'MXB0031403', '88', '3', '13', 'manuel.olea@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160469', 'Mariel', 'Góngora', 'González', 'MXB0034901', '12', '3', '16', 'mariel.gongora@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160511', 'Brenda', 'Andrade', 'Nuñez', 'MXB0031404', '80', '3', '9', 'brenda.andrade@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160580', 'Ileana Isabel', 'González', 'Angulo', 'MXB0121501', '35', '3', '5', 'ileana.gonzalez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160581', 'Miguel Francisco', 'Pech', 'Argüelles', 'MXB0033304', '16', '1', '16', 'miguel.pech@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160582', 'Adriana Raquel', 'Puc', 'Rodríguez', 'MXB0031606', '10', '5', '12', 'adriana.puc@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160583', 'Stacy', 'Lara', 'Mena', 'MXB0034604', '10', '1', '12', 'stacy.lara@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160755', 'Gloria', 'Peniche', 'Gómez', 'MXB0121501', '6', '3', '10', 'gloria.peniche@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160756', 'María Antonieta', 'Pacheco', 'Pantoja', 'MXB0031407', '80', '3', '9', 'maria.pacheco@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160764', 'Juan Andrés', 'Palomo', null, 'MXB0034606', '82', '1', '12', 'juan.palomo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160812', 'Ileana Cristina', 'Escalante', 'Alpuche', 'MXB0031607', '57', '5', '12', 'ileana.escalante@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160871', 'Elsa Beatriz', 'Jiménez', 'Urcelay', 'MXB0031407', '80', '3', '9', 'elsa.jimenez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160873', 'Karla Yaneth', 'Bravo', 'Vargas', 'MXB0034601', '85', '1', '12', 'karla.bravo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160877', 'Enrique', 'Poot', 'Palma', 'MXB0033304', '16', '1', '16', 'enrique.poot@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160908', 'Daniel Alejandro', 'Xix', 'Tzakum', 'MXB0034001', '18', '4', '16', 'daniel.xix@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160909', 'Mariana', 'Romero', 'García', 'MXB0034602', '55', '1', '12', 'mariana.romero@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32160969', 'Alicia Reneé', 'Carrasco', 'Azcuaga', 'MXB0034602', '10', '1', '12', 'alicia.carrasco@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161036', 'Grecia Estefanía', 'Berber', 'Selem', 'MXB0031413', '14', '3', '20', 'grecia.berber@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161038', 'Gonzalo Enrique', 'Esquivel', 'Martínez', 'MXB0031411', '14', '3', '18', 'gonzalo.esquivel@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161042', 'Erika Astrid', 'Gutiérrez', 'Ramírez', 'MXB0031411', '14', '3', '17', 'erika.gutierrez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161044', 'Yohanna', 'Alfaro', 'Herrera', 'MXB0031414', '14', '3', '16', 'yohanna.alfaro@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161047', 'Ileana Guadalupe', 'Ortega', 'González', 'MXB0121506', '30', '3', '5', 'ileana.ortega@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161048', 'Fernando Humberto', 'Aguilar', 'Torres', 'MXB0031411', '14', '3', '20', 'fernando.aguilar@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161083', 'Eduardo José', 'Abreu', 'Pérez', 'MXB0121519', '80', '3', '9', 'eduardo.abreu@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161099', 'Naomy Del Pilar', 'Bastarrachea', 'May', 'MXB0121519', '80', '3', '9', 'naomy.bastarrachea@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161233', 'Lucia Jaqueline', 'Ramos', 'Gómez', 'MXB0121519', '80', '3', '9', 'lucia.ramos@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161243', 'Mildred Beatriz', 'Salas', 'Ley', 'MXB0121519', '80', '3', '9', 'mildred.salas@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161296', 'Edwin Manuel', 'Rosas', 'Caballero', 'MXB0031410', '88', '3', '12', 'edwin.rosas@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161372', 'Manuel Hernán', 'Hoyos', 'Pinzón', 'MXB0031414', '80', '3', '9', 'manuel.hoyos@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161402', 'Rubi Del Socorro', 'Moguel', 'Ojeda', 'MXB0121519', '80', '3', '9', 'rubi.moguel@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161632', 'Pedro Antonio', 'Mendoza', 'Aguilar', 'MXB0031612', '56', '5', '9', 'pamakeb@hotmail.com', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161633', 'Yuselmy Fabiola', 'López', 'Nah', 'MXB0034001', '11', '4', '12', 'yuselmy.lopez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161636', 'Yussiff Emmanuel', 'Pérez', 'Méndez', 'MXB0034101', '10', '4', '12', 'yussiff.perez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161674', 'Kevin Alberto', 'Cruz', 'Ricalde', 'MXB0034301', '4', '1', '9', 'kevin.cruz@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161675', 'Nury Fernanda', 'Evia', 'Ceballos', 'MXB0031602', '34', '5', '5', 'nury.evia@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161770', 'Rodrigo', 'González', 'Somonte', 'MXB0031403', '88', '3', '15', 'rodrigo.gonzalez2@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161773', 'Mónica', 'Sierra', 'González', 'MXB0034301', '59', '1', '9', 'monica.sierra@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161867', 'Farrah Silvana', 'Ferro', 'Muñoz', 'MXB0121501', '6', '3', '11', 'farrah.ferro@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161868', 'María Lucía', 'Bolio', 'Martínez', 'MXB0031605', '10', '5', '12', 'lucia.bolio@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32161974', 'Angélica', 'Brizuela', 'Gabriel', 'MXB0031605', '10', '5', '12', 'angelica.brizuela@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162014', 'Gerardo Iván', 'Salgado', 'Ríos', 'MXB0034603', '42', '1', '5', 'gerardo.salgado@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162062', 'Ayerím Del Rosario', 'Vallejo', 'Álvarez', 'MXB0031604', '34', '5', '5', 'ayerim.vallejo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162093', 'Erika Del Socorro', 'Enríquez', 'Vázquez', 'MXB0034407', '41', '3', '8', 'erika.enriquezv@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162270', 'Johann Erasto', 'Jimenez', 'Bautista', 'MXB0034602', '66', '1', '12', 'johann.jimenez@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162275', 'Noé De Jesús', 'Tec', 'Cetina', 'MXB0121519', '80', '3', '9', 'noe.tec@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162282', 'Roberto Iván', 'Puc', 'Pool', 'MXB0121519', '80', '3', '9', 'roberto.puc@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162285', 'Adriana Gabriela', 'Carrillo', 'Peraza', 'MXB0121519', '80', '3', '9', 'adriana.carrillo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162288', 'Minerva Stephani', 'Vargas', 'Chávez', 'MXB0121519', '80', '3', '9', 'minerva.vargas@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162289', 'Eduardo José', 'Gutierrez', 'Peniche', 'MXB0121519', '80', '3', '9', 'eduardo.gutierrezp@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162403', 'Andrea', 'Gómez', 'Domenzáin', 'MXB0031604', '10', '5', '12', 'andrea.gomezd@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162406', 'Marcos Daniel', 'Lugo', 'Ancona', 'MXB0121519', '80', '3', '9', 'marcos.lugo@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162408', 'Patricia Isabel', 'González', 'Calcáneo', 'MXB0031414', '14', '3', '16', 'patricia.gonzalezg@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162409', 'Pamela', 'Kemp', 'Medina', 'MXB0034510', '10', '5', '12', 'pamela.kemp@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162414', 'Marcelo Ulises', 'Quijano', 'Ricalde', 'MXB0034001', '86', '4', '12', 'marcelo.quijano@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162491', 'Gicel', 'Córdoba', 'Pech', 'MXB0033304', '89', '1', '12', 'gicel.cordoba@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162547', 'Carola Hortensia', 'Rivera de Vargas', null, 'MXB0127414', '7', '1', '9', 'carola.rivera@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162548', 'Carlos Alberto', 'Palma', 'Castillo', 'MXB0033302', '10', '1', '12', 'carlos.palma@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162549', 'Marvin', 'Arcos', 'Solis', 'MXB0034606', '82', '1', '12', 'marvin.arcos@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162550', 'Cristina Gisela', 'Canto', 'Herrera', 'MXB0127414', '5', '1', '9', 'cristina.canto@anahuac.mx', '2016-05-27 21:47:06', '0');
INSERT INTO `empleados` VALUES ('32162559', 'David', 'Mir', 'Gil', 'MXB0031415', '80', '3', '9', 'david.mir@anahuac.mx', '2016-05-27 21:47:06', '0');

-- ----------------------------
-- Table structure for empleados_source
-- ----------------------------
DROP TABLE IF EXISTS `empleados_source`;
CREATE TABLE `empleados_source` (
  `empleado` int(11) NOT NULL,
  `apellido_paterno` varchar(255) DEFAULT NULL,
  `apellido_materno` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `id_departamento` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `departamento` varchar(255) DEFAULT NULL,
  `puesto` varchar(255) DEFAULT NULL,
  `nivel` varchar(255) DEFAULT NULL,
  `id_jefe` int(11) DEFAULT NULL,
  `jefe` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of empleados_source
-- ----------------------------
INSERT INTO `empleados_source` VALUES ('32122411', 'Anguiano', 'Avila', 'Luis Oscar', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Asistente de dirección                  ', 'Mandos medios y profesorado 2', '2', 'Peñúñuri Munguía P. Ulises', 'luis.anguiano@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32123111', 'Gutierrez', 'Martinez', 'Luis Ernesto', '10000284', 'Rectoría', 'MXB0034606 - Dirección de Desarrollo Institucional', 'Director de desarrollo institucional    ', 'Direcciones 2', '1', 'Pardo Hervás P.Rafael', 'luis.gutierrez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32123705', 'Allen', 'Novelo', 'Nina Rosa', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico', 'Asistente académico                     ', 'Mandos medios y profesorado 2', '32124245', 'Guzmán Silva Susana', 'nina.allen@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124170', 'Flores', 'May', 'Gaspar', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124202', 'Zaldivar Álvarez Antonio', 'gaspar.flores@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124172', 'Vegue', 'Corbacho', 'David', '10000222', 'Vicerrectoría Académica', 'MXB0031416 - Coordinación de humanidades', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124183', 'Otero Rejón Francisco Javier', 'david.vegue@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124174', 'López', 'Rodriguez', 'Paula Patricia', '10000213', 'Vicerrectoría Académica', 'MXB0031405 - Derecho', 'Secretario(a) de departamento           ', 'Operativos 2', '32124350', 'Álvarez Escalante Absalón', 'patricia.lopez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124176', 'Chi', 'Canul', 'Martha Angelica', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Secretaria de depto.', 'Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2', '32124289', 'Echazarreta Montero Jhoanna', 'martha.chi@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124178', 'Rejón', 'Martínez', 'Lidia Maricruz', '10004062', 'Rectoría', 'MXB0033302 - Dirección de Administraci', 'Auxiliar administrativo                 ', 'Operativos 1', '32124975', 'Rodriguez Pech Mayte Eugenia', 'maricruz.rejon@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124181', 'Mendoza', 'Villalobos', 'Alejandra', '10002630', 'Vicerrectoría Académica', 'MXB0121501 - Dirección de Posgrados y Extensión', 'Director de programas de posgrado y exte', 'Direcciones 2', '32142632', 'Acuña González Narciso Antonio', 'alejandra.mendoza@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124183', 'Otero', 'Rejón', 'Francisco Javier', '10000222', 'Vicerrectoría Académica', 'MXB0031416 - Coordinación de humanidades', 'Coordinador general de humanidades      ', 'Direcciones 2', '32142632', 'Acuña González Narciso Antonio', 'francisco.otero@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124184', 'Carrillo', 'Acosta', 'María Cristina', '10000267', 'Vicerrectoría Académica', 'MXB0034401 - Vicerrectoría Académica', 'Secretario (a) de la Dirección          ', 'Operativos 1', '32142632', 'Acuña González Narciso Antonio', 'cristina.carrillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124185', 'Martín', 'Gómez', 'Rubí Candelaria', '10004065', 'Rectoría', 'MXB0033305 - Centro de Atención Alumnos', 'Secretario(a) de departamento           ', 'Operativos 2', '32142652', 'Castro Ávila Eduardo', 'rubi.martin@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124186', 'Narváez', 'Galaz', 'Lia Regina', '10000282', 'Rectoría', 'MXB0034604 - Gerencia de Recursos humanos', 'Gerente de recursos humanos             ', 'Mandos medios y profesorado 1 ', '1', 'Pardo Hervás P.Rafael', 'lia.narvaez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124187', 'Sandoval', 'Vázquez', 'María Del Carmen', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Auxiliar administrativo                 ', 'Operativos 1', '32124226', 'Anaya Sandoval Juan Antonio', 'carmen.sandoval@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124188', 'Chávez', 'Reyes', 'María Del Rocío', '10004062', 'Rectoría', 'MXB0033302 - Dirección de Administraci', 'Jefe de servicios escolares externos    ', 'Mandos medios y profesorado 1 ', '32124315', 'Peniche Sanguino Astrid Marvin', 'rocio.chavez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124189', 'Ontiveros', 'Velázquez', 'Julio Antonio', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Jefe de servicios generales             ', 'Mandos medios y profesorado 2', '2', 'Peñúñuri Munguía P. Ulises', 'julio.ontiveros@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124190', 'Hernández', 'Loeza', 'María Guadalupe', '10000213', 'Vicerrectoría Académica', 'MXB0031405 - Derecho', 'Auxiliar administrativo                 ', 'Operativos 1', '32124350', 'Álvarez Escalante Absalón', 'guadalupe.hernandez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124192', 'Negroe', 'Monforte', 'Benjamín Ramón', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - Economía y Negocios', 'Director de programa académico          ', 'Mandos medios y profesorado 1 ', '32149211', 'Silveira Bolio José Antonio', 'benjamin.negroe@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124193', 'Cirerol', 'León', 'Annette Dinorah', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Auxiliar administrativo                 ', 'Operativos 1', '32142667', 'Castro Landeros María Alicia', 'annete.cirerol@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124194', 'Cervera', null, 'María Guadalupe Del Carmen', '10004057', 'Vicerrectoría de Formación Integral', 'MXB0031607 - Vicerrectoría de Formación Integral', 'Auxiliar administrativo                 ', 'Operativos 1', '32124321', 'Franco Calvillo José Rodrigo ', 'guadalupe.cervera@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124195', 'Tello', 'Rodriguez', 'Martha María', '10000221', 'Vicerrectoría Académica', 'MXB0031415 - Arquitectura', 'Director de programa académico          ', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 ', '32142632', 'Acuña González Narciso Antonio', 'martha.tello@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124196', 'Zárate', 'Medina', 'Mercedes', '10000268', 'Vicerrectoría Académica', 'MXB0034403 - Operación Académica', 'Auxiliar administrativo                 ', 'Operativos 1', '32147656', 'Luna McCarthy Diana Patricia', 'mercedes.zarate@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124197', 'Cel', 'Briceño', 'Eduardo Fernando', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Jardinero                               ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'eduardo.cel@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124198', 'Ayala', 'Fernández', 'Debora', '10004061', 'Vicerrectoría Académica', 'MXB0033301 - Centro de Lenguas', 'Auxiliar administrativo                 ', 'Operativos 1', '32137041', 'Towle Wachenheim Judith Margarete', 'debora.ayala@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124199', 'Cachón', 'Medrano', 'Enrique De Jesus', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Chofer mensajero                        ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'enrique.cachon@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124202', 'Zaldivar', 'Álvarez', 'Antonio', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Jefe de servicios generales             ', 'Mandos medios y profesorado 2', '2', 'Peñúñuri Munguía P. Ulises', 'antonio.zaldivar@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124206', 'Dominguez', 'Cherit', 'Luciano Diab', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Profesor universitario                  ', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y', '32142661', 'Rivera Rovelo Jorge', 'luciano.dominguez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124209', 'Tello', 'Rodriguez', 'Marisol', '10000211', 'Vicerrectoría Académica', 'MXB0031403 - Ciencias de la Comunicación', 'Director de programa académico          ', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 ', '32142632', 'Acuña González Narciso Antonio', 'marisol.tello@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124210', 'Barroso', 'Tanoira', 'Francisco Gerardo', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124192', 'Negroe Monforte Benjamín Ramón', 'francisco.barroso@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124213', 'Chin', 'Pool', 'Zolly Herlinda', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Técnico de laboratorio y/o taller       ', 'Operativos 1', '32142651', 'Echeverría y Eguiluz José Manuel', 'zolly.chin@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124214', 'Aquino', 'Hernández', 'Pedro Ricardo', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Técnico de laboratorio y/o taller       ', 'Operativos 1', '32142651', 'Echeverría y Eguiluz José Manuel', 'pedro.aquino@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124215', 'Ibañez', 'Gómez', 'Katinka Elizabeth', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Coordinador de campos clínicos          ', 'Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y', '32142651', 'Echeverría y Eguiluz José Manuel', 'katinka.ibanez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124216', 'Pedro', 'Fernández', 'Karim Fernando', '10000279', 'Rectoría', 'MXB0034601 - Rectoría UA Mayab', 'Asistente ejecutivo de rectoría         ', 'Mandos medios y profesorado 1 ', '1', 'Pardo Hervás P.Rafael', 'karim.pedro@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124218', 'Carrillo', 'Hernández', 'Jorge Abraham', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124202', 'Zaldivar Álvarez Antonio', 'jorge.carrillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124222', 'Vera', 'Cardeña', 'Marisol Guadalupe', '10004062', 'Rectoría', 'MXB0033302 - Dirección de Administraci', 'Auxiliar administrativo                 ', 'Operativos 1', '32124975', 'Rodriguez Pech Mayte Eugenia', 'marisol.vera@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124223', 'Pacheco', 'Pantoja', 'Elda Leonor', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32148067', 'Estrada Avilés Lili Marlene', 'elda.pacheco@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124224', 'Herrera', 'Baas', 'Florángely', '10000280', 'Rectoría', 'MXB0034602 - Coordinación de Comunicación', 'Coordinador de comunicación             ', 'Mandos medios y profesorado 1 ', '1', 'Pardo Hervás P.Rafael', 'florangely.herrera@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124225', 'González', 'Novelo', 'José Alejandro', '10000215', 'Vicerrectoría Académica', 'MXB0031408 - Psicología', 'Director de programa académico          ', 'Mandos medios y profesorado 1 ', '32142632', 'Acuña González Narciso Antonio', 'alejandro.gonzalezn@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124226', 'Anaya', 'Sandoval', 'Juan Antonio', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - Ingeniería', 'Director de división académica          ', 'Direcciones 2', '32142632', 'Acuña González Narciso Antonio', 'antonio.anaya@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124227', 'Zapata', 'Carrillo', 'Silvia Zuhalia', '10000211', 'Vicerrectoría Académica', 'MXB0031403 - Ciencias de la Comunicación', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124209', 'Tello Rodriguez Marisol', 'silvia.zapata@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124229', 'Achach', 'Solís', 'Marisol', '10000269', 'Vicerrectoría Académica', 'MXB0034401 - Vicerrectoría Académica', 'Coordinador de relaciones académicas    ', 'Mandos medios y profesorado 1 ', '32142632', 'Acuña González Narciso Antonio', 'marisol.achach@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124233', 'Cohuo', 'Chin', 'Inocencio', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Jardinero                               ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'inocencio.cohuo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124234', 'Peraza', 'Rosas', 'María Jazmine Del Carmen', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Jefe de servicios computacionales       ', 'Mandos medios y profesorado 1 ', '32160092', 'González Cincúnegui Luis Alberto', 'jazmine.peraza@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124235', 'Barrera', 'Martínez', 'Antonio', '10000279', 'Rectoría', 'MXB0034601 - Rectoría UA Mayab', 'Asistente ejecutivo de rectoría         ', 'Mandos medios y profesorado 1 ', '1', 'Pardo Hervás P.Rafael', 'antonio.barrera@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124236', 'Cruz', 'López', 'Anna Karina', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico', 'Especialista en Desarrollo de Medios    ', 'Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y', '32124245', 'Guzmán Silva Susana', 'anna.cruz@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124238', 'Torreblanca', 'Rios', 'Fernando Antonio', '10000287', 'Vicerrectoría Académica', 'MXB0034901 - Biblioteca', 'Jefe de biblioteca                      ', 'Mandos medios y profesorado 1 ', '32147656', 'Acuña González Narciso Antonio', 'fernando.torreblanca@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124243', 'Euan', 'Calderón', 'Eugenia Beatriz', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Jefe de Contabilidad                    ', 'Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profeso', '32124341', 'Martínez González Leonor Beatriz', 'eugenia.euan@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124245', 'Guzmán', 'Silva', 'Susana Enriqueta', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico e Investigación', 'Director de desarrollo académico        ', 'Direcciones 2', '32142632', 'Acuña González Narciso Antonio', 'susana.guzman@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124248', 'Peniche', 'Rivero', 'Yngrid', '10000282', 'Rectoría', 'MXB0034604 - Gerencia de Recursos humanos', 'Auxiliar administrativo                 ', 'Operativos 1', '32124186', 'Narváez Galaz Lia Regina', 'yngrid.peniche@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124249', 'Pérez', 'Varguez', 'Carlos Gaspar', '10000211', 'Vicerrectoría Académica', 'MXB0031403 - Ciencias de la Comunicación', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124209', 'Tello Rodriguez Marisol', 'carlos.perez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124250', 'Vidal', 'Carrillo', 'Anna Carolina', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico MXB0034407 - Desarrollo Académico', 'Asistente académico                     ', 'Mandos medios y profesorado 2', '32162093', 'Enríquez Vázquez Ericka Del Socorro', 'anna.vidal@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124253', 'Santana', 'Cab', 'Luis Enrique', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124202', 'Zaldivar Álvarez Antonio', 'luis.santana@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124254', 'Pedrero', 'Aguilar', 'Lissett Beatriz', '10000212', 'Vicerrectoría Académica', 'MXB0031404 - Diseño', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32156835', 'Duarte Rosado Yermak Alexandro', 'lissett.pedrero@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124255', 'Escalante', 'Góngora', 'Gretty Guadalupe', '10000211', 'Vicerrectoría Académica', 'MXB0031403 - Ciencias de la Comunicación', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124209', 'Tello Rodriguez Marisol', 'gretty.escalante@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124256', 'Estrada', 'Medina', 'Rubí Margarita', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Secretario (a) de la Dirección          ', 'Operativos 1', '2', 'Peñúñuri Munguía P. Ulises', 'rubi.estrada@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124257', 'Barrera', 'Bustillos', 'Martha Eugenia', '10000219', 'Vicerrectoría Académica', 'MXB0031413 - Nutrición', 'Director de programa académico          ', 'Mandos medios y profesorado 1 ', '32142632', 'Acuña González Narciso Antonio', 'martha.barrera@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124263', 'Durán', 'Yabur', 'Margarita Concepción', '10000212', 'Vicerrectoría Académica', 'MXB0031404 - Diseño', 'Secretario(a) de departamento           ', 'Operativos 2', '32156835', 'Duarte Rosado Yermak Alexandro', 'margarita.duran@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124267', 'Cardós', 'Santoyo', 'Fermín Orlando', '10004063', 'Rectoría', 'MXB0033303 - Dirección Servicios Institucionales y Pl', 'Director de Servicios Institucionales y PlaneaciónDirector de Servicios Institucionales y PlaneaciónDirector de Servicios Institucionales y PlaneaciónDirector de Servicios Institucionales y PlaneaciónDirector de Servicios Institucionales y PlaneaciónDirec', 'Direcciones 1', '1', 'Pardo Hervás P.Rafael', 'fermin.cardos@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124269', 'Farjat', 'Aguilar', 'Argel Antonio', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico', 'Especialista en Desarrollo de Medios    ', 'Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y', '32124245', 'Guzmán Silva Susana', 'argel.farjat@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124272', 'Ortiz', 'Suárez', 'Alicia Del Carmen', '10000215', 'Vicerrectoría Académica', 'MXB0031408 - Psicología', 'Auxiliar administrativo                 ', 'Operativos 1', '32124225', 'González Novelo José Alejandro', 'alicia.ortiz@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124274', 'García', 'Hinojosa', 'Julián', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124202', 'Zaldivar Álvarez Antonio', 'julian.garcia@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124275', 'Díaz', 'Aguilar', 'Julia Amanda', '10003298', 'Vicerrectoría Académica', 'MXB0121504 - Mtria. Admon. Publica (mid)', 'Coordinador de posgrados                ', 'Mandos medios y profesorado 1 ', '32124350', 'Álvarez Escalante Absalón', 'julia.diaz@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124276', 'Pool', 'Pech', 'Jose Mauricio', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Jardinero                               ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'jose.pool@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124278', 'Acevedo', 'Marentes', 'Fernando Enrique', '10002630', 'Vicerrectoría Académica', 'MXB0121501 - Dirección de Posgrados y Extensión', 'Asistente académico                     ', 'Mandos medios y profesorado 2', '32124181', 'Mendoza Villalobos Alejandra', 'fernando.acevedo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124279', 'Cen', 'Caamal', 'Marisol', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124192', 'Negroe Monforte Benjamín Ramón', 'marisol.cen@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124281', 'Sansores', 'Sánchez', 'María Eugenia', '10000268', 'Vicerrectoría Académica', 'MXB0034403 - Operación Académica', 'Secretario(a) de departamento           ', 'Operativos 2', '32147656', 'Luna McCarthy Diana Patricia', 'maria.sansores@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124282', 'Sansores', 'Ruz', 'Andrea Josefina', '10004061', 'Vicerrectoría Académica', 'MXB0033301 - Centro de Lenguas', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32137041', 'Towle Wachenheim Judith Margarete', 'andrea.sansores@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124284', 'Castillo', 'Pompeyo', 'Carlos Alberto', '10000219', 'Vicerrectoría Académica', 'MXB0031413 - Nutrición', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124257', 'Barrera Bustillo Martha Eugenia', 'carlos.castillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124289', 'Echazarreta', 'Montero', 'Jhoanna', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Jefe de compras                         ', 'Mandos medios y profesorado 2', '2', 'Peñúñuri Munguía P. Ulises', 'jhoanna.echazarreta@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124291', 'Herrera', 'Cámara', 'Gabriela Del Socorro', '10000267', 'Vicerrectoría Académica', 'MXB0034401 - Vicerrectoría Académica', 'Secretario (a) de la Dirección          ', 'Operativos 1', '32142632', 'Acuña González Narciso Antonio', 'gabriela.herrera@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124292', 'Urzaiz', 'Lares', 'Jose Gabriel', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Profesor universitario                  ', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 ', '32142661', 'Rivera Rovelo Jorge', 'gabriel.urzaiz@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124302', 'Ruiz', 'Medina', 'Francisco Santiago', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124202', 'Zaldivar Álvarez Antonio', 'francisco.ruiz@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124303', 'Urzúa', 'Navarrete', 'Andrea Susana', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32142658', 'Ortiz Heredia Hansel Francisco', 'andrea.urzua@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124304', 'Mendoza', 'Noh', 'Beatriz Anilú', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Especialista de soporte a sistemas      ', 'Mandos medios y profesorado 2', '32160092', 'González Cincúnegui Luis Alberto', 'anilu.mendoza@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124313', 'Martinez', 'Rodriguez', 'Maria Cecilia', '10004065', 'Rectoría', 'MXB0033305 - Centro de Atención Alumnos', 'Secretario(a) de departamento           ', 'Operativos 2', '32142652', 'Castro Ávila Eduardo', 'cecilia.martinez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124314', 'Biachi', 'Valencia', 'Ligia Beatriz', '10000212', 'Vicerrectoría Académica', 'MXB0031404 - Diseño', 'Auxiliar administrativo                 ', 'Operativos 1', '32156835', 'Duarte Rosado Yermak Alexandro', 'ligia.biachi@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124315', 'Peniche', 'Sanguino', 'Astrid Marvin', '10004062', 'Rectoría', 'MXB0033302 - Dirección de Administraci', 'Director de administración escolar y nor', 'Direcciones 2', '32124267', 'Cardós Santoyo Fermín', 'astrid.peniche@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124317', 'Correa', 'Cruz', 'Daniel Alberto', '10000287', 'Vicerrectoría Académica', 'MXB0034901 - Biblioteca', 'Auxiliar de Biblioteca                  ', 'Operativos 2', '32124238', 'Torreblanca Rios Fernando Antonio', 'daniel.correa@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124320', 'Hornelas', 'Pineda', 'Carlos Manuel', '10000211', 'Vicerrectoría Académica', 'MXB0031403 - Ciencias de la Comunicación', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124209', 'Tello Rodriguez Marisol', 'carlos.hornelas@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124321', 'Franco', 'Calvillo', 'José Rodrigo', '10004203', 'Vicerrectoría de Formación Integral', 'MXB0031612 - Coordinación de Selecciones y Ac. Deport', 'Coordinador de selec y academias deporti', 'Mandos medios y profesorado 1 ', '1', 'Pardo Hervás P.Rafael', 'rodrigo.franco@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124328', 'Cohuo', 'Chin', 'Eusebio', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124202', 'Zaldivar Álvarez Antonio', 'eusebio.cohuo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124329', 'Crespo', 'Canté', 'Gener Ricardo', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Técnico de laboratorio y/o taller       ', 'Operativos 1', '32142651', 'Echeverría y Eguiluz José Manuel', 'gener.crespo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124330', 'Padrón', 'Chim', 'Consepción', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Jardinero                               ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'consepcion.padron@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124331', 'Mijangos', 'Naal', 'Rosa Eugenia', '10000287', 'Vicerrectoría Académica', 'MXB0034901 - Biblioteca', 'Supervisor de servicios al público      ', 'Mandos medios y profesorado 2', '32124238', 'Torreblanca Rios Fernando Antonio', 'rosa.mijangos@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124333', 'Centeno', 'Sarabia', 'Elsy Noemi', '10000222', 'Vicerrectoría Académica', 'MXB0031416 - Coordinación de humanidades', 'Auxiliar administrativo                 ', 'Operativos 1', '32124183', 'Otero Rejón Francisco Javier', 'elsy.centeno@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124335', 'Fournier', 'Montiel', 'José Guillermo', '10000212', 'Vicerrectoría Académica', 'MXB0031404 - Diseño', 'Profesor universitario                  ', 'Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y', '32156835', 'Duarte Rosado Yermak Alexandro', 'guillermo.fournier@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124336', 'Dzib', 'Chan', 'Martha Patricia', '10004062', 'Rectoría', 'MXB0033302 - Dirección de Administraci', 'Auxiliar administrativo                 ', 'Mandos medios y profesorado 2', '32124975', 'Rodriguez Pech Mayte Eugenia', 'patricia.dzib@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124341', 'Martínez', 'González', 'Leonor Beatriz Del Socorro', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Contralor                               ', 'Direcciones 2', '2', 'Peñúñuri Munguía P. Ulises', 'leonor.martinez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124342', 'Luna', 'Martínez', 'Jose Luis', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Coordinador de campos clínicos          ', 'Mandos medios y profesorado 2', '32142651', 'Echeverría y Eguiluz José Manuel', 'jose.lunam@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124343', 'Medina', 'Lara', 'Aurea Rosa', '10000219', 'Vicerrectoría Académica', 'MXB0031413 - Nutrición', 'Auxiliar administrativo                 ', 'Operativos 1', '32124257', 'Barrera Bustillo Martha Eugenia', 'aurea.medina@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124344', 'Escobedo', 'García', 'María Adela', '10004065', 'Rectoría', 'MXB0033305 - Centro de Atención Alumnos', 'Secretario(a) de departamento           ', 'Operativos 2', '32142652', 'Castro Ávila Eduardo', 'maria.escobedo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124346', 'Esquivel', 'Cortés', 'Eric José', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124192', 'Negroe Monforte Benjamín Ramón', 'eric.esquivel@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124348', 'Amaya', 'Pérez', 'Ada Luz', '10002630', 'Vicerrectoría Académica', 'MXB0121501 - Dirección de Posgrados y Extensión', 'Secretario (a) de la Dirección          ', 'Operativos 1', '32124181', 'Mendoza Villalobos Alejandra', 'ada.amaya@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124349', 'Rodriguez', 'Pantoja', 'Rocio Elizabeth', '10000222', 'Vicerrectoría Académica', 'MXB0031416 - Coordinación de humanidades', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124183', 'Otero Rejón Francisco Javier', 'rocio.rodriguez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124350', 'Álvarez', 'Escalante', 'Absalón', '10000213', 'Vicerrectoría Académica', 'MXB0031405 - Derecho', 'Director de programa académico          ', 'Mandos medios y profesorado 1 ', '32142632', 'Acuña González Narciso Antonio', 'absalon.alvarez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124351', 'Kumán', 'Dzul', 'Andres', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Jardinero                               ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'andres.kuman@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124355', 'San Miguel', 'Alvarado', 'Africa', '10004090', 'Rectoría', 'MXB0127414 - Oficina de Transferencia', 'Secretario(a) de departamento           ', 'Operativos 2', '32143434', 'Garza Roche Regina', 'africa.sanmiguel@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124359', 'Guardia', 'Chi', 'Cándido', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Jardinero                               ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'candido.guardia@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124363', 'Casanova', 'López', 'Rosa María', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Auxiliar administrativo                 ', 'Operativos 1 ', '32148074', 'Martínez Faz Dora Elia', 'rosa.casanova@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124365', 'Ramos', 'Medina', 'Jessica Guadalupe', '10004063', 'Rectoría', 'MXB0033303 - Dirección Servicios Institucionales y Pl', 'Asistente de dirección                  ', 'Mandos medios y profesorado 2', '32124267', 'Cardós Santoyo Fermín', 'jessica.ramos@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124366', 'Muñoz', 'Zetina', 'Adrián Baltazar', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124202', 'Zaldivar Álvarez Antonio', 'adrian.munoz@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124370', 'Carrillo', 'Marin', 'Jose  Alfredo', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Auxiliar técnico                        ', 'Operativos 2', '32124234', 'Peraza Rosas María Jazmine del Carmen', 'jose.carrillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124898', 'Escamilla', 'Borges', 'Lucy Del Carmen', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Auxiliar administrativo                 ', 'Operativos 1', '32124192', 'Negroe Monforte Benjamín Ramón', 'lucy.escamilla@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124903', 'Burgos', 'Montes De Oca', 'María Cristina', '10000213', 'Vicerrectoría Académica', 'MXB0031405 - Derecho', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124350', 'Álvarez Escalante Absalón', 'cristina.burgos@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32124975', 'Rodríguez', 'Pech', 'Mayte Eugenia', '10004062', 'Rectoría', 'MXB0033302 - Dirección de Administraci', 'Jefe de servicios escolares intern y aud', 'Mandos medios y profesorado 1 ', '32124315', 'Peniche Sanguino Astrid Marvin', 'mayte.rodriguez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32133083', 'Rosado', 'Richard', 'Isabel Guadalupe', '10004061', 'Vicerrectoría Académica', 'MXB0033301 - Centro de Lenguas', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32137041', 'Towle Wachenheim Judith Margarete', 'isabel.rosado@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32133367', 'Alpizar', 'Rodríguez', 'Marian', '10000219', 'Vicerrectoría Académica', 'MXB0031413 - Nutrición', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124257', 'Barrera Bustillo Martha Eugenia', 'marian.alpizar@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32133467', 'Osuna', 'Enríquez', 'Raúl Armando', '10004203', 'Vicerrectoría de Formación Integral', 'MXB0031612 - Coordinación de Selecciones y Ac. Deport', 'Entrenador de Selecciones               ', 'Mandos medios y profesorado 2', '32124321', 'Franco Calvillo José Rodrigo ', 'raoe33@hotmail.com');
INSERT INTO `empleados_source` VALUES ('32136613', 'Henry', 'Caretta', 'Gilda', '10004054', 'Vicerrectoría de Formación Integral', 'MXB0031607 - Vicerrectoría de Formación Integral', 'Especialista de atención a foráneos     ', 'Operativos 1', '32124321', 'Franco Calvillo José Rodrigo ', 'gilda.henry@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32136969', 'Coello', 'Castañeda', 'Orlando Jesús', '10004203', 'Vicerrectoría  de Formación Integral', 'MXB0031612 - Coordinación de Selecciones y Ac. Deport', 'Entrenador de Selecciones               ', 'Mandos medios y profesorado 2', '32124321', 'Franco Calvillo José Rodrigo ', 'orlando_coeca@hotmail.com');
INSERT INTO `empleados_source` VALUES ('32137035', 'Escárcega', 'Galera', 'Lucely De Los Angeles', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Supervisor Administrativo               ', 'Operativos 1', '32124189', 'Ontiveros Velázquez Julio Antonio', 'lucely.escarcega@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32137036', 'Karam', 'Espósitos', 'José Jesús', '10000215', 'Vicerrectoría Académica', 'MXB0031408 - Psicología', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124225', 'González Novelo José Alejandro', 'jose.karam@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32137037', 'Mézquita', 'Gamboa', 'Karla Leticia', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Cajero                                  ', 'Operativos 2', '32124341', 'Martínez González Leonor Beatriz', 'karla.mezquita@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32137040', 'Fregoso', 'Lomas', 'Sofía Constanza', '10000221', 'Vicerrectoría Académica', 'MXB0031415 - Arquitectura', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124195', 'Tello Rodriguez Martha María', 'sofia.fregoso@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32137041', 'Towle', 'Wachenheim', 'Judith Margarete', '10004061', 'Vicerrectoría Académica', 'MXB0033301 - Centro de Lenguas', 'Coordinador del Centro de Lenguas       Coordinador del Centro de Lenguas       Coordinador del Centro de Lenguas       Coordinador del Centro de Lenguas       ', 'Mandos medios y profesorado 1 ', '32124245', 'Guzmán Silva Susana', 'judith.towle@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32137185', 'Palomeque', 'Martínez', 'Elena', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Auxiliar de laboratorio y/o taller      ', 'Operativos 2', '32142667', 'Castro Landeros María Alicia', 'elena.palomeque@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32137726', 'Góngora', 'Bates', 'Clara Angélica', '10000220', 'Vicerrectoría Académica', 'MXB0031414 - Cirujano Dentista', 'Auxiliar administrativo                 ', 'Operativos 1', '32154629', 'Peniche Marcín Rolando Gonzalo', 'angelica.gongora@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32140720', 'Olivera', 'Novelo', 'Jaime Ermilo', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico', 'Coordinador de tutorías y apoyo académic', 'Mandos medios y profesorado 1 ', '32124245', 'Guzmán Silva Susana', 'jaime.olivera@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142235', 'García', 'López', 'Carlos Daniel', '10004059', 'Vicerrectoría de Formación Integral', 'MXB0031609 - Desarrollo Humano', 'Asesor de desarrollo humano             ', 'Mandos medios y profesorado 2', '32124321', 'Franco Calvillo José Rodrigo ', 'carlos.garcia@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142628', 'Bolio', 'Romero', 'María José', '10000282', 'Rectoría', 'MXB0034604 - Gerencia de Recursos humanos', 'Especialista de recursos humanos        ', 'Mandos medios y profesorado 2', '32124186', 'Narváez Galaz Lia Regina', 'maria.bolio@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142632', 'Acuña', 'González', 'Narciso Antonio', '10000267', 'Vicerrectoría Académica', 'MXB0034401 - Vicerrectoría Académica', 'Vicerrector académico                   ', 'Autoridades 2', '1', 'Pardo Hervás P.Rafael', 'narciso.acuna@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142634', 'López', 'Albor', 'Ileana Patricia', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124192', 'Negroe Monforte Benjamín Ramón', 'ileana.lopez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142649', 'Muñoz', 'Bello', 'Aida Rosa', '10004202', 'Vicerrectoría de Formación Integral', 'MXB0031606 - Difusión Cultural', 'Coordinador de difusión cultural        ', 'Mandos medios y profesorado 1 ', '32124321', 'Franco Calvillo José Rodrigo ', 'aida.munoz@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142651', 'Echeverría', 'Y Eguiluz', 'José Manuel', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Director de programa académico          ', 'Mandos medios y profesorado 1 ', '32142632', 'Acuña González Narciso Antonio', 'jose.echeverria@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142652', 'Castro', 'Avila', 'Eduardo', '10004065', 'Rectoría', 'MXB0033305 - Centro de Atención Alumnos', 'Coordinador de atención a alumnos       ', 'Mandos medios y profesorado 2', '1', 'Pardo Hervás P.Rafael', 'eduardo.castro@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142653', 'González', 'Encalada', 'Ana Beatriz', '10004054', 'Vicerrectoría de Formación Integral', 'MXB0031603 - Relaciones Estudiatiles', 'Auxiliar administrativo                 ', 'Operativos 1', '32124321', 'Franco Calvillo José Rodrigo ', 'ana.gonzalez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142658', 'Ortiz', 'Heredia', 'Hansel Francisco', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - Economía y Negocios', 'Director de programa académico          ', 'Mandos medios y profesorado 1 ', '32149211', 'Silveira Bolio José Antonio', 'hansel.ortiz@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142661', 'Rivera', 'Rovelo', 'Jorge', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Coordinador de programa académico       ', 'Mandos medios y profesorado 1 ', '32124226', 'Anaya Sandoval Juan Antonio', 'jorge.rivera@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142667', 'Castro', 'Landeros', 'María Alicia', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Director de programa académico          ', 'Mandos medios y profesorado 1 ', '32149211', 'Silveira Bolio José Antonio', 'maria.castro@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142851', 'Falcón', 'Rivera', 'Karla Yamile', '10004062', 'Rectoría', 'MXB0033302 - Dirección de Administraci', 'Especialista de certificación y titulaci', 'Mandos medios y profesorado 2', '32124188', 'Chávez Reyes María Del Rocío', 'karla.falcon@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142871', 'Hernández', 'Cortés', 'Trinidad Rebeca', '10000279', 'Rectoría', 'MXB0034601 - Rectoría UA Mayab', 'Secretario(a) de rectoría               ', 'Operativos 1', '1', 'Pardo Hervás P.Rafael', 'rebeca.hernandez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142874', 'Torres', 'Jiménez', 'Yara Lizette', '10004063', 'Rectoría', 'MXB0033303 - Dirección Servicios Institucionales y Pl', 'Coordinador de proyectos                ', 'Mandos medios y profesorado 1 ', '32124267', 'Cardós Santoyo Fermín', 'yara.torres@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142875', 'Tuyub', 'España', 'Arumi', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico', 'Coordinador de Calidad Académica        ', 'Mandos medios y profesorado 1 ', '32124245', 'Guzmán Silva Susana', 'arumi.tuyub@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142985', 'Kú', 'Carrillo', 'Francisco  Manuel', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               ', 'Mandos medios y profesorado 1 ', '32154629', 'Peniche Marcín Rolando Gonzalo', 'francisco.ku@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32142999', 'Ayala', 'Parra', 'Guadalupe Nahiely', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Auxiliar administrativo                 ', 'Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Ope', '32142651', 'Echeverría y Eguiluz José Manuel', 'guadalupe.ayala@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32143258', 'Valle', 'Moo', 'Freddy Juventino', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Técnico de soporte                      ', 'Operativos 1', '32124304', 'Mendoza Noh Beatriz Anilú', 'freddy.valle@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32143261', 'Peraza', 'Chuc', 'Moctezuma', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Técnico de soporte                      ', 'Operativos 1', '32149973', 'Murillo Esquivel Gary', 'moctezuma.peraza@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32143366', 'Ventura', 'Sabido', 'Martha Georgina Del Socorro', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Asistente de dirección                  ', 'Mandos medios y profesorado 2', '32124289', 'Echazarreta Montero Jhoanna', 'martha.ventura@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32143434', 'Garza', 'Roche', 'Regina', '10004090', 'Rectoría', 'MXB0127414 - Oficina de Transferencia', 'Director de centro de investigación     ', 'Direcciones 2', '1', 'Pardo Hervás P.Rafael', 'regina.garza@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32143435', 'Dominguez', 'Maldonado', 'Rubén', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Profesor universitario                  ', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y', '32144114', 'Escalante Macías Valadez José Luis', 'ruben.dominguez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32143828', 'Ojeda', 'Viana', 'Georgina Maribel', '10000280', 'Rectoría', 'MXB0034602 - Coordinación de Comunicación', 'Coordinador de comunicación             ', 'Mandos medios y profesorado 2', '32124224', 'Herrera Baas Florángely', 'maribel.ojeda@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32143970', 'Solís', 'Castilla', 'Alfredo José', '10004203', 'Vicerrectoría de Formación Integral', 'MXB0031612 - Coordinación de Selecciones y Ac. Deport', 'Entrenador de Selecciones               ', 'Mandos medios y profesorado 2', '32124321', 'Franco Calvillo José Rodrigo ', 'alfredo.solis@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32144069', 'Fraire', 'Torres', 'Maythe', '10002656', 'Vicerrectoría de Administración y Finanzas', 'MXB0123203 - Clínica Universitaria', 'Secretario(a) de departamento           ', 'Operativos 2', '32148648', 'Domínguez Nolasco Dafne', 'maythe.fraire@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32144113', 'Díaz', 'Negrón', 'Gladys Ruby', '10000221', 'Vicerrectoría Académica', 'MXB0031415 - Arquitectura', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124195', 'Tello Rodriguez Martha María', 'gladys.diaz@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32144114', 'Escalante', 'Macías Valadez', 'José Luis', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Coordinador de programa académico       ', 'Mandos medios y profesorado 1 ', '32124226', 'Anaya Sandoval Juan Antonio', 'jose.escalante@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32144190', 'Puc', 'Martin', 'Juan Gualberto', '10004062', 'Rectoría', 'MXB0033302 - Dirección de Administraci', 'Auxiliar administrativo                 ', 'Mandos medios y profesorado 2', '32124975', 'Rodriguez Pech Mayte Eugenia', 'juan.puc@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32144380', 'Murillo', 'Rodríguez', 'Eric Simón', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32149706', 'Espinosa Y Macin Eduardo', 'eric.murillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32144462', 'Lara', 'Martínez', 'Mariela Trinidad', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Técnico de laboratorio y/o taller       ', 'Operativos 1', '32142651', 'Echeverría y Eguiluz José Manuel', 'mariela.lara@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32144488', 'Gamboa', 'Mendez', 'Mario Ernesto', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               ', 'Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y', '32154629', 'Peniche Marcín Rolando Gonzalo', 'mario.gamboa@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32144526', 'Piña', 'Quijano', 'Mercedes Del Pilar', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Asistente académico                     ', 'Mandos medios y profesorado 2', '32142651', 'Echeverría y Eguiluz José Manuel', 'mercedes.pina@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32144555', 'Villarreal', 'Vidal', 'Alfonso', '10002653', 'Vicerrectoría Académica', 'MXB0121528 - Mtria. Terapia Familiar (mid)', 'Coordinador de posgrados                ', 'Mandos medios y profesorado 1 ', '32124225', 'González Novelo José Alejandro', 'alfonso.villarreal@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32144995', 'Avilez', 'Briceño', 'Sally Yolanda', '10000280', 'Rectoría', 'MXB0034602 - Coordinación de Comunicación', 'Coordinador de comunicación             ', 'Mandos medios y profesorado 2', '32124224', 'Herrera Baas Florángely', 'sally.avilez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32145155', 'Palacios', 'Ruíz', 'Alexis Mauricio', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Profesor universitario                  ', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y', '32142661', 'Rivera Rovelo Jorge', 'alexis.palacios@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32145420', 'Martinez', 'Castillo', 'Adalberto Antonio', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32148067', 'Estrada Avilés Lili Marlene', 'adalberto.martinez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32145456', 'Aranda', 'Morales', 'Anevi', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Supervisor Administrativo               ', 'Operativos 1 ', '32148074', 'Martínez Faz Dora Elia', 'anevi.aranda@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32145534', 'Quintal', 'Castillo', 'Andrés Gaspar', '10004203', 'Vicerrectoría de Formación Integral', 'MXB0031612 - Coordinación de Selecciones y Ac. Deport', 'Entrenador de Selecciones               ', 'Mandos medios y profesorado 2', '32124321', 'Franco Calvillo José Rodrigo ', 'ossensei@yahoo.com');
INSERT INTO `empleados_source` VALUES ('32145538', 'Espinosa', 'Garza', 'María De La Asunción Cecilia', '10004061', 'Vicerrectoría Académica', 'MXB0033301 - Centro de Lenguas', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32137041', 'Towle Wachenheim Judith Margarete', 'maria.espinosag@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32145548', 'González', 'Madariaga', 'Mayte José', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Auxiliar administrativo                 ', 'Operativos 1', '32124341', 'Martínez González Leonor Beatriz', 'mayte.gonzalez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32146467', 'Pinzón', 'Balam', 'Olga Paulina', '10000282', 'Rectoría', 'MXB0034604 - Gerencia de Recursos humanos', 'Especialista de recursos humanos        ', 'Mandos medios y profesorado 2', '32124186', 'Narváez Galaz Lia Regina', 'olga.pinzon@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32146480', 'Gomez', 'Perez', 'Edsi', '10000219', 'Vicerrectoría Académica', 'MXB0031413 - Nutrición', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124257', 'Barrera Bustillo Martha Eugenia', 'edsi.gomez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32146510', 'Alonzo', 'Medina', 'Gerardo Manuel', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Profesor universitario                  ', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y', '32142661', 'Rivera Rovelo Jorge', 'gerardo.alonzo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32146544', 'Osorio', 'Vázquez', 'María Cristina', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32142658', 'Ortiz Heredia Hansel Francisco', 'maria.osoriov@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32146674', 'Ramos', 'Arevalo', 'Eduardo Alberto', '10000287', 'Vicerrectoría Académica', 'MXB0034901 - Biblioteca', 'Auxiliar de Biblioteca                  ', 'Operativos 2', '32124238', 'Torreblanca Rios Fernando Antonio', 'eduardo.ramos@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32146961', 'Castillo', 'Salazar', 'Tatiana Macarena', '10000284', 'Rectoría', 'MXB0034606 - Dirección de Desarrollo Institucional', 'Asistente de dirección                  ', 'Mandos medios y profesorado 2', '32123111', 'Gutiérrez Martínez Luis Ernesto', 'tatiana.castillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32147070', 'Flores', 'Bargas', 'Beatriz Gabriela', '10000211', 'Vicerrectoría Académica', 'MXB0031403 - Ciencias de la Comunicación', 'Secretario(a) de departamento           ', 'Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2', '32124209', 'Tello Rodriguez Marisol', 'beatriz.flores@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32147524', 'Ávila', 'Medina', 'Ricardo', '10002630', 'Vicerrectoría Académica', 'MXB0121501 - Dirección de Posgrados y Extensión', 'Auxiliar administrativo                 ', 'Operativos 1', '32124278', 'Acevedo Marentes Fernando Enrique', 'ricardo.avila@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32147525', 'Wabi', 'Peniche', 'Carlos Andrés', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de IngenieríaMXB0031410 - División de Ingeniería', 'Coordinador de programa académico       ', 'Mandos medios y profesorado 1 ', '32124226', 'Anaya Sandoval Juan Antonio', 'carlos.wabi@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32147527', 'Reyes', 'Mézquita', 'Cinddy Noemí', '10000269', 'Vicerrectoría Académica', 'MXB0034404 - Relaciones Académicas', 'Auxiliar administrativo                 ', 'Operativos 1', '32124229', 'Achach Solís Marisol', 'cinddy.reyes@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32147649', 'Sánchez', 'Trujillo', 'María Guadalupe', '10000213', 'Vicerrectoría Académica', 'MXB0031405 - Derecho', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124350', 'Álvarez Escalante Absalón', 'maria.sanchezt@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32147655', 'Gutiérrez', 'Barrera', 'Jesús Arturo', '10000222', 'Vicerrectoría Académica', 'MXB0031416 - Coordinación de humanidades', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124183', 'Otero Rejón Francisco Javier', 'jesus.gutierrez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32147656', 'Luna', 'Mccarthy', 'Diana Patricia', '10000268', 'Vicerrectoría Académica', 'MXB0034403 - Operación Académica', 'Coordinador de operación de licenciatura', 'Mandos medios y profesorado 1 ', '32142632', 'Acuña González Narciso Antonio', 'diana.luna@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32147708', 'López', 'Vales', 'María Anunciata', '10000266', 'Rectoría', 'MXB0034301 - Promoción', 'Director atención preuniversitaria y mer', 'Direcciones 2', '1', 'Pardo Hervás P.Rafael', 'anunciata.lopez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148067', 'Estrada', 'Avilés', 'Lili Marlene', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Coordinador de programa académico       ', 'Mandos medios y profesorado 1 ', '32142651', 'Echeverría y Eguiluz José Manuel', 'lili.estrada@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148074', 'Martínez', 'Faz', 'Dora Elia', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Jefe de crédito y cobranza              ', 'Mandos medios y profesorado 2', '32124341', 'Martínez González Leonor Beatriz', 'dora.martinez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148210', 'Castro', 'Flota', 'Maribel Concepción', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Auxiliar Contable                       ', 'Operativos 1', '32124243', 'Euan Calderón Eugenia Beatriz', 'maribel.castro@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148278', 'González', 'Solís', 'Armando José', '10000220', 'Vicerrectoría Académica', 'MXB0031414 - Cirujano Dentista', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'armando.gonzalez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148332', 'Puerto', 'Ávila', 'Ana Rosa', '10004090', 'Rectoría', 'MXB0127414 - Oficina de Transferencia', 'Secretario(a) de departamento           ', 'Operativos 2', '32143434', 'Garza Roche Regina', 'ana.puerto@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148606', 'Espinosa', 'Pérez', 'Diana Carolina', '10000282', 'Rectoría', 'MXB0034604 - Gerencia de Recursos humanos', 'Especialista de recursos humanos        ', 'Operativos 1', '32146467', 'Pinzón Balam Olga Paulina', 'diana.espinosa@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148648', 'Domínguez', 'Nolasco', 'Dafne', '10002656', 'Vicerrectoría de Administración y Finanzas', 'MXB0123203 - Clínica Universitaria', 'Asistente de dirección                  Asistente de dirección                  Asistente de dirección                  Asistente de dirección                  Asistente de dirección                  Asistente de dirección                  Asistente de di', 'Mandos medios y profesorado 2', '2', 'Peñúñuri Munguía P. Ulises', 'dafne.dominguez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148701', 'Zaldívar', 'Rae', 'Jaime Antonio', '10000271', 'Vicerrectoría Académica', 'MXB0034401 - Vicerrectoría Académica', 'Coordinador de investigación            ', 'Mandos medios y profesorado 1 ', '32142632', 'Acuña González Narciso Antonio', 'jaime.zaldivar@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148709', 'Aysa', 'Rodríguez', 'Ana Lucía', '10000286', 'Rectoría', 'MXB0034608 - Programa de Egresados', 'Coordinador del programa                ', 'Mandos medios y profesorado 2', '32123111', 'Gutiérrez Martínez Luis Ernesto', 'ana.aysa@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148862', 'Sanchez', 'Gomez', 'Miriam Adriana', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Especialista de presupuestos            ', 'Mandos medios y profesorado 2', '32124341', 'Martínez González Leonor Beatriz', 'miriam.sanchez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148863', 'Gonzalez', 'Gutierrez', 'Ligia Natalia', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32142667', 'Castro Landeros María Alicia', 'ligia.gonzalez2@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148865', 'Rodriguez', 'Alcala', 'Antonio', '10000221', 'Vicerrectoría Académica', 'MXB0031415 - Arquitectura', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124195', 'Tello Rodriguez Martha María', 'antonio.rodriguez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148868', 'Castillo', 'Espronceda', 'Claudia Lorena', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Asistente de dirección                  ', 'Mandos medios y profesorado 2', '32124341', 'Martínez González Leonor Beatriz', 'claudia.castillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148924', 'Hernandez', 'Tello', 'Fernando', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32142667', 'Castro Landeros María Alicia', 'fernando.hernandez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32148925', 'Espejo', 'Sauri', 'Raul Jose', '10000266', 'Rectoría', 'MXB0034301 - Promoción', 'Asesor preuniversitario                 ', 'Mandos medios y profesorado 2', '32151164', 'Payeras Sanchez Luisa Maria', 'raul.espejo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149072', 'Estrella', 'Suaste', 'Gilberto Ramon', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124202', 'Zaldivar Álvarez Antonio', 'gilberto.estrella@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149174', 'Sanchez', 'Pool', 'Russel Miguel', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Auxiliar técnico                        ', 'Operativos 2', '32124234', 'Peraza Rosas María Jazmine del Carmen', 'russel.sanchez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149175', 'Navarro', 'Chim', 'Rosana Patricia', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Técnico de laboratorio y/o taller       ', 'Operativos 1', '32142651', 'Echeverría y Eguiluz José Manuel', 'rosana.navarro@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149211', 'Silveira', 'Bolio', 'José Antonio', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - Economía y Negocios', 'Director de división académica          ', 'Direcciones 1', '32142632', 'Acuña González Narciso Antonio', 'jose.silveira@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149218', 'Casas', null, 'Viridiana', '10004061', 'Vicerrectoría Académica', 'MXB0033301 - Centro de Lenguas', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32137041', 'Towle Wachenheim Judith Margarete', 'viridiana.casas@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149265', 'Ortiz', 'Mier Y Teran', 'Jose Ramiro', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Supervisor Administrativo               ', 'Operativos 1', '2', 'Peñúñuri Munguía P. Ulises', 'ramiro.ortiz@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149269', 'Bolio', 'Vales', 'Alberto Rene', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'alberto.bolio@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149485', 'Palomo', 'Gasca', 'Catalina', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico', 'Coordinador de Formación Educativa y Apoyo Académico    Coordinador de Formación Educativa y Apoyo Académico    Coordinador de Formación Educativa y Apoyo Académico    Coordinador de Formación Educativa y Apoyo Académico    Coordinador de Formación Educat', 'Mandos medios y profesorado 1 ', '32124245', 'Guzmán Silva Susana', 'catalina.palomo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149706', 'Espinosa', 'Y Macin', 'Eduardo', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Coordinador de programa académico       ', 'Mandos medios y profesorado 1 ', '32142651', 'Echeverría y Eguiluz José Manuel', 'eduardo.espinosa@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149819', 'Lopez', 'Acosta', 'Melina Leticia', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Auxiliar Contable                       ', 'Operativos 1', '32124243', 'Euan Calderón Eugenia Beatriz', 'melina.lopez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149869', 'Ortiz', 'Sauri', 'Javier', '10000220', 'Vicerrectoría Académica', 'MXB0031414 - Cirujano Dentista', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'javier.ortiz@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149870', 'Pérez', 'Bernal', 'Maria Gabriela', '10000221', 'Vicerrectoría Académica', 'MXB0031415 - Arquitectura', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124195', 'Tello Rodriguez Martha María', 'gabriela.perez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149910', 'Lopez', 'Moreno', 'Leydi Diana', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - Economía y Negocios', 'Secretario (a) de la Dirección          ', 'Operativos 1', '32149211', 'Silveira Bolio José Antonio', 'leydi.lopez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149970', 'Castillo', 'Magaña', 'Leopoldo Manuel', '10000222', 'Vicerrectoría Académica', 'MXB0031416 - Coordinación de humanidades', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124183', 'Otero Rejón Francisco Javier', 'leopoldo.castillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149973', 'Murillo', 'Esquivel', 'Gary Rusell', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Jefe de infraestructura tecnológica     ', 'Mandos medios y profesorado 1 ', '32160092', 'González Cincúnegui Luis Alberto', 'gary.murillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149975', 'Vazquez', 'Cruz', 'Luis Alonso', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Técnico de laboratorio y/o taller       ', 'Operativos 1', '32142651', 'Echeverría y Eguiluz José Manuel', 'luis.vazquez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32149977', 'Caceres', 'Medina', 'Juliana Margarita', '10002652', 'Vicerrectoría Académica', 'MXB0121527 - Mtria. Nutrición Clínica (mid)', 'Coordinador de posgrados                ', 'Mandos medios y profesorado 2', '32124257', 'Barrera Bustillo Martha Eugenia', 'juliana.caceres@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32150470', 'Novelo', 'Alcocer', 'Linabel', '10004204', 'Vicerrectoría de Formación Integral', 'MXB0034510 - Bloque Electivo Anahuac', 'Asistente de dirección                  ', 'Mandos medios y profesorado 2', '32124321', 'Franco Calvillo José Rodrigo ', 'linabel.novelo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32150583', 'Rodriguez', 'Martin', 'Francisco Javier', '10000212', 'Vicerrectoría Académica', 'MXB0031404 - Diseño', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32156835', 'Duarte Rosado Yermak Alexandro', 'javier.rodriguezm@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32150757', 'Parra', 'Burgos', 'Maricarmen De Atocha', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Secretario(a) de departamento           ', 'Operativos 2', '32124226', 'Anaya Sandoval Juan Antonio', 'maricarmen.parra@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32150966', 'Varguez', 'Perez', 'Ileana Trinidad', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Auxiliar Contable                       ', 'Operativos 1', '32124243', 'Euan Calderón Eugenia Beatriz', 'ileana.varguez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151164', 'Payeras', 'Sanchez', 'Luisa Maria', '10000266', 'Rectoría', 'MXB0034301 - Promoción', 'Asesor preuniversitario                ', 'Mandos medios y profesorado 1 ', '32147708', 'López Vales María Anunciata', 'luisa.payeras@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151397', 'Canché', 'Can', 'Marcelo', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Jardinero                               ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'marcelo.canche@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151435', 'Pérez', 'Domínguez', 'Daniel Alberto', '10000220', 'Vicerrectoría Académica', 'MXB0031414 - Cirujano Dentista', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'daniel.perez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151436', 'Reyes', 'Castillo', 'Roberto Enrique', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Técnico de laboratorio y/o taller       ', 'Operativos 1', '32142651', 'Echeverría y Eguiluz José Manuel', 'roberto.reyes@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151505', 'Medina', 'Sabido', 'David', '10000219', 'Vicerrectoría Académica', 'MXB0031413 - Nutrición', 'Coordinador de campos clínicos          ', 'Mandos medios y profesorado 2', '32124257', 'Barrera Bustillo Martha Eugenia', 'david.medina@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151595', 'Tuyub', 'Dzul', 'María Jesús', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Auxiliar Contable                       ', 'Operativos 1', '32124243', 'Euan Calderón Eugenia Beatriz', 'maria.tuyub@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151597', 'Campo', 'Marrufo', 'José Manuel', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico', 'Auxiliar técnico                        ', 'Operativos 2', '32124236', 'Cruz López Anna Karina', 'jose.campo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151598', 'Sulú', 'Balam', 'Wilberth Bibiano', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Jardinero                               ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'wilberth.sulu@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151600', 'Castillo', 'López', 'Beatriz Alejandra', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico', 'Asistente académico                     ', 'Mandos medios y profesorado 2', '32162093', 'Enríquez Vázquez Ericka Del Socorro', 'beatriz.castillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151603', 'Marqueda', 'Alcocer', 'Maricela', '10000266', 'Rectoría', 'MXB0034301 - Promoción', 'Jefe de admisiones                      ', 'Mandos medios y profesorado 1 ', '32147708', 'López Vales María Anunciata', 'maricela.marqueda@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151614', 'Peraza', 'Zermeño', 'José Daniel', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico', 'Auxiliar técnico                        ', 'Operativos 2', '32124236', 'Cruz López Anna Karina', 'daniel.peraza@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151615', 'Argaez', 'Morales', 'Angélica Patricia', '10000220', 'Vicerrectoría Académica', 'MXB0031414 - Cirujano Dentista', 'Técnico de laboratorio y/o taller       ', 'Operativos 1', '32154629', 'Peniche Marcín Rolando Gonzalo', 'angelica.argaez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151737', 'Fernández', 'Bandini', 'Lucía Del Corazón De María', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32148067', 'Estrada Avilés Lili Marlene', 'bandini.lucia@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151835', 'Morcillo', 'Bolio', 'Diana Celina', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Auxiliar administrativo                 ', 'Operativos 2', '32142651', 'Echeverría y Eguiluz José Manuel', 'diana.morcillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32151854', 'Chávez', 'Jacquez', 'Sofía', '10000282', 'Rectoría', 'MXB0034604 - Gerencia de Recursos humanos', 'Especialista de recursos humanos        ', 'Operativos 1', '32142628', 'Bolio Romero María José', 'sofia.chavez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32152130', 'Lizama', 'Dorantes', 'Natalia Paulina', '10004203', 'Vicerrectoría de Formación Integral', 'MXB0031612 - Coordinación de Selecciones y Ac. Deport', 'Entrenador de Selecciones               ', 'Mandos medios y profesorado 2', '32124321', 'Franco Calvillo José Rodrigo ', 'natalia.lizama@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32152177', 'Reyes', 'Avila', 'Nidelvia Yolanda', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Técnico de laboratorio y/o taller       ', 'Operativos 1', '32142651', 'Echeverría y Eguiluz José Manuel', 'nidelvia.reyes@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32152181', 'Montalvo', 'López', 'María Guadalupe', '10004055', 'Vicerrectoría de Formación Integral', 'MXB0031604 - Red Misión', 'Auxiliar administrativo                 ', 'Operativos 1', '32162062', 'Vallejo Álvarez Ayerím del Rosario', 'maria.montalvol@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32152377', 'Santos', 'Villafaña', 'Jorge Eduardo', '10004057', 'Vicerrectoría de Formación Integral', 'MXB0031607 - Vicerrectoría de Formación Integral', 'Asistente de dirección                  ', 'Mandos medios y profesorado 2', '32124321', 'Franco Calvillo José Rodrigo ', 'jorge.santos@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32152425', 'López', 'Osorio', 'Orlando Humberto', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Auxiliar de laboratorio y/o taller      ', 'Operativos 2', '32142667', 'Castro Landeros María Alicia', 'orlando.lopez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32152430', 'Cadena', 'Mejía', 'Fernando', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32149706', 'Espinosa Y Macin Eduardo', 'fernando.cadena@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32152527', 'Díaz', 'Negrón', 'Porfirio Rodolfo', '10000212', 'Vicerrectoría Académica', 'MXB0031404 - Diseño', 'Auxiliar de laboratorio y/o taller      ', 'Operativos 2 ', '32156835', 'Duarte Rosado Yermak Alexandro', 'porfirio.diaz@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32152638', 'Burgos', 'Estrella', 'Helly Maricela', '10003302', 'Vicerrectoría Académica', 'MXB0121508 - Mtria. Ciencias de la Ed. (mid)', 'Coordinador de posgrados                ', 'Mandos medios y profesorado 1 ', '32124225', 'González Novelo José Alejandro', 'helly.burgos@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32152691', 'López', 'Ortega', 'Eli Vianey', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32142667', 'Castro Landeros María Alicia', 'eli.lopez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32152778', 'Argüelles', 'Guerrero', 'Mariela Concepción', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Auxiliar de Compras                     ', 'Operativos 1', '32124289', 'Echazarreta Montero Jhoanna', 'mariela.arguelles@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153244', 'López', 'Berumen', 'Bruno Abraham', '10000212', 'Vicerrectoría Académica', 'MXB0031404 - Diseño', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32156835', 'Duarte Rosado Yermak Alexandro', 'bruno.lopez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153290', 'Rodríguez', 'Herrera', 'Edesio Martin', '10004203', 'Vicerrectoría de Formación Integral', 'MXB0031612 - Coordinación de Selecciones y Ac. Deport', 'Entrenador de Selecciones               ', 'Mandos medios y profesorado 2', '32124321', 'Franco Calvillo José Rodrigo ', 'edesio1972@hotmail.com');
INSERT INTO `empleados_source` VALUES ('32153319', 'Blas', 'Zapata', 'Tobías Manuel', '10000282', 'Rectoría', 'MXB0034604 - Gerencia de Recursos humanos', 'Especialista de recursos humanos        ', 'Operativos 1', '32146467', 'Pinzón Balam Olga Paulina', 'tobias.blas@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153323', 'Poot', 'Ortega', 'Erick José', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'erick.poot@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153337', 'García', 'González', 'Felipe', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Técnico de soporte                      ', 'Operativos 1', '32149973', 'Murillo Esquivel Gary', 'felipe.garcia@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153437', 'Castillo', 'Quijano', 'Florisela Marlene', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Cajero                                  ', 'Operativos 2', '32124341', 'Martínez González Leonor Beatriz', 'florisela.castillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153479', 'González', 'Anaya', 'Ana Paulina', '10000266', 'Rectoría', 'MXB0034301 - Promoción', 'Asesor preuniversitario                 ', 'Mandos medios y profesorado 1 ', '32147708', 'López Vales María Anunciata', 'paulina.gonzalez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153663', 'Pineda', 'Fuentes', 'José Fernando', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Auxiliar técnico                        ', 'Operativos 2', '32124234', 'Peraza Rosas María Jazmine del Carmen', 'jose.pineda@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153664', 'Conde', 'Burgos', 'Abel', '10004065', 'Rectoría', 'MXB0033305 - Centro de Atención Alumnos', 'Auxiliar administrativo                 ', 'Operativos 1', '32142652', 'Castro Ávila Eduardo', 'abel.conde@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153815', 'Guedimín', 'Bojórquez', 'Delfina María', '10004090', 'Rectoría', 'MXB0127414 - Oficina de Transferencia', 'Asistente de dirección                  ', 'Mandos medios y profesorado 2', '32143434', 'Garza Roche Regina', 'delfina.guedimin@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153840', 'Trujillo', 'Paredes', 'Niurka', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32148067', 'Estrada Avilés Lili Marlene', 'niurka.trujillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153844', 'Terrazas', 'Brandt', 'Arturo Alfonso', '10000279', 'Rectoría', 'MXB0034601 - Rectoría UA Mayab', 'Chofer mensajero                        ', 'Operativos 2', '1', 'Pardo Hervás P.Rafael', 'arturo.terrazas@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153871', 'Pérez', 'Aguilar', 'Elizabeth Del Carmen', '10000266', 'Rectoría', 'MXB0034301 - Promoción', 'Secretario(a) de departamento           ', 'Operativos 2', '32147708', 'López Vales María Anunciata', 'elizabeth.perez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153874', 'Saldaña', 'Aportela', 'Ernesto', '10004056', 'Vicerrectoría de Formación Integral', 'MXB0031605 - Servicio y Acción Social', 'Coordinador de Servicio y Acción Social   ', 'Mandos medios y profesorado 2', '32124321', 'Franco Calvillo José Rodrigo ', 'ernesto.saldana@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153970', 'Aguayo', 'Rosado', 'Orfi Guadalupe', '10000280', 'Rectoría', 'MXB0034602 - Coordinación de Comunicación', 'Especialista en página WEB              Especialista en página WEB              Especialista en página WEB              Especialista en página WEB              Especialista en página WEB              Especialista en página WEB              Especialista en', 'Operativos 1', '32124224', 'Herrera Baas Florángely', 'orfi.aguayo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32153980', 'Uicab', 'Che', 'María Magdalena', '10000221', 'Vicerrectoría Académica', 'MXB0031415 - Arquitectura', 'Auxiliar administrativo                 ', 'Operativos 1', '32124195', 'Tello Rodriguez Martha María', 'maria.uicab@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154094', 'Urias', 'Ibarra', 'Elizabeth', '10000282', 'Rectoría', 'MXB0034604 - Gerencia de Recursos humanos', 'Auxiliar administrativo                 ', 'Operativos 1', '32124186', 'Narváez Galaz Lia Regina', 'elizabeth.urias@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154101', 'Molina', 'Gutiérrez', 'Greta Nikolai', '10000215', 'Vicerrectoría Académica', 'MXB0031408 - Psicología', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124225', 'González Novelo José Alejandro', 'greta.molina@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154166', 'Martínez', 'Chan', 'Vanessa Guadalupe', '10000211', 'Vicerrectoría Académica', 'MXB0031403 - Ciencias de la Comunicación', 'Auxiliar administrativo                 ', 'Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1', '32124209', 'Tello Rodriguez Marisol', 'vanessa.martinez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154228', 'Perez', 'Gomez', 'Jorge Hiram', '10000287', 'Vicerrectoría Académica', 'MXB0034901 - Biblioteca', 'Auxiliar de Biblioteca                  ', 'Operativos 2', '32124238', 'Torreblanca Rios Fernando Antonio', 'jorge.perez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154232', 'Lizarraga', 'Castro', 'Isabel', '10004062', 'Rectoría', 'MXB0033302 - Dirección de Administraci', 'Auxiliar administrativo                 ', 'Mandos medios y profesorado 2', '32124315', 'Peniche Sanguino Astrid Marvin', 'isabel.lizarraga@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154240', 'Martín', 'Peón', 'María Gabriela', '10000267', 'Vicerrectoría Académica', 'MXB0034401 - Vicerrectoría Académica', 'Asistente de dirección                  ', 'Mandos medios y profesorado 2', '32142632', 'Acuña González Narciso Antonio', 'gabriela.martin@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154314', 'Sabido', 'Perera', 'Yazmín Orquidia', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Técnico de laboratorio y/o taller       ', 'Operativos 1', '32124226', 'Anaya Sandoval Juan Antonio', 'yazmin.sabido@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154463', 'Tut', 'Aké', 'Sergio Gabriel', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124202', 'Zaldivar Álvarez Antonio', 'sergio.tut@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154516', 'Navarro', 'Tec', 'Manuel Alberto', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Jardinero                               ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'manuel.navarro@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154574', 'Lima', 'Chim', 'Rafael', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Jardinero                               ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'rafael.lima@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154582', 'León', 'Gil', 'Monica Georgina', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico', 'Asistente académico                     ', 'Mandos medios y profesorado 2', '32162093', 'Enríquez Vázquez Ericka Del Socorro', 'monica.leon@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154629', 'Peniche', 'Marcin', 'Rolando Gonzalo', '10000220', 'Vicerrectoría Académica', 'MXB0031414 - Cirujano Dentista', 'Director de programa académico          ', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y', '32142632', 'Acuña González Narciso Antonio', 'rolando.peniche@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154649', 'Romero', 'Euan', 'Wilian Ulises', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124202', 'Zaldivar Álvarez Antonio', 'wiliam.romero@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154651', 'Nieves', 'Metri', 'Georgina', '10000280', 'Rectoría', 'MXB0034602 - Coordinación de Comunicación', 'Auxiliar administrativo                 ', 'Operativos 1', '32143828', 'Ojeda Viana Georgina Maribel', 'georgina.nieves@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154693', 'Castillo', 'Cruz', 'Darling Del Carmen', '10000219', 'Vicerrectoría Académica', 'MXB0031413 - Nutrición', 'Auxiliar de laboratorio y/o taller      ', 'Operativos 2', '32124257', 'Barrera Bustillo Martha Eugenia', 'darling.castillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154936', 'Us', 'Vázquez', 'Luis David', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Auxiliar técnico                        ', 'Operativos 2', '32124234', 'Peraza Rosas María Jazmine del Carmen', 'luis.us@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32154937', 'Medina', 'Rodriguez', 'José Roberto', '10000284', 'Rectoría', 'MXB0034606 - Dirección de Desarrollo Institucional', 'Secretario  de depto.', 'Operativos 1', '32146961', 'Castillo Salazar Tatiana Macarena', 'jose.medina@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32155174', 'Cervantes', 'Cámara', 'Efraín Alberto', '10004203', 'Vicerrectoría de Formación Integral', 'MXB0031612 - Coordinación de Selecciones y Ac. Deport', 'Entrenador de Selecciones               ', 'Mandos medios y profesorado 2', '32124321', 'Franco Calvillo José Rodrigo ', 'efrain.cervantes.camara@gmail.com');
INSERT INTO `empleados_source` VALUES ('32155229', 'Solis', 'Navarrete', 'Lourdes Jhoana', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Operador de Conmutador                  ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'lourdes.solis@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32155231', 'Giorgana', 'Macedo', 'Geovanny Rafael', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Profesor universitario                  ', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y', '32142661', 'Rivera Rovelo Jorge', 'geovanny.giorgana@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32155512', 'Acevedo', 'Vales', 'María Alejandrina', '10000282', 'Rectoría', 'MXB0034604 - Gerencia de Recursos humanos', 'Especialista de recursos humanos        ', 'Mandos medios y profesorado 2', '32124186', 'Narváez Galaz Lia Regina', 'alejandrina.acevedo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32155690', 'Tamayo', 'Escalante', 'Aida Dayanara', '10002630', 'Vicerrectoría Académica', 'MXB0121501 - Dirección de Posgrados y Extensión', 'Coordinador de Programas Posgrado y Exte', 'Mandos medios y profesorado 1 ', '32124181', 'Mendoza Villalobos Alejandra', 'aida.tamayo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32155724', 'Ortega', 'Rosado', 'Laura Elena', '10002630', 'Vicerrectoría Académica', 'MXB0121501 - Dirección de Posgrados y Extensión', 'Coordinador de Programas Posgrado y Exte', 'Mandos medios y profesorado 1 ', '32124181', 'Mendoza Villalobos Alejandra', 'laura.ortega@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32155726', 'Mejia', 'Ricalde', 'Alejandrina', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Jefe de Contabilidad                    ', 'Mandos medios y profesorado 2', '32124341', 'Martínez González Leonor Beatriz', 'alejandrina.mejia@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32156835', 'Duarte', 'Rosado', 'Yermak Alexandro', '10000212', 'Vicerrectoría Académica', 'MXB0031404 - Diseño', 'Director de programa académico          ', 'Mandos medios y profesorado 1 ', '32142632', 'Acuña González Narciso Antonio', 'yermak.duarte@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157008', 'Dominguez', 'Ayora', 'Asuncion Del Rosario', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Auxiliar administrativo                 ', 'Operativos 2', '32142651', 'Echeverría y Eguiluz José Manuel', 'asuncion.dominguez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157009', 'Rodriguez', 'Vargas', 'Fernando', '10000215', 'Vicerrectoría Académica', 'MXB0031408 - Psicología', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124225', 'González Novelo José Alejandro', 'fernando.rodriguez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157048', 'Copland', 'Amaya', 'Ana Meybel', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32142658', 'Ortiz Heredia Hansel Francisco', 'ana.copland@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157288', 'Oliva', 'Avilés', 'Andrés Iván', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Profesor universitario                  ', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y', '32142661', 'Rivera Rovelo Jorge', 'andres.oliva@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157290', 'Medina', 'Palma', 'Jorge Carlos', '10000222', 'Vicerrectoría Académica', 'MXB0031416 - Coordinación de humanidades', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124183', 'Otero Rejón Francisco Javier', 'jorge.medina@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157393', 'Yerbes', 'Contreras', 'Leonardo Daniel', '10000212', 'Vicerrectoría Académica', 'MXB0031404 - Diseño', 'Técnico de laboratorio y/o taller       ', 'Operativos 1', '32156835', 'Duarte Rosado Yermak Alexandro', 'leonardo.yerbes@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157400', 'Interian', 'Chuc', 'Ana Rosa', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Operador de Conmutador                  ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'ana.interian@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157402', 'Ampudia', 'López Cortijo', 'Ximena', '10000266', 'Rectoría', 'MXB0034301 - Promoción', 'Especialista de orientación vocacional  ', 'Mandos medios y profesorado 2', '32151603', 'Marqueda Alcocer Maricela ', 'ximena.ampudia@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157411', 'Hernandez', 'Moreno', 'Laura Rosenda', '10003300', 'Vicerrectoría Académica', 'MXB0121506 - Mtria. Alta Dirección y Neg. (mid)', 'Auxiliar administrativo                 ', 'Operativos 1', '32161047', 'Ortega González Ileana Guadalupe', 'laura.hernandez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157412', 'Escalante', 'Ayuso', 'Erika Maria', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Investigación', 'Auxiliar administrativo                 ', 'Operativos 1', '32148701', 'Zaldívar Rae Jaime Antonio', 'erika.escalante@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157498', 'Fitzmaurice', 'Cahluni', 'Alejandro Esteban', '10000211', 'Vicerrectoría Académica', 'MXB0031403 - Ciencias de la Comunicación', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124209', 'Tello Rodriguez Marisol', 'alejandro.fitzmaurice@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157535', 'Peniche', 'Rosales', 'Jorge Ernesto', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico', 'Especialista en diseño instruccional    ', 'Operativos 1', '32124236', 'Cruz López Anna Karina', 'jorge.peniche@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157581', 'Quijano', 'Sosa', 'Nancy Marlene', '10000282', 'Rectoría', 'MXB0034604 - Gerencia de Recursos humanos', 'Asistente de dirección                  ', 'Mandos medios y profesorado 2', '32124186', 'Narváez Galaz Lia Regina', 'nancy.quijano@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157582', 'Echazarreta', 'Montero', 'Fabiola', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Supervisor Administrativo               ', 'Operativos 1', '32124341', 'Martínez González Leonor Beatriz', 'fabiola.echazarreta@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157584', 'Pineda', 'Manzanilla', 'Maria Rosa', '10004057', 'Vicerrectoría de Formación Integral', 'MXB0031606 - Difusión Cultural', 'Auxiliar administrativo                 ', 'Operativos 1', '32142649', 'Muñoz Bello Aida Rosa', 'maria.pineda@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157585', 'Couoh', 'Guerra', 'Jossue Alejandro', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'josue.couoh@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157586', 'Lara', 'Lizarraga', 'Maria Simoneta', '10004062', 'Rectoría', 'MXB0033302 - Dirección de Administraci', 'Auxiliar administrativo                 ', 'Operativos 1', '32154232', 'Lizarraga Castro Isabel', 'maria.lara@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157587', 'Lavalle', 'Alonso', 'Ana Margarita', '10000266', 'Rectoría', 'MXB0034301 - Promoción', 'Auxiliar administrativo                 ', 'Operativos 1', '32147708', 'López Vales María Anunciata', 'ana.lavalle@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157650', 'Torres', 'Montalvo', 'Gonzalo Manuel', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Profesor universitario                  ', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 ', '32147525', 'Wabi Peniche Carlos Andrés', 'gonzalo.torres@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157686', 'Miranda', 'Rosado', 'Flor Marina', '10000280', 'Rectoría', 'MXB0034602 - Coordinación de Comunicación', 'Auxiliar administrativo                 ', 'Operativos 1', '32144995', 'Avilez Briceño Sally Yolanda', 'flor.miranda@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157697', 'Alpuche', 'Diaz', 'Andres Alberto', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124189', 'Ontiveros Velázquez Julio Antonio', 'andres.alpuche@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157789', 'González', 'Uruñuela', 'Luis Alberto', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124202', 'Zaldivar Álvarez Antonio', 'luis.gonzalez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32157836', 'Garcia', 'Blackaller', 'Nelly Genoveva', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32148067', 'Estrada Avilés Lili Marlene', 'nelly.garcia@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32159413', 'Argüelles', 'Barrancos', 'David Rene', '10000287', 'Vicerrectoría Académica', 'MXB0034901 - Biblioteca', 'Auxiliar de Biblioteca                  ', 'Operativos 2', '32124238', 'Torreblanca Rios Fernando Antonio', 'david.arguelles@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32159427', 'Gómez', 'Ortiz', 'Jorge Oswaldo', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32142667', 'Castro Landeros María Alicia', 'jorge.gomezo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32159479', 'Zapata', 'Díaz', 'Yazmin Antonia', '10000268', 'Vicerrectoría Académica', 'MXB0034403 - Operación Académica', 'Auxiliar administrativo                 ', 'Operativos 1', '32147656', 'Luna McCarthy Diana Patricia', 'yazmin.zapata@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32159481', 'Valencia', 'Cervera', 'Maria Irene', '10000286', 'Rectoría', 'MXB0034608 - Programa de Egresados', 'Auxiliar administrativo                 ', 'Operativos 1', '32148709', 'Aysa Rodríguez Ana Lucía', 'maria.cervera@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32159619', 'Moreno', 'Castillo', 'Oscar Melesio', '10000284', 'Rectoría', 'MXB0034606 - Dirección de Desarrollo Institucional', 'Auxiliar administrativo                 ', 'Operativos 1', '32123111', 'Gutiérrez Martínez Luis Ernesto', 'oscar.moreno@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32159728', 'Romero', 'Euan', 'Luis Miguel', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar de mantenimiento               ', 'Operativos 2', '32124202', 'Zaldivar Álvarez Antonio', 'luis.romero@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32159730', 'Dominguez', 'Cervera', 'Rafael Alfonso', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               ', 'Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y', '32154629', 'Peniche Marcín Rolando Gonzalo', 'rafael.dominguez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32159732', 'González', 'Leija', 'Mariana Berenice', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Investigación', 'Asistente académico                     ', 'Mandos medios y profesorado 2', '32148701', 'Zaldívar Rae Jaime Antonio', 'mariana.gonzalez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32159785', 'Carrera', 'Pérez', 'Hilda Ivonne', '10000266', 'Rectoría', 'MXB0034301 - Promoción', 'Asesor preuniversitario                 ', 'Mandos medios y profesorado 2', '32151164', 'Payeras Sanchez Luisa Maria', 'hilda.carrera@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32159786', 'Dominguez', 'Maldonado', 'Joaquina Leonor', '10000281', 'Rectoría', 'MXB0034603 - Coordinación de Vinculación y Recaudació', 'Auxiliar administrativo                 ', 'Operativos 1', '32123111', 'Salgado  Ríos Gerardo Iván', 'joaquina.dominguez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32159882', 'Bejarano', 'Carrasco', 'Ramón', '10000279', 'Rectoría', 'MXB0034601 - Rectoría UA Mayab', 'Asistente de dirección                  ', 'Mandos Medios y profesorado 2', '1', 'Pardo Hervás P.Rafael', 'ramon.bejarano@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32159883', 'López', 'Ramos', 'Tania', '10000269', 'Vicerrectoría Académica', 'MXB0034404 - Relaciones Académicas', 'Auxiliar administrativo                 ', 'Operativos 1', '32124229', 'Achach Solís Marisol', 'tania.lopezr@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32159906', 'Martinez', 'Valdez', 'Reyna Guadalupe', '10000280', 'Rectoría', 'MXB0034602 - Coordinación de Comunicación', 'Secretario(a) de departamento           ', 'Operativos 2 ', '32124224', 'Herrera Baas Florángely', 'reyna.martinez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160002', 'Cantón', 'Gamboa', 'Pamela Elizabeth', '10000280', 'Rectoría', 'MXB0034602 - Coordinación de Comunicación', 'Auxiliar administrativo                 ', 'Operativos 1', '32144995', 'Avilez Briceño Sally Yolanda', 'pamela.canton@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160003', 'Rafful', 'Soberanis', 'Sara Nathali', '10004062', 'Rectoría', 'MXB0033302 - Dirección de Administraci', 'Auxiliar administrativo                 ', 'Operativos 1', '32142851', 'Falcón Rivera Karla Yamile', 'sara.rafful@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160092', 'González', 'Cincúnegui', 'Luis Alberto', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Coordinador de servicios de tecnología  ', 'Direcciones 2', '32124267', 'Cardós Santoyo Fermín', 'luis.gonzalezc@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160093', 'Pieck', 'Puerto', 'Alexandra', '10000286', 'Rectoría', 'MXB0034608 - Programa de Egresados', 'Auxiliar administrativo                 ', 'Operativos 1', '32148709', 'Aysa Rodríguez Ana Lucía', 'alexandra.pieck@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160205', 'Sabido', 'Basteris', 'Maricarmen', '10000213', 'Vicerrectoría Académica', 'MXB0031405 - Derecho', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124350', 'Álvarez Escalante Absalón', 'maricarmen.sabido@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160207', 'Oropeza', 'Gorocica', 'Virginia Meribeth', '10000212', 'Vicerrectoría Académica', 'MXB0031404 - Diseño', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32156835', 'Duarte Rosado Yermak Alexandro', 'virginia.oropeza@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160208', 'Couoh', 'Castañeda', 'Jary Davis', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Asistente académico                     ', 'Mandos medios y profesorado 2', '32142651', 'Echeverría y Eguiluz José Manuel', 'jary.couoh@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160218', 'Rocha', 'Sánchez', 'Miguel Ángel', '10000212', 'Vicerrectoría Académica', 'MXB0031404 - Diseño', 'Auxiliar de laboratorio y/o taller      ', 'Operativos 2', '32156835', 'Duarte Rosado Yermak Alexandro', 'miguel.rocha@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160223', 'Recillas', 'Ilizaliturri', 'Yerani', '10000282', 'Rectoría', 'MXB0034604 - Gerencia de Recursos humanos', 'Auxiliar administrativo                 ', 'Operativos 1', '32124186', 'Narváez Galaz Lia Regina', 'yerani.recillas@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160333', 'Farias', 'Fueyo', 'Maria Eugenia', '10000266', 'Rectoría', 'MXB0034301 - Promoción', 'Asesor preuniversitario                 ', 'Mandos medios y profesorado 2', '32153479', 'González Anaya Ana Paulina', 'maria.farias@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160334', 'Ortega', 'Rios Covian', 'Roberto Antonio', '10000280', 'Rectoría', 'MXB0034602 - Coordinación de Comunicación', 'Diseñador                               ', 'Operativos 1', '32124224', 'Herrera Baas Florángely', 'roberto.ortega@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160335', 'Novelo', 'Castro', 'Luis Andres', '10004628', 'Vicerrectoría Académica', 'MXB0121548 - Mtria.DirTecnEnInfyTel MID', 'Coordinador de posgrados y extensión              Coordinador de posgrados y extensión              Coordinador de posgrados y extensión              Coordinador de posgrados y extensión              Coordinador de posgrados y extensión              Coord', 'Mandos medios y profesorado 1 ', '32124226', 'Anaya Sandoval Juan Antonio', 'luis.novelo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160340', 'Mena', 'Aranda', 'Almendra Ascencion', '10000280', 'Rectoría', 'MXB0034602 - Coordinación de Comunicación', 'Especialista en página WEB', 'Operativos 1', '32124224', 'Herrera Baas Florángely', 'almendra.mena@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160391', 'Bleis', 'Yam', 'Jessica Selene', '10000266', 'Rectoría', 'MXB0034301 - Promoción', 'Coordinador de becas a alumnos          ', 'Mandos medios y profesorado 2', '32147708', 'López Vales María Anunciata', 'jessica.bleis@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160394', 'Vázquez', 'Navarrete', 'Jesús Alberto', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Técnico de soporte                      ', 'Operativos 1', '32124304', 'Mendoza Noh Beatriz Anilú', 'jesus.vazquez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160407', 'Nabté', 'Escamilla', 'María De Guadalupe', '10000215', 'Vicerrectoría Académica', 'MXB0031408 - Psicología', 'Técnico de laboratorio y/o taller       ', 'Operativos 1', '32124225', 'González Novelo José Alejandro', 'maria.nabte@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160437', 'Olea', 'Martínez', 'Manuel', '10000211', 'Vicerrectoría Académica', 'MXB0031403 - Ciencias de la Comunicación', 'Técnico de laboratorio y/o taller       ', 'Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1', '32124209', 'Tello Rodriguez Marisol', 'manuel.olea@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160469', 'Góngora', 'González', 'Mariel', '10000287', 'Vicerrectoría Académica', 'MXB0034901 - Biblioteca', 'Auxiliar de Biblioteca                  ', 'Operativos 2', '32124238', 'Torreblanca Rios Fernando Antonio', 'mariel.gongora@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160511', 'Andrade', 'Nuñez', 'Brenda', '10000212', 'Vicerrectoría Académica', 'MXB0031404 - Diseño', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32156835', 'Duarte Rosado Yermak Alexandro', 'brenda.andrade@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160580', 'González', 'Angulo', 'Ileana Isabel', '10002630', 'Vicerrectoría Académica', 'MXB0121501 - Dirección de Posgrados y Extensión', 'Coordinador de Programas Posgrado y Exte', 'Mandos medios y profesorado 1 ', '32124181', 'Mendoza Villalobos Alejandra', 'ileana.gonzalez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160581', 'Pech', 'Argüelles', 'Miguel Francisco', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Auxiliar técnico                        ', 'Operativos 2', '32124234', 'Peraza Rosas María Jazmine del Carmen', 'miguel.pech@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160582', 'Puc', 'Rodríguez', 'Adriana Raquel', '10004202', 'Vicerrectoría de Formación Integral', 'MXB0031606 - Difusión Cultural', 'Auxiliar administrativo                 ', 'Operativos 1', '32142649', 'Muñoz Bello Aida Rosa', 'adriana.puc@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160583', 'Lara', 'Mena', 'Stacy', '10000282', 'Rectoría', 'MXB0034604 - Gerencia de Recursos humanos', 'Auxiliar administrativo                 ', 'Operativos 1', '32124186', 'Narváez Galaz Lia Regina', 'stacy.lara@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160755', 'Peniche', 'Gómez', 'Gloria', '10002630', 'Vicerrectoría Académica', 'MXB0121501 - Dirección de Posgrados y Extensión', 'Asistente Académico                     Asistente Académico                     Asistente Académico                     Asistente Académico                     Asistente Académico                     Asistente Académico                     Asistente Acadé', 'Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y', '32155724', 'Ortega Rosado Laura Elena', 'gloria.peniche@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160756', 'Pacheco', 'Pantoja', 'María Antonieta', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32142658', 'Ortiz Heredia Hansel Francisco', 'maria.pacheco@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160764', 'Palomo', null, 'Juan Andrés', '10000284', 'Rectoría', 'MXB0034606 - Dirección de Desarrollo Institucional', 'Secretario  de depto.', 'Operativos 1', '32146961', 'Castillo Salazar Tatiana Macarena', 'juan.palomo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160812', 'Escalante', 'Alpuche', 'Ileana Cristina', '10004054', 'Vicerrectoría de Formación Integral', 'MXB0031607 - Vicerrectoría de Formación Integral', 'Especialista de atención a foráneos     ', 'Operativos 1', '32124321', 'Franco Calvillo José Rodrigo ', 'ileana.escalante@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160871', 'Jiménez', 'Urcelay', 'Elsa Beatriz', '10000214', 'Vicerrectoría Académica', 'MXB0031407 - División de Negocios', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124192', 'Negroe Monforte Benjamín Ramón', 'elsa.jimenez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160873', 'Bravo', 'Vargas', 'Karla Yaneth', '10000279', 'Rectoría', 'MXB0034601 - Rectoría UA Mayab', 'Secretario(a) de rectoría               ', 'Operativos 1', '1', 'Pardo Hervás P.Rafael', 'karla.bravo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160877', 'Poot', 'Palma', 'Enrique', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Auxiliar técnico                        ', 'Operativos 2', '32124234', 'Peraza Rosas María Jazmine del Carmen', 'enrique.poot@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160908', 'Xix', 'Tzakum', 'Daniel Alejandro', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Chofer mensajero                        ', 'Operativos 2', '32124289', 'Echazarreta Montero Jhoanna', 'daniel.xix@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160909', 'Romero', 'García', 'Mariana', '10000280', 'Rectoría', 'MXB0034602 - Coordinación de Comunicación', 'Diseñador                               ', 'Operativos 1', '32124224', 'Herrera Baas Florángely', 'mariana.romero@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32160969', 'Carrasco', 'Azcuaga', 'Alicia Reneé', '10000280', 'Rectoría', 'MXB0034602 - Coordinación de Comunicación', 'Auxiliar administrativo                 ', 'Operativos 1', '32143828', 'Ojeda Viana Georgina Maribel', 'alicia.carrasco@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161036', 'Berber', 'Selem', 'Grecia Estefanía', '10000219', 'Vicerrectoría Académica', 'MXB0031413 - Nutrición', 'Auxiliar de laboratorio y/o taller      ', 'Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Ope', '32124257', 'Barrera Bustillo Martha Eugenia', 'grecia.berber@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161038', 'Esquivel', 'Martínez', 'Gonzalo Enrique', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Auxiliar de laboratorio y/o taller      ', 'Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2', '32124342', 'Luna Martínez José Luis', 'gonzalo.esquivel@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161042', 'Gutiérrez', 'Ramírez', 'Erika Astrid', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Auxiliar de laboratorio y/o taller      ', 'Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2', '32124342', 'Luna Martínez José Luis', 'erika.gutierrez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161044', 'Alfaro', 'Herrera', 'Yohanna', '10000220', 'Vicerrectoría Académica', 'MXB0031414 - Cirujano Dentista', 'Auxiliar de laboratorio y/o taller      ', 'Operativos 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'yohanna.alfaro@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161047', 'Ortega', 'González', 'Ileana Guadalupe', '10003300', 'Vicerrectoría Académica', 'MXB0121506 - Mtria. Alta Dirección y Neg. (mid)', 'Coordinador de posgrados  y extensión             Coordinador de posgrados  y extensión             Coordinador de posgrados  y extensión             Coordinador de posgrados  y extensión             Coordinador de posgrados  y extensión             Coord', 'Mandos medios y profesorado 1 ', '32142658', 'Ortiz Heredia Hansel Francisco', 'ileana.ortega@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161048', 'Aguilar', 'Torres', 'Fernando Humberto', '10000217', 'Vicerrectoría Académica', 'MXB0031411 - Médico Cirujano', 'Auxiliar de laboratorio y/o taller      ', 'Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Ope', '32124342', 'Luna Martínez José Luis', 'fernando.aguilar@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161083', 'Abreu', 'Pérez', 'Eduardo José', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'eduardo.abreu@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161099', 'Bastarrachea', 'May', 'Naomy Del Pilar', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'naomy.bastarrachea@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161233', 'Ramos', 'Gómez', 'Lucia Jaqueline', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'lucia.ramos@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161243', 'Salas', 'Ley', 'Mildred Beatriz', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'mildred.salas@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161296', 'Rosas', 'Caballero', 'Edwin Manuel', '10000216', 'Vicerrectoría Académica', 'MXB0031410 - División de Ingeniería', 'Técnico de laboratorio y/o taller       ', 'Operativos 1', '32124226', 'Anaya Sandoval Juan Antonio', 'edwin.rosas@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161372', 'Hoyos', 'Pinzón', 'Manuel Hernán', '10000220', 'Vicerrectoría Académica', 'MXB0031414 - Cirujano Dentista', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'manuel.hoyos@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161402', 'Moguel', 'Ojeda', 'Rubi Del Socorro', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'rubi.moguel@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161632', 'Mendoza', 'Aguilar', 'Pedro Antonio', '10004203', 'Vicerrectoría de Formación Integral', 'MXB0031612 - Coordinación de Selecciones y Ac. Deport', 'Entrenador de Selecciones               ', 'Mandos medios y profesorado 2', '32124321', 'Franco Calvillo José Rodrigo ', 'pamakeb@hotmail.com');
INSERT INTO `empleados_source` VALUES ('32161633', 'López', 'Nah', 'Yuselmy Fabiola', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Auxiliar Contable                       ', 'Operativos 1', '32124243', 'Euan Calderón Eugenia Beatriz', 'yuselmy.lopez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161636', 'Pérez', 'Méndez', 'Yussiff Emmanuel', '10000265', 'Vicerrectoría de Administración y Finanzas', 'MXB0034101 - Mantenimiento', 'Auxiliar administrativo                 ', 'Operativos 1', '32124202', 'Zaldivar Álvarez Antonio', 'yussiff.perez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161674', 'Cruz', 'Ricalde', 'Kevin Alberto', '10000266', 'Rectoría', 'MXB0034301 - Promoción', 'Asesor preuniversitario                 ', 'Mandos medios y profesorado 2', '32153479', 'González Anaya Ana Paulina', 'kevin.cruz@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161675', 'Evia', 'Ceballos', 'Nury Fernanda', '10004053', 'Vicerrectoría de Formación Integral', 'MXB0031602 - Programas de liderazgo VERTICE', 'Coordinador de programas de liderazgo   ', 'Mandos medios y profesorado 1 ', '32124321', 'Franco Calvillo José Rodrigo ', 'nury.evia@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161770', 'González', 'Somonte', 'Rodrigo', '10000211', 'Vicerrectoría Académica', 'MXB0031403 - Ciencias de la Comunicación', 'Técnico de laboratorio y/o taller       ', 'Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1', '32124209', 'Tello Rodriguez Marisol', 'rodrigo.gonzalez2@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161773', 'Sierra', 'González', 'Mónica', '10000266', 'Rectoría', 'MXB0034301 - Promoción', 'Especialista de orientación vocacional  ', 'Mandos medios y profesorado 2', '32151603', 'Marqueda Alcocer Maricela ', 'monica.sierra@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161867', 'Ferro', 'Muñoz', 'Farrah Silvana', '10002630', 'Vicerrectoría Académica', 'MXB0121501 - Dirección de Posgrados y Extensión', 'Asistente Académico                     Asistente Académico                     Asistente Académico                     Asistente Académico                     Asistente Académico                     Asistente Académico                     Asistente Acadé', 'Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profeso', '32124181', 'Mendoza Villalobos Alejandra', 'farrah.ferro@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161868', 'Bolio', 'Martínez', 'María Lucía', '10004056', 'Vicerrectoría de Formación Integral', 'MXB0031605 - Servicio y Acción Social', 'Auxiliar administrativo                 ', 'Operativos 1', '32153874', 'Saldaña Aportela Ernesto', 'lucia.bolio@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32161974', 'Brizuela', 'Gabriel', 'Angélica', '10004056', 'Vicerrectoría de Formación Integral', 'MXB0031605 - Servicio y Acción Social', 'Auxiliar administrativo                 ', 'Operativos 1', '32153874', 'Saldaña Aportela Ernesto', 'angelica.brizuela@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162014', 'Salgado', 'Ríos', 'Gerardo Iván', '10000281', 'Rectoría', 'MXB0034603 - Coordinación de Vinculación y Recaudación', 'Coordinador de vinculación y recaud fond', 'Mandos medios y profesorado 1 ', '32123111', 'Gutiérrez Martínez Luis Ernesto', 'gerardo.salgado@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162062', 'Vallejo', 'Álvarez', 'Ayerím Del Rosario', '10004055', 'Vicerrectoría de Formación Integral', 'MXB0031604 - Red Misión', 'Coordinador de programas de liderazgo   ', 'Mandos medios y profesorado 1 ', '32124321', 'Franco Calvillo José Rodrigo ', 'ayerim.vallejo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162093', 'Enríquez', 'Vázquez', 'Erika Del Socorro', '10000271', 'Vicerrectoría Académica', 'MXB0034407 - Desarrollo Académico', 'Coordinador de tutorías y apoyo académic', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y', '32124245', 'Guzmán Silva Susana', 'erika.enriquezv@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162270', 'Jimenez', 'Bautista', 'Johann Erasto', '10000280', 'Rectoría', 'MXB0034602 - Coordinación de Comunicación', 'Especialista en página WEB              Especialista en página WEB              Especialista en página WEB              Especialista en página WEB              Especialista en página WEB              Especialista en página WEB              Especialista en', 'Operativos 1', '32124224', 'Herrera Baas Florángely', 'johann.jimenez@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162275', 'Tec', 'Cetina', 'Noé De Jesús', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'noe.tec@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162282', 'Puc', 'Pool', 'Roberto Iván', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'roberto.puc@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162285', 'Carrillo', 'Peraza', 'Adriana Gabriela', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'adriana.carrillo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162288', 'Vargas', 'Chávez', 'Minerva Stephani', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'minerva.vargas@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162289', 'Gutierrez', 'Peniche', 'Eduardo José', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'eduardo.gutierrezp@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162403', 'Gómez', 'Domenzáin', 'Andrea', '10004055', 'Vicerrectoría de Formación Integral', 'MXB0031604 - Red Misión', 'Auxiliar administrativo                 ', 'Operativos 1', '32162062', 'Vallejo Álvarez Ayerím del Rosario', 'andrea.gomezd@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162406', 'Lugo', 'Ancona', 'Marcos Daniel', '10002646', 'Vicerrectoría Académica', 'MXB0121519 - Esp. Odontologia', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'marcos.lugo@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162408', 'González', 'Calcáneo', 'Patricia Isabel', '10000220', 'Vicerrectoría Académica', 'MXB0031414 - Cirujano Dentista', 'Auxiliar de laboratorio y/o taller      ', 'Operativos 2', '32154629', 'Peniche Marcín Rolando Gonzalo', 'patricia.gonzalezg@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162409', 'Kemp', 'Medina', 'Pamela', '10004204', 'Vicerrectoría de Formación Integral', 'MXB0034510 - Bloque Electivo Anahuac', 'Auxiliar administrativo                 ', 'Operativos 1', '32150470', 'Novelo Alcocer Linabel', 'pamela.kemp@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162414', 'Quijano', 'Ricalde', 'Marcelo Ulises', '10000264', 'Vicerrectoría de Administración y Finanzas', 'MXB0034001 - Vicerrectoría Administración y Finanzas', 'Supervisor Administrativo               ', 'Operativos 1', '32124189', 'Ontiveros Velázquez Julio Antonio', 'marcelo.quijano@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162491', 'Córdoba', 'Pech', 'Gicel', '10004064', 'Rectoría', 'MXB0033304 - Coordinación de Servicios Tecnológicos', 'Técnico de soporte                      ', 'Operativos 1', '32124304', 'Mendoza Noh Beatriz Anilú', 'gicel.cordoba@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162547', 'Rivera de Vargas', null, 'Carola Hortensia', '10004090', 'Rectoría', 'MXB0127414 - Oficina de Transferencia', 'Asistente de dirección                    ', 'Mandos medios y profesorado 2', '32143434', 'Garza Roche Regina', 'carola.rivera@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162548', 'Palma', 'Castillo', 'Carlos Alberto', '10004062', 'Rectoría', 'MXB0033302 - Dirección de Administraci', 'Auxiliar administrativo                 ', 'Operativos 1', '32124975', 'Rodriguez Pech Mayte Eugenia', 'carlos.palma@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162549', 'Arcos', 'Solis', 'Marvin', '10000284', 'Rectoría', 'MXB0034606 - Dirección de Desarrollo Institucional', 'Secretario  de depto.', 'Operativos 1', '32146961', 'Castillo Salazar Tatiana Macarena', 'marvin.arcos@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162550', 'Canto', 'Herrera', 'Cristina Gisela', '10004090', 'Rectoría', 'MXB0127414 - Oficina de Transferencia', 'Asistente académico                     ', 'Mandos medios y profesorado 2 ', '32143434', 'Garza Roche Regina', 'cristina.canto@anahuac.mx');
INSERT INTO `empleados_source` VALUES ('32162559', 'Mir', 'Gil', 'David', '10000221', 'Vicerrectoría Académica', 'MXB0031415 - Arquitectura', 'Profesor universitario                  ', 'Mandos medios y profesorado 2', '32124195', 'Tello Rodriguez Martha María', 'david.mir@anahuac.mx');

-- ----------------------------
-- Table structure for evaluaciones
-- ----------------------------
DROP TABLE IF EXISTS `evaluaciones`;
CREATE TABLE `evaluaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `usuarioRegistrante` varchar(255) DEFAULT NULL,
  `fechaRegistro` datetime DEFAULT NULL,
  `texto_bienvenida_evaluacion` text,
  `texto_bienvenida_autoevaluacion` text,
  `status` int(11) DEFAULT '0' COMMENT '0: Cerrado\r\n1: Abierto para evaluación\r\n2: Abierto para autoevaluación',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ap_id` (`id`) USING BTREE,
  UNIQUE KEY `app_titulo` (`titulo`),
  KEY `ap_usuario` (`usuarioRegistrante`) USING BTREE,
  KEY `ap_freg` (`fechaRegistro`) USING BTREE,
  KEY `ap_status` (`status`) USING BTREE,
  CONSTRAINT `fk_evals_usuarios_1` FOREIGN KEY (`usuarioRegistrante`) REFERENCES `usuarios` (`usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Esta es la tabla que indeza los ciclos de aplicaciones de evaluaciones.\r\nDebe incluir todos los posibles status que pueda tener para proveer de información rápidamente.';

-- ----------------------------
-- Records of evaluaciones
-- ----------------------------
INSERT INTO `evaluaciones` VALUES ('1', '2016', 'admin', '2016-03-12 13:34:12', '<p>Es un gusto contar con tu compromiso y dedicación al responder los reactivos de manera objetiva para continuar fortaleciendo\r\n	a tu departamento  y  a  nuestra Universidad.\r\n</p>\r\n<p>\r\n	Recuerda que el cierre de las evaluaciones será el <b>Miércoles 3 de mayo de 2016 a las 20:00 horas</b>.<br>\r\n	Los resultados serán enviados en las siguientes fechas:\r\n	<ul>\r\n		<li>El <b>lunes 6 y martes 7 de junio de 2016</b> se entregarán a <b>cada Evaluador</b> los <b>resultados impresos</b>.</li>\r\n		<li>El <b>lunes 27 de junio de 2016</b> se enviarán por correo electrónico a cada colaborador.</li>\r\n	</ul>\r\n	<b>¡GRACIAS por tu tiempo!</b>\r\n</p>', '<p>Es un gusto contar con tu compromiso y dedicación al responder los reactivos de manera objetiva para continuar fortaleciendo\r\n	a tu departamento  y  a  nuestra Universidad.\r\n</p>\r\n<p>\r\n	Recuerda que el cierre de las evaluaciones será el <b>Miércoles 3 de mayo de 2016 a las 20:00 horas</b>.<br>\r\n	<b>¡GRACIAS por tu tiempo!</b>\r\n</p>', '1');

-- ----------------------------
-- Table structure for evaluaciones_cuestionario_niveles
-- ----------------------------
DROP TABLE IF EXISTS `evaluaciones_cuestionario_niveles`;
CREATE TABLE `evaluaciones_cuestionario_niveles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `tipo` enum('competencia','manual') DEFAULT 'competencia',
  `id_competencia` int(11) DEFAULT NULL,
  `id_manual` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_id` (`id`),
  UNIQUE KEY `ec_key` (`evaluacion`,`nivel`,`id_competencia`),
  UNIQUE KEY `ec_key2` (`evaluacion`,`nivel`,`id_manual`),
  KEY `ec_eval` (`evaluacion`),
  KEY `ec_nivel` (`nivel`),
  KEY `ec_comp` (`id_competencia`),
  KEY `ec_manu` (`id_manual`),
  CONSTRAINT `ec_comp` FOREIGN KEY (`id_competencia`) REFERENCES `cuestionarios_competencias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ec_eval` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ec_man` FOREIGN KEY (`id_manual`) REFERENCES `cuestionarios_manual_input` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ec_niv` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of evaluaciones_cuestionario_niveles
-- ----------------------------

-- ----------------------------
-- Table structure for evaluaciones_cuestionario_puestos
-- ----------------------------
DROP TABLE IF EXISTS `evaluaciones_cuestionario_puestos`;
CREATE TABLE `evaluaciones_cuestionario_puestos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `tipo` enum('competencia','manual') DEFAULT 'competencia',
  `id_competencia` int(11) DEFAULT NULL,
  `id_manual` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_id` (`id`),
  UNIQUE KEY `ec_un` (`evaluacion`,`nivel`,`id_competencia`) USING BTREE,
  KEY `ec_comp` (`id_competencia`),
  KEY `ec_manu` (`id_manual`),
  KEY `ecp4` (`nivel`),
  KEY `ec_eval` (`evaluacion`,`nivel`,`id_manual`) USING BTREE,
  CONSTRAINT `ecp1` FOREIGN KEY (`id_competencia`) REFERENCES `cuestionarios_competencias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ecp2` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ecp3` FOREIGN KEY (`id_manual`) REFERENCES `cuestionarios_manual_input` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ecp4` FOREIGN KEY (`nivel`) REFERENCES `puestos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of evaluaciones_cuestionario_puestos
-- ----------------------------

-- ----------------------------
-- Table structure for jerarquias
-- ----------------------------
DROP TABLE IF EXISTS `jerarquias`;
CREATE TABLE `jerarquias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) DEFAULT NULL,
  `jefe` int(11) DEFAULT NULL,
  `subordinado` int(11) DEFAULT NULL,
  `fechaRegistro` datetime DEFAULT NULL,
  `usuarioRegistrante` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `je_id` (`id`),
  UNIQUE KEY `je_relacion` (`jefe`,`subordinado`),
  UNIQUE KEY `je_constrain` (`evaluacion`,`subordinado`),
  KEY `je_jefe` (`jefe`),
  KEY `je_aplicacion` (`evaluacion`),
  KEY `je_subordinado` (`subordinado`),
  KEY `je_usuario` (`usuarioRegistrante`),
  CONSTRAINT `jerarquias_ibfk_1` FOREIGN KEY (`jefe`) REFERENCES `empleados` (`empleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jerarquias_ibfk_2` FOREIGN KEY (`subordinado`) REFERENCES `empleados` (`empleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jerarquias_ibfk_3` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jerarquias_ibfk_4` FOREIGN KEY (`usuarioRegistrante`) REFERENCES `usuarios` (`usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=515 DEFAULT CHARSET=utf8 COMMENT='Índice de relaciones entre jefes y subordinados por aplicación.';

-- ----------------------------
-- Records of jerarquias
-- ----------------------------
INSERT INTO `jerarquias` VALUES ('1', '1', null, '1', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('2', '1', null, '2', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('4', '1', '1', '32123111', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('5', '1', '1', '32124186', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('6', '1', '1', '32124216', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('7', '1', '1', '32124224', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('8', '1', '1', '32124235', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('9', '1', '1', '32124267', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('10', '1', '1', '32124321', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('11', '1', '1', '32142632', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('12', '1', '1', '32142652', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('13', '1', '1', '32142871', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('14', '1', '1', '32143434', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('15', '1', '1', '32147708', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('16', '1', '1', '32153844', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('17', '1', '1', '32159882', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('18', '1', '1', '32160873', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('19', '1', '2', '32122411', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('20', '1', '2', '32124189', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('21', '1', '2', '32124202', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('22', '1', '2', '32124256', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('23', '1', '2', '32124289', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('24', '1', '2', '32124341', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('25', '1', '2', '32148648', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('26', '1', '2', '32149265', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('27', '1', '32123111', '32146961', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('28', '1', '32123111', '32148709', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('29', '1', '32123111', '32159619', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('30', '1', '32123111', '32159786', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('31', '1', '32123111', '32162014', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('32', '1', '32124181', '32124278', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('33', '1', '32124181', '32124348', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('34', '1', '32124181', '32155690', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('35', '1', '32124181', '32155724', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('36', '1', '32124181', '32160580', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('37', '1', '32124181', '32161867', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('38', '1', '32124183', '32124172', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('39', '1', '32124183', '32124333', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('40', '1', '32124183', '32124349', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('41', '1', '32124183', '32147655', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('42', '1', '32124183', '32149970', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('43', '1', '32124183', '32157290', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('44', '1', '32124186', '32124248', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('45', '1', '32124186', '32142628', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('46', '1', '32124186', '32146467', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('47', '1', '32124186', '32154094', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('48', '1', '32124186', '32155512', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('49', '1', '32124186', '32157581', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('50', '1', '32124186', '32160223', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('51', '1', '32124186', '32160583', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('52', '1', '32124188', '32142851', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('53', '1', '32124189', '32124197', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('54', '1', '32124189', '32124199', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('55', '1', '32124189', '32124233', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('56', '1', '32124189', '32124276', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('57', '1', '32124189', '32124330', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('58', '1', '32124189', '32124351', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('59', '1', '32124189', '32124359', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('60', '1', '32124189', '32137035', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('61', '1', '32124189', '32151397', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('62', '1', '32124189', '32151598', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('63', '1', '32124189', '32153323', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('64', '1', '32124189', '32154516', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('65', '1', '32124189', '32154574', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('66', '1', '32124189', '32155229', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('67', '1', '32124189', '32157400', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('68', '1', '32124189', '32157585', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('69', '1', '32124189', '32157697', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('70', '1', '32124189', '32162414', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('71', '1', '32124192', '32124210', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('72', '1', '32124192', '32124279', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('73', '1', '32124192', '32124346', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('74', '1', '32124192', '32124898', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('75', '1', '32124192', '32142634', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('76', '1', '32124192', '32160871', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('77', '1', '32124195', '32137040', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('78', '1', '32124195', '32144113', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('79', '1', '32124195', '32148865', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('80', '1', '32124195', '32149870', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('81', '1', '32124195', '32153980', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('82', '1', '32124195', '32162559', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('83', '1', '32124202', '32124170', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('84', '1', '32124202', '32124218', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('85', '1', '32124202', '32124253', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('86', '1', '32124202', '32124274', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('87', '1', '32124202', '32124302', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('88', '1', '32124202', '32124328', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('89', '1', '32124202', '32124366', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('90', '1', '32124202', '32149072', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('91', '1', '32124202', '32154463', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('92', '1', '32124202', '32154649', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('93', '1', '32124202', '32157789', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('94', '1', '32124202', '32159728', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('95', '1', '32124202', '32161636', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('96', '1', '32124209', '32124227', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('97', '1', '32124209', '32124249', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('98', '1', '32124209', '32124255', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('99', '1', '32124209', '32124320', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('100', '1', '32124209', '32147070', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('101', '1', '32124209', '32154166', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('102', '1', '32124209', '32157498', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('103', '1', '32124209', '32160437', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('104', '1', '32124209', '32161770', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('105', '1', '32124224', '32143828', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('106', '1', '32124224', '32144995', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('107', '1', '32124224', '32153970', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('108', '1', '32124224', '32159906', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('109', '1', '32124224', '32160334', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('110', '1', '32124224', '32160340', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('111', '1', '32124224', '32160909', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('112', '1', '32124224', '32162270', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('113', '1', '32124225', '32124272', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('114', '1', '32124225', '32137036', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('115', '1', '32124225', '32144555', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('116', '1', '32124225', '32152638', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('117', '1', '32124225', '32154101', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('118', '1', '32124225', '32157009', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('119', '1', '32124225', '32160407', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('120', '1', '32124226', '32124187', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('121', '1', '32124226', '32142661', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('122', '1', '32124226', '32144114', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('123', '1', '32124226', '32147525', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('124', '1', '32124226', '32150757', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('125', '1', '32124226', '32154314', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('126', '1', '32124226', '32160335', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('127', '1', '32124226', '32161296', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('128', '1', '32124229', '32147527', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('129', '1', '32124229', '32159883', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('130', '1', '32124234', '32124370', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('131', '1', '32124234', '32149174', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('132', '1', '32124234', '32153663', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('133', '1', '32124234', '32154936', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('134', '1', '32124234', '32160581', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('135', '1', '32124234', '32160877', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('136', '1', '32124236', '32151597', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('137', '1', '32124236', '32151614', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('138', '1', '32124236', '32157535', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('139', '1', '32124238', '32124317', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('140', '1', '32124238', '32124331', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('141', '1', '32124238', '32146674', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('142', '1', '32124238', '32154228', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('143', '1', '32124238', '32159413', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('144', '1', '32124238', '32160469', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('145', '1', '32124243', '32148210', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('146', '1', '32124243', '32149819', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('147', '1', '32124243', '32150966', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('148', '1', '32124243', '32151595', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('149', '1', '32124243', '32161633', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('150', '1', '32124245', '32123705', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('151', '1', '32124245', '32124236', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('152', '1', '32124245', '32124269', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('153', '1', '32124245', '32137041', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('154', '1', '32124245', '32140720', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('155', '1', '32124245', '32142875', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('156', '1', '32124245', '32149485', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('157', '1', '32124245', '32162093', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('158', '1', '32124257', '32124284', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('159', '1', '32124257', '32124343', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('160', '1', '32124257', '32133367', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('161', '1', '32124257', '32146480', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('162', '1', '32124257', '32149977', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('163', '1', '32124257', '32151505', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('164', '1', '32124257', '32154693', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('165', '1', '32124257', '32161036', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('166', '1', '32124267', '32124315', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('167', '1', '32124267', '32124365', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('168', '1', '32124267', '32142874', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('169', '1', '32124267', '32160092', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('170', '1', '32124278', '32147524', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('171', '1', '32124289', '32124176', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('172', '1', '32124289', '32143366', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('173', '1', '32124289', '32152778', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('174', '1', '32124289', '32160908', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('175', '1', '32124304', '32143258', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('176', '1', '32124304', '32160394', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('177', '1', '32124304', '32162491', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('178', '1', '32124315', '32124188', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('179', '1', '32124315', '32124975', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('180', '1', '32124315', '32154232', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('181', '1', '32124321', '32124194', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('182', '1', '32124321', '32133467', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('183', '1', '32124321', '32136613', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('184', '1', '32124321', '32136969', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('185', '1', '32124321', '32142235', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('186', '1', '32124321', '32142649', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('187', '1', '32124321', '32142653', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('188', '1', '32124321', '32143970', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('189', '1', '32124321', '32145534', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('190', '1', '32124321', '32150470', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('191', '1', '32124321', '32152130', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('192', '1', '32124321', '32152377', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('193', '1', '32124321', '32153290', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('194', '1', '32124321', '32153874', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('195', '1', '32124321', '32155174', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('196', '1', '32124321', '32160812', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('197', '1', '32124321', '32161632', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('198', '1', '32124321', '32161675', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('199', '1', '32124321', '32162062', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('200', '1', '32124341', '32124243', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('201', '1', '32124341', '32137037', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('202', '1', '32124341', '32145548', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('203', '1', '32124341', '32148074', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('204', '1', '32124341', '32148862', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('205', '1', '32124341', '32148868', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('206', '1', '32124341', '32153437', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('207', '1', '32124341', '32155726', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('208', '1', '32124341', '32157582', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('209', '1', '32124342', '32161038', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('210', '1', '32124342', '32161042', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('211', '1', '32124342', '32161048', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('212', '1', '32124350', '32124174', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('213', '1', '32124350', '32124190', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('214', '1', '32124350', '32124275', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('215', '1', '32124350', '32124903', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('216', '1', '32124350', '32147649', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('217', '1', '32124350', '32160205', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('218', '1', '32124975', '32124178', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('219', '1', '32124975', '32124222', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('220', '1', '32124975', '32124336', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('221', '1', '32124975', '32144190', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('222', '1', '32124975', '32162548', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('223', '1', '32137041', '32124198', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('224', '1', '32137041', '32124282', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('225', '1', '32137041', '32133083', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('226', '1', '32137041', '32145538', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('227', '1', '32137041', '32149218', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('228', '1', '32142628', '32151854', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('229', '1', '32142632', '32124181', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('230', '1', '32142632', '32124183', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('231', '1', '32142632', '32124184', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('232', '1', '32142632', '32124195', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('233', '1', '32142632', '32124209', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('234', '1', '32142632', '32124225', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('235', '1', '32142632', '32124226', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('236', '1', '32142632', '32124229', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('237', '1', '32142632', '32124245', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('238', '1', '32142632', '32124257', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('239', '1', '32142632', '32124291', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('240', '1', '32142632', '32124350', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('241', '1', '32142632', '32142651', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('242', '1', '32142632', '32147656', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('243', '1', '32142632', '32148701', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('244', '1', '32142632', '32149211', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('245', '1', '32142632', '32154240', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('246', '1', '32142632', '32154629', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('247', '1', '32142632', '32156835', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('248', '1', '32142649', '32157584', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('249', '1', '32142649', '32160582', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('250', '1', '32142651', '32124213', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('251', '1', '32142651', '32124214', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('252', '1', '32142651', '32124215', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('253', '1', '32142651', '32124329', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('254', '1', '32142651', '32124342', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('255', '1', '32142651', '32142999', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('256', '1', '32142651', '32144462', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('257', '1', '32142651', '32144526', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('258', '1', '32142651', '32148067', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('259', '1', '32142651', '32149175', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('260', '1', '32142651', '32149706', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('261', '1', '32142651', '32149975', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('262', '1', '32142651', '32151436', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('263', '1', '32142651', '32151835', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('264', '1', '32142651', '32152177', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('265', '1', '32142651', '32157008', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('266', '1', '32142651', '32160208', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('267', '1', '32142652', '32124185', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('268', '1', '32142652', '32124313', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('269', '1', '32142652', '32124344', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('270', '1', '32142652', '32153664', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('271', '1', '32142658', '32124303', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('272', '1', '32142658', '32146544', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('273', '1', '32142658', '32157048', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('274', '1', '32142658', '32160756', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('275', '1', '32142658', '32161047', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('276', '1', '32142661', '32124206', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('277', '1', '32142661', '32124292', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('278', '1', '32142661', '32145155', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('279', '1', '32142661', '32146510', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('280', '1', '32142661', '32155231', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('281', '1', '32142661', '32157288', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('282', '1', '32142667', '32124193', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('283', '1', '32142667', '32137185', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('284', '1', '32142667', '32148863', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('285', '1', '32142667', '32148924', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('286', '1', '32142667', '32152425', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('287', '1', '32142667', '32152691', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('288', '1', '32142667', '32159427', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('289', '1', '32142851', '32160003', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('290', '1', '32143434', '32124355', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('291', '1', '32143434', '32148332', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('292', '1', '32143434', '32153815', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('293', '1', '32143434', '32162547', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('294', '1', '32143434', '32162550', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('295', '1', '32143828', '32154651', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('296', '1', '32143828', '32160969', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('297', '1', '32144114', '32143435', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('298', '1', '32144995', '32157686', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('299', '1', '32144995', '32160002', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('300', '1', '32146467', '32148606', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('301', '1', '32146467', '32153319', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('302', '1', '32146961', '32154937', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('303', '1', '32146961', '32160764', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('304', '1', '32146961', '32162549', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('305', '1', '32147525', '32157650', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('306', '1', '32147656', '32124196', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('307', '1', '32147656', '32124238', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('308', '1', '32147656', '32124281', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('309', '1', '32147656', '32159479', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('310', '1', '32147708', '32151164', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('311', '1', '32147708', '32151603', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('312', '1', '32147708', '32153479', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('313', '1', '32147708', '32153871', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('314', '1', '32147708', '32157587', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('315', '1', '32147708', '32160391', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('316', '1', '32148067', '32124223', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('317', '1', '32148067', '32145420', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('318', '1', '32148067', '32151737', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('319', '1', '32148067', '32153840', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('320', '1', '32148067', '32157836', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('321', '1', '32148074', '32124363', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('322', '1', '32148074', '32145456', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('323', '1', '32148648', '32144069', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('324', '1', '32148701', '32157412', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('325', '1', '32148701', '32159732', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('326', '1', '32148709', '32159481', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('327', '1', '32148709', '32160093', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('328', '1', '32149211', '32124192', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('329', '1', '32149211', '32142658', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('330', '1', '32149211', '32142667', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('331', '1', '32149211', '32149910', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('332', '1', '32149706', '32144380', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('333', '1', '32149706', '32152430', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('334', '1', '32149973', '32143261', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('335', '1', '32149973', '32153337', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('336', '1', '32150470', '32162409', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('337', '1', '32151164', '32148925', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('338', '1', '32151164', '32159785', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('339', '1', '32151603', '32157402', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('340', '1', '32151603', '32161773', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('341', '1', '32153479', '32160333', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('342', '1', '32153479', '32161674', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('343', '1', '32153874', '32161868', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('344', '1', '32153874', '32161974', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('345', '1', '32154232', '32157586', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('346', '1', '32154629', '32137726', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('347', '1', '32154629', '32142985', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('348', '1', '32154629', '32144488', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('349', '1', '32154629', '32148278', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('350', '1', '32154629', '32149269', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('351', '1', '32154629', '32149869', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('352', '1', '32154629', '32151435', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('353', '1', '32154629', '32151615', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('354', '1', '32154629', '32159730', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('355', '1', '32154629', '32161044', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('356', '1', '32154629', '32161083', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('357', '1', '32154629', '32161099', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('358', '1', '32154629', '32161233', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('359', '1', '32154629', '32161243', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('360', '1', '32154629', '32161372', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('361', '1', '32154629', '32161402', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('362', '1', '32154629', '32162275', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('363', '1', '32154629', '32162282', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('364', '1', '32154629', '32162285', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('365', '1', '32154629', '32162288', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('366', '1', '32154629', '32162289', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('367', '1', '32154629', '32162406', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('368', '1', '32154629', '32162408', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('369', '1', '32155724', '32160755', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('370', '1', '32156835', '32124254', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('371', '1', '32156835', '32124263', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('372', '1', '32156835', '32124314', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('373', '1', '32156835', '32124335', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('374', '1', '32156835', '32150583', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('375', '1', '32156835', '32152527', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('376', '1', '32156835', '32153244', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('377', '1', '32156835', '32157393', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('378', '1', '32156835', '32160207', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('379', '1', '32156835', '32160218', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('380', '1', '32156835', '32160511', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('381', '1', '32160092', '32124234', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('382', '1', '32160092', '32124304', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('383', '1', '32160092', '32149973', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('384', '1', '32161047', '32157411', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('385', '1', '32162062', '32152181', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('386', '1', '32162062', '32162403', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('387', '1', '32162093', '32124250', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('388', '1', '32162093', '32151600', '2016-05-27 21:47:06', 'admin');
INSERT INTO `jerarquias` VALUES ('389', '1', '32162093', '32154582', '2016-05-27 21:47:06', 'admin');

-- ----------------------------
-- Table structure for niveles
-- ----------------------------
DROP TABLE IF EXISTS `niveles`;
CREATE TABLE `niveles` (
  `codigo` int(255) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `areakey` (`titulo`),
  KEY `areid` (`codigo`),
  KEY `areti` (`titulo`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of niveles
-- ----------------------------
INSERT INTO `niveles` VALUES ('1', 'Autoridades 1');
INSERT INTO `niveles` VALUES ('2', 'Autoridades 2');
INSERT INTO `niveles` VALUES ('3', 'Direcciones 1');
INSERT INTO `niveles` VALUES ('4', 'Direcciones 2');
INSERT INTO `niveles` VALUES ('5', 'Mandos medios y profesorado 1');
INSERT INTO `niveles` VALUES ('6', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1');
INSERT INTO `niveles` VALUES ('7', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1');
INSERT INTO `niveles` VALUES ('8', 'Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y profesorado 1 Mandos medios y');
INSERT INTO `niveles` VALUES ('9', 'Mandos medios y profesorado 2');
INSERT INTO `niveles` VALUES ('10', 'Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y profesorado 2 Mandos medios y');
INSERT INTO `niveles` VALUES ('11', 'Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profesorado 2Mandos medios y profeso');
INSERT INTO `niveles` VALUES ('12', 'Operativos 1');
INSERT INTO `niveles` VALUES ('13', 'Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1');
INSERT INTO `niveles` VALUES ('14', 'Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1');
INSERT INTO `niveles` VALUES ('15', 'Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1Operativos 1');
INSERT INTO `niveles` VALUES ('16', 'Operativos 2');
INSERT INTO `niveles` VALUES ('17', 'Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2');
INSERT INTO `niveles` VALUES ('18', 'Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2');
INSERT INTO `niveles` VALUES ('19', 'Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2');
INSERT INTO `niveles` VALUES ('20', 'Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Operativos 2Ope');

-- ----------------------------
-- Table structure for preguntas_puestos
-- ----------------------------
DROP TABLE IF EXISTS `preguntas_puestos`;
CREATE TABLE `preguntas_puestos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `competencia` varchar(255) DEFAULT NULL,
  `pregunta` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=957 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of preguntas_puestos
-- ----------------------------
INSERT INTO `preguntas_puestos` VALUES ('340', 'DIRECTOR DE PROGRAMA ACADÉMICO( NIVEL MANDOS MEDIOS 1)', 'Promueve constantemente la misión institucional y los valores universitarios en su trabajo de supervisión de las labores académicas y administrativas del personal a su cargo.');
INSERT INTO `preguntas_puestos` VALUES ('341', 'DIRECTOR DE PROGRAMA ACADÉMICO( NIVEL MANDOS MEDIOS 1)', 'Mantiene una supervisión constante de la calidad de las cátedras impartidas y revisa al término de cada período escolar los resultados arrojados por los procesos de evaluación docente para alinear aspectos que sean necesarios.');
INSERT INTO `preguntas_puestos` VALUES ('342', 'DIRECTOR DE PROGRAMA ACADÉMICO( NIVEL MANDOS MEDIOS 1)', 'Atiende y resuelve con prontitud y actitud de servicio las necesidades y solicitudes de los estudiantes y docentes.');
INSERT INTO `preguntas_puestos` VALUES ('343', 'DIRECTOR DE PROGRAMA ACADÉMICO( NIVEL MANDOS MEDIOS 1)', 'Demuestra una preocupación genuina y permanente por la optimización del uso de los recursos humanos y materiales asignados a su programa académico.');
INSERT INTO `preguntas_puestos` VALUES ('344', 'DIRECTOR DE PROGRAMA ACADÉMICO( NIVEL MANDOS MEDIOS 1)', 'Valida constantemente mediante el sector empresarial y social el perfil del egresado formado en la Licenciatura y establece programas que mejoren la percepción y respondan a las necesidades de la sociedad.');
INSERT INTO `preguntas_puestos` VALUES ('345', 'DIRECTOR DE PROGRAMA ACADÉMICO( NIVEL MANDOS MEDIOS 1)', 'Da un seguimiento cercano a cada uno de sus profesores y personal buscando generar un buen ambiente, la colaboración en equipo, la integración con la universidad y dando respuesta a sus intereses e inquietudes. ');
INSERT INTO `preguntas_puestos` VALUES ('346', 'DIRECTOR DE PROGRAMA ACADÉMICO( NIVEL MANDOS MEDIOS 1)', 'Colabora permanentemente con las labores de promoción de su escuela hacia los diversos públicos: egresados, empresas,instituciones privadas y gubernamentales entre otros.');
INSERT INTO `preguntas_puestos` VALUES ('347', 'DIRECTOR DE PROGRAMA ACADÉMICO( NIVEL MANDOS MEDIOS 1)', 'Da un seguimiento puntual al Plan Operativo Anual y asegura su cumplimiento en el tiempo establecido y con la calidad requerida. ');
INSERT INTO `preguntas_puestos` VALUES ('348', 'DIRECTOR DE PROGRAMA ACADÉMICO( NIVEL MANDOS MEDIOS 1)', 'Se preocupa por tener y retener a docentes de excelencia para licencitatura y posgrados con experiencia profesional y calidad académica.');
INSERT INTO `preguntas_puestos` VALUES ('349', 'DIRECTOR DE PROGRAMA ACADÉMICO( NIVEL MANDOS MEDIOS 1)', 'Busca proponer, desarrollar, implementar y actualizar los programas de posgrados y educación continua.');
INSERT INTO `preguntas_puestos` VALUES ('350', 'VICERRECTOR ACADÉMICO (NIVEL AUTORIDADES 2) ', 'Promueve activamente el desarrollo de nuestra misión e \"identidad católica\" dentro de la Institución y entre el personal que depende de él.');
INSERT INTO `preguntas_puestos` VALUES ('351', 'VICERRECTOR ACADÉMICO (NIVEL AUTORIDADES 2) ', 'Establece y supervisa la realización de las prioridades de operación y quehacer académico de las áreas a su cargo.');
INSERT INTO `preguntas_puestos` VALUES ('352', 'VICERRECTOR ACADÉMICO (NIVEL AUTORIDADES 2) ', 'Procura la máxima calidad académica y busca implementar los sistemas necesarios para conseguirla, de modo que dé respuesta a las inquietudes de estudiantes y profesores. ');
INSERT INTO `preguntas_puestos` VALUES ('353', 'VICERRECTOR ACADÉMICO (NIVEL AUTORIDADES 2) ', 'Analizar y propone los programas académicos que debe de ofrecer la Universidad manteniédolos actualizados.');
INSERT INTO `preguntas_puestos` VALUES ('354', 'VICERRECTOR ACADÉMICO (NIVEL AUTORIDADES 2) ', 'Procura la máxima calidad académica certificada de la universidad a partir de los procesos de acreditación que la institución ha decidido emprender y renovar tanto en licenciatura como en Posgrados');
INSERT INTO `preguntas_puestos` VALUES ('355', 'VICERRECTOR ACADÉMICO (NIVEL AUTORIDADES 2) ', 'Ha establecido nuevas relaciones académicas y mantiene una relación cercana con otras instituciones nacionales e internacionales de prestigio.');
INSERT INTO `preguntas_puestos` VALUES ('356', 'VICERRECTOR ACADÉMICO (NIVEL AUTORIDADES 2) ', 'Desarrolla y da seguimiento al Plan Estratégico y de Presupuesto del área a corto, mediano y largo plazo de acuerdo al Plan Estratégico de la Universidad asegurando su cumplimiento.');
INSERT INTO `preguntas_puestos` VALUES ('357', 'VICERRECTOR ACADÉMICO (NIVEL AUTORIDADES 2) ', 'Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('358', 'VICERRECTOR ACADÉMICO (NIVEL AUTORIDADES 2) ', 'Procura y fomenta una colaboración estrecha con las vicerrectorias de la Universidad');
INSERT INTO `preguntas_puestos` VALUES ('359', 'VICERRECTOR ACADÉMICO (NIVEL AUTORIDADES 2) ', 'Fomenta y busca la innovación en todas sus áreas, en especial en el proceso de enseñanza aprendizaje y en los métodos. Buscando una estrecha relación con el departamento de innovación de la Universidad. ');
INSERT INTO `preguntas_puestos` VALUES ('360', 'VICERRECTOR DE ADMINISTRACIÓN Y FINANZAS (NIVEL AUTORIDADES 2)', 'Promueve activamente el desarrollo de nuestra misión e \"identidad católica\" dentro de la Institución y entre el personal que depende de él.');
INSERT INTO `preguntas_puestos` VALUES ('361', 'VICERRECTOR DE ADMINISTRACIÓN Y FINANZAS (NIVEL AUTORIDADES 2)', 'Desarrolla y da seguimiento al Plan Estratégico y de Presupuesto del área a corto, mediano y largo plazo de acuerdo al Plan Estratégico de la Universidad asegurando su cumplimiento.');
INSERT INTO `preguntas_puestos` VALUES ('362', 'VICERRECTOR DE ADMINISTRACIÓN Y FINANZAS (NIVEL AUTORIDADES 2)', 'Da seguimiento y busca el cumplimiento ágil de los proyectos de la Universidad en el ámbito de su competencia.');
INSERT INTO `preguntas_puestos` VALUES ('363', 'VICERRECTOR DE ADMINISTRACIÓN Y FINANZAS (NIVEL AUTORIDADES 2)', 'Supervisa el correcto registro y en los tiempos establecidos las operaciones económicas de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('364', 'VICERRECTOR DE ADMINISTRACIÓN Y FINANZAS (NIVEL AUTORIDADES 2)', 'Propone al Comité Rectoral los procedimientos administrativos, modificaciones requeridas al presupuesto y cuotas escolares en beneficio de la Institución para presentar a la RUA con las gestiones correspondientes ante la junta de gobierno.');
INSERT INTO `preguntas_puestos` VALUES ('365', 'VICERRECTOR DE ADMINISTRACIÓN Y FINANZAS (NIVEL AUTORIDADES 2)', 'Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('366', 'VICERRECTOR DE ADMINISTRACIÓN Y FINANZAS (NIVEL AUTORIDADES 2)', 'Integra en tiempo y forma junto con el Comité Rectoral y Rector el presupuesto anual de la Universidad, se encarga de darle seguimiento y vela por el cumplimiento del mismo');
INSERT INTO `preguntas_puestos` VALUES ('367', 'VICERRECTOR DE ADMINISTRACIÓN Y FINANZAS (NIVEL AUTORIDADES 2)', 'Comprende y comunica los objetivos a cumplir y motiva a los miembros del equipo al cumplimiento de los mismos.');
INSERT INTO `preguntas_puestos` VALUES ('368', 'VICERRECTOR DE ADMINISTRACIÓN Y FINANZAS (NIVEL AUTORIDADES 2)', 'Se asegura de proporcionar servicios de alta calidad a los estudiantes y clientes internos tanto en la atención, trato y vanguardia de los servicios que tienen relación a su área de competencia.');
INSERT INTO `preguntas_puestos` VALUES ('369', 'VICERRECTOR DE ADMINISTRACIÓN Y FINANZAS (NIVEL AUTORIDADES 2)', 'Diseña y ejecuta las medidas financieras que aseguren la óptima utilización de los recursos financieros y administrativos de la Institución.Diseña y ejecuta las medidas financieras que aseguren la óptima utilización de los recursos financieros y administrativos de la Institución.');
INSERT INTO `preguntas_puestos` VALUES ('370', 'VICERRECTOR DE FORMACIÓN INTEGRAL (NIVEL AUTORIDADES 2)', 'Promueve activamente el desarrollo de nuestra misión e \"identidad católica\" dentro de la Institución y entre el personal que depende de él.');
INSERT INTO `preguntas_puestos` VALUES ('371', 'VICERRECTOR DE FORMACIÓN INTEGRAL (NIVEL AUTORIDADES 2)', 'Propicia y coordina de manera permanente las actividades de las áreas de Difusión Cultural y Deportes.');
INSERT INTO `preguntas_puestos` VALUES ('372', 'VICERRECTOR DE FORMACIÓN INTEGRAL (NIVEL AUTORIDADES 2)', 'Propicia y coordina de manera permanente las actividades de los Programas de Acción y Servicio Social que apoyan la formación integral de los estudiantes.');
INSERT INTO `preguntas_puestos` VALUES ('373', 'VICERRECTOR DE FORMACIÓN INTEGRAL (NIVEL AUTORIDADES 2)', 'Vela por la adecuada implantación, operación y evaluación del modelo educativo Anáhuac de formación integral.');
INSERT INTO `preguntas_puestos` VALUES ('374', 'VICERRECTOR DE FORMACIÓN INTEGRAL (NIVEL AUTORIDADES 2)', 'Propone y desarrolla constantemente programas relacionados con la promoción del liderazgo de acción positiva ante la comunidad universitaria.');
INSERT INTO `preguntas_puestos` VALUES ('375', 'VICERRECTOR DE FORMACIÓN INTEGRAL (NIVEL AUTORIDADES 2)', 'Fomenta actividades de acción social incrementando consistentemente la participación activa de alumnos, profesores y personal universitario.');
INSERT INTO `preguntas_puestos` VALUES ('376', 'VICERRECTOR DE FORMACIÓN INTEGRAL (NIVEL AUTORIDADES 2)', 'Desarrolla y da seguimiento al Plan Estratégico y de Presupuesto del área a corto, mediano y largo plazo de acuerdo al Plan Estratégico de la Universidad asegurando su cumplimiento.');
INSERT INTO `preguntas_puestos` VALUES ('377', 'VICERRECTOR DE FORMACIÓN INTEGRAL (NIVEL AUTORIDADES 2)', 'Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('378', 'VICERRECTOR DE FORMACIÓN INTEGRAL (NIVEL AUTORIDADES 2)', 'Fomenta la identidad institucional, apostolados y acción social en los alumnos de posgrados.');
INSERT INTO `preguntas_puestos` VALUES ('379', 'VICERRECTOR DE FORMACIÓN INTEGRAL (NIVEL AUTORIDADES 2)', 'Cuenta con un plan pastoral y se asegura de su avance y cumplimiento.');
INSERT INTO `preguntas_puestos` VALUES ('380', 'DIRECTOR DE DIVISIÓN (NIVEL DIRECCCIONES 1)', 'Promueve activamente el desarrollo de nuestra \"identidad católica\" especialmente en las actividades relacionadas con la formación humana y académica de los alumnos.');
INSERT INTO `preguntas_puestos` VALUES ('381', 'DIRECTOR DE DIVISIÓN (NIVEL DIRECCCIONES 1)', 'Trabaja junto con la Vicerrectoría Académica, en el alcance y funciones de la división estableciendo planes y programas actualizados a corto,mediano y largo plazo.');
INSERT INTO `preguntas_puestos` VALUES ('382', 'DIRECTOR DE DIVISIÓN (NIVEL DIRECCCIONES 1)', 'Busca la máxima calidad dentro del aula (puntualidad y asistencia de profesores, cumplimiento del programa, participación de los alumnos, innovación en las cátedras, etc)');
INSERT INTO `preguntas_puestos` VALUES ('383', 'DIRECTOR DE DIVISIÓN (NIVEL DIRECCCIONES 1)', 'Busca la máxima calidad académica reconocida tanto en Licenciatura como en Posgrados.');
INSERT INTO `preguntas_puestos` VALUES ('384', 'DIRECTOR DE DIVISIÓN (NIVEL DIRECCCIONES 1)', 'Constantemente desarrolla, implementa y actualiza los programas de posgrados y educación continua.');
INSERT INTO `preguntas_puestos` VALUES ('385', 'DIRECTOR DE DIVISIÓN (NIVEL DIRECCCIONES 1)', 'Mantiene una supervisión constante de la calidad de las cátedras impartidas en la Divisón y revisa al término de cada período escolar los resultados arrojados por los procesos de evaluación docente para alinear aspectos que sean necesarios.');
INSERT INTO `preguntas_puestos` VALUES ('386', 'DIRECTOR DE DIVISIÓN (NIVEL DIRECCCIONES 1)', 'Establece y mantiene relaciones de colaboración con: Instituciones académicas de prestigio,nacionales o extranjeras, con el medio profesional correspondiente y con los egresados de la facultad.');
INSERT INTO `preguntas_puestos` VALUES ('387', 'DIRECTOR DE DIVISIÓN (NIVEL DIRECCCIONES 1)', 'Elabora el Plan y Presupuesto Anual de Operación de su División dando seguimiento a la realización del mismo en el tiempo y calidad requerida.');
INSERT INTO `preguntas_puestos` VALUES ('388', 'DIRECTOR DE DIVISIÓN (NIVEL DIRECCCIONES 1)', 'Da un seguimiento cercano a cada uno de sus profesores buscando generar un buen ambiente, la colaboración en equipo, la integración con la universidad y dando respuesta a sus intereses e inquietudes. ');
INSERT INTO `preguntas_puestos` VALUES ('389', 'DIRECTOR DE DIVISIÓN (NIVEL DIRECCCIONES 1)', 'Valida constantemente mediante el sector empresarial y social el perfil del egresado formado en la División y establece programas que mejoren la percepción y respondan a las necesidades de la sociedad.');
INSERT INTO `preguntas_puestos` VALUES ('390', 'DIRECTOR DE SERVICIOS INSTITUCIONALES Y PLANEACIÓN (NIVEL DIRECCIONES 1)', 'Elabora y presenta al comité rectoral para su aprobación, el plan estratégico y los programas anuales acordados con las autoridades y directivos de las diferentes áreas de la universidad. ');
INSERT INTO `preguntas_puestos` VALUES ('391', 'DIRECTOR DE SERVICIOS INSTITUCIONALES Y PLANEACIÓN (NIVEL DIRECCIONES 1)', 'Asesora al comité rectoral para desarrollar, actualizar y dar seguimiento a la aplicación del plan estratégico y su programa anual. ');
INSERT INTO `preguntas_puestos` VALUES ('392', 'DIRECTOR DE SERVICIOS INSTITUCIONALES Y PLANEACIÓN (NIVEL DIRECCIONES 1)', 'Da un seguimiento cercano a los programas anuales y brinda una retroalimentación clara y estratégica a los responsables. ');
INSERT INTO `preguntas_puestos` VALUES ('393', 'DIRECTOR DE SERVICIOS INSTITUCIONALES Y PLANEACIÓN (NIVEL DIRECCIONES 1)', 'Brinda constantemente información estadística fidedígna que sirva para las determinaciones de desarrollo y crecimiento universitario');
INSERT INTO `preguntas_puestos` VALUES ('394', 'DIRECTOR DE SERVICIOS INSTITUCIONALES Y PLANEACIÓN (NIVEL DIRECCIONES 1)', 'Orienta y coordina de forma permanente a el área de Administración Escolar logrando un servicio óptimo para los usuarios de la institución.');
INSERT INTO `preguntas_puestos` VALUES ('395', 'DIRECTOR DE SERVICIOS INSTITUCIONALES Y PLANEACIÓN (NIVEL DIRECCIONES 1)', 'Orienta y coordina de forma permanente al área de Servicios Tecnológicos logrando un servicio óptimo para los usuarios de la institución.');
INSERT INTO `preguntas_puestos` VALUES ('396', 'DIRECTOR DE SERVICIOS INSTITUCIONALES Y PLANEACIÓN (NIVEL DIRECCIONES 1)', 'Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('397', 'DIRECTOR DE SERVICIOS INSTITUCIONALES Y PLANEACIÓN (NIVEL DIRECCIONES 1)', 'Analiza y propone las acciones y procesos que se basan en la medición, diagnóstico, evaluación, diseño y propuestas de intervención para el mejoramiento continuo de procesos y servicios. Ha propuesto mejoras que se han implementado con éxito en el último año.');
INSERT INTO `preguntas_puestos` VALUES ('398', 'DIRECTOR DE SERVICIOS INSTITUCIONALES Y PLANEACIÓN (NIVEL DIRECCIONES 1)', 'Apoya y propone al comité rectoral el diseño, implantación y mecanismos de evaluación institucional. ');
INSERT INTO `preguntas_puestos` VALUES ('399', 'DIRECTOR DE SERVICIOS INSTITUCIONALES Y PLANEACIÓN (NIVEL DIRECCIONES 1)', 'Coordina de manera eficaz los procesos de certificación y acreditación nacionales e internacionales logrando mantener la excelencia académica de la institución. Da un seguimiento a las recomendaciones u observaciones de los sistemas de acreditación.');
INSERT INTO `preguntas_puestos` VALUES ('400', 'DIRECTOR DE DESARROLLO INSTITUCIONAL ( NIVEL DIRECCIONES 2)', 'Promueve activamente el desarrollo de nuestra \"identidad católica\" dentro de la Institución y en especial dentro del personal de su área,egresados y bienhechores.');
INSERT INTO `preguntas_puestos` VALUES ('401', 'DIRECTOR DE DESARROLLO INSTITUCIONAL ( NIVEL DIRECCIONES 2)', 'Desarrolla e implementa Estrategias de Financiamiento para el crecimiento de la institución basándose en apoyos filantrópicos individuales,grupales y empresariales.');
INSERT INTO `preguntas_puestos` VALUES ('402', 'DIRECTOR DE DESARROLLO INSTITUCIONAL ( NIVEL DIRECCIONES 2)', 'Recauda Recursos Económicos y en Especie (independietes de la operación ordinaria de la Universidad) para el desarrollo de la Institución.');
INSERT INTO `preguntas_puestos` VALUES ('403', 'DIRECTOR DE DESARROLLO INSTITUCIONAL ( NIVEL DIRECCIONES 2)', 'Supervisa la correcta aplicación de los recursos económicos y en especie recaudados de acuerdo a la asignación inicial. ');
INSERT INTO `preguntas_puestos` VALUES ('404', 'DIRECTOR DE DESARROLLO INSTITUCIONAL ( NIVEL DIRECCIONES 2)', 'De manera continua realiza planes y proyectos que fomentan el apoyo y colaboración de los egresados en las actividades institucionales.');
INSERT INTO `preguntas_puestos` VALUES ('405', 'DIRECTOR DE DESARROLLO INSTITUCIONAL ( NIVEL DIRECCIONES 2)', 'Evalúa constantemente la percepción de los públicos a quienes son dirigidos sus eventos y actividades (egresados, alumnos, empresas,etc), y realiza propuestas para su mejoramiento.');
INSERT INTO `preguntas_puestos` VALUES ('406', 'DIRECTOR DE DESARROLLO INSTITUCIONAL ( NIVEL DIRECCIONES 2)', 'Establece relaciones permanentes con distintas dependencias de gobierno,del sector privado y social que favorecen el desarrollo e imagen de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('407', 'DIRECTOR DE DESARROLLO INSTITUCIONAL ( NIVEL DIRECCIONES 2)', 'Desarrolla y da seguimiento al Plan Estratégico y de Presupuesto del área a corto, mediano y largo plazo de acuerdo al Plan Estratégico de la Universidad asegurando su cumplimiento.');
INSERT INTO `preguntas_puestos` VALUES ('408', 'DIRECTOR DE DESARROLLO INSTITUCIONAL ( NIVEL DIRECCIONES 2)', 'Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('409', 'DIRECTOR DE DESARROLLO INSTITUCIONAL ( NIVEL DIRECCIONES 2)', 'Comprende y comunica los objetivos a cumplir y motiva a los miembros del equipo al cumplimiento de los mismos.');
INSERT INTO `preguntas_puestos` VALUES ('410', 'DIRECTOR DE DESARROLLO ACADÉMICO (NIVEL DIRECCCIONES 2) ', 'Promueve activamente el desarrollo de nuestra \"identidad católica\" especialmente en la formación docente y tutorías.');
INSERT INTO `preguntas_puestos` VALUES ('411', 'DIRECTOR DE DESARROLLO ACADÉMICO (NIVEL DIRECCCIONES 2) ', 'De manera consistente y junto con sus coordinadores diseña,supervisa y evalúa la ejecución de procesos de excelencia académica e investigación y propone acciones para el mejoramiento continuo de los mismos.');
INSERT INTO `preguntas_puestos` VALUES ('412', 'DIRECTOR DE DESARROLLO ACADÉMICO (NIVEL DIRECCCIONES 2) ', 'Se asegura de tener un modelo eficaz de atención personal a los estudiantes, particularmente a través de los programas de tutoría, y busca su mejora contínua.');
INSERT INTO `preguntas_puestos` VALUES ('413', 'DIRECTOR DE DESARROLLO ACADÉMICO (NIVEL DIRECCCIONES 2) ', 'Da seguimiento al cumplimiento efectivo de diversos indicadores de desempeño académico y realiza estudios que permitan conocer los requerimientos de acreditación institucional y de programas académicos ante diferentes instancias(ANUES, FIMPES, ETC).');
INSERT INTO `preguntas_puestos` VALUES ('414', 'DIRECTOR DE DESARROLLO ACADÉMICO (NIVEL DIRECCCIONES 2) ', 'Conduce el análisis e interpretación de la Práctica de Evaluación Docentes a nivel Institucional, propone acciones para el mejoramiento y se asegura del cumplimiento de las mismas.');
INSERT INTO `preguntas_puestos` VALUES ('415', 'DIRECTOR DE DESARROLLO ACADÉMICO (NIVEL DIRECCCIONES 2) ', 'Procura la máxima calidad académica certificada de la universidad según los planes de la misma, en especial busca mejorar en las evaluaciones del EGEL.');
INSERT INTO `preguntas_puestos` VALUES ('416', 'DIRECTOR DE DESARROLLO ACADÉMICO (NIVEL DIRECCCIONES 2) ', 'Apoya los procesos, proyectos e iniativas relacionadas con la Capacitación del Personal Docente.');
INSERT INTO `preguntas_puestos` VALUES ('417', 'DIRECTOR DE DESARROLLO ACADÉMICO (NIVEL DIRECCCIONES 2) ', 'Busca la máxima calidad dentro del aula (puntualidad y asistencia de profesores, cumplimiento del programa, participación de los alumnos, innovación en las cátedras, etc).');
INSERT INTO `preguntas_puestos` VALUES ('418', 'DIRECTOR DE DESARROLLO ACADÉMICO (NIVEL DIRECCCIONES 2) ', 'Funge permanentemente como auditor en las diferentes escuelas con la finalidad de el logro de las certificaciones de programas académicos.');
INSERT INTO `preguntas_puestos` VALUES ('419', 'DIRECTOR DE DESARROLLO ACADÉMICO (NIVEL DIRECCCIONES 2) ', 'Conduce eficientemente los procesos relacionados con la selección y el desarrollo de profesores de planta y de honorarios.');
INSERT INTO `preguntas_puestos` VALUES ('420', 'ESPECIALISTA EN DESARROLLO DE MEDIOS (NIVEL MANDOS MEDIOS 2)', 'Integra eficientemente de páginas Web de los cursos del Proyecto @prende, de acuerdo a las indicaciones del especialista en Diseño Instruccional, requerimientos de los profesores, tipo de contenido y área de conocimiento.');
INSERT INTO `preguntas_puestos` VALUES ('421', 'ESPECIALISTA EN DESARROLLO DE MEDIOS (NIVEL MANDOS MEDIOS 2)', 'Diseña de objetos de aprendizaje \"a la medida\", materiales de apoyo y recursos multimedia innovadores.');
INSERT INTO `preguntas_puestos` VALUES ('422', 'ESPECIALISTA EN DESARROLLO DE MEDIOS (NIVEL MANDOS MEDIOS 2)', 'Desarrolla y aplica con éxito estándares SCORM a los recursos multimedia, objetos e integración de contenidos en WebCT.');
INSERT INTO `preguntas_puestos` VALUES ('423', 'ESPECIALISTA EN DESARROLLO DE MEDIOS (NIVEL MANDOS MEDIOS 2)', 'Digitaliza en forma y tiempo documentos, imágenes, audios, videos,etc, para la integración de los cursoso del Programa @prende.');
INSERT INTO `preguntas_puestos` VALUES ('424', 'ESPECIALISTA EN DESARROLLO DE MEDIOS (NIVEL MANDOS MEDIOS 2)', 'Asesora satisfactoriamente a profesores y alumnos, en cuanto al uso de herramientas, software especializado o aplicaciones que se requieren para la impartición de las materias en WebCT y Blackboard.');
INSERT INTO `preguntas_puestos` VALUES ('425', 'ESPECIALISTA EN DESARROLLO DE MEDIOS (NIVEL MANDOS MEDIOS 2)', 'Supervisa el funcionamiento de todos los recuros que contien cada materia integrada en WebCat, de acuerdo a las indicaciones del Especialista en Diseño Instruccional o del prrofesor.');
INSERT INTO `preguntas_puestos` VALUES ('426', 'ESPECIALISTA EN DESARROLLO DE MEDIOS (NIVEL MANDOS MEDIOS 2)', 'Estructura y actualiza adecuadamente los archivos y directorios de cursos abiertos en WebCT y Blackboard.');
INSERT INTO `preguntas_puestos` VALUES ('427', 'ESPECIALISTA EN DESARROLLO DE MEDIOS (NIVEL MANDOS MEDIOS 2)', 'Actualiza y usa la galería de objetos de aprendizaje y recursos multimedia desarrollada para el Programa @prende.');
INSERT INTO `preguntas_puestos` VALUES ('428', 'ESPECIALISTA EN DESARROLLO DE MEDIOS (NIVEL MANDOS MEDIOS 2)', 'Respalda de forma permanente los documentos originales de los maestros, así como los materiales desarrollados por los enlaces del Programa @prende en cada Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('429', 'ESPECIALISTA EN DESARROLLO DE MEDIOS (NIVEL MANDOS MEDIOS 2)', 'Cumple eficientemente con los objetivos del Programa @prende en la Red de Universidades Anáhuac.');
INSERT INTO `preguntas_puestos` VALUES ('430', 'ESPECIALISTA DE ORIENTACIÓN VOCACIONAL (NIVEL MANDOS MEDIOS 2)', 'Orienta apropiadamente a los candidatos a postulantes que solicitan ingreso a la Institución, para que elijan una profesión adecuada,tomando en cuenta sus habilidades, aptitudes, intereses y características de personalidad.');
INSERT INTO `preguntas_puestos` VALUES ('431', 'ESPECIALISTA DE ORIENTACIÓN VOCACIONAL (NIVEL MANDOS MEDIOS 2)', 'Aplica pruebas psicológicas a los candidatos a ingresar a la institución y elabora adecuadamente los perfiles vocacionales de cada uno de ellos.');
INSERT INTO `preguntas_puestos` VALUES ('432', 'ESPECIALISTA DE ORIENTACIÓN VOCACIONAL (NIVEL MANDOS MEDIOS 2)', 'Entrevista a cada uno de los candidatos y elabora en tiempo y forma los reportes psicológicos que se envían al área de admisiones.');
INSERT INTO `preguntas_puestos` VALUES ('433', 'ESPECIALISTA DE ORIENTACIÓN VOCACIONAL (NIVEL MANDOS MEDIOS 2)', 'Mantiene contacto con los directores de las escuelas y conoce el grado de adaptación de los alumnos de nuevo ingreso a la escuela y a la Institución.');
INSERT INTO `preguntas_puestos` VALUES ('434', 'ESPECIALISTA DE ORIENTACIÓN VOCACIONAL (NIVEL MANDOS MEDIOS 2)', 'Mantiene contacto con los alumnos en casos de bajo rendimiento, problemas de motivación u otros y los canaliza debidamente a instituciones externas que les puedan brindar ayuda.');
INSERT INTO `preguntas_puestos` VALUES ('435', 'ESPECIALISTA DE ORIENTACIÓN VOCACIONAL (NIVEL MANDOS MEDIOS 2)', 'Reorienta satisfactoriamente a los alumnos que solicitan cambio de carrera.');
INSERT INTO `preguntas_puestos` VALUES ('436', 'ESPECIALISTA DE ORIENTACIÓN VOCACIONAL (NIVEL MANDOS MEDIOS 2)', 'Realiza entrevistas y mantiene un adecuado contacto con padres de familia.');
INSERT INTO `preguntas_puestos` VALUES ('437', 'ESPECIALISTA DE ORIENTACIÓN VOCACIONAL (NIVEL MANDOS MEDIOS 2)', 'Determina con precisión la conveniencia o no de ingreso de cada aspirante a través de un reporte.');
INSERT INTO `preguntas_puestos` VALUES ('438', 'ESPECIALISTA DE ORIENTACIÓN VOCACIONAL (NIVEL MANDOS MEDIOS 2)', 'Controla, revisa y entrega en tiempo y forma los exámenes y reportes psicológicos a las áreas correspondientes.');
INSERT INTO `preguntas_puestos` VALUES ('439', 'COORDINADOR DE PROGRAMA DE EGRESADOS (NIVEL MANDOS MEDIOS 2)', 'Propone a la Dirección planes y políticas para estrechar las relaciones de la Universidad con sus egresados fomentando su apoyo y colaboración en actividades institucionales.');
INSERT INTO `preguntas_puestos` VALUES ('440', 'COORDINADOR DE PROGRAMA DE EGRESADOS (NIVEL MANDOS MEDIOS 2)', 'Establece vínculos permanentes con empresas de sectores públicos y privados,que permiten que nuestros egresados puedan integrarse al ambiente laboral en forma rápida y con oportunidades de acuerdo a su perfil y aspiraciones profesionales.');
INSERT INTO `preguntas_puestos` VALUES ('441', 'COORDINADOR DE PROGRAMA DE EGRESADOS (NIVEL MANDOS MEDIOS 2)', 'Propicia con éxito encuentros, ferias y seminarios que ponen en contacto a nustros alumnos de últimos semestres con las oportunidades laborales a fines a sus perfiles académicos.');
INSERT INTO `preguntas_puestos` VALUES ('442', 'COORDINADOR DE PROGRAMA DE EGRESADOS (NIVEL MANDOS MEDIOS 2)', 'Administra, supervisa y evalúa con eficiencia las herraminetas (administrativas y electrónicas) que se presentan a los egresados como alternativas de búsqueda de oportunidades laborales (bolsa de trabajo).');
INSERT INTO `preguntas_puestos` VALUES ('443', 'COORDINADOR DE PROGRAMA DE EGRESADOS (NIVEL MANDOS MEDIOS 2)', 'Fomenta satisfactoriamente eventos: comidas, foros,encuentros, seminarios, etc., de integración y reencuentro de grupos de egresados. ');
INSERT INTO `preguntas_puestos` VALUES ('444', 'COORDINADOR DE PROGRAMA DE EGRESADOS (NIVEL MANDOS MEDIOS 2)', 'Mantiene constante relación con egresados que colaboran en empresas líderes logrando que participen con la Universidad en proyectos sociales,foros y conferencias siendo modelos a seguir en la vida profesional para nuestros alumnos.');
INSERT INTO `preguntas_puestos` VALUES ('445', 'COORDINADOR DE PROGRAMA DE EGRESADOS (NIVEL MANDOS MEDIOS 2)', 'Cuenta con un programa o proceso de retroalimentación efectivo (sugerencias/encuestas) por parte de los egresados, que permiten realinear los proyectos, planes y programas en base a las necesidades y expectativas reales de los mismos.');
INSERT INTO `preguntas_puestos` VALUES ('446', 'COORDINADOR DE PROGRAMA DE EGRESADOS (NIVEL MANDOS MEDIOS 2)', 'Establece negociaciones permanantes con proveedores y prestadores de servicios logrando acuerdos que apoyan la economía de nuestros egresados (descuentos, promociones,etc).');
INSERT INTO `preguntas_puestos` VALUES ('447', 'COORDINADOR DE PROGRAMA DE EGRESADOS (NIVEL MANDOS MEDIOS 2)', 'Administra y vigila constantemente que se encuentren actualizadas la base de datos con la información personal de los egresados.');
INSERT INTO `preguntas_puestos` VALUES ('448', 'COORDINADOR DE PROGRAMA DE EGRESADOS (NIVEL MANDOS MEDIOS 2)', 'Supervisa con eficiencia que todos los medios de contacto con los egresados (cartas, correo electrónico, publicaciones, revistas,etc) cumplan con los contenidos alineados a los valores y misión de la institución.');
INSERT INTO `preguntas_puestos` VALUES ('449', 'ASESOR DE DESARROLLO HUMANO (NIVEL MANDOS MEDIOS 2)', 'Brinda atención personalizada a alumnos que le sean canalizados ya sea por áreas académicas vía tutores, por la coordinación de relaciones estudiantiles o por alguna otra instancia.');
INSERT INTO `preguntas_puestos` VALUES ('450', 'ASESOR DE DESARROLLO HUMANO (NIVEL MANDOS MEDIOS 2)', 'Evalúa las condiciones, características y actitudes de alumnos asignados a su atención valuando si requiere la atención de un especialista y/o le establece u programa de adaptación.');
INSERT INTO `preguntas_puestos` VALUES ('451', 'ASESOR DE DESARROLLO HUMANO (NIVEL MANDOS MEDIOS 2)', 'Alerta en tiempo y forma al Vicerrector de Formación Integral sobre alumnos que presentan problemas que ameriten citar a los padres o tutores.');
INSERT INTO `preguntas_puestos` VALUES ('452', 'ASESOR DE DESARROLLO HUMANO (NIVEL MANDOS MEDIOS 2)', 'Apoya apropiadamente a los profesores de tutorías en cuanto a la forma que deben manejar o canalizar casos que ameriten atención personalizada.');
INSERT INTO `preguntas_puestos` VALUES ('453', 'ASESOR DE DESARROLLO HUMANO (NIVEL MANDOS MEDIOS 2)', 'En coordinación con relaciones estudiantiles organiza con eficiencia cursos, y conferencias de formación hacia los alumnos manejando temas como: alcoholismo, drogadicción, depresión, anorexia, bulimia, etc.');
INSERT INTO `preguntas_puestos` VALUES ('454', 'ASESOR DE DESARROLLO HUMANO (NIVEL MANDOS MEDIOS 2)', 'Trabaja en conjunto con el Director de Pastoral Universitaria apoyándole en el diagnóstico.');
INSERT INTO `preguntas_puestos` VALUES ('455', 'ASESOR DE DESARROLLO HUMANO (NIVEL MANDOS MEDIOS 2)', 'Atiende con actitud de servicio a todo alumno o persona de la Institución que se acerque a solicitar sus servicios.');
INSERT INTO `preguntas_puestos` VALUES ('456', 'ASESOR DE DESARROLLO HUMANO (NIVEL MANDOS MEDIOS 2)', 'Conoce y está familiarizado con los centros y grupos de apoyo con los que cuenta la Ciudad en la que se ubica la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('457', 'ASESOR DE DESARROLLO HUMANO (NIVEL MANDOS MEDIOS 2)', 'Participa activamente en actividades estudiantiles (Megamisión, actividades culturales,etc) que le permiten interactuar con los alumnos detectando problemas reales o potenciales ya sea a nivel individual o grupal.');
INSERT INTO `preguntas_puestos` VALUES ('458', 'ASESOR DE DESARROLLO HUMANO (NIVEL MANDOS MEDIOS 2)', 'Mantiene estricta confidencialidad de la información que le confíen tanto los alumnos, el personal y padres de familia.');
INSERT INTO `preguntas_puestos` VALUES ('459', 'COODINADOR DE SERVICIO Y ACCIÓN SOCIAL (NIVEL MANDOS MEDIOS 2)', 'Promueve y coordina eficientemente el programa de acción social universitario, asegurando su función formativa alineada a nuestra misión.');
INSERT INTO `preguntas_puestos` VALUES ('460', 'COODINADOR DE SERVICIO Y ACCIÓN SOCIAL (NIVEL MANDOS MEDIOS 2)', 'Propicia y alienta un ambiente propositivo que promueve el desarrollo de nuestra \"identidad católica\" entre alumnos, egresados y personal en general.');
INSERT INTO `preguntas_puestos` VALUES ('461', 'COODINADOR DE SERVICIO Y ACCIÓN SOCIAL (NIVEL MANDOS MEDIOS 2)', 'Vigila debidamente que las actividades se realicen de acuerdo a la normatividad vigente.');
INSERT INTO `preguntas_puestos` VALUES ('462', 'COODINADOR DE SERVICIO Y ACCIÓN SOCIAL (NIVEL MANDOS MEDIOS 2)', 'Recauda con éxito fondos y bienes para programas de ayuda para zonas de desastre.');
INSERT INTO `preguntas_puestos` VALUES ('463', 'COODINADOR DE SERVICIO Y ACCIÓN SOCIAL (NIVEL MANDOS MEDIOS 2)', 'Coordina eficientemente brigadas y proyectos especiales que surjan como resultado del apoyo de la comunidad u iversitaria ante grandes desastres (huracanes, inundaciones, incendios, etc.).');
INSERT INTO `preguntas_puestos` VALUES ('464', 'COODINADOR DE SERVICIO Y ACCIÓN SOCIAL (NIVEL MANDOS MEDIOS 2)', 'Mantiene un registro actualizado de las fundaciones o instituciones de asistencia social en las que los alumnos puedan realizar su actividad.');
INSERT INTO `preguntas_puestos` VALUES ('465', 'COODINADOR DE SERVICIO Y ACCIÓN SOCIAL (NIVEL MANDOS MEDIOS 2)', 'Promueve,coordina y administra satisfactoriamente el proceso de Servicio Social de los alumnos.');
INSERT INTO `preguntas_puestos` VALUES ('466', 'COODINADOR DE SERVICIO Y ACCIÓN SOCIAL (NIVEL MANDOS MEDIOS 2)', 'Da tutorías, apoyo y orientación adecuada a los alumnos que se encuentran realizando su servicio social.');
INSERT INTO `preguntas_puestos` VALUES ('467', 'COODINADOR DE SERVICIO Y ACCIÓN SOCIAL (NIVEL MANDOS MEDIOS 2)', 'Promueve con éxito a nuestros estudiantes ante las instituciones altruistas o de beneficiencia creando espacios que permiten que nuestros alumnos realicen su servicio social.');
INSERT INTO `preguntas_puestos` VALUES ('468', 'COODINADOR DE SERVICIO Y ACCIÓN SOCIAL (NIVEL MANDOS MEDIOS 2)', 'Define apropiadamente las políticas y lineamientos que deben cumplir las empresas, instituciones o fundaciones que buscan cubrir sus necesidades de recursoso humanos, con apoyo de los alumnos de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('469', 'ENTRENADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 2)', 'Entrena con exigencia y disciplina a los equipos que le sean asignados.');
INSERT INTO `preguntas_puestos` VALUES ('470', 'ENTRENADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 2)', 'Selecciona adecuadamente a los integrantes para los equipos según categorías y habilidades de los candidatos.');
INSERT INTO `preguntas_puestos` VALUES ('471', 'ENTRENADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 2)', 'Establece programas y rutinas de entrenamiento personal y grupal que mejoran el desempeño deportivo.');
INSERT INTO `preguntas_puestos` VALUES ('472', 'ENTRENADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 2)', 'Vigila consistentemente que se lleven a cabo las rutinas de calentamiento para la prevención de lesiones.');
INSERT INTO `preguntas_puestos` VALUES ('473', 'ENTRENADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 2)', 'Colabora con el Coordinador en el diseño y elaboración de programas de entrenamiento para los equipos representativos.');
INSERT INTO `preguntas_puestos` VALUES ('474', 'ENTRENADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 2)', 'Promueve con éxito partidos de competencia entre equipos de diferentes facultades, entre equipos de empleados de diferentes áreas y con equipos externos.');
INSERT INTO `preguntas_puestos` VALUES ('475', 'ENTRENADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 2)', 'Vigila que se de buen uso de las instalaciones.');
INSERT INTO `preguntas_puestos` VALUES ('476', 'ENTRENADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 2)', 'Vigila de manera permanenete que se cuente con apoyo médico y arbitraje adecuado en los partidos que se realicen.');
INSERT INTO `preguntas_puestos` VALUES ('477', 'ENTRENADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 2)', 'Coordina satisfactoriamente actividades con entidades gubernamentales y privadas que promuevan el deporte juvenil.');
INSERT INTO `preguntas_puestos` VALUES ('478', 'ENTRENADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 2)', 'Apoya con eficiencia en la coordinación de viajes cuando sea necesario.');
INSERT INTO `preguntas_puestos` VALUES ('479', 'ASISTENTE DE DIRECCIÓN (NIVEL MANDOS MEDIOS 2)', 'Apoya satisfactoriamente al desarrollo de el Plan Estratégico y Presupuesto Anual del área a corto, mediano y pargo plazo y supervisa su aplicación.');
INSERT INTO `preguntas_puestos` VALUES ('480', 'ASISTENTE DE DIRECCIÓN (NIVEL MANDOS MEDIOS 2)', 'Apoya con eficiencia al Vicerrector o Director en el seguimiento a los objetivos del área.');
INSERT INTO `preguntas_puestos` VALUES ('481', 'ASISTENTE DE DIRECCIÓN (NIVEL MANDOS MEDIOS 2)', 'Elabora en tiempo y forma informes sobre la operación del área e informa a su superior de las actividades realizadas.');
INSERT INTO `preguntas_puestos` VALUES ('482', 'ASISTENTE DE DIRECCIÓN (NIVEL MANDOS MEDIOS 2)', 'Recibe y direcciona adecuadamente la documentación interna dirigida al Vicerrector o Director.');
INSERT INTO `preguntas_puestos` VALUES ('483', 'ASISTENTE DE DIRECCIÓN (NIVEL MANDOS MEDIOS 2)', 'Atiende con actitud de servicio a personas internas que requieran apoyo de su jefe inmediato.');
INSERT INTO `preguntas_puestos` VALUES ('484', 'ASISTENTE DE DIRECCIÓN (NIVEL MANDOS MEDIOS 2)', 'Analiza con eficiencia diversos asuntos recibidos dando: solución directa, elabora una propuestas o delega los asuntos al área correspondiente.');
INSERT INTO `preguntas_puestos` VALUES ('485', 'ASISTENTE DE DIRECCIÓN (NIVEL MANDOS MEDIOS 2)', 'Da seguimiento a los asuntos, y en su caso participa activamente cuando se requiere.');
INSERT INTO `preguntas_puestos` VALUES ('486', 'ASISTENTE DE DIRECCIÓN (NIVEL MANDOS MEDIOS 2)', 'Atiende los asuntos que su jefe le delegue y lo representa dignamente en actividades especiales.');
INSERT INTO `preguntas_puestos` VALUES ('487', 'ASISTENTE DE DIRECCIÓN (NIVEL MANDOS MEDIOS 2)', 'Maneja apropiadamente las comunicaciones del Vicerrector o Director, tanto interna como externamente.');
INSERT INTO `preguntas_puestos` VALUES ('488', 'ASISTENTE DE DIRECCIÓN (NIVEL MANDOS MEDIOS 2)', 'Apoya al Vicerrector o Director en la implementación, seguimiento y control de las iniciativas de la Red Anáhuac.');
INSERT INTO `preguntas_puestos` VALUES ('489', 'ESPECIALISTA DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 2)', 'Atiende con actitud de servicio al personal de la Institución en todo lo referente a recursos humanos.');
INSERT INTO `preguntas_puestos` VALUES ('490', 'ESPECIALISTA DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 2)', 'En forma conjunta con el área de finanzas,apoya con eficacia en los procesos de liquidación y finiquito del personal.');
INSERT INTO `preguntas_puestos` VALUES ('491', 'ESPECIALISTA DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 2)', 'Apoya satisfactoriamente en el proceso de reclutamiento y selección al personal.');
INSERT INTO `preguntas_puestos` VALUES ('492', 'ESPECIALISTA DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 2)', 'Recibe, revisa y registra en tiempo y forma las incidencias de la nómina,impuestos, IMSS, entre otras.');
INSERT INTO `preguntas_puestos` VALUES ('493', 'ESPECIALISTA DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 2)', 'Da el seguimiento adecuado a la entrega de documentación del personal respecto a títulos y certificados de estudios o cursos de capacitación.');
INSERT INTO `preguntas_puestos` VALUES ('494', 'ESPECIALISTA DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 2)', 'Apoya eficientemente en eventos de integración (día de la madre, día del maestro, cumpleaños, posada, etc).');
INSERT INTO `preguntas_puestos` VALUES ('495', 'ESPECIALISTA DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 2)', 'Apoya en la elaboración de estadísticas y reportes útiles que dan seguimiento a los objetivos y proyectos del área.');
INSERT INTO `preguntas_puestos` VALUES ('496', 'ESPECIALISTA DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 2)', 'Apoya debidamente a la Gerencia en los procesos de evaluación del personal.');
INSERT INTO `preguntas_puestos` VALUES ('497', 'ESPECIALISTA DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 2)', 'Apoyo en los procesos de certificación y acreditación ante entidades públicas y privadas (FIMPES entre otras).');
INSERT INTO `preguntas_puestos` VALUES ('498', 'ESPECIALISTA DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 2)', 'Conocimiento y apoyo constante a los objetivos del área y la misión institucional.');
INSERT INTO `preguntas_puestos` VALUES ('499', 'COORDINADOR DE CAMPOS CLÍNICOS (NIVEL MANDOS MEDIOS 2)', 'Asesora debidamente a los maestros en la estructuración y/o actualización de los programas correspondientes a las distintas asignaturas del ciclo clínico.');
INSERT INTO `preguntas_puestos` VALUES ('500', 'COORDINADOR DE CAMPOS CLÍNICOS (NIVEL MANDOS MEDIOS 2)', 'Asegura que los maestros entreguen el programa desglosado de las asignaturas del ciclo anterior.');
INSERT INTO `preguntas_puestos` VALUES ('501', 'COORDINADOR DE CAMPOS CLÍNICOS (NIVEL MANDOS MEDIOS 2)', 'Apoya con eficiencia en la búsqueda de los campos clínicos idóneos.');
INSERT INTO `preguntas_puestos` VALUES ('502', 'COORDINADOR DE CAMPOS CLÍNICOS (NIVEL MANDOS MEDIOS 2)', 'Supervisa el programa de avance académico de cada materia de cada sede hospitalaria y en el adecuado desarrollo de los cursos complementarios.');
INSERT INTO `preguntas_puestos` VALUES ('503', 'COORDINADOR DE CAMPOS CLÍNICOS (NIVEL MANDOS MEDIOS 2)', 'Realiza reuniones debidamente programadas con los titutales de las asignaturas,después de cada periodo de exámenes parciales.');
INSERT INTO `preguntas_puestos` VALUES ('504', 'COORDINADOR DE CAMPOS CLÍNICOS (NIVEL MANDOS MEDIOS 2)', 'Fija el sistema de evaluación por módulo en conjunto con los maestros del ciclo, aplica y evalúa los exámenes de cada módulo.');
INSERT INTO `preguntas_puestos` VALUES ('505', 'COORDINADOR DE CAMPOS CLÍNICOS (NIVEL MANDOS MEDIOS 2)', 'Da a conocer la forma, tipo y manera de evaluar de cada profesor de forma anticipada permitiendo que tanto alumnos como maestros puedan agendar con anticipación sus fechas de exámenes.');
INSERT INTO `preguntas_puestos` VALUES ('506', 'COORDINADOR DE CAMPOS CLÍNICOS (NIVEL MANDOS MEDIOS 2)', 'Completa satisfactoriamente la evaluación del personal docente y comunica los resultados de dicha evaluación con el fin de mejorar la calidad de los mismos.');
INSERT INTO `preguntas_puestos` VALUES ('507', 'COORDINADOR DE CAMPOS CLÍNICOS (NIVEL MANDOS MEDIOS 2)', 'Motiva con éxito la realización y participación de los alumnos en eventos especiales como: Misiones Médicas, Jornadas de Salud, Seminario de Bioética, entre otras.');
INSERT INTO `preguntas_puestos` VALUES ('508', 'COORDINADOR DE CAMPOS CLÍNICOS (NIVEL MANDOS MEDIOS 2)', 'Solicita en tiempo y forma a los maestros de ciclo clínicos el banco de reactivos necesarios para estructurar la evaluación final.');
INSERT INTO `preguntas_puestos` VALUES ('509', 'PROFESOR UNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Elabora el contenido de sus clases con información actualizada en base al programa académico establecido y autorizado por las autoridades académicas correspondientes.');
INSERT INTO `preguntas_puestos` VALUES ('510', 'PROFESOR UNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Establece una interacción positiva con los alumnos facilitando el aprendizaje y la formación integral del estudiante.');
INSERT INTO `preguntas_puestos` VALUES ('511', 'PROFESOR UNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Prepara y aplica en tiempo y forma los exámenes para la valoración del aprendizaje de su materia.');
INSERT INTO `preguntas_puestos` VALUES ('512', 'PROFESOR UNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'De manera permenente busca continuar con su formación profesional y docente.');
INSERT INTO `preguntas_puestos` VALUES ('513', 'PROFESOR UNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Participa activamente en cursos o seminarios que le sean asignados y/o programados por el área de formación docente.');
INSERT INTO `preguntas_puestos` VALUES ('514', 'PROFESOR UNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Atiende y da seguimiento oportuno a las inquietudes de los alumnos.');
INSERT INTO `preguntas_puestos` VALUES ('515', 'PROFESOR UNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Se asesora con la autoridad correspondiente para la pronta solución de problemas de sus alumnos.');
INSERT INTO `preguntas_puestos` VALUES ('516', 'PROFESOR UNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Utiliza eficientemente la tecnología como apoyo dela práctica docente.');
INSERT INTO `preguntas_puestos` VALUES ('517', 'PROFESOR UNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Realiza con eficiencia el seguimiento académico y personal de sus alumnos tutoriados.');
INSERT INTO `preguntas_puestos` VALUES ('518', 'PROFESOR UNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Entrega informes útiles de seguimiento al Director de su escuela.');
INSERT INTO `preguntas_puestos` VALUES ('519', 'SUPERVISOR DE SERVICIOS AL PÚBLICO (NIVEL MANDOS MEDIOS 2)', 'Establece contacto permanente con los usuarios obteniendo retroalimentación acerca de los servicios que se proporcionan.');
INSERT INTO `preguntas_puestos` VALUES ('520', 'SUPERVISOR DE SERVICIOS AL PÚBLICO (NIVEL MANDOS MEDIOS 2)', 'Supervisa eficientemente el funcionamiento y desarrollo de los módulos de circulación y Opac Web del sistema de administración de biblioteca.');
INSERT INTO `preguntas_puestos` VALUES ('521', 'SUPERVISOR DE SERVICIOS AL PÚBLICO (NIVEL MANDOS MEDIOS 2)', 'Coordina y supervisa debidamente las actividades referentes a la organizacipon, control, prestación, difusión de servicios y recursos de la biblioteca.');
INSERT INTO `preguntas_puestos` VALUES ('522', 'SUPERVISOR DE SERVICIOS AL PÚBLICO (NIVEL MANDOS MEDIOS 2)', 'Establece de manera continua contactos con Instituciones logrando convenios de cooperación bibliotecaria.');
INSERT INTO `preguntas_puestos` VALUES ('523', 'SUPERVISOR DE SERVICIOS AL PÚBLICO (NIVEL MANDOS MEDIOS 2)', 'Coordina reuniones periódicas con el personal del área y mantiene una constante comunicación con los miembros de la misma.');
INSERT INTO `preguntas_puestos` VALUES ('524', 'SUPERVISOR DE SERVICIOS AL PÚBLICO (NIVEL MANDOS MEDIOS 2)', 'Presenta con éxito planes y programas de trabajo y vigila su cumplimiento.');
INSERT INTO `preguntas_puestos` VALUES ('525', 'SUPERVISOR DE SERVICIOS AL PÚBLICO (NIVEL MANDOS MEDIOS 2)', 'Apoya satisfactoriamente en la elaboración del programa anual de la biblioteca.');
INSERT INTO `preguntas_puestos` VALUES ('526', 'SUPERVISOR DE SERVICIOS AL PÚBLICO (NIVEL MANDOS MEDIOS 2)', 'Organiza y mantiene actualizados los sistemas y procedimientos del área.');
INSERT INTO `preguntas_puestos` VALUES ('527', 'SUPERVISOR DE SERVICIOS AL PÚBLICO (NIVEL MANDOS MEDIOS 2)', 'En forma cconjunta con el jefe de área, elabora el presupuesto anual de operación del área y presenta reportes periódicos de avance.');
INSERT INTO `preguntas_puestos` VALUES ('528', 'SUPERVISOR DE SERVICIOS AL PÚBLICO (NIVEL MANDOS MEDIOS 2)', 'Participa activamente en las visitas guiadas para usuarios de la biblioteca.');
INSERT INTO `preguntas_puestos` VALUES ('529', 'ESPECIALISTA DE SOPORTE A SISTEMAS (NIVEL MANDOS MEDIOS 2)', 'Garantiza la correcta operación del SIU de los sistemas (SW) institucionales asignados al área.');
INSERT INTO `preguntas_puestos` VALUES ('530', 'ESPECIALISTA DE SOPORTE A SISTEMAS (NIVEL MANDOS MEDIOS 2)', 'Proporciona a la Comunidad Universitaria la información necesaria localizada en el SIU y en otros sistemas (SW) institucionales asignados al área, para la operación de sus áreas de trabajo.');
INSERT INTO `preguntas_puestos` VALUES ('531', 'ESPECIALISTA DE SOPORTE A SISTEMAS (NIVEL MANDOS MEDIOS 2)', 'Canaliza y da seguimeinto hasta su solución a los problemas relacionados con la División de Universidades, así como da respuesta de ello a la Comunidad Universitaria.');
INSERT INTO `preguntas_puestos` VALUES ('532', 'ESPECIALISTA DE SOPORTE A SISTEMAS (NIVEL MANDOS MEDIOS 2)', 'Genera en tiempo y forma la información requerida por los usuarios a través de reportes.');
INSERT INTO `preguntas_puestos` VALUES ('533', 'ESPECIALISTA DE SOPORTE A SISTEMAS (NIVEL MANDOS MEDIOS 2)', 'Procura la entera satisfacción de todos los usuarios,promoviendo la comunicación y estando atento a sus necesidades.');
INSERT INTO `preguntas_puestos` VALUES ('534', 'ESPECIALISTA DE SOPORTE A SISTEMAS (NIVEL MANDOS MEDIOS 2)', 'Mantiene sus procedimientos con estándares elevados de seguridad para su correcta operación.');
INSERT INTO `preguntas_puestos` VALUES ('535', 'ESPECIALISTA DE SOPORTE A SISTEMAS (NIVEL MANDOS MEDIOS 2)', 'Cuenta con mecanismos de evaluación (encuestas, entrevistas,etc) que le permiten monitorear el grado de satisfacción de sus clientes.');
INSERT INTO `preguntas_puestos` VALUES ('536', 'ESPECIALISTA DE SOPORTE A SISTEMAS (NIVEL MANDOS MEDIOS 2)', 'Reporta oportunamente los resultados del área y el nivel de satisfacción de sus clientes tomenado las medidas necesarias.');
INSERT INTO `preguntas_puestos` VALUES ('537', 'ESPECIALISTA DE SOPORTE A SISTEMAS (NIVEL MANDOS MEDIOS 2)', 'Apoya eficientemente a la División de Universidades y AGS (Área Global de Sistemas), en los procesos de implementación, dimensionamiento y migración.');
INSERT INTO `preguntas_puestos` VALUES ('538', 'ESPECIALISTA DE SOPORTE A SISTEMAS (NIVEL MANDOS MEDIOS 2)', 'Trabaja en forma conjunta con la División de Universidades y AGS, en la actualización de las versiones de Banner y de cualquier otro sistema (SW) institucional que opera en la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('539', 'ESPECIALISTA DE PRESUPUESTOS (NIVEL MANDOS MEDIOS 2)', 'Controla y supervisa adecuadamente los registros de gastos mensuales de cada área.');
INSERT INTO `preguntas_puestos` VALUES ('540', 'ESPECIALISTA DE PRESUPUESTOS (NIVEL MANDOS MEDIOS 2)', 'Revisa eficaz y continuamente los gastos reales vs. presupuestados.');
INSERT INTO `preguntas_puestos` VALUES ('541', 'ESPECIALISTA DE PRESUPUESTOS (NIVEL MANDOS MEDIOS 2)', 'Mantiene actualizado el sistema de asignación y seguimiento del ejercicio presupuestal.');
INSERT INTO `preguntas_puestos` VALUES ('542', 'ESPECIALISTA DE PRESUPUESTOS (NIVEL MANDOS MEDIOS 2)', 'Elabora en tiempo y forma los reportes mensuales de gastos.');
INSERT INTO `preguntas_puestos` VALUES ('543', 'ESPECIALISTA DE PRESUPUESTOS (NIVEL MANDOS MEDIOS 2)', 'Realiza adecuadamente las evaluaciones financieras.');
INSERT INTO `preguntas_puestos` VALUES ('544', 'ESPECIALISTA DE PRESUPUESTOS (NIVEL MANDOS MEDIOS 2)', 'Revisa de manera consistente las solicitudes de gastos para asegurar la suficiencia de fondos.');
INSERT INTO `preguntas_puestos` VALUES ('545', 'ESPECIALISTA DE PRESUPUESTOS (NIVEL MANDOS MEDIOS 2)', 'Mantiene actualizado el presupuesto de sueldos y salarios de la Institución.');
INSERT INTO `preguntas_puestos` VALUES ('546', 'ESPECIALISTA DE PRESUPUESTOS (NIVEL MANDOS MEDIOS 2)', 'Monitorea continuamente los ingresos y egresos de cada una de las áreas.');
INSERT INTO `preguntas_puestos` VALUES ('547', 'ESPECIALISTA DE PRESUPUESTOS (NIVEL MANDOS MEDIOS 2)', 'Genera de manera constante información estadística útil y proyecciones.');
INSERT INTO `preguntas_puestos` VALUES ('548', 'ESPECIALISTA DE PRESUPUESTOS (NIVEL MANDOS MEDIOS 2)', 'Apoya con actitud de servicio a las áreas en la elaboración y seguimiento de sus presupuestos.');
INSERT INTO `preguntas_puestos` VALUES ('549', 'JEFE DE COMPRAS (NIVEL MANDOS MEDIOS 2)', 'Contacta y selecciona proveedores gestionando los trámites de compras que se autoricen e investiga la costeablilidad y valor de los artículos que se adquieren.');
INSERT INTO `preguntas_puestos` VALUES ('550', 'JEFE DE COMPRAS (NIVEL MANDOS MEDIOS 2)', 'Integra y maneja con eficiencia el consecutivo de compras.');
INSERT INTO `preguntas_puestos` VALUES ('551', 'JEFE DE COMPRAS (NIVEL MANDOS MEDIOS 2)', 'Administra debidamente la cartera de proveedores.');
INSERT INTO `preguntas_puestos` VALUES ('552', 'JEFE DE COMPRAS (NIVEL MANDOS MEDIOS 2)', 'Controla adecuadamente las órdenes de entrega a almacén por concepto de compras autorizadas.');
INSERT INTO `preguntas_puestos` VALUES ('553', 'JEFE DE COMPRAS (NIVEL MANDOS MEDIOS 2)', 'Recaba en tiempo y forma las facturas o comprobantes fiscales correspondientes a las compras realizadas. ');
INSERT INTO `preguntas_puestos` VALUES ('554', 'JEFE DE COMPRAS (NIVEL MANDOS MEDIOS 2)', 'En conjunto con las autoridades correspondientes, implementa las políticas y procedimientos de compras, así como su difusión y cumplimiento de los mismos.');
INSERT INTO `preguntas_puestos` VALUES ('555', 'JEFE DE COMPRAS (NIVEL MANDOS MEDIOS 2)', 'Da el seguimiento adecuado a convenios y contratos realizados.');
INSERT INTO `preguntas_puestos` VALUES ('556', 'JEFE DE COMPRAS (NIVEL MANDOS MEDIOS 2)', 'Gestiona y da el debido seguimiento a garantías de productos o servicios adquiridos por el área.');
INSERT INTO `preguntas_puestos` VALUES ('557', 'JEFE DE COMPRAS (NIVEL MANDOS MEDIOS 2)', 'Elabora reportes e información estadística útil para el área.');
INSERT INTO `preguntas_puestos` VALUES ('558', 'JEFE DE COMPRAS (NIVEL MANDOS MEDIOS 2)', 'Desarrolla y capacita adecuadamente al personal de su área.');
INSERT INTO `preguntas_puestos` VALUES ('559', 'JEFE DE CONTABILIDAD (NIVEL MANDOS MEDIOS 2)', 'Supervisa y realiza con eficiencia los registros de operaciones económicas, contables y financieras de la Institución de acuerdo a los lineamientos y políticas establecidas.');
INSERT INTO `preguntas_puestos` VALUES ('560', 'JEFE DE CONTABILIDAD (NIVEL MANDOS MEDIOS 2)', 'Aplica o registra con precisión las operaciones económicas de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('561', 'JEFE DE CONTABILIDAD (NIVEL MANDOS MEDIOS 2)', 'Efectúa los pagos fiscales y tributarios, cumpliendo en todo momento con las obligaciones fiscales.');
INSERT INTO `preguntas_puestos` VALUES ('562', 'JEFE DE CONTABILIDAD (NIVEL MANDOS MEDIOS 2)', 'Elabora y presenta con puntualidad la declaración anual y los estados financieros.');
INSERT INTO `preguntas_puestos` VALUES ('563', 'JEFE DE CONTABILIDAD (NIVEL MANDOS MEDIOS 2)', 'Da un adecuado seguimiento a las auditorías y dictámenes contables que ');
INSERT INTO `preguntas_puestos` VALUES ('564', 'JEFE DE CONTABILIDAD (NIVEL MANDOS MEDIOS 2)', 'Cumple debidamente con el pago de obligaciones gubernamentales IMSS, ISPT, INFONAVIT.');
INSERT INTO `preguntas_puestos` VALUES ('565', 'JEFE DE CONTABILIDAD (NIVEL MANDOS MEDIOS 2)', 'Registra con precisión las operaciones diarias de bancos, manteniendo actualizados los saldos e informando diariamente al Contralor y Vicerrector de Administración y Finanazas.');
INSERT INTO `preguntas_puestos` VALUES ('566', 'JEFE DE CONTABILIDAD (NIVEL MANDOS MEDIOS 2)', 'Vigila que los pagos de nómina se efectúen correcta y oportunamente.');
INSERT INTO `preguntas_puestos` VALUES ('567', 'JEFE DE CONTABILIDAD (NIVEL MANDOS MEDIOS 2)', 'Efectúa eficientemente el registro contable de pólizas derivadas de las nóminas de empleados y profesores.');
INSERT INTO `preguntas_puestos` VALUES ('568', 'JEFE DE CONTABILIDAD (NIVEL MANDOS MEDIOS 2)', 'Verifica con exactitud los registros auxiliares,mayor y balance mensual de saldos.');
INSERT INTO `preguntas_puestos` VALUES ('569', 'JEFE DE CRÉDITO Y COBRANZA (NIVEL MANDOS MEDIOS 2)', 'Genera y mantiene actualizada la lista de sujetos de crédito y sus montos correspondientes.');
INSERT INTO `preguntas_puestos` VALUES ('570', 'JEFE DE CRÉDITO Y COBRANZA (NIVEL MANDOS MEDIOS 2)', 'Verifica el cumplimiento de los vencimientos de todos los acuerdos de crédito.');
INSERT INTO `preguntas_puestos` VALUES ('571', 'JEFE DE CRÉDITO Y COBRANZA (NIVEL MANDOS MEDIOS 2)', 'En base a los lineamientos y políticas establecidas, facilita el apoyo financiero a los alumnos que lo requieran,dando seguimiento oportuno al pago de financiamiento y becas.');
INSERT INTO `preguntas_puestos` VALUES ('572', 'JEFE DE CRÉDITO Y COBRANZA (NIVEL MANDOS MEDIOS 2)', 'Analiza pertinentemente los créditos educativos que se van a otorgar y los presenta ante las autoridades.');
INSERT INTO `preguntas_puestos` VALUES ('573', 'JEFE DE CRÉDITO Y COBRANZA (NIVEL MANDOS MEDIOS 2)', 'Atiende con actitud de servicio a alumnos y padres de familia sobre temas de becas y financiamientos.');
INSERT INTO `preguntas_puestos` VALUES ('574', 'JEFE DE CRÉDITO Y COBRANZA (NIVEL MANDOS MEDIOS 2)', 'Fomenta con éxito un ambiente de cumplimiento en los temas de crédito.');
INSERT INTO `preguntas_puestos` VALUES ('575', 'JEFE DE CRÉDITO Y COBRANZA (NIVEL MANDOS MEDIOS 2)', 'Elabora y concilia con precisión los movimientos contables que afecten el área.');
INSERT INTO `preguntas_puestos` VALUES ('576', 'JEFE DE CRÉDITO Y COBRANZA (NIVEL MANDOS MEDIOS 2)', 'Controla eficientemente la cobranza y emite reportes de alumnos morosos.');
INSERT INTO `preguntas_puestos` VALUES ('577', 'JEFE DE CRÉDITO Y COBRANZA (NIVEL MANDOS MEDIOS 2)', 'Elabora y propone a sus superiores, planes de pago de alumnos con dificultades.');
INSERT INTO `preguntas_puestos` VALUES ('578', 'JEFE DE CRÉDITO Y COBRANZA (NIVEL MANDOS MEDIOS 2)', 'Da seguimiento correcto y oportuno a los pagos de financiamiento y becas.');
INSERT INTO `preguntas_puestos` VALUES ('579', 'JEFE DE SERVICIOS GENERALES (NIVEL MANDOS MEDIOS 2)', 'Coordina adecuadamente al servicio de mantenimiento y limpieza de la Institución.');
INSERT INTO `preguntas_puestos` VALUES ('580', 'JEFE DE SERVICIOS GENERALES (NIVEL MANDOS MEDIOS 2)', 'Coordina el servicio del conmutador y atiende las necesidades del personal de inmediato.');
INSERT INTO `preguntas_puestos` VALUES ('581', 'JEFE DE SERVICIOS GENERALES (NIVEL MANDOS MEDIOS 2)', 'Supervisa y da el seguimiento apropiado al servicio de vigilancia y jardinería de la Institución.');
INSERT INTO `preguntas_puestos` VALUES ('582', 'JEFE DE SERVICIOS GENERALES (NIVEL MANDOS MEDIOS 2)', 'Propone y realiza programas de mantenimiento preventivo y de seguridad para todas las áreas de la Institución.');
INSERT INTO `preguntas_puestos` VALUES ('583', 'JEFE DE SERVICIOS GENERALES (NIVEL MANDOS MEDIOS 2)', 'Apoya con recurso y logística a los departamentos que así lo soliciten para la realización de eventos.');
INSERT INTO `preguntas_puestos` VALUES ('584', 'JEFE DE SERVICIOS GENERALES (NIVEL MANDOS MEDIOS 2)', 'Coordina con eficiencia los servicios médico,de recolección y entrega de documentos (mensajería interna) entre las diferentes áreas de la Institución.');
INSERT INTO `preguntas_puestos` VALUES ('585', 'JEFE DE SERVICIOS GENERALES (NIVEL MANDOS MEDIOS 2)', 'Coordina adecuadamente a los proveedores en las remodelaciones, adecuaciones, ampliaciones de instalaciones y mobiliario.');
INSERT INTO `preguntas_puestos` VALUES ('586', 'JEFE DE SERVICIOS GENERALES (NIVEL MANDOS MEDIOS 2)', 'Efectúa diariamente sesiones con los responsables directos de las áreas bajo su cargo y selectivamente todos los días efectúa recorridos de supervisión y muestro de cumplimiento de servicios.');
INSERT INTO `preguntas_puestos` VALUES ('587', 'JEFE DE SERVICIOS GENERALES (NIVEL MANDOS MEDIOS 2)', 'Elabora políticas y procedimientos de operación propias de su área y reportes sobre los resultados obtenidos.');
INSERT INTO `preguntas_puestos` VALUES ('588', 'JEFE DE SERVICIOS GENERALES (NIVEL MANDOS MEDIOS 2)', 'Supervisa, evalúa y capacita debidamente al personal a su cargo.');
INSERT INTO `preguntas_puestos` VALUES ('589', 'ASISTENTE ACADÉMICO (NIVEL MANDOS MEDIOS 2)', 'Realiza apropiadamente las actividades que su jefe le asigne,apoyando al área en tareas o proyectos especiales.');
INSERT INTO `preguntas_puestos` VALUES ('590', 'ASISTENTE ACADÉMICO (NIVEL MANDOS MEDIOS 2)', 'Apoya eficientemente en la programación y aplicación de exámenes de los diferentes cursos.');
INSERT INTO `preguntas_puestos` VALUES ('591', 'ASISTENTE ACADÉMICO (NIVEL MANDOS MEDIOS 2)', 'Apoya en los procesos de evaluación y auditoría del área, para comprobar y asegurar el buen funcionamiento de la misma. ');
INSERT INTO `preguntas_puestos` VALUES ('592', 'ASISTENTE ACADÉMICO (NIVEL MANDOS MEDIOS 2)', 'Apoya de manera servicial en la comunicación a profesores y alumnos sobre horarios, programación académica,etc.');
INSERT INTO `preguntas_puestos` VALUES ('593', 'ASISTENTE ACADÉMICO (NIVEL MANDOS MEDIOS 2)', 'Da atención personal a los alumnos y los apoya para resolver problemas que puedan surgir en la selección de clases o en cualquier otra actividad que realice el área.');
INSERT INTO `preguntas_puestos` VALUES ('594', 'ASISTENTE ACADÉMICO (NIVEL MANDOS MEDIOS 2)', 'Da atención personalizada a profesores canalizando a las instancias correspondientes inquietudes o problemas planteados por los mismos.');
INSERT INTO `preguntas_puestos` VALUES ('595', 'ASISTENTE ACADÉMICO (NIVEL MANDOS MEDIOS 2)', 'Apoya con eficiencia en la búsqueda de candidatos y en la integración de expedientes de personas que se vayan a incorporar como profesores ya sea de planta u honorarios.');
INSERT INTO `preguntas_puestos` VALUES ('596', 'ASISTENTE ACADÉMICO (NIVEL MANDOS MEDIOS 2)', 'Vigila que tanto alumnos como profesores cumplan con los lineamientos y procedimientos establecidos, alertando a su superior sobre desviacioneso anomalías.');
INSERT INTO `preguntas_puestos` VALUES ('597', 'ASISTENTE ACADÉMICO (NIVEL MANDOS MEDIOS 2)', 'Propone y desarrolla propuestas de mejora que cumplan con los objetivos del área.');
INSERT INTO `preguntas_puestos` VALUES ('598', 'ASISTENTE ACADÉMICO (NIVEL MANDOS MEDIOS 2)', 'Busca su desarrollo y crecimiento personal capacitándose en tareas y funciones propias de su área.');
INSERT INTO `preguntas_puestos` VALUES ('599', 'ESPECIALISTA DE CERTIFICACIÓN Y TITULACIÓN (NIVEL MANDOS MEDIOS 2)', 'Mantiene estrecha relación con la Secretaría de Educación Pública (SEP) para la autenticación y legalización de documentos.');
INSERT INTO `preguntas_puestos` VALUES ('600', 'ESPECIALISTA DE CERTIFICACIÓN Y TITULACIÓN (NIVEL MANDOS MEDIOS 2)', 'Gestiona debidamente ante la SEO las revisiones de estudios.');
INSERT INTO `preguntas_puestos` VALUES ('601', 'ESPECIALISTA DE CERTIFICACIÓN Y TITULACIÓN (NIVEL MANDOS MEDIOS 2)', 'Está al tanto de nuevas disposiciones oficiales e informa oportunamente de las mismas.');
INSERT INTO `preguntas_puestos` VALUES ('602', 'ESPECIALISTA DE CERTIFICACIÓN Y TITULACIÓN (NIVEL MANDOS MEDIOS 2)', 'Recibe con amabilidad los documentos necesarios de parte de los estudiantes para realizar los trámites.');
INSERT INTO `preguntas_puestos` VALUES ('603', 'ESPECIALISTA DE CERTIFICACIÓN Y TITULACIÓN (NIVEL MANDOS MEDIOS 2)', 'Conoce y difunde eficientemente información relevante de los procesos de titulación tanto a los académicos como a los estudiantes.');
INSERT INTO `preguntas_puestos` VALUES ('604', 'ESPECIALISTA DE CERTIFICACIÓN Y TITULACIÓN (NIVEL MANDOS MEDIOS 2)', 'Asesora a los estudiantes en la realización de sus trámites de titulación.');
INSERT INTO `preguntas_puestos` VALUES ('605', 'ESPECIALISTA DE CERTIFICACIÓN Y TITULACIÓN (NIVEL MANDOS MEDIOS 2)', 'Redacta y programa las actas de los exámenes profesionales de manera adecuada.');
INSERT INTO `preguntas_puestos` VALUES ('606', 'ESPECIALISTA DE CERTIFICACIÓN Y TITULACIÓN (NIVEL MANDOS MEDIOS 2)', 'Efectúa con precisión el proceso de revisión de estudios sobre los antecedentes escolares y la trayectoria académica de los estudiantes, para iniciar su proceso de titulación.');
INSERT INTO `preguntas_puestos` VALUES ('607', 'ESPECIALISTA DE CERTIFICACIÓN Y TITULACIÓN (NIVEL MANDOS MEDIOS 2)', 'Emite en tiempo y forma la convocatoria controlando el registro de candidatos a obtener el título profesional.');
INSERT INTO `preguntas_puestos` VALUES ('608', 'ESPECIALISTA DE CERTIFICACIÓN Y TITULACIÓN (NIVEL MANDOS MEDIOS 2)', 'Elabora y controla con eficiencia la información estadística que se genera en el área. ');
INSERT INTO `preguntas_puestos` VALUES ('609', 'ASESOR PREUNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Detecta áreas de oportunidad para la promoción universitaria y participa en la realización de planes de acción correspondientes.');
INSERT INTO `preguntas_puestos` VALUES ('610', 'ASESOR PREUNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Cumple con las metas de captación de matrícula de nuesvos ingresos de acuerdo a las establecidas por: colegios meta y carreras asignadas.');
INSERT INTO `preguntas_puestos` VALUES ('611', 'ASESOR PREUNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Orienta de manera personal a los preuniversitarios en sus necesidades de información para la elección de universidad y les da seguimiento logrando su inscripción a algún programa de licenciatura.');
INSERT INTO `preguntas_puestos` VALUES ('612', 'ASESOR PREUNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Difunde y gestiona los diversos esquemas de becas y apoyos económicos para asegurar que los alumnos de alto potencial académico y/o humano, se logren incorporar a la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('613', 'ASESOR PREUNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Promueve en el segmento meta de preuniversitarios, las ventajas competitivas que ofrece la Universidad y la Red Anáhuac a través de diversas estrategias y actividades.');
INSERT INTO `preguntas_puestos` VALUES ('614', 'ASESOR PREUNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Persuade a través de presentaciones en grupo o individual sobre los beneficios qu');
INSERT INTO `preguntas_puestos` VALUES ('615', 'ASESOR PREUNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Mantiene, cuida y eleva el prestigio de la imagen de las Universidades de la Red Anáhuac, a través de un código de valores, de discurso, de atención y de vestimenta.');
INSERT INTO `preguntas_puestos` VALUES ('616', 'ASESOR PREUNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Fomenta las relaciones institucionales con las preparatorias meta, mediante un programa de acercamiento y de servicio permanente, y a través de los alumnos egresados de las mismas.');
INSERT INTO `preguntas_puestos` VALUES ('617', 'ASESOR PREUNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Organiza actividades que faciliten el acercamiento de preuniversitarios a las diversas licenciaturas y que permitan que conozcan las instalaciones y servicios.');
INSERT INTO `preguntas_puestos` VALUES ('618', 'ASESOR PREUNIVERSITARIO (NIVEL MANDOS MEDIOS 2)', 'Orienta adecuadamente a estudiantes foráneos en todo lo relacionado con trámites de ingreso y programas que ofrecen las Universidades de la Red.');
INSERT INTO `preguntas_puestos` VALUES ('619', 'COORDINADOR DE BECAS ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Entrevista a los solicitantes de beca y determina en base a políticas y mediante un estudio socieconómico adecuado, si la ayuda económica solicitada es necesaria y viable.');
INSERT INTO `preguntas_puestos` VALUES ('620', 'COORDINADOR DE BECAS ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'En coordinación con el Jefe de Admisiones,valora dedidamente a los aspirantes a becas turnando la información de los candidatos a las instancias correspondientes (Comité de Becas o su equivalente).');
INSERT INTO `preguntas_puestos` VALUES ('621', 'COORDINADOR DE BECAS ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Analiza la situación académica de cada candidato y propone a los candidatos idóneos en base a los lineamientos y políticas establecidas por las autoridades.');
INSERT INTO `preguntas_puestos` VALUES ('622', 'COORDINADOR DE BECAS ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Brinda de manera servicial la información a los candidatos acerca de los requisitos para solicitud de beca y crédito educativo.');
INSERT INTO `preguntas_puestos` VALUES ('623', 'COORDINADOR DE BECAS ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'En conjunto con los asesores preuniversitarios,promueve con éxito las becas y apoyos entre los candidatos a ingresar a la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('624', 'COORDINADOR DE BECAS ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Apoya y da seguimiento a los candidatos en el trámite y elaboración de documentos para el otorgamiento de becas y financiamientos.');
INSERT INTO `preguntas_puestos` VALUES ('625', 'COORDINADOR DE BECAS ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Supervisa eficientemente que los becados cumplan con los compromisos que aceptaron.');
INSERT INTO `preguntas_puestos` VALUES ('626', 'COORDINADOR DE BECAS ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Da el correcto y continuo seguimiento a los beneficiarios de crédito educativo o becas en lo que se refiere al cumplimiento de requisitos para el otorgamiento continuado del mismo.');
INSERT INTO `preguntas_puestos` VALUES ('627', 'COORDINADOR DE BECAS ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Informa satisfactoriamente a las áreas de administración y finanzas sobre c´reditos educativos, turnando la información correspondiente');
INSERT INTO `preguntas_puestos` VALUES ('628', 'COORDINADOR DE BECAS ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Genera en tiempo y forma información estadística del área.');
INSERT INTO `preguntas_puestos` VALUES ('629', 'COORDINACIÓN DE ATENCIÓN A ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Administra en forma óptima, el único punto de contacto para prospectos y alumnos de la Universidad, ofreciendo sus servicios de manera presencial, web y telefónicamente.');
INSERT INTO `preguntas_puestos` VALUES ('630', 'COORDINACIÓN DE ATENCIÓN A ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Maximiza los servicios y productos que se ofrecen con el menor gasto posible, logrando altos niveles de sinergias con las diferentes áraes de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('631', 'COORDINACIÓN DE ATENCIÓN A ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Logra y mantiene sinergias con las áreas de admisión, becas, finanzas, proveedores y cualquier prestador de servicios que este relacionado con productos demandados por loa alumnos/prospectos.');
INSERT INTO `preguntas_puestos` VALUES ('632', 'COORDINACIÓN DE ATENCIÓN A ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Posiciona con éxito a la coordinación de atención a alumnos como un área líder de calidad y servicios en la Comunidad Universitaria.');
INSERT INTO `preguntas_puestos` VALUES ('633', 'COORDINACIÓN DE ATENCIÓN A ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Genera mediaciones y estadísticas que permiten monitorear el nivel de satisfacción en el servicio proporcionado y reporta resultados en forma periódica a la dirección.');
INSERT INTO `preguntas_puestos` VALUES ('634', 'COORDINACIÓN DE ATENCIÓN A ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Firma acuerdos y documenta procesos operativos con las áreas relacionadas al servicio dentro de la Institución y le da seguimiento.');
INSERT INTO `preguntas_puestos` VALUES ('635', 'COORDINACIÓN DE ATENCIÓN A ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Desarrolla procesos estandarizados que optimizan los recursos del área sin demeritar los niveles de servicio ofrecidos.');
INSERT INTO `preguntas_puestos` VALUES ('636', 'COORDINACIÓN DE ATENCIÓN A ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Da segumiento a problemas críticos o situaciones especiales apoyando al personal de su área en la resolución de conflictos.');
INSERT INTO `preguntas_puestos` VALUES ('637', 'COORDINACIÓN DE ATENCIÓN A ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Monitorea continuamente los resultados obtenidos buscando la mejora continua y la búsqueda de mejores prácticas del mercado, en lo que a atención a clientes se refiere.');
INSERT INTO `preguntas_puestos` VALUES ('638', 'COORDINACIÓN DE ATENCIÓN A ALUMNOS (NIVEL MANDOS MEDIOS 2)', 'Supervisa y propicia el desarrollo y capacitación del personal del área para que cumpla satisfactoriamente con su función.');
INSERT INTO `preguntas_puestos` VALUES ('639', 'SE APLICARÁ PARA PERSONAL ADMINISTRATIVO (NIVEL OPERATIVO 1-2)', 'Mantiene una estrecha comunicación con su jefe sobre todos los aspectos del cargo que influyen directa o indirectamente en el cumplimiento de la Misión de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('640', 'SE APLICARÁ PARA PERSONAL ADMINISTRATIVO (NIVEL OPERATIVO 1-2)', 'Organiza y mantiene actualizados los sistemas y procedimientos del área.');
INSERT INTO `preguntas_puestos` VALUES ('641', 'SE APLICARÁ PARA PERSONAL ADMINISTRATIVO (NIVEL OPERATIVO 1-2)', 'Apoya al Director del área en el desarrollo del Plan Estratégico a corto, mediano y largo plazo, de acuerdo con el Plan Estratégico de la Universidad, coordinando la elaboración de los planes y programas anuales de trabajo y dando el seguimiento adecuado.');
INSERT INTO `preguntas_puestos` VALUES ('642', 'SE APLICARÁ PARA PERSONAL ADMINISTRATIVO (NIVEL OPERATIVO 1-2)', 'Promueve y difunde la misión de \"identidad católica\" de la institución, actuando con rectitud y congruencia en todas las actividades asignadas a su cargo.');
INSERT INTO `preguntas_puestos` VALUES ('643', 'SE APLICARÁ PARA PERSONAL ADMINISTRATIVO (NIVEL OPERATIVO 1-2)', 'Conoce y apoya satisfactoriamente los proyectos, objetivos y misión del área en la que desempeña sus funciones.');
INSERT INTO `preguntas_puestos` VALUES ('644', 'SE APLICARÁ PARA PERSONAL ADMINISTRATIVO (NIVEL OPERATIVO 1-2)', 'Conoce a los clientes y proveedores de servicio del área en la que trabaja y ofrece una calidad de atención adecuada y oportuna.');
INSERT INTO `preguntas_puestos` VALUES ('645', 'SE APLICARÁ PARA PERSONAL ADMINISTRATIVO (NIVEL OPERATIVO 1-2)', 'Busca continuamente su desarrollo y crecimiento personal capacitándose en tareas y funciones propias del área.');
INSERT INTO `preguntas_puestos` VALUES ('646', 'SE APLICARÁ PARA PERSONAL ADMINISTRATIVO (NIVEL OPERATIVO 1-2)', 'Apoya satisfactoriamente en proyectos especiales, así como en tareas de grupo que puedan no estar relacionadas directamente con sus funciones cotidianas.');
INSERT INTO `preguntas_puestos` VALUES ('647', 'SE APLICARÁ PARA PERSONAL ADMINISTRATIVO (NIVEL OPERATIVO 1-2)', 'Alerta al jefe inmediato superior sobre problemas o dificultades detectadas en el área.');
INSERT INTO `preguntas_puestos` VALUES ('648', 'SE APLICARÁ PARA PERSONAL ADMINISTRATIVO (NIVEL OPERATIVO 1-2)', 'Propone y desarrolla propuestas de mejora que cumplan con los objetivos del área.');
INSERT INTO `preguntas_puestos` VALUES ('649', 'SECRETARIAS Y ASISTENTES (NIVEL OPERATIVO 2)', 'Realiza con eficiencia tareas de captura, redacción de documentos, archivo y organización de eventos; control de agenda, control de viajes y en general apoya al área en todo lo referente a cuestiones administrativas.');
INSERT INTO `preguntas_puestos` VALUES ('650', 'SECRETARIAS Y ASISTENTES (NIVEL OPERATIVO 2)', 'Atiende con actitud de servicios a usuarios, personal del área, proveedores y prestadores de servicio.');
INSERT INTO `preguntas_puestos` VALUES ('651', 'SECRETARIAS Y ASISTENTES (NIVEL OPERATIVO 2)', 'Apoya en tiempo y forma al control de gastos, elaboración de reportes de viaje y reservaciones.');
INSERT INTO `preguntas_puestos` VALUES ('652', 'SECRETARIAS Y ASISTENTES (NIVEL OPERATIVO 2)', 'Lleva a cabo una adecuada recepción y registro de documentos recibidos y enviados por el área.');
INSERT INTO `preguntas_puestos` VALUES ('653', 'SECRETARIAS Y ASISTENTES (NIVEL OPERATIVO 2)', 'Realiza la recepción, registro y direccionamiento de llamadas con eficiencia y actitud de servicio.');
INSERT INTO `preguntas_puestos` VALUES ('654', 'SECRETARIAS Y ASISTENTES (NIVEL OPERATIVO 2)', 'Solicita y administra en el tiempo y forma requerido: papelería, artículos de oficina, caja chica, suministros para operación de equipos de computación etc.');
INSERT INTO `preguntas_puestos` VALUES ('655', 'SECRETARIAS Y ASISTENTES (NIVEL OPERATIVO 2)', 'Ejecuta debidamente los trámites de pago a proveedores.');
INSERT INTO `preguntas_puestos` VALUES ('656', 'SECRETARIAS Y ASISTENTES (NIVEL OPERATIVO 2)', 'Tiene un adecuado conocimiento de los objetivos del área y apoya la misión de la institución.');
INSERT INTO `preguntas_puestos` VALUES ('657', 'SECRETARIAS Y ASISTENTES (NIVEL OPERATIVO 2)', 'Apoya con diligencia en la organización de juntas y eventos del área.');
INSERT INTO `preguntas_puestos` VALUES ('658', 'SECRETARIAS Y ASISTENTES (NIVEL OPERATIVO 2)', 'Mantiene un adecuado control y orden del archivo.');
INSERT INTO `preguntas_puestos` VALUES ('659', 'SERVICIOS GENERALES (NIVEL OPERATIVO 2)', 'Alerta a sus superiores sobre fallas o problemas que requieran los servicios del área de mantenimiento o jardinería.');
INSERT INTO `preguntas_puestos` VALUES ('660', 'SERVICIOS GENERALES (NIVEL OPERATIVO 2)', 'Realiza mantenimiento preventivo y correctivo a las instalaciones de la institución.');
INSERT INTO `preguntas_puestos` VALUES ('661', 'SERVICIOS GENERALES (NIVEL OPERATIVO 2)', 'Atiende los requerimiento de reparación, corrigiendo el daño en el menor tiempo.');
INSERT INTO `preguntas_puestos` VALUES ('662', 'SERVICIOS GENERALES (NIVEL OPERATIVO 2)', 'Solicita con anticipación los materiales que se requieran para los trabajos a realizar.');
INSERT INTO `preguntas_puestos` VALUES ('663', 'SERVICIOS GENERALES (NIVEL OPERATIVO 2)', 'Ejecuta con eficiencia las actividades a realizar diariamente del área con el reporte correspondiente.');
INSERT INTO `preguntas_puestos` VALUES ('664', 'SERVICIOS GENERALES (NIVEL OPERATIVO 2)', 'Propone al jefe del área las mejoras que considere pertinentes para cumplir con las responsabilidades asignadas.');
INSERT INTO `preguntas_puestos` VALUES ('665', 'SERVICIOS GENERALES (NIVEL OPERATIVO 2)', 'Conoce los objetivos del área y la misión de la institución.');
INSERT INTO `preguntas_puestos` VALUES ('666', 'SERVICIOS GENERALES (NIVEL OPERATIVO 2)', 'Realiza actividades de apoyo dentro del área ');
INSERT INTO `preguntas_puestos` VALUES ('667', 'SERVICIOS GENERALES (NIVEL OPERATIVO 2)', 'Conoce y lleva acabo los sistemas de seguridad de la institución.');
INSERT INTO `preguntas_puestos` VALUES ('668', 'SERVICIOS GENERALES (NIVEL OPERATIVO 2)', 'Cuida del buen uso de los equipos y herramientas que se le asignen.');
INSERT INTO `preguntas_puestos` VALUES ('669', 'DEL DIRECTOR DE PASTORAL UNIVERSITARIA (NIVEL DIRECCIONES 2)', 'Promueve activamente el desarrollo de nuestra misión e \"identidad católica\" especialmente en las actividades relacionadas con la formación humana de los alumnos.');
INSERT INTO `preguntas_puestos` VALUES ('670', 'DEL DIRECTOR DE PASTORAL UNIVERSITARIA (NIVEL DIRECCIONES 2)', 'Ofrece un servicio de atención personalizada en lo espiritual y humano a toda la comunidad universitaria.');
INSERT INTO `preguntas_puestos` VALUES ('671', 'DEL DIRECTOR DE PASTORAL UNIVERSITARIA (NIVEL DIRECCIONES 2)', 'Realiza permanentemente actividades complementarias de formación humana y religiosa.');
INSERT INTO `preguntas_puestos` VALUES ('672', 'DEL DIRECTOR DE PASTORAL UNIVERSITARIA (NIVEL DIRECCIONES 2)', 'Preside de manera permanente y logra aumentar la asistencia de alumnos a las siguientes actividades: misas, confesiones, retiros, misiones, etc.');
INSERT INTO `preguntas_puestos` VALUES ('673', 'DEL DIRECTOR DE PASTORAL UNIVERSITARIA (NIVEL DIRECCIONES 2)', 'Promociona actividades propias del área por medio de posters, trípticos, visitas, etc.');
INSERT INTO `preguntas_puestos` VALUES ('674', 'DEL DIRECTOR DE PASTORAL UNIVERSITARIA (NIVEL DIRECCIONES 2)', 'Mantiene una estrecha comunicación con el Rector sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('675', 'DEL DIRECTOR DE PASTORAL UNIVERSITARIA (NIVEL DIRECCIONES 2)', 'Coordina eficientemente la acción apostólica.');
INSERT INTO `preguntas_puestos` VALUES ('676', 'DEL DIRECTOR DE PASTORAL UNIVERSITARIA (NIVEL DIRECCIONES 2)', 'Encausa las inquietudes humanitarias y apostólicas de la comunidad universitaria.');
INSERT INTO `preguntas_puestos` VALUES ('677', 'DEL DIRECTOR DE PASTORAL UNIVERSITARIA (NIVEL DIRECCIONES 2)', 'Organiza encuentros de reflexión y seminarios o cursos de formación.');
INSERT INTO `preguntas_puestos` VALUES ('678', 'DEL DIRECTOR DE PASTORAL UNIVERSITARIA (NIVEL DIRECCIONES 2)', 'Revisa al término de cada actividad de formación una evaluación de los resultados obtenidos para alinear aspectos que sean necesarios.');
INSERT INTO `preguntas_puestos` VALUES ('679', 'DIRECTOR DE ATENCIÓN PREUNIVERSITARIA Y MERCADOTECNIA (DIRECCCIONES 2)', 'Alcanza las metas de crecimiento de la matrícula de la licenciatura que solicite la Institución de acuerdo al Plan de Mercadotécnia Estratégica que desarrolla anualmente.');
INSERT INTO `preguntas_puestos` VALUES ('680', 'DIRECTOR DE ATENCIÓN PREUNIVERSITARIA Y MERCADOTECNIA (DIRECCCIONES 2)', 'Desarrolla y da seguimiento al Plan Estratégico y de Presupuesto del área a corto, mediano y largo plazo de acuerdo al Plan Estratégico de la Universidad asegurando su cumplimiento.');
INSERT INTO `preguntas_puestos` VALUES ('681', 'DIRECTOR DE ATENCIÓN PREUNIVERSITARIA Y MERCADOTECNIA (DIRECCCIONES 2)', 'Tiene un conocimiento objetivo del mercado en que participa la institución, y logra traducirlo traducirlo en un plan integral de mercadotecnia y promoción.');
INSERT INTO `preguntas_puestos` VALUES ('682', 'DIRECTOR DE ATENCIÓN PREUNIVERSITARIA Y MERCADOTECNIA (DIRECCCIONES 2)', 'Planea, coordina y evalúa de manera constante los cursos de capacitación para profesores de preparatoria, asesores preuniversitarios, directores y coordinadores de promoción de escuelas y facultades.');
INSERT INTO `preguntas_puestos` VALUES ('683', 'DIRECTOR DE ATENCIÓN PREUNIVERSITARIA Y MERCADOTECNIA (DIRECCCIONES 2)', 'Coordina los servicios de Orientación Vocacional de la Universidad para la decisión de admisión de alumnos y otorga un servicio al público con la finalidad de detectar prospectos con el perfil ideal.');
INSERT INTO `preguntas_puestos` VALUES ('684', 'DIRECTOR DE ATENCIÓN PREUNIVERSITARIA Y MERCADOTECNIA (DIRECCCIONES 2)', 'Garantiza los medios y aplicación de criterios para elevar la calidad en el perfil de alumnos admitidos.');
INSERT INTO `preguntas_puestos` VALUES ('685', 'DIRECTOR DE ATENCIÓN PREUNIVERSITARIA Y MERCADOTECNIA (DIRECCCIONES 2)', 'Organiza eventos de promoción y atención dirigidos a nuestros mercados meta, buscando una mejora continua en los mismos.');
INSERT INTO `preguntas_puestos` VALUES ('686', 'DIRECTOR DE ATENCIÓN PREUNIVERSITARIA Y MERCADOTECNIA (DIRECCCIONES 2)', 'Atiende de manera personalizada y con altos estándares de servicio a preparatorias meta, candidatos y solicitantes para los programas de licenciatura.');
INSERT INTO `preguntas_puestos` VALUES ('687', 'DIRECTOR DE ATENCIÓN PREUNIVERSITARIA Y MERCADOTECNIA (DIRECCCIONES 2)', 'Dirige los esfuerzos del departamento de becas para asegurar el mayor número de preuniversitarios con un alto perfil académico y humano.');
INSERT INTO `preguntas_puestos` VALUES ('688', 'DIRECTOR DE ATENCIÓN PREUNIVERSITARIA Y MERCADOTECNIA (DIRECCCIONES 2)', 'Desarrolla y analiza reportes estadísticos de utilidad para diversas áreas y escuelas.');
INSERT INTO `preguntas_puestos` VALUES ('689', 'CONTRALOR (NIVEL DIRECCIONES 2)', 'Proporciona información financiera, clara, veraz y oportuna a las autoridades.');
INSERT INTO `preguntas_puestos` VALUES ('690', 'CONTRALOR (NIVEL DIRECCIONES 2)', 'Analiza y evalua desde el punto de vista financiero, tanto los proyectos ya existentes como los nuevos que se propongan y realiza informes y propuestas a las autoridades.');
INSERT INTO `preguntas_puestos` VALUES ('691', 'CONTRALOR (NIVEL DIRECCIONES 2)', 'Controla e informa mensualmente sobre la afectación al presupuesto del mes y el acumulado. Realizando las propuestas de ajustes adecuadas para su cumplimiento.');
INSERT INTO `preguntas_puestos` VALUES ('692', 'CONTRALOR (NIVEL DIRECCIONES 2)', 'Realiza estudios de aumento de cuotas y elabora su respectiva propuesta.');
INSERT INTO `preguntas_puestos` VALUES ('693', 'CONTRALOR (NIVEL DIRECCIONES 2)', 'Atiende y da opciones de resolución a los alumnos y padres de familia con complicaciones en sus obligaciones de pago.');
INSERT INTO `preguntas_puestos` VALUES ('694', 'CONTRALOR (NIVEL DIRECCIONES 2)', 'Elabora en el tiempo establecido el presupuesto de ingresos.Elabora en el tiempo establecido el presupuesto de ingresos.');
INSERT INTO `preguntas_puestos` VALUES ('695', 'CONTRALOR (NIVEL DIRECCIONES 2)', 'Elabora semestralmente informe detallado sobre:\na) Gastos efectuados durante el semestre, así como de las partidas ya presupuestadas y pendientes de aplicar\nb) Cobranza.\nc) Pagos pendientes (comprometidos).\nd) Análisis comparativo de presupuesto aprobado contra presupuesto consumido.');
INSERT INTO `preguntas_puestos` VALUES ('696', 'CONTRALOR (NIVEL DIRECCIONES 2)', 'Mantiene una estrecha comunicación con el Vicerrector de Administración y Finanzas sobre los aspectos del cargo que influyen en el cumplimiento de la Misión de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('697', 'CONTRALOR (NIVEL DIRECCIONES 2)', 'Atiende y da opciones de resolución a los alumnos y padres de familia con complicaciones en sus obligaciones de pago.');
INSERT INTO `preguntas_puestos` VALUES ('698', 'CONTRALOR (NIVEL DIRECCIONES 2)', 'Revisa y controla todas las declaraciones gubernamentales (IMSS, ISPT, INFONAVIT, etc), cuentas y conciliaciones bancarias,cartera de cobranza y pólizas de cheques (semanal).');
INSERT INTO `preguntas_puestos` VALUES ('699', 'COORDINADOR GENERAL DE HUMANIDADES (DIRECCIONES 2)', 'Promueve activamente el desarrollo de nuestra misión e \"identidad católica\" dentro de la Institución y en especial dentro del personal de su área y alumnos.');
INSERT INTO `preguntas_puestos` VALUES ('700', 'COORDINADOR GENERAL DE HUMANIDADES (DIRECCIONES 2)', 'Integra de manera eficaz la formación humanística como elemento central de la educación universitaria.');
INSERT INTO `preguntas_puestos` VALUES ('701', 'COORDINADOR GENERAL DE HUMANIDADES (DIRECCIONES 2)', 'Coordina con la División de Universidades y directores de escuela el desarrollo de planes y programas para el logro de los fines institucionales en el área de formación humana.');
INSERT INTO `preguntas_puestos` VALUES ('702', 'COORDINADOR GENERAL DE HUMANIDADES (DIRECCIONES 2)', 'Desarrolla continuamente los programas y materiales de las materias del área de humanidades.');
INSERT INTO `preguntas_puestos` VALUES ('703', 'COORDINADOR GENERAL DE HUMANIDADES (DIRECCIONES 2)', 'Administra y coordina con eficiencia a los profesores del área:reclutamiento,asignación de grupos,evaluación, capacitación y desarrollo.');
INSERT INTO `preguntas_puestos` VALUES ('704', 'COORDINADOR GENERAL DE HUMANIDADES (DIRECCIONES 2)', 'Supervisa de manera continua la oferta académica de las materias y la calidad de las cátedras impartidas de su área.');
INSERT INTO `preguntas_puestos` VALUES ('705', 'COORDINADOR GENERAL DE HUMANIDADES (DIRECCIONES 2)', 'Evalúa el logro de los objetivos de las materias mediante la revisión de calificaciones y contenido de los exámenes.');
INSERT INTO `preguntas_puestos` VALUES ('706', 'COORDINADOR GENERAL DE HUMANIDADES (DIRECCIONES 2)', 'Mantiene relaciones de colaboración con escuelas afines de otras instituciones académicas de prestigio nacionales y extranjeras.');
INSERT INTO `preguntas_puestos` VALUES ('707', 'COORDINADOR GENERAL DE HUMANIDADES (DIRECCIONES 2)', 'Define líneas de investigación y asigna profesores de tiempo completo que determinen el alcance, tiempo y resultados esperados de la investigación.');
INSERT INTO `preguntas_puestos` VALUES ('708', 'COORDINADOR GENERAL DE HUMANIDADES (DIRECCIONES 2)', 'Promueve los programas de Posgrado y Educación Contínua entre egresados y organizaciones del área.');
INSERT INTO `preguntas_puestos` VALUES ('709', 'DIRECTOR DE PROGRAMAS DE POSGRADO Y EXTENSIÓN (NIVEL DIRECCIONES 2)', 'Alcanza las metas de crecimiento de la matrícula de posgrado que solicite la Institución de acuerdo al Plan de Mercadotécnia Estratégica que desarrollada anualmente.');
INSERT INTO `preguntas_puestos` VALUES ('710', 'DIRECTOR DE PROGRAMAS DE POSGRADO Y EXTENSIÓN (NIVEL DIRECCIONES 2)', 'Desarrolla y ejecuta un adecuado Programa de Atención a Empresas e Instituciones con potencial a convertirse en clientes.');
INSERT INTO `preguntas_puestos` VALUES ('711', 'DIRECTOR DE PROGRAMAS DE POSGRADO Y EXTENSIÓN (NIVEL DIRECCIONES 2)', 'Mantiene una estrecha comunicación con el Vicerrector de Académico, Directores de Escuela, Coordinadores de Posgrados y su personal acargo.');
INSERT INTO `preguntas_puestos` VALUES ('712', 'DIRECTOR DE PROGRAMAS DE POSGRADO Y EXTENSIÓN (NIVEL DIRECCIONES 2)', 'Busca la máxima calidad dentro del aula (calidad de los profesores, metódo de enseñanza, cumplimiento del programa, participación de los alumnos, innovación en las cátedras, etc)');
INSERT INTO `preguntas_puestos` VALUES ('713', 'DIRECTOR DE PROGRAMAS DE POSGRADO Y EXTENSIÓN (NIVEL DIRECCIONES 2)', 'Realiza adecuadamente la promoción hacia los Egresados, Empresas, Instituciones privadas y gubernamentales, etc.');
INSERT INTO `preguntas_puestos` VALUES ('714', 'DIRECTOR DE PROGRAMAS DE POSGRADO Y EXTENSIÓN (NIVEL DIRECCIONES 2)', 'Vigila la correcta integración de los expedientes de los alumnos para apoyarlos en su proceso de titulación.');
INSERT INTO `preguntas_puestos` VALUES ('715', 'DIRECTOR DE PROGRAMAS DE POSGRADO Y EXTENSIÓN (NIVEL DIRECCIONES 2)', 'Supervisa continuamente la calidad académica de los cursos ofrecidos en su programa.');
INSERT INTO `preguntas_puestos` VALUES ('716', 'DIRECTOR DE PROGRAMAS DE POSGRADO Y EXTENSIÓN (NIVEL DIRECCIONES 2)', 'Atiende y resuelve con actitud de servicio las necesidades y solicitudes de los estudiantes y docentes.');
INSERT INTO `preguntas_puestos` VALUES ('717', 'DIRECTOR DE PROGRAMAS DE POSGRADO Y EXTENSIÓN (NIVEL DIRECCIONES 2)', 'Promueve activamente el desarrollo de nuestra \"identidad católica\" especialmente en las actividades relacionadas con la formación humana y académica de los alumnos.');
INSERT INTO `preguntas_puestos` VALUES ('718', 'DIRECTOR DE PROGRAMAS DE POSGRADO Y EXTENSIÓN (NIVEL DIRECCIONES 2)', 'Revisa al término de cada período escolar los resultados arrojados por los procesos de evaluación docente, monitorea la calidad académica y alinea aspectos que sean necesarios.');
INSERT INTO `preguntas_puestos` VALUES ('719', 'COORDINADOR DE SERVICIOS DE TECNOLOGÍA', 'Coordina constantemente las actividades que mantienen actualizada la infraestructura tecnológica de cómputo, informática, comunicaciones y telecomunicacciones de la universidad.');
INSERT INTO `preguntas_puestos` VALUES ('720', 'COORDINADOR DE SERVICIOS DE TECNOLOGÍA', 'Proporciona el equipo tecnológico necesario para la operación eficiente de las salas de cómputo.');
INSERT INTO `preguntas_puestos` VALUES ('721', 'COORDINADOR DE SERVICIOS DE TECNOLOGÍA', 'Supervisa la adecuada prestración de servicios de soporte técnico tanto a áreas académicas como administrativas.');
INSERT INTO `preguntas_puestos` VALUES ('722', 'COORDINADOR DE SERVICIOS DE TECNOLOGÍA', 'Planea, administra y controla los recursos materiales que garantizan la máxima disponibilidad de servicios tecnológicos a la comunidad universitaria.');
INSERT INTO `preguntas_puestos` VALUES ('723', 'COORDINADOR DE SERVICIOS DE TECNOLOGÍA', 'Planea y administra los recursos humanos que garantizan un adecuado servicio a los alumnos.');
INSERT INTO `preguntas_puestos` VALUES ('724', 'COORDINADOR DE SERVICIOS DE TECNOLOGÍA', 'Elabora eficientemente y da seguimiento al presupuesto anual de operación del área.');
INSERT INTO `preguntas_puestos` VALUES ('725', 'COORDINADOR DE SERVICIOS DE TECNOLOGÍA', 'Implementa sistemas de información que agilicen los procesos acdémicos, administrativos y operativos de la Institución.');
INSERT INTO `preguntas_puestos` VALUES ('726', 'COORDINADOR DE SERVICIOS DE TECNOLOGÍA', 'Asesora a las diferentes áreas acerca de las mejores soluciones tecnológicas para su desarrollo.');
INSERT INTO `preguntas_puestos` VALUES ('727', 'COORDINADOR DE SERVICIOS DE TECNOLOGÍA', 'Supervisa la operación y mantenimiento eficiente de los servicios de telecomunicaciones y telefonía de la institución.');
INSERT INTO `preguntas_puestos` VALUES ('728', 'COORDINADOR DE SERVICIOS DE TECNOLOGÍA', 'Propone soluciones tecnológicas que optimicen los recursos universitarios y coadyuden al logro de un servicio eficiente.');
INSERT INTO `preguntas_puestos` VALUES ('729', 'DIRECTOR DE ADMINISTRACIÓN ESCOLAR Y NORMATIVIDAD     (NIVEL DIRECCIONES2)', 'Obtiene y controla eficientemente la información escolar de la universidad en relación a los planes de estudio y avance escolar del alumnado de licenciatura y posgrado.');
INSERT INTO `preguntas_puestos` VALUES ('730', 'DIRECTOR DE ADMINISTRACIÓN ESCOLAR Y NORMATIVIDAD     (NIVEL DIRECCIONES2)', 'Verifica adecuadamente la autenticidad de los documentos escolares que expide la institución.');
INSERT INTO `preguntas_puestos` VALUES ('731', 'DIRECTOR DE ADMINISTRACIÓN ESCOLAR Y NORMATIVIDAD     (NIVEL DIRECCIONES2)', 'Mantiene y coordina eficientemente las labores de servicios internos, externos y auditoria escolar.');
INSERT INTO `preguntas_puestos` VALUES ('732', 'DIRECTOR DE ADMINISTRACIÓN ESCOLAR Y NORMATIVIDAD     (NIVEL DIRECCIONES2)', 'Organiza, innova y mantiene actulizada la estructura, sistemas y procedimientos del trabajo del área: Servicios Internos, Externos y Auditoria Escolar.');
INSERT INTO `preguntas_puestos` VALUES ('733', 'DIRECTOR DE ADMINISTRACIÓN ESCOLAR Y NORMATIVIDAD     (NIVEL DIRECCIONES2)', 'Vigila el cumplimiento de las políticas y lineamientos establecidos por la Universidad para la certificación, acreditaciones, programas de estudio,etc.');
INSERT INTO `preguntas_puestos` VALUES ('734', 'DIRECTOR DE ADMINISTRACIÓN ESCOLAR Y NORMATIVIDAD     (NIVEL DIRECCIONES2)', 'Dirige el adecuado intercambio de información sobre datos y registros de estudiantes en las escuelas y facultades.');
INSERT INTO `preguntas_puestos` VALUES ('735', 'DIRECTOR DE ADMINISTRACIÓN ESCOLAR Y NORMATIVIDAD     (NIVEL DIRECCIONES2)', 'Proporciona en tiempo y forma a las instituciones oficiales la información requerida sobre la operación escolar de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('736', 'DIRECTOR DE ADMINISTRACIÓN ESCOLAR Y NORMATIVIDAD     (NIVEL DIRECCIONES2)', 'Mantiene una estrecha comunicación con el Director de Servicios Institucionales y Planeación sobre los aspectos del cargo que influyen directa o indirectamente en el cumplimiento de la Misión de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('737', 'DIRECTOR DE ADMINISTRACIÓN ESCOLAR Y NORMATIVIDAD     (NIVEL DIRECCIONES2)', 'Presenta a su Director y al Rector las estadísticas escolares y las requeridas por organismos oficiales y extraoficiales de manera contínua y oportuna.');
INSERT INTO `preguntas_puestos` VALUES ('738', 'DIRECTOR DE ADMINISTRACIÓN ESCOLAR Y NORMATIVIDAD     (NIVEL DIRECCIONES2)', 'Supervisa de manera eficiente el desempeño de las personas a su cargo.');
INSERT INTO `preguntas_puestos` VALUES ('739', 'COORDINADOR DE RELACIONES ACADÉMICAS (NIVEL MANDOS MEDIOS 1)', 'Constantemente logra convenios de intercambio con instituciones de enseñanza superior tanto a nivel nacional como internacional.');
INSERT INTO `preguntas_puestos` VALUES ('740', 'COORDINADOR DE RELACIONES ACADÉMICAS (NIVEL MANDOS MEDIOS 1)', 'Mantiene relaciones con instituciones privadas, sociales y públicas que promueven actividades académicas de intercambio a nivel licenciatura y posgrado.');
INSERT INTO `preguntas_puestos` VALUES ('741', 'COORDINADOR DE RELACIONES ACADÉMICAS (NIVEL MANDOS MEDIOS 1)', 'Participa en eventos culturales especialmente los convocados por embajadas y organizaciones internacionales logrando ampliar nuestras opciones de intercambio académico.');
INSERT INTO `preguntas_puestos` VALUES ('742', 'COORDINADOR DE RELACIONES ACADÉMICAS (NIVEL MANDOS MEDIOS 1)', 'Coordina eficientemente los procesos de equivalencias de estudios de los alumnos de intercambio con las diferentes escuelas y servicios escolares.');
INSERT INTO `preguntas_puestos` VALUES ('743', 'COORDINADOR DE RELACIONES ACADÉMICAS (NIVEL MANDOS MEDIOS 1)', 'Consolida los programas de intercambio académico existentes manteniendo la calidad y el prestigio logrado.');
INSERT INTO `preguntas_puestos` VALUES ('744', 'COORDINADOR DE RELACIONES ACADÉMICAS (NIVEL MANDOS MEDIOS 1)', 'Evalúa los resultados obtenidos en los programas de intercambio e implementa programas de mejoramiento a los procedimientos existentes.');
INSERT INTO `preguntas_puestos` VALUES ('745', 'COORDINADOR DE RELACIONES ACADÉMICAS (NIVEL MANDOS MEDIOS 1)', 'Se preocupa, promueve y se asegura de incrementar el número de estudiantes en intercambio académico internacional bidireccionalmente.');
INSERT INTO `preguntas_puestos` VALUES ('746', 'COORDINADOR DE RELACIONES ACADÉMICAS (NIVEL MANDOS MEDIOS 1)', 'Atiende satisfactoriamente y con un sistema personalizado a los visitantes externos y alumnos de intercambio internacional para que cumplan sus objetivos.');
INSERT INTO `preguntas_puestos` VALUES ('747', 'COORDINADOR DE RELACIONES ACADÉMICAS (NIVEL MANDOS MEDIOS 1)', 'Tiene el control y seguimiento adecuado de los alumnos que se encuentran de intercambio en otras universidades o en nuestra propia institución.');
INSERT INTO `preguntas_puestos` VALUES ('748', 'COORDINADOR DE RELACIONES ACADÉMICAS (NIVEL MANDOS MEDIOS 1)', 'Difunde y propicia un ambiente propositivo para que las instituciones con las que mantenemos intercambio nos perciban como una universidad de \"identidad católica\" que promueve los valores.');
INSERT INTO `preguntas_puestos` VALUES ('749', 'COORDINADOR DE PROGRAMAS DE LIDERAZGO (NIVEL MANDOS MEDIOS 1) : Vértice, Red Misión', 'Elabora el plan estratégico que asegure la permanencia del programa y el logro de los objetivos establecidos.');
INSERT INTO `preguntas_puestos` VALUES ('750', 'COORDINADOR DE PROGRAMAS DE LIDERAZGO (NIVEL MANDOS MEDIOS 1) : Vértice, Red Misión', 'Promueve el desarrollo de nuestra \"identidad católica\" especialmente en las actividades relacionadas con el programa de liderazgo que maneja.');
INSERT INTO `preguntas_puestos` VALUES ('751', 'COORDINADOR DE PROGRAMAS DE LIDERAZGO (NIVEL MANDOS MEDIOS 1) : Vértice, Red Misión', 'Busca y logra el apoyo de líderes positivos y de personalidades distinguidas en pro del beneficio social para la participación en algún evento y/o colaboración en especie para los proyectos.');
INSERT INTO `preguntas_puestos` VALUES ('752', 'COORDINADOR DE PROGRAMAS DE LIDERAZGO (NIVEL MANDOS MEDIOS 1) : Vértice, Red Misión', 'En conjunto con las áreas académicas selecciona e integra a los alumnos a programas de liderazgo.');
INSERT INTO `preguntas_puestos` VALUES ('753', 'COORDINADOR DE PROGRAMAS DE LIDERAZGO (NIVEL MANDOS MEDIOS 1) : Vértice, Red Misión', 'Apoya a la VFI y a la comunidad universeitaria en genral, en proyectos especiales de ayuda derivados de desastres naturales.');
INSERT INTO `preguntas_puestos` VALUES ('754', 'COORDINADOR DE PROGRAMAS DE LIDERAZGO (NIVEL MANDOS MEDIOS 1) : Vértice, Red Misión', 'Escucha y canaliza las iniciativas de los estudiantes a través de los comités establecidos.');
INSERT INTO `preguntas_puestos` VALUES ('755', 'COORDINADOR DE PROGRAMAS DE LIDERAZGO (NIVEL MANDOS MEDIOS 1) : Vértice, Red Misión', 'Organiza satisfactoriamente al grupo que asistirá a la Megamisión.');
INSERT INTO `preguntas_puestos` VALUES ('756', 'COORDINADOR DE PROGRAMAS DE LIDERAZGO (NIVEL MANDOS MEDIOS 1) : Vértice, Red Misión', 'Al término de cada actividad realiza una evaluación de los resultados obtenidos alineando aspectos que son necesarios.');
INSERT INTO `preguntas_puestos` VALUES ('757', 'COORDINADOR DE PROGRAMAS DE LIDERAZGO (NIVEL MANDOS MEDIOS 1) : Vértice, Red Misión', 'Coordina favorablemente las tutorías a los alumnos de vértice.');
INSERT INTO `preguntas_puestos` VALUES ('758', 'COORDINADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 1)', 'Elabora y controla el Plan de Desarrollo Estratégico del departamento.');
INSERT INTO `preguntas_puestos` VALUES ('759', 'COORDINADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 1)', 'De manera permanente planea y promueve encuentros deportivos internos que logran la asistencia planeada y fomentan la integración de grupos.');
INSERT INTO `preguntas_puestos` VALUES ('760', 'COORDINADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 1)', 'De manera permanente planea y promueve encuentros deportivos externos que logran la asistencia planeada y fomentan la integración de grupos.');
INSERT INTO `preguntas_puestos` VALUES ('761', 'COORDINADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 1)', 'Mantiene adecuadas relaciones con otras instituciones educativas y consejos deportivos.');
INSERT INTO `preguntas_puestos` VALUES ('762', 'COORDINADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 1)', 'Coordina y evalúa semestralmente al personal del área buscando su desarrollo y capacitación.');
INSERT INTO `preguntas_puestos` VALUES ('763', 'COORDINADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 1)', 'Supervisa y evalúa los resultados de las campañas informativas de los eventos deportivos en búsqueda de la mejora continua.');
INSERT INTO `preguntas_puestos` VALUES ('764', 'COORDINADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 1)', 'Vigila que las instalaciones y equipo para las actividades deportivas se conserven en estado óptimo de funcionamiento y uso.');
INSERT INTO `preguntas_puestos` VALUES ('765', 'COORDINADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 1)', 'Colabora de manera activa y frecuentemente con el programa de becarios, con los alumnos asignados al área de deportes.');
INSERT INTO `preguntas_puestos` VALUES ('766', 'COORDINADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 1)', 'Diseña e implementa programas y actividades que promuevan la participación deportiva de alumnos, profesores y colaboradores.');
INSERT INTO `preguntas_puestos` VALUES ('767', 'COORDINADOR DE SELECCIONES Y ACADEMIAS DEPORTIVAS (NIVEL MANDOS MEDIOS 1)', 'Coordina adecuadamente a los alumnos que realizan su servicio social dentro del área.');
INSERT INTO `preguntas_puestos` VALUES ('768', 'COORDINADOR DE OPERACIÓN DE  POSGRADOS Y EXTENSIÓN (NIVEL MANDOS MEDIOS 1)', 'Supervisa y coordina satisfactoriamente el área académica y administrativa de los programas a su cargo.');
INSERT INTO `preguntas_puestos` VALUES ('769', 'COORDINADOR DE OPERACIÓN DE  POSGRADOS Y EXTENSIÓN (NIVEL MANDOS MEDIOS 1)', 'Diseña y renueva el plan de estudios de los programas de posgrado y extensión de acuerdo a las necesidades del área.');
INSERT INTO `preguntas_puestos` VALUES ('770', 'COORDINADOR DE OPERACIÓN DE  POSGRADOS Y EXTENSIÓN (NIVEL MANDOS MEDIOS 1)', 'Supervisa eficazmente la contratación docente de acuerdo al nivel requerido y los tiempos establecidos.');
INSERT INTO `preguntas_puestos` VALUES ('771', 'COORDINADOR DE OPERACIÓN DE  POSGRADOS Y EXTENSIÓN (NIVEL MANDOS MEDIOS 1)', 'Realiza adecuadamente la promoción hacia los Egresados, Empresas, Instituciones privadas y gubernamentales, etc.');
INSERT INTO `preguntas_puestos` VALUES ('772', 'COORDINADOR DE OPERACIÓN DE  POSGRADOS Y EXTENSIÓN (NIVEL MANDOS MEDIOS 1)', 'Realiza en tiempo y forma la programación académica del área.');
INSERT INTO `preguntas_puestos` VALUES ('773', 'COORDINADOR DE OPERACIÓN DE  POSGRADOS Y EXTENSIÓN (NIVEL MANDOS MEDIOS 1)', 'Vigila la correcta integración de los expedientes de los alumnos para apoyarlos en su proceso de titulación.');
INSERT INTO `preguntas_puestos` VALUES ('774', 'COORDINADOR DE OPERACIÓN DE  POSGRADOS Y EXTENSIÓN (NIVEL MANDOS MEDIOS 1)', 'Supervisa continuamente la calidad académica de los cursos ofrecidos en su programa.');
INSERT INTO `preguntas_puestos` VALUES ('775', 'COORDINADOR DE OPERACIÓN DE  POSGRADOS Y EXTENSIÓN (NIVEL MANDOS MEDIOS 1)', 'Atiende con actitud de servicio las necesidades y solicitudes de los estudiantes y docentes.');
INSERT INTO `preguntas_puestos` VALUES ('776', 'COORDINADOR DE OPERACIÓN DE  POSGRADOS Y EXTENSIÓN (NIVEL MANDOS MEDIOS 1)', 'Promueve activamente el desarrollo de nuestra \"identidad católica\" especialmente en las actividades relacionadas con la formación humana y académica de los alumnos.');
INSERT INTO `preguntas_puestos` VALUES ('777', 'COORDINADOR DE OPERACIÓN DE  POSGRADOS Y EXTENSIÓN (NIVEL MANDOS MEDIOS 1)', 'Revisa al término de cada período escolar los resultados arrojados por los procesos de evaluación docente, monitorea la calidad académica y alinea aspectos que sean necesarios.');
INSERT INTO `preguntas_puestos` VALUES ('778', 'COORDINADOR DE OPERACIÓN DE LICENCIATURA (MANDOS MEDIOS 1)', 'Organiza,coordina y supervisa permanentemente la adecuada aplicación de los procedimientos establecidos en la ejecución de la operación académica.');
INSERT INTO `preguntas_puestos` VALUES ('779', 'COORDINADOR DE OPERACIÓN DE LICENCIATURA (MANDOS MEDIOS 1)', 'Cumple y hace cumplir las políticas y lineamientos definidos por superiores, así como el estatuto de la Universidad, su reglamento, planes y programas de trabajo y, en general, las dispocisiones y acuerdos que normen la estructura y funcionamiento de la universidad.');
INSERT INTO `preguntas_puestos` VALUES ('780', 'COORDINADOR DE OPERACIÓN DE LICENCIATURA (MANDOS MEDIOS 1)', 'Mantiene un registro actualizado de las actividades del personal académico que se llevan acabo en la Institución y coordina la aplicación de los exámenes departamentales.');
INSERT INTO `preguntas_puestos` VALUES ('781', 'COORDINADOR DE OPERACIÓN DE LICENCIATURA (MANDOS MEDIOS 1)', 'Se asegura de que la oferta académica de asignaturas sea la adecuada para la demanda de cursos de los estudiantes y acorde al avance de su plan de estudios.');
INSERT INTO `preguntas_puestos` VALUES ('782', 'COORDINADOR DE OPERACIÓN DE LICENCIATURA (MANDOS MEDIOS 1)', 'Analiza y propone soluciones a los alumnos que presentan problemas académicos.');
INSERT INTO `preguntas_puestos` VALUES ('783', 'COORDINADOR DE OPERACIÓN DE LICENCIATURA (MANDOS MEDIOS 1)', 'Apoya las labores de programación anual de cada dirección de escuela y verifica la correcta aplicación de los planes de estudio.');
INSERT INTO `preguntas_puestos` VALUES ('784', 'COORDINADOR DE OPERACIÓN DE LICENCIATURA (MANDOS MEDIOS 1)', 'Coordina la Operación Académica, negocia requerimientos con otros sectores de la institución, elabora alteraciones del sistema en orden al mejoramiento de la eficiencia de la labor académica.');
INSERT INTO `preguntas_puestos` VALUES ('785', 'COORDINADOR DE OPERACIÓN DE LICENCIATURA (MANDOS MEDIOS 1)', 'Optimiza la utilización de los espacios físicos y realiza reportes para su análisis.');
INSERT INTO `preguntas_puestos` VALUES ('786', 'COORDINADOR DE OPERACIÓN DE LICENCIATURA (MANDOS MEDIOS 1)', 'Apoya las labores de programación académica de todas las escuelas y verifica la correcta aplicación de los planes de estudio. Mantiene una abierta comunicación con las Escuelas.');
INSERT INTO `preguntas_puestos` VALUES ('787', 'COORDINADOR DE OPERACIÓN DE LICENCIATURA (MANDOS MEDIOS 1)', 'Apoya con eficiencia a la planeación y coordinación de eventos especiales y actividades de la licenciatura: Reconocimientos de excelencia académica, graduaciones, etc.');
INSERT INTO `preguntas_puestos` VALUES ('788', 'ASISTENTE EJECUTIVO DE RECTORÍA (NIVEL MANDOS MEDIOS 1)', 'Apoya al Rector en el desarrollo del Plan estratégico a corto, mediano y largo plazo.');
INSERT INTO `preguntas_puestos` VALUES ('789', 'ASISTENTE EJECUTIVO DE RECTORÍA (NIVEL MANDOS MEDIOS 1)', 'Apoya al Rector en el seguimiento a objetivos y proyectos buscando su cumplimiento de todas las áreas y vicerrectorías que dependen del Rector.');
INSERT INTO `preguntas_puestos` VALUES ('790', 'ASISTENTE EJECUTIVO DE RECTORÍA (NIVEL MANDOS MEDIOS 1)', 'Apoya al Rector en el presupuesto anual de operación de Rectoría y supervisa el presupuesto de las áreas de los departamentos que dependen del Rector.');
INSERT INTO `preguntas_puestos` VALUES ('791', 'ASISTENTE EJECUTIVO DE RECTORÍA (NIVEL MANDOS MEDIOS 1)', 'Atiende con actitud de servicio y continuamente a personas internas, alumnos, o padres de familia que requieren apoyo de la Rectoría.');
INSERT INTO `preguntas_puestos` VALUES ('792', 'ASISTENTE EJECUTIVO DE RECTORÍA (NIVEL MANDOS MEDIOS 1)', 'Da seguimiento a los asuntos, y en su caso, participa activamente haciendo propuestas de solución al Rector o a los responsables de las áreas.');
INSERT INTO `preguntas_puestos` VALUES ('793', 'ASISTENTE EJECUTIVO DE RECTORÍA (NIVEL MANDOS MEDIOS 1)', 'Participa en proyectos que el Rector encomiende, es proactivo y propositivo.');
INSERT INTO `preguntas_puestos` VALUES ('794', 'ASISTENTE EJECUTIVO DE RECTORÍA (NIVEL MANDOS MEDIOS 1)', 'Apoya con eficiencia al Rector en la organización de reuniones que involucren tanto autoridades de la Universidad como personalidades de instituciones hermanas, empresas o entidades gubernamentales.');
INSERT INTO `preguntas_puestos` VALUES ('795', 'ASISTENTE EJECUTIVO DE RECTORÍA (NIVEL MANDOS MEDIOS 1)', 'En general, facilita al Rector la operación de la dirección de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('796', 'ASISTENTE EJECUTIVO DE RECTORÍA (NIVEL MANDOS MEDIOS 1)', 'Apoya al Rector en la implementación, seguimiento y control de las iniciativas de la Red Anáhuac.');
INSERT INTO `preguntas_puestos` VALUES ('797', 'ASISTENTE EJECUTIVO DE RECTORÍA (NIVEL MANDOS MEDIOS 1)', 'Mantiene una estrecha comunicación con el Rector sobre todos los aspectos del cargo que influyen directa o indirectamente en el cumplimiento de la Misión de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('798', 'JEFE DE SERVICIOS ESCOLARES EXTERNOS (NIVEL MANDOS MEDIOS 1)', 'Realiza con eficiencia los trámites ordinarios que mantienen el reconocimiento de estudios ante las instituciones oficiales.');
INSERT INTO `preguntas_puestos` VALUES ('799', 'JEFE DE SERVICIOS ESCOLARES EXTERNOS (NIVEL MANDOS MEDIOS 1)', 'Prepara en los tiempos establecidos la información requerida sobre la operación escolar de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('800', 'JEFE DE SERVICIOS ESCOLARES EXTERNOS (NIVEL MANDOS MEDIOS 1)', 'Da fe sin valor oficial, de los documentos que no requieren legalización, en los tiempos y casos requeridos.');
INSERT INTO `preguntas_puestos` VALUES ('801', 'JEFE DE SERVICIOS ESCOLARES EXTERNOS (NIVEL MANDOS MEDIOS 1)', 'Realiza y supervisa los trámites de revalidación, legalización y registro de títulos, así como la obtención de cédulas profesionales en forma y tiempo.');
INSERT INTO `preguntas_puestos` VALUES ('802', 'JEFE DE SERVICIOS ESCOLARES EXTERNOS (NIVEL MANDOS MEDIOS 1)', 'Por indicaciones del Director de administración escolar y normatividad, representa dignamente a la Universidad ante las instituciones gubernamentales certificadoras para la obtención de documentos de alumnos y egresados.');
INSERT INTO `preguntas_puestos` VALUES ('803', 'JEFE DE SERVICIOS ESCOLARES EXTERNOS (NIVEL MANDOS MEDIOS 1)', 'Ejecuta eficientemente el proceso de certificados legalizados a la SEP.');
INSERT INTO `preguntas_puestos` VALUES ('804', 'JEFE DE SERVICIOS ESCOLARES EXTERNOS (NIVEL MANDOS MEDIOS 1)', 'Efectúa el adecuado control y seguimiento de estudiantes extranjeros sobre la obtención y refrendo de su documentación migratoria que les permite estudiar en la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('805', 'JEFE DE SERVICIOS ESCOLARES EXTERNOS (NIVEL MANDOS MEDIOS 1)', 'En coordinación con las escuelas y facultades, lleva acabo con eficiencia los procedimientos de baja por: voluntaria, falta de documentos, documentación falsa o por efectos disciplinarios de los alumnos.');
INSERT INTO `preguntas_puestos` VALUES ('806', 'JEFE DE SERVICIOS ESCOLARES EXTERNOS (NIVEL MANDOS MEDIOS 1)', 'Elabora, analiza y controla con eficiencia la información estadística que se genera en su área.');
INSERT INTO `preguntas_puestos` VALUES ('807', 'JEFE DE SERVICIOS ESCOLARES EXTERNOS (NIVEL MANDOS MEDIOS 1)', 'Atiende continuamente y con actitud de servicio los procesos de consulta sobre documentos de estudiantes que formulan diversas instancias nacionales e internacionales.');
INSERT INTO `preguntas_puestos` VALUES ('808', 'COORDINADOR DE CALIDAD ACADÉMICA (NIVEL MANDOS MEDIOS 1)', 'Investiga, Diseña y supervisa constantemente la calidad de los asuntos académicos relacionados con el proceso de enseñanza-aprendizaje.');
INSERT INTO `preguntas_puestos` VALUES ('809', 'COORDINADOR DE CALIDAD ACADÉMICA (NIVEL MANDOS MEDIOS 1)', 'Asegura la calidad de las funciones universitarias empleando sistemas de evaluación y monitoreo constantes, innovadores y confiables.');
INSERT INTO `preguntas_puestos` VALUES ('810', 'COORDINADOR DE CALIDAD ACADÉMICA (NIVEL MANDOS MEDIOS 1)', 'Diseña y administra satisfactoriamente los procesos de evaluación de alumnos, profesores y programas educativos.');
INSERT INTO `preguntas_puestos` VALUES ('811', 'COORDINADOR DE CALIDAD ACADÉMICA (NIVEL MANDOS MEDIOS 1)', 'Porpone con frecuencia políticas y procedimientos que mejoran la calidad de los servicios académicos.');
INSERT INTO `preguntas_puestos` VALUES ('812', 'COORDINADOR DE CALIDAD ACADÉMICA (NIVEL MANDOS MEDIOS 1)', 'Evalúa y reporta semestralmente los resultados sobre la calidad del aprendizaje por parte de los alumnos y de los servicios de apoyo académico. Propone acciones de mejora con respecto a los resultados.');
INSERT INTO `preguntas_puestos` VALUES ('813', 'COORDINADOR DE CALIDAD ACADÉMICA (NIVEL MANDOS MEDIOS 1)', 'Se preocupa, promueve y se asegura la puntualidad y asistencia de los docentes a sus asignaturas.');
INSERT INTO `preguntas_puestos` VALUES ('814', 'COORDINADOR DE CALIDAD ACADÉMICA (NIVEL MANDOS MEDIOS 1)', 'Desarrolla, implementa, da seguimiento y reporta trimestralmente los resultados de los indicadores clave de desempeño institucional. Realiza propuestas de acción para mejorarlos.');
INSERT INTO `preguntas_puestos` VALUES ('815', 'COORDINADOR DE CALIDAD ACADÉMICA (NIVEL MANDOS MEDIOS 1)', 'Coordina y da seguimiento al desarrollo de programas de intervención educativa conducentes a la mejora de la calidad de la docencia y del aprendizaje de los estudiantes.');
INSERT INTO `preguntas_puestos` VALUES ('816', 'COORDINADOR DE CALIDAD ACADÉMICA (NIVEL MANDOS MEDIOS 1)', 'Evalúa y retroalimenta cada semestre el plan rector de investigación de la universidad y reporta resultados a la Dirección.');
INSERT INTO `preguntas_puestos` VALUES ('817', 'COORDINADOR DE CALIDAD ACADÉMICA (NIVEL MANDOS MEDIOS 1)', 'Evalúa y retroalimenta cada semestre el plan de tutorías y reporta resultados a la Dirección.');
INSERT INTO `preguntas_puestos` VALUES ('818', 'COORDINADOR DE INVESTIGACIÓN (NIVEL MANDOS MEDIOS 1)', 'Dirige adecuadamente la elaboración, implantación y evaluación de programas de investigación de la institución de acuerdo a la misión, valores y características del entorno.');
INSERT INTO `preguntas_puestos` VALUES ('819', 'COORDINADOR DE INVESTIGACIÓN (NIVEL MANDOS MEDIOS 1)', 'Orienta al profesorado de la institución para el logro de niveles de excelencia en el campo de la investigación.');
INSERT INTO `preguntas_puestos` VALUES ('820', 'COORDINADOR DE INVESTIGACIÓN (NIVEL MANDOS MEDIOS 1)', 'Establece y mantiene relaciones con organismos nacionales e internacionales de acreditación.');
INSERT INTO `preguntas_puestos` VALUES ('821', 'COORDINADOR DE INVESTIGACIÓN (NIVEL MANDOS MEDIOS 1)', 'Participa constantemente en foros nacionales e internacionales en el campo de la educación superior representando dignamente a la Institución.');
INSERT INTO `preguntas_puestos` VALUES ('822', 'COORDINADOR DE INVESTIGACIÓN (NIVEL MANDOS MEDIOS 1)', 'Promueve la publicación de los resultados de las investigaciones realizadas vigilando que cumplan con los lineamientos de edición e imagen Institucional.');
INSERT INTO `preguntas_puestos` VALUES ('823', 'COORDINADOR DE INVESTIGACIÓN (NIVEL MANDOS MEDIOS 1)', 'Desarrolla diversas estrategias y actividades que impulsan la investigación y enriquecen la curricula que logran avances en el conocimiento.');
INSERT INTO `preguntas_puestos` VALUES ('824', 'COORDINADOR DE INVESTIGACIÓN (NIVEL MANDOS MEDIOS 1)', 'Mantiene un registro confiable y actualizado de los proyectos de investigación y da seguimiento a los avances obtenidos.');
INSERT INTO `preguntas_puestos` VALUES ('825', 'COORDINADOR DE INVESTIGACIÓN (NIVEL MANDOS MEDIOS 1)', 'Proporciona a las autoridades información objetiva y relevante sobre los resultados de la investigación y presenta indicadores de desempeño que permiten valorar los avances obtenidos.');
INSERT INTO `preguntas_puestos` VALUES ('826', 'COORDINADOR DE INVESTIGACIÓN (NIVEL MANDOS MEDIOS 1)', 'Estimula la participación activa de profesores y estudiantes en congresos, conferencias de carácter científico y tecnológico y asociaciones educativas y de apoyo a la investigación (CONACYT, FIMPES, ANUIES, NSF, entre otras).');
INSERT INTO `preguntas_puestos` VALUES ('827', 'COORDINADOR DE INVESTIGACIÓN (NIVEL MANDOS MEDIOS 1)', 'Establece y mantiene vínculos con medios editoriales logrando la publicación de trabajos de investigación.');
INSERT INTO `preguntas_puestos` VALUES ('828', 'JEFE DE ADMISIONES (NIVEL MANDOS MEDIOS 1)', 'Atiende con actitud de servicio a los candidatos de ingreso a la Institución a nivel licenciatura.');
INSERT INTO `preguntas_puestos` VALUES ('829', 'JEFE DE ADMISIONES (NIVEL MANDOS MEDIOS 1)', 'Está en contacto continuo con los asesores preuniversitarios dando seguimiento a candidatos o prospectos.');
INSERT INTO `preguntas_puestos` VALUES ('830', 'JEFE DE ADMISIONES (NIVEL MANDOS MEDIOS 1)', 'Recibe y procesa con eficiencia las solicitudes de admisión.');
INSERT INTO `preguntas_puestos` VALUES ('831', 'JEFE DE ADMISIONES (NIVEL MANDOS MEDIOS 1)', 'Aplica y analiza satisfactoriamente los resultados de las pruebas de aptitud académica,habilidades y psicológicas realizadas a los candidatos.');
INSERT INTO `preguntas_puestos` VALUES ('832', 'JEFE DE ADMISIONES (NIVEL MANDOS MEDIOS 1)', 'Integra en los tiempos establecidos la información de exámenes de habilidades y psicológicos en los formatos y sistemas correspondientes.');
INSERT INTO `preguntas_puestos` VALUES ('833', 'JEFE DE ADMISIONES (NIVEL MANDOS MEDIOS 1)', 'Evalúa la idoneidad del candidato, propone el ingreso e incorpora nuevo alumnado a la institución.');
INSERT INTO `preguntas_puestos` VALUES ('834', 'JEFE DE ADMISIONES (NIVEL MANDOS MEDIOS 1)', 'Aconseja asertivamente la autorización o rechazo de aspirantes y turna los casos especiales a las instancias correspondientes.');
INSERT INTO `preguntas_puestos` VALUES ('835', 'JEFE DE ADMISIONES (NIVEL MANDOS MEDIOS 1)', 'Informa en tiempo y forma a los candidatos la resolución universitaria.');
INSERT INTO `preguntas_puestos` VALUES ('836', 'JEFE DE ADMISIONES (NIVEL MANDOS MEDIOS 1)', 'Elabora estadísticas útiles del proceso de admisión y facilita la información a las escuelas y facultades, en los tiempos requeridos.');
INSERT INTO `preguntas_puestos` VALUES ('837', 'JEFE DE ADMISIONES (NIVEL MANDOS MEDIOS 1)', 'Genera reportes de información para la Dirección de atención preuniversitaria y mercadotecnia, en la forma y tiempos establecidos.');
INSERT INTO `preguntas_puestos` VALUES ('838', 'COORDINADOR DE TUTORÍAS Y APOYO ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Integra eficientemente los expedientes de los participantes del Programa de Complementación Académica (PCA).');
INSERT INTO `preguntas_puestos` VALUES ('839', 'COORDINADOR DE TUTORÍAS Y APOYO ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Recaba permanentemente información académica, personal y de desempeño con las diferentes fuentes de información.');
INSERT INTO `preguntas_puestos` VALUES ('840', 'COORDINADOR DE TUTORÍAS Y APOYO ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Da un seguimiento adecuado al desempeño de los participantes del PCA.');
INSERT INTO `preguntas_puestos` VALUES ('841', 'COORDINADOR DE TUTORÍAS Y APOYO ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Actualiza continuamente los resultados de las diferentes instancias evaluadoras de los participantes del PCA.');
INSERT INTO `preguntas_puestos` VALUES ('842', 'COORDINADOR DE TUTORÍAS Y APOYO ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Canaliza y da seguimiento a cada participante con el personal que le brindará la ayuda necesaria.');
INSERT INTO `preguntas_puestos` VALUES ('843', 'COORDINADOR DE TUTORÍAS Y APOYO ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Analiza detalladamente cada caso y conforma el equipo de personal adecuado para sus necesidades.');
INSERT INTO `preguntas_puestos` VALUES ('844', 'COORDINADOR DE TUTORÍAS Y APOYO ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Da seguimiento y hace propuestas a la evaluación del PCA.Da seguimiento y hace propuestas a la evaluación del PCA.');
INSERT INTO `preguntas_puestos` VALUES ('845', 'COORDINADOR DE TUTORÍAS Y APOYO ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Analiza los puntos detectados como áreas de oportunidad y fortalezas del programa, tomando las medidas pertinentes para mejores resultados.');
INSERT INTO `preguntas_puestos` VALUES ('846', 'COORDINADOR DE TUTORÍAS Y APOYO ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Genera las intervenciones que garantizan la mejora continua del PCA.');
INSERT INTO `preguntas_puestos` VALUES ('847', 'COORDINADOR DE TUTORÍAS Y APOYO ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Mantiene una estrecha y constante relación con sus alumnos tutoriales y equipo de trabajo.');
INSERT INTO `preguntas_puestos` VALUES ('848', 'COORDINADOR DEL CENTRO DE LENGUAS (NIVEL MANDOS MEDIOS 1)', 'Realiza en tiempo y forma la programación académica de cursos de idiomas y de bloque electivo.');
INSERT INTO `preguntas_puestos` VALUES ('849', 'COORDINADOR DEL CENTRO DE LENGUAS (NIVEL MANDOS MEDIOS 1)', 'Desarrolla con éxito las estrategias necesarias para lograr el crecimiento del área desde un punto de vista económico y comercial.');
INSERT INTO `preguntas_puestos` VALUES ('850', 'COORDINADOR DEL CENTRO DE LENGUAS (NIVEL MANDOS MEDIOS 1)', 'Prepara y promociona cursos de idiomas para los estudiantes cubriendo y manteniendo el número de alumnos requeridos por grupo.');
INSERT INTO `preguntas_puestos` VALUES ('851', 'COORDINADOR DEL CENTRO DE LENGUAS (NIVEL MANDOS MEDIOS 1)', 'Establece y da seguimiento continuo a las políticas que determinan si un alumno se considera aprobado en cierto idioma.');
INSERT INTO `preguntas_puestos` VALUES ('852', 'COORDINADOR DEL CENTRO DE LENGUAS (NIVEL MANDOS MEDIOS 1)', 'Crea y mantiene un archivo actualizado de todos los alumnos, así como de su situación escolar con respecto a los requisitos de idiomas.');
INSERT INTO `preguntas_puestos` VALUES ('853', 'COORDINADOR DEL CENTRO DE LENGUAS (NIVEL MANDOS MEDIOS 1)', 'Publica y hace del conocimiento del alumno el resultado de sus exámenes, dándoles una adecuada retroalimentación.');
INSERT INTO `preguntas_puestos` VALUES ('854', 'COORDINADOR DEL CENTRO DE LENGUAS (NIVEL MANDOS MEDIOS 1)', 'Investiga,desarrolla e implementa la capacitación y actualización necesaria para el personal docente.');
INSERT INTO `preguntas_puestos` VALUES ('855', 'COORDINADOR DEL CENTRO DE LENGUAS (NIVEL MANDOS MEDIOS 1)', 'Actualiza continuamente los programas a través de investigación y convenios con otras instituciones.');
INSERT INTO `preguntas_puestos` VALUES ('856', 'COORDINADOR DEL CENTRO DE LENGUAS (NIVEL MANDOS MEDIOS 1)', 'Supervisa e implementa el desarrollo de material didáctico y técnicas de enseñanza innovadoras para los cursos.');
INSERT INTO `preguntas_puestos` VALUES ('857', 'COORDINADOR DEL CENTRO DE LENGUAS (NIVEL MANDOS MEDIOS 1)', 'Previene la demanda de cursos de idiomas y asegura ofrecer los cursos demandados.');
INSERT INTO `preguntas_puestos` VALUES ('858', 'JEFE DE BIBLIOTECA (NIVEL MANDOS MEDIOS 1)', 'Promueve la utilización de tecnología de punta en la biblioteca.');
INSERT INTO `preguntas_puestos` VALUES ('859', 'JEFE DE BIBLIOTECA (NIVEL MANDOS MEDIOS 1)', 'Planea, programa y supervisa constantemente la integración de un acervo bibliográfico, audiovisual y los medios tecnológicos adecuados para su uso.');
INSERT INTO `preguntas_puestos` VALUES ('860', 'JEFE DE BIBLIOTECA (NIVEL MANDOS MEDIOS 1)', 'Implementa nuevos servicios que permiten agilizar el acceso a la información para el alumnado y usuarios de la biblioteca.');
INSERT INTO `preguntas_puestos` VALUES ('861', 'JEFE DE BIBLIOTECA (NIVEL MANDOS MEDIOS 1)', 'Promueve continua y satisfactorimante la utilización óptima de los recursos bibliográficos y audiovisuales, especialmente en las labores relacionadas con la docencia y la investigación.');
INSERT INTO `preguntas_puestos` VALUES ('862', 'JEFE DE BIBLIOTECA (NIVEL MANDOS MEDIOS 1)', 'Organiza cada inicio de período escolar actividades para informar a la comunidad universitaria sobre los recursos y servicios de la biblioteca.');
INSERT INTO `preguntas_puestos` VALUES ('863', 'JEFE DE BIBLIOTECA (NIVEL MANDOS MEDIOS 1)', 'Coordina en tiempo y forma las actividades de adquisiciones, procesos técnicos y servicios al público.');
INSERT INTO `preguntas_puestos` VALUES ('864', 'JEFE DE BIBLIOTECA (NIVEL MANDOS MEDIOS 1)', 'Supervisa eficientemente el desempeño de las personas a su cargo buscando su capacitación y desarrollo constante.');
INSERT INTO `preguntas_puestos` VALUES ('865', 'JEFE DE BIBLIOTECA (NIVEL MANDOS MEDIOS 1)', 'Lleva el adecuado control del uso de los recursos financieros que se han asignado a la biblioteca.');
INSERT INTO `preguntas_puestos` VALUES ('866', 'JEFE DE BIBLIOTECA (NIVEL MANDOS MEDIOS 1)', 'En forma conjunta con el Director del área, elabora el presupuesto anual de operación del área y presenta reportes periódicos de avance.');
INSERT INTO `preguntas_puestos` VALUES ('867', 'JEFE DE BIBLIOTECA (NIVEL MANDOS MEDIOS 1)', 'Mantiene una estrecha comunicación con el Director sobre todos los aspectos a su cargo que influyen directa o indirectamente en el cumplimiento de la misión de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('868', 'COORDINADOR DE VINCULACIÓN Y RECAUDACIÓN DE FONDOS (NIVEL MANDOS MEDIOS 1)', 'Promueve continua y dignamente a la Institución en los distintos sectores de la sociedad (egresados, industria, gobierno,etc) tanto nacional como internacional.');
INSERT INTO `preguntas_puestos` VALUES ('869', 'COORDINADOR DE VINCULACIÓN Y RECAUDACIÓN DE FONDOS (NIVEL MANDOS MEDIOS 1)', 'Recauda los fondos acordados en el presupuesto anual para el financiamiento del desarrollo de la Institución por mecanismos distintos a las colegiaturas.');
INSERT INTO `preguntas_puestos` VALUES ('870', 'COORDINADOR DE VINCULACIÓN Y RECAUDACIÓN DE FONDOS (NIVEL MANDOS MEDIOS 1)', 'Supervisa la correcta aplicación de los fondos destinados al desarrollo de la Institución de acuerdo a la asignación inicial.');
INSERT INTO `preguntas_puestos` VALUES ('871', 'COORDINADOR DE VINCULACIÓN Y RECAUDACIÓN DE FONDOS (NIVEL MANDOS MEDIOS 1)', 'Cuenta con una base de datos actualizada de los principales líderes y referencias nacionales e internacionales en los sectores de influencia.');
INSERT INTO `preguntas_puestos` VALUES ('872', 'COORDINADOR DE VINCULACIÓN Y RECAUDACIÓN DE FONDOS (NIVEL MANDOS MEDIOS 1)', 'Desarrolla acciones de promoción y presencia sistemática con la personalidades nacionales,en especial con los que son egresados o han mantenido contacto cercano con la institucion.');
INSERT INTO `preguntas_puestos` VALUES ('873', 'COORDINADOR DE VINCULACIÓN Y RECAUDACIÓN DE FONDOS (NIVEL MANDOS MEDIOS 1)', 'En conjunto con los responsables de las escuelas selecciona líderes que sean representativos de nuestros valores con el fin de poder incluirlos dentro de nuestro grupo de invitados y/o colaboradores.');
INSERT INTO `preguntas_puestos` VALUES ('874', 'COORDINADOR DE VINCULACIÓN Y RECAUDACIÓN DE FONDOS (NIVEL MANDOS MEDIOS 1)', 'Asegura la oportuna cobertura en los medios de comunicación masiva, de las visitas o eventos relevantes, que garantiza una presencia continua que identifica a la Institución como una sede de conocimeinto académico, científico y cultural.');
INSERT INTO `preguntas_puestos` VALUES ('875', 'COORDINADOR DE VINCULACIÓN Y RECAUDACIÓN DE FONDOS (NIVEL MANDOS MEDIOS 1)', 'Aprovecha contínumente las actividades tales como:inaguraciones, congresos, foros,etc., para invitar a líderes a nuestra Institución.');
INSERT INTO `preguntas_puestos` VALUES ('876', 'COORDINADOR DE VINCULACIÓN Y RECAUDACIÓN DE FONDOS (NIVEL MANDOS MEDIOS 1)', 'Representa a la Institución en los distintos sectores de la sociedad, y promueve su imagen, su oferta educativa y sus servicios.');
INSERT INTO `preguntas_puestos` VALUES ('877', 'GERENTE DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 1)', 'Impulsa y supervisa adecuadamente los procesos de búsqueda, selección y reclutamiento del personal académico y administrativo de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('878', 'GERENTE DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 1)', 'Implementa y desarrolla adecuadamente la inducción, capacitación y formación del personal de la UAM.');
INSERT INTO `preguntas_puestos` VALUES ('879', 'GERENTE DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 1)', 'Vela por el cumplimiento del perfil de puesto correspondiente de cada uno de los puestos.');
INSERT INTO `preguntas_puestos` VALUES ('880', 'GERENTE DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 1)', 'Se asegura constantemente de que el personal tenga una adecuada integración profesional y humana a la identidad y misión de la universidad.');
INSERT INTO `preguntas_puestos` VALUES ('881', 'GERENTE DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 1)', 'Vela por el cumplimiento de la estructura orgánico-funcional y hace propuestas cuando se requiere.');
INSERT INTO `preguntas_puestos` VALUES ('882', 'GERENTE DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 1)', 'Velar por el cumplimiento de la disciplina laboral de acuerdo a normas y criterios vigentes y hace propuestas cuando se requiere.');
INSERT INTO `preguntas_puestos` VALUES ('883', 'GERENTE DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 1)', 'Propone e implementa normas y políticas que rijen  las relaciones del personal de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('884', 'GERENTE DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 1)', 'Dirige y supervisa debidamente todas las actividades de apoyo al área de sueldos y salarios (elaboración de nóminas y pagos diversos). Realiza estudios comparativos de sueldos y compensaciones con otras universidades para proponer mejoras en las prestaciones del personal.');
INSERT INTO `preguntas_puestos` VALUES ('885', 'GERENTE DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 1)', 'Coordina el proceso de evaluaciones de desempeño, clima laboral y 360°,  etc, analizando los resultados y propone acciones de la mejora continua de del ambiente y la cultura organizacional.');
INSERT INTO `preguntas_puestos` VALUES ('886', 'GERENTE DE RECURSOS HUMANOS (NIVEL MANDOS MEDIOS 1)', 'Ejecuta todas las medidas necesarias para dar cumplimiento a las disposiciones oficiales y legales en materia laboral y de seguridad social y custodia la documentación correspondiente');
INSERT INTO `preguntas_puestos` VALUES ('887', 'JEFE DE SERVICIOS ESCOLARES INTERNOS Y AUDITORIA (NIVEL MANDOS MEDIOS 1)', 'Mantiene actualizada y en orden la base de datos de los alumnos a nivel licenciatura y posgrado, desde su ingreso hasta su egreso, resguardando los archivos de datos generales, inscripción e historia académica.');
INSERT INTO `preguntas_puestos` VALUES ('888', 'JEFE DE SERVICIOS ESCOLARES INTERNOS Y AUDITORIA (NIVEL MANDOS MEDIOS 1)', 'Controla y certifica que la información en la base de datos sea confiable y que se suministre de manera oportuna para facilitar los procesos, asi como mantiene el sistema mecanizado para el control de avance escolar de los alumnos.');
INSERT INTO `preguntas_puestos` VALUES ('889', 'JEFE DE SERVICIOS ESCOLARES INTERNOS Y AUDITORIA (NIVEL MANDOS MEDIOS 1)', 'Coordina con eficacia con las diferentes áreas de la Universidad la implementación de los sistemas integrales (SIU) en base a los lineamientos, políticas y tiempos establecidos.');
INSERT INTO `preguntas_puestos` VALUES ('890', 'JEFE DE SERVICIOS ESCOLARES INTERNOS Y AUDITORIA (NIVEL MANDOS MEDIOS 1)', 'Conoce la legislación universitaria y establece mecanismos que aseguran su cumplimiento.');
INSERT INTO `preguntas_puestos` VALUES ('891', 'JEFE DE SERVICIOS ESCOLARES INTERNOS Y AUDITORIA (NIVEL MANDOS MEDIOS 1)', 'Reporta a la Dirección de administración escolar y normatividad sobre cualquier irregularidad en el proceso escolar y de casos de estudiantes que requieran un tratamiento especial y realiza propuestas para su resolución.');
INSERT INTO `preguntas_puestos` VALUES ('892', 'JEFE DE SERVICIOS ESCOLARES INTERNOS Y AUDITORIA (NIVEL MANDOS MEDIOS 1)', 'Controla eficazmente el seguimiento de la entrega de documentos de alumnos de nuevo ingreso.');
INSERT INTO `preguntas_puestos` VALUES ('893', 'JEFE DE SERVICIOS ESCOLARES INTERNOS Y AUDITORIA (NIVEL MANDOS MEDIOS 1)', 'Coordina oportunamente la ejecución de las tareas de certificación de los estudios de alumnos de nivel licenciatura y posgrados.');
INSERT INTO `preguntas_puestos` VALUES ('894', 'JEFE DE SERVICIOS ESCOLARES INTERNOS Y AUDITORIA (NIVEL MANDOS MEDIOS 1)', 'Planea y dirige los procesos de inscripción y reinscripción de alumnos en cuanto a su fase de selección de cursos, de los periodos académicos.');
INSERT INTO `preguntas_puestos` VALUES ('895', 'JEFE DE SERVICIOS ESCOLARES INTERNOS Y AUDITORIA (NIVEL MANDOS MEDIOS 1)', 'Ejecuta en tiempo y forma el procedimiento institucional de Reingreso y Bajas voluntarias y administrativas de los estudiantes.');
INSERT INTO `preguntas_puestos` VALUES ('896', 'JEFE DE SERVICIOS ESCOLARES INTERNOS Y AUDITORIA (NIVEL MANDOS MEDIOS 1)', 'Elabora y controla con eficiencia la información estadística que se genera en su área.');
INSERT INTO `preguntas_puestos` VALUES ('897', 'JEFE DE SERVICIOS COMPUTACIONALES (NIVEL MANDOS MEDIOS 1)', 'Mantiene contacto directo y constante con los diversos usuarios de la Institución, analiza sus dificultades y realiza propuestas para la mejora continua del servicio.');
INSERT INTO `preguntas_puestos` VALUES ('898', 'JEFE DE SERVICIOS COMPUTACIONALES (NIVEL MANDOS MEDIOS 1)', 'Coordina y participa de manera constante en la definición e implementación de los diversos procesos y procedimientos de atención y servicio.');
INSERT INTO `preguntas_puestos` VALUES ('899', 'JEFE DE SERVICIOS COMPUTACIONALES (NIVEL MANDOS MEDIOS 1)', 'Reporta en tiempo y forma los avances de los diversos proyectos del área.');
INSERT INTO `preguntas_puestos` VALUES ('900', 'JEFE DE SERVICIOS COMPUTACIONALES (NIVEL MANDOS MEDIOS 1)', 'Coordina de forma permanente la instalación de los equipos que adquiera la institución y capacita al personal que hará uso de los mismos (computadoras,impresoras,scanner,etc).');
INSERT INTO `preguntas_puestos` VALUES ('901', 'JEFE DE SERVICIOS COMPUTACIONALES (NIVEL MANDOS MEDIOS 1)', 'Mantiene contacto permanente con las empresas proveedoras de equipo y gestiona garantías y procesos de mantenimiento.');
INSERT INTO `preguntas_puestos` VALUES ('902', 'JEFE DE SERVICIOS COMPUTACIONALES (NIVEL MANDOS MEDIOS 1)', 'Mantiene en óptimas condiciones los sistemas de información.');
INSERT INTO `preguntas_puestos` VALUES ('903', 'JEFE DE SERVICIOS COMPUTACIONALES (NIVEL MANDOS MEDIOS 1)', 'Brinda con actitud de servicio y de manera permanente el soporte necesario a los usuarios.');
INSERT INTO `preguntas_puestos` VALUES ('904', 'JEFE DE SERVICIOS COMPUTACIONALES (NIVEL MANDOS MEDIOS 1)', 'Implementa sistemas de información que agilizan los procedimientos académicos, administrativos y operativos de la Institución.');
INSERT INTO `preguntas_puestos` VALUES ('905', 'JEFE DE SERVICIOS COMPUTACIONALES (NIVEL MANDOS MEDIOS 1)', 'En coordinación con el área de infraestructura tecnológica crea y administra a los grupos y usuarios, establece los permisos, protege la información interna como externa, internet,etc, en el tiempo y calidad requerida.');
INSERT INTO `preguntas_puestos` VALUES ('906', 'JEFE DE SERVICIOS COMPUTACIONALES (NIVEL MANDOS MEDIOS 1)', 'En coordinación con el área de infraestructura tecnológica verifica semanalmente el antivirus, así como la actualización de los mismos.');
INSERT INTO `preguntas_puestos` VALUES ('907', 'JEFE DE INFRAESTRUCTURA TECNOLÓGICA (NIVEL MANDOS MEDIOS 1)', 'Supervisa constantemente que todos los servicios de cómputo ofrecidos a través de servidores centrales hacia el personal administrativo, académico y alumnos sean de excelente calidad y con tecnología de punta.');
INSERT INTO `preguntas_puestos` VALUES ('908', 'JEFE DE INFRAESTRUCTURA TECNOLÓGICA (NIVEL MANDOS MEDIOS 1)', 'Procura y fomenta una excelente comunicación entre su equipo de trabajo y una mejora constante en la prestación de servicios que ofrece su jefatura.');
INSERT INTO `preguntas_puestos` VALUES ('909', 'JEFE DE INFRAESTRUCTURA TECNOLÓGICA (NIVEL MANDOS MEDIOS 1)', 'Procura la entera satisfacción de todos los usuarios, promoviendo la comunicación constante y estando atento a sus necesidades.');
INSERT INTO `preguntas_puestos` VALUES ('910', 'JEFE DE INFRAESTRUCTURA TECNOLÓGICA (NIVEL MANDOS MEDIOS 1)', 'Protege permanentemente de ataques externos e internos a la red.');
INSERT INTO `preguntas_puestos` VALUES ('911', 'JEFE DE INFRAESTRUCTURA TECNOLÓGICA (NIVEL MANDOS MEDIOS 1)', 'Investiga y propone constamente sobre nuevas tecnologías y avances en el área de redes proponiendo mejoras.');
INSERT INTO `preguntas_puestos` VALUES ('912', 'JEFE DE INFRAESTRUCTURA TECNOLÓGICA (NIVEL MANDOS MEDIOS 1)', 'Instala nuevos servidores y efectúa pruebas y reparación de los mismos en caso de ser necesario con un enfoque de servicio al cliente indicado por la Institución.');
INSERT INTO `preguntas_puestos` VALUES ('913', 'JEFE DE INFRAESTRUCTURA TECNOLÓGICA (NIVEL MANDOS MEDIOS 1)', 'Lleva un adecuado y constante control y administración de los servicios de la página web de la Universidad,servicio de correo,control de impresión,etc.');
INSERT INTO `preguntas_puestos` VALUES ('914', 'JEFE DE INFRAESTRUCTURA TECNOLÓGICA (NIVEL MANDOS MEDIOS 1)', 'Monitorea y reporta el tráfico de la red contando con estadísticas que permitan conocer el performance de la misma y se asegura de la disponibilidad, accesibilidad, velocidad y usabilidad del servicio de internet.');
INSERT INTO `preguntas_puestos` VALUES ('915', 'JEFE DE INFRAESTRUCTURA TECNOLÓGICA (NIVEL MANDOS MEDIOS 1)', 'Apoya constantemente y con actitud de servicio a todas las áreas que lo requieren, en el mantenimiento y actualización de sus bases de datos.');
INSERT INTO `preguntas_puestos` VALUES ('916', 'JEFE DE INFRAESTRUCTURA TECNOLÓGICA (NIVEL MANDOS MEDIOS 1)', 'Coordina con eficiencia la configuración de los equipo inalámbricos de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('917', 'COORDINADOR DE DIFUSIÓN CULTURAL (NIVEL MANDOS MEDIOS 1)', 'Propone, coordina y supervisa con eficiencia eventos de integración que enriquezcan la vida estudiantil de la universidad.');
INSERT INTO `preguntas_puestos` VALUES ('918', 'COORDINADOR DE DIFUSIÓN CULTURAL (NIVEL MANDOS MEDIOS 1)', 'Establece adecuados canales de comunicación para escuchar a los estudiantes.');
INSERT INTO `preguntas_puestos` VALUES ('919', 'COORDINADOR DE DIFUSIÓN CULTURAL (NIVEL MANDOS MEDIOS 1)', 'Monitorea los resultados de los proyectos de integración vigentes y propone a las autoridades modificaciones y/o nuevos planes.');
INSERT INTO `preguntas_puestos` VALUES ('920', 'COORDINADOR DE DIFUSIÓN CULTURAL (NIVEL MANDOS MEDIOS 1)', 'Verifica de manera consistente que las autoridades y programas colaboren en la formación de los estudiantes.');
INSERT INTO `preguntas_puestos` VALUES ('921', 'COORDINADOR DE DIFUSIÓN CULTURAL (NIVEL MANDOS MEDIOS 1)', 'Evalúa sistemáticamente los logros formativos de los programas ofrecidos.');
INSERT INTO `preguntas_puestos` VALUES ('922', 'COORDINADOR DE DIFUSIÓN CULTURAL (NIVEL MANDOS MEDIOS 1)', 'Estructura programas culturales de formación así como organiza y ofrece eventos culturales de calidad para la Comunidad Universitaria.');
INSERT INTO `preguntas_puestos` VALUES ('923', 'COORDINADOR DE DIFUSIÓN CULTURAL (NIVEL MANDOS MEDIOS 1)', 'Establece y mantiene vínculos con organismos estatales, privados, embajadas y centros extranjeros de carácter cultural.');
INSERT INTO `preguntas_puestos` VALUES ('924', 'COORDINADOR DE DIFUSIÓN CULTURAL (NIVEL MANDOS MEDIOS 1)', 'Promueve actividades encaminadas al fortalecimiento de relaciones estudiales intrauniversitaria.');
INSERT INTO `preguntas_puestos` VALUES ('925', 'COORDINADOR DE DIFUSIÓN CULTURAL (NIVEL MANDOS MEDIOS 1)', 'Promueve eventos culturales externos de interés para el enriquecimiento de la Comunidad Universitaria.');
INSERT INTO `preguntas_puestos` VALUES ('926', 'COORDINADOR DE DIFUSIÓN CULTURAL (NIVEL MANDOS MEDIOS 1)', 'Coordina y apoya en los eventos de Bienvida así como en entrega de reconocimiento de alumnos.');
INSERT INTO `preguntas_puestos` VALUES ('927', 'COORDINACIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Cumple los lineamientos institucionales y de la RED en materia de: comunicación(interna y externa), promoción, manejo de imagen y mercadotecnia.');
INSERT INTO `preguntas_puestos` VALUES ('928', 'COORDINACIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Administra continuamente las estrategias de comunicación y mercadotecnia de acuerdo a las necesidades y objetivos de las áreas logrando cubrir ya sea el público interno y/ó externo.');
INSERT INTO `preguntas_puestos` VALUES ('929', 'COORDINACIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'De forma permanente vigila que todo lo relacionado a comunicación, medios y mercadotecnia se encuentre alineado a los lineamientos institucionales establecidos.');
INSERT INTO `preguntas_puestos` VALUES ('930', 'COORDINACIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Colabora activamente y mantiene relaciones con otras instituciones, organismos,agencias de publicidad,diseño y relaciones públicas.');
INSERT INTO `preguntas_puestos` VALUES ('931', 'COORDINACIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Vigila que la imagen de la Red Anáhuac se emplee de forma adecuada en todos los medios (escritos y electrónicos) asesorando adecuadamente a las áreas que desarrollen comunicaciónes internas.');
INSERT INTO `preguntas_puestos` VALUES ('932', 'COORDINACIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Apoya eficientemente a Divisiones,Escuelas y Facultades así como a áreas administrativas en la coordinación de campañas, eventos y programas especiales dirigidos a fomentar la imagen y las relaciones internas y externas de la institución.');
INSERT INTO `preguntas_puestos` VALUES ('933', 'COORDINACIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Publica periódicamente la información oficial de la Institución empleando los medios institucionales (internos, generales y para egresados) y cubriendo el mercado meta.');
INSERT INTO `preguntas_puestos` VALUES ('934', 'COORDINACIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Busca con frecuencia prestadores de servicios publicitarios e integra una cartera de proveedores confiables, que permiten utilizar productos y servicios de promoción y comunicación de calidad.');
INSERT INTO `preguntas_puestos` VALUES ('935', 'COORDINACIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Supervisa que las herramientas electrónicas empleadas para la comunicación tanto interna como extrena se encuentren a la vanguardia en tecnología y diseño visual.');
INSERT INTO `preguntas_puestos` VALUES ('936', 'COORDINACIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Da seguimiento a las relaciones con la prensa y los medios de comunicación el cual apoya la entrega de productos y servicios solicitados con la calidad y en los tiempos establecidos.');
INSERT INTO `preguntas_puestos` VALUES ('937', 'DIRECCIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Propicia una comunicación efectiva entre los sectores internos y externos de la Universidad para el logro de los objetivos institucionales.');
INSERT INTO `preguntas_puestos` VALUES ('938', 'DIRECCIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Administra continuamente las estrategias de comunicación y mercadotecnia de acuerdo a las necesidades y objetivos de las áreas logrando el impacto requerido.');
INSERT INTO `preguntas_puestos` VALUES ('939', 'DIRECCIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Vigila que todo lo competente a comunicación Medios y mercadotecnia se encuentre alineado a los lineamientos institucionales establecidos por la División de Universidades.');
INSERT INTO `preguntas_puestos` VALUES ('940', 'DIRECCIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Representa a la Universidad ante los medios de comunicación social en dependencia del Rector.');
INSERT INTO `preguntas_puestos` VALUES ('941', 'DIRECCIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Se asegura de cuidar la imagen de la Universidad en el exterior (página web, eventos, medios masivos de comunicación, etc).');
INSERT INTO `preguntas_puestos` VALUES ('942', 'DIRECCIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Mantiene una fuerte y productiva relación con todos los directivos de la Institución para apoyar proyectos de comunicación y mercadotecnia institucional.');
INSERT INTO `preguntas_puestos` VALUES ('943', 'DIRECCIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Colabora con firmas externas, relaciones públicas, diseños y comunicación para ejecutar estrategias y acciones.');
INSERT INTO `preguntas_puestos` VALUES ('944', 'DIRECCIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Asesora y coordina las estrategias específicas de los coordinadores del área buscando un adecuado desempeño.');
INSERT INTO `preguntas_puestos` VALUES ('945', 'DIRECCIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Busca continuamente tener presencia en medios que sumen a la buena imagen de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('946', 'DIRECCIÓN DE COMUNICACIÓN (NIVEL MANDOS MEDIOS 1)', 'Desarrolla y da seguimiento al Plan Estratégico y de Presupuesto del área a corto, mediano y largo plazo de acuerdo al Plan Estratégico de la Universidad asegurando su cumplimiento.');
INSERT INTO `preguntas_puestos` VALUES ('947', 'COORDINADOR DE PROGRAMA ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Realiza eficientemente todas las funciones de coordinación académica y administrativa del programa(s) a su cargo,promoviendo la misión y valores universitarios.');
INSERT INTO `preguntas_puestos` VALUES ('948', 'COORDINADOR DE PROGRAMA ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Se coordina adecuadamente con el Director del área en la selección y contratación del personal académico de acuerdo al perfil y en los tiempos establecidos.');
INSERT INTO `preguntas_puestos` VALUES ('949', 'COORDINADOR DE PROGRAMA ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Apoya constantemente las labores de promoción hacia los diversos públicos: preparatorias,egresados, empresas instituciones privadas y gubernamentales entre otros.');
INSERT INTO `preguntas_puestos` VALUES ('950', 'COORDINADOR DE PROGRAMA ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Supervisa continuamente la calidad de las cátedras impartidas alineando los planes y programas a lo establecido en la División o escuela.');
INSERT INTO `preguntas_puestos` VALUES ('951', 'COORDINADOR DE PROGRAMA ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Atiende continuamente y con actitud de servicio las necesidades de los estudiantes y docentes,proponiendo soluciones.');
INSERT INTO `preguntas_puestos` VALUES ('952', 'COORDINADOR DE PROGRAMA ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Apoya las tutorías y vigila de manera constante que se apliquen a alumnos que manifiestan alguna inquietud y a los que presentan bajo desempeño.');
INSERT INTO `preguntas_puestos` VALUES ('953', 'COORDINADOR DE PROGRAMA ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Revisa al término de cada período escolar los resultados arrojados por los procesos de evaluación docente para monitorear la calidad académica y alinear aspectos que sean necesarios.');
INSERT INTO `preguntas_puestos` VALUES ('954', 'COORDINADOR DE PROGRAMA ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Cuida de manera consistente de la óptima utilización de los recursos tanto humanos como materiales asignados a sus programas.');
INSERT INTO `preguntas_puestos` VALUES ('955', 'COORDINADOR DE PROGRAMA ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Cumple y hace cumplir las políticas y lineamientos definidos por los superiores y en general las disposiciones y acuerdos que normen la estructura y funcionamiento de la Universidad.');
INSERT INTO `preguntas_puestos` VALUES ('956', 'COORDINADOR DE PROGRAMA ACADÉMICO (NIVEL MANDOS MEDIOS 1)', 'Promueve de manera continua la integración efectiva del personal y de los alumnos.');

-- ----------------------------
-- Table structure for puestos
-- ----------------------------
DROP TABLE IF EXISTS `puestos`;
CREATE TABLE `puestos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `pkey` (`titulo`),
  KEY `puesid` (`codigo`),
  KEY `puesti` (`titulo`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of puestos
-- ----------------------------
INSERT INTO `puestos` VALUES ('3', 'Asesor de desarrollo humano');
INSERT INTO `puestos` VALUES ('4', 'Asesor preuniversitario');
INSERT INTO `puestos` VALUES ('5', 'Asistente académico');
INSERT INTO `puestos` VALUES ('6', 'Asistente Académico                     Asistente Académico                     Asistente Académico                     Asistente Académico                     Asistente Académico                     Asistente Académico                     Asistente Acadé');
INSERT INTO `puestos` VALUES ('7', 'Asistente de dirección');
INSERT INTO `puestos` VALUES ('8', 'Asistente de dirección                  Asistente de dirección                  Asistente de dirección                  Asistente de dirección                  Asistente de dirección                  Asistente de dirección                  Asistente de di');
INSERT INTO `puestos` VALUES ('9', 'Asistente ejecutivo de rectoría');
INSERT INTO `puestos` VALUES ('10', 'Auxiliar administrativo');
INSERT INTO `puestos` VALUES ('11', 'Auxiliar Contable');
INSERT INTO `puestos` VALUES ('12', 'Auxiliar de Biblioteca');
INSERT INTO `puestos` VALUES ('13', 'Auxiliar de Compras');
INSERT INTO `puestos` VALUES ('14', 'Auxiliar de laboratorio y/o taller');
INSERT INTO `puestos` VALUES ('15', 'Auxiliar de mantenimiento');
INSERT INTO `puestos` VALUES ('16', 'Auxiliar técnico');
INSERT INTO `puestos` VALUES ('17', 'Cajero');
INSERT INTO `puestos` VALUES ('18', 'Chofer mensajero');
INSERT INTO `puestos` VALUES ('19', 'Contralor');
INSERT INTO `puestos` VALUES ('20', 'Coordinador de atención a alumnos');
INSERT INTO `puestos` VALUES ('21', 'Coordinador de becas a alumnos');
INSERT INTO `puestos` VALUES ('22', 'Coordinador de Calidad Académica');
INSERT INTO `puestos` VALUES ('23', 'Coordinador de campos clínicos');
INSERT INTO `puestos` VALUES ('24', 'Coordinador de comunicación');
INSERT INTO `puestos` VALUES ('25', 'Coordinador de difusión cultural');
INSERT INTO `puestos` VALUES ('26', 'Coordinador de Formación Educativa y Apoyo Académico    Coordinador de Formación Educativa y Apoyo Académico    Coordinador de Formación Educativa y Apoyo Académico    Coordinador de Formación Educativa y Apoyo Académico    Coordinador de Formación Educat');
INSERT INTO `puestos` VALUES ('27', 'Coordinador de investigación');
INSERT INTO `puestos` VALUES ('28', 'Coordinador de operación de licenciatura');
INSERT INTO `puestos` VALUES ('29', 'Coordinador de posgrados');
INSERT INTO `puestos` VALUES ('30', 'Coordinador de posgrados  y extensión             Coordinador de posgrados  y extensión             Coordinador de posgrados  y extensión             Coordinador de posgrados  y extensión             Coordinador de posgrados  y extensión             Coord');
INSERT INTO `puestos` VALUES ('31', 'Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               Coordinador de posgrados y extensión               Coordinador de posgrados y extensión');
INSERT INTO `puestos` VALUES ('32', 'Coordinador de posgrados y extensión              Coordinador de posgrados y extensión              Coordinador de posgrados y extensión              Coordinador de posgrados y extensión              Coordinador de posgrados y extensión              Coord');
INSERT INTO `puestos` VALUES ('33', 'Coordinador de programa académico');
INSERT INTO `puestos` VALUES ('34', 'Coordinador de programas de liderazgo');
INSERT INTO `puestos` VALUES ('35', 'Coordinador de Programas Posgrado y Exte');
INSERT INTO `puestos` VALUES ('36', 'Coordinador de proyectos');
INSERT INTO `puestos` VALUES ('37', 'Coordinador de relaciones académicas');
INSERT INTO `puestos` VALUES ('38', 'Coordinador de selec y academias deporti');
INSERT INTO `puestos` VALUES ('39', 'Coordinador de Servicio y Acción Social');
INSERT INTO `puestos` VALUES ('40', 'Coordinador de servicios de tecnología');
INSERT INTO `puestos` VALUES ('41', 'Coordinador de tutorías y apoyo académic');
INSERT INTO `puestos` VALUES ('42', 'Coordinador de vinculación y recaud fond');
INSERT INTO `puestos` VALUES ('43', 'Coordinador del Centro de Lenguas       Coordinador del Centro de Lenguas       Coordinador del Centro de Lenguas       Coordinador del Centro de Lenguas');
INSERT INTO `puestos` VALUES ('44', 'Coordinador del programa');
INSERT INTO `puestos` VALUES ('45', 'Coordinador general de humanidades');
INSERT INTO `puestos` VALUES ('46', 'Director atención preuniversitaria y mer');
INSERT INTO `puestos` VALUES ('47', 'Director de administración escolar y nor');
INSERT INTO `puestos` VALUES ('48', 'Director de centro de investigación');
INSERT INTO `puestos` VALUES ('49', 'Director de desarrollo académico');
INSERT INTO `puestos` VALUES ('50', 'Director de desarrollo institucional');
INSERT INTO `puestos` VALUES ('51', 'Director de división académica');
INSERT INTO `puestos` VALUES ('52', 'Director de programa académico');
INSERT INTO `puestos` VALUES ('53', 'Director de programas de posgrado y exte');
INSERT INTO `puestos` VALUES ('54', 'Director de Servicios Institucionales y PlaneaciónDirector de Servicios Institucionales y PlaneaciónDirector de Servicios Institucionales y PlaneaciónDirector de Servicios Institucionales y PlaneaciónDirector de Servicios Institucionales y PlaneaciónDirec');
INSERT INTO `puestos` VALUES ('55', 'Diseñador');
INSERT INTO `puestos` VALUES ('56', 'Entrenador de Selecciones');
INSERT INTO `puestos` VALUES ('57', 'Especialista de atención a foráneos');
INSERT INTO `puestos` VALUES ('58', 'Especialista de certificación y titulaci');
INSERT INTO `puestos` VALUES ('59', 'Especialista de orientación vocacional');
INSERT INTO `puestos` VALUES ('60', 'Especialista de presupuestos');
INSERT INTO `puestos` VALUES ('61', 'Especialista de recursos humanos');
INSERT INTO `puestos` VALUES ('62', 'Especialista de soporte a sistemas');
INSERT INTO `puestos` VALUES ('63', 'Especialista en Desarrollo de Medios');
INSERT INTO `puestos` VALUES ('64', 'Especialista en diseño instruccional');
INSERT INTO `puestos` VALUES ('65', 'Especialista en página WEB');
INSERT INTO `puestos` VALUES ('66', 'Especialista en página WEB              Especialista en página WEB              Especialista en página WEB              Especialista en página WEB              Especialista en página WEB              Especialista en página WEB              Especialista en');
INSERT INTO `puestos` VALUES ('67', 'Gerente de recursos humanos');
INSERT INTO `puestos` VALUES ('68', 'Jardinero');
INSERT INTO `puestos` VALUES ('69', 'Jefe de admisiones');
INSERT INTO `puestos` VALUES ('70', 'Jefe de biblioteca');
INSERT INTO `puestos` VALUES ('71', 'Jefe de compras');
INSERT INTO `puestos` VALUES ('72', 'Jefe de Contabilidad');
INSERT INTO `puestos` VALUES ('73', 'Jefe de crédito y cobranza');
INSERT INTO `puestos` VALUES ('74', 'Jefe de infraestructura tecnológica');
INSERT INTO `puestos` VALUES ('75', 'Jefe de servicios computacionales');
INSERT INTO `puestos` VALUES ('76', 'Jefe de servicios escolares externos');
INSERT INTO `puestos` VALUES ('77', 'Jefe de servicios escolares intern y aud');
INSERT INTO `puestos` VALUES ('78', 'Jefe de servicios generales');
INSERT INTO `puestos` VALUES ('79', 'Operador de Conmutador');
INSERT INTO `puestos` VALUES ('80', 'Profesor universitario');
INSERT INTO `puestos` VALUES ('1', 'Rector');
INSERT INTO `puestos` VALUES ('81', 'Secretaria de depto.');
INSERT INTO `puestos` VALUES ('82', 'Secretario  de depto.');
INSERT INTO `puestos` VALUES ('83', 'Secretario (a) de la Dirección');
INSERT INTO `puestos` VALUES ('84', 'Secretario(a) de departamento');
INSERT INTO `puestos` VALUES ('85', 'Secretario(a) de rectoría');
INSERT INTO `puestos` VALUES ('86', 'Supervisor Administrativo');
INSERT INTO `puestos` VALUES ('87', 'Supervisor de servicios al público');
INSERT INTO `puestos` VALUES ('88', 'Técnico de laboratorio y/o taller');
INSERT INTO `puestos` VALUES ('89', 'Técnico de soporte');
INSERT INTO `puestos` VALUES ('2', 'Vicerector');
INSERT INTO `puestos` VALUES ('90', 'Vicerrector académico');

-- ----------------------------
-- Table structure for respuestas_autoevaluacion
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_autoevaluacion`;
CREATE TABLE `respuestas_autoevaluacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) DEFAULT '0' COMMENT '0: Jefe, 1: Autoevaluación',
  `empleado` int(11) DEFAULT '0' COMMENT '0: Evaluaciones, 1: Autoevaluaciones',
  `nivel` int(11) DEFAULT NULL,
  `fechaRegistro` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resev_key` (`evaluacion`,`empleado`) USING BTREE,
  KEY `respuestas_autoevaluacion_ibfk_2` (`empleado`),
  KEY `respuestas_autoevaluacion_ibfk_3` (`nivel`),
  CONSTRAINT `respuestas_autoevaluacion_ibfk_1` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respuestas_autoevaluacion_ibfk_2` FOREIGN KEY (`empleado`) REFERENCES `empleados` (`empleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respuestas_autoevaluacion_ibfk_3` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuestas_autoevaluacion
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_autoevaluacion_competencias
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_autoevaluacion_competencias`;
CREATE TABLE `respuestas_autoevaluacion_competencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `id_conducta` int(11) DEFAULT NULL,
  `id_valor` int(11) NOT NULL,
  `id_evaluacion_empleado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rescla` (`id`),
  UNIQUE KEY `resclacevkey` (`evaluacion`,`nivel`,`id_valor`,`id_conducta`,`id_evaluacion_empleado`) USING BTREE,
  KEY `resclacev` (`evaluacion`,`nivel`),
  KEY `rexclac_niv` (`nivel`),
  KEY `rexclac_val` (`id_valor`),
  KEY `rexclac_cond` (`id_conducta`),
  KEY `rec5` (`id_evaluacion_empleado`),
  CONSTRAINT `respuestas_autoevaluacion_competencias_ibfk_1` FOREIGN KEY (`id_conducta`) REFERENCES `cuestionarios_competencias_secciones_conductas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respuestas_autoevaluacion_competencias_ibfk_2` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respuestas_autoevaluacion_competencias_ibfk_3` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respuestas_autoevaluacion_competencias_ibfk_4` FOREIGN KEY (`id_valor`) REFERENCES `cuestionarios_competencias_secciones_valores_posibles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respuestas_autoevaluacion_competencias_ibfk_5` FOREIGN KEY (`id_evaluacion_empleado`) REFERENCES `respuestas_autoevaluacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Los valores numéricos no se guardan.\r\nEn cambio se almacenan los IDS de los "valores posibles" según la conducta para un nivel específico.\r\nPara obtener el valor se debe refenciar a:\r\ncuestionarios_competencias_secciones_valores_posibles > cuestionarios_valores_posibles.\r\nEs ahí donde se contiene el valor numérico.';

-- ----------------------------
-- Records of respuestas_autoevaluacion_competencias
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_autoevaluacion_manual_abierto
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_autoevaluacion_manual_abierto`;
CREATE TABLE `respuestas_autoevaluacion_manual_abierto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `id_manual_input_pregunta` int(11) NOT NULL,
  `id_evaluacion_empleado` int(11) DEFAULT NULL,
  `indice` int(11) NOT NULL COMMENT 'Uno por cada "cantidad" de respuestas posibles. Comienza en 0.',
  `valor` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rescla` (`id`),
  UNIQUE KEY `reackeys` (`evaluacion`,`nivel`,`id_manual_input_pregunta`,`indice`),
  KEY `recma_niv` (`nivel`),
  KEY `recma_preg` (`id_manual_input_pregunta`),
  KEY `rema5` (`id_evaluacion_empleado`),
  CONSTRAINT `rama1` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rama2` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rama3` FOREIGN KEY (`id_manual_input_pregunta`) REFERENCES `cuestionarios_manual_input_preguntas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rama4` FOREIGN KEY (`id_evaluacion_empleado`) REFERENCES `respuestas_autoevaluacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuestas_autoevaluacion_manual_abierto
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_autoevaluacion_manual_opciones
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_autoevaluacion_manual_opciones`;
CREATE TABLE `respuestas_autoevaluacion_manual_opciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `id_opcion_respuesta` int(11) NOT NULL,
  `id_opciones_input_manual` int(11) NOT NULL,
  `id_evaluacion_empleado` int(11) DEFAULT NULL,
  `valor_manual` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rescla` (`id`),
  UNIQUE KEY `reackeys` (`evaluacion`,`nivel`,`id_opciones_input_manual`,`id_opcion_respuesta`),
  KEY `recma_niv` (`nivel`),
  KEY `recma_res` (`id_opcion_respuesta`) USING BTREE,
  KEY `recmm_preg` (`id_opciones_input_manual`),
  KEY `remo5` (`id_evaluacion_empleado`),
  CONSTRAINT `ramo1` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ramo2` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ramo3` FOREIGN KEY (`id_opcion_respuesta`) REFERENCES `cuestionarios_manual_input_preguntas_opciones_respuestas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ramo4` FOREIGN KEY (`id_opciones_input_manual`) REFERENCES `cuestionarios_manual_input_preguntas_opciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ramo5` FOREIGN KEY (`id_evaluacion_empleado`) REFERENCES `respuestas_autoevaluacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuestas_autoevaluacion_manual_opciones
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_clave_competencias_niveles
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_clave_competencias_niveles`;
CREATE TABLE `respuestas_clave_competencias_niveles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `id_conducta` int(11) DEFAULT NULL,
  `id_valor` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rescla` (`id`),
  UNIQUE KEY `resclacevkey` (`evaluacion`,`nivel`,`id_valor`,`id_conducta`) USING BTREE,
  KEY `resclacev` (`evaluacion`,`nivel`),
  KEY `rexclac_niv` (`nivel`),
  KEY `rexclac_val` (`id_valor`),
  KEY `rexclac_cond` (`id_conducta`),
  CONSTRAINT `rexclac_cond` FOREIGN KEY (`id_conducta`) REFERENCES `cuestionarios_competencias_secciones_conductas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rexclac_ev` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rexclac_niv` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rexclac_val` FOREIGN KEY (`id_valor`) REFERENCES `cuestionarios_competencias_secciones_valores_posibles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='Los valores numéricos no se guardan.\r\nEn cambio se almacenan los IDS de los "valores posibles" según la conducta para un nivel específico.\r\nPara obtener el valor se debe refenciar a:\r\ncuestionarios_competencias_secciones_valores_posibles > cuestionarios_valores_posibles.\r\nEs ahí donde se contiene el valor numérico.';

-- ----------------------------
-- Records of respuestas_clave_competencias_niveles
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_clave_competencias_puestos
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_clave_competencias_puestos`;
CREATE TABLE `respuestas_clave_competencias_puestos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `id_conducta` int(11) DEFAULT NULL,
  `id_valor` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rescla` (`id`),
  UNIQUE KEY `resclacevkey` (`evaluacion`,`nivel`,`id_valor`,`id_conducta`) USING BTREE,
  KEY `resclacev` (`evaluacion`,`nivel`),
  KEY `rexclac_niv` (`nivel`),
  KEY `rexclac_val` (`id_valor`),
  KEY `rexclac_cond` (`id_conducta`),
  CONSTRAINT `rccp1` FOREIGN KEY (`id_conducta`) REFERENCES `cuestionarios_competencias_secciones_conductas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rccp2` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rccp3` FOREIGN KEY (`nivel`) REFERENCES `puestos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rccp4` FOREIGN KEY (`id_valor`) REFERENCES `cuestionarios_competencias_secciones_valores_posibles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='Los valores numéricos no se guardan.\r\nEn cambio se almacenan los IDS de los "valores posibles" según la conducta para un nivel específico.\r\nPara obtener el valor se debe refenciar a:\r\ncuestionarios_competencias_secciones_valores_posibles > cuestionarios_valores_posibles.\r\nEs ahí donde se contiene el valor numérico.';

-- ----------------------------
-- Records of respuestas_clave_competencias_puestos
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_clave_historico_niveles
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_clave_historico_niveles`;
CREATE TABLE `respuestas_clave_historico_niveles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) DEFAULT NULL,
  `nivel` int(11) DEFAULT NULL,
  `usuarioRegistrante` varchar(255) DEFAULT NULL,
  `fechaRegistro` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rechkey` (`id`),
  KEY `rechinf` (`id`,`evaluacion`,`nivel`,`usuarioRegistrante`),
  KEY `respch_ev` (`evaluacion`),
  KEY `respch_niv` (`nivel`),
  KEY `respch_usu` (`usuarioRegistrante`),
  CONSTRAINT `respch_ev` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respch_niv` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respch_usu` FOREIGN KEY (`usuarioRegistrante`) REFERENCES `usuarios` (`usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuestas_clave_historico_niveles
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_clave_historico_puestos
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_clave_historico_puestos`;
CREATE TABLE `respuestas_clave_historico_puestos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) DEFAULT NULL,
  `puesto` int(11) DEFAULT NULL,
  `usuarioRegistrante` varchar(255) DEFAULT NULL,
  `fechaRegistro` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rechkey` (`id`),
  KEY `rechinf` (`id`,`evaluacion`,`puesto`,`usuarioRegistrante`),
  KEY `respch_ev` (`evaluacion`),
  KEY `respch_niv` (`puesto`),
  KEY `respch_usu` (`usuarioRegistrante`),
  CONSTRAINT `respuestas_clave_historico_puestos_ibfk_1` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respuestas_clave_historico_puestos_ibfk_2` FOREIGN KEY (`puesto`) REFERENCES `puestos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respuestas_clave_historico_puestos_ibfk_3` FOREIGN KEY (`usuarioRegistrante`) REFERENCES `usuarios` (`usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuestas_clave_historico_puestos
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_clave_manual_abierto
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_clave_manual_abierto`;
CREATE TABLE `respuestas_clave_manual_abierto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `id_manual_input_pregunta` int(11) NOT NULL,
  `indice` int(11) NOT NULL COMMENT 'Uno por cada "cantidad" de respuestas posibles. Comienza en 0.',
  `valor` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rescla` (`id`),
  UNIQUE KEY `reackeys` (`evaluacion`,`nivel`,`id_manual_input_pregunta`,`indice`),
  KEY `recma_niv` (`nivel`),
  KEY `recma_preg` (`id_manual_input_pregunta`),
  CONSTRAINT `recma_ev` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recma_niv` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recma_preg` FOREIGN KEY (`id_manual_input_pregunta`) REFERENCES `cuestionarios_manual_input_preguntas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuestas_clave_manual_abierto
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_clave_manual_opciones
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_clave_manual_opciones`;
CREATE TABLE `respuestas_clave_manual_opciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `id_opcion_respuesta` int(11) NOT NULL,
  `id_opciones_input_manual` int(11) NOT NULL,
  `valor_manual` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rescla` (`id`),
  UNIQUE KEY `reackeys` (`evaluacion`,`nivel`,`id_opciones_input_manual`,`id_opcion_respuesta`),
  KEY `recma_niv` (`nivel`),
  KEY `recma_res` (`id_opcion_respuesta`) USING BTREE,
  KEY `recmm_preg` (`id_opciones_input_manual`),
  CONSTRAINT `recmm_ec` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recmm_niv` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recmm_opc` FOREIGN KEY (`id_opcion_respuesta`) REFERENCES `cuestionarios_manual_input_preguntas_opciones_respuestas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recmm_preg` FOREIGN KEY (`id_opciones_input_manual`) REFERENCES `cuestionarios_manual_input_preguntas_opciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuestas_clave_manual_opciones
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_evaluacion
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_evaluacion`;
CREATE TABLE `respuestas_evaluacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) DEFAULT '0' COMMENT '0: Jefe, 1: Autoevaluación',
  `evaluador` int(11) DEFAULT '0' COMMENT '0: Evaluaciones, 1: Autoevaluaciones',
  `evaluadosTotales` int(11) DEFAULT '0',
  `avance` int(11) DEFAULT '0',
  `fechaRegistro` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resev_key` (`evaluacion`,`evaluador`,`evaluadosTotales`),
  KEY `resev_ev` (`evaluacion`) USING BTREE,
  KEY `resev_indexes` (`id`,`evaluacion`,`evaluador`) USING BTREE,
  KEY `resev` (`evaluador`) USING BTREE,
  CONSTRAINT `respev1` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respev2` FOREIGN KEY (`evaluador`) REFERENCES `empleados` (`empleado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuestas_evaluacion
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_evaluacion_competencias
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_evaluacion_competencias`;
CREATE TABLE `respuestas_evaluacion_competencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `id_conducta` int(11) DEFAULT NULL,
  `id_valor` int(11) NOT NULL,
  `id_evaluacion_empleado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rescla` (`id`),
  UNIQUE KEY `resclacevkey` (`evaluacion`,`nivel`,`id_valor`,`id_conducta`,`id_evaluacion_empleado`) USING BTREE,
  KEY `resclacev` (`evaluacion`,`nivel`),
  KEY `rexclac_niv` (`nivel`),
  KEY `rexclac_val` (`id_valor`),
  KEY `rexclac_cond` (`id_conducta`),
  KEY `rec5` (`id_evaluacion_empleado`),
  CONSTRAINT `rec1` FOREIGN KEY (`id_conducta`) REFERENCES `cuestionarios_competencias_secciones_conductas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rec2` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rec3` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rec4` FOREIGN KEY (`id_valor`) REFERENCES `cuestionarios_competencias_secciones_valores_posibles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rec5` FOREIGN KEY (`id_evaluacion_empleado`) REFERENCES `respuestas_evaluacion_empleados` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8 COMMENT='Los valores numéricos no se guardan.\r\nEn cambio se almacenan los IDS de los "valores posibles" según la conducta para un nivel específico.\r\nPara obtener el valor se debe refenciar a:\r\ncuestionarios_competencias_secciones_valores_posibles > cuestionarios_valores_posibles.\r\nEs ahí donde se contiene el valor numérico.';

-- ----------------------------
-- Records of respuestas_evaluacion_competencias
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_evaluacion_empleados
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_evaluacion_empleados`;
CREATE TABLE `respuestas_evaluacion_empleados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) DEFAULT NULL,
  `evaluador` int(11) DEFAULT NULL,
  `empleado` int(11) DEFAULT NULL,
  `id_respuestas_evaluacion` int(11) DEFAULT NULL,
  `fechaRegistro` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reejefe` (`evaluador`),
  KEY `reesubo` (`empleado`),
  KEY `reeev` (`evaluacion`,`id`) USING BTREE,
  KEY `reesubore` (`id_respuestas_evaluacion`),
  CONSTRAINT `reeev` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reejefe` FOREIGN KEY (`evaluador`) REFERENCES `jerarquias` (`jefe`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reesubo` FOREIGN KEY (`empleado`) REFERENCES `jerarquias` (`subordinado`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reesubore` FOREIGN KEY (`id_respuestas_evaluacion`) REFERENCES `respuestas_evaluacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuestas_evaluacion_empleados
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_evaluacion_manual_abierto
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_evaluacion_manual_abierto`;
CREATE TABLE `respuestas_evaluacion_manual_abierto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `id_manual_input_pregunta` int(11) NOT NULL,
  `id_evaluacion_empleado` int(11) DEFAULT NULL,
  `indice` int(11) NOT NULL COMMENT 'Uno por cada "cantidad" de respuestas posibles. Comienza en 0.',
  `valor` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rescla` (`id`),
  UNIQUE KEY `reackeys` (`evaluacion`,`nivel`,`id_manual_input_pregunta`,`indice`),
  KEY `recma_niv` (`nivel`),
  KEY `recma_preg` (`id_manual_input_pregunta`),
  KEY `rema5` (`id_evaluacion_empleado`),
  CONSTRAINT `rema1` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rema2` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rema3` FOREIGN KEY (`id_manual_input_pregunta`) REFERENCES `cuestionarios_manual_input_preguntas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rema5` FOREIGN KEY (`id_evaluacion_empleado`) REFERENCES `respuestas_evaluacion_empleados` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuestas_evaluacion_manual_abierto
-- ----------------------------

-- ----------------------------
-- Table structure for respuestas_evaluacion_manual_opciones
-- ----------------------------
DROP TABLE IF EXISTS `respuestas_evaluacion_manual_opciones`;
CREATE TABLE `respuestas_evaluacion_manual_opciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `id_opcion_respuesta` int(11) NOT NULL,
  `id_opciones_input_manual` int(11) NOT NULL,
  `id_evaluacion_empleado` int(11) DEFAULT NULL,
  `valor_manual` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rescla` (`id`),
  UNIQUE KEY `reackeys` (`evaluacion`,`nivel`,`id_opciones_input_manual`,`id_opcion_respuesta`),
  KEY `recma_niv` (`nivel`),
  KEY `recma_res` (`id_opcion_respuesta`) USING BTREE,
  KEY `recmm_preg` (`id_opciones_input_manual`),
  KEY `remo5` (`id_evaluacion_empleado`),
  CONSTRAINT `remo1` FOREIGN KEY (`evaluacion`) REFERENCES `evaluaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `remo2` FOREIGN KEY (`nivel`) REFERENCES `niveles` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `remo3` FOREIGN KEY (`id_opcion_respuesta`) REFERENCES `cuestionarios_manual_input_preguntas_opciones_respuestas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `remo4` FOREIGN KEY (`id_opciones_input_manual`) REFERENCES `cuestionarios_manual_input_preguntas_opciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `remo5` FOREIGN KEY (`id_evaluacion_empleado`) REFERENCES `respuestas_evaluacion_empleados` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuestas_evaluacion_manual_opciones
-- ----------------------------

-- ----------------------------
-- Table structure for usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `usuario` varchar(255) NOT NULL DEFAULT '',
  `pass` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fechaRegistro` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '1' COMMENT '0: Inactivo, 1: Activo, 2: Eliminado',
  PRIMARY KEY (`usuario`),
  KEY `user_user` (`usuario`),
  KEY `user_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catálogo de usuarios';

-- ----------------------------
-- Records of usuarios
-- ----------------------------
INSERT INTO `usuarios` VALUES ('admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'Administrador de sistema', 'admin@bcore.com.mx', '2015-09-07 20:58:33', '0');

-- ----------------------------
-- View structure for empleados_formato
-- ----------------------------
DROP VIEW IF EXISTS `empleados_formato`;
CREATE VIEW `empleados_formato` AS select `e`.`empleado` AS `empleado`,concat(ifnull(`e`.`nombre`,''),' ',ifnull(`e`.`apellido_paterno`,''),' ',ifnull(`e`.`apellido_materno`,'')) AS `n`,`e`.`nombre` AS `nombre`,`e`.`apellido_paterno` AS `apellido_paterno`,`e`.`apellido_materno` AS `apellido_materno`,`e`.`departamento` AS `departamento`,`d`.`titulo` AS `departamento_n`,`e`.`puesto` AS `puesto`,`p`.`titulo` AS `puesto_n`,`e`.`area` AS `area`,`a`.`titulo` AS `area_n`,`e`.`nivel` AS `nivel`,`niveles`.`titulo` AS `nivel_n`,`e`.`email` AS `email`,`e`.`fechaRegistro` AS `fechaRegistro`,`e`.`status` AS `status` from ((((`empleados` `e` join `departamentos` `d` on((`e`.`departamento` = `d`.`codigo`))) join `puestos` `p` on((`e`.`puesto` = `p`.`codigo`))) join `areas` `a` on((`e`.`area` = `a`.`codigo`))) join `niveles` on((`e`.`nivel` = `niveles`.`codigo`))) ;

-- ----------------------------
-- View structure for subordinados
-- ----------------------------
DROP VIEW IF EXISTS `subordinados`;
CREATE VIEW `subordinados` AS select `j`.`evaluacion` AS `evaluacion`,`j`.`jefe` AS `jefe`,`e`.`empleado` AS `empleado`,`e`.`n` AS `n`,`e`.`nombre` AS `nombre`,`e`.`apellido_paterno` AS `apellido_paterno`,`e`.`apellido_materno` AS `apellido_materno`,`e`.`departamento` AS `departamento`,`e`.`departamento_n` AS `departamento_n`,`e`.`puesto` AS `puesto`,`e`.`puesto_n` AS `puesto_n`,`e`.`area` AS `area`,`e`.`area_n` AS `area_n`,`e`.`nivel` AS `nivel`,`e`.`nivel_n` AS `nivel_n`,`e`.`email` AS `email`,`e`.`fechaRegistro` AS `fechaRegistro`,`e`.`status` AS `status` from (`jerarquias` `j` join `empleados_formato` `e` on((`j`.`subordinado` = `e`.`empleado`))) where (`j`.`jefe` is not null) ;

-- ----------------------------
-- View structure for jefes_iniciales
-- ----------------------------
DROP VIEW IF EXISTS `jefes_iniciales`;
CREATE VIEW `jefes_iniciales` AS select distinct `j`.`evaluacion` AS `evaluacion`,0 AS `jefe`,`e`.`empleado` AS `empleado`,`e`.`n` AS `n`,`e`.`nombre` AS `nombre`,`e`.`apellido_paterno` AS `apellido_paterno`,`e`.`apellido_materno` AS `apellido_materno`,`e`.`departamento` AS `departamento`,`e`.`departamento_n` AS `departamento_n`,`e`.`puesto` AS `puesto`,`e`.`puesto_n` AS `puesto_n`,`e`.`area` AS `area`,`e`.`area_n` AS `area_n`,`e`.`nivel` AS `nivel`,`e`.`nivel_n` AS `nivel_n`,`e`.`email` AS `email`,`e`.`fechaRegistro` AS `fechaRegistro`,`e`.`status` AS `status` from (`jerarquias` `j` join `empleados_formato` `e` on((`j`.`subordinado` = `e`.`empleado`))) where (not(`j`.`subordinado` in (select `subordinados`.`empleado` from `subordinados`))) ;

-- ----------------------------
-- View structure for evaluaciones_jefes
-- ----------------------------
DROP VIEW IF EXISTS `evaluaciones_jefes`;
CREATE VIEW `evaluaciones_jefes` AS select `s`.`evaluacion` AS `evaluacion`,`s`.`jefe` AS `jefe`,`s`.`empleado` AS `empleado`,`s`.`n` AS `n`,`s`.`nombre` AS `nombre`,`s`.`apellido_paterno` AS `apellido_paterno`,`s`.`apellido_materno` AS `apellido_materno`,`s`.`departamento` AS `departamento`,`s`.`departamento_n` AS `departamento_n`,`s`.`puesto` AS `puesto`,`s`.`puesto_n` AS `puesto_n`,`s`.`area` AS `area`,`s`.`area_n` AS `area_n`,`s`.`nivel` AS `nivel`,`s`.`nivel_n` AS `nivel_n`,`s`.`email` AS `email`,`s`.`fechaRegistro` AS `fechaRegistro`,`s`.`status` AS `status` from `subordinados` `s` where `s`.`empleado` in (select `subordinados`.`jefe` from `subordinados`) union select `j`.`evaluacion` AS `evaluacion`,NULL AS `jefe`,`j`.`empleado` AS `empleado`,`j`.`n` AS `n`,`j`.`nombre` AS `nombre`,`j`.`apellido_paterno` AS `apellido_paterno`,`j`.`apellido_materno` AS `apellido_materno`,`j`.`departamento` AS `departamento`,`j`.`departamento_n` AS `departamento_n`,`j`.`puesto` AS `puesto`,`j`.`puesto_n` AS `puesto_n`,`j`.`area` AS `area`,`j`.`area_n` AS `area_n`,`j`.`nivel` AS `nivel`,`j`.`nivel_n` AS `nivel_n`,`j`.`email` AS `email`,`j`.`fechaRegistro` AS `fechaRegistro`,`j`.`status` AS `status` from `jefes_iniciales` `j` ;

-- ----------------------------
-- View structure for evaluacion_niveles
-- ----------------------------
DROP VIEW IF EXISTS `evaluacion_niveles`;
CREATE VIEW `evaluacion_niveles` AS select distinct `j`.`evaluacion` AS `evaluacion`,`j`.`nivel` AS `nivel`,`j`.`nivel_n` AS `nivel_n` from `jefes_iniciales` `j` union select distinct `s`.`evaluacion` AS `evaluacion`,`s`.`nivel` AS `nivel`,`s`.`nivel_n` AS `nivel_n` from `subordinados` `s` ;


-- ----------------------------
-- View structure for empleados_disponibles
-- ----------------------------
DROP VIEW IF EXISTS `empleados_disponibles`;
CREATE VIEW `empleados_disponibles` AS select `e`.`empleado` AS `empleado`,`e`.`nombre` AS `nombre`,`e`.`apellido_paterno` AS `apellido_paterno`,`e`.`apellido_materno` AS `apellido_materno`,concat(ifnull(`e`.`nombre`,''),' ',ifnull(`e`.`apellido_paterno`,''),' ',ifnull(`e`.`apellido_materno`,'')) AS `n`,`e`.`departamento` AS `departamento`,`e`.`nivel` AS `nivel`,`e`.`puesto` AS `puesto`,`e`.`area` AS `area`,`e`.`email` AS `email`,`e`.`status` AS `status`,`e`.`fechaRegistro` AS `fechaRegistro` from `empleados_formato` `e` where (`e`.`status` = 0) ;

-- ----------------------------
-- View structure for cartas_envios_detalle
-- ----------------------------
DROP VIEW IF EXISTS `cartas_envios_detalle`;
CREATE VIEW `cartas_envios_detalle` AS select `ce`.`id` AS `id`,`ce`.`evaluacion` AS `evaluacion`,`ce`.`tipo` AS `tipo`,`ce`.`usuarioRegistrante` AS `usuarioRegistrante`,`ce`.`fechaRegistro` AS `fechaRegistro`,`ce`.`empleadosTotales` AS `empleadosTotales`,`ce`.`avance` AS `avance`,`u`.`nombre` AS `usuario_n`,`u`.`email` AS `email` from (`cartas_envios` `ce` join `usuarios` `u` on((`ce`.`usuarioRegistrante` = `u`.`usuario`))) ;

-- ----------------------------
-- View structure for cartas_envios_relacion
-- ----------------------------
DROP VIEW IF EXISTS `cartas_envios_relacion`;
CREATE VIEW `cartas_envios_relacion` AS select `ce`.`evaluacion` AS `evaluacion`,`cee`.`envio` AS `envio`,`ce`.`tipo` AS `tipo`,`cee`.`empleado` AS `empleado`,`cee`.`email` AS `email`,`cee`.`carta` AS `carta`,`cee`.`fechaRegistro` AS `fechaRegistro` from (`cartas_envios` `ce` join `cartas_envios_empleados` `cee` on((`ce`.`id` = `cee`.`envio`))) ;

-- ----------------------------
-- View structure for competencias_respuestas
-- ----------------------------
DROP VIEW IF EXISTS `competencias_respuestas`;
CREATE VIEW `competencias_respuestas` AS select `cv`.`evaluacion` AS `evaluacion`,`cp`.`competencia` AS `competencia`,`cv`.`valor` AS `valor`,`cv`.`etiqueta` AS `etiqueta`,`cv`.`titulo` AS `titulo`,`cv`.`descripcion` AS `descripcion`,`cp`.`id` AS `id_valor` from (`cuestionarios_competencias_secciones_valores_posibles` `cp` join `cuestionarios_valores_posibles` `cv` on((`cp`.`valor` = `cv`.`id`))) order by `cp`.`competencia`,`cv`.`valor` ;

-- ----------------------------
-- View structure for competencias_respuestas_valores
-- ----------------------------
DROP VIEW IF EXISTS `competencias_respuestas_valores`;
CREATE VIEW `competencias_respuestas_valores` AS select `cv`.`evaluacion` AS `evaluacion`,`cp`.`competencia` AS `competencia`,`cv`.`valor` AS `valor`,`cv`.`etiqueta` AS `etiqueta`,`cv`.`titulo` AS `titulo`,`cp`.`id` AS `id_valor` from (`cuestionarios_competencias_secciones_valores_posibles` `cp` join `cuestionarios_valores_posibles` `cv` on((`cp`.`valor` = `cv`.`id`))) order by `cp`.`competencia`,`cv`.`valor` ;

-- ----------------------------
-- View structure for evaluaciones_catalogo
-- ----------------------------
DROP VIEW IF EXISTS `evaluaciones_catalogo`;
CREATE VIEW `evaluaciones_catalogo` AS select `evaluaciones`.`id` AS `id`,`evaluaciones`.`titulo` AS `titulo` from `evaluaciones` where (`evaluaciones`.`status` <> 3) ;

-- ----------------------------
-- View structure for evaluaciones_info
-- ----------------------------
DROP VIEW IF EXISTS `evaluaciones_info`;
CREATE VIEW `evaluaciones_info` AS select `e`.`id` AS `id`,`e`.`titulo` AS `titulo`,`e`.`usuarioRegistrante` AS `usuarioRegistrante`,`e`.`fechaRegistro` AS `fechaRegistro`,(select count(1) from `evaluaciones_jefes` where (`evaluaciones_jefes`.`evaluacion` = `e`.`id`)) AS `jefesTotales`,(select count(1) from `jerarquias` where (`jerarquias`.`evaluacion` = `e`.`id`)) AS `empleadosTotales`,(select `c`.`fechaRegistro` from `cartas_envios` `c` where (`c`.`evaluacion` = `e`.`id`) order by (`c`.`fechaRegistro` and (`c`.`tipo` = 0)) limit 1) AS `cartas_eval_fecha`,(select round(((`cartas_envios`.`avance` / `cartas_envios`.`empleadosTotales`) * 100),0) from `cartas_envios` where ((`cartas_envios`.`evaluacion` = `e`.`id`) and (`cartas_envios`.`tipo` = 0))) AS `cartas_eval_avance`,now() AS `reporte_eval_fecha`,10 AS `reporte_eval_avance`,10 AS `eval_avance`,(select `c`.`fechaRegistro` from `cartas_envios` `c` where (`c`.`evaluacion` = `e`.`id`) order by (`c`.`fechaRegistro` and (`c`.`tipo` = 1)) limit 1) AS `cartas_auto_fecha`,(select round(((`cartas_envios`.`avance` / `cartas_envios`.`empleadosTotales`) * 100),0) from `cartas_envios` where ((`cartas_envios`.`evaluacion` = `e`.`id`) and (`cartas_envios`.`tipo` = 1))) AS `cartas_auto_avance`,now() AS `reporte_auto_fecha`,0 AS `reporte_auto_avance`,10 AS `auto_avance`,`e`.`texto_bienvenida_evaluacion` AS `texto_bienvenida_evaluacion`,`e`.`texto_bienvenida_autoevaluacion` AS `texto_bienvenida_autoevaluacion`,`e`.`status` AS `status`,`u1`.`nombre` AS `usuarioRegistranteNombre`,(case `e`.`status` when 0 then 'Cerrado' when 1 then 'Evaluación activa' when 2 then 'Autoevaluación activa' end) AS `statusValor` from (`evaluaciones` `e` join `usuarios` `u1` on((`e`.`usuarioRegistrante` = `u1`.`usuario`))) ;

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
CREATE VIEW `evaluacion_competencias` AS select `cc`.`evaluacion` AS `evaluacion`,`cc`.`id` AS `id`,`cc`.`titulo` AS `titulo`,`cc`.`orden` AS `orden`,'competencia' AS `tipo`,`cc`.`principal` AS `principal`,`cc`.`vinculaPuestos` AS `vinculaPuestos` from `cuestionarios_competencias` `cc` union select `cmi`.`evaluacion` AS `evaluacion`,`cmi`.`id` AS `id`,`cmi`.`titulo` AS `titulo`,`cmi`.`orden` AS `orden`,'manual' AS `manual`,1 AS `1`,0 AS `0` from `cuestionarios_manual_input` `cmi` ;

-- ----------------------------
-- View structure for evaluacion_cuestionario_listado
-- ----------------------------
DROP VIEW IF EXISTS `evaluacion_cuestionario_listado`;
CREATE VIEW `evaluacion_cuestionario_listado` AS select `ecu`.`id` AS `id`,`ecu`.`evaluacion` AS `evaluacion`,`ecu`.`nivel` AS `nivel`,`ecu`.`tipo` AS `tipo`,`ecu`.`id_competencia` AS `id_competencia`,`ecu`.`id_manual` AS `id_manual`,`eco`.`titulo` AS `titulo`,`eco`.`orden` AS `orden`,0 AS `nivelPuesto`,`eco`.`vinculaPuestos` AS `vinculaPuestos` from (`evaluaciones_cuestionario_niveles` `ecu` join `evaluacion_competencias` `eco` on(((`ecu`.`id_competencia` = `eco`.`id`) and (`ecu`.`tipo` = 'competencia') and (`eco`.`tipo` = 'competencia') and (`ecu`.`evaluacion` = `eco`.`evaluacion`)))) union select `ecu`.`id` AS `id`,`ecu`.`evaluacion` AS `evaluacion`,`ecu`.`nivel` AS `nivel`,`ecu`.`tipo` AS `tipo`,`ecu`.`id_competencia` AS `id_competencia`,`ecu`.`id_manual` AS `id_manual`,`eco`.`titulo` AS `titulo`,`eco`.`orden` AS `orden`,0 AS `0`,0 AS `My_exp_0` from (`evaluaciones_cuestionario_niveles` `ecu` join `evaluacion_competencias` `eco` on(((`ecu`.`id_manual` = `eco`.`id`) and (`ecu`.`tipo` = 'manual') and (`eco`.`tipo` = 'manual') and (`ecu`.`evaluacion` = `eco`.`evaluacion`)))) union select `ecu`.`id` AS `id`,`ecu`.`evaluacion` AS `evaluacion`,`ecu`.`nivel` AS `nivel`,`ecu`.`tipo` AS `tipo`,`ecu`.`id_competencia` AS `id_competencia`,`ecu`.`id_manual` AS `id_manual`,`eco`.`titulo` AS `titulo`,`eco`.`orden` AS `orden`,1 AS `1`,0 AS `0` from (`evaluaciones_cuestionario_puestos` `ecu` join `evaluacion_competencias` `eco` on(((`ecu`.`id_competencia` = `eco`.`id`) and (`ecu`.`tipo` = 'competencia') and (`eco`.`tipo` = 'competencia') and (`ecu`.`evaluacion` = `eco`.`evaluacion`)))) order by `evaluacion`,`nivel`,`orden` ;

-- ----------------------------
-- View structure for respuestas_evaluaciones_empleados_detalles
-- ----------------------------
DROP VIEW IF EXISTS `respuestas_evaluaciones_empleados_detalles`;
CREATE VIEW `respuestas_evaluaciones_empleados_detalles` AS select `s`.`evaluacion` AS `evaluacion`,`s`.`jefe` AS `jefe`,`s`.`empleado` AS `empleado`,`s`.`n` AS `n`,`s`.`departamento_n` AS `departamento_n`,`s`.`puesto` AS `puesto`,`s`.`puesto_n` AS `puesto_n`,`s`.`area_n` AS `area_n`,`s`.`nivel` AS `nivel`,`s`.`nivel_n` AS `nivel_n`,ifnull(`ree`.`id`,0) AS `respuesta`,`ree`.`fechaRegistro` AS `fechaRegistro` from (`subordinados` `s` left join `respuestas_evaluacion_empleados` `ree` on(((`s`.`evaluacion` = `ree`.`evaluacion`) and (`s`.`jefe` = `ree`.`evaluador`) and (`s`.`empleado` = `ree`.`empleado`)))) ;

-- ----------------------------
-- View structure for respuestas_evaluacion_detalles
-- ----------------------------
DROP VIEW IF EXISTS `respuestas_evaluacion_detalles`;
CREATE VIEW `respuestas_evaluacion_detalles` AS select `ef`.`empleado` AS `empleado`,`ef`.`nombre` AS `nombre`,`ef`.`n` AS `n`,md5(`ef`.`n`) AS `clave`,`j`.`evaluacion` AS `evaluacion`,`re`.`evaluadosTotales` AS `evaluadosTotales`,`re`.`avance` AS `avance`,`re`.`fechaRegistro` AS `fechaRegistro` from ((`empleados_formato` `ef` join `jerarquias` `j` on((`j`.`subordinado` = `ef`.`empleado`))) left join `respuestas_evaluacion` `re` on(((`ef`.`empleado` = `re`.`evaluador`) and (`j`.`evaluacion` = `re`.`evaluacion`)))) ;

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
		DELETE FROM respuestas_clave_competencias_niveles WHERE evaluacion = OLD.evaluacion AND nivel = OLD.nivel;
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
	DELETE FROM respuestas_clave_competencias_puestos WHERE evaluacion = OLD.evaluacion AND nivel = OLD.nivel;
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
