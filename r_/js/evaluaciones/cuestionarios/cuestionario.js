'use strict';
var controlador = 'cuestionarios';

//Controlador de cuestionarios
/*
== Funciona por igual para clave, respuestas de jefes y autoevaluaciones ==
En el parámetro "data" se recibe información de funcionamiento:
{
	modalidad:	Puede ser una de tres 'clave' || 'jefe' || 'autoevaluacion'
							Con esto se define el funcionamiento del controlador.
	empleado:		Auxiliar para conocer qué cuestionario se va a aplicar. Es un objeto JSON:
	{
		nivel:		Necesitamos el nivel para saber qué cuestionario aplicar.
							Aunque en 'clave' no tengamos empleado se tiene que definir este nivel obligatoriamente.
		...:			Otros datos del empleado como nombre, puesto y esas cosas.
	}
	evaluación:	ID de la evaluación.
	exito:			Función para llamar cuando se registre correctamente un cuestionario.
	error:			Función para llamar cuando algo salga mal.
}
*/
app.controller('cuestionariosCtrl', [ '$scope', '$rootScope', '$http', '$timeout', '$sce', '$uibModalInstance', 'data', function ($scope, $rootScope, $http, $timeout, $sce, $uibModalInstance, data) {
 $scope.cancelar = function () {
		if(!$scope.gui.ocupado)
			$uibModalInstance.dismiss();
  };
	
	$scope.gui = ''; //Información de gui. Se obtiene todo desde la directiva de formulario.js
	
	//Asignar scope desde 'data' si el controlador está en modal
	if(typeof data.modalScope != 'undefined')
		for(var i in data.modalScope)
			$scope[i] = data.modalScope[i];
	
	//Objeto de información para directiva de cuestionario
	data.titulo = $scope.titulo;
	$scope.data = data;
	
	//Acciones
	$scope.siguiente = function(){ $rootScope.$broadcast('form-siguiente', { gui: $scope.gui }); };
	$scope.anterior = function(){ $rootScope.$broadcast('form-anterior', { gui: $scope.gui }); };
	$scope.registrar = function(){ $rootScope.$broadcast('form-registrar', { gui: $scope.gui }); };
	
	/* Receptores de broadcasts */
	$scope.$on('gui-update', function(event, args) { $scope.gui = args; });
	
	/* Función de registro */
	$scope.$on('formulario-valores', function(event, valores) {
		$scope.gui.ocupado = true;
		$scope.gui.error = false;
		$scope.gui.exito = false;
		
		$http.post(_sitePath_ + controlador + '/registrar_clave' + _suffix_, { info: valores })
		.then(function(response){
			if(response.data.error == 0)
			{
				$scope.gui.exito = true;
				$timeout(function(){
					$scope.gui.exito = false;
				}, 2000);
			}
			else
				$scope.gui.error = true;
		},function(msg){
			$scope.gui.error = true;
		}).finally(function(){
			$scope.gui.ocupado = false;
			
			//Enviar broadcast de éxito
			$rootScope.$broadcast('cuestionario-registrado', { tipo: data.tipo });
		});
	});
	
}]);