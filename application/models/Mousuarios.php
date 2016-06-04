<?php
class Mousuarios extends CI_Model
{
	//Variables del modelo.
	var $id = 0;
	var $formName = '';
	var $tabla = 'usuarios';
	
	//Devuelve el objeto de la clase.
	public function init(){ return $this; }
	
	//Campos y opciones del formulario
	public function campos()
	{
		$campos = array(
			'usuario' => array(
				'type' => 'text',
				'placeholder' => 'Usuario',
				'required' => 'required',
				'autofocus' => 'autofocus'
			),
			'nombre' => array(
				'type' => 'text',
				'placeholder' => 'Nombre',
				'required' => 'required',
				'autofocus' => 'autofocus'
			),
			'email' => array(
				'type' => 'text',
				'placeholder' => 'Email'
			),
			'telefono' => array(
				'type' => 'text',
				'placeholder' => 'Teléfono'
			),
			'pass1' => array(
				'type' => 'password',
				'placeholder' => 'Contraseña'
			),
			'pass2' => array(
				'type' => 'password',
				'placeholder' => 'Confirma contraseña'
			),
			'permisos' => array(
				'type' => 'select',
				'multiple' => 'multiple',
				'size' => 10,
				'options' => array(
					'4' => 'Reservaciones',
					'3' => 'Establecimientos',
					'2' => 'Líderes (completo)',
					'5' => 'Líderes (limitado)',
					'1' => 'Usuarios',
					'6' => 'Reportes'
				),
				'placeholder' => 'Permisos'
			)
		);
		
		//Agregar nombre del campo
		foreach($campos as $k => $v) $campos[$k]['name'] = $k;
		return $campos;
	}
	
	//Regresar cadenas de campo en HTML
	public function campos_html()
	{
		$this->load->library('campo');
		$campos = array();
		foreach($this->campos() as $nombre => $atributos)
		{
			$c = new campo();
			$c->formName = $this->formName;
			foreach($atributos as $attr => $value) $c->$attr = $value;
			
			//Especificar modelo
			$c->model = $this->formName . '.' . $nombre;
			
			$campos[$nombre] = $c->crear();
		}
		
		return $campos;
	}

	//Registrar / editar
	var $obj;
	public function registrar()
	{
		$r['error'] = 0;
		
		//Agregar datos extra
		$userData = $this->moguardia->data();
		if(isset($this->obj->id))
			$insert = $this->obj->id === 0;
		else
			$insert = false;
		unset($this->obj->id);
		
		//Establecer contraseña
		if(isset($this->obj->pass1) and strlen($this->obj->pass1) > 0 and strlen($this->obj->pass2) > 0)
		{
			$this->obj->pass = sha1($this->obj->pass1);
			unset($this->obj->pass1);
			unset($this->obj->pass2);
		}
		
		if($insert) //Inserción
		{
			if(!$this->db->insert($this->tabla, $this->obj)) $r['error']++;
		}
		else //Actualización
			if(!$this->db->where('usuario', $this->obj->usuario)->update($this->tabla, $this->obj)) $r['error']++;
		
		//Verificar el error
		if($r['error'] > 0)
		{
			$mysql_error = $this->db->error();
			switch($mysql_error['code'])
			{
				case 1062:
					$r['msg'] = 'Este registro está duplicado.';
					$r['sq'] = $this->db->last_query();
					break;
					
				default:
					$r['info'] = $mysql_error;
					$r['msg'] = 'El motivo no pudo ser determinado.';
			}
		}
		return $r;
	}
}