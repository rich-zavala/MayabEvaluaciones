<div class="box box-default box-solid">
	<div class="box-body" ng-controller="appController">
		<div class="alert alert-danger marginBottom0" ng-if="gui.cargandoError"><i class="fa fa-fw fa-warning marginRight10"></i> Ha ocurrido un error. Intente nuevamente.</div>
		<div ng-if="!gui.cargandoError">
			<button type="submit" class="btn btn-block btn-primary" ng-click="agregar(jerarquia)"><i class="fa fa-plus marginRight10"></i> Agregue un empleado al nivel más alto</button>
		</div>
		<div>
			<div class="alert alert-warning marginTop10 marginBottom0" ng-if="gui.cargando"><i class="fa fa-fw fa-spinner fa-pulse marginRight10"></i> Cargando información...</div>
			<ul class="list-group marginTop10 marginBottom0">
				<tree-render ng-repeat="data in jerarquia.subordinados" info="data" parent="jerarquia" functions="functions"></tree-render>
			</ul>
		</div>
	</div>
</div>