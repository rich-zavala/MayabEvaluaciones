<body class="skin-yellow fixed">
	<div class="wrapper">
		<div class="content-wrapper">
			<header class="main-header">
				<a href="inicio.html" class="logo">
					<span class="logo-mini"><b>Ev</b>AM</span>
					<span class="logo-lg"><b>Evals.</b> Mayab</span>
				</a>

				<nav class="navbar navbar-static-top" role="navigation">
					<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
						<span class="sr-only">Cambiar navegación</span>
					</a>
					
					<div class="navbar-custom-menu">
						<ul class="nav navbar-nav">
							<li class="dropdown user user-menu">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">
									<img src="r_/images/user.png" class="user-image" alt="User Image">
									<span class="hidden-xs"><?=username()?></span>
								</a>
								<ul class="dropdown-menu">
									<li class="user-footer">
										<div class="text-center">
											<a href="<?=base('acceso/logout')?>" class="btn btn-warning btn-block"><i class="fa fa-fw fa-lock"></i> Cerrar sesión</a>
										</div>
									</li>
								</ul>
							</li>
						</ul>
					</div>
				</nav>
			</header>
			<aside class="main-sidebar">
				<section class="sidebar">
					<ul class="sidebar-menu">
						<li class="treeview">
							<a href="#"><i class="fa fa-fw fa-list"></i> <span>Evaluaciones</span> <i class="fa fa-angle-left pull-right"></i></a>
							<ul class="treeview-menu">
								<?php foreach($evaluaciones as $ev){ ?>
								<li><a href="<?=base('evaluaciones/info/' . $ev->id)?>"><?=$ev->titulo?></a></li>
								<?php } ?>
								<li><a href="<?=base('evaluaciones')?>"><i class="fa fa-fw fa-plus"></i> Nuevo</a></li>
							</ul>
						</li>
						<li><a href="<?=base('empleados')?>"><i class="fa fa-fw fa-users"></i> <span>Empleados</span></a></li>
						<li><a href="<?=base('usuarios')?>"><i class="fa fa-fw fa-user-secret"></i> <span>Usuarios</span></a></li>
					</ul><!-- /.sidebar-menu -->
				</section>
				<!-- /.sidebar -->
			</aside>