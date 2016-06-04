<div class="nav-tabs-custom" ng-controller="appController">
  <ul class="nav nav-tabs">
		<li ng-repeat="tab in tabs" ng-class="{ active: tabActual == tab }"><a ng-click="activarTab(tab)">{{tab.titulo}}</a></li>
	</ul>	
	<competencias-formulario tipo="tab.tipo" niveles="tab.niveles" competencias="tab.competencias" intro="tab.intro" gui="tab.gui" ng-show="tabActual == tab" ng-repeat="tab in tabs"></competencias-formulario>
</div>