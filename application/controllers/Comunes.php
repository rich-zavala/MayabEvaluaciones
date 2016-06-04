<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Comunes extends CI_Controller {
	
	function __construct() {
		parent::__construct();
		if(!$this->moguardia->isloged(true))
			show_error('La sesión de usuario no se encuentra disponible.');
	}
	
	//Vista de lideres
	public function index(){ show_404(); }
	
	//Actualizar un status
	public function actualizar()
	{
		$obj = json_decode(file_get_contents('php://input'));
		$c = $this->mocomun->init();
		$c->tabla($obj->tabla);
		$c->valor($obj->valor);
		$c->campo($obj->campo);
		$c->id($obj->id);
		$r = $c->cambio_campo();
		
		$this->output->set_content_type('application/json')->set_output(json_encode($r, JSON_NUMERIC_CHECK));
	}
	
	//Eliminar un registro
	public function eliminar()
	{
		$obj = json_decode(file_get_contents('php://input'));
		$c = $this->mocomun->init();
		$c->tabla($obj->tabla);
		$c->id($obj->id);
		$r = $c->eliminar();
		
		$this->output->set_content_type('application/json')->set_output(json_encode($r, JSON_NUMERIC_CHECK));
	}
	
	//Exportar lista de excel
	public function exportar($tabla, $filtro = null, $valor = null)
	{
		$this->load->model('mocomun');
		$this->mocomun->tabla($tabla);
		
		//Restringir líderes
		if($tabla == 'lideres_exportable' && !$this->moguardia->tienePermiso(5)) exit;
		
		//aplicar filtros
		if($filtro != null and $valor != null) 
		{
			$this->mocomun->csv_filtro($filtro, $valor);
		}
		
		$this->mocomun->csv();
	}
}