<?php defined('BASEPATH') OR exit('No direct script access allowed');

/*
Controla los cuestionarios de evaluaciones, tanto para jefes como para empleados.
*/

class Evaluar extends CI_Controller {
	function __construct() {
		parent::__construct();
	}
	
	public function index(){ show_error(); }
	
	/*
	Inicio: Acceso a cuestionarios para jefes > EVALUACIÓN
	*/
	public function inicio($evaluacion = null, $empleadoClave = null)
	{
		if($evaluacion < 1 or strlen($empleadoClave) == 0)
			show_error();
		
		//Información de la evaluación
		$id = (int)$evaluacion;
		$this->load->model('evaluaciones/evaluacion');
		$evaluacion = $this->evaluacion->init($id);
		unset($evaluacion->info->texto_bienvenida_autoevaluacion);
		
		//Información del evaluación
		$this->load->model('moevaluar');
		$evaluador = $this->moevaluar->init();
		$evaluador->evaluacion($id);
		$evaluador->evaluador($empleadoClave);
		if($evaluacion->info->status == 1) $evaluador->evaluados(); //Cargar empleados si está abierto
		unset($evaluador->info->clave);
		
		$d = array(
			'evaluacion' => $evaluacion,
			'evaluador' => $evaluador
		);
		
		$this->moheader->addJs('js/angularApp.js');
		$this->moheader->addJs('js/evaluar/evaluador.js');
		$this->moheader->addJs('js/cuestionario/formulario.js');
		$h = array(
			'include_css' => $this->moheader->include_css(),
			'include_js' => $this->moheader->include_js()
		);
		$this->load->view('layouts/header', $h);
		$this->load->view('evaluacion/evaluar', $d);
	}
	
	/*
	Autoevaluacion: Acceso a empleados
	*/
	public function autoevaluacion($evaluacion = null, $empleadoClave = null)
	{
		if($evaluacion < 1 or strlen($empleadoClave) == 0)
			show_error();
		
		//Información de la evaluación
		$id = (int)$evaluacion;
		$this->load->model('evaluaciones/evaluacion');
		$evaluacion = $this->evaluacion->init($id);
		unset($evaluacion->info->texto_bienvenida_evaluacion);
		
		//Información del evaluación
		$this->load->model('moevaluar');
		$evaluador = $this->moevaluar->init();
		$evaluador->evaluacion($id);
		$evaluador->evaluador($empleadoClave);
		
		$d = array(
			'evaluacion' => $evaluacion,
			'evaluador' => $evaluador
		);
		
		$this->moheader->addJs('js/angularApp.js');
		$this->moheader->addJs('js/evaluar/evaluador.js');
		$this->moheader->addJs('js/cuestionario/formulario.js');
		$h = array(
			'include_css' => $this->moheader->include_css(),
			'include_js' => $this->moheader->include_js()
		);
		$this->load->view('layouts/header', $h);
		$this->load->view('evaluacion/autoevaluar', $d);
	}
	
	//Obtener el cuestionario
	public function cuestionario()
	{
		$input = json_decode(file_get_contents("php://input"));
		$this->load->model('evaluaciones/mocuestionarios');
		$mc = $this->mocuestionarios->init($input->evaluacion);
		$mc->niveles();
		$mc->setNivel($input->nivel);
		$mc->puestos();
		$mc->setPuesto($input->puesto);
		$mc->getCompetenciasNivelPuesto();
		
		//Si es autoevaluación remover preguntas abiertas
		if($input->modalidad == 'autoevaluacion')
			$mc->removerPreguntasAbiertas();
		
		$this->output->set_content_type('application/json')->set_output(json_encode($mc->infoCuestionarios, JSON_NUMERIC_CHECK));
	}
	
	public function responder()
	{
		$data = json_decode(file_get_contents('php://input'));
		$this->load->model('moevaluar');
		$ev = $this->moevaluar->init();
		$r = $ev->registrar($data);
		$this->output->set_content_type('application/json')->set_output(json_encode($r, JSON_NUMERIC_CHECK));
	}
}
