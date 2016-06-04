<div ng-controller="appController">
	<div class="row marginTop20">
		<div class="col-md-4 col-sm-6 col-xs-12">
			<h3 class="marginTop0">Información inicial</h3>			
			<div class="box box-widget widget-user widget-info">
			
				<div class="widget-user-header" ng-class="{ 'bg-aqua-active': status.val > 0,  'bg-gray-active': status.val == 0 }">
					<h3 class="widget-user-username"><i class="fa fa-fw fa-lock"></i> Apertura</h3>
					<select class="small-box-footer" ng-model="status" ng-options="option.descripcion for option in statusOptions track by option.val">
					</select>
				</div>
				
				<div class="box-footer">
					<h4 class="text-info text-center"><i class="fa fa-fw fa-users"></i> Jerarquía</h4>
					<div class="row">
						<div class="col-sm-6 border-right">
							<div class="description-block">
								<h5 class="description-header"><?=$info->jefesTotales?></h5>
								<span class="description-text">Jefes</span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="description-block">
								<h5 class="description-header"><?=$info->empleadosTotales?></h5>
								<span class="description-text">Empleados</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="col-md-4 col-sm-6 col-xs-12">
			<h3 class="marginTop0">Evaluación</h3>
			<info-box info="info.evaluacion.cartas"></info-box>
			<info-box info="info.evaluacion.respuestas"></info-box>
			<info-box info="info.evaluacion.reportes"></info-box>
		</div>
		
		<div class="col-md-4 col-sm-6 col-xs-12">
			<h3 class="marginTop0">Autoevaluación</h3>
			<info-box info="info.autoevaluacion.cartas"></info-box>
			<info-box info="info.autoevaluacion.respuestas"></info-box>
			<info-box info="info.autoevaluacion.reportes"></info-box>
		</div>
		
	</div>
</div>
<script>var _info_ = <?=json_encode($info, JSON_NUMERIC_CHECK)?>;</script>