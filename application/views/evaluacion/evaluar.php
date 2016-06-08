<script>
	var _modalidad_ = 'jefe';
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
			
			<div ng-show="!data.set">
				<div class="content-wrapper">
					<section class="content-header">
						<h1>Bienvenido,</h1>
						<h2>{{evaluador.info.n}}</h2>
					</section>
					
					<div class="content">
						<div ng-bind-html="evaluacion.info.texto_bienvenida_evaluacion | to_trusted"></div>
						<div class="box box-warning marginTop20" ng-if="evaluacion.info.status == 1">
							<div class="box-header with-border">
								<div class="pull-right text-muted negritas">{{evaluador.info.avance}} de {{evaluador.info.evaluadosTotales}} empleados evaluados</div>
								<h3 class="box-title"><i class="fa fa-fw fa-users"></i> Personal que será evaluado</h3>
							</div>
							<div class="box-body">
								<p>Actualmente tienes asignada la evaluación de los siguientes empleados:</p>
								
								<div ng-repeat="e in evaluador.evaluados">
									<div class="info-box bg-aqua" ng-if="e.respuesta == 0">
										<a class="info-box-icon" title="Ir al cuestionario" ng-click="evaluar(e)"><i class="fa fa-user"></i></a>
										<div class="info-box-content">
											<div class="font12 text-warning pull-right">{{e.nivel_n}}</div>
											<div class="info-box-text info-box-encuesta-empleado">
												<b>{{e.n}}</b>
												<br>
												{{e.puesto_n}}.
											</div>
											<div class="info-box-encuesta-link marginTop10">
												<a ng-click="evaluar(e)">
													<i class="fa fa-fw fa-external-link"></i> Haga click aquí para abrir el cuestionario.
												</a>
											</div>
										</div>
									</div>
									
									<div class="info-box bg-green" ng-if="e.respuesta > 0">
										<span class="info-box-icon"><i class="fa fa-check"></i></span>
										<div class="info-box-content">
											<div class="font12 text-warning pull-right">{{e.nivel_n}}</div>
											<div class="info-box-text info-box-encuesta-empleado">
												<b>{{e.n}}</b>
												<br>
												{{e.puesto_n}}
											</div>
											<div class="info-box-text">
												El cuestionario fue contestado el <b>{{moment(e.fechaRegistro).format('D MMM, YYYY - HH:mm')}} hrs</b>.
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					
						<section class="marginTop20" ng-if="evaluacion.info.status != 1">
							<hr>
							<div class="alert alert-info"> <i class="fa fa-fw fa-info-circle"></i> La evaluación se encuentra actualmente cerrada.</div>
							<p class="negritas">Si necesitas más información ponte en contacto con el departamento de RR.HH.</p>
						</section>
					</div>
				</div>
			</div>
			
			<div class="content-wrapper" ng-if="data.set">
				<div class="evaluandoTitulo">
					<span><i class="fa fa-fw fa-user"></i> {{evaluador.info.n}}</span>
					<button class="btn btn-warning btn-sm pull-right" ng-click="cancelar()" ng-if="!gui.ocupado"><i class="fa fa-fw fa-times"></i> Cancelar esta evaluación</button>
				</div>
				
				<div class="content">
					<template-formulario data="data"></template-formulario>
					
					<div class="" ng-if="!gui.cargando && !gui.cargandoRespuestas && !gui.sinCuestionrarios">
						<button class="btn btn-warning pull-left" type="button" ng-click="anterior()" ng-if="!gui.primerCuestionario" ng-disabled="gui.ocupado"><i class="fa fa-chevron-left marginLeft10"></i> Anterior</button>
						<button class="btn btn-primary pull-right" type="button" ng-click="siguiente()" ng-if="!gui.ultimoCuestionario">Siguiente <i class="fa fa-chevron-right marginLeft10"></i></button>
						<button class="btn btn-success pull-right" type="button" ng-click="registrar()" ng-if="gui.ultimoCuestionario" ng-disabled="gui.ocupado"><i class="fa fa-floppy-o marginRight10"></i> Registrar</button>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			
			<footer class="main-footer">
				<strong><a href="#">Universidad Anáhuac Mayab</a></strong> 2016. Todos los derechos reservados.
			</footer>
		</div>
	</div>
</body>
</html>