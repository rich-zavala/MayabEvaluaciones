<?php
// p($e);
//5 de agosto del 2016 - Si la evaluación es la #1 y el jefe es Rafael Pardo cambiar su nombre por Miguel Pérez
if(isset($e->jefe_empleado) and $e->evaluacion == 1 and $e->jefe_empleado == 1)
	$e->jefe = "Ing. Miguel E. Pérez Gómez";
else if($imprimible == 1 and in_array($empleado, array('32145420', '32124223', '32151737', '32153840'))) //22 de agosto - Jefes especiales para algunos empleados
	$e->jefe = "Dr. Eduardo Espinosa";
// else if($imprimible == 1 and in_array($empleado, array('32145456', '32124363')))
	// $e->jefe = "Leonor Martínez";
// else if($imprimible == 1 and in_array($empleado, array('32146480', '32133367', '32124284', '32151505', '32149977', '32124343', '32161036', '32154693')))
	// $e->jefe = "Aurorra Porrúa";
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title><?=TITULO?></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" href="<?=base()?>r_/images/favicon.ico" />
		<base href="<?=base()?>">
		<?=$include_css?>
		<script src='<?=base()?>r_/components/jquery/jquery.min.js'></script>
		<script src='<?=base()?>r_/components/highcharts/highcharts.js'></script>
		<script>var _sitePath_ = '<?=base()?>'; var _suffix_ = '<?=suffix()?>';</script>
  </head>
	<body>
		<div class="container">
			<div id="encabezado">
				<div id="logo" class="pull-left"></div>
				<h1 class="pull-right text-right">
					Capital Humano<br>
					<b>Resultados <span><?=($tipo == 0) ? 'Evaluación' : 'Autoevaluación'?></span> del Desempeño</b>
					<br> <?=$eval->titulo?>
				</h1>
			</div>
			<div class="clearfix"></div>
			<div class="row f12">
				<div class="col-xs-6">
					<table class="header-table" align="center">
						<tr>
							<th class="text-right">Nombre:</th>
							<td><?=$e->nombre?></td>
						</tr>
						<tr>
							<th class="text-right">Departamento:</th>
							<td><?=$e->departamento_n?></td>
						</tr>
						<tr>
							<th class="text-right">Puesto:</th>
							<td><?=$e->puesto_n?></td>
						</tr>
					</table>
				</div>
				<div class="col-cs-6">
					<table class="header-table" align="center">
						<tr>
							<th class="text-right">Jefe:</th>
							<td><?=$e->jefe?></td>
						</tr>
						<?php if($modalidad == 'jefe'){ ?>
						<tr>
							<th class="text-right">Promedio:</th>
							<td><?=round($re->promedio_total, 2)?></td>
						</tr>
						<?php } ?>
						<tr>
							<th class="text-right">Antigüedad:</th>
							<td><?=$e->antiguedad?></td>
						</tr>
					</table>
				</div>
			</div>

			<hr>
			
			<div class="row">
				<div class="col-xs-12">
					<h2 class="marginTop5">Competencias</h2>
					<?php
					foreach($c->competencias as $kco => $co)
					{
						if($co->tipo == 'competencia')
						{
							//28 jul
							$titulo = ucfirst(trim(str_replace('Competencias', '', $co->titulo)));
							$subtitulo = null;
							if($co->importante == 0)
							{
								$titulo = 'Funciones del Puesto o Nivel';
								$subtitulo = $co->titulo;
							}
					?>
					<div class="marginBottom10 pb">
						<table class="pull-right">
							<tr>
								<td>
									<div class="inline recuadro text-center valor-esperado"></div>
									<div class="inline middle">Valor esperado</div>
								</td>
							</tr>
						</table>
					
						<h2 class="titulo-bloque"><?=romanic_title($titulo, $kco + 1)?></h2>
						<?=($subtitulo != null) ? '<h2 class="_subtitulo">' . $subtitulo . '</h2>' : ''?>
						<table class="table table-bordered marginBottom10">
							<tr>
							<?php
							foreach($co->respuestas as $krs => $rs)
							{
							?>
								<td class="text-center text-small valores-tabla <?=cl($krs, count($co->respuestas))?>" style="width: <?=(100 / count($co->respuestas))?>%">
									<div><?=$rs->titulo?></div>
									<div class="negritas"><?=$rs->etiqueta?></div>
								</td>
							<?php
							}
							?>
							</tr>
						</table>
							<?php
							foreach($co->secciones as $sk => $s)
							{
								//Obtener el promedio para el título
								$prom = 0;
								foreach($co->respuestas as $krs => $rs)
								{
									foreach($s->conductas as $tk => $t)
									{
										if(isset($re->valores[$t->id]))
										{
											$prom = number_format((float) $re->promedios[$t->seccion]['promedio'], 2, '.', '');
											break;
										}
									}
									if($prom > 0) break;
								}
							?>
						<table class="table table-bordered tabla-colores">
							<tr>
								<th class="w80p bgAnahuac">
									<?php if($modalidad == 'jefe'){ ?><div class="pull-right prom">Prom: <?=$prom?></div><?php } ?>
									<h3 class="seccion-titulo margin0"><?=$sk + 1?>.- <?=$s->titulo?></h3>
								</th>
								<?php
								foreach($co->respuestas as $krs => $rs)
								{
								?>
								<td class="text-center middle text-small etiqueta <?=cl($krs, count($co->respuestas))?>" style="width: <?=(20 / count($co->respuestas))?>%">
									<?=$rs->etiqueta?>
								</td>
								<?php
								}
								?>
							</tr>
							
								<?php
								foreach($s->conductas as $tk => $t)
								{
									//Identificar respuesta
									$valor = 0;
									if(isset($re->valores[$t->id]))
									{
										$valor = $re->valores[$t->id]->valor;
										$co->promedios_respuestas[$t->seccion] = $re->promedios[$t->seccion]['promedio'];
									}
									
									//Indezar promedio
									if(!isset($co->respuestas[$krs]->promedios))
									{
										$co->respuestas[$krs]->promedios_respuestas = array();
										$co->respuestas[$krs]->promedios_clave = array();
									}
									
									if(isset($clave->promedios[$t->seccion]))
										$co->promedios_clave[$t->seccion] = $clave->promedios[$t->seccion]['promedio'];
								?>
							<tr>
								<td class="text-small justify">
									<?=$sk + 1?>.<?=$tk + 1?>.- <?=$t->descripcion?>
								</td>
								<?php
									foreach($co->respuestas as $co_r)
									{
										$class = null;
										if($co_r->valor <= $valor)
											$class = cl($valor - 1, count($co->respuestas));
										
										$clave_respuesta = null;
										if(isset($clave->valores[$t->id]) and $clave->valores[$t->id]->valor == $co_r->valor)
											$clave_respuesta = 'valor-esperado';
										
										$respuesta = null;
										if($co_r->valor == $re->valores[$t->id]->valor)
											$respuesta = '&#x25cf;';
								?>
								<td class="valor text-center midde <?=$class?> <?=$clave_respuesta?>"><?=$respuesta?></td>
								<?php
									}
								?>
							</tr>
								<?php
								}
								?>
						</table>
							<?php
							}
							?>
						</div>
						<?php
						}
					}
					?>
				</div>
			</div>
		
			<div class="pb">
				<!-- Promedios -->
				<?php if($modalidad == 'jefe'){ ?>
				<div class="row">
					<div class="col-xs-12">
						<h2>Indicadores de valoración de competencias</h2>
						
						<table class="table table-bordered tabla-colores">
							<tr class="active">
								<th>Competencias:</th>
								<th class="text-right">Promedio Final</th>
								<th class="text-right">Promedio Esperado</th>
							</tr>
							<?php
							foreach($c->competencias as $co)
							{
								if(isset($co->promedios_clave) and $co->tipo == 'competencia')
								{									
									//29 jul
									$titulo = ucfirst(trim(str_replace('Competencias', '', $co->titulo)));
									$subtitulo = null;
									if($co->importante == 0)
									{
										$titulo = 'Funciones del Puesto o Nivel';
										$subtitulo = $co->titulo;
									}
							?>
							<tr>
								<td class="negritas info"><?=ucfirst(trim(str_replace('Competencias', '', $titulo)))?></td>
								<td class="text-right"><?=number_format(array_sum($co->promedios_respuestas)/count($co->promedios_respuestas), 2, '.', '')?></td>
								<td class="text-right"><?=number_format(array_sum($co->promedios_clave)/count($co->promedios_clave), 2, '.', '')?></td>
							</tr>
							<?php
								}
							}
							?>
						</table>
					</div>
				</div>
				<?php } ?>
			
				<div class="row">
					<?php
					$graficas = array();
					foreach($c->competencias as $co)
					{
						if(isset($co->promedios_clave) and $co->tipo == 'competencia')
						{
							$etiquetas = array();
							foreach($co->respuestas as $res)
								$etiquetas[] = $res->titulo;
							
							$gr = array(
								'id' => $co->id,
								'titulo' => $co->titulo,
								'secciones' => array(),
								'respuestas' => $co->promedios_respuestas,
								'esperados' => $co->promedios_clave,
								'etiquetas' => $etiquetas
							);
							foreach($co->secciones as $s)
								$gr['secciones'][] = $s->titulo;
								
							$mini = (count($co->secciones) == 1) ? 'mini' : null;
					?>
					<div class="col-xs-12 marginBottom10 graph <?=$mini?>" id="graph<?=$co->id?>"></div>
					<?php
							$graficas[] = $gr;
						}
					}
					?>
				</div>
				
				
				<?php if($modalidad == 'jefe' and $tipo == 0){ ?>
				
				<div class="row marginTop10">
					<div class="col-xs-12"><h2>Preguntas abiertas</h2></div>
					<?php
					//Preguntas abiertas: Introducción manual
					$current = 0;
					foreach($re->abiertas_manuales as $a)
					{
						$new = $current != $a->id;
						$current = $a->id;
						if($new)
						{
					?>
					<div class="col-xs-6">
						<div class="box box-warning ">
							<div class="box-header with-border">
								<h3 class="box-title"><?=str_replace('<br>', ' - ', $a->titulo)?></h3>
							</div>
							<div class="box-body">
								<ul>
					<?php
						}
					?>
									<li><?=$a->manual_valor?></li>
					<?php if(!$new){ ?>
								</ul>
							</div>
						</div>
					</div>
					<?php
						}
					}
					?>
				</div>
			
				<div class="row">
					<?php
					//Preguntas abiertas: Con respuesta booleana y comentario
					foreach($re->abiertas_opciones as $a)
					{
					?>
					<div class="col-xs-6">
						<div class="box box-warning ">
							<div class="box-header with-border">
								<h3 class="box-title"><?=str_replace('<br>', ' - ', $a->titulo)?></h3>
							</div>
							<div class="box-body">
								<div><b>Respuesta:</b> <?=$a->respuesta_booleana?></div>
								<div class="justify"><b><?=$a->manual_input?>:</b> <?=$a->respuesta_manual?></div>
							</div>
						</div>
					</div>
					<?php
					}
					?>
				</div>
				
				<?php
				}
				
				if($imprimible == 1){
				?>
				<div class="row marginTop20">
					<div class="col-xs-12 text-center">
						Acuerdos: _______________________________________________________________________________________________________________<br><br><br>
						_________________________________________________________________________________________________________________________
					</div>
				</div>
				
				<div class="row">
					<div class="col-xs-12">
						<table align="center" class="firmas w50 marginBottom20">
							<tr>
								<th></th>
								<th></th>
							</tr>
							<tr>
								<td class="text-center">
									<b>
									<?php
									//23 Ago - A estos sólo se les cambia el nombre en la firma
									if($imprimible == 1 and in_array($empleado, array('32146480', '32133367', '32124284', '32151505', '32149977', '32124343', '32161036', '32154693')))
										$e->jefe = "Aurorra Porrúa";
									
									echo $e->jefe;
									?>
									</b>
									<br>Jefe de área
								</td>
								<td class="text-center">
									<b><?=$e->nombre?></b>
									<br>Colaborador
								</td>
							</tr>
						</table>
					</div>
				</div>
				<?php } ?>
			</div>
		</div>
		<script>
		$(function () {
			<?php
			foreach($graficas as $gr)
			{
			?>
			$('#graph<?=$gr['id']?>').highcharts({
				chart: {
					borderColor: '#F4F4F4',
					borderWidth: 1,
					width: 1000
				},
				credits:{ enabled: false },
				plotOptions : { line : { animation : false } },
				title : { text : '<?=$gr['titulo']?>' },
				legend: {
					layout: 'vertical',
          align: 'right',
          verticalAlign: 'middle',
          borderWidth: 0
        },
				xAxis : { categories : ['<?=join($gr['secciones'], "','")?>'] },
				yAxis : {
					title: null,
					ceiling: 10,
					floor: 0,
					categories: [ '', "<?=join('","', $gr['etiquetas'])?>" ],
					labels: {
						formatter: function() {
							return this.value;
						}
					}
					
				},
				series : [{
					name : 'Resultado',
					color: '#f79f38',
					data : [<?=join($gr['respuestas'], ',')?>]
				}, {
					name : 'Valor Esperado',
					color: '#00aaff',
					data : [<?=join($gr['esperados'], ',')?>]
				}]
			});
			<?php
			}
			?>
		});
		</script>
	</body>
</html>