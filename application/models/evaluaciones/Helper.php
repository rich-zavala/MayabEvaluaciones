<?php
/*
Colección de herramientas para ayudar a dibujar las páginas de secciones de evaluacioens.
También incluye acciones relacionadas directamente con la evaluación, tales como:
- Creación
- Edición
- Eliminación
*/
class Helper extends CI_Model
{
	function __construct($actual = 'info') { //"Info" es la sección por defecto
		parent::__construct();
	}
	
	function init(){ return $this;	}
	
	//Definición de secciones
	public $secciones = array(
		'info' => array(
			'titulo' => 'Información',
			'fa' => 'info'
		),
		'jerarquias' => array(
			'titulo' => 'Jerarquías',
			'fa' => 'sitemap'
		),
		'cuestionarios' => array(
			'titulo' => 'Cuestionarios',
			'fa' => 'check-square-o'
		),
		'cartas' => array(
			'titulo' => 'Cartas',
			'fa' => 'envelope'
		),
		'respuestas' => array(
			'titulo' => 'Respuestas',
			'fa' => 'database'
		),
		'reportes' => array(
			'titulo' => 'Reportes',
			'fa' => 'inbox'
		),
	);
	
	/*
	Carga de vistas para controladores que se muestran en pantalla
	$d 						Variables que se pasarán a la vista principal
								Debe incluir $d['evaluacion'] con el id de la evaluación actual
	$librerias		Conjunto de librerías a cargar manualmente ( 'css' =>, 'js' =>)
	*/
	public function view($d = array(), $librerias = array())
	{
		$ci =& get_instance(); //Para obtener la sección actual
		$this->load->model('moheader');
		
		//Cargar librerías de header manuales
		if(isset($librerias['js'])) foreach($librerias['js'] as $lib) $this->moheader->addJs($lib);
		if(isset($librerias['css'])) foreach($librerias['css'] as $lib) $this->moheader->addCss($lib);
		
		//Establecer librerías del header fijas
		$h = $this->header_includes($d['evaluacion']);
		
		//Variables para el wrapper de secciones
		$t = array(
			'evaluacion' => $d['evaluacion'],
			'secciones' => $this->secciones,
			'actual' => $ci->router->method
		);
		
		//Info de la evaluación
		$this->load->model('evaluaciones/evaluacion');
		$this->e = $this->evaluacion->init($this->id);
		$t['info'] = $this->e->info;
		
		//Cargar vistas
		$this->load->view('layouts/header', $h);
		$this->load->view('layouts/sitio_wrapper');
		$this->load->view($this->controlador . '/layout_header', $t);
		$this->load->view($this->controlador . '/' . $t['actual'], $d);
		$this->load->view($this->controlador . '/layout_footer');
		$this->load->view('layouts/footer');
	}
	
	//Carga de librerías fijas para este controlador
	public function header_includes($evaluacion)
	{
		return array(
			'include_css' => $this->moheader->include_css(),
			'include_js' => $this->moheader->include_js(),
			'evaluaciones' => $this->mocomun->evaluaciones($evaluacion)
		);
	}

	//Registrar nueva evaluación
	public function nuevo($obj)
	{
		$r['error'] = 0;
		
		//Agregar datos extra
		$i = array(
			'titulo' => $obj->titulo,
			'usuarioRegistrante' => $this->moguardia->data()['usuario']
		);
		
		//Insertar
		if(!$this->db->insert('evaluaciones', $i))
		{
			$r['error']++;
		}
		else //Continuar
		{
			$r['id'] = $ev = $this->db->insert_id();
			
			/*
			EJECUTAR CLONACIONES!!!
			*/
			// 1. Jerarquía
			if(isset($obj->jerarquias) and $obj->jerarquias->id > 0)
			{
				$s = "INSERT INTO jerarquias (evaluacion, jefe, subordinado, nivel, puesto, usuarioRegistrante) SELECT {$ev}, jefe, subordinado, nivel, puesto, '" . $this->moguardia->data()['usuario'] . "' FROM jerarquias WHERE evaluacion = " . $obj->jerarquias->id;
				$this->db->query($s);
			}
			
			// 2. Competencias
			if(isset($obj->cuestionarios) and $obj->cuestionarios->id > 0)
			{
				/*
				== Valores posibles de competencia ==
				Se crea un catálogo de equivalencias de ids originales y nuevos para poder actualizar en "cuestionarios_competencias_secciones_valores_posibles"
				*/
				$caseValores = $valoresPosibles = [];
				$valoresPosiblesOriginales = $this->db->where('evaluacion', $obj->cuestionarios->id)->get('cuestionarios_valores_posibles')->result();
				foreach($valoresPosiblesOriginales as $vpo)
				{
					//Insertar competencia
					$idVpo = $vpo->id;
					unset($vpo->id);
					$vpo->evaluacion = $ev;
					$this->db->insert('cuestionarios_valores_posibles', $vpo);
					$caseValores[$idVpo] = $this->db->insert_id();
				}
				
				//Preparar equivalencias para niveles y puestos
				$caseCompetencia = $caseManual = [];
				
				// Por cada competencia clonar niveles y puestos
				$competencias = $this->db->where('evaluacion', $obj->cuestionarios->id)->get('cuestionarios_competencias')->result();
				foreach($competencias as $competencia)
				{
					//Insertar competencia
					$idCompetenciaOriginal = $competencia->id;
					unset($competencia->id);
					$competencia->evaluacion = $ev;
					$this->db->insert('cuestionarios_competencias', $competencia);
					$competencia->id = $this->db->insert_id();
					
					//Agregar a catálogo de case
					$caseCompetencia[] = "WHEN {$idCompetenciaOriginal} THEN " . $competencia->id;
					
					//Insertar secciones de competencia
					$secciones = $this->db->where('competencia', $idCompetenciaOriginal)->get('cuestionarios_competencias_secciones')->result();
					foreach($secciones as $seccion)
					{
						$idSeccionOriginal= $seccion->id;
						unset($seccion->id);
						$seccion->competencia = $competencia->id;
						$this->db->insert('cuestionarios_competencias_secciones', $seccion);
						$seccion->id = $this->db->insert_id();
						
						//Insertar conductas de esta sección
						$conductas = $this->db->where('seccion', $idSeccionOriginal)->get('cuestionarios_competencias_secciones_conductas')->result();
						foreach($conductas as $conducta)
						{
							//Insertar competencia
							$idConductaOriginal = $conducta->id;
							unset($conducta->id);
							$conducta->seccion = $seccion->id;
							$this->db->insert('cuestionarios_competencias_secciones_conductas', $conducta);
					
							//Agregar a catálogo de case
							$nuevo_conductas[] = "WHEN {$idConductaOriginal} THEN " . $this->db->insert_id();
						}
					}
					
					//Insertar valores posibles de esta competencia
					$valores = $this->db->where('competencia', $idCompetenciaOriginal)->get('cuestionarios_competencias_secciones_valores_posibles')->result();
					foreach($valores as $valor)
					{
						//Insertar competencia
						$idValorOricinal = $valor->id;
						unset($valor->id);
						$valor->competencia = $competencia->id;
						$valor->valor = $caseValores[$valor->valor];
						$this->db->insert('cuestionarios_competencias_secciones_valores_posibles', $valor);
				
						//Agregar a catálogo de case
						$nuevo_valores_posibles[] = "WHEN {$idValorOricinal} THEN " . $this->db->insert_id();
					}
				}
				
				// 3. Preguntas abiertas
				// Por cada pregunta clonar niveles y puestos
				$manuales = $this->db->where('evaluacion', $obj->cuestionarios->id)->get('cuestionarios_manual_input')->result();
				foreach($manuales as $manual)
				{
					//Insertar manual
					$idManualOriginal = $manual->id;
					unset($manual->id);
					$manual->evaluacion = $ev;
					$this->db->insert('cuestionarios_manual_input', $manual);
					$manual->id = $this->db->insert_id();
					
					//Agregar a catálogo de case
					$caseManual[] = "WHEN {$idManualOriginal} THEN " . $manual->id;
					
					//Insertar preguntas
					$preguntas = $this->db->where('contenedor', $idManualOriginal)->get('cuestionarios_manual_input_preguntas')->result();
					foreach($preguntas as $pregunta)
					{
						$idPreguntaOriginal = $pregunta->id;
						unset($pregunta->id);
						$pregunta->contenedor = $manual->id;
						$this->db->insert('cuestionarios_manual_input_preguntas', $pregunta);
						$pregunta->id = $this->db->insert_id();
						
						//Insertar opciones de pregunta
						$opciones = $this->db->where('input', $idPreguntaOriginal)->get('cuestionarios_manual_input_preguntas_opciones')->result();
						foreach($opciones as $opcion)
						{
							$idOpcionOriginal = $opcion->id;
							unset($opcion->id);
							$opcion->input = $pregunta->id;
							$this->db->insert('cuestionarios_manual_input_preguntas_opciones', $opcion);
							$opcion->id = $this->db->insert_id();
						
							//Insertar respuestas de una opción
							$respuestas = $this->db->where('input_opciones', $idOpcionOriginal)->get('cuestionarios_manual_input_preguntas_opciones_respuestas')->result();
							foreach($respuestas as $respuesta)
							{
								unset($respuesta->id);
								$respuesta->input_opciones = $opcion->id;
								$this->db->insert('cuestionarios_manual_input_preguntas_opciones_respuestas', $respuesta);
							}
						}
					}
				}
				
				// 4. Clonar respuestas de claves
				$s = "INSERT INTO respuestas_clave_competencias_niveles SELECT NULL, {$ev}, nivel,
							CASE id_conducta " . join(" ", $nuevo_conductas) . " END,
							CASE id_valor " . join(" ", $nuevo_valores_posibles) . " END
							FROM respuestas_clave_competencias_niveles WHERE evaluacion = " . $obj->cuestionarios->id;
				$this->db->query($s);
				
				$s = "INSERT INTO respuestas_clave_competencias_puestos SELECT NULL, {$ev}, nivel,
							CASE id_conducta " . join(" ", $nuevo_conductas) . " END,
							CASE id_valor " . join(" ", $nuevo_valores_posibles) . " END
							FROM respuestas_clave_competencias_puestos WHERE evaluacion = " . $obj->cuestionarios->id;
				$this->db->query($s);
				
				// 5. Insertar asignaciones por nivel
				$s = "INSERT INTO evaluaciones_cuestionario_niveles SELECT NULL, {$ev}, nivel, tipo,
							CASE id_competencia " . join(" ", $caseCompetencia) . " END,
							CASE id_manual " . join(" ", $caseManual) . " END
							FROM evaluaciones_cuestionario_niveles WHERE evaluacion = " . $obj->cuestionarios->id;
				$this->db->query($s);
				
				// 6. Insertar asignaciones por puesto
				$s = "INSERT INTO evaluaciones_cuestionario_puestos SELECT NULL, {$ev}, nivel, tipo,
							CASE id_competencia " . join(" ", $caseCompetencia) . " END,
							CASE id_manual " . join(" ", $caseManual) . " END
							FROM evaluaciones_cuestionario_puestos WHERE evaluacion = " . $obj->cuestionarios->id;
				$this->db->query($s);
			}
		}
		
		//Verificar el error
		if($r['error'] > 0)
		{
			$mysql_error = $this->db->error();
			switch($mysql_error['code'])
			{
				case 1062:
					$r['msg'] = 'Este registro está duplicado.';
					break;
					
				default:
					$r['info'] = $mysql_error;
					$r['msg'] = 'El motivo no pudo ser determinado.';
			}
		}
		return $r;
	}
}