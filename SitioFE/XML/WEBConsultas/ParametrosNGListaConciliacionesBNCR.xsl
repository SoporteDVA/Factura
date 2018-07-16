<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Conciliaciones BNCR</title>
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
				<xsl:when test="ConsultaRegistrosBNCROutput">
					<xsl:for-each select="ConsultaRegistrosBNCROutput">
						<xsl:call-template name="DetallePagos"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="EstadosOutput">
					<xsl:for-each select="EstadosOutput/Resultado">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConsultaRegistrosBNCRFault">
					<xsl:for-each select="ConsultaRegistrosBNCRFault">
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
			<input type="hidden" name="Transaccion" value="ConsultaRegistrosBNCR"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="Filtro" value="XML/WEBConsultas/ParametrosNGListaConciliacionesBNCR.xsl"/>
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
						<font class="tituloAzulClaro">Consulta de Registros de Archivos Conciliacion BNCR</font>
						<font class="tituloAzulClaro"></font>
					</td>
				</tr>
			</table>
			<br/>
			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta">Fecha Pagos Inicial:
						<input name="FechaInicial" type="text" class="Calendario"/>
					</td>
					<td class="etiqueta">Fecha Pagos Final:
						<input name="FechaFinal" type="text" class="Calendario"/>
					</td>
				</tr>
			</table>
			<br/>
			<p>
				<div align="center">
					<input name="Reporte" class="button_red" type="button" value="Consultar" onclick="if (document.forms[0].FechaInicial.value == '') alert('Debe definir una Fecha Fecha Inicial'); else submit();"/>
				</div>
			</p>
		</form>
	</xsl:template>
	<xsl:template name="DetallePagos">
		<div align="center">
			<table align="center">
				<tr>
					<td width="30%">
						<p align="center">
							<img align="baseline" src="imagenes/DVAEnc.JPG"/>
						</p>
					</td>
					<td>
						<fONT class="tituloAzulClaro">Lista de Registros de Archivos Procesados</fONT>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<div width="100%" align="right">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="Estados"/>
				<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGListaConciliacionesBNCR.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button" type="submit" value="  «« Realizar Otra Consulta   "/>
			</form>
		</div>


		<table class="tabla" align="right" width="100%">
			<thead>

				<tr class="etiqueta">
					<th align="center">Registro</th>
					<th align="center">Tipo Registro</th>
					<th>Recaudador</th>
					<th>Cuenta Bancaria</th>
					<th>Nota Credito BNCR</th>
					<th>Monto</th>
					<th>Moneda</th>
					<th>F.Pago</th>
					<th>Fecha y Hora Proceso</th>
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select="Resultados/Fila">

					<tr colspan="2">
						<!--Escoge el formato de la fila, si es reversión, se pone en rojo   -->
						<xsl:choose>
							<xsl:when test="TipoRegistroBNCR='02'">
								<xsl:attribute name="class">detalle</xsl:attribute>
							</xsl:when>
							<xsl:when test="TipoRegistroBNCR='03'">
								<xsl:attribute name="class">tablaSinImprimir</xsl:attribute>
							</xsl:when>
							<xsl:when test="Estado='PP' or Estado='DP'">
								<xsl:attribute name="class">tablaPendiente</xsl:attribute>
							</xsl:when>
							<xsl:when test="Reversion='1'">
								<xsl:attribute name="class">tablaResaltado</xsl:attribute>
							</xsl:when>
							<xsl:when test="Reversion!='1' and Estado='PG' and (NumeroRecibo='0' or NumeroRecibo='Sin Imprimir')">
								<xsl:attribute name="class">tablaSinImprimir</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="class">detalle</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>

						<td align="left">

							<xsl:choose>
								<xsl:when test="TipoRegistroBNCR='02'">
									<a href="Transaccion.aspx?Transaccion=ConsultaArchivoBNCR&amp;CodigoRegistro={Registro}&amp;Fecha={FechaPagos}&amp;FechaCarga={FechaCarga}&amp;ServidorSTX=infoware.STX.Cajas&amp;Filtro=XML/WEBCierreNC/CargaArchivoBNCR.xsl" target="_blank"
									   onclick="window.open(this.href,this.target,toolbar=no,statusbar=no,menubar=no);return false;">
										<xsl:value-of select="Registro"/>
									</a>
									<!--<p align="Left">
										<a>
											<xsl:attribute name="href">Transaccion.aspx?Transaccion=ConsultaArchivoBNCR&amp;CodigoRegistro=<xsl:value-of select="Registro"/>&amp;Fecha=<xsl:value-of select="FechaPagos"/>&amp;FechaCarga=<xsl:value-of select="FechaCarga"/>&amp;ServidorSTX=infoware.STX.Cajas&amp;Filtro=XML/WEBCierreNC/CargaArchivoBNCR.xsl</xsl:attribute>
											<img hspace="1" src="imagenes/vwicn032.gif" align="center" border="0" alt="Consulta Detallada"/>
											<xsl:value-of select="Registro"/>
										</a>
									</p>-->
								</xsl:when>

								<xsl:otherwise>
								</xsl:otherwise>
							</xsl:choose>
						</td>

						<td align="Left">
							<xsl:value-of select="TipoRegistro"/>
						</td>
						<td align="center">
							<xsl:value-of select="RecaudadorProveedorBNCR"/>
						</td>
						<td align="center">
							<xsl:value-of select="CTACorrienteBNCR"/>
						</td>

						<td align="center">
							<xsl:value-of select="NotaBNCR"/>
						</td>
						<td align="justify">
							<xsl:value-of select="format-number(MontoNotaBNCR,'###,###,###,##0.00')"/>
						</td>
						<td align="center">
							<xsl:choose>
								<xsl:when test="MonedaBNCR='01'">Colones</xsl:when>
								<xsl:when test="MonedaBNCR='02'">Dolares</xsl:when>
								<xsl:when test="MonedaBNCR='03'">Euros</xsl:when>
								<xsl:otherwise>Colones</xsl:otherwise>
							</xsl:choose>
						</td>
						<td align="justify">
							<xsl:value-of select="FechaPagos"/>
						</td>
						<td align="justify">
							<xsl:value-of select="FechaCarga"/>
						</td>
					</tr>
				</xsl:for-each>
				<!--</xsl:for-each>-->
			</tbody>
		</table>
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
					<td colSpan="3" class="detalle">
						<xsl:value-of select="Respuesta"/>
					</td>
				</tr>
			</table>
			<br/>
			<br/>
		</div>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="Estados"/>
				<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGListaConciliacionesBNCR.xsl"/>
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