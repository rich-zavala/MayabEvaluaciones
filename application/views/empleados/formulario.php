<div class="modal-header">
	<button type="button" class="close" ng-click="cancelar()"><span aria-hidden="true">&times;</span></button>
  <h4 class="modal-title">{{ nuevo ? 'Registro de nuevo' : 'Edición de '}} empleado</h4>
</div>
<form name="_<?=$formName?>">
	<div class="modal-body">
				<div class="row">
					<div class="col-sm-4"><?=$campos['empleado']?></div>
					<div class="col-sm-4"><?=$campos['email']?></div>
					<div class="col-sm-4"><?=$campos['nivel']?></div>
				</div>
				<div class="row">
					<div class="col-sm-4"><?=$campos['nombre']?></div>					
					<div class="col-sm-4"><?=$campos['apellido_paterno']?></div>
					<div class="col-sm-4"><?=$campos['apellido_materno']?></div>
				</div>
				<div class="row">
					<div class="col-sm-4"><?=$campos['departamento']?></div>
					<div class="col-sm-4"><?=$campos['puesto']?></div>
					<div class="col-sm-4"><?=$campos['area']?></div>
				</div>
				<div class="row">
					<div class="col-sm-4"><?=$campos['fechaAlta']?></div>
				</div>
		<input type="hidden" ng-model="formulario.empleado" >
		
		<div class="marginTop10">
			<div class="alert alert-warning marginBottom0" ng-if="gui.ocupado"><i class="fa fa-spinner fa-spin marginRight10"></i> Registrando información...</div>
			<div class="alert alert-danger marginBottom0" ng-if="gui.invalid"><i class="fa fa-warning marginRight10"></i> Llene todos los campos obligatorios para continuar.</div>
			<div class="alert alert-danger marginBottom0" ng-if="gui.error"><i class="fa fa-warning marginRight10"></i> Ha ocurrido un error. {{error}}</div>
			<div class="alert alert-success marginBottom0" ng-if="gui.exito"><i class="fa fa-check marginRight10"></i> El registro se ha realizado exitosamente.</div>
		</div>
	</div>
	<div class="modal-footer">
		<button class="btn btn-warning pull-left" type="button" ng-click="cancelar()"><i class="fa fa-times marginRight10"></i> Cancelar</button>
		<button class="btn btn-default" type="button" ng-click="registrar()"><i class="fa fa-floppy-o marginRight10"></i> Registrar</button>
	</div>
</form>