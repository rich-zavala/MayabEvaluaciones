//Dibuja los elementos de la jerarquía
app.directive('treeRender', ['$compile', function($compile) {
  return {
    restrict: 'E',
		replace: true,
    scope: {
      obj: '=info',
      parent: '=parent',
      functions: '=functions'
    },
    templateUrl: _sitePath_ + 'r_/js/evaluaciones/jerarquias/tree_render.html',
		compile: function(element) {
			return directiveCompile(element,  $compile);
		},
    controller: ['$scope', '$rootScope', '$http', '$uibModal', function($scope, $rootScope, $http, $uibModal) {
			//Agregar
			$scope.agregar = $scope.functions.agregar;
			
			//Eliminación
			$scope.eliminar = function(){
				if(confirm("Confirme la eliminación de este empleado de esta evaluación.\nTodos los subordinados también serán removidos."))
				{
					$scope.obj.wait = true;
					var info = {
						evaluacion: $scope.obj.evaluacion,
						empleado: $scope.obj.empleado
					};
					$http.post(_sitePath_ + controlador + '/eliminar' + _suffix_, { info: info } )
					.then(function(response){
						if(response.data.error == 0)
						{
							$scope.parent.subordinados.splice($scope.parent.subordinados.indexOf($scope.obj), 1);
						}
						else
							$scope.removerElemento(selectedItem);
					},function(msg){
						alert("Ha ocurrido un error. Intente de nuevo más tarde.");
						delete $scope.obj.wait;
					});
				}
			}
    }]
  };
}]);