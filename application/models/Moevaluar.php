<?php
class Moevaluar extends CI_Model
{
	private $evaluacion;
	public $info;
	public $evaluados;
	
	//Devuelve el objeto de la clase.
	public function init(){
		return $this;
	}
	
	//Setear evaluacion
	public function evaluacion($i){ $this->evaluacion = (int)$i; }
	
	//Setear empleado
	public function evaluador($i){
		$w = array(
			'evaluacion' => $this->evaluacion,
			'clave' => $i
		);
		$q = $this->db->where($w)->get('respuestas_evaluacion_detalles');
		if($q->num_rows() > 0)
		{
			$this->info = $q->row();
			$this->info->avance = (int)$this->info->avance;
		}
		else
			show_error('La información no está disponible.');
	}
	
	//Información de los evaluados
	public function evaluados()
	{
		$q = $this->db->where('jefe', $this->info->empleado)->get('respuestas_evaluaciones_empleados_detalles');
		if($this->info->evaluadosTotales == 0) //Reasignación de valor, por si el registro es nulo
			$this->info->evaluadosTotales = $q->num_rows();
		
		$this->evaluados = $q->result();
	}
	
	//Registrar respuestas de un empleado
	public function registrar($info, $evaluador, $evaluado)
	{
		$r['error'] = 0;
		
		//Verificaciones iniciales
		$i = array(
			'evaluacion' => $evaluador->evaluacion,
			'evaluador' => $evaluador->empleado
		);

		$q = $this->db->select('id')->where($i)->get('respuestas_evaluacion');
		if($q->num_rows() == 0)
		{
			$this->db->insert('respuestas_evaluacion', $i);
			$respId = $this->db->insert_id();
		}
		else
			$respId = $q->row()->id;
		
		//Actualizar totales
		$this->db->simple_query('CALL respuestas_evaluacion_totales(' . $evaluador->evaluacion . ', ' . $evaluador->empleado . ')');
		
		$q = $this->db->select('id')->where('empleado', $evaluado->empleado)->get('respuestas_evaluacion_empleados');
		if($q->num_rows() > 0)
		{
			$r['error']++;
			$r['msg'] = "Este empleado ha sido evaluado anteriormente";
		}
		else
		{
			//Generar registro de respuesta de evaluado
			$i = array(
				'evaluacion' => $evaluador->evaluacion,
				'evaluador' => $evaluador->empleado,
				'empleado' => $evaluado->empleado,
				'id_respuestas_evaluacion' => $respId
			);
			if(!$this->db->insert('respuestas_evaluacion_empleados', $i))
			{
				$r['error']++;
				$r['msg'] = "Error en inserción de índice de respuesta de evaluación de empleado";
			}
			else
			{
				$respEmpId = $this->db->insert_id();
					
				//Comenzar inserciones de respuestas
				if(isset($info->respuestas->competencias) and count((array)$info->respuestas->competencias) > 0
				and !$this->db->insert_batch('respuestas_evaluacion_competencias', obj2ins(addResId($info->respuestas->competencias, $respEmpId))))
				{
					$r['error']++;
					$r['msg'] = "Error en inserción de respuestas de competencias";
				}
				
				if($r['error'] == 0 and isset($info->respuestas->manual)
				and isset($info->respuestas->manual->abierto) and count((array)$info->respuestas->manual->abierto) > 0
				and !$this->db->insert_batch('respuestas_evaluacion_manual_abierto', obj2ins(addResId($info->respuestas->manual->abierto, $respEmpId))))
				{
					$r['error']++;
					$r['msg'] = "Error en inserción de respuestas manuales abiertas";
				}
				
				if($r['error'] == 0 and isset($info->respuestas->manual)
				and isset($info->respuestas->manual->opciones) and count((array)$info->respuestas->manual->opciones) > 0
				and !$this->db->insert_batch('respuestas_evaluacion_manual_opciones', obj2ins(addResId($info->respuestas->manual->opciones, $respEmpId))))
				{
					$r['error']++;
					$r['msg'] = "Error en inserción de respuestas manuales de opciones";
				}
				
			}
		}
		
		return $r;
	}
}