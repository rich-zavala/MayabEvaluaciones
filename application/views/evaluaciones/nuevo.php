<div ng-app="app" ng-cloak>
	<div ng-controller="nuevaEvaluacion">
		<section class="content-header">
			<h1>
				<i class="fa fa-fw fa-plus marginRight10"></i> Creación de nueva evaluación
			</h1>
		</section>
		
		<section class="content">
			<form class="box box-primary" name="fNuevo" novalidate ng-show="!gui.cargandoError && !gui.exito">
				<div class="box-header with-border">
					<h3 class="box-title">Asistente de creación de evaluación</h3>
        </div>
				<div class="box-body">
					<div class="form-group" ng-class="{ 'has-error': fNuevo.titulo.$touched && fNuevo.titulo.$invalid }">
						<label for="titulo">Título</label>
						<input id="titulo" name="titulo" type="text" class="form-control" placeholder="Año u otro nombre" ng-model="form.titulo" required>
					</div>
					<div class="form-group">
						<label for="jerarquias">Copiar jerarquías de</label>
						<select id="jerarquias" name="jerarquias" class="form-control" ng-options="item.titulo for item in catalogo" ng-model="form.jerarquias">
							<option value="">-- Ninguno --</option>
						</select>
					</div>
					<div class="form-group">
						<label for="cuestionarios">Copiar cuestionarios de</label>
						<select id="cuestionarios" name="cuestionarios" class="form-control" ng-options="item.titulo for item in catalogo" ng-model="form.cuestionarios">
							<option value="">-- Ninguno --</option>
						</select>
					</div>
				</div>
				<div class="overlay" ng-if="gui.cargando">
					<i class="fa fa-refresh fa-spin"></i>
        </div>
				<div class="box-footer">
					<div class="alert alert-warning" ng-if="fNuevo.$dirty && fNuevo.$invalid">
						<i class="fa fa-warning marginRight10"></i> Existen campos requeridos inválidos. Verifique su información.
					</div>
					<div class="alert alert-danger" ng-if="gui.error">
						<i class="fa fa-warning marginRight10"></i> Ha ocurrido un error: {{gui.error_msg}}
					</div>
					<button type="submit" class="btn btn-primary" ng-click="registrar()"><i class="fa fa-floppy-o marginRight10"></i> Registrar</button>
        </div>
			</form>
			
			<div class="alert alert-danger" ng-if="gui.cargandoError">
				<i class="fa fa-warning marginRight10"></i> Ha ocurrido un error. Intente de nuevo más tarde.
			</div>
			
			<div class="box box-success" ng-show="gui.exito">
				<div class="box-header with-border">
					<h3 class="box-title">Registro exitoso</h3>
        </div>
				<div class="box-body">
					<div class="alert alert-success">
						<i class="fa fa-check marginRight10"></i> La evaluación <b>"{{form.titulo}}"</b> ha sido creada.
					</div>
					
					<p><a href="<?=base()?>evaluaciones/info/{{nuevo_id}}<?=suffix()?>">Haga click aquí para configurar sus propiedades.</a></p>
				</div>
			</div>
		</section>
	</div>
</div>