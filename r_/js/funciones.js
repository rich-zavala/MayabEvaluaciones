/*
Variables de identificación
Usados por Angular
¡NO CAMBIAR NI ELIMINAR!
*/
var _app_reservaciones_detalle_ready_ = false;

//Variables de AdminLTE
var AdminLTEOptions = {
	enableBSToppltip: false
};

function c(s){ try{console.log(s);}catch(e){} }
var _ajaxBussy_ = false;
$.ajaxSetup({
	method: 'post',
	dataType: 'json',
	complete: function(){ _ajaxBussy_ = false; }
});

//Evento de cambio de campo booleano
function cambioBool(o)
{
	o.click(function(e){
		e.preventDefault();
		if(!_ajaxBussy_)
		{
			_ajaxBussy_ = true;
			var t = $(this);
			var clone = t.clone();
			var data = t.data();
			obj = spinner(t);
			var callback = function(obj, data){
				clone.data('valor', data.result);
				obj.replaceWith(clone);
				cambioColor(clone);
				cambioBool(clone);
			}
			cambiar(data.tabla, data.id, data.campo, obj, callback);
		}
	});
}

//Mostrar spinner
function spinner(o)
{
	var classes = o.attr('class') + ' btn-disabled';
	var spin = $('<span class="' + classes + '" disabled><i class="fa fa-spinner fa-spin"></i></span>');
	o.replaceWith(spin);
	return spin;
}

//Mostrar link roto
function broken(o)
{
	var classes = o.attr('class') + ' btn-disabled';
	var spin = $('<span class="' + classes + '" disabled><i class="fa fa-unlink"></i></span>');
	o.replaceWith(spin);
	return spin;
}

//Establecer color
function cambioColor(o)
{
	if((o.data('valor') == 0 && !o.hasClass('cambioRol')) || (o.data('valor') == 1 && o.hasClass('cambioRol')))
	{
		o.removeClass('btn-danger').addClass('btn-success').text('Activo');
		if(o.hasClass('badge')) o.removeClass('progress-bar-danger').addClass('progress-bar-success'); //Para listado
	}
	else
	{
		o.removeClass('btn-success').addClass('btn-danger').text('Inactivo');
		if(o.hasClass('badge')) o.removeClass('progress-bar-success').addClass('progress-bar-danger');//Para listado
	}
}

//Cambiar el status de un campo booleano
function cambiar(tabla, id, campo, obj, callback)
{	
	$.ajax({
		url: _sitePath_ + 'acciones/cambio' + _suffix_,
		data: { tabla: tabla, id: id, campo: campo },
		method: 'post',
		dataType: 'json',
		success: function(data){
			if(typeof callback == 'function') callback(obj, data);
		},
		error: function(){
			alertError();
			obj.replaceWith('<i class="fa fa-unlink"></i>');
		},
		complete: function(){ _ajaxBussy_ = false; }
	});
}

//Eliminación de registro
var newLocation = '';
function eliminar(o, callback)
{
	$(o).unbind('click').click(function(e){
		e.preventDefault();
		if(!_ajaxBussy_ && confirm('Confirme la eliminación de este registro'))
		{
			_ajaxBussy_ = true;
			
			var t = $(this);
			var data = t.data();
			var clase = t.attr('class');
			var newLocation = '';
			if(typeof data.location != 'undefined') newLocation = data.location;
			obj = spinner(t);
			
			$.ajax({
				url: _sitePath_ + 'acciones/eliminar' + _suffix_,
				data: { tabla: data.tabla, id: data.id },
				method: 'post',
				dataType: 'json',
				success: function(data){
					if(data.result > 0)
					{
						if(newLocation.length == 0)
						{
							//Refrescar página si es necesario
							function eliminarCallback(){ if($('.' + clase.replace(/ /g, '.') + ':visible').size() == 0) window.location.reload(); }
							
							obj.parents('TR:first').fadeOut(eliminarCallback); //Identifica el TR padre del botón y lo desaparece
							obj.parents('.panel:first').fadeOut(eliminarCallback); //Identifica el .panel padre del botón y lo desaparece
							
							//Ejecutar callback si hay uno
							try{ callback(); } catch(e){}
						}
						else
						{
							alert('El registro ha sido eliminado.');
							window.location = newLocation;
						}
					}
					else
					{
						alertError();
						broken(obj);//.replaceWith('<i class="fa fa-unlink"></i>');
					}
				},
				error: function(){
					alertError();
					broken(obj);//.replaceWith('<i class="fa fa-unlink"></i>');
				},
				complete: function(){ _ajaxBussy_ = false; }
			});
		}
	});
}

//Set time field
function setTime(o)
{
	var v = $(o).val();
	try
	{
		var parts = v.split(':');
		if (!/^\d{2}:\d{2}:\d{2}$/.test(v) || (parts[0] > 23 || parts[1] > 59 || parts[2] > 59) || v.length == 0) $(o).val('00:00:00');
	} catch(e){}
}

//Campo de fecha
function setDatePicker()
{
	try
	{
		$('.date').datepicker({
			format: 'yyyy-mm-dd',
			language: 'es',
			autoclose: true
		});
	} catch(e){ c('No JS > datepicker'); }
}

//Campo de time
function setTimePicker()
{
	try
	{
		$('.time').blur(function(){
			setTime(this);
		}).each(function(){ setTime(this); }).timepicker({
			disableTextInput: true,
			timeFormat: 'H:i:s',
			selectOnBlur: true,
			show2400: true,
			step: 15
		});
	} catch(e){ c('No JS > timepicker'); }
}

//Alerta de error
var _errorMsg_ = 'Ha ocurrido un error. Intente de nuevo más tarde.';
function alertError(s)
{
	if(typeof s == 'undefined') s = _errorMsg_;
	alert(s);
}

//Block y deBlock
function block(){ $.blockUI({ message: 'Cargando...' }); }
function unBlock(){
	$.unblockUI();
	$('.blockUI').remove();
}

//Toogle de menú lateral
function sbToogle(){
	if(localStorage.sbHiden == '1')
		$('.navbar-default.sidebar, #page-wrapper').removeClass('sbHide');
	else
		$('.navbar-default.sidebar, #page-wrapper').addClass('sbHide');
}

$().ready(function(){
	//Toogle del sidebar
	if(typeof localStorage.sbHiden == 'undefined') localStorage.sbHiden = '0';
	sbToogle();
	$('#sideToogle a').click(function(e){
		e.preventDefault();
		if(localStorage.sbHiden == '1')
			localStorage.sbHiden = '0';
		else
			localStorage.sbHiden = '1';
		
		sbToogle();
	});
	
	//Inicializar campos especiales
	setDatePicker();
	setTimePicker();
	
	//iCheck
	$('.iCheckSquare').iCheck({
		checkboxClass: 'icheckbox_square-blue',
		radioClass: 'iradio_square-blue',
		increaseArea: '20%' // optional
	});
});