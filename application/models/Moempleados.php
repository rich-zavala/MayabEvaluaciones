<?php
class Moempleados extends CI_Model
{
	//Variables del modelo.
	var $formName = '';
	var $tabla = 'empleados';
	
	//Devuelve el objeto de la clase.
	public function init(){ return $this; }
	
	//Campos y opciones del formulario
	public function campos()
	{
		$campos = array(
			'empleado' => array(
				'type' => 'text',
				'placeholder' => 'Empleado',
				'required' => 'required',
				'autofocus' => 'autofocus'
			),
			'nombre' => array(
				'type' => 'text',
				'placeholder' => 'Nombre',
				'required' => 'required',
				'autofocus' => 'autofocus'
			),
			'apellido_paterno' => array(
				'type' => 'text',
				'placeholder' => 'Apellido paterno',
				'required' => 'required',
				'autofocus' => 'autofocus'
			),
			'apellido_materno' => array(
				'type' => 'text',
				'placeholder' => 'Apellido materno',
				'autofocus' => 'autofocus'
			),
			'email' => array(
				'type' => 'email',
				'required' => 'required',
				'placeholder' => 'Email'
			),
			'departamento' => array(
				'type' => 'select',
				'options' => $this->get_form_options('departamentos'),
				'required' => 'required',
				'placeholder' => 'Departamento'
			),
			'puesto' => array(
				'type' => 'select',
				'options' => $this->get_form_options('puestos'),
				'required' => 'required',
				'placeholder' => 'Puesto'
			),
			'area' => array(
				'type' => 'select',
				'options' => $this->get_form_options('areas'),
				'required' => 'required',
				'placeholder' => 'Área'
			),
			'nivel' => array(
				'type' => 'select',
				'options' => $this->get_form_options('niveles'),
				'required' => 'required',
				'placeholder' => 'Nivel'
			),
			'fechaAlta' => array(
				'type' => 'date',
				'required' => 'required',
				'placeholder' => 'Fecha de alta'
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
		
		//Identificar alteración
		$w = array('empleado' => $this->obj->empleado);
		$insert = $this->db->select('empleado')->where($w)->get('empleados')->num_rows() == 0;
		
		if($insert) //Inserción
		{
			if(!$this->db->insert($this->tabla, $this->obj)) $r['error']++;
		}
		else //Actualización
			if(!$this->db->where($w)->update($this->tabla, $this->obj)) $r['error']++;
		
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
		else
		{
			//Obtener datos nuevos con aliases
			$r['datos'] = $this->db->where('empleado', $this->obj->empleado)->order_by('n')->get('empleados_formato')->row();
		}
		return $r;
	}
	
	/* Catálogos para opciones de formulario */
	public function get_form_options($table)
	{
		$options = array();
		foreach($this->db->order_by('titulo')->get($table)->result() as $r)
			$options[$r->codigo] = $r->titulo;
		
		return $options;
	}
}