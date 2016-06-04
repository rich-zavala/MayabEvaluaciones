//Ricardo 20Ene2016: This "compile" functions makes posible to reuse the directive in itself.

var directiveCompile = function(element, $compile) {
	var contents = element.contents().remove();
	var contentsLinker;
	return function (scope, iElement) {
		if (angular.isUndefined(contentsLinker)) {
			contentsLinker = $compile(contents);
		}

		contentsLinker(scope, function (clonedElement) {
			iElement.append(clonedElement);
		});
	};
}