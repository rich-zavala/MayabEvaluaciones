//Dibuja los elementos de la jerarquía
app.directive('treeRender', ['$compile', function($compile) {
  return {
    restrict: 'E',
		replace: true,
    scope: {
      obj: '=info',
      parent: '=parent',
      data: '=data',
      tab: '=tab'
    },
    templateUrl: _sitePath_ + 'r_/js/evaluaciones/cartas/tree_render.html',
		compile: function(element) {
			return directiveCompile(element,  $compile);
		},
    controller: ['$scope', '$rootScope', '$http', '$uibModal', function($scope, $rootScope, $http, $uibModal) {
			$scope._sitePath_ = _sitePath_;
			$scope._suffix_ = _suffix_;
			$scope._eval_ = _eval_;
		}]
  };
}]);