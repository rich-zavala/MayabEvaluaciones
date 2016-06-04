<div class="content" ng-app="app" ng-cloak>
	<div ng-controller="listado" ng-init="registrosCargar()">
	
		<div class="box box-default">
			<div class="box-header with-border">
				<i class="fa" ng-class="gui.icono"></i>
				<h3 class="box-title">{{gui.titulo}}</h3>
				
				<div class="box-tools pull-right">
					<button class="btn btn-sm btn-primary" ng-click="formulario.nuevo()"><i class="fa fa-plus"></i> Agregar registro</button>
				</div>
				
			</div>
			<div class="box-body autoScroll">
				<div class="alert alert-warning marginBottom0" ng-if="gui.cargando"><i class="fa fa-spinner fa-spin marginRight10"></i> Cargando información...</div>
				<div class="alert alert-danger marginBottom0" ng-if="gui.cargandoError"><i class="fa fa-warning marginRight10"></i> Ha ocurrido un error. Reinicie su sesión e intente nuevamente.</div>
				<div class="alert alert-info marginBottom0" ng-if="!gui.cargando && !gui.cargandoError && registros.length == 0"><i class="fa fa-info-circle marginRight10"></i> No hay registros actualmente. <a href="#" ng-click="formulario.nuevo()">Haga click aquí para iniciar</a>.</div>
				
				<!-- TABLA -->
				<div class="" ng-if="!gui.cargando && registros.length > 0">
					<form class="form-inline marginBottom20 filter">
						<div class="form-group marginRight10">
							<label for="buscador">Buscar</label>
							<input type="text" id="buscador" class="form-control input-sm" ng-model="tabla.filtro">
						</div>
						<div class="form-group marginRight10">
							<label for="orden">Ordernar</label>
							<select id="orden" class="form-control input-sm" ng-model="tabla.orden">
								<option value="n">Nombre</option>
								<option value="departamento_n">Departamento</option>
								<option value="puesto_n">Puesto</option>
								<option value="area_n">Área</option>
								<option value="nivel_n">Nivel</option>
								<option value="email">Email</option>
								<option value="status">Estatus</option>
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
					
					<table class="table table-striped table-hover">
						<tr>
							<th class="bg-primary">Id / Fecha registro</th>
							<th class="bg-primary">Nombre / Email</th>
							<th class="bg-primary">Departamento</th>
							<th class="bg-primary">Área</th>
							<th class="bg-primary">Puesto</th>
							<th class="bg-primary">Nivel</th>
							<th class="bg-primary nowrap">Fecha registro</th>
							<th class="bg-primary"></th>
						</tr>
						<tr ng-repeat="r in registros | filter : tabla.filtro | orderBy: tabla.orden : tabla.direccion != 'asc' | limitTo : tabla.registros" ng-dblclick="formulario.editar($event, r)">
							<td nowrap>
								{{r.empleado}}<br>
								<span class="text-warning">{{r.fechaRegistro.length > 0 ? moment(r.fechaRegistro).format('D MMM, YYYY - HH:mm') : ''}}</span>
							</td>
							<td class="nowrap">
								{{r.n}}<br>
								<i class="text-muted">{{r.email}}</i>
							</td>
							<td>{{r.departamento_n}}</td>
							<td>{{r.area_n}}</td>
							<td>{{r.puesto_n}}</td>
							<td>{{r.nivel_n}}</td>
							<td>
								<div class="dropdown acciones-switch">
									<button class="btn btn-xs dropdown-toggle acciones-switch-btn" data-toggle="dropdown" ng-class="{ 'btn-success' : r.status == 0, 'btn-danger' : r.status == 1 }">
										<i class="fa marginRight5" ng-class="{ 'fa-check' : r.status == 0, 'fa-minus' : r.status == 1 }"></i> {{ r.status == 0 ? 'Activo' : 'Inactivo' }}
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu dropdown-menu-right">
										<li class="dropdown-header">Cambiar de estatus</li>
										<li ng-if="r.status == 1"><a href="#" ng-click="cambiarStatus($event, r)"><i class="fa fa-check"></i> Activo</a></li>
										<li ng-if="r.status == 0"><a href="#" ng-click="cambiarStatus($event, r)"><i class="fa fa-minus"></i> Inactivo</a></li>
										<li role="separator" class="divider"></li>
										<li><a href="#" ng-click="formulario.editar($event, r)"><i class="fa fa-pencil"></i> Editar</a></li>
										<li><a href="#" ng-click="registroEliminar($event, r)"><i class="fa fa-times"></i> Eliminar</a></li>
									</ul>
								</div>
							</td>
						</tr>
					</table>
					
				</div>
			</div>
		
	</div>
	</div>
</div>