<?php
/*Identifica si una cadena es un rango de fechas*/
function parseRango($rango){
	$rango = trim($rango);
	$r = explode(' - ', $rango);
	if(count($r) == 2)
	{
		if(validateDate($r[0]) and validateDate($r[1]))
			return $r;
		else return false;
	}
	else return false;
}

/*Valida una fecha en formato YYYY-dd-mm*/
function validateDate($date){
  $d = DateTime::createFromFormat('Y-m-d', $date);
  return $d && $d->format('Y-m-d') == $date;
}

function p($s){
	if(!is_string($s))
	{
		echo "<pre>";
		print_r($s);
		echo "</pre>";
	}
	else
	{
		echo nl2br($s);
	}
}

function selected($i1, $i2, $echo = true){
	if($i1 == $i2)
	{
		if($echo)
		{
			echo "selected";
		}
		else
		{
			return "selected";
		}
	}
}

function checked($i1, $i2, $echo = true){
	if($i1 == $i2)
	{
		if($echo)
		{
			echo "checked";
		}
		else
		{
			return "checked";
		}
	}
}

function checkedArray($i, $array){
	if(is_array($array) and in_array($i, $array))
		return 'checked';
	else
		return null;
}

function selectedArray($i, $array){
	// p($array);
	if(is_array($array) and in_array($i, $array))
		return 'selected';
	else
		return null;
}

function now(){ return date('Y-m-d H:i:s'); }

function now_fecha(){ return date('Y-m-d'); }

function Meses($m){
	$meses = array("", "Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre");
	return $meses[$m];
}
	
// Devuelve la cadena PM o AM, dependiendo de la hora que sea
function FormatoHora($f){
	list($fecha, $hora) = explode(" ", $f);
	list($hora, $min, $seg) = explode(":", $hora);
	if($hora >=12) {
		$texto = "pm";
		if($hora>12) { $hora -= 12; }
	} else {
		$texto = "am";
	}
	$hh = $hora.":".$min.$texto;
	return $hh;
}

function FormatoFechaHora($f){
	list($fecha, $hora) = explode(" ", $f);
	list($anio, $mes, $dia) = explode("-", $fecha);
	$ff = $dia." de ".Meses((int) $mes)." del ".$anio." a la(s) ".FormatoHora($f);
	return $ff;
}

function suffix(){
	$ci =& get_instance();
	return $ci->config->item('url_suffix');
}

//Obtiene el URL base del sitio. Puede pasársele una variable para concatenar.
function base($url = ""){
	$ci =& get_instance();
	$base = $ci->config->item('base_url');
	if(strlen($url)) $base .= $url . suffix();
	return $base;
}

function username(){
	$ci =& get_instance();
	return $ci->session->userdata('nombre');
}

function dosDecimales($number){ return number_format((float)$number, 2, '.', ''); }

function emailConfig(){
	return array(
		'protocol' => 'smtp',
		'smtp_host' => 'localhost',
		'mailtype' => 'html',
		'wordwrap' => true
	);
}

//Canchas
function cancha($n){
	$canchas = array(
		0 => 'CH',
		1 => 'CH',
		2 => 'PRO'
	);
	
	return $canchas[$n];
}

//Descripción de cancha
function canchaTxt($n){
	$canchas = array(
		0 => 'Cancha chica',
		1 => 'Cancha chica',
		2 => 'Cancha profesional'
	);
	
	return $canchas[$n];
}

//Dibujar renglón de goles de jugador
function jugadorGoles($j, $reverse, $tabindex = 0){
	$textDirection = ($reverse) ? "text-right" : "";
	
	/*
	$campo = "<td class='text-center'><input id='gol{$j->ID_Jugador}' type='number' class='form-control input-sm inputSmall text-center gol{$j->ID_Equipo} golJugador' data-equipo='{$j->ID_Equipo}' name='goles_jugador[{$j->ID_Equipo}][{$j->ID_Jugador}][{$j->goles->id_goles}]' value='{$j->goles->goles}' tabindex='{$tabindex}'></td>";
	$nombre = "<td class='{$textDirection}' width='*'><label for='gol{$j->ID_Jugador}' class='normal margin0'>{$j->NomJug} {$j->ApeJug}</label></td>";$campo = "<td class='text-center'><input id='gol{$j->ID_Jugador}' type='number' class='form-control input-sm inputSmall text-center gol{$j->ID_Equipo} golJugador' data-equipo='{$j->ID_Equipo}' name='goles_jugador[{$j->ID_Equipo}][{$j->ID_Jugador}][{$j->goles->id_goles}]' value='{$j->goles->goles}' tabindex='{$tabindex}'></td>";
	*/
	$mrgn = ($reverse) ? 'marginLeft10' : 'marginRight10';
	
	$campo = "<div class='puntajeJugador {$mrgn}'><input id='gol{$j->ID_Jugador}' type='number' class='form-control input-sm inputSmall text-center gol{$j->ID_Equipo} golJugador' data-equipo='{$j->ID_Equipo}' name='goles_jugador[{$j->ID_Equipo}][{$j->ID_Jugador}]' value='{$j->goles}' tabindex='{$tabindex}'></div>";
	$nombre = "<label for='gol{$j->ID_Jugador}' class='normal margin0'>{$j->NomJug} {$j->ApeJug}</label>";
	$row = "<td colspan='2' class='puntajeJugadores %s'>%s %s</td>";
	
	if($reverse)
		printf($row, "text-right", $nombre, $campo);
	else
		printf($row, null, $campo, $nombre);
}

function actualURL(){
	return "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
}

function archivo_extension($s){
	$archivoPartes = explode('.', $s);
	return $archivoPartes[count($archivoPartes) - 1];
}

function sanitize($s){
	$s = preg_replace("([^\w\s\d\-_~,;:\[\]\(\).])", '', $s);
	return strtolower(preg_replace("([\.]{2,})", '', $s));
}

function sortByNombre($a, $b) {
  return strcmp($a['nombre'], $b['nombre']);
}

function money($num)
{
	return number_format($num, 2);
}

function mes($i)
{
	$m = array ( null, "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic");
	return $m[$i];
}

function getIsoWeeksInYear($year)
{
    $date = new DateTime;
    $date->setISODate($year, 53);
    return ($date->format("W") === "53" ? 53 : 52);
}

//Convierte un objeto asociativo en arreglo para inserción en BDD
function obj2ins($obj)
{
	$r = array();
	foreach($obj as $o) $r[] = $o;
	return $r;
}

//Agrega el id de evaluacion_empleado a un todos los elementos de un objeto de inserción
function addResId($obj, $id)
{
	foreach($obj as $k => $v)
		$obj->$k->id_evaluacion_empleado = $id;
	
	return $obj;
}

/* Definir color para PDF */
function cl($current, $max)
{
	if($current == 0)
	{
		return 'lv-min';
	}
	else if($max == 5)
	{
		switch($current)
		{
			case 1:
				return 'lv-min-a';
			break;
			case 2:
				return 'lv-mid';
			break;
			case 3:
				return 'lv-mid-a';
			break;
			case 4:
				return 'lv-max';
			break;
		}
	}
	else if($max == 4)
	{
		switch($current)
		{
			case 1:
				return 'lv-min-b';
			break;
			case 2:
				return 'lv-mid-b';
			break;
			case 3:
				return 'lv-max';
			break;
		}
	}
}

function romanic_number($integer, $upcase = true)
{ 
	$table = array('M'=>1000, 'CM'=>900, 'D'=>500, 'CD'=>400, 'C'=>100, 'XC'=>90, 'L'=>50, 'XL'=>40, 'X'=>10, 'IX'=>9, 'V'=>5, 'IV'=>4, 'I'=>1);
	$return = '';
	while($integer > 0)
	{
		foreach($table as $rom=>$arb)
		{
			if($integer >= $arb)
			{
				$integer -= $arb;
				$return .= $rom;
				break;
			}
		}
	}

	return $return;
}

function romanic_title($title, $num)
{
	return romanic_number($num) . '.-  ' . $title;
}