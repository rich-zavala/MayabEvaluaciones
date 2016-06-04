<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Inicio extends CI_Controller {
	function __construct() {
		parent::__construct();
		if(!$this->moguardia->isloged(true))
			show_error('La sesión de usuario no se encuentra disponible.');
	}
	
	public function index()
	{
		/* Inicialmente se redirige a la evaluación más reciente */
		$evaluaciones = $this->mocomun->evaluaciones();
		redirect(base('evaluaciones/info/' . $evaluaciones[0]->id ));
	}
}
