<?php if ( ! defined('BASEPATH')) exit('No se permite el acceso directo al script');

class Emailuam
{
	var $config = array(
		'protocol' => 'smtp',
		'smtp_port' => 25,
		// 'smtp_host' => 'UAM-EXCH02',
		'smtp_host' => '192.168.10.104',
		'mailtype' => 'html', 
		'charset' => 'UTF-8',
		'wordwrap' => TRUE,
		'crlf' => "\r\n",
		'newline' => "\r\n"
	);
	
	var $from = "evaluaciones@anahuac.mx";
	var $fromName = "Evaluacion de Desempeno, Anáhuac Mayab";
	var $to;
	var $cc;
	var $subject;
	var $message;
	var $ci;
	
	function __construct() {
		$this->ci = & get_instance();
		$this->ci->load->library('email');
	}
	
	public function from($i, $nombre)
	{
		$this->from = trim($i);
		$this->fromName = trim($nombre);
	}
	
	public function to($i)
	{
		$this->to = $i;
		// $this->to = 'uam@uam.mx';
	}
	
	public function cc($i)
	{
		$this->cc = $i;
	}
	
	public function reply_to($i)
	{
		$this->reply_to = $i;
	}
	
	public function subject($i)
	{
		$this->subject = trim($i);
	}
	
	public function message($i)
	{
		$this->message = trim($i);
	}
	
	public function attach($path)
	{
		$this->ci->email->attach($path);
	}
	
	public function print_debugger()
	{
		return false;
	}
	
	public function send()
	{
		$this->ci->email->initialize($this->config);
		$this->ci->email->from($this->from, $this->fromName);
		$this->ci->email->to($this->to);
		$this->ci->email->cc($this->cc);
		$this->ci->email->subject($this->subject);
		$this->ci->email->message($this->message);
		return $this->ci->email->send();
	}
}
?>