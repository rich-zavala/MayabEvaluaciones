<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Pdf extends CI_Controller {
	//Generar HTML de un reporte
	/*
	$modalidad 0 - eva y 1 - auto
	$imprimible 0 - No, 1 - Si
	*/
	public function template($evaluacion, $tipo, $modalidad, $empleado, $imprimible = 0)
	{
		//Info del evaluado
		$this->load->model('evaluaciones/mojerarquias');
		$this->mojerarquias->init($evaluacion, false);
		$e = $this->mojerarquias->info($empleado);
		
		//Info de cuestionario
		$this->load->model('evaluaciones/mocuestionarios');
		$mc = $this->mocuestionarios->init($evaluacion);
		$mc->niveles();
		$mc->setNivel($e->nivel);
		$mc->puestos();
		$mc->setPuesto($e->puesto);
		$mc->getCompetenciasNivelPuesto();
		
		//Respuestas
		$this->load->model('evaluaciones/evaluacion');
		$re = $this->evaluacion->init($evaluacion);
		$re->empleado($empleado);
		$re->tipo($tipo);
		
		$respuestas = $re->respuestas_completas();
		if(count($respuestas->valores) == 0)
			show_error('No se encontraron respuestas para ' . $e->nombre);
		else
		{
			//Clave
			$clave = $re->respuestas_clave($e->nivel, $e->puesto);
			
			$this->moheader->addCss('css/pdf.css');
			$d = array(
				'include_css'	=> $this->moheader->include_css(),
				'eval'				=> $re->info(),
				'empleado'		=> $empleado,
				'e' 					=> $e,
				'c' 					=> $mc->infoCuestionarios,
				're'					=> $respuestas,
				'clave'				=> $clave,
				'modalidad'		=> $modalidad,
				'tipo'				=> $tipo,
				'imprimible'	=> $imprimible
			);
			// p($d); exit;
			$this->load->view('evaluaciones/plantilla_pdf_evaluacion', $d);
		}
	}
	
	//Generar PDFde un reporte
	public function reporte($evaluacion, $tipo, $modalidad, $empleado, $imprimible = 0)
	{
		$this->load->model('evaluaciones/mocartas');
		$this->mocartas->evaluacion($evaluacion);
		$this->mocartas->empleado($empleado);
		$this->mocartas->tipo($tipo);
		$this->mocartas->imprimible($imprimible);
		$p = $this->mocartas->generarPDF( (object) array('empleado' => $empleado), $modalidad );
		header('Location: ' . utf8_encode($p->url));
	}
}