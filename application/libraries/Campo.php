<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed'); 

class Campo {
	//Atributos del campo
	var $name, $type, $placeholder, $class, $model, $options, $value, $required, $readonly, $min, $max, $autofocus, $rows, $id, $label, $multiple, $size, $formName;
	
	//Crear campo
	public function crear()
	{
		$campo = '';
		$this->formName = '_' . $this->formName;
		$this->label = $this->placeholder;
		
		//Ampliar el estilo
		$this->class .= ' form-control';
		
		//Establecer atributos obligatorios
		$attrs = array(
			'name' => $this->name,
			'type' => $this->type,
			'placeholder' => $this->placeholder,
			'class' => 'input-sm '
		);
		
		//Establecer atributos opcionales
		if(strlen(trim($this->class)) > 0) $attrs['class'] .= $this->class;
		if(strlen(trim($this->model)) > 0) $attrs['ng-model'] = $this->model;
		if(strlen(trim($this->readonly)) > 0) $attrs['readonly'] = $this->readonly;
		if(strlen(trim($this->min)) > 0) $attrs['min'] = $this->min;
		if(strlen(trim($this->min)) > 0) $attrs['min'] = $this->min;
		if(strlen(trim($this->autofocus)) > 0) $attrs['autofocus'] = $this->autofocus;
		if(strlen(trim($this->rows)) > 0) $attrs['rows'] = $this->rows;
		if(strlen(trim($this->multiple)) > 0) $attrs['multiple'] = $this->multiple;
		if(strlen(trim($this->size)) > 0) $attrs['size'] = $this->size;
		if(strlen(trim($this->required)) > 0)
		{
			$attrs['required'] = $this->required;
			$this->label .= '*';
		}
		
		//Especificar name como id si no está especificado
		if(strlen(trim($this->id)) == 0) $attrs['id'] = $this->name;
		
		switch($this->type)
		{
			case 'text':
			case 'email':
			case 'number':
				$campo = form_input($attrs);
				break;
				
			case 'password':
				$campo = form_password($attrs);
				break;
				
			case 'textarea':
				$campo = form_textarea($attrs);
				break;
				
			case 'date':
				$attrs['type'] = 'text';
				$attrs['class'] .= ' date';
				$campo = form_input($attrs);
				break;
				
			case 'select':
				//Definir atributos
				$atributos = array();
				foreach($attrs as $attr => $value) $atributos[] = $attr . "='{$value}'";
				
				$campo = form_dropdown($this->name, $this->options, null, implode(" ", $atributos));
				break;
		}
		
		//Crear objeto de Bootstrap
		$formObj = $this->formName . '.' . $this->name;
		$campo = '<div class="form-group" ng-class="{ \'has-error\': ' . $formObj . '.$invalid && ' . $formObj . '.$touched }">
								<label for="' . $attrs['id'] . '">' . $this->label . '</label>
								' . $campo . '
							</div>';

		return $campo;
	}

	//Regresar cadenas de campo en HTML
	public function campos_html($campos_array, $formName)
	{
		// $this->load->library('campo');
		$campos = array();
		foreach($campos_array as $nombre => $atributos)
		{
			$c = new campo();
			$c->formName = $formName;
			foreach($atributos as $attr => $value) $c->$attr = $value;
			
			//Especificar modelo
			$c->model = $formName . '.' . $nombre;
			
			$campos[$nombre] = $c->crear();
		}
		
		return $campos;
	}
}

?>