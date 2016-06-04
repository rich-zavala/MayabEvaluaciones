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
	También establece $this->id
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
}