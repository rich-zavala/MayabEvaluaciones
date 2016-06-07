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
	var $from = "no-reply@anahuac.mx";
	var $fromName = "Evaluación de Desempeño, Anáhuac Mayab";
	var $to;
	var $cc;
	var $subject;
	var $message;
	
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
	
	public function print_debugger()
	{
		return false;
	}
	
	public function send()
	{
		$ci = & get_instance();
		$ci->load->library('email');
		$ci->email->initialize($this->config);
		$ci->email->from($this->from, $this->fromName);
		$ci->email->to($this->to);
		$ci->email->cc($this->cc);
		$ci->email->subject($this->subject);
		$ci->email->message($this->message);
		return $ci->email->send();
	}
}
?>