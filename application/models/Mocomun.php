<?php
/*
Coleccción de herramientas comunmente usadas en los controladores
*/
class Mocomun extends CI_Model
{
	var $tabla;
	var $id = 0;
	var $campo;
	var $valor;
	
	function __construct()
	{
		parent::__construct();
		$this->db->query('SET lc_time_names = "es_MX"');
	}
	
	public function init(){ return $this; }
	
	public function tabla($tabla){ $this->tabla = $tabla; }
	public function id($id){ $this->id = $id; }
	public function campo($campo){ $this->campo = $campo; }
	public function valor($valor){ $this->valor = $valor; }
	
	//Ejecutar cambio en campo booleano
	public function cambio()
	{
		$r = array( 'error' => 0 );
		$s = "UPDATE {$this->tabla} SET {$this->campo} = !{$this->campo} WHERE " . $this->getPrimaryKey() . " = {$this->id}";
		if(!$this->db->query($s)) $r['error']++;
		
		return $r;
	}
	
	//Cambiar el valor de algún campo
	public function cambio_campo()
	{
		$r = array( 'error' => 0 );
		$w = array( $this->getPrimaryKey() => $this->id );
		$i = array( $this->campo => $this->valor );
		if(!$this->db->where($w)->update($this->tabla, $i)) $r['error']++;
		$r['msg'] = $this->db->error();
		
		//Actualizar puntos
		if($r['error'] == 0 and $this->tabla == 'reservaciones') $r['puntos'] = $this->mocomun->reservacion_puntos($this->id);
		
		return $r;
	}
	
	//Eliminar un registro
	public function eliminar()
	{
		$r = array( 'error' => 0 );
		$w = array( $this->getPrimaryKey() => $this->id );
		if($this->tabla != 'usuarios' && !$this->db->where($w)->delete($this->tabla))
			$r['error']++;
		else if(!$this->db->where($w)->update($this->tabla, array( 'status' => 3 )))
			$r['error']++;
		
		/*
		Eliminación de registros foráneos
		*/
		switch($this->tabla)
		{
			case 'establecimientos':
				$w = array( 'establecimiento' => $this->id );
				$this->db->where($w)->delete('reservaciones');
			case 'lideres':
				$w = array( 'lider' => $this->id );
				$this->db->where($w)->delete('reservaciones');
		}
		
		$r['msg'] = $this->db->error();
		return $r;
	}
	
	//Obtener nombre del campo de clave primaria de una tabla
	public function getPrimaryKey()
	{
		$pk = '';
		foreach($this->db->field_data($this->tabla) as $r)
		{
			if($r->primary_key > 0)
			{
				$pk = $r->name;
				break;
			}
		}
		return $pk;
	}

	//Obtener todos los registros de una tabla y agregarlos a la memoria
	var $resultados = array();
	public function getTabla($order = ''){
		$q = $this->db->order_by($order)->get($this->tabla);
		if($q->num_rows() > 0)
		{
			$this->resultados = $q->result();
			return true;
		}
		else return false;
	}

	//Filtro para el CSV
	var $csv_where = array();
	public function csv_filtro($filtro, $valor)
	{
		$this->csv_where = array($filtro => $valor);
	}
	
	//Generar CSV
	public function csv()
	{
		$this->load->dbutil();
		$this->load->helper('file');
		$this->load->helper('download');
		$query = $this->db->where($this->csv_where)->get($this->tabla);
		$delimiter = ",";
		$newline = "\r\n";
		$data = utf8_decode($this->dbutil->csv_from_result($query, $delimiter, $newline));
		force_download($this->tabla . '.csv', $data);
	}
	
	/* Aplicaciones */
	//Listado de aplicaciones
	public function evaluaciones()
	{
		$aplicaciones = [];
		return $this->db->select('id, titulo')->order_by('fechaRegistro DESC')->get('evaluaciones')->result();
	}
}