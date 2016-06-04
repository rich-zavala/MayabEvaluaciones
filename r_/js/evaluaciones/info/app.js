'use strict';
app.controller('appController', ['$scope', '$rootScope', '$http', '$filter', '$timeout', function($scope, $rootScope, $http, $filter, $timeout) {	
	//Info para cuadros
	$scope.info = {
		evaluacion: {
			cartas: objCrear('Envío de cartas', 'envelope', _info_.cartas_eval_avance, _info_.cartas_eval_fecha),
			respuestas: objCrear('Respuestas', 'file-text', _info_.eval_avance, null),
			reportes: objCrear('Envío de reportes', 'bar-chart', _info_.reporte_eval_avance, _info_.reporte_eval_fecha)
		},
		autoevaluacion: {
			cartas: objCrear('Envío de cartas', 'envelope', _info_.cartas_auto_avance, _info_.cartas_auto_fecha),
			respuestas: objCrear('Respuestas', 'file-text', _info_.auto_avance, null),
			reportes: objCrear('Envío de reportes', 'bar-chart', _info_.reporte_auto_avance, _info_.reporte_auto_fecha)
		}
	};
	
	//Cambio de status
	$scope.statusOptions = [ objStatusCrear(0, 'Cerrado'), objStatusCrear(1, 'Evaluación activa'), objStatusCrear(3, 'Autoevaluación activa')];
	$scope.status = $scope.statusOptions.filter(function(o){ return (o.val == _info_.status) })[0];
	var changeStatus = true;
	$scope.$watch('status', function(ne, ol){
		if(ol != ne && changeStatus)
		{
			$http.post( _sitePath_ + 'comunes/actualizar' + _suffix_, {
				tabla: 'evaluaciones',
				valor: ne.val,
				campo: 'status',
				id: _info_.id
			})
			.then(function (response) {
				if(response.data.error > 0)
					changeStatusError(ol);
			}, function (response) {
				changeStatusError(ol);
			});
		}
		else
			changeStatus = true;
	});

	var changeStatusError = function(obj){
		alert("Ha ocurrido un error. Intente de nuevo más tarde.");
		changeStatus = false;
		$scope.status = obj;
	};
}]);

var objCrear = function(titulo, icono, porcentaje, fecha){
	return {
		titulo: titulo,
		icono: icono,
		porcentaje: porcentaje,
		fecha: fecha
	};	
}

var objStatusCrear = function(val, descripcion){
	return {
		val: val,
		descripcion: descripcion
	};	
}

//Cuadros de información
app.directive('infoBox', ['$compile', function($compile) {
  return {
    restrict: 'E',
		replace: true,
    scope: {
      info: '=info'
    },
    templateUrl: _sitePath_ + 'r_/js/evaluaciones/info/infoBox.html',
    controller: ['$scope', function($scope) {
			$scope.moment = moment;
			
			if(!$scope.info.porcentaje)
				$scope.info.porcentaje = 0;
		}]
  };
}]);