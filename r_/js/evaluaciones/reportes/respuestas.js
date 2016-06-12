'use strict';
var controlador = 'evaluaciones';
app.controller('appController', ['$scope', '$rootScope', '$http', '$filter', '$timeout', function($scope, $rootScope, $http, $filter, $timeout) {	
	$scope.moment = moment;
	$scope.gui = {
		cargando: true,
		cargandoError: false
	};
	
	$scope.tabla = {
		filtro: '',
		registros: '10',
		mostrar: 'n',
		status: '-1',
		orden: 'empleado_n',
		direccion: 'asc'
	}

	var respuestasCompletas = [];
	$scope.registros = [];
	
	$http.post( _sitePath_ + controlador + '/respuestas_registros' + _suffix_, {
		evaluacion: _eval_
	})
	.then(function (response) {
		if(response.data.error > 0)
			$scope.gui.cargandoError = true;
		else
			respuestasCompletas = $scope.registros = response.data;
	}, function (response) {
		$scope.gui.cargandoError = true;
	}).finally(function(){
		$scope.gui.cargando = false;
	});
	
	//Filtro según status
	$scope.$watch('tabla.mostrar', function(_new, _old){
		switch(_new)
		{
			case 'ev_fecha':
				$scope.registros = respuestasCompletas.filter(function (r) {
					return r.ev_fecha != null;
				});
				break;
			case 'aev_fecha':
				$scope.registros = respuestasCompletas.filter(function (r) {
					return r.aev_fecha != null;
				});
				break;
			case 'b':
				$scope.registros = respuestasCompletas.filter(function (r) {
					return r.ev_fecha != null && r.aev_fecha != null;
				});
				break;
			default:
				$scope.registros = respuestasCompletas;
		}
		// $scope.$apply();
	});
}]);