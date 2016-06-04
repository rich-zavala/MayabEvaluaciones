<?php defined('BASEPATH') OR exit('No direct script access allowed');

/*
Controla las llamadas de AJAX hechas por la sección de cuestionarios
*/

class Cuestionarios extends CI_Controller {
	
	function __construct() {
		parent::__construct();
		if(!$this->moguardia->isloged(true))
			show_error('La sesión de usuario no se encuentra disponible.');
		else
			$this->load->model('evaluaciones/mocuestionarios');
	}

	public function index()
	{
		show_error();
	}
	
	//Devuelve listado de niveles y puestos para angular
	public function niveles_puestos()
	{
		$info = json_decode(file_get_contents('php://input'));
		$this->mocuestionarios->init($info->evaluacion);
		if($info->niveles)
		{
			$this->mocuestionarios->niveles();
			$this->mocuestionarios->nivelesCompetencias();
		}
		
		if($info->puestos)
		{
			$this->mocuestionarios->puestos();
			$this->mocuestionarios->puestosCompetencias();
		}
		
		$data = array(
			'niveles' => $this->mocuestionarios->niveles,
			'puestos' => $this->mocuestionarios->puestos
		);
		
		$this->output->set_content_type('application/json')->set_output(json_encode($data, JSON_NUMERIC_CHECK));
	}
	
	//Devuelve listado de competencias para angular
	public function competencias()
	{
		$evaluacion = json_decode(file_get_contents('php://input'))->evaluacion;
		$this->mocuestionarios->init($evaluacion);
		$this->mocuestionarios->setCuestionarios(); //Cargar catálogo de competencias
		$this->output->set_content_type('application/json')->set_output(json_encode($this->mocuestionarios->competencias, JSON_NUMERIC_CHECK));
	}
	
	//Registrar competencias de un nivel
	public function registrar_competencias()
	{
		$info = json_decode(file_get_contents('php://input'));	
		$this->mocuestionarios->init($info->evaluacion);
		$r = $this->mocuestionarios->registrarCompetencias($info);
		$this->output->set_content_type('application/json')->set_output(json_encode($r, JSON_NUMERIC_CHECK));
	}
	
	//Obtener el cuestionario de un nivel para clave
	/*
	18 Mayo 2016 > Ricardo Zavala
	Todos los objetos relacionados con niveles o puestos hacen referencia a la palabra "nivel".
	Esto es porque el requerimiento inicial sólamente comprendía niveles. Posteriormente se
	agregó la opción de los puestos. Por eso no tiene sentido, pero así está la cosa.
	*/
	public function clave()
	{
		$input = json_decode(file_get_contents("php://input")); //Parámetros
		$mc = $this->mocuestionarios->init($input->evaluacion);
		if($input->tipo == 0) //Switch entre cuestionarios de niveles y puestos
		{
			$mc->niveles();
			$mc->setNivel($input->nivel);
			$mc->setCompetencias();
			$mc->setCompetenciasPreguntas();
			$info = $mc->getNivelInfo();
		}
		else
		{
			$mc->puestos();
			$mc->setPuesto($input->nivel);
			$mc->setCompetencias(1);
			$mc->setCompetenciasPreguntas(true, 'puestos');
			$info = $mc->getPuestoInfo();
		}
		
		$this->output->set_content_type('application/json')->set_output(json_encode($info, JSON_NUMERIC_CHECK));
	}
	
	//Eliminar empleado
	public function eliminar()
	{
		$info = json_decode(file_get_contents('php://input'))->info;	
		$r = $this->mocuestionarios->eliminar($info);
		$this->output->set_content_type('application/json')->set_output(json_encode($r, JSON_NUMERIC_CHECK));
	}

	/*
	== Manejadores de registros ==
	*/
	//Insertar respuestas de clave de un nivel
	public function registrar_clave()
	{
		$info = json_decode(file_get_contents('php://input'))->info;
		$r = $this->mocuestionarios->registrarClave($info);
		$this->output->set_content_type('application/json')->set_output(json_encode($r, JSON_NUMERIC_CHECK));
	}
	
	//Obtener respuestas de una clave
	public function respuestas_clave()
	{
		$obj = json_decode(file_get_contents('php://input'));
		$r = $this->mocuestionarios->respuestasClave($obj);
		$this->output->set_content_type('application/json')->set_output(json_encode($r, JSON_NUMERIC_CHECK));
	}
}