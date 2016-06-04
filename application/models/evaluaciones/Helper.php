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
			'fa' => 'line-chart'
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
			$r['id'] = $this->db->insert_id();
			
			/*
			EJECUTAR CLONACIONES!!!
			*/
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