<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:result="http://127.0.0.1/results" extension-element-prefixes="result">
	<xsl:output method="html" indent="yes" encoding="utf-8"/>
	<xsl:template match="/">
		<html>
			<head>
				<meta http-equiv="Pragma" content="no-cache"/>
				<link rel="stylesheet" type="text/css" href="STestilos.css"/>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"></script>
				<script src="codigo/dist_geo.js" language="javascript" type="text/javascript"></script>
				<script type="text/javascript" src="datepicker/prototype.js"></script>
				<script type="text/javascript" src="datepicker/scriptaculous.js"></script>
				<script type="text/javascript" src="datepicker/datepicker.js"></script>
				<script language="javascript">function revisarRangoFechas() {
						var FechaDesde=document.forms[0].FechaDesde;
						var FechaHasta=document.forms[0].FechaHasta;					
						if (FechaDesde.value == '') {
							alert('Favor Indicar Fecha Desde!');
						} else if (FechaHasta.value == '') {
							alert('Favor Indicar Fecha Hasta!');
						} else if (FechaDesde.value > FechaHasta.value) {
							alert('Revise por favor las fechas desde/hasta!');
						} 
						if (FechaIngreso.value == '') {
							alert('Favor Indicar Fecha de Ingreso del Vehículo!');
							} 
						document.forms[0].submit();
				
					}</script>
				<style type="text/css">div.datepicker {
 position: absolute;
 text-align: center;
 border: 1px #C4D5E3 solid;
 font-family: arial;
}
div.datepicker-header {
 font-size: 12px;
 font-weight: bold;
 background: #e9eff4;
 border-bottom:1px solid #c4d5e3;
 padding: 2px;
}
div.datepicker-footer {
 font-size: 10px;
 background: #e9eff4;
 border-top:1px solid #c4d5e3;
 cursor: pointer;
 text-align: center;
 padding: 2px;
}
div.datepicker-calendar {
 font-size: 10px;
 background:#FFFFFF;
 padding: 2px;
 text-align: center;
}
div.datepicker-calendar table {
 font-size: 10px;
 border: 1px white solid;
 margin: 0px;
 padding: 0px;
 text-align: center;
}
div.datepicker-calendar table tr {
 border: 1px white solid;
 margin: 0px;
 padding: 0px;
}
div.datepicker-calendar table td {
 border: 1px #eaeaea solid;
 margin: 0px;
 padding: 0px;
 text-align: center;
}
div.datepicker-calendar table td:hover, 
div.datepicker-calendar table td.outbound:hover,
div.datepicker-calendar table td.today:hover {
 border: 1px #c4d5e3 solid;
 background: #e9eff4;
 cursor: pointer;
}
div.datepicker-calendar table td.wday {
 border: 1px #ffffff solid;
 background: #ffffff;
 cursor: text;
}
div.datepicker-calendar table td.outbound {
 background: #e8e4e4;
}
div.datepicker-calendar table td.today {
 border: 1px #16518e solid;
 background: #c4d5e3;
}</style>
				<script language="javascript" type="text/javascript">function VerificarData(){
				    var estado=1;
					var f=document.forms[0];
					if (f.NumeroChasis.value=="") { 
						alert('Por favor digíte el Numero de Chasis.');
						return false;}
					if (f.NumeroMotor.value=="") { 
						alert('Por favor digíte el Numero de Motor.');
						return false;}
					if (f.NumeroPlaca.value=="") { 
						alert('Por favor digíte el Numero de Placa.');
						return false;}
					if (f.CedulaPropietario.value=='') { 
						alert('Por favor digíte la Identificación del propietario.');
						return false;}
					if (f.NomPropietario.value=="") { 
						alert('Por favor digíte el Nombre del propietario.');
						return false;}			
					if (f.Provincia.value &lt; 1){ 
						alert('Por favor seleccione la Provincia');
						return false;}
					if (f.TelPropietario.value=="") { 
						alert('Por favor registre un Teléfono');
						return false;}					
					return true;
				}
				function OcultarElemento(valor){				  
				var IdOficina='OfiField';
				var IdElemento='DirField';			
				if((document.getElementById)&amp;&amp; (document.getElementById(IdElemento)!=null)) {
	  		        // Se obtienen una referencia del objeto
					var FOficina = document.getElementById(IdOficina);					
					var FDireccion = document.getElementById(IdElemento);
					var FEtiqueta = document.getElementById('FEtiqueta');
					// Se verifica que la propiedad de visibilida esta accesible
		 			if ((FOficina.style)&amp;&amp;(FOficina.style.visibility!=null)) {
						FOficina.style.visibility='hidden';
						FDireccion.style.visibility='hidden';		
						alert(FEtiqueta.value);
						alert(FEtiqueta.text);				
						if (valor==1) {
							FOficina.style.visibility='visible';
							FEtiqueta.value='Oficina:';
							}
						else{
							FDireccion.style.visibility='visible';
							FEtiqueta.value='Dirección:';
							}
					}    			
  			   }else {	
				// This CSS property is not assigned or is not supported
				return;
  			   }
			}
					 function getCanton (Provincia,Canton) {	
					 if (Provincia==-1)
						return 'Provincia no Seleccionada.';
					 if (Canton==-1)
					   return 'Canton no Seleccionado';
					 if (canton==null)
						return 'Canton no Seleccionado';
					 if (canton[Provincia-1]==null)
						return 'Provincia no Seleccionada.';
					 if  (canton[Provincia-1][Canton-1]==null)
						return 'Canton NO SELECCIONADO';						
					return (canton[Provincia-1][Canton-1][0]);
				}
				function getDistrito (Provincia,Canton,Distrito) {				    
          			if (Provincia==-1)
						return 'Provincia no Seleccionada.';
					if (Canton==-1)
					   return 'Canton no Seleccionado';
					if (Distrito ==-1)
					    return 'Distrito no Seleccionado';
					if (distrito[Provincia-1]==null)
						return 'Provincia no Seleccionada.';
					if  (distrito[Provincia-1][Canton-1]==null)
						return 'Canton NO SELECCIONADO';
					if  (distrito[Provincia-1][Canton-1][Distrito-1]==null)
						return 'Distrito NO SELECCIONADO';					
					return (distrito[Provincia-1][Canton-1][Distrito-1][0]);
                }</script>
			</head>
			<body>
				<table align="center" border="0">
					<tr>
						<td width="50%">
							<p align="center">
								<img align="baseline" src="imagenes/ins.gif" border="0" hspace="0" height="60"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Registro de Pólizas General</font>
						</td>
					</tr>
				</table>
				<br/>
				<form action="Transaccion.aspx" method="post" onsubmit="return VerificarData();">
					<input type="hidden" name="Transaccion" value="RegistrarPolizaGeneralINS"/>
					<input type="hidden" name="Filtro" value="XML/General/GeneralPagar.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
					<input type="hidden" name="Registrar" value="1"/>
					<!-- Revisar estos valores -->
					<!-- -->
					<div align="center" class="tituloAzulClaro">Información de la Nueva Póliza</div>
					<br/>
					<table align="center" class="tabla">
						<tr>
							<td class="etiqueta">Fecha Ingreso :</td>
							<td colSpan="3">
								<input id="date-In" name="FechaIngreso"/>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Modelo:</td>
							<td class="detalle">
								<SELECT name="AnoModelo" class="campo">
									<script>for (var intLoop=1900; intLoop &lt; 2013; intLoop++)
								 	          document.writeln('&lt;option'+(<xsl:value-of select="2012"/> == intLoop ?
                                 ' selected="selected"' : "")+'&gt;'+intLoop+'&lt;/option&gt;');</script>
								</SELECT>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Numero Chasis :</td>
							<td class="detalle">
								<input name="NumeroChasis" value="{NumeroChasis}" size="30" maxlength="30"/>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Numero Motor :</td>
							<td class="detalle">
								<input name="NumeroMotor" value="{NumeroMotor}" size="30" maxlength="30"/>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Numero Placa :</td>
							<td class="detalle">
								<input name="NumeroPlaca" value="{NumeroPlaca}" size="30" maxlength="30"/>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Fecha Inicio Vigencia :</td>
							<td colSpan="3">
								<input id="date-from" name="FechaDesde"/>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Fecha Final Vigencia :</td>
							<td colSpan="3">
								<input id="date-to" name="FechaHasta"/>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">País :</td>
							<td colSpan="3" class="detalle">
								<select class="campo" name="Pais">
									<xsl:for-each select="CargaCaracteristicasPolizasOutput/Paises/Fila">
										<option value="{Codigo}" selected="selected">
											<xsl:value-of select="Descripcion"/>
										</option>
									</xsl:for-each>
								</select>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">
								<select class="campo" name="TipoCedulaPropietario">
									<xsl:for-each select="CargaCaracteristicasPolizasOutput/TiposIdentificacion/Fila">
										<xsl:if test="Codigo=0">
											<option value="{Codigo}" selected="selected">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
										<xsl:if test="Codigo &gt;0">
											<option value="{Codigo}">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
									</xsl:for-each>
								</select>
							</td>
							<td class="detalle">
								<input name="CedulaPropietario" value="{CedulaPropietario}" size="15" maxlength="15" onkeypress="solonumeros(event)"/>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Nombre de Propietario :</td>
							<td class="detalle">
								<input name="NomPropietario" value="{NomPropietario}" size="40" maxlength="100"/>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Provincia:</td>
							<td class="detalle">
								<SELECT class="inputAzul" NAME="Provincia"
								        onChange="fillSelectFromArray(this.form.Canton, ((this.selectedIndex == -1) ? null : canton[this.selectedIndex-1])); fillSelectFromArray(this.form.Distrito, ((Canton.selectedIndex == -1) ? null : distrito[this.selectedIndex-1][0]));">
									<OPTION VALUE="-1">--- Selecione ---</OPTION>
									<OPTION VALUE="1">SAN JOSE</OPTION>
									<OPTION VALUE="2">ALAJUELA</OPTION>
									<OPTION VALUE="3">CARTAGO</OPTION>
									<OPTION VALUE="4">HEREDIA</OPTION>
									<OPTION VALUE="5">GUANACASTE</OPTION>
									<OPTION VALUE="6">PUNTARENAS</OPTION>
									<OPTION VALUE="7">LIMON</OPTION>
								</SELECT>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Cantón:</td>
							<td class="detalle">
								<SELECT NAME="Canton" onChange="fillSelectFromArray(this.form.Distrito, ((this.selectedIndex == -1) ? null : distrito[Provincia.selectedIndex-1][this.selectedIndex]));">
									<OPTION>&#xA0; &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; 
          &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;</OPTION>
								</SELECT>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Distrito:</td>
							<td class="detalle">
								<SELECT NAME="Distrito">
									<OPTION>&#xA0; &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; 
          &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;</OPTION>
								</SELECT>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Teléfono :</td>
							<td class="detalle">
								<input name="TelPropietario" value="{TelPropietario}" size="8" maxlength="8"/>
							</td>
						</tr>
					</table>
					<br/>
					<div align="center">
						<input name="BotonSalvar" type="submit" value="      Registrar      "/>
						<input name="BtnCerrar" type="button" value="      Limpiar      "
						       onclick="cargar(this,'Transaccion.aspx?Transaccion=CargaCaracteristicasPolizas&amp;servidorSTX=infoware.STX.Gestion&amp;Filtro=~/XML/General/RegistrarGeneral.xsl','Transaccion')"/>
					</div>
				</form>
				<script type="text/javascript">var dpck	= new DatePicker({
          relative	: 'date-from',
          language	: 'sp'
          });</script>
				<script type="text/javascript">var dpck	= new DatePicker({
          relative	: 'date-to',
          language	: 'sp'
          });</script>
				<script type="text/javascript">var dpck	= new DatePicker({
          relative	: 'date-In',
          language	: 'sp'
          });</script>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="Provincias">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo=1">SAN JOSE</xsl:when>
			<xsl:when test="$Codigo=2">ALAJUELA</xsl:when>
			<xsl:when test="$Codigo=3">CARTAGO</xsl:when>
			<xsl:when test="$Codigo=4">HEREDIA</xsl:when>
			<xsl:when test="$Codigo=5">GUANACASTE</xsl:when>
			<xsl:when test="$Codigo=6">PUNTARENAS</xsl:when>
			<xsl:when test="$Codigo=7">LIMON</xsl:when>
			<xsl:otherwise>NO ASIGNADA</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="TipoEnvio">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo=1">A Oficina</xsl:when>
			<xsl:when test="$Codigo=2">A Domicilio</xsl:when>
			<xsl:otherwise>No asignado</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="MostrarMensaje">
		<xsl:param name="Mensaje" select="."/>
		<div align="center">
			<br/>
			<font class="tituloAzulClaro">
				<xsl:value-of select="$Mensaje"/>
			</font>
			<br/>
			<br/>
			<input name="BtnCerrar" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=FlotillaConsultar&amp;ServidorSTX=infoware.STX.Flotilla&amp;Filtro=~/XML/Flotillas/ConsultaFlotillas.xsl','Transaccion')"/>
		</div>
	</xsl:template>
	<xsl:template name="Descripcion" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		<xsl:param name="Identificacion" select="."/>
		<xsl:choose>
			<xsl:when test="$Identificacion = 0">Cedula Fisica nacional</xsl:when>
			<xsl:when test="$Identificacion = 1">Cedula de Residencia</xsl:when>
			<xsl:when test="$Identificacion = 4">Cedula Institucion Autonoma</xsl:when>
			<xsl:when test="$Identificacion = 5">Indocumentados</xsl:when>
			<xsl:when test="$Identificacion = 6">Documento Unico</xsl:when>
			<xsl:when test="$Identificacion = 8">Permiso de Trabajo</xsl:when>
			<xsl:when test="$Identificacion = 9">Pasaporte</xsl:when>
			<xsl:when test="$Identificacion = 15">Cedula Refugiados</xsl:when>
			<xsl:when test="$Identificacion = 16">Cedula Asociada a Tramites</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
