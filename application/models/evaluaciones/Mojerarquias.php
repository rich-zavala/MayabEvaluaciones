<?php
class Mojerarquias extends CI_Model
{
	var $id = 0; //Id de la evaluación actual
	public $registros = array(); //Arreglo de la jerarquía completa
	
	//Devuelve el objeto de la clase.
	public function init($id, $get = true){
		$this->id = $id;
		// if($get) $this->jerarquia();
		return $this;
	}
	
	//Obtener jerarquía completa de esta evaluación
	public function get()
	{
		$jerarquia = array();
		$jefes = $this->jefes();
		if(count($jefes) > 0)
			foreach($jefes as $jefe)
				$jerarquia[] = $this->generar($jefe); //Alimentar arreglo recursivamente
		
		$this->registros = $jerarquia;
	}
	
	//Buscar a los jefes iniciales
	public function jefes()
	{
		$w = array( 'evaluacion' => $this->id );
		return $this->db->order_by('n')->get_where('jefes_iniciales', $w)->result();
	}
	
	//Buscar subordinados de un jefe
	public function generar($jefe)
	{
		//Consulta
		$w = array(
			'evaluacion' => $this->id,
			'jefe' => $jefe->empleado
		);
		$subordinados = $this->db->order_by('n')->get_where('subordinados', $w)->result();
		
		if(count($subordinados) > 0)
		{
			$jefe->subordinados = array();
			foreach($subordinados as $subordinado)
				$jefe->subordinados[] = $this->generar($subordinado);
		}
		
		return $jefe;
	}
	
	//Dejar sólo jefes
	public function soloJefes()
	{
		// p($this->registros);
		foreach($this->registros as $k => $v)
			$this->registros[$k] = $this->soloJefesRecursivo($v);
	}
	
	//Función auxiliar para "soloJefes"
	public function soloJefesRecursivo($obj)
	{
		$remove = array();
		foreach($obj->subordinados as $k => $subordinado)
		{
			if(isset($subordinado->subordinados) and count($subordinado->subordinados) > 0)
				$obj->subordinados[$k] = $this->soloJefesRecursivo($subordinado);
			else
				$remove[] = $k;
		}
		
		foreach($remove as $rem)
			unset($obj->subordinados[$rem]);
		
		$obj->subordinados = array_values($obj->subordinados); //Importante!
		return $obj;
	}
	
	//Buscar empleados para agregar. Regresa hasta 10 resultados
	public function empleados_buscador($param)
	{
		//Consulta
		$w = array(
			'empleado' => $param
		);
		$r = $this->db->where($w)->or_like('n', $param)->limit(10)->get('empleados_disponibles')->result();
		return $r;
	}
	
	//Registrar empleado
	public function insertar($obj)
	{
		$r['error'] = 0;
		
		//Agregar datos extra
		$obj->usuarioRegistrante = $this->moguardia->data()['usuario'];
		
		//Insertar
		if(!$this->db->insert('jerarquias', $obj))
		{
			$r['error']++;
			$mysql_error = $this->db->error();
			switch($mysql_error['code'])
			{
				case 1062:
					$r['msg'] = 'Este empleado ya se encuentra en esta evaluación.';
					break;
					
				default:
					$r['info'] = $mysql_error;
					$r['msg'] = 'El motivo no pudo ser determinado.';
			}
		}
		return $r;
	}
	
	//Eliminar empleado
	public function eliminar($obj)
	{
		$r['error'] = 0;
		$this->db->where('evaluacion', $obj->evaluacion);
		$this->db->where('(jefe = ' . $obj->empleado . ' OR subordinado = ' . $obj->empleado . ')');
		if(!$this->db->delete('jerarquias'))
		{
			$r['error']++;
			$r['info'] = $this->db->error();
		}
		else
		{
			$this->db->simple_query("CALL remover_jefe(" . $obj->evaluacion . ", " . $obj->empleado . ")");
		}
		return $r;
	}
}