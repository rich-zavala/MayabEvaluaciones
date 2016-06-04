<?php
class Mocartas extends CI_Model
{
	var $evaluacion = 0;
	var $tipo = 0;
	public $info;
	public $empleado;
	public $envio;
	public $empleadosTotales;
	
	//Devuelve el objeto de la clase.
	public function init(){
		return $this;
	}
	
	//Setear evaluacion
	public function evaluacion($i){ $this->evaluacion = (int)$i; }
	
	//Setear tipo
	public function tipo($i){ $this->tipo = (int)$i; }
	
	//Setear empleado
	public function empleado($i){ $this->empleado = (int)$i; }
	
	//Setear id de envío
	public function envio($i){ $this->envio = (int)$i; }
	
	//Setear empleados totales
	public function empleadosTotales($i){ $this->empleadosTotales = (int)$i; }
	
	//Obtener información de envío de cartas
	public function info($incluirJerarquias = true)
	{
		$r = (object)array( 'id' => 0, 'jerarquia' => (object)array() );
		
		if($incluirJerarquias)//Obtener jerarquía
		{
			$this->load->model('evaluaciones/mojerarquias');
			$this->mojerarquias->init($this->evaluacion)->get();
			if($this->tipo == 0) $this->mojerarquias->soloJefes();
			$r->jerarquia = $this->mojerarquias->registros;
		}
		
		//Datos principales
		$w = array(
			'evaluacion' => $this->evaluacion,
			'tipo' => $this->tipo
		);
		
		$q = $this->db->where($w)->order_by('id', 'DESC')->limit(1)->get('cartas_envios_detalle');
		if($q->num_rows() > 0) //Existe un registro
		{
			foreach($q->row() as $k => $v)
				$r->$k = $v;
				
			//Avance porcentual
			$r->avance = (int)(($r->avance / $r->empleadosTotales) * 100);
			
			//Obtener información de las cartas enviadas
			$w['envio'] = $r->id;
			$envios = $this->db->where($w)->get('cartas_envios_relacion')->result();
			
			//Agregar información de envío a aquellos empleados que estén enlistados
			foreach($r->jerarquia as $k => $v)
				$r->jerarquia[$k] = $this->empleadoCarta($v, $envios);
		}
		
		$this->info = $r;
	}
	
	//Asignar información de carta a un empleado recursivamente
	public function empleadoCarta($empleado, $cartas)
	{
		if(is_object($empleado))
		{
			$empleado->carta = array( 'envio' => 0 );
			foreach($cartas as $carta)
			{
				if($empleado->empleado == $carta->empleado)
				{
					$empleado->carta = array(
						'envio' => $carta->envio,
						'fechaRegistro' => $carta->fechaRegistro
					);
					break;
				}
			}
				
			if(isset($empleado->subordinados) and count($empleado->subordinados) > 0)
				foreach($empleado->subordinados as $k => $subordinado)
					$empleado->subordinados[$k] = $this->empleadoCarta($subordinado, $cartas);
		}
		
		return $empleado;
	}
	
	//Generar el contenido de una carta de un empleado según el tipo
	public function contenido()
	{
		$columna = 'tipo_' . $this->tipo;
		$w = array( 'evaluacion' => $this->evaluacion );
		$template = $this->db->where($w)->get('cartas_templates')->row()->$columna;
		
		//Generar vínculo dependiendo del tipo
		$empleadoInfo = $this->db->select('n, email, MD5(n) clave')->where('empleado', $this->empleado)->order_by('n')->get('empleados_formato')->row();
		$vinculo = ($this->tipo == 0) ?
			base('evaluar/inicio/' . $this->evaluacion . '/' . $empleadoInfo->clave)		//Evaluación
		:	base('evaluar/autoevaluacion/' . $this->evaluacion . '/' . $empleadoInfo->clave);		//Autoevaluación
		
		//Reemplazar comodines
		$template = str_replace('[empleado_nombre]', $empleadoInfo->n, $template);
		$template = str_replace('[vinculo]', $vinculo, $template);
		
		return array(
			'vinculo' => $vinculo,
			'email' => $empleadoInfo->email,
			'texto' => $template
		);
	}
	
	//Registrar índice de envío
	public function nuevoEnvio()
	{
		$i = array(
			'evaluacion' => $this->evaluacion,
			'tipo' => $this->tipo,
			'usuarioRegistrante' => $this->moguardia->data()['usuario'],
			'empleadosTotales' => $this->empleadosTotales
		);
		$this->db->insert('cartas_envios', $i);
		$this->envio($this->db->insert_id());
	}

	//Enviar una carta por email
	public function enviar()
	{
		$r = array( 'error' => 0 );
		$contenido = $this->contenido();
		
		//Registrar en BDD
		$i = array(
			'envio' => $this->envio,
			'empleado' => $this->empleado,
			'email' => $contenido['email'],
			'carta' => $contenido['texto']
		);
		$this->db->insert('cartas_envios_empleados', $i);
		$envioId = $this->db->insert_id();
		
		$this->load->library('emailuam');
		$this->emailuam->to($contenido['email']);
		$this->emailuam->subject('Evaluación de empleados');
		$this->emailuam->message($contenido['texto']);
		
		if($this->emailuam->send())
		{
			$this->info(false);
			$r['avance'] = $this->info->avance;
			$r['id_envio_empleado'] = $envioId;
		}
		else
		{
			$this->db->where('id', $envioId)->delete('cartas_envios_empleados');
			$r['error']++;
		}
		
		return $r;
	}
}