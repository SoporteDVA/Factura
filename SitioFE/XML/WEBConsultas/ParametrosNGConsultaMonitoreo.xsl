<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Bitacora de Cierres CCSS</title>
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
				<xsl:when test="Consulta_CierreMonitoreoOutput">
					<xsl:for-each select="Consulta_CierreMonitoreoOutput">
						<xsl:call-template name="DetallePagos"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="EstadosOutput">
					<xsl:for-each select="EstadosOutput/Resultado">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="Consulta_CierreMonitoreoFault">
					<xsl:for-each select="Consulta_CierreMonitoreoFault">
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
			<input type="hidden" name="Transaccion" value="Consulta_CierreMonitoreo"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="Filtro" value="XML/WEBConsultas/ParametrosNGConsultaMonitoreo.xsl"/>
			<input type="hidden" name="Colector" value="1"/>
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
						<font class="tituloAzulClaro">Monitoreo de Cierres Automaticos CCSS</font>
						<font class="tituloAzulClaro"></font>
					</td>
				</tr>
			</table>
			<br/>
			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta" align="center">Fecha:
						<input name="Fecha" type="text" class="Calendario"/>
					</td>
					<!--<td class="etiqueta">
						<input name="FechaFinal" type="text" class="Calendario"/>
					</td>-->
				</tr>
			</table>
			<br/>

			<br/>
			<p>
				<div align="center">
					<input name="Reporte" class="button_red" type="button" value="Consultar" onclick="if (document.forms[0].Fecha.value == '') alert('Debe definir una Fecha Fecha Inicial'); else submit();"/>
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
						<fONT class="tituloAzulClaro">Monitoreo Cierres Automaticos</fONT>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<div align="right">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="Estados"/>
				<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGConsultaMonitoreo.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button" type="submit" value="  «« Realizar Otra Consulta   "/>
			</form>
		</div>
		<br/>






		<table id="8" class="tabla" align="left" width="100%">
			<thead>
				<tr class="etiqueta">
					<th align="center">Convenio</th>
					<th>Fecha</th>
					<th>Estado</th>
					<th>Mensaje</th>
					<th>Monto</th>
					<th>Cantidad</th>
				</tr>
			</thead>

			<tbody>

				<xsl:for-each select="Resultados/Fila">
					<tr>
						<!--Escoge el formato de la fila, si es reversión, se pone en rojo   -->
						<xsl:choose>
							<xsl:when test="Estado='Cerrada'">
								<xsl:attribute name="class">detalle</xsl:attribute>
							</xsl:when>
							<xsl:when test="Estado='Abierta'">
								<xsl:attribute name="class">tablaConError</xsl:attribute>
							</xsl:when>
							<xsl:when test="Estado='No Existe'">
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
							<xsl:value-of select="Convenio"/>
						</td>
						<td align="justify">
							<xsl:value-of select="Fecha"/>
						</td>
						<td align="Left">
							<xsl:value-of select="Estado"/>
						</td>
						<td align="left">
							<xsl:value-of select="Mensaje"/>
						</td>
						<td align="right">
							<xsl:choose>
								<xsl:when test="Monto=''">0.00</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="format-number(Monto,'###,###,###,##0.00')"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>

						<td align="center">
							<xsl:choose>
								<xsl:when test="CantidadPagos=''">0</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="format-number(CantidadPagos,'#')"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</xsl:for-each>
				<tr>
					<td class="etiqueta"/>
					<td class="etiqueta"/>
					<td class="etiqueta"/>
					<td class="etiqueta" align="right">Total
						<strong><![CDATA[ ]]></strong>
					</td>
					<td class="etiqueta" align="right">
						<xsl:value-of select="format-number(sum(Resultados/Fila/Monto),'###,###,###,###,###,##0.00')"/>

					</td>

					<td class="etiqueta" align="center">

						<xsl:value-of select="sum(Resultados/Fila/CantidadPagos)"/>
					</td>

					
				</tr>
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
				<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGConsultaMonitoreo.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="   Volver   "/>
			</form>
		</div>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\RecaudacionPruebasSitios\XML\WEBConsultas\Consulta_CierreMonitoreoOutput.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->