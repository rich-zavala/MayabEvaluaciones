<?php
/*
Rich 29 Abril 2015
Modelo que permite crear el objeto de cabecera de manera dinámica
$css > Contiene arreglo de css a agregar, aparte de los estándares
$js > Contiene arreglo de js a agregar, aparte de los estándares
*/
class Moheader extends CI_Model
{
	var $assetsPath; //Ruta de la carpeta con librerías
	
	//Librerías CSS predeterminadas
	var $css = array(
		'AdminLTE-2.3.0/bootstrap/css/bootstrap.min.css',
		'components/fa/css/font-awesome.min.css',
		'components/bootstrap-datepicker/bootstrap-datepicker.css',
		'AdminLTE-2.3.0/dist/css/AdminLTE.css',
		'AdminLTE-2.3.0/dist/css/skins/skin-yellow.min.css',
		'AdminLTE-2.3.0/plugins/iCheck/flat/blue.css',
		'AdminLTE-2.3.0/plugins/morris/morris.css',
		// 'AdminLTE-2.3.0/plugins/datepicker/datepicker3.css'
		'css/estilos.css'
	);
	
	//Librerías JS predeterminadas
	var $js = array(
		'components/jquery/jquery.min.js',
		'AdminLTE-2.3.0/bootstrap/js/bootstrap.min.js',
		'components/jqueryui/jquery-ui.min.js',
		'components/jqueryblock/jquery.blockUI.js',
		'components/bootstrap-datepicker/bootstrap-datepicker.min.js',
		'components/bootstrap-datepicker/bootstrap-datepicker.es.min.js',
		'AdminLTE-2.3.0/plugins/daterangepicker/moment.min.js',
		'AdminLTE-2.3.0/plugins/slimScroll/jquery.slimscroll.min.js',
		'AdminLTE-2.3.0/plugins/fastclick/fastclick.min.js',
		'AdminLTE-2.3.0/dist/js/app.min.js',
		'AdminLTE-2.3.0/plugins/iCheck/icheck.min.js',
		'components/angular/angular.js',
		// 'components/angular/angular-sanitize.min.js',
		'components/angular/ui-bootstrap-tpls-1.3.1.min.js',
		'js/funciones.js'
	);
	
	function __construct() {
		parent::__construct();
		$this->assetsPath = $this->config->item('base_url') . 'r_/';
	}
	
	function init(){ return $this;	}
	
	//Agregar un css
	function addCss($ruta){ $this->css[] = $ruta; }
	
	//Agregar un js
	function addJs($ruta){ $this->js[] = $ruta; }
	
	//Generar cadena de includes CSS
	function include_css()
	{
		$s = '';
		$this->css = array_unique($this->css);
		foreach($this->css as $o) $s .= "<link rel='stylesheet' href='" . $this->assetsPath . $o . "'>\n";
		return $s;
	}
	
	//Generar cadena de includes CSS
	function include_js()
	{
		$s = '';
		$this->js = array_unique($this->js);
		foreach($this->js as $o) $s .= "<script src='" . $this->assetsPath . $o . "'></script>\n";
		return $s;
	}
}