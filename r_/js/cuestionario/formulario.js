app.directive('templateFormulario', [function() {
  return {
    restrict: 'E',
		replace: true,
    scope: {
      data: '=data'
    },
    templateUrl: _sitePath_ + 'r_/js/cuestionario/formulario.html',
    controller: ['$scope', '$rootScope', '$http', '$filter', '$uibModal', '$timeout', function($scope, $rootScope, $http, $filter, $uibModal, $timeout) {
			var data = $scope.data;
			
			//Manejador de gui
			$scope.gui = {
				cargando:							true,		//Cargando información de cuestionario
				cargandoError:				false,	//Error cargando cuestionario o respuestas
				cargandoRespuestas:		false,	//Cargando respuestas previamente registradas
				guardando:						false,	//Guardando respuestas
				guardandoError:				false,	//Error guardando respuestas
				ultimoCuestionario:		false,	//Es la última página del último cuestionario
				primerCuestionario:		true		//Es la primra página del primer cuestionario
			};
			
			//Actualiza GUI de padre
			var guiUpdated = function(){ $rootScope.$broadcast('gui-update', $scope.gui); };
			guiUpdated();
			$scope.$watch('gui', function(){
				guiUpdated();
			})
			
			//Objeto que contiene el cuestionario
			$scope.cuestionario = [];
			var cuestionarioOrden = [];
			var cuestionarioActual = 0;
			
			//Obtener JSON de cuestionario
			var info = {
				modalidad: data.modalidad,
				tipo: data.tipo,
				evaluacion: data.evaluacion,
				nivel: data.empleado.nivel,
				puesto: data.empleado.puesto
			};
			
			//Obtener URL para el JSON del cuestionario según su modalidad
			var cuestionarioUrl = _sitePath_ + controlador;
			switch(data.modalidad)
			{
				case 'clave':
					//Obtener respuestas registradas con anterioridad después de generar el orden de preguntas
					obtenerRespuestas = function(){ //Sobreescribe función dummy inicial
						$scope.gui.cargandoRespuestas = true;
						$http.post(_sitePath_ + controlador + '/respuestas_clave' + _suffix_, info)
						.then(function(response){
							var respData = response.data;
							angular.forEach(respData.competencias, function(v, i){ //Respuestas de competencias
								$scope.datos.respuestas.competencias[i].id_valor = v;
							});
							
							angular.forEach(respData.manual.abierto, function(v, i){ //Respuestas de abiertos manuales
								$scope.datos.respuestas.manual.abierto[i].valor = v;
							});
							
							angular.forEach(respData.manual.opciones, function(v, i){ //Respuestas de abiertos con opciones
								$scope.datos.respuestas.manual.opciones[i].id_opcion_respuesta = v.id_opcion_respuesta;
								$scope.datos.respuestas.manual.opciones[i].valor_manual = v.valor_manual;
							});
						},function(msg){
							$scope.gui.cargandoError = true;
						}).finally(function(){
							$scope.gui.cargandoRespuestas = false;
						});
					};
					
					// cuestionarioUrl +=  '/' + data.modalidad + '/' + data.evaluacion + '/' + data.empleado.nivel;
					cuestionarioUrl +=  '/clave';
					break;
				case 'jefe':
					cuestionarioUrl +=  '/cuestionario'; ///' + data.evaluacion + '/' + data.empleado.nivel;
					break;
				case 'autoevaluacion':
					break;
			}
			
			$http.post(cuestionarioUrl + _suffix_, info)
			.then(function(response){
				$scope.cuestionario = response.data.competencias;
				$scope.competenciaActual = $scope.cuestionario[0].id;
				$scope.seccionActual = $scope.cuestionario[0].secciones[0].id;
				
				ordenCuestionarios();
				$scope.gui.cargando = false;
			},function(msg){
				$scope.gui.cargandoError = true;
			});
			
			//Navegación en el cuestionario
			var currentForm, cuestionarioActualForm;
			$scope.setForm = function (form) {
				currentForm = form;
				setCuestionarioActual();
			};
			
			var siguiente = function(){
				cuestionarioActualForm.$submitted = true;
				if(cuestionarioActualForm.$valid)
				{
					if(cuestionarioOrden.length > (cuestionarioActual + 1))
						cuestionarioActual++;
					
					$scope.gui.ultimoCuestionario = cuestionarioOrden.length <= (cuestionarioActual + 1); //¿Es el último?
					$scope.gui.primerCuestionario = false;
					
					setCuestionarioActual();
				}
			};
			
			var anterior = function(){
				if(cuestionarioActual > 0)
					cuestionarioActual--;
				
				$scope.gui.primerCuestionario = cuestionarioActual <= 0;
				$scope.gui.ultimoCuestionario = false;
				setCuestionarioActual();
			};
			
			var setCuestionarioActual = function(){
				$timeout(function(){ //	¡Otra cosa rara!
					$scope.competenciaActual = cuestionarioOrden[cuestionarioActual].competencia;
					$scope.seccionActual = cuestionarioOrden[cuestionarioActual].seccion;
					cuestionarioActualForm =  currentForm['f_' + $scope.competenciaActual + '_' + $scope.seccionActual];
					
					if(typeof cuestionarioActualForm != 'undefined') //Esperar a que esté listo el objeto
					{
						cuestionarioActualForm.$submitted = false;
						if($('.modal, #contenedorPrincipal').scrollTop() > 150)
							$('.modal, #contenedorPrincipal').animate({ scrollTop: 150 }, 500);
					}
				});
			};
			
			//Registrar
			var registrar = function(){				
				cuestionarioActualForm.$submitted = true;
				if(cuestionarioActualForm.$valid)
					$rootScope.$broadcast('formulario-valores', $scope.datos );
			};
			
			//Indezar orden de los cuestionarios y crear objetos de respuesta
			var ordenCuestionarios = function(){
				$scope.datos.respuestas.competencias = {};
				$scope.cuestionario.forEach(function(cuestionario, cIndex){
					/*
					20 Mayo 2015 > Ricardo Zavala
					A los cuestionarios de tipo "vinculaPuestos" se les da un tratamiento especial
					*/
					if(cuestionario.vinculaPuestos == 1)
						cuestionario.secciones = [{ mostrarPuestos: true, id : 0 }];
					
					cuestionario.secciones.forEach(function(seccion, sIndex){
						cuestionarioOrden.push({
							competencia: cuestionario.id,
							seccion: seccion.id
						});
						
						//Setear objeto de respuestas
						if(typeof seccion.mostrarPuestos != 'undefined')
						{
						}
						else if(cuestionario.tipo == "competencia")
							seccion.conductas.forEach(function(conducta, conIndex){
								$scope.datos.respuestas.competencias[conducta.id] = { //Objeto de respuesta
									evaluacion: $scope.datos.evaluacion,
									nivel: $scope.datos.nivel,
									id_conducta: conducta.id,
									id_valor: null
								};
							});
						else
						{
							$scope.datos.respuestas.manual = {
								abierto: {},
								opciones: {}
							};
							seccion.preguntas.forEach(function(pregunta, pIndex){
								if(pregunta.tipo == "abierto")
								{
									for(var i = 0; i < pregunta.inputsCantidad; i++)
									{
										$scope.datos.respuestas.manual.abierto[pregunta.id + '_' + i] = { //Objeto de respuesta
											evaluacion: $scope.datos.evaluacion,
											nivel: $scope.datos.nivel,
											id_manual_input_pregunta: pregunta.id,
											indice: i,
											valor: null
										};
									}
								}
								
								if(pregunta.tipo == "opciones")
								{
									pregunta.opciones.forEach(function(opcion, oIndex){
										$scope.datos.respuestas.manual.opciones[opcion.id] = { //Objeto de respuesta
											evaluacion: $scope.datos.evaluacion,
											nivel: $scope.datos.nivel,
											id_opciones_input_manual: opcion.id,
											id_opcion_respuesta: null,
											valor_manual: null
										};
									});
								}
							});
						}
					});
				});
				
				//Obtener preguntas si es necesario
				if(data.modalidad == 'clave') obtenerRespuestas();
				
				//Checar si sólo hay un cuestionario
				if(cuestionarioOrden.length == 1)
					$scope.gui.ultimoCuestionario = true;
			};
			
			//Obtener arreglo para repeat en preguntas abiertas
			$scope.getNumber = function(num) { return new Array(num); }
			
			/* Respuestas y validaciones */
			$scope.datos = {
				evaluacion: data.evaluacion,
				nivel: data.empleado.nivel,
				tipo: data.tipo,
				respuestas: {}
			};
			
			/* Manejador de broadcast desde los controladores padre */
			$scope.$on('form-siguiente', function() { siguiente(); });
			$scope.$on('form-anterior', function() { anterior(); });
			$scope.$on('form-registrar', function() { registrar(); });
		}]
  }
}]);