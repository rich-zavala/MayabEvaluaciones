var app = angular.module('app', ['ui.bootstrap']);

//Modal de eliminación
app.controller('eliminarController', [ '$scope', '$rootScope', '$http', '$uibModalInstance', 'data', function ($scope, $rootScope, $http, $uibModalInstance, data) {
	$scope.registro = data;
	$scope.data = {
		tabla: data.tabla,
		id: data.id
	};
	
	//Inicializar eliminación
	$scope.registrar = function () {
		if(!$scope.gui.ocupado)
		{
			alertReset();
			$scope.gui.ocupado = true;
			
			$http.post(_sitePath_ + 'comunes/eliminar' + _suffix_, $scope.data).
			success(function(d) {
				if(d.error == 0)
				{
					$scope.gui.exito = true;
					$rootScope.$broadcast('registroEliminacion', $scope.data);
				}
				else
				{
					$scope.gui.error = true;
					$scope.error = d.msg;
				}
			})
			.error(function() {
				$scope.gui.error = true;
			})
			.finally(function(){
				$scope.gui.ocupado = false;
			});
		}
	};
	
	//Cerrar modal
	$scope.cancelar = function () {
		$uibModalInstance.dismiss('cancel');
	};
	
	//Reseteo de valores de alerta
	$scope.gui = {};
	var alertReset = function(){
		$scope.gui.ocupado = false;
		$scope.gui.exito = false;
		$scope.gui.error = false;
		$scope.gui.invalid = false;
	};
	
	alertReset();
}]);

//Filtro para sanitizar html. Si no se utiliza marca error
app.filter('to_trusted', ['$sce', function($sce) {
	return function(text) {
		return $sce.trustAsHtml(text);
	};
}]);

app.directive('hoverClass', function () {
	return {
		restrict: 'A',
		scope: {
			hoverClass: '@'
		},
		link: function (scope, element) {
			element.on('mouseenter', function() {
				element.addClass(scope.hoverClass);
			});
			element.on('mouseleave', function() {
				element.removeClass(scope.hoverClass);
			});
		}
	};
});