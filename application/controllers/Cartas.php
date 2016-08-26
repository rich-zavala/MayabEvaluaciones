<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Cartas extends CI_Controller {
	
	function __construct() {
		parent::__construct();
		if(!$this->moguardia->isloged(true))
			show_error('La sesión de usuario no se encuentra disponible.');
		else
			$this->load->model('evaluaciones/mocartas');
	}

	public function index(){ show_error(); }
	
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
	public function contenido($evaluacion, $tipo, $empleado, $modalidad = false)
	{
		$this->mocartas->evaluacion($evaluacion);
		$this->mocartas->tipo($tipo);
		$this->mocartas->empleado($empleado);
		$contenido = ($modalidad != 'personal') ? $this->mocartas->contenido() : $this->mocartas->contenido(1);
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
		$envio = str_replace('Exit with code 1 due to network error: UnknownContentError', '', $this->mocartas->enviar()); //A veces sale un error desconocido
		$this->output->set_content_type('application/json')->set_output(json_encode($envio, JSON_NUMERIC_CHECK));
	}

	//Para reportes, enviar PDF comprimidos descargables
	public function comprimido($evaluacion, $empleado)
	{
		set_time_limit(0);
		$this->mocartas->evaluacion($evaluacion);
		$this->mocartas->empleado($empleado);
		$zip = $this->mocartas->comprimido($empleado);
		if(file_exists($zip['path']))
		{		
			header("HTTP/1.1 303 See Other");
			header("Location: " . $zip['url']);
		}
		else
			show_error('No se encontraron respuestas relacionadas con este evaluador.');
	}
}