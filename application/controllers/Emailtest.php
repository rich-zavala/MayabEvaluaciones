<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Emailtest extends CI_Controller
{
	/*
	Genera el reporte de FUA
	*/
	public function index()
	{
		$msg = '<!DOCTYPE html>
					<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
					<head>
						<meta charset="utf-8">
						<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
						<title>Contenido de carta</title>
					<script type="text/javascript"></script><link rel="stylesheet" type="text/css" href="/B1D671CF-E532-4481-99AA-19F420D90332/netdefender/hui/ndhui.css" /></head>
					<body><script type="text/javascript" language="javascript" src="/B1D671CF-E532-4481-99AA-19F420D90332/netdefender/hui/ndhui.js?0=0&amp;0=0&amp;0=0"></script><p>Estimado(a) Rafael Pardo 	Hervás:</p>

					<p>
						Antes de reunirte con los colaboradores a tu cargo para retroalimentarlos,
						es importante que analices y compares los resultados obtenidos, por lo que
						te envío un archivo Zip que contiene la siguiente información:
						<ol>
							<li><b>Autoevaluación</b> del colaborador con el puntaje obtenido.</li>
							<li><b>Evaluación</b> del colaborador con el puntaje obtenido.</li>
						</ol>
					</p>

					<p>
						El <b>martes 16 y miércoles 17</b> de agosto te haré llegar en sobre cerrado las:
						<ol>
							<li><b>Evaluaciones</b> de los colaboradores SIN el puntaje obtenido.</li>
						</ol>
					</p>

					<p>
						Es importante que <b>trabajes sobre este documento impreso</b> durante la retroalimentación
						ya que <b>el colaborador no debe saber el puntaje obtenido</b>, para
						que se enfoque a desarrollar las competencias requeridas y no en una calificación.
					</p>

					<p>
						Durante la retroalimentación: escribe sobre la evaluación los acuerdos 
						de trabajo, firmen ambos el documentos y te solicito me entregues todas la 
						<b>evaluaciones firmadas</b> en un sobre cerrado <b>antes del martes 30 de agosto de 2016</b>.
					</p>

					<p>
						Saludos cordiales y quedo a tus órdenes para cualquier duda.
					</p>

					<p>
						<b>Alejandrina Acevedo Vales</b><br>
						Capital Humano<br>
						<i>Evalución y Desarrollo</i><br>
						alejandrina.acevedo@anahuac.mx ext. 168
					</p></body>
					</html>';
		$mails = array('maria.cervera@anahuac.mx', 'ligia.gonzalez2@anahuac.mx', 'maricela.marqueda@anahuac.mx', 'karla.mezquita@anahuac.mx');
		
		foreach($mails as $m)
		{
			$this->load->library('emailuam');
			$this->emailuam->to($m);
			$this->emailuam->cc(array('alejandrina.acevedo@anahuac.mx', 'jesus.vazquez@anahuac.mx'));
			$this->emailuam->subject('Evaluación de desempeño: Reporte de resultados');
			$this->emailuam->message($msg);
			if($this->emailuam->send())
			{
				echo '<br>Enviado => ' . $m; 
			}
			else echo $this->email->print_debugger();
		}
		///echo $this->emailuam->message_template();
		//echo $this->email->print_debugger();
	}
}