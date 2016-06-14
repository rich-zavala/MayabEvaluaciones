<?php defined('BASEPATH') OR exit('No direct script access allowed');
/*
Controlador de vistas primarias del módulo de evaluaciones completo.
Aquí sólo se manejan htmls (con js y css).
El resto de las llamadas se realiza a través de ajax.
Las respuestas de ajax se controlan con controladores diferentes a este (con algunas excepciones),
tanto para generar json como para manipular BDD.
*/

class Evaluaciones extends CI_Controller {
	//Variables del controlador
	var $tabla = 'evaluaciones'; //Nombre de la tabla o vista en la base de datos
	var $controlador = 'evaluaciones'; //Nombre del objeto principal (para vistas, estilos y librerías)
	var $formName = 'formulario'; //Debe llamarse "formulario" para que funcione el angular
	var $helper; //Conjunto de herramientas para este controlador
	var $e; //Colección de modelos paraa las evaluaciones
	var $id; //Id de evaluación actual
	var $librerias = array( 'js' => array(), 'css' => array() ); //Arreglo de librerías para cargar junto con las vistas

	function __construct() {
		parent::__construct();
		if(!$this->moguardia->isloged(true))
			show_error('La sesión de usuario no se encuentra disponible.');
		else
		{
			//Cargar modelos
			$this->load->model('evaluaciones/helper');
			
			//Inicializar info de secciones
			$this->helper = $this->helper->init();
			
			//Verificar información de evaluación si está definido
			$ci =& get_instance();
			if(count($ci->uri->segments) > 2 and is_numeric($ci->uri->segments[3]))
			{
				$this->id = $ci->uri->segments[3];
				$this->librerias['js'][] = 'js/angularApp.js';
			}
		}
	}

	//Nueva evaluación
	public function index()
	{
		//Librerías de angular
		$this->moheader->addJs('js/angularApp.js');
		$this->moheader->addJs('js/' . $this->controlador . '/nuevo.js');

		//Librerías comunes
		$h = array(
			'include_css' => $this->moheader->include_css(),
			'include_js' => $this->moheader->include_js(),
			'evaluaciones' => $this->mocomun->evaluaciones()
		);
		
		$this->load->view('layouts/header', $h);
		$this->load->view('layouts/sitio_wrapper');
		$this->load->view($this->controlador . '/nuevo');
		$this->load->view('layouts/footer');
	}
	
	//Información de una evaluación
	public function info($evaluacion)
	{
		$this->load->model('evaluaciones/evaluacion');
		$e = $this->evaluacion->init($evaluacion);
		
		$this->librerias['js'][] = 'js/evaluaciones/info/app.js';
		$d = array(
			'evaluacion' => $evaluacion,
			'info' => $e->info()
		);
		$this->helper->view($d, $this->librerias);
	}
	
	//Gestor de jerarquías
	public function jerarquias($evaluacion)
	{
		$librerias = array(
			'js/recursive_directive_compile.js',
			'js/' . $this->controlador . '/jerarquias/app.js',
			'js/' . $this->controlador . '/jerarquias/tree_render.js'
		);
		$this->librerias['js'] = array_merge($this->librerias['js'], $librerias);
		$d = array( 'evaluacion' => $evaluacion );
		$this->helper->view($d, $this->librerias);
	}
	
	//Gestor de cuestionarios > Niveles
	public function cuestionarios($evaluacion)
	{
		$librerias = array(
			'js/cuestionario/formulario.js',
			'js/' . $this->controlador . '/cuestionarios/niveles.js',
			'js/' . $this->controlador . '/cuestionarios/cuestionario.js'
		);
		$this->librerias['js'] = array_merge($this->librerias['js'], $librerias);
		$d = array( 'evaluacion' => $evaluacion );
		$this->helper->view($d, $this->librerias);
	}
	
	//Gestor de cartas
	public function cartas($evaluacion)
	{	
		$librerias = array(
			'js/recursive_directive_compile.js',
			'js/' . $this->controlador . '/cartas/app.js',
			'js/' . $this->controlador . '/cartas/tree_render.js'
		);
		$this->librerias['js'] = array_merge($this->librerias['js'], $librerias);
		$d = array( 'evaluacion' => $evaluacion );
		$this->helper->view($d, $this->librerias);
	}
	
	//Devuelve listado de evaluaciones para angular
	public function listado()
	{
		$c = $this->mocomun->init();
		$c->tabla('evaluaciones_catalogo');
		$c->getTabla();

		$this->output->set_content_type('application/json')->set_output(json_encode($c->resultados, JSON_NUMERIC_CHECK));
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
		$m->obj->permisos = implode(',', $m->obj->permisos); //Los permisos entran como arreglo
		$r = $m->registrar();
		$this->output->set_content_type('application/json')->set_output(json_encode($r));
	}
	
	//Nueva evaluación - Registrar
	public function nuevo_registrar()
	{
		$obj = json_decode(file_get_contents('php://input'));
		$r = $this->helper->nuevo($obj);
		$this->output->set_content_type('application/json')->set_output(json_encode($r));
	}

	//11 junio 2016 > Reporte de respuestas
	public function respuestas($evaluacion)
	{
		$this->load->model('evaluaciones/evaluacion');
		// $e = $this->evaluacion->init($evaluacion);
		
		$this->librerias['js'][] = 'js/evaluaciones/reportes/respuestas.js';
		$d = array(
			'evaluacion' => $evaluacion//,
			// 'info' => $e->respuestas()
		);
		$this->helper->view($d, $this->librerias);
	}
	
	//Registros para el reporte de respuestas
	public function respuestas_registros()
	{
		$evaluacion = json_decode(file_get_contents('php://input'))->evaluacion;
		$this->load->model('evaluaciones/evaluacion');
		$e = $this->evaluacion->init($evaluacion);
		$this->output->set_content_type('application/json')->set_output(json_encode($e->respuestas(), JSON_NUMERIC_CHECK));
	}

	//Vista temporal de respuestas (Evaluación)
	public function reseval($empleado)
	{
		$this->load->model('evaluaciones/evaluacion');
		$this->evaluacion->empleado($empleado);
		$this->evaluacion->respuestas_detalle_eval();
		$this->evaluacion->csv();
	}

	//Vista temporal de respuestas (Auto)
	public function resauto($empleado)
	{
		$this->load->model('evaluaciones/evaluacion');
		$this->evaluacion->empleado($empleado);
		$this->evaluacion->respuestas_detalle_auto();
		$this->evaluacion->csv();
	}
}