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
 
¡¡¡IMPORTANTE!!!
Debido al requerimiento de último momento se debe agregar compatibilidad de cuestionarios a los puestos
tal y como si fueran niveles.
*/
class Mocuestionarios extends CI_Model
{
	var $id = 0; //Id de la evaluación actual
	var $nivel = 0; //Nivel de empleado
	var $puesto = 0; //Puesto de empleado
	public $preguntas = array(); //Arreglo de arbol de referencias
	public $puestos = array();
	public $niveles = array();
	public $competencias = array();
	public $cuestionarios = array();
	public $infoCuestionarios =  array();
	
	//Devuelve el objeto de la clase.
	public function init($id)
	{
		$this->id = $id;
		return $this;
	}
	
	//Setear nivel de empleado
	public function setNivel($i){ $this->nivel = (int)$i; }
	
	//Obtiene todos los niveles de empleados en esta evaluación
	public function niveles()
	{
		$w = array( 'evaluacion' => $this->id );
		$this->niveles = $this->db->order_by('nivel_n')->get_where('evaluaciones_niveles_listado', $w)->result();
	}
	
	//Aislar información de un sólo nivel
	public function getNivelInfo()
	{
		$r = (object)array();
		foreach($this->niveles as $k => $n)
			if($n->nivel == $this->nivel)
				$r = (object) array_merge((array) $n, array( 'index' => $k )); //Se agrega "index" para conocer su posición en el arreglo de la clase
		
		return $r;
	}
	
	//Obtiene el catálogo de competencias asignados a esta evaluación
	public function setCuestionarios()
	{
		$w = array( 'evaluacion' => $this->id );
		if(count($this->competencias == 0))
		{
			$this->competencias = $this->db
			->order_by('importante DESC, orden, id ASC')->get_where('evaluacion_competencias', $w)
			->result();
		}
		
		if(count($this->cuestionarios == 0))
			$this->cuestionarios = $this->db->order_by('orden, nivel')->get_where('evaluacion_cuestionario_listado', $w)->result();
	}
		
	/*
	Arreglo de niveles o puestos y sus competencias (Para listado)
	Argumento $tipo: 0 - Niveles, 1 - Puestos
	*/
	public function nivelesCompetencias()
	{
		foreach($this->niveles as $k => $v)
		{
			$this->setNivel($v->nivel);
			$this->niveles[$k]->competencias = $this->setCompetencias();
		}
	}
	
	//Obtiene las competencias y preguntas abiertas asignadas a un nivel
	/*
	Se tiene que setear el nivel cada vez para poder hacer solicitudes de niveles específicos.
	0 > Niveles
	1 > Competencias
	*/
	public function setCompetencias($tipo = 0) //Tipo hace switch entre niveles y puestos
	{
		if($tipo == 0 and $this->nivel <= 0) show_error("No se ha definido el nivel");
		if($tipo == 1 and $this->puesto <= 0) show_error("No se ha definido el puesto");
		
		if(count($this->competencias == 0) || count($this->cuestionarios == 0) )
			$this->setCuestionarios();
		
		$r = array();
		$ident = ($tipo == 0) ? $this->nivel : $this->puesto;
		foreach($this->cuestionarios as $cuestionario)
			if($cuestionario->nivelPuesto == $tipo and $cuestionario->nivel == $ident)
				foreach($this->competencias as $competencia)
					if($cuestionario->tipo == $competencia->tipo and ($cuestionario->id_competencia == $competencia->id or $cuestionario->id_manual == $competencia->id))
						$r[] = (object)array_merge((array)$competencia, (array)$cuestionario);

		$index = $tipo == 0 ? $this->getNivelInfo()->index : $this->getPuestoInfo()->index;
		
		if($tipo == 0)
			$this->niveles[$index]->competencias = $r;
		else
			$this->puestos[$index]->competencias = $r;
		
		return $r;
	}
	
	//Agrega preguntas a competencias a niveles
	public function setCompetenciasPreguntas($incluirValores = true, $mode = 'niveles')
	{
		foreach($this->$mode as $k => $n)
			if(isset($n->competencias))
				foreach($n->competencias as $kc => $com)
					eval( "\$this->" . $mode . "[\$k]->competencias[\$kc]->secciones = \$this->competenciaSecciones(\$com, \$incluirValores);" );
	}
	
	//Setear puesto de empleado
	public function setPuesto($i){ $this->puesto = (int)$i; }
	
	//Obtiene todos los puestos de empleados
	public function puestos()
	{
		$w = array( 'evaluacion' => $this->id );
		$this->puestos = $this->db
		->order_by('nivel_n')->get_where('evaluaciones_puestos_listado', $w)->result();
	}
	
	//Aislar información de un sólo puesto
	public function getPuestoInfo()
	{
		$r = (object)array();
		foreach($this->puestos as $k => $n)
			if($n->nivel == $this->puesto)
				$r = (object) array_merge((array) $n, array( 'index' => $k )); //Se agrega "index" para conocer su posición en el arreglo de la clase
		
		return $r;
	}
	
	//Arreglo de puestos y sus competencias (Para listado)
	public function puestosCompetencias()
	{
		foreach($this->puestos as $k => $v)
		{
			$this->setPuesto($v->nivel);
			$this->puestos[$k]->competencias = $this->setCompetencias(1);
		}
	}
	
	//Obtiene las competencias y preguntas abiertas asignadas a un puesto
	/*public function setPuestoCompetencias()
	{
		if($this->puesto <= 0) show_error("No se ha definido el puesto");
		
		$w = array(
			'evaluacion' => $this->id,
			'principal' => 0,
			'nivel' => $this->puesto //"Nivel" es el alias para puesto.
		);
		
		//Agregar información de competencias en este nivel
		$puestoIndex= $this->getPuestoInfo()->index;
		$this->puestos[$puestoIndex]->competencias = $this->db->order_by('evaluacion, nivel, orden') //El orden no se respeta en la vista.
		->get_where('evaluacion_cuestionario_listado', $w)->result();
		return $this->puestos[$puestoIndex]->competencias;
	}*/
	
	//Obtener secciones de una competencia
	private function competenciaSecciones($com, $incluirValores = true)
	{
		if($com->tipo == "competencia")
		{
			$w = array( 'competencia' => $com->id_competencia );
			$tabla = 'cuestionarios_competencias_secciones';
		}
		else if($com->tipo == "manual")
		{
			$w = array(
				'evaluacion' => $com->evaluacion,
				'id' => $com->id_manual
			);
			$tabla = 'cuestionarios_manual_input';
		}
		
		$r = $this->db->where($w)->order_by('orden')->get($tabla)->result(); //Arreglo de resultados
		
		foreach($r as $kcom => $c)
		{
			if($com->tipo == "competencia") //Para cada sección "competencia" obtener sus posibles respuestas y conductas
			{
				//Respuestas
				/* Las respuestas se asignan a la competencia entera, no a cada conducta. */
				$w = array(
					'evaluacion' => $com->evaluacion,
					'competencia' => $com->id_competencia
				);
				$respuestas = $this->db->where($w)->order_by('valor')->get('competencias_respuestas')->result();
				$com->respuestas = $respuestas; //Estas respuestas sólo sirven para mostrar en HTML como tablita. No son para elegir
				
				//Conseguir los valores reales con id de referencia
				if($incluirValores) $com->valores = $this->db->where($w)->get('competencias_respuestas_valores')->result();
				
				//Conductas
				$conductas = $this->db->where('seccion', $c->id)->order_by('orden')->get('cuestionarios_competencias_secciones_conductas')->result();
				$r[$kcom]->conductas = $conductas;
			}
			else //Obtener información de preguntas abiertas
			{
				//Preguntas
				$preguntas = $this->db->where('contenedor', $c->id)->order_by('orden')->get('cuestionarios_manual_input_preguntas')->result();
				foreach($preguntas as $kpreg => $preg) //Por cada tipo de pregunta obtener su información
				{
					if($preg->tipo == "opciones") //Obtener opciones de esta pregunta
					{
						$opciones = $this->db->where('input', $preg->id)->order_by('orden')->get('cuestionarios_manual_input_preguntas_opciones')->result();
						foreach($opciones as $ko => $opc) //Obtener las respuestas de cada opción
							$opciones[$ko]->respuestas = $this->db->where('input_opciones', $opc->id)->order_by('orden')->get('cuestionarios_manual_input_preguntas_opciones_respuestas')->result();
						
						$preguntas[$kpreg]->opciones = $opciones;
					}
				}
				
				$r[$kcom]->preguntas = $preguntas;
			}
		}
		
		return $r;
	}
	
	/*
	PARA EVALUACIÓN Y AUTOEVALUACIÓN
	La siguiente función muestra el catálogo de competencias según el nivel y puesto de un empleado.
	En el orden correspondiente.
	*/
	public function getCompetenciasNivelPuesto()
	{
		$this->setCompetencias(0);
		$nivelCompetencias = $this->getNivelInfo();
		$puestoCompetencias = array();
		$this->setCompetenciasPreguntas(false);
		foreach($nivelCompetencias->competencias as $keyCompetencia => $competencia)
			if($competencia->vinculaPuestos == 1) //Tiene posicionador
			{
				$vinculaPuestosIndex = $keyCompetencia;
				$this->setCompetencias(1);
				$this->setCompetenciasPreguntas(false, 'puestos');
				$puestoCompetencias = $this->getPuestoInfo();
				
				array_splice( $nivelCompetencias->competencias, $keyCompetencia, 0, $puestoCompetencias->competencias );
				unset($nivelCompetencias->competencias[ ($keyCompetencia + count($puestoCompetencias->competencias)) ]); //Remover posicionador
				break;
			}
		
		// $nivelCompetencias->competencias = array_values($nivelCompetencias->competencias); //Resetear índices
		$this->infoCuestionarios = $nivelCompetencias;
		$this->resetearCompetenciasIndices();
		// return $nivelCompetencias;
	}
	
	/* REGISTRO Y MANIPULACION DE BDD */
	//Registro de competencias de un nivel o un puesto
	public function registrarCompetencias($info)
	{
		$t = 'evaluaciones_cuestionario_' . ( $info->tipo == 0 ? 'niveles' : 'puestos' ); //Switch de tabla nivel/puesto
		$r['error'] = 0;
		
		//Remover todos los registros actuales
		$w = array(
			'evaluacion' => $this->id,
			'nivel' => $info->nivel
		);
		
		//Objetos para conservar
		$competencias = array();
		foreach($info->competencias as $k => $com)
		{
			if($com->tipo == 'competencia')
				$competencias[] = $com->id_competencia;
		}
		
		$manual = array();
		foreach($info->competencias as $com)
			if($com->tipo == 'manual')
				$manual[] = $com->id_manual;
		
		//Eliminar registros que no se van a consevar
		if(count($competencias) > 0)
			$q = $this->db->where_not_in('id_competencia', $competencias);
		else
			$q = $this->db->where('id_competencia IS NOT NULL', null);
		
		$q->where($w)->delete($t);
		
		if(count($manual) > 0)
			$q = $this->db->where_not_in('id_manual', $manual);
		else
			$q = $this->db->where('id_manual IS NOT NULL', null);
		
		$q->where($w)->delete($t);
		
		if(count($info->competencias) == 0)
			$this->db->where($w)->delete($t);
		
		//Resetear el autoincrement porque soy obsesivo
		$this->db->simple_query('ALTER TABLE ' . $t . ' AUTO_INCREMENT=1');
		
		foreach($info->competencias as $com)
		{
			$insert_query = $this->db->insert_string($t, $com);
			$insert_query = str_replace('INSERT INTO', 'INSERT IGNORE INTO',$insert_query);
			
			if(!$this->db->query($insert_query)) $r['error']++;
		}
		
		if($r['error'] > 0)
		{
			$r['msg'] = $r['error'] . " competencias no se registraron.";
		}
		else //Devolver competencias actuales del nivel
		{
			if($info->tipo == 0)
			{
				$this->niveles();
				$this->setNivel($info->nivel);
			}
			else
			{
				$this->puestos();
				$this->setPuesto($info->nivel);
			}
			$r['data'] = $this->setCompetencias($info->tipo);
		}
		
		return $r;
	}
	
	//Insertar respuestas de clave de un nivel o de un puesto
	public function registrarClave($info)
	{
		$r['error'] = 0;		
		$i = array(
			'evaluacion' => $info->evaluacion,
			'nivel' => $info->nivel,
			'usuarioRegistrante' => $this->moguardia->data()['usuario']
		);
		if($info->tipo == 0)
			$tipo = 'niveles';
		else
		{
			$tipo = 'puestos';
			$i['puesto'] = $i['nivel'];
			unset($i['nivel']);
		}
		
		//Registrar histórico
		if(!$this->db->insert('respuestas_clave_historico_' . $tipo, $i))
		{
			$r['error']++;
			$r['msg'] = "Error en inserción de histórico";
		}
		
		if($r['error'] == 0)
		{
			//Resetear respuestas
			$this->db->simple_query('CALL reset_respuestas_clave(' . $info->evaluacion . ', ' . $info->nivel . ', ' . $info->tipo . ')');
			
			//Comenzar inserciones de respuestas
			if(isset($info->respuestas->competencias) and count((array)$info->respuestas->competencias) > 0
			and !$this->db->insert_batch('respuestas_clave_competencias_' . $tipo, obj2ins($info->respuestas->competencias)))
			{
				$r['error']++;
				$r['msg'] = "Error en inserción de respuestas de competencias";
			}
			
			if($r['error'] == 0 and isset($info->respuestas->manual)
			and isset($info->respuestas->manual->abierto) and count((array)$info->respuestas->manual->abierto) > 0
			and !$this->db->insert_batch('respuestas_clave_manual_abierto', obj2ins($info->respuestas->manual->abierto)))
			{
				$r['error']++;
				$r['msg'] = "Error en inserción de respuestas manuales abiertas";
			}
			
			if($r['error'] == 0 and isset($info->respuestas->manual)
			and isset($info->respuestas->manual->opciones) and count((array)$info->respuestas->manual->opciones) > 0
			and !$this->db->insert_batch('respuestas_clave_manual_opciones', obj2ins($info->respuestas->manual->opciones)))
			{
				$r['error']++;
				$r['msg'] = "Error en inserción de respuestas manuales de opciones";
			}
		}
		
		return $r;
	}
	
	//Respuestas de clave de un nivel o de un puesto
	public function respuestasClave($o)
	{
		$tipo = ($o->tipo == 0) ? 'niveles' : 'puestos';
		
		$r = (object)array(
			'competencias' => array(),
			'manual' => (object)array(
				'abierto' => array(),
				'opciones' => array()
			)
		);
		
		$w = array(
			'evaluacion' => $o->evaluacion,
			'nivel' => $o->nivel
		);
		
		//Obtener competencias
		$valores = $this->db->where($w)->get('respuestas_clave_competencias_' . $tipo)->result();
		foreach($valores as $val)
			$r->competencias[$val->id_conducta] = $val->id_valor;
		
		//Obtener manual abierto
		$valores = $this->db->where($w)->get('respuestas_clave_manual_abierto')->result();
		foreach($valores as $k => $val)
		{
			$r->manual->abierto[$val->id_manual_input_pregunta . '_' . $val->indice] = $val->valor;
		}
		
		//Obtener manual opciones
		$valores = $this->db->where($w)->get('respuestas_clave_manual_opciones')->result();
		foreach($valores as $k => $val)
		{
			$r->manual->opciones[$val->id_opciones_input_manual] = (object)array(
				'id_opcion_respuesta' => $val->id_opcion_respuesta,
				'valor_manual' => $val->valor_manual
			);
		}
		
		return $r;
	}

	//Remover respuestas abiertas (Para autoevaluaciones)
	public function removerPreguntasAbiertas()
	{
		$manualIndex = -1;
		foreach($this->infoCuestionarios->competencias as $k => $v)
		{
			if($v->tipo == "manual")
			{
				$manualIndex = $k;
				break;
			}
		}
		
		if($manualIndex >= 0)
		{
			unset($this->infoCuestionarios->competencias[$manualIndex]);
			$this->resetearCompetenciasIndices();
		}
	}
	
	//Reordenar índices de competencias obtenidas
	private function resetearCompetenciasIndices()
	{
		$this->infoCuestionarios->competencias = array_values($this->infoCuestionarios->competencias); //Resetear índices
	}
}