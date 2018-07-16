<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Consulta de Fecha y Servicio para Cierre de NC</title>
				<link rel="stylesheet" href="jquery.ui.all.css" type="text/css"/>
				<link rel="stylesheet" href="jquery-ui.css" type="text/css"/>
				<link rel="stylesheet" href="STEstilos.css" type="text/css"/>
				<link rel="stylesheet" href="jquery.ui.datepicker" type="text/css"/>
				<link rel="stylesheet" type="text/css" href="filtergrid.css" media="screen"/>
				<script type="text/javascript" src="jquery-1.11.0.min.js"></script>
				<script type="text/javascript" src="excel.js"></script>
				<script src="jquery.min.js"></script>
				<script src="jquery-ui.min.js"></script>
				<script type="text/javascript" src="Buscar.js"></script>
				<style>body{
                              font: 62.5% "Trebuchet MS", sans-serif;
                              margin: 50px;
                              }
                              .demoHeaders {
                              margin-top: 2em;
                              }
                              #dialog-link {
                              padding: .4em 1em .4em 20px;
                              text-decoration: none;
                              position: relative;
                              }
                              #dialog-link span.ui-icon {
                              margin: 0 5px 0 0;
                              position: absolute;
                              left: .2em;
                              top: 50%;
                              margin-top: -8px;
                              }
                              #icons {
                              margin: 0;
                              padding: 0;
                              }
                              #icons li {
                              margin: 2px;
                              position: relative;
                              padding: 4px 0;
                              cursor: pointer;
                              float: left;
                              list-style: none;
                              }
                              #icons span.ui-icon {
                              float: left;
                              margin: 0 4px;
                              }
                              .fakewindowcontain .ui-widget-overlay {
                              position: absolute;
                              }
                              select {
                              width: 200px;
                              }</style>
				<script>$(function() {
                              var currentDate = new Date();
                              $( ".Calendario" ).datepicker({
                              closeText: 'Cerrar',
                              prevText: 'Ant',
                              nextText: 'Sig',
                              currentText: 'Hoy',
                              monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                              monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
                              dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
                              dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
                              dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
                              weekHeader: 'Sm',
                              dateFormat: 'dd/mm/yy',
                              firstDay: 1,
                              defaultDate: new Date(),
                              isRTL: false,
                              showMonthAfterYear: false,
                              yearSuffix: ''
                              });
                              $(".Calendario").datepicker("setDate", currentDate);
                              });</script>
			</head>
			<xsl:choose>
				<xsl:when test="ConsultaNotasCreditoOutput">
					<xsl:for-each select="ConsultaNotasCreditoOutput">
						<xsl:call-template name="DetalleCierres"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="EstadosOutput">
					<xsl:for-each select="EstadosOutput/Resultado">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConsultaNotasCreditoFault">
					<xsl:for-each select="ConsultaNotasCreditoFault">
						<xsl:call-template name="RegeneraCierres"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="GeneraAperturasOutput">
					<xsl:for-each select="GeneraAperturasOutput">
						<xsl:call-template name="MensajeAperturas"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="CerrarNCHaciendaFault">
					<xsl:for-each select="CerrarNCHaciendaFault">
						<xsl:call-template name="Mensaje"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="CerrarNCHaciendaOutput">
					<xsl:for-each select="CerrarNCHaciendaOutput">
						<xsl:call-template name="Mensaje"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<center>
						<xsl:call-template name="Mensaje"/>
					</center>
				</xsl:otherwise>
			</xsl:choose>
			<body>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="Consulta">
		<form action="Transaccion.aspx" method="post">
			<input type="hidden" name="Transaccion" value="ConsultaNotasCredito"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="Filtro" value="XML/WEBCierreNC/ConsultaServicioFechaEstado.xsl"/>
			<div align="center">
				<table align="center">
					<tr>
						<td width="30%">
							<p align="center">
								<img align="baseline" src="imagenes/DVAEnc.JPG"/>
							</p>
						</td>
					</tr>
				</table>
			</div>
			<table align="center" width="500" border="0">
				<tr>
					<td width="50%" align="center">
						<font class="tituloAzulClaro">Consultas de Notas Credito Ministerio Hacienda</font>
						<font class="tituloAzulClaro"></font>
					</td>
				</tr>
			</table>
			<br/>
			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta">Fecha de Cierre Hacienda :
						<input name="Fecha" type="text" class="Calendario"/>
					</td>
					<!--<td class="etiqueta">Fecha Final:
						<input name="FechaFinal" type="text" class="Calendario"/>
					</td>-->
				</tr>
			</table>

			<br/>




			<br/>

			<p>
				<div align="center">
					<input name="Reporte" class="button_red" type="button" value="Consultar Cierres" onclick="if (document.forms[0].Fecha.value == '') alert('Debe definir una Fecha Fecha'); else submit();"/>
				</div>
			</p>
		</form>
	</xsl:template>
	<xsl:template name="DetalleCierres">
		<div align="center">
			<table align="center">
				<tr>
					<td width="30%">
						<p align="center">
							<img align="baseline" src="imagenes/DVAEnc.JPG"/>
						</p>
					</td>
				</tr>
			</table>
			<table align="center" width="500" border="0">
				<tr>
					<td width="50%" align="center">
						<font class="tituloAzulClaro">Notas de Credito Ministerio Hacienda</font>
						<font class="tituloAzulClaro"></font>
					</td>
				</tr>
			</table>
		</div>
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="Estados"/>
			<input type="hidden" name="Filtro" value="~/XML/WEBCierreNC/ConsultaServicioFechaEstado.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input name="BotonCerrar" class="button" type="submit" value="  «« Volver   "/>
		</form>


		<br/>

		<div width="100%" align="center">
		

			<table class="tabla">


				<thead>
					<tr class="encabezado">
						<th>Servicio</th>
						<th>Nota Credito</th>
						<th>Estado</th>
						<th>Fecha</th>
						<th>Monto</th>
						<th>Comision</th>
						<th>Cantidad Pagos</th>
						<th>Acción</th>
					</tr>
				</thead>
				<xsl:for-each select="Resultado/Fila">
					<tbody>
						<td class="tablaSinImprimir" align="left">
							<xsl:value-of select="id_servicio"/>--<xsl:value-of select="DesColector"/></td>
						<td class="tablaSinImprimir" align="right">
							<xsl:value-of select="NotaCredito"/>
						</td>
						<td class="tablaSinImprimir" align="center">
							<xsl:value-of select="Estado"/>
						</td>
						<td class="tablaSinImprimir" align="right">
							<xsl:value-of select="Fecha"/>
						</td>
						<td class="tablaSinImprimir" align="right">
							<xsl:value-of select="format-number(Monto,'###,###,###,##0.00')"/>
						</td>
						<td class="tablaSinImprimir" align="right">
							<xsl:value-of select="format-number(Comision,'###,###,###,##0.00')"/>
						</td>
						<td class="tablaSinImprimir" align="center">
							<xsl:value-of select="Cantidad"/>
						</td>
						<td class="Detalle" align="center">
							<xsl:choose>
								<xsl:when test="Estado='ABIERTA' and HOY &gt; 0">
									<a href="Transaccion.aspx?Transaccion=CerrarNCHacienda&amp;Colector={id_servicio}&amp;NotaCredito={NotaCredito}&amp;Estado={EstadoReal}&amp;Fecha={Fecha}&amp;ServidorSTX=infoware.STX.Cajas&amp;Filtro=XML/WEBCierreNC/ConsultaServicioFechaEstado.xsl">Generar Cierre</a>
								</xsl:when>
								<xsl:when test="Estado='CERRADA'">
									<a href="Transaccion.aspx?Transaccion=CerrarNCHacienda&amp;Colector={id_servicio}&amp;NotaCredito={NotaCredito}&amp;Estado={EstadoReal}&amp;Fecha={Fecha}&amp;ServidorSTX=infoware.STX.Cajas&amp;Filtro=XML/WEBCierreNC/ConsultaServicioFechaEstado.xsl">ReGenerar Cierre</a>
								</xsl:when>
								<xsl:otherwise>NO Aplica</xsl:otherwise>
							</xsl:choose>
						</td>
					</tbody>
				</xsl:for-each>
			</table>
			<br/>

			<table align="center" width="500" border="0">
				<tr>
					<td width="50%" align="center">
						<font class="tituloAzulClaro">Con el siguiente botón se podrán regenerar todos las aperturas del día de Hacienda, debe generar el cierre posteriormente para volver a crear los archivos</font>
						<font class="tituloAzulClaro"></font>
					</td>
				</tr>
			</table>
			<div align="center">
				<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="GeneraAperturas"/>
					<input type="hidden" name="Filtro" value="XML/WEBCierreNC/ConsultaServicioFechaEstado.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
					<input type="hidden" name="Fecha" value="{Resultado/Fila/Fecha}"/>
					<input name="BotonCerrar" class="button_red" type="submit" value="   Recrear Aperturas del día y Reclasificar los pagos "/>
				</form>
			</div>
		</div>
		<br/>
	</xsl:template>
	<xsl:template name="RegeneraCierres">
		<div align="center">
			<table align="center">
				<tr>
					<td width="30%">
						<p align="center">
							<img align="baseline" src="imagenes/DVAEnc.JPG"/>
						</p>
					</td>
				</tr>
			</table>
		</div>
		<table align="center" width="500" border="0">
			<tr>
				<td width="50%" align="center">
					<font class="tituloAzulClaro">Regeneración de Notas de Crédito</font>
					<font class="tituloAzulClaro"></font>
				</td>
			</tr>
		</table>


		<br/>

		<div align="center">

			<table class="tabla" align="center">

				<tr>
					<td class="etiqueta">Mensaje:</td>
					<td colSpan="3">
						<xsl:value-of select="Mensaje"/>
					</td>
				</tr>
			</table>
			<br/>
			<br/>
		</div>

		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="Estados"/>
				<input type="hidden" name="Filtro" value="XML/WEBCierreNC/ConsultaServicioFechaEstado.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="   Volver   "/>
			</form>
		</div>

		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="GeneraAperturas"/>
				<input type="hidden" name="Filtro" value="XML/WEBCierreNC/ConsultaServicioFechaEstado.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input type="hidden" name="Fecha" value="{Fecha}"/>
				<input name="BotonCerrar" class="button_red" type="submit" value="   Generar Aperturas   "/>
			</form>
		</div>
	</xsl:template>
	<xsl:template name="MensajeAperturas">
		<div align="center">
			<table align="center">
				<tr>
					<td width="30%">
						<p align="center">
							<img align="baseline" src="imagenes/DVAEnc.JPG"/>
						</p>
					</td>
				</tr>
			</table>
		</div>

		<table align="center" width="500" border="0">
			<tr>
				<td width="50%" align="center">
					<font class="tituloAzulClaro">Resultado de las Aperturas Hacienda y Reclasificación de Pagos</font>
					<font class="tituloAzulClaro"></font>
				</td>
			</tr>
		</table>
		<div width="100%" align="center">

			<table class="tabla">


				<thead>
					<tr class="encabezado">
						<th>Estado</th>
						<th>Respuesta</th>
						<th>Servicio</th>
						<th>Descripcion</th>
						<th>Estado Pagos</th>
						<th>Respuesta Pagos</th>
					</tr>
				</thead>
				<xsl:for-each select="Resultados">
					<tbody>

						<td class="tablaSinImprimir" align="center">
							<xsl:value-of select="ResultadoNota/Estado"/>
						</td>

						<td class="tablaSinImprimir" align="left">
							<xsl:value-of select="ResultadoNota/Respuesta"/>
						</td>

						<td class="tablaSinImprimir" align="center">
							<xsl:value-of select="ResultadoNota/Servicio"/>
						</td>

						<td class="tablaSinImprimir" align="left">
							<xsl:value-of select="ResultadoNota/Descripcion"/>
						</td>
						<td class="tablaSinImprimir" align="center">
							<xsl:value-of select="ResultadoPagos/Estado"/>
						</td>

						<td class="tablaSinImprimir" align="left">
							<xsl:value-of select="ResultadoPagos/Respuesta"/>
						</td>
					</tbody>
				</xsl:for-each>
			</table>
			<br/>
		</div>


		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="Estados"/>
				<input type="hidden" name="Filtro" value="XML/WEBCierreNC/ConsultaServicioFechaEstado.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="   Volver   "/>
			</form>
		</div>
	</xsl:template>

	<xsl:template name="Mensaje">
		<div align="center">
			<table align="center">
				<tr>
					<td width="30%">
						<p align="center">
							<img align="baseline" src="imagenes/DVAEnc.JPG"/>
						</p>
					</td>
				</tr>
			</table>
		</div>
		<div align="center">

			<table class="tabla" align="center">

				<tr>
					<td class="etiqueta">Mensaje:</td>
					<td colSpan="3">
						<xsl:value-of select="Mensaje"/>
					</td>
				</tr>
			</table>
			<br/>
			<br/>
		</div>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="Estados"/>
				<input type="hidden" name="Filtro" value="XML/WEBCierreNC/ConsultaServicioFechaEstado.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="   Volver   "/>
			</form>
		</div>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->