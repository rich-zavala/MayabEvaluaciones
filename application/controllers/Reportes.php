<?php
/*
21 de junio del 2016 | Ricardo Zavala
Este controlador es idéntico al de Cartas.
Mocartas se encarga de identificar el controlador para realizar los switches correspondientes
*/

defined('BASEPATH') OR exit('No direct script access allowed');
include('Cartas.php');
class_alias('Cartas', 'Reportes');