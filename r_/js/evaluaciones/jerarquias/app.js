'use strict';
var controlador = 'jerarquias';
app.controller('appController', ['$scope', '$rootScope', '$http', '$filter', '$uibModal', '$timeout', function($scope, $rootScope, $http, $filter, $uibModal, $timeout) {
	$scope.jerarquia = {
		evaluacion: _eval_,
		subordinados: []
	};
	
	//Objetos del GUI
	$scope.gui = {
		cargando: true,
		cargandoError: false
	};
	
	//Obtener catálogo
	$http.post( _sitePath_ + controlador + '/json' + _suffix_, { evaluacion: _eval_ })
	.then(function (response) {
		$scope.jerarquia.subordinados = response.data;
	}, function (response) {
		$scope.gui.cargandoError = true;
	}).finally(function(){
		$scope.gui.cargando = false;
	});
	
	//Agregar
	$scope.agregar = function (obj) {
		var modalInstance = $uibModal.open({
			templateUrl: _sitePath_ + 'r_/js/evaluaciones/jerarquias/agregar.html',
			controller: 'formularioAgregarCtrl',
			size: 'md',
			resolve: {
				data: parent
			}
		});

		//Retreive data resultant from modal
		modalInstance.result.then(function (selectedItem) {
			if(selectedItem != null)
			{
				if(typeof obj.subordinados == 'undefined') obj.subordinados = [];
				selectedItem.evaluacion = obj.evaluacion;
				selectedItem.wait = true; //Para mostrar el bloqueo
				selectedItem.new = true;
				obj.subordinados.push(selectedItem);
				
				//Enviar solicitud de registro
				var info = {
					evaluacion: selectedItem.evaluacion,
					jefe: obj.empleado,
					subordinado: selectedItem.empleado
				};
				$http.post(_sitePath_ + controlador + '/registrar' + _suffix_, { info: info } )
				.then(function(response){
					if(response.data.error == 0)
						delete selectedItem.wait;
					else
						$scope.removerElemento(obj, selectedItem);
				},function(msg){
					alert("Ha ocurrido un error durante el registro. Intente de nuevo más tarde.");
					$scope.removerElemento(obj, selectedItem);
				});
			}
		});
		
		modalInstance.rendered.then(function(){
			$('#_empleado_form_').focus();
		});
	};

	//Remover elemento por error
	$scope.removerElemento = function(obj, selectedItem){
		obj.subordinados.splice([obj.subordinados.indexOf(selectedItem)], 1);
	}
	
	$scope.functions = { agregar: $scope.agregar, removerElemento: $scope.removerElemento };
}]);

//Modal de agregación
app.controller('formularioAgregarCtrl', [ '$scope', '$http', '$uibModalInstance', 'data', function ($scope, $http, $uibModalInstance, data) {
	$scope.typeSelected = null;
	$scope.typeResult = null;

  $scope.ok = function () {
    $uibModalInstance.close($scope.typeResult); //Send data to caller controller
  };

  $scope.cancel = function () {
    $uibModalInstance.dismiss('I\' closed!');
  };
	
	//Guardar resultados para obtenerlos posteriormente
	var tmpClaves = [];
	var tmpNombres = [];
	var tmpEmpleados = [];
  $scope.getEmpleados = function(val) {
		return $http.post(_sitePath_ + controlador + "/buscador/" + _eval_ + _suffix_, { param: val })
		.then(function(response){
			for(var i in response.data)
			{
				if(tmpClaves.indexOf(response.data[i].empleado))
				{
					tmpClaves.push(response.data[i].empleado);
					tmpNombres.push(response.data[i].n);
					tmpEmpleados.push(response.data[i]);
				}
			}
			
			return response.data.map(function(item){
				return item.n;
			});
		});
	};
	
	//TypeAhead item selected
	$scope.selected = function($item, $event)
	{
		$scope.typeResult = tmpEmpleados[tmpNombres.indexOf($scope.typeSelected)];
	}

	//Validar input
	$scope.validar = function(){
		if(typeof $scope.typeSelected != "undefined")
			$scope.ok();
	}
}]);