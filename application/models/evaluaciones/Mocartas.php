<?php
/*
Este modelo se encarga de informar y enviar las cartas de bienvenida y de reportes.
Identifica el controlador y aplica los switches correspondientes.
*/

class Mocartas extends CI_Model
{
	var $evaluacion = 0;
	var $tipo = 0;
	public $info;
	public $empleado;
	public $envio;
	public $empleadosTotales;
	private $m; //Identificador de modalidad (Cartas/Reportes)
	private $pdf_url;
	private $repDir;
	private $workPath;
	private $reporte_destinatario;
	private $imprimible;
	
	//Init: Identifica el contolador y discierne entre Cartas y Reportes
	function __construct() {
		$ci =& get_instance();
		$this->m = $ci->router->class;
		$this->pdf_url = base() . 'pdf/template/';
		$this->workPath = FCPATH;
		$this->repDir = FCPATH . 'reportes/';
	}
	
	//Devuelve el objeto de la clase.
	public function init(){ return $this; }
	
	//Setear evaluacion
	public function evaluacion($i){ $this->evaluacion = (int)$i; }
	
	//Setear tipo
	public function tipo($i){ $this->tipo = (int) $i; }
	
	//Setear imprimible
	public function imprimible($i){ $this->imprimible = (int)$i; }
	
	//Setear empleado
	public function empleado($i){ $this->empleado = (int)$i; }
	
	//Setear id de envío
	public function envio($i){ $this->envio = (int)$i; }
	
	//Setear empleados totales
	public function empleadosTotales($i){ $this->empleadosTotales = (int)$i; }
	
	//Definir modalidad de reporte
	public function reporte_destinatario($i){ $this->reporte_destinatario = $i; }
	
	//Obtener información de envío de cartas
	public function info($incluirJerarquias = true)
	{
		$r = (object)array( 'id' => 0, 'jerarquia' => (object)array() );
		
		if($incluirJerarquias)//Obtener jerarquía
		{
			$this->load->model('evaluaciones/mojerarquias');
			$this->mojerarquias->init($this->evaluacion)->get();
			if($this->tipo == 0) $this->mojerarquias->soloJefes(); //Para reportes se da la jerarquía completa
			$r->jerarquia = $this->mojerarquias->registros;
		}
		
		//Datos principales
		$w = array(
			'evaluacion' => $this->evaluacion,
			'tipo' => $this->tipo
		);
		
		$q = $this->db->where($w)->order_by('id', 'DESC')->limit(1)->get($this->m . '_envios_detalle');
		if($q->num_rows() > 0) //Existe un registro
		{
			foreach($q->row() as $k => $v)
				$r->$k = $v;
				
			//Avance porcentual
			$r->avance = (int)(($r->avance / $r->empleadosTotales) * 100);
			
			//Obtener información de las cartas enviadas
			$w['envio'] = $r->id;
			$envios = $this->db->where($w)->get($this->m . '_envios_relacion')->result();
			
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
	//$reportes_modalidad > 0 - Eval, 1 - Autoeval
	public function contenido($reportes_modalidad = false)
	{
		$columna = 'tipo_' . $this->tipo;
		
		//Para reportes
		// if($reportes_modalidad != false and $this->tipo != 1)
			// $columna .= $reportes_modalidad;
		
		$w = array( 'evaluacion' => $this->evaluacion );
		$template = $this->db->where($w)->get($this->m . '_templates')->row()->$columna;
		
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
		$this->db->insert($this->m . '_envios', $i);
		$this->envio($this->db->insert_id());
	}

	//Enviar una carta por email
	/* Si el empleado está inactivo se registrará una carta vacía y no se enviará. Esto es para la sumatoria de avances. */
	public function enviar()
	{
		$continuar = true;
		$r = array( 'error' => 0 );
		$st = $this->db->where('empleado', $this->empleado)->get('empleados')->row()->status == 0;
		$contenido = $st ? $this->contenido() : array( 'email' => '', 'texto' => 'Empleado inactivo');
			
		//Registrar en BDD
		$i = array(
			'envio' => $this->envio,
			'empleado' => $this->empleado,
			'email' => $contenido['email'],
			'carta' => $contenido['texto']
		);
		
		//Resetear envío anterior (puede quedar inconsistente por algún error de 3ra parte)
		$this->db->trans_start();
		$this->db->where( array('envio' => $this->envio, 'empleado' => $this->empleado) )->delete($this->m . '_envios_empleados');
		$this->db->insert($this->m . '_envios_empleados', $i);
		$envioId = $this->db->insert_id();
		
		$this->info(false);
		$r['avance'] = $this->info->avance;
		$r['id_envio_empleado'] = $envioId;
		
		if($st) //Enviar si el empleado está activo
		{
			switch($this->m)
			{
				case 'reportes':
					$subject = 'Evaluación de desempeño: Reporte de resultados';
					break;
				default:
					$subject = 'Evaluación de desempeño';
					break;
			}
			
			$this->load->library('emailuam');
			$this->emailuam->to($contenido['email']);
			$this->emailuam->subject($subject);
			$this->emailuam->message($contenido['texto']);
			
			//Anexar archivo de reporte
			if($this->m == 'reportes')
			{
				if($this->tipo == 0)
				{
					/*
					A los jefes se les envía un comprimido con las evaluaciones y autoevaluaciones de sus subordinados
					*/
					$file = $this->comprimido();
					if(!$file['error'])
						$this->emailuam->attach($file['path']);
					else
					{
						$continuar = false;
						$this->emailuam->message('No se encontraron resultados.');
					}
				}
				else
				{
					/*
					A los coloaboradores se les envía los reportes individuales de su evaluación y autoevaluación
					*/
					$e = (object) array( 'empleado' => $this->empleado );
					
					//Evaluacion
					$evalData = $this->subordinados_con_respuestas($this->empleado);
					// p($evalData);
					// p($this->db->last_query());
					if(count($evalData) > 0)
					{
						$this->tipo(0);
						$data = $this->generarPDF($e, 'colaborador');
						// p($data);
						$this->emailuam->attach($data->path);
						$conPDF = true;
					}
					
					//Autoevaluación
					if($this->autoevaluacion_hecha())
					{
						$this->tipo(1);
						$data = $this->generarPDF($e, 'colaborador');
						// p($this->emailuam);
						$this->emailuam->attach($data->path);
						$conPDF = true;
					}
				}
			}
			
			if($this->tipo == 0 or ($this->tipo == 1 and isset($conPDF)))
			{
				if($continuar)
				{			
					if(!$this->emailuam->send())
					{
						$this->db->where('id', $envioId)->delete($this->m . '_envios_empleados');
						$r['error']++;
					}
				}
				else
					$this->db->where('id', $envioId)->delete($this->m . '_envios_empleados');
			}
		}
		
		//Ejecutaar transacción
		if($continuar)
			$this->db->trans_complete();

		return $r;
	}
	
	/*
	Funciones de reportes
	*/
	
	//Saber si un empleado hizo autoevaluación
	private function autoevaluacion_hecha()
	{
		$w = array( 'evaluacion' => $this->evaluacion, 'empleado' => $this->empleado );
		return $this->db->where($w)->select('1')->from('respuestas_autoevaluacion re')->get()->num_rows() > 0;
	}
	
	//Obtener sólamente los subordinados con respuestas
	//$empleado > Se le puede pasar el id de un empleado único
	private function subordinados_con_respuestas($empleado = 0)
	{
		$w = array( 're.evaluacion' => $this->evaluacion);
		if($empleado == 0)
			$w['ree.evaluador'] = $empleado;
		else
			$w['ree.empleado'] = $empleado;
		
		$q = $this->db->where($w)
									->select('re.evaluacion, re.evaluador, ree.empleado, n')
									->from('respuestas_evaluacion re')
									->join('respuestas_evaluacion_empleados ree', 'ree.id_respuestas_evaluacion = re.id')
									->join('empleados_formato ef', 'ef.empleado = ree.empleado');
		return $q->get()->result();
	}
	
	//Generar un PDF
	/*
	$e > Resultado de un objeto arrojado por "subordinados_con_respuestas"
	$modalidad > jefe (con puntajes) ó colaborador (sin puntajes)
	*/
	public function generarPDF($e, $modalidad)
	{
		set_time_limit(60);
		$error = 0;
		$sufijo  = ($this->tipo == 0) ? '_evaluacion' : '_autoevaluacion';
		$sufijo  .= ($modalidad == 'jefe') ? '_completo' : null;
		$fecha = date('d')." ".Meses(date('m')-1).", ".date('Y');
		$url = $this->pdf_url . $this->evaluacion . '/' . $this->tipo . '/' . $modalidad . '/' . $e->empleado;
		
		//Para imprimible
		if($this->imprimible == 1)
		{
			$url .= '/1';
			$sufijo .= '_imprimible';
		}
		
		$url .= suffix();
		
		$fileDir = $this->repDir . $this->evaluacion;
		@mkdir($fileDir);
		$fileDir .= '/pdf/';
		@mkdir($fileDir);
		
		if(!isset($e->n)) $e->n = $this->db->where('empleado', $e->empleado)->get('empleados_formato')->row()->n;
		
		$fileName = $e->empleado . ' - ' . utf8_decode($e->n) . $sufijo . '.pdf';
		$filePath = $fileDir . $fileName;
		$tmpFile = 'reportes/tmp_' . $e->empleado .  '.pdf';
		
		if(!file_exists($filePath))
		{
			try {
				$command = ' -q -L 7 -R 7 -T 8 -B 8 --page-size Letter --image-quality 100 --footer-right [page]/[topage] --footer-left "' . $fecha . '" --footer-font-size 6';
				$command .= ' ' . $url . ' ' . escapeshellarg($this->workPath. $tmpFile) . ' ' . ' 2>&1';
				$command = "\"C:\\Program Files\\wkhtmltopdf\\bin\\wkhtmltopdf\"" . $command;
				ob_start();
				system($command, $retval);
				$returnValue = ob_get_contents();
				ob_end_clean();
				echo $returnValue;
				if($retval == 1) $error++;
			} catch (Exception $e) {
				$error++;
			}

			// Output the results
			if ($error > 0) {
				@unlink($tmpFile);
			} else {
				rename($tmpFile, $filePath);
			}
		}
		
		return (object) array(
			'dir' 			=> $fileDir,
			'path' 			=> $filePath,
			'url' 			=> base() . 'reportes/' . $this->evaluacion . '/pdf/' . $fileName,
			'template' 	=> $url,
			'error' 		=> $error
		);
	}
	
	//Generar comprimido de los PDF de reportes para un jefe
	public function comprimido()
	{
		set_time_limit(60);
		$targetDir = $this->repDir . $this->evaluacion . '/zip/';
		@mkdir($targetDir);
		
		$fileName = 'reportes_'. $this->empleado . '.zip';
		$targetURL = base() . 'reportes/' . $this->evaluacion . '/zip/' . $fileName;
		$targetFile = $targetDir . $fileName;
		@unlink($targetFile); //Para forzar la generación del archivo
		
		$err = false;
		if(!file_exists($targetFile))
		{
			//Generar los PDF
			$files = array();
			$subordinados = $this->subordinados_con_respuestas();
			if(count($subordinados) > 0)
			{
				foreach($subordinados as $s)
				{
					for($tipo = 0; $tipo < 2; $tipo++)
					{
						$this->tipo($tipo);
						$pdf = $this->generarPDF($s, 'jefe');
						if($pdf->error == 0)
						{
							$files[] = $pdf->path;
							if(!isset($rootPath)) $rootPath = realpath($pdf->dir);
						}
					}
				}

				// Initialize archive object
				if(count($files) > 0)
				{
					$zip = new ZipArchive();
					$zip->open($targetFile, ZipArchive::CREATE | ZipArchive::OVERWRITE);
					
					foreach ($files as $file)
						$zip->addFile($file, iconv('ISO-8859-1', 'IBM850', substr(str_replace('_completo', '', $file), strlen($rootPath) + 1)));

					$zip->close();
				}
				else $err = true;
			}
			else
				$err = true; //No hay subordinados con respuestas
		}
		
		return array(
			'error' => $err,
			'path' => $targetFile,
			'url' => $targetURL
		);
	}
}