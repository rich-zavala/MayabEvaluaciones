<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Cartas extends CI_Controller {
	
	function __construct() {
		parent::__construct();
		if(!$this->moguardia->isloged(true))
			show_error('La sesión de usuario no se encuentra disponible.');
		else
			$this->load->model('evaluaciones/mocartas');
	}

	public function index()
	{
		show_error();
	}
	
	//Información del envío de cartas
	public function info()
	{
		$data = json_decode(file_get_contents('php://input'))->info;
		$this->mocartas->evaluacion($data->evaluacion);
		$this->mocartas->tipo($data->tipo);
		$this->mocartas->info();
		$this->output->set_content_type('application/json')->set_output(json_encode($this->mocartas->info, JSON_NUMERIC_CHECK));
	}
	
	//Mostrar carta de un empleado
	public function contenido($evaluacion, $tipo, $empleado)
	{
		$this->mocartas->evaluacion($evaluacion);
		$this->mocartas->tipo($tipo);
		$this->mocartas->empleado($empleado);
		$contenido = $this->mocartas->contenido();
		echo '<!DOCTYPE html>
					<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
					<head>
						<meta charset="utf-8">
						<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
						<title>Contenido de carta</title>
					</head>
					<body>' . $contenido['texto'] . '</body>
					</html>';
	}
	
	
	public function nuevo_envio()
	{
		$data = json_decode(file_get_contents('php://input'))->data;
		$this->mocartas->evaluacion($data->evaluacion);
		$this->mocartas->tipo($data->tipo);
		$this->mocartas->empleadosTotales($data->empleadosTotales);
		$this->mocartas->nuevoEnvio();
		$this->output->set_content_type('application/json')->set_output(json_encode($this->mocartas->envio, JSON_NUMERIC_CHECK));
	}
	
	//Enviar una carta
	public function enviar()
	{
		$data = json_decode(file_get_contents('php://input'))->data;
		$this->mocartas->evaluacion($data->evaluacion);
		$this->mocartas->tipo($data->tipo);
		$this->mocartas->empleado($data->empleado->empleado);
		$this->mocartas->envio($data->envio);
	// public function enviar($evaluacion, $tipo, $empleado)
	// {
		// $this->mocartas->evaluacion($evaluacion);
		// $this->mocartas->tipo($tipo);
		// $this->mocartas->empleado($empleado);
		$envio = $this->mocartas->enviar();
		$this->output->set_content_type('application/json')->set_output(json_encode($envio, JSON_NUMERIC_CHECK));
	}
}