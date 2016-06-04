<?php
/*
== Obtiene y genera información de cuestionarios. ==
 - Crea el arbol de referencias:
		Competencias
			Secciones
				Conductas
					Valores posibles
		Preguntas de input manual
			Preguntas abiertas
			Preguntas de opción múltiple

 - Gestiona la asignación por nivel
 - Gestiona cómo armar un cuestionario según el nivel
 - Gestiona los registros de claves por parte de usuarios
 - NO gestiona la inserción de respuestas de empleados
*/
class Mocuestionarios extends CI_Model
{
	var $id = 0; //Id de la evaluación actual
	public $preguntas = array(); //Arreglo de arbol de referencias
	public $niveles = array();
	public $competencias = array();
	
	//Devuelve el objeto de la clase.
	public function init($id)
	{
		$this->id = $id;
		return $this;
	}
	
	//Obtiene todos los niveles de empleados en esta evaluación
	public function niveles()
	{
		$w = array( 'evaluacion' => $this->id );
		$this->niveles = $this->db->get_where('evaluacion_niveles', $w)->result();
	}
	
	//Obtiene el catálogo de competencias asignados a esta evaluación
	public function competencias()
	{
		$w = array( 'evaluacion' => $this->id );
		$this->competencias = $this->db->order_by('orden')->get_where('evaluacion_competencias', $w)->result();
	}
	
	//Obtiene las competencias y preguntas abiertas asignadas a un nivel
	public function nivel_competencias($nivel)
	{
		$w = array(
			'evaluacion' => $this->id,
			'nivel' => $nivel
		);
		return $this->db->get_where('evaluaciones_cuestionario', $w)->result();
	}
	
	//Agrega competencias a niveles
	public function niveles_competencias()
	{
		foreach($this->niveles as $k => $v)
			$this->niveles[$k]->competencias = $this->nivel_competencias($v->nivel);
	}
	
	//Agrega preguntas a competencias a niveles
	public function niveles_competencias_preguntas()
	{
		foreach($this->niveles[$k]->competencias as $kcom => $vcom)
			$this->niveles[$k]->competencias[$kcom]->preguntas = $this->competencia_preguntas($vcom);
	}
	
	//Obtener todo el arbol de referencias de preguntas de una competencia
	private function competencia_preguntas($com)
	{
		if($com->tipo == "competencia")
		{
			$w = array( 'competencia' => $com->id );
			$tabla = 'cuestionarios_competencias_secciones';
		}
		else if($com->tipo == "manual")
		{
			$w = array( 'evaluacion' => $com->evaluacion );
			$tabla = 'cuestionarios_manual_input';
		}
		
		return $this->db->where($w)->order_by('orden')->get($tabla)->result();
	}
	
	/* REGISTRO Y MANIPULACION DE BDD */
	public function registrar_niveles_competencias($nivel, $obj)
	{
		$t = 'evaluaciones_cuestionario';
		$r['error'] = 0;
		
		//Remover todos los registros actuales
		$w = array(
			'evaluacion' => $this->id,
			'nivel' => $nivel
		);
		if($this->db->where($w)->delete($t))
		{
			//Resetear el autoincrement porque soy obsesivo
			$this->db->simple_query('ALTER TABLE ' . $t . ' AUTO_INCREMENT=1');
			
			foreach($obj as $com)
				if(!$this->db->insert($t, $com)) $r['error']++;
			
			if($r['error'] > 0)
			{
				$r['msg'] = $r['error'] . " competencias no se registraron.";
			}
			else //Devolver competencias actuales del nivel
			{
				$r['data'] = $this->nivel_competencias($nivel);
			}
		}
		else
		{
			$r['error']++;
			$r['msg'] = "Error al eliminar registros actuales.";
		}
		
		return $r;
	}
	
}