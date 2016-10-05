'use strict';
var controlador = 'evaluaciones';
app.controller('nuevaEvaluacion', ['$scope', '$rootScope', '$http', '$filter', '$timeout', function($scope, $rootScope, $http, $filter, $timeout) {
	//Objeto de formulario
	$scope.form = {
		titulo: null,
		jerarquias: null,
		cuestionarios: null
	};
	
	//Objetos del GUI
	$scope.gui = {
		cargando: true,
		cargandoError: false,
		invalid: false,
		error: false,
		exito: false
	};
	
	//Cargar catálogos
	$http.post(_sitePath_ + controlador + '/listado' + _suffix_)
	.success(function(data, status, headers, config) {
		$scope.catalogo = data;
	})
	.error(function(data, status, headers, config) {
		$scope.gui.cargandoError = true;
	})
	.finally(function(){
		$scope.gui.cargando = false;
	});

	//Registrar evaluación
	$scope.nuevo_id = 0; //ID del nuevo registro
	$scope.registrar = function () {
		if(!$scope.gui.cargando)
		{
			
			//Validar formulario		
			try{ $scope.fNuevo.$setDirty(); } catch(e){ console.log(e);}
			console.log($scope.fNuevo);
			$scope.gui.error = false;
			
			if($scope.fNuevo.$valid) //Es válido > Enviar
			{
				$scope.gui.cargando = true;
				
				$http.post(_sitePath_ + controlador + '/nuevo_registrar' + _suffix_, $scope.form).
				success(function(data) {
					if(data.error == 0)
					{
						$scope.gui.exito = true;
						$scope.nuevo_id = data.id;
					}
					else
					{
						$scope.gui.error = true;
						$scope.gui.error_msg = data.msg;
					}
				})
				.error(function() {
					$scope.gui.error = true;
				})
				.finally(function(){
					$scope.gui.cargando = false;
				});
			}
			else //Algo anda mal...
				$scope.gui.invalid = true;
		}
	};
	
}]);