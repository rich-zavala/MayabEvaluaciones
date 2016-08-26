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
	private $modalidad = 'evaluacion';
	private $tipo ;
	// public $data;
	
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
	public function empleado($empleado){ $this->empleado = $empleado; }
	
	//Setear tipo
	public function tipo($i){ $this->tipo = $i; }
	
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

	//Agregar respuestas abiertas
	public function respuestas_completas()
	{
		$data = (object) array(
			'valores' 				=> (object) array(),
			'promedios' 			=> array(),
			'promedio_total' 	=> 0,
			'abiertas' 				=> (object) array(),
		);
		
		//Respuestas de competencias
		$q = $this->db;
		if($this->tipo == 0)
		{
			$w = array( 'r.evaluacion' => $this->id, 'r.empleado' => $this->empleado );
			$q->from('respuestas_evaluacion re')
				->join('respuestas_evaluacion_empleados r', 'r.id_respuestas_evaluacion = re.id')
				->join('respuestas_evaluacion_competencias rec', 'rec.id_evaluacion_empleado = r.id');
		}
		else
		{
			$w = array( 're.evaluacion' => $this->id, 're.empleado' => $this->empleado );
			$q->from('respuestas_autoevaluacion re')
				->join('respuestas_autoevaluacion_competencias rec', 'rec.id_evaluacion_empleado = re.id');
		}
		
		$q->where($w);
		$valores = $this->respuestas_joins($q)->get()->result();
		$data->valores = array();
		foreach($valores as $v)
			$data->valores[$v->id_conducta] = $v;

		if(count($data->valores) > 0)
		{
			//Obtener promedio
			$pr = $this->promedios($data->valores);
			$data->promedios = $pr->promedios;
			$data->promedio_total = $pr->promedio_total;
			
			//Calcular promedio total
			$data->promedio_total = ($data->promedio_total / count($data->promedios));
		}
		
		//Preguntas abiertas y manuales para evaluaciones
		if($this->tipo == 0)
		{
			$data->abiertas_manuales = $this->db->where($w)->get('respuestas_manuales r')->result();
			$data->abiertas_opciones = $this->db->where($w)->get('respuestas_opciones r')->result();
		}
		return $data;
	}
	
	//Obtener respuestas de clave
	public function respuestas_clave($nivel, $puesto)
	{
		$data = (object) array(
			'valores' => array(),
			'promedios' => array(),
			'promedio_total' => array()
		);
		$rn = $this->respuestas_clave_query('nivel', $nivel);
		$rp = $this->respuestas_clave_query('puesto', $puesto);
		$valores = array_merge($rp, $rn);
		$data->valores = array();
		foreach($valores as $v)
			$data->valores[$v->id_conducta] = $v;
		
		$pr = $this->promedios($data->valores);
		$data->promedios = $pr->promedios;
		$data->promedio_total = $pr->promedio_total;
		
		return $data;
	}
	
	//Auxiliar para "respuestas_clave"
	private function respuestas_clave_query($tipo, $id)
	{
		$w = array(
			'rec.evaluacion' => $this->id,
			'nivel' => $id
		);
		
		$tabla = ($tipo == 'nivel') ? 'respuestas_clave_competencias_niveles' : 'respuestas_clave_competencias_puestos';	
		
		$q = $this->db->where($w)
						->from($tabla . ' rec');
		return $this->respuestas_joins($q)->order_by('seccion')->get()->result();
	}
	
	//Auxiliar para obtener respuestas
	private function respuestas_joins($q)
	{
		return $q->select('rec.id_conducta, rec.id_valor, cvp.valor, ccsc.seccion')
						->join('cuestionarios_competencias_secciones_valores_posibles ccsvp', 'rec.id_valor = ccsvp.id')
						->join('cuestionarios_valores_posibles cvp', 'ccsvp.valor = cvp.id')
						->join('cuestionarios_competencias_secciones_conductas ccsc', 'rec.id_conducta = ccsc.id');
	}
	
	//Auxiliar para conseguir promedios
	private function promedios($r)
	{
		$pr = (object) array(
			'promedios' => array(),
			'promedio_total' => 0
		);
		
		//Obtener promedio
		foreach($r as $d)
		{
			if(!isset($pr->promedios[$d->seccion]))
			{
				$pr->promedios[$d->seccion] = array(
					'reactivos' => 0,
					'max' => 0,
					'promedio' => 0
				);
			}
			
			$pr->promedios[$d->seccion]['reactivos']++;
			$pr->promedios[$d->seccion]['max'] += (int)$d->valor;
		}
		
		foreach($pr->promedios as $k => $v)
		{
			$pr->promedios[$k]['promedio'] = round($v['max'] / $v['reactivos'], 2);
			$pr->promedio_total += $pr->promedios[$k]['promedio'];
		}
		
		return $pr;
	}
}