/*
18 Mayo 2016 > Ricardo Zavala
Todos los objetos relacionados con niveles o puestos hacen referencia a la palabra "nivel".
Esto es porque el requerimiento inicial sólamente comprendía niveles. Posteriormente se
agregó la opción de los puestos. Por eso no tiene sentido, pero así está la cosa.
*/

'use strict';
var controlador = 'cuestionarios';

//Controlador para el listado y envío de cartas
app.controller('appController', ['$scope', '$rootScope', '$http', '$timeout', function($scope, $rootScope, $http, $timeout) {
	//Catálogos
	$scope.gui = {
		cargandoNiveles: true,
		cargandoCompetencias: true,
		nivelesGuardando: false
	};
	
	// $scope.vinculaPuestos = { titulo: null }; //Info del cuestionario tipo vinculaPuesto
	$scope.tabs = [
		{
			tipo: 0,
			titulo: 'Niveles',
			intro: 'Defina los cuestionarios específicos por cada nivel.',
			niveles: [],
			competencias: [],
			gui: $scope.gui
		},
		{
			tipo: 1,
			titulo: 'Puestos',
			into: null,
			niveles: [],
			competencias: [],
			gui: $scope.gui
		}
	];
	
	//Cambio de tab
	$scope.activarTab = function(tab){
		$scope.tabActual = tab;
		
		//Emitir evento de carga a la directiva
		// $rootScope.$broadcast('cargarInfo', tab);
	};
	$scope.niveles = [];
	
	//Obtener niveles
	var obtenerNivelesInfo = function(niveles, puestos){
		$scope.gui.cargandoNiveles = true;
		
		var params = {
			evaluacion: _eval_,
			niveles: niveles,
			puestos: puestos
		};
		
		$http.post( _sitePath_ + controlador + '/niveles_puestos' + _suffix_, params)
		.then(function (response) {
			if(params.niveles) $scope.tabs[0].niveles = response.data.niveles;
			if(params.puestos) $scope.tabs[1].niveles = response.data.puestos;
		}, function (response) {
			$scope.gui.cargandoNivelesError = true;
		}).finally(function(){
			$scope.gui.cargandoNiveles = false;
			
			//Para recarga después de guardar competencias
			$scope.editandoCompetencias = false;
			$scope.nivel_elegido = {};
		});
	};
	obtenerNivelesInfo(true, true);
	
	//Obtener competencias
	$http.post( _sitePath_ + controlador + '/competencias' + _suffix_, { evaluacion: _eval_ })
	.then(function (response) {
		//Identificar las competencias de niveles y de puestos
		for(var i in response.data)
		{
			if(response.data[i].principal == 1)
				$scope.tabs[0].competencias.push(response.data[i]);
			else
				$scope.tabs[1].competencias.push(response.data[i]);
				
			if(response.data[i].vinculaPuestos == 1)
				$scope.tabs[1].intro = 'Defina los cuestionarios específicos por cada puesto. Estos cuestionarios se mostrarán cuando la evaluación por nivel alcance a <b>&quot;' + response.data[i].titulo + '&quot;</b>.';
		}
	}, function (response) {
		$scope.gui.cargandoCompetenciasError = true;
	}).finally(function(){
		$scope.gui.cargandoCompetencias = false;
	});

	//Clave contestada: Recargar información de niveles
	$scope.$on('cuestionario-registrado', function(event, args) {
		obtenerNivelesInfo( args.tipo == 0, args.tipo == 1 );
	});
	
	//Activar la primera pestaña
	$timeout(function(){ $scope.activarTab($scope.tabs[0]); }, 1);
}]);

//Directiva
app.directive('competenciasFormulario', ['$compile', function($compile) {
  return {
    restrict: 'E',
		replace: true,
    scope: {
      tipo: '=tipo',
      niveles: '=niveles',
      competencias: '=competencias',
      intro: '=intro',
      gui: '=gui'
    },
    templateUrl: _sitePath_ + 'r_/js/evaluaciones/cuestionarios/competencias.html',
    controller: ['$scope', '$rootScope', '$http', '$filter', '$uibModal', '$timeout', function($scope, $rootScope, $http, $filter, $uibModal, $timeout) {
			$scope.moment = moment;
			
			//Elección de competencias
			$scope.elegirNivel = function(obj){
				if(!$scope.gui.nivelesGuardando)
				{
					$scope.editandoCompetencias = true;
					$scope.nivel_elegido = obj;
					for(var i in $scope.competencias)
					{
						$scope.competencias[i].activo = false;
						for(var ii in obj.competencias)
						{
							if(($scope.competencias[i].tipo == "competencia" && $scope.competencias[i].id == obj.competencias[ii].id_competencia) ||
								 ($scope.competencias[i].tipo == "manual" && $scope.competencias[i].id == obj.competencias[ii].id_manual))
							{
								$scope.competencias[i].activo = true;
								break;
							}
						}
					}
					
					$scope.nivel_elegido_competencias = angular.copy($scope.competencias);
				}
			};
			
			//Agregar o remover una competencia al nivel seleccionado
			$scope.competenciaAgregar = function(competencia){
				if(!$scope.gui.nivelesGuardando)
					competencia.activo = !competencia.activo;
			}
			
			//Guardar cambios hechos en la asignación de competencias
			$scope.competenciasGuardar = function(competencia){
				var continuar = true;
				
				//Alertar al usuario del reseteo de respuestas
				if($scope.nivel_elegido.clave_registrada == 1)
					continuar = confirm("¡IMPORTANTE!\nAl manipular los cuestionarios que conforman este nivel TODAS LAS RESPUESTAS CLAVE SERÁN ELIMINADAS.\n¿Desea continuar?");
				
				if(continuar)
				{
					$scope.gui.nivelesGuardando = true;
					var competencias = [];
					for(var i in $scope.competencias)
					{
						if($scope.competencias[i].activo)
						{
							var competencia = {
								evaluacion: _eval_,
								nivel: $scope.nivel_elegido.nivel,
								tipo: $scope.competencias[i].tipo,
								id_competencia: ($scope.competencias[i].tipo == 'competencia') ? $scope.competencias[i].id : null,
								id_manual: ($scope.competencias[i].tipo == 'manual') ? $scope.competencias[i].id : null
							}
							competencias.push(competencia);
						}
					}
					
					//Objeto de inserción
					var data = {
						evaluacion: _eval_,
						nivel: $scope.nivel_elegido.nivel,
						tipo: $scope.tipo,
						competencias: competencias
					};
					
					$http.post( _sitePath_ + controlador + '/registrar_competencias' + _suffix_, data)
					.then(function (response) {
						if(response.data.error == 0)
						{
							$scope.nivel_elegido.competencias = response.data.data;
							$scope.nivel_elegido_competencias = angular.copy($scope.competencias);
							$scope.gui.nivelesGuardadoExito = true;
							$scope.nivel_elegido.clave_registrada = 0;
							setTimeout(function(){
								$('#nivelesGuardadoExito').fadeOut(function(){
									competenciasGuardado();
									$scope.$apply();
								});
							}, 2000);
						}
						else
						{
							alert("Ha ocurrido un error. Intente de nuevo más tarde.");
							competenciasGuardado();
						}
					}, function (response) {
						alert("Ha ocurrido un error. Intente de nuevo más tarde.");
						competenciasGuardado();
					});
				}
			};
			
			var competenciasGuardado = function(){
				$scope.gui.nivelesGuardadoExito = false;
				$scope.gui.nivelesGuardando = false;
			};

			//Cerrar columna de competencias
			$scope.competenciasCerrar = function(){
				$scope.editandoCompetencias = false;
				$scope.nivel_elegido = null;
				$scope.nivel_elegido_competencias = null;
				competenciasGuardado();
			};
			$scope.competenciasCerrar();

			/* Contestar preguntas para registrar la clave */
			$scope.contestarClave = function(obj){
				if(!$scope.gui.nivelesGuardando)
				{
					var data = { //Objeto para pasar al controlador del modal
						modalidad: 'clave',
						tipo: $scope.tipo,
						evaluacion: _eval_,
						empleado: {
							nivel: obj.nivel
						},
						modalScope: {
							titulo: obj.nivel_n
						}
					};
					
					var modalInstance = $uibModal.open({
						templateUrl: _sitePath_ + 'r_/js/evaluaciones/cuestionarios/modalClave.html',
						controller: 'cuestionariosCtrl',
						size: 'lg',
						keyboard: false,
						backdrop: false,
						resolve: {
							data: data
						}
					});
				}
			};
			
			//Listado títulos de competancias
			$scope.titulosCompetencias = function(com){
				var r = [];
				angular.forEach(com, function(v, k){
					r.push($($.parseHTML('<span>' + v.titulo + '</span>')).text()); //Limpiar el texto del título
				});
				return r.join(', ');
			};
		}]
  }	
}]);