<?php
class Moguardia extends CI_Model
{
	function __construct() {
		parent::__construct();
	}
	
	function init(){ return $this;	}
	
	//Verificar que exista una sesión en el sistema
	public function isloged($redirect = false)
	{
		$isLoged = $this->session->userdata('acceso');
		if(!$isLoged)
		{
			if($redirect)
			{
				$this->load->helper('url');
				redirect($this->config->item('base_url'));
			}
			else return false;
		}
		else return true;
	}
	
	//Registrar sesión de usuario
	public function setLogin($u, $p)
	{
		$w = array(
			'usuario' => $u,
			'pass' => sha1($p),
			'status' => 0
		);
		$q = $this->db->where($w)->get('usuarios');
		if($q->num_rows() > 0)
		{
			$data = array(
				'acceso' => true,
				'horaLogueo' => now()
			);
			$data = array_merge($data, $q->row_array());
			// p($data);
			// $data['permisos'] = explode(',', $data['permisos']);
			$this->session->set_userdata($data);
		}
		else @$this->session->sess_destroy();
	}
	
	//Cerrar sesión
	public function logout()
	{	
		$data = array( 'acceso' => false );
		$this->session->set_userdata($data);
		@$this->session->sess_destroy();
	}

	//Datos de la sesion
	public function data()
	{
		return $this->session->all_userdata();
	}

	///Verificar si la sesión tiene un permiso determinado
	// public function tienePermiso($i)
	// {
		// $info = $this->data();
		// return @in_array($i, $info['permisos']);
	// }
}