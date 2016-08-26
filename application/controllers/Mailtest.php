<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Mailtest extends CI_Controller
{
	public function index()
	{
		//exit;
		$this->load->library('emailuam');
		$this->emailuam->to('rich.zavalac@gmail.com');
		$this->emailuam->cc(array('vazqueznjesus@gmail.com', 'jesus.vazquez@anahuac.mx', 'jesus.vazquez90@hotmail.com'));
		$this->emailuam->subject('Prueba de correo');
		$this->emailuam->message('HOLA, RICH!!');
		$this->emailuam->send();
		echo $this->email->print_debugger();
	}
}