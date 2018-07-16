//
//******************************************************************************
// FUNCIONES PARA EL MANEJO DE VISTAS CON PAGINACION
//******************************************************************************
//
//
// Variables globales para el manejo de la paginaci�n
//==============================================================================
var SORT_COLUMN_INDEX;
var Pagina=0;
var Paginas=0,LineasPagina=0;
var Encabezado=1;
var Pie=0;
var Matris,Tabla,Nav,Nav2;
//
// Muestra la p�gina de la tabla cuyo indice recibe como parametro
//==============================================================================
function irA(pag) {
	if(!(pag<0 || pag>Paginas-1)) Pagina=pag;
	var inicio=LineasPagina*Pagina;
	var fin=LineasPagina*(Pagina+1)
	var fila,fila2,datos,celda,txt;
	var estilo='cell2';
	var f=Encabezado;
	if(fin>Matris.length)
		fin=Matris.length;
	for(var i=inicio;i<fin;i++) {
		fila=Tabla.tBodies[0].insertRow(f++);
		datos=Matris[i];
		for(var j=0;j<datos.length;j++) {
			celda=fila.insertCell(j);
			celda.innerHTML='<h4>'+datos[j]+'</h4>';
			if(datos[j].match(/^[\d\$�.,-]+$/))
				celda.className=estilo+'n';
			else
				celda.className=estilo;
		}
		if(estilo=='cell3')
			estilo='cell2';
		else
			estilo='cell3';
	}	
	for(f=f;f<Tabla.rows.length-Pie;)
		Tabla.tBodies[0].deleteRow(f);
	if(Paginas<2) {
		if(Nav.rows.length>0) Nav.tBodies[0].deleteRow(0);
		if(Nav2.rows.length>0) Nav2.tBodies[0].deleteRow(0);
	} else {
		fila=Nav.rows[0];
		if(Nav2) fila2=Nav2.rows[0];
		for(f=0;f<Paginas;++f) {
			if(f==Pagina)
				fila.cells[f].innerHTML='<b>'+(f+1)+'</b>';
			else
				fila.cells[f].innerHTML="<a href='JavaScript:irA("+f+")' target='_self' class='linkazulpeq'>"+(f+1)+"</a>"
			fila2.cells[f].innerHTML=fila.cells[f].innerHTML;
		}
	}
}

//
// Inicializacion de las variables para manejar la paginaci�n
//==============================================================================
function IniciarPaginacion() {
	alert(Matris);
	if(Matris==null) return;
	Paginas=Math.round((Matris.length/LineasPagina)+0.499);
	alert(Paginas);
    // Find all tables with class paginacion and make them paginacion
    if (!document.getElementsByTagName) return;
    tbls = document.getElementsByTagName("table");
    for (ti=0;ti<tbls.length;ti++) {
        thisTbl = tbls[ti];
        if (((' '+thisTbl.className+' ').indexOf("paginacion") != -1) && (thisTbl.id)) {
            //initTable(thisTbl.id);
            Tabla=thisTbl;   
            ts_makeSortable(thisTbl);
        } else if (((' '+thisTbl.className+' ').indexOf("navegacion") != -1)) {
        	if(Nav) 
			Nav2=Nav;
		Nav=thisTbl;
		var fila=Nav.rows[0];
		for(var i=0;i<Paginas;++i)
			fila.insertCell(i).innerHTML=i+1;
        }
    }
    if(Tabla) irA(0);
}

function ts_makeSortable(table) {
    if (table.rows && table.rows.length > 0) {
        var firstRow = table.rows[Encabezado-1];
    }
    if (!firstRow) return;
    
    // We have a first row: assume it's the header, and make its contents clickable links
    for (var i=0;i<firstRow.cells.length;i++) {
        var cell = firstRow.cells[i];
        var txt = ts_getInnerText(cell);
        cell.innerHTML = '<a href="#" class="encabezado" onclick="ts_resortTable(this);return false;">'+txt+'<span class="sortarrow">&nbsp;&nbsp;&nbsp;</span></a>';
    }
}

function ts_getInnerText(el) {
	if (typeof el == "string") return el;
	if (typeof el == "undefined") { return el };
	if (el.innerText) return el.innerText;	//Not needed but it is faster
	var str = "";
	
	var cs = el.childNodes;
	var l = cs.length;
	for (var i = 0; i < l; i++) {
		switch (cs[i].nodeType) {
			case 1: //ELEMENT_NODE
				str += ts_getInnerText(cs[i]);
				break;
			case 3:	//TEXT_NODE
				str += cs[i].nodeValue;
				break;
		}
	}
	return str;
}

function ts_resortTable(lnk) {
    // get the span
    var span;
    for (var ci=Encabezado-1;ci<lnk.childNodes.length;ci++) {
        if (lnk.childNodes[ci].tagName && lnk.childNodes[ci].tagName.toLowerCase() == 'span') span = lnk.childNodes[ci];
    }
    var spantext = ts_getInnerText(span);
    var td = lnk.parentNode;
    var column = td.cellIndex;
    var table = getParent(td,'TABLE');
    
    // Work out a type for the column
    if (table.rows.length <= Encabezado) return;
    var itm = ts_getInnerText(table.rows[Encabezado].cells[column]);
    sortfn = ts_sort_caseinsensitive;
    if (itm.match(/\d{1,2}[\/-]\d\d[\/-]\d\d\d\d$/)) sortfn = ts_sort_date;
    if (itm.match(/\d{1,2}[\/-]\d\d[\/-]\d\d$/)) sortfn = ts_sort_date;
    if (itm.match(/^[�$�]/)) sortfn = ts_sort_currency;
    if (itm.match(/^[\d.,]+$/)) sortfn = ts_sort_numeric;
    SORT_COLUMN_INDEX = column;
    var firstRow = new Array();
    var newRows = new Array();
    for (i=0;i<table.rows[0].length;i++) { firstRow[i] = table.rows[0][i]; }
    for (j=1;j<table.rows.length;j++) { newRows[j-1] = table.rows[j]; }

    Matris.sort(sortfn);

    if (span.getAttribute("sortdir") == 'down') {
        ARROW = '&nbsp;&nbsp;&uarr;';
        Matris.reverse();
        span.setAttribute('sortdir','up');
    } else {
        ARROW = '&nbsp;&nbsp;&darr;';
        span.setAttribute('sortdir','down');
    }
    // Delete any other arrows there may be showing
    var allspans = document.getElementsByTagName("span");
    for (var ci=0;ci<allspans.length;ci++) {
        if (allspans[ci].className == 'sortarrow') {
            if (getParent(allspans[ci],"table") == getParent(lnk,"table")) { // in the same table as us?
                allspans[ci].innerHTML = '&nbsp;&nbsp;&nbsp;';
            }
        }
    }       
    span.innerHTML = ARROW;
    irA(0);
}

function getParent(el, pTagName) {
	if (el == null) return null;
	else if (el.nodeType == 1 && el.tagName.toLowerCase() == pTagName.toLowerCase())	// Gecko bug, supposed to be uppercase
		return el;
	else
		return getParent(el.parentNode, pTagName);
}
function ts_sort_date(a,b) {
    // y2k notes: two digit years less than 50 are treated as 20XX, greater than 50 are treated as 19XX
    aa = a[SORT_COLUMN_INDEX];
    bb = b[SORT_COLUMN_INDEX];
    if (aa.length == 10) {
        dt1 = aa.substr(6,4)+aa.substr(3,2)+aa.substr(0,2);
    } else {
        yr = aa.substr(6,2);
        if (parseInt(yr) < 50) { yr = '20'+yr; } else { yr = '19'+yr; }
        dt1 = yr+aa.substr(3,2)+aa.substr(0,2);
    }
    if (bb.length == 10) {
        dt2 = bb.substr(6,4)+bb.substr(3,2)+bb.substr(0,2);
    } else {
        yr = bb.substr(6,2);
        if (parseInt(yr) < 50) { yr = '20'+yr; } else { yr = '19'+yr; }
        dt2 = yr+bb.substr(3,2)+bb.substr(0,2);
    }
    if (dt1==dt2) return 0;
    if (dt1<dt2) return -1;
    return 1;
}

function ts_sort_currency(a,b) { 
    aa = a[SORT_COLUMN_INDEX].replace(/[^0-9]/g,'');
    bb = b[SORT_COLUMN_INDEX].replace(/[^0-9]/g,'');
    return parseFloat(aa) - parseFloat(bb);
}

function ts_sort_numeric(a,b) { 
    aa = parseFloat(a[SORT_COLUMN_INDEX].replace(/[^0-9]/g,''));
    if (isNaN(aa)) aa = 0;
    bb = parseFloat(b[SORT_COLUMN_INDEX].replace(/[^0-9]/g,'')); 
    if (isNaN(bb)) bb = 0;
    return aa-bb;
}

function ts_sort_caseinsensitive(a,b) {
    aa = a[SORT_COLUMN_INDEX].toLowerCase();
    bb = b[SORT_COLUMN_INDEX].toLowerCase();
    if (aa==bb) return 0;
    if (aa<bb) return -1;
    return 1;
}

function ts_sort_default(a,b) {
    aa = a[SORT_COLUMN_INDEX];
    bb = b[SORT_COLUMN_INDEX];
    if (aa==bb) return 0;
    if (aa<bb) return -1;
    return 1;
}
// addEvent and removeEvent
// cross-browser event handling for IE5+,  NS6 and Mozilla
// By Scott Andrew
function addEvent(elm, evType, fn, useCapture)
{
  if (elm.addEventListener){
    elm.addEventListener(evType, fn, useCapture);
    return true;
  } else if (elm.attachEvent){
    var r = elm.attachEvent("on"+evType, fn);
    return r;
  } else {
    alert("Handler could not be removed");
  }
} 
// Obtiene el nombre de la base de datos actual en la forma "Protocolo://Servidor[:Puerto]/BaseDatos
function bd() {
	var protocolo = location.protocol
	var loc = location.pathname
	if(protocolo=="Notes:") {
		loc = loc.substr(1,loc.length-1)
		loc = "/" + loc.substr(0,loc.indexOf("/")+1)
	} else
		loc = loc.substr(0,loc.indexOf("nsf/")+4)
	if(location.port=="")
		return protocolo+"//"+location.hostname+loc
	else
		return protocolo+"//"+location.hostname+":"+location.port+loc
}
// Ejecuta la transacci�n actual cuando presionan Enter
function ejecutar(evt) {
	var caracter=(evt.wich)?evt.wich:evt.keyCode
	if(caracter==13) {
		var f=document.forms[0];
		if(f!=null) {
			if(f.Consultar!=null) {
				f.Consultar.click();
				status='Procesando...';
			} else if(f.Verificar!=null) {
				f.Verificar.click();
				status='Procesando...';
			} else if(f.Confirmar!=null) {
				f.Confirmar.click();
				status='Procesando...';
			} else if(f.Cancelar!=null) {
				f.Cancelar.click();
				status='Procesando...';
			}
		}
	}
	return false;
}
//******************************************************************************
//  FUNCIONES DE VALIDACIONES
//******************************************************************************
//
//
// Verifica que en el campo actual s�lo se digiten n�meros
//==============================================================================
function soloNumeros(evt) {
	evt=(evt)?evt:window.event
	var caracter=(evt.wich)?evt.wich:evt.keyCode
	if(caracter>31 && (caracter<48 || caracter>57)) {
		status="Este campo sólo acepta números."
		return false
	}
	status=""
	return true
}
function esCero(campo) {
	var f=document.forms[0];
	if(campo.value==null || campo.value=="" || parseInt(campo.value)==0) {
		mostrarError(campo,"El campo "+campo.name+" debe ser numérico diferente de cero.")
		return true
	} else
		return false
}
// Muestra un error en un campo y luego posiciona el cursor en el campo
function mostrarError(campo,mensaje) {
	alert(mensaje)
	campo.focus()
}
// Verifica que sobre el campo actual s�lo se digiten montos, incluyendo un punto decimal
function soloMontos(evt,campo) {
	evt=(evt)?evt:window.event
	var caracter=(evt.wich)?evt.wich:evt.keyCode
	if(caracter>31 && (caracter<48 || caracter>57) && caracter!=46) {
		status="Este campo sólo acepta números y el punto (.) decimal."
		return false
	}
	if(caracter==46 && campo.value.indexOf('.')>=0) {
		status="Puede incluir un sólo punto decimal(.)."
		return false
	}
	status=""
	return true
}
//
//******************************************************************************
// FUNCIONES PARA EL MANEJO DE BOTONES DE MENUES
//******************************************************************************
//
// Carga el URL en el frame e indica que el boton es el seleccionado (onclick)
//==============================================================================
function EjecutarTransaccion(url,frame)
{
        alert(url);
	open(url,frame);
	return true;
}
//******************************************************************************
//
// Realiza una confirmacion del deseo de ejecutar una transaccion 
// Carga el URL en el frame e indica que el boton es el seleccionado (onclick)
//==============================================================================

function Preguntar(Mensaje,objeto,enlace,marco){
				if(confirm(Mensaje)==true){ 
				  cargar(objeto,enlace,marco);
				  return true;
   				} 
				else 
				   return false;
				}
//
// Carga el URL en el frame e indica que el boton es el seleccionado (onclick)
//==============================================================================
function cargar(boton,url,frame)
{
	/*alert(frame.forms[0]);
	frame.innerHTML = '<html><head><META http-equiv="Content-Type" content="text/html; charset=utf-8">'
		+ '<title>RACSA</title><link rel="stylesheet" type="text/css" href="STEstilos.css">'
		+ '</head><body><br><table class="tabla" align="center"><tr><td><img src="imagenes/animWait.gif">'
		+ '</td><td>Cuenta  no  existe</td></tr></table></body></html>';
	alert(frame.innerHTML);		*/
	open(url,frame);
	var f=document.forms[0];
	for(var i=0;i<f.elements.length;++i) {
		b=f.elements[i];
		if(b.color!=null && b.fondo!=null) {
			b.style.backgroundColor=b.fondo;
			b.style.color=b.color;
			b.seleccionado=false;
		}
	}
	boton.fondo=boton.fondo1;
	boton.color=boton.style.color;
	boton.seleccionado=true;
	boton.style.backgroundColor='#025B9D';
	boton.style.color='#ffffff';
	return true;
}
//
// Devuelve el color de fondo original del boton (onmouseout)
//==============================================================================
function normal(boton) {
	if(boton.seleccionado==null || !boton.seleccionado)
		if(boton.fondo1!=null) 
			boton.style.backgroundColor=boton.fondo1
	return true
}
//
// Resalta el boton cambiandole el color de fondo (onmouseover)
//==============================================================================
function resaltar(boton) {
	if(boton.seleccionado==null || !boton.seleccionado) {
		boton.fondo1=boton.style.backgroundColor
		boton.style.backgroundColor='#CCDEEB'
	}
	return true
}
//
//******************************************************************************
// FUNCIONES PARA EL MANEJO DE LAS TRANSACCIONES
//******************************************************************************
//
// Envía la reversión
//==============================================================================
function reversar(nombre)
{
	if(confirm("¿Esta seguro que desea reversar esta transacción?")==true) {
		var f=document.forms[0];
		f.Reversion.value="1";
		f.Transaccion.value=nombre;
		f.submit();
		return true;
	} else
		return false;
}
//
// Permite ejecutar una transaccion desde otra.
//==============================================================================
function ejecutarComo(nombre)
{	
	var f=document.forms[0];	
	f.Transaccion.value=nombre;
	f.submit();
	return true;
}
//
//==============================================================================
function ejecutarComoA(nombre,pantalla)
{	
	var f=document.forms[0];
	f.Transaccion.value=nombre;
	f.Filtro.value=pantalla;
	f.submit();
	return true;
}
//
// Oculta los campos en la transaccion segun la forma de pago
//==============================================================================
function ocultarFormaPago() 
{
	elemento=document.forms[0].CodigoBanco;
	if(document.forms[0].FormaPago.value == 1) {								
		elemento.style.display=elemento.style.display == "none" ? "block" : "none";
		document.forms[0].CodigoBanco.value = "";		
		document.forms[0].CuentaCheque.readOnly = true;
		document.forms[0].CuentaCheque.value = "";
		document.forms[0].NumeroCheque.readOnly = true;
		document.forms[0].NumeroCheque.value = "";
		document.forms[0].CedulaCliente.readOnly = false;
		document.forms[0].FormularioPsicotropicos.readOnly = false;																			
		document.forms[0].OtrosValores.value = 0;
		document.forms[0].Efectivo.value = document.forms[0].TotalPago.value;								
	}
	else {
		elemento.style.display=elemento.style.display == "none" ? "block" : "none";
		
		document.forms[0].CuentaCheque.readOnly = false;
		document.forms[0].NumeroCheque.readOnly = false;
		document.forms[0].CedulaCliente.readOnly = true;						
		document.forms[0].CedulaCliente.value = "";
		document.forms[0].FormularioPsicotropicos.readOnly = true;	
		document.forms[0].FormularioPsicotropicos.value = "";	
		document.forms[0].OtrosValores.value = document.forms[0].TotalPago.value;
		document.forms[0].Efectivo.value = 0;
	}
	return true;
}




//
// Oculta los campos en la transaccion de pago CCSS segun la forma de pago
//==============================================================================
function ocultarFormaPagoCCSS() 
{
	if(document.forms[0].FormaPago.value == 1) {								
		document.forms[0].CodigoBanco.readOnly = true;
		document.forms[0].CodigoBanco.value = "";		
		document.forms[0].CuentaCheque.readOnly = true;
		document.forms[0].CuentaCheque.value = "";
		document.forms[0].NumeroCheque.readOnly = true;
		document.forms[0].NumeroCheque.value = "";
		document.forms[0].CedulaCliente.readOnly = false;
		document.forms[0].FormularioPsicotropicos.readOnly = false;																			
		document.forms[0].OtrosValoresIVM.value = 0;
		document.forms[0].OtrosValoresSEM.value = 0;
		document.forms[0].EfectivoIVM.value = document.forms[0].TotalIVM.value;								
		document.forms[0].EfectivoSEM.value = document.forms[0].TotalSEM.value;								
	}
	else {
		document.forms[0].CodigoBanco.readOnly = false;
		document.forms[0].CuentaCheque.readOnly = false;
		document.forms[0].NumeroCheque.readOnly = false;
		document.forms[0].CedulaCliente.readOnly = true;						
		document.forms[0].CedulaCliente.value = "";
		document.forms[0].FormularioPsicotropicos.readOnly = true;	
		document.forms[0].FormularioPsicotropicos.value = "";	
		document.forms[0].OtrosValoresIVM.value = document.forms[0].TotalIVM.value;
		document.forms[0].OtrosValoresSEM.value = document.forms[0].TotalSEM.value;
		document.forms[0].EfectivoIVM.value = 0;								
		document.forms[0].EfectivoSEM.value = 0;								
	}
	return true;
}
//
// Oculta los campos en la transaccion segun la forma de pago
//==============================================================================
function eliminarPuntoDecimal(campo)
{
	var v=campo.value*100;
	campo.value=Math.round(v,0);
	return true;
}

function ddMMYYYY_to_YYYYMMdd(date) {
    var values = date.split("/");
    return values[2] + '/' + values[1] + '/' + values[0];
}

function mmDDYYYY_to_YYYYMMdd(date) {
    var values = date.split("/");
    return values[2] + '/' + values[0] + '/' + values[1];
}


// Permite validar monto

//==============================================================================

function mayorque(montorecibo)

{          


         if(document.forms[0].TotalPago.value >= montorecibo ) {								
		Alert("si");								
	}
	else {
		Alert("no");								
	}
	return true;

           

}

 


// Permite ejecutar una transaccion desde otra.

//==============================================================================

function CambiarTransaccion(nombre,filtro)

{          

            var f=document.forms[0];        

            f.Transaccion.value=nombre;

            f.Filtro.value=filtro;

            f.submit();

            return true;

}

 

//
