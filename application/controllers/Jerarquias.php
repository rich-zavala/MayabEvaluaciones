<?php defined('BASEPATH') OR exit('No direct script access allowed');

/*
Controla las llamadas de AJAX hechas por la sección de jerarquías
*/

class Jerarquias extends CI_Controller {
	
	function __construct() {
		parent::__construct();
		if(!$this->moguardia->isloged(true))
			show_error('La sesión de usuario no se encuentra disponible.');
		else
			$this->load->model('evaluaciones/mojerarquias');
	}

	public function index()
	{
		show_error();
	}
	
	//Devuelve listado de jerarquías para angular
	public function json()
	{
		$evaluacion = json_decode(file_get_contents('php://input'))->evaluacion;
		$this->mojerarquias->init($evaluacion);
		$this->mojerarquias->get(); //Consultar BDD
		$this->output->set_content_type('application/json')->set_output(json_encode($this->mojerarquias->registros, JSON_NUMERIC_CHECK));
	}
	
	//Buscador de empleados
	public function buscador()
	{
		$param = json_decode(file_get_contents('php://input'))->param;
		$this->output->set_content_type('application/json')->set_output(json_encode($this->mojerarquias->empleados_buscador($param), JSON_NUMERIC_CHECK));
	}
	
	//Insertar empleado
	public function registrar()
	{
		$info = json_decode(file_get_contents('php://input'))->info;	
		$this->mojerarquias->init($info->evaluacion);
		$r = $this->mojerarquias->insertar($info);
		$this->output->set_content_type('application/json')->set_output(json_encode($r, JSON_NUMERIC_CHECK));
	}
	
	//Eliminar empleado
	public function eliminar()
	{
		$info = json_decode(file_get_contents('php://input'))->info;	
		$r = $this->mojerarquias->eliminar($info);
		$this->output->set_content_type('application/json')->set_output(json_encode($r, JSON_NUMERIC_CHECK));
	}
}