<div class="modal-header">
	<button type="button" class="close" ng-click="cancelar()"><span aria-hidden="true">&times;</span></button>
  <h4 class="modal-title">{{gui.titulo}}</h4>
</div>
<form name="_<?=$formName?>">
	<div class="modal-body">
		<div class="row">
			<div class="col-xs-8">			
				<div class="row">
					<div class="col-sm-6"><?=$campos['usuario']?></div>
					<div class="col-sm-6"><?=$campos['nombre']?></div>					
				</div>
				<div class="row">
					<div class="col-sm-6"><?=$campos['email']?></div>
					<div class="col-sm-6"><?=$campos['telefono']?></div>
				</div>
				<div class="row">
					<div class="col-sm-6"><?=$campos['pass1']?></div>
					<div class="col-sm-6"><?=$campos['pass2']?></div>
				</div>
			</div>
			<div class="col-xs-4"><?=$campos['permisos']?></div>
		</div>
		<input type="hidden" ng-model="formulario.id" >
		
		<div class="marginTop10">
			<div class="alert alert-warning" ng-if="gui.ocupado"><i class="fa fa-spinner fa-spin marginRight10"></i> Registrando información...</div>
			<div class="alert alert-danger" ng-if="gui.invalid"><i class="fa fa-warning"></i> Llene todos los campos obligatorios para continuar.</div>
			<div class="alert alert-danger" ng-if="gui.error"><i class="fa fa-warning"></i> Ha ocurrido un error. {{error}}</div>
			<div class="alert alert-success" ng-if="gui.exito"><i class="fa fa-check"></i> El registro se ha realizado exitosamente.</div>
			<div class="alert alert-danger" ng-if="gui.pass"><i class="fa fa-warning"></i> Los campos de contraseña no coinciden</div>
		</div>
	</div>
	<div class="modal-footer">
		<button class="btn btn-primary pull-left" type="button" ng-click="cancelar()"><i class="fa fa-times marginRight10"></i> Cancelar</button>
		<button class="btn btn-warning" type="button" ng-click="registrar()"><i class="fa fa-floppy-o marginRight10"></i> Registrar</button>
	</div>
</form>