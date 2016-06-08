<script>
	var _modalidad_ = 'autoevaluacion';
	var _evaluacion_ = <?=json_encode($evaluacion, JSON_NUMERIC_CHECK)?>;
	var _evaluador_ = <?=json_encode($evaluador, JSON_NUMERIC_CHECK)?>;
</script>
<body id="contenedorPrincipal" class="blue-yellow layout-boxed layout-top-nav encuesta">
	<div class="wrapper" ng-app="app" ng-cloak>
		<div ng-controller="appController">
			<header class="main-header">
				<nav class="navbar navbar-static-top solid">
					<div class="navbar-header">
						<div class="logo"></div>
						<span class="navbar-brand">
							<div>Evaluaciones de desempeño {{evaluacion.info.titulo}}</div>
						</span>
					</div>
				</nav>
			</header>
			
			<div>
				<div class="content-wrapper">
					<section class="content-header">
						<h1>Bienvenido,</h1>
						<h2>{{evaluador.info.n}}</h2>
					</section>
					
					<div class="content">
						<div ng-bind-html="evaluacion.info.texto_bienvenida_autoevaluacion | to_trusted"></div>
						
						<div class="box box-warning marginTop20" ng-if="evaluacion.info.status == 1 && data.empleado.autoFecha == null">
							<div class="box-header with-border">
								<h3 class="box-title"><i class="fa fa-fw fa-edit"></i> Contesta el siguiente cuestionario</h3>
							</div>
							<div class="box-body">
								<template-formulario data="data"></template-formulario>
								<div class="" ng-if="!gui.cargando && !gui.cargandoRespuestas && !gui.sinCuestionrarios">
									<button class="btn btn-warning pull-left" type="button" ng-click="anterior()" ng-if="!gui.primerCuestionario" ng-disabled="gui.ocupado"><i class="fa fa-chevron-left marginLeft10"></i> Anterior</button>
									<button class="btn btn-primary pull-right" type="button" ng-click="siguiente()" ng-if="!gui.ultimoCuestionario">Siguiente <i class="fa fa-chevron-right marginLeft10"></i></button>
									<button class="btn btn-success pull-right" type="button" ng-click="registrar()" ng-if="gui.ultimoCuestionario" ng-disabled="gui.ocupado"><i class="fa fa-floppy-o marginRight10"></i> Registrar</button>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>							
							
						<div class="info-box bg-green" ng-if="evaluacion.info.status == 1 && data.empleado.autoFecha != null">
							<span class="info-box-icon"><i class="fa fa-check"></i></span>
							<div class="info-box-content">
								<div class="info-box-text">
									<h2 class="marginTop10">Ya hemos recibido tus respuestas</h2>
									El cuestionario fue contestado el <b>{{moment(data.autoFecha).format('D MMM, YYYY - HH:mm')}} hrs</b>.
								</div>
							</div>
						</div>
					
						<section class="marginTop20" ng-if="evaluacion.info.status != 1">
							<hr>
							<div class="alert alert-info"> <i class="fa fa-fw fa-info-circle"></i> La autoevaluación se encuentra actualmente cerrada.</div>
							<p class="negritas">Si necesitas más información ponte en contacto con el departamento de RR.HH.</p>
						</section>
					</div>
				</div>
			</div>
			
			<footer class="main-footer">
				<strong><a href="#">Universidad Anáhuac Mayab</a></strong> 2016. Todos los derechos reservados.
			</footer>
		</div>
	</div>
</body>
</html>