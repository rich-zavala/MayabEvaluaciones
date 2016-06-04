<div class="nav-tabs-custom" ng-controller="appController">
  <ul class="nav nav-tabs">
		<li ng-repeat="tab in tabs" ng-class="{ active: tabActual == tab }"><a ng-click="activarTab(tab)">{{tab.titulo}}</a></li>
	</ul>
	<cartas-controller tipo="tab.tipo" ng-show="tabActual == tab" ng-repeat="tab in tabs"></cartas-controller>
</div>