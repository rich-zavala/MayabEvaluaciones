'use strict';
var controlador = 'cartas';

//Controlador de tabs
app.controller('appController', ['$scope', '$rootScope', '$timeout', function($scope, $rootScope, $timeout) {
	$scope.tabs = [
		{ tipo: 0, titulo: 'Evaluaciones', intro: 'jefes para evaluación' },
		{ tipo: 1, titulo: 'Autoevaluaciones', intro: 'empleados para autoevaluación' }
	];
	
	//Cambio de tab
	$scope.activarTab = function(tab){
		$scope.tabActual = tab;
		
		//Emitir evento de carga a la directiva
		$rootScope.$broadcast('cargarInfo', tab);
	};
	
	//Activar la primera pestaña
	$timeout(function(){ $scope.activarTab($scope.tabs[0]); }, 250);
}]);

//Controlador para el listado y envío de cartas
app.directive('cartasController', ['$compile', function($compile) {
  return {
    restrict: 'E',
		replace: true,
    scope: {
      tipo: '=tipo'
    },
    templateUrl: _sitePath_ + 'r_/js/evaluaciones/cartas/listado.html',
		compile: function(element) {
			return directiveCompile(element,  $compile);
		},
    controller: ['$scope', '$rootScope', '$http', '$filter', '$uibModal', '$timeout', function($scope, $rootScope, $http, $filter, $uibModal, $timeout) {
			$scope.moment = moment;
			$scope.gui = {
				cargando: true,
				cargandoError: false
			};
			
			//Iniciar carga de información
			$scope.tab = {};
			var infoCargada = false;
			$scope.$on('cargarInfo', function(event, tab) {
				if(tab.tipo == $scope.tipo && !infoCargada)
				{
					$scope.tab = tab;
					infoCargada = true;
					cargarInfo();
				}
			});
			
			//Obtener catálogo
			var cargarInfo = function(){
				$http.post( _sitePath_ + 'cartas/info' + _suffix_, {
					info: {
						evaluacion: _eval_,
						tipo: $scope.tab.tipo
					}
				})
				.then(function (response) {
					//Obtener jerarquía
					$scope.data = response.data;
				}, function (response) {
					$scope.gui.cargandoError = true;
				}).finally(function(){
					$scope.gui.cargando = false;
				});
			}
			
			$scope.enviarCartas = function (obj) {
				var modalInstance = $uibModal.open({
					templateUrl: _sitePath_ + 'r_/js/evaluaciones/cartas/enviar' + _suffix_,
					controller: 'modalEnviarCartas',
					size: 'md',
					resolve: {
						data: {
							data: $scope.data,
							tab: $scope.tab
						}
					}
				});
			};
		}]
  }	
}]);

//Modal de agregación
app.controller('modalEnviarCartas', [ '$scope', '$http', '$uibModalInstance', 'data', function ($scope, $http, $uibModalInstance, data) {
	$scope.data = data.data;
	$scope.tab = data.tab;
	if(!$scope.data.avance) $scope.data.avance = 0;
	
	$scope.gui = {
		envioDisponible: data.data.id == 0 || data.data.avance == 0,
		enviadoPreviamente: data.data.avance >= 100,
		enviadoParcialmente: data.data.avance > 0 && data.data.avance < 100,
		envioExito: false,
		envioError: false
	};
	
	//El proceso de envío continúa incluso después de cerrar el modal...
	var cerrado = false;
  $scope.cancel = function () {
		$uibModalInstance.dismiss();
		data.data.enviando = false;
		cerrado = true;
	};
	
	//Enviar desde cero
	var empleados = [];
	$scope.enviar = function() {
		var reseteo = $scope.gui.enviadoPreviamente;
		var continuar = true;
		
		if(reseteo)
			continuar = confirm("Se han realizado envíos con anterioridad.\nSi elige continuar los destinatarios recibirán los mensajes nuevamente.\n¿Desea continuar?");
	
		if(continuar)
		{
			//Crear arreglo monodimensional de jerarquía
			empleados = [];
			$scope.data.jerarquia.forEach(function(empleado){ objFlat(empleado); });
			
			//Resetear todo si es neceario
			if(reseteo)
			{
				empleados.forEach(function(empleado){
					empleado.carta.envio = 0
				});
				data.data.id = 0;
				data.data.avance = 0;
			}
			
			//Es primer envío o se solicita enviar desde 0
			if(reseteo || data.data.avance == 0)
			{
				var callback = function(d){
					$scope.data.id = d;
					envioEmpleadoCallback(null);
				};
				var callbackError = function(d){
					$scope.gui.cargando = false;
				};
				
				nuevoEnvio(callback, callbackError);
			}
			else //Continuar
			{
				envioEmpleadoCallback(null);
			}
		}
	}
	
	//Función para crear arreglo monodimensional
	var objFlat = function(obj){
		empleados.push(obj);
		if('subordinados' in obj)
			obj.subordinados.forEach(function(empleado){ objFlat(empleado); });
	};
	
	//Crear nuevo índice de envío
	var nuevoEnvio = function(callback, callback_error){
		data.data.enviando = true;
		$scope.empleadoEnviando = false;
		$http.post( _sitePath_ + 'cartas/nuevo_envio' + _suffix_, {
			data: {
				evaluacion: _eval_,
				tipo: $scope.tab.tipo,
				empleadosTotales: empleados.length
			}
		})
		.then(function (response) {
			callback(response.data);
		}, function (response) {
			$scope.gui.envioError = true;
		}).finally(function(){
			callback_error();
		});
	};
	
	//Auxiliar de envío a empleados
	var envioEmpleadoCallback = function(obj){
		var index = empleados.indexOf(obj);
		var next = index + 1;
		if(next in  empleados)
		{
			var nextEmpleado = empleados[next];
			if(typeof nextEmpleado.carta == 'undefined' || nextEmpleado.carta.envio == 0)
				enviarCarta(nextEmpleado, envioEmpleadoCallback);
			else
				envioEmpleadoCallback(nextEmpleado);
		}
		else
		{
			data.data.enviando = false;
			$scope.gui.envioExito = true;
		}
	}
	
	//Enviar email a un empleado
	var enviarCarta = function(empleado, callback){
		if(!cerrado)
		{
			$scope.empleadoEnviando = empleado;
			data.data.enviando = true;
			$http.post( _sitePath_ + 'cartas/enviar' + _suffix_, {
				data: {
					evaluacion: _eval_,
					tipo: $scope.tab.tipo,
					empleado: empleado,
					envio: $scope.data.id
				}
			})
			.then(function (response) {
				if(response.data.error == 0)
				{
					empleado.carta = {
						envio: $scope.data.id,
						fechaRegistro: new Date()
					};
					data.data.avance = response.data.avance;
					callback(empleado);
				}
				else
					$scope.gui.envioError = true;
			}, function (response) {
				$scope.gui.envioError = true;
			});
		}
	};
}]);

//Capitalizar cadena
String.prototype.capitalizeFirstLetter = function() {
  return this.charAt(0).toUpperCase() + this.slice(1);
}