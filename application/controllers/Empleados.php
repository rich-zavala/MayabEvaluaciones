<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Empleados extends CI_Controller {
	//Variables del controlador
	var $tabla = 'empleados'; //Nombre de la tabla o vista en la base de datos
	var $controlador = 'empleados'; //Nombre del objeto principal (para vistas, estilos y librerías)
	var $formName = 'formulario'; //Debe llamarse "formulario" para que funcione el angular

	function __construct() {
		parent::__construct();
		if(!$this->moguardia->isloged(true))
			show_error('La sesión de usuario no se encuentra disponible.');
		else
		{
			$this->load->model('moempleados');
			$this->model = $this->moempleados->init();
		}
	}

	//Vista de usuarios
	public function index()
	{
		$this->moheader->addJs('js/angularApp.js');
		$this->moheader->addJs('js/' . $this->controlador . '/listado.js');
		$h = array(
			'include_css' => $this->moheader->include_css(),
			'include_js' => $this->moheader->include_js(),
			'evaluaciones' => $this->mocomun->evaluaciones()
		);

		$this->load->view('layouts/header', $h);
		$this->load->view('layouts/sitio_wrapper');
		$this->load->view($this->controlador . '/listado');
		$this->load->view('layouts/footer');
	}

	//Devuelve listado de objetos para angular
	public function registros()
	{
		$c = $this->mocomun->init();
		$c->tabla('empleados_formato');
		$c->getTabla();

		$this->output->set_content_type('application/json')->set_output(json_encode($c->resultados));
	}

	//Formulario de registros (Modal)
	public function formulario()
	{
		$formName = $this->formName;
		$m = $this->model;
		$m->formName = $formName;
		$d = array(
			'formName' => $formName,
			'campos' => $m->campos_html()
		);

		$this->load->view( $this->controlador . '/formulario', $d);
	}

	//Registrar / editar lider
	public function submit()
	{
		$obj = json_decode(file_get_contents('php://input'));
		$m = $this->model;
		$m->obj = $obj;
		$r = $m->registrar();
		$this->output->set_content_type('application/json')->set_output(json_encode($r));
	}
}