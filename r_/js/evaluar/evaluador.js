/**
Controlador de cuestionarios de evaluación y autoevaluación del lado del usuario.
**/

'use strict';
var controlador = 'evaluar';
app.controller('appController', ['$scope', '$rootScope', '$http', '$timeout', function($scope, $rootScope, $http, $timeout) {
	//Herramientas
	$scope.moment = moment;
	$scope.evaluacion = _evaluacion_;
	
	//Modalidad de jefe: No mostrar cuestionario
	if(_modalidad_ == 'jefe')
	{
		$scope.evaluador = _evaluador_;
		$scope.data = {
			evaluacion: _evaluacion_.id,
			modalidad: 	'jefe',
			set: 				false
		};
	}
	
	//Modalidad de autoevaluación: Mostrar cuestionario enseguida
	if(_modalidad_ == 'autoevaluacion')
	{
		$scope.data = {
			evaluacion:	 _evaluacion_.id,
			modalidad: 	'autoevaluacion',
			empleado: 	_evaluador_.info,
			set: 				true
		};
	}
	
	//Iniciar evaluación de un empleado (Modalidad de jefe)
	$scope.evaluar = function(e){
		$scope.data.titulo = "Evaluando a " + e.n;
		$scope.data.empleado = e;
		$scope.data.set = true;
	};
	
	//Acciones de botones
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
		
		var datos = {
			modalidad: _modalidad_,
			info: valores,
			evaluador: _evaluador_.info,
			evaluado: $scope.data.empleado
		};
		
		$http.post(_sitePath_ + controlador + '/responder' + _suffix_, datos)
		.then(function(response){
			if(response.data.error == 0)
			{
				//Actualizar empleado
				$scope.data.empleado.respuesta = 1;
				if(_modalidad_ == 'jefe')
				{
					$scope.data.empleado.fechaRegistro = new Date();
					$scope.evaluador.info.avance++;
				}
				
				if(_modalidad_ == 'autoevaluacion') //Mostrar aviso de éxito
					$scope.data.empleado.autoFecha = true;
				
				$scope.data.set = false;
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
			$rootScope.$broadcast('cuestionario-registrado');
		});
	});
	
	//Cancelar evaluación
	$scope.cancelar = function(){
		$scope.data.set = !confirm("No se guardarán las respuestas elegidas durante esta evaluación.\nConfirme que no desea continuar por el momento.");
	};
}]);