'use strict';
var controlador = 'empleados';
app.controller('listado', ['$scope', '$rootScope', '$http', '$filter', '$uibModal', '$timeout', function($scope, $rootScope, $http, $filter, $uibModal, $timeout) {
	//Herramientas
	$scope.moment = moment;
	
	//Variables auxiliares para la vista
	$scope.gui = {
		titulo: 'Empleados',
		icono: 'fa-users',
		cargando: false,
		cargandoError: false
	}
	
	$scope.tabla = {
		filtro: '',
		registros: '20',
		orden: 'n',
		direccion: 'asc'
	}
	
	//Variables del sistema
	$scope.registros = [];
	
	//Solicitar registros
	$scope.registrosCargar = function(){
		if(!$scope.gui.cargando)
		{
			$scope.gui.cargando = true;
			$http.post(_sitePath_ + controlador + '/registros' + _suffix_)
		  .success(function(data, status, headers, config) {
		  	$scope.registros = data;
		  })
		  .error(function(data, status, headers, config) {
		    $scope.gui.cargandoError = true;
		  })
		  .finally(function(){
		  	$scope.gui.cargando = false;
		  });
	  }
  }
  
	//Mostrar nuevo formulario
  $scope.formulario = {
		//Registro nuevo
		nuevo: function(){
			var data = {
				formulario: { },
				nuevo: true
			};
			$scope.formulario.modal(data);
		},
		
		//Editar registro existente
		editar: function($event, obj){
			$event.preventDefault();
			var data = {
				formulario: obj,
				nuevo: false
			};
			$scope.formulario.modal(data);
		},
		
		//Abrir modal
		modal: function(data){
			block();
			var modalInstance = $uibModal.open({
				templateUrl: _sitePath_ + controlador + '/formulario' + _suffix_,
				controller: 'formularioController',
				openedClass: 'modal-primary',
				size: 'lg',
				
				resolve:  {
					data: data,
				}
			}).rendered.then(function(){
				setDatePicker();
				unBlock();
			});
		}
	};
	
	//Cambio de statuss
	$scope.cambiarStatus = function($event, info){
		$event.preventDefault();

		//¡Cambiar el status de una vez!
		info.status = (info.status == 0) ? 1 : 0;
		
		var data = {
			tabla: 'empleados',
			campo: 'status',
			valor: info.status,
			id: info.empleado
		};
		$http.post(_sitePath_ + 'comunes/actualizar' + _suffix_, data)
		.error(function(data, status, headers, config) {
			alert('Ha ocurrido un error. Intente nuevamente más tarde.');
			info.status = (info.status == 0) ? 1 : 0;
		});
	}
	
	//Eliminación
	$scope.registroEliminar = function($event, data){
		$event.preventDefault();
		block();
		console.log(data);
		data.tabla = 'empleados';
		data.id = data.empleado;
		var modalInstanceEliminar = $uibModal.open({
			templateUrl: _sitePath_ + 'r_/templates/eliminar.html',
			controller: 'eliminarController',
				// openedClass: 'modal-warning',
			size: 'md',
			resolve:  {
				data: data,
			}
		}).rendered.then(function(){
			unBlock();
		});
	}
	
	//Obtener datos desde un modal y ejecutar sincronización
	//Nuevo registro
	$scope.$on('registroAgregar', function (event, data) {
		console.log(data);
		$scope.registros.push(data);
	});
	
	//Manipulación de registro
	$scope.$on('registroActualizar', function (event, data) {
		for(var i in $scope.registros)
		{
			if($scope.registros[i].empleado == data.empleado)
			{
				$scope.registros[i] = data;
				break;
			}
		}
	});
	
	//Eliminación
	$scope.$on('registroEliminacion', function (event, data) {
		if(data.tabla == 'empleados')
		{
			var index = -1;
			for(var i in $scope.registros)
			{
				if(index < 0 && $scope.registros[i].id == data.id)
				{
					index = i;
					break;
				}
			}
			
			if(index >= 0) $scope.registros.splice(index, 1);
		}
	});
}]);

/*
Formulario de registro
El parámetro "data" debe incluir atributo "gui" y "formulario"
"gui" > Valores para la interfaz del modal
"formulario" > Valores predeterminados del formulario. El formulario debe incluir campos con el modelo "formulario.[nombre]"

En el scope se creará un objeto llamado "_formulario" que hará referencia al formulario del DOM. Este formulario se debe llamar igual "_formulario"
*/
app.controller('formularioController', [ '$scope', '$rootScope', '$http', '$uibModalInstance', 'data', function ($scope, $rootScope, $http, $uibModalInstance, data) {
	$scope.nuevo = data.nuevo;
	$scope.gui = {};
	// console.log(data);
	// $scope.formulario = angular.copy(data.formulario);
	$scope.formulario = angular.copy(data.formulario);
	var nuevo_registro = {};
	
	//Remover aliases
	delete $scope.formulario.n;
	delete $scope.formulario.status;
	delete $scope.formulario.departamento_n;
	delete $scope.formulario.area_n;
	delete $scope.formulario.puesto_n;
	delete $scope.formulario.nivel_n;
	delete $scope.formulario.n;
	
	//Inicializar registro
	$scope.registrar = function () {
		if(!$scope.gui.ocupado)
		{
			alertReset();
			
			//Validar formulario		
			for(var i in $scope._formulario) try{ $scope._formulario[i].$setTouched(); } catch(e){}
			
			if($scope._formulario.$valid) //Es válido > Enviar
			{
					$('[name="_formulario"] *').prop('disabled', true);
					$scope.gui.ocupado = true;
					
					$http.post(_sitePath_ + controlador + '/submit' + _suffix_, $scope.formulario).
					success(function(data) {
						if(data.error == 0)
						{
							$scope.gui.exito = true;
							nuevo_registro = data.datos;
							var broadcastEvent = 'registroAgregar';
							if($scope.nuevo) //Transformar en edición
								$scope.nuevo = false;
							else
								broadcastEvent = 'registroActualizar';
							
							//Pasar el elemento al scope principal
							$rootScope.$broadcast(broadcastEvent, nuevo_registro);
						}
						else
						{
							$scope.gui.error = true;
							$scope.error = data.msg;
						}
					})
					.error(function() {
						$scope.gui.error = true;
					})
					.finally(function(){
						$scope.gui.ocupado = false;
						$('[name="_formulario"] *').prop('disabled', false);
					});
			}
			else //Algo anda mal...
				$scope.gui.invalid = true;
		}
	};
	
	//Cerrar modal
	$scope.cancelar = function () {
		$uibModalInstance.dismiss('cancel');
	};
	
	//Submit on enter en input
	var eventHandler = function(event) {
		if((event.target.type == 'text') && event.which === 13)
		{
			$scope.registrar();
			$scope.$apply();
		}
	}
	
	$(document).bind('keypress', eventHandler);
	$scope.$on('$destroy', function () { $(document).unbind('keypress', eventHandler); })
	
	//Reseteo de valores de alerta
	var alertReset = function(){
		$scope.gui.ocupado = false;
		$scope.gui.exito = false;
		$scope.gui.error = false;
		$scope.gui.invalid = false;
	};
	alertReset();
}]);