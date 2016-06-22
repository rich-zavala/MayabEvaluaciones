<script>
var _eval_ = parseInt(<?=$evaluacion?>);
</script>
<div ng-app="app" ng-cloak>
	<section class="content-header">
		<h1>
			<i class="fa fa-fw fa-list marginRight10"></i> Aplicación de evaluaciones &quot;<b><?=$info->titulo?></b>&quot;
		</h1>
	</section>
	
	<section class="content">
		<div class="nav-tabs-custom jerarquias">
			<ul class="nav nav-pills navMayab marginBottom10">
				<?php foreach($secciones as $seccion => $seccion_info){ ?>
				<li <?=($actual == $seccion) ? 'class="active"' : ''?>>
					<a href="evaluaciones/<?=$seccion?>/<?=$evaluacion.suffix()?>">
						<i class="fa fa-fw fa-<?=$seccion_info['fa']?>"></i>
						<?=$seccion_info['titulo']?>
					</a>
				</li>
				<?php } ?>
			</ul>
		</div>
		
		