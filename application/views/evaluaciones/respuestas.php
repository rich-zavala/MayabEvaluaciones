<div class="box box-solid">
	<div class="box-header with-border">
		<i class="fa fa-database"></i>
		<h3 class="box-title">Reporte de respuestas de evaluación y autoevaluación</h3>
	</div>
	<div class="box-body autoScroll" ng-controller="appController">
		<div class="alert alert-warning marginBottom0" ng-if="gui.cargando"><i class="fa fa-spinner fa-spin marginRight10"></i> Cargando información...</div>
		<div class="alert alert-danger marginBottom0" ng-if="gui.cargandoError"><i class="fa fa-warning marginRight10"></i> Ha ocurrido un error. Reinicie su sesión e intente nuevamente.</div>
		<div class="alert alert-info marginBottom0" ng-if="!gui.cargando && !gui.cargandoError && registros.length == 0"><i class="fa fa-info-circle marginRight10"></i> No hay registros actualmente. <a href="#" ng-click="formulario.nuevo()">Haga click aquí para iniciar</a>.</div>

		<div ng-if="!gui.cargando && registros.length > 0">
			<form class="form-inline marginBottom20 filter">
				<div class="form-group marginRight10">
					<label for="buscador">Buscar</label>
					<input type="text" id="buscador" class="form-control input-sm" ng-model="tabla.filtro">
				</div>
				<div class="form-group marginRight10">
					<label for="orden">Mostrar</label>
					<select id="orden" class="form-control input-sm" ng-model="tabla.mostrar">
						<option value="n">Todos</option>
						<option value="ev_fecha">Evaluados</option>
						<option value="aev_fecha">Autoevaluados</option>
						<option value="b">Ambos</option>
					</select>
				</div>
				<div class="form-group marginRight10">
					<label for="orden">Ordernar</label>
					<select id="orden" class="form-control input-sm" ng-model="tabla.orden">
						<option value="empleado_n">Nombre</option>
						<option value="ev_fecha">Evaluado</option>
						<option value="aev_fecha">Autoevaluado</option>
					</select>
				</div>
				<div class="form-group marginRight10">
					<label for="direccion">&nbsp;</label>
					<select id="direccion" class="form-control input-sm" ng-model="tabla.direccion">
						<option value="asc">Asc</option>
						<option value="desc">Desc</option>
					</select>
				</div>
				<div class="form-group marginRight10">
					<label for="registros">Registros</label>
					<select id="registros" class="form-control input-sm" ng-model="tabla.registros">
						<option>10</option>
						<option>20</option>
						<option>50</option>
						<option>100</option>
						<option value="999999999999">Todos</option>
					</select>
				</div>
			</form>
			
			<table class="table table-striped table-bordered table-hover">
				<tr>
					<th class="bg-primary">Empleado</th>
					<th width="1" class="bg-primary">Evaluado</th>
					<th width="1" class="bg-primary">Autoevaluado</th>
				</tr>
				<tr ng-repeat="r in registros | filter : tabla.filtro | orderBy: [tabla.orden, 'empleado_n'] : tabla.direccion != 'asc' | limitTo : tabla.registros" ng-dblclick="formulario.editar($event, r)">
					<td nowrap>
						{{r.empleado_n}}<br>
						<span class="text-warning">{{r.empleado}}</span>
					</td>
					<td class="nowrap bg-danger" ng-if="r.ev_fecha == null" title="Evaluación pendiente">
						<i class="fa fa-fw fa-close"></i>
					</td>
					<td class="nowrap bg-success" ng-if="r.ev_fecha != null" title="Evaluación realizada">
						<a ng-href="<?=base()?>evaluaciones/reseval/{{r.subordinado}}<?=suffix()?>" target="_resauto{{r.subordinado}}">
							<i class="fa fa-fw fa-check marginRight10"></i> <small>{{r.ev_evaluador_n}}</small><br>
							<i class="text-muted">{{moment(r.ev_fecha).format('D MMM YYYY - HH:mm')}}</i>
						</a>
					</td>
					<td class="nowrap bg-danger" ng-if="r.aev_fecha == null" title="Autoevaluación pendiente">
						<i class="fa fa-fw fa-close"></i>
					</td>
					<td class="nowrap bg-success" ng-if="r.aev_fecha != null" title="Autoevaluación realizada">
						<a ng-href="<?=base()?>evaluaciones/resauto/{{r.subordinado}}<?=suffix()?>" target="_resauto{{r.subordinado}}">
							<i class="fa fa-fw fa-check marginRight10"></i>
							<span class="text-muted">{{moment(r.aev_fecha).format('D MMM YYYY - HH:mm')}}</span>
						</a>
					</td>
				</tr>
			</table>
			
		</div>
	</div>
</div>