<?php
/*
Colección de propiedades de una evaluación.
Es prácticamente un catálogo de accesos directos al resto de los modelos.
*/

class Evaluacion extends CI_Model
{
	//Variables del modelo
	var $id = 0;
	public $info; //Información básica de una evaluación
	public $jerarquias; //Modelo de jerarquías
	private $empleado;
	private $respuestas_registros_query;
	
	//Devuelve el objeto de la clase.
	public function init($id){
		$this->id = (int)$id;
		$this->info($this->id);
		if($this->id == 0) show_error('La evaluación solicitada no se encuentra disponible.');
		return $this;
	}
	
	/*
	Información básica de la evaluación
	Devuelve siempre el atributo "ok" que define la existencia del registro.
	*/
	public function info()
	{
		$w = array(
			'id' => $this->id
		);
		$r = $this->db->get_where('evaluaciones_info_reportable', $w)->row();
		if(isset($r->id))
			$r->ok = true;
		else
			$r = (object) array( 'ok' => false );
		
		$this->info = $r;
		return $r;
	}

	//Reporte de respuestas
	public function respuestas()
	{
		$r = array();
		$q = $this->db->order_by('empleado_n')->get_where('reporte_respuestas_evaluacion', array( 'evaluacion' => $this->id ) );
		if($q->num_rows() > 0)
			$r = $q->result();
		
		return $r;
	}

	//Setear empleado
	public function empleado($empleado)
	{
		$this->empleado = $empleado;
	}
	
	//Listado de respuestas de un empleado: Evaluación
	public function respuestas_detalle_eval()
	{
		$this->respuestas_registros_query = $this->db->get_where('respuestas_evaluacion_detalle', array( 'empleado' => $this->empleado ));
	}
	
	//Listado de respuestas de un empleado: Autoevaluación
	public function respuestas_detalle_auto()
	{
		$this->respuestas_registros_query = $this->db->get_where('respuestas_autoevaluacion_detalle', array( 'empleado' => $this->empleado ));
	}
	
	//Generar CSV
	public function csv()
	{
		$this->load->dbutil();
		$this->load->helper('file');
		$this->load->helper('download');
		$delimiter = ",";
		$newline = "\r\n";
		$data = utf8_decode($this->dbutil->csv_from_result($this->respuestas_registros_query, $delimiter, $newline));
		force_download($this->tabla . '.csv', $data);
	}
}