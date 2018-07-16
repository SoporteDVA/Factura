<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Bitacora de Totales</title>
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
				<xsl:when test="ConsultaTotalesBNCROutput[Resultados/TotalesBNCR/CantidadColectores&gt;0 or Resultados/TotalesDAVIVIENDA/CantidadColectores&gt;0]">
					<xsl:call-template name="DetallePagos"/>
				</xsl:when>
				<xsl:when test="EstadosOutput">
					<xsl:for-each select="EstadosOutput/Resultado">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConsultaTotalesBNCROutputFault">
					<xsl:for-each select="ConsultaTotalesBNCROutputFault">
						<xsl:call-template name="Mensaje"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConsultaTotalesBNCROutput[Resultados/TotalesBNCR/CantidadColectores=0 or Resultados/TotalesDAVIVIENDA/CantidadColectores=0]">
					<xsl:call-template name="Mensaje"/>
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
			<input type="hidden" name="Transaccion" value="ConsultaTotalesBNCR"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="Filtro" value="XML/WEBCierreNC/ParametrosNGConsultaTotalesTransacciones.xsl"/>
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
						<font class="tituloAzulClaro">Validacion de Totales por Colector BNCR</font>
						<font class="tituloAzulClaro"></font>
					</td>
				</tr>
			</table>
			<br/>
			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta" align="center">Fecha de Transacciones:
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
						<fONT class="tituloAzulClaro">Resumen de datos Locales y Remotos BNCR</fONT>
						<br/>
						<fONT class="tituloAzulClaro">Fecha de Transacciones: <xsl:value-of select="ConsultaTotalesBNCROutput/Resultados/Fecha"/></fONT>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="Estados"/>
				<input type="hidden" name="Filtro" value="~/XML/WEBCierreNC/ParametrosNGConsultaTotalesTransacciones.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button" type="submit" value="  «« Realizar Otra Consulta   "/>
			</form>
		</div>
		<br/>
		<div>
			<table align="center">
				<tr>
					<td>
						<table class="tabla">
							<thead align="left">
								<td class="etiqueta" colspan="2" align="center">Transacciones</td>
								<tr>
									<th class="etiquetaBNCR" align="right">Total Transacciones BNCR:</th>
									<td class="detalle">
										<xsl:value-of select="sum(ConsultaTotalesBNCROutput/Resultados/TotalesBNCR/Totales/TipoColector/nTotalTransacciones)"/>
									</td>
								</tr>
								<tr>
									<th class="etiquetaDAV" align="right">Total Transacciones Locales:</th>
									<td class="detalle">
										<xsl:value-of select="sum(ConsultaTotalesBNCROutput/Resultados/TotalesDAVIVIENDA/Totales/TipoColector/nTotalTransacciones)"/>
									</td>
								</tr>
								<tr>
									<th class="etiquetaBLANCA" align="right">Diferencia Transacciones:</th>
									<td class="detalle" align="center">
										<xsl:value-of select="sum(ConsultaTotalesBNCROutput/Resultados/TotalesDAVIVIENDA/Totales/TipoColector/nTotalTransacciones)-sum(ConsultaTotalesBNCROutput/Resultados/TotalesBNCR/Totales/TipoColector/nTotalTransacciones)"/>
									</td>
								</tr>
							</thead>
						</table>
					</td>
					<td>
						<table class="tabla">

							<thead align="left">
								<td class="etiqueta" colspan="2" align="center">Montos</td>
								<tr>

									<th class="etiquetaBNCR" align="right">Monto Total BNCR:</th>
									<td class="detalle" align="right">
										<xsl:value-of select="format-number(sum(ConsultaTotalesBNCROutput/Resultados/TotalesBNCR/Totales/TipoColector/nMontoTotal),'###,###,###.00')"/>
									</td>
								</tr>
								<tr>
									<th class="etiquetaDAV" align="right">Monto Total Local:</th>
									<td class="detalle" align="right">
										<xsl:value-of select="format-number(sum(ConsultaTotalesBNCROutput/Resultados/TotalesDAVIVIENDA/Totales/TipoColector/nMontoTotal),'###,###,###.00')"/>
									</td>
								</tr>
								<tr>
									<th class="etiquetaBLANCA" align="right">Diferencia Monto:</th>
									<td class="detalle" align="right">
										<xsl:value-of select="format-number((sum(ConsultaTotalesBNCROutput/Resultados/TotalesBNCR/Totales/TipoColector/nMontoTotal)-sum(ConsultaTotalesBNCROutput/Resultados/TotalesDAVIVIENDA/Totales/TipoColector/nMontoTotal)),'###,###,###.00')"/>
									</td>
								</tr>
							</thead>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<div width="100%">
			<table align="center">
				<tr>
					<td width="100%">
						<table class="tabla" align="left" width="100%">
							<thead>
								<th class="etiquetaBNCR" colspan="5">Totales Banco Nacional para la fecha : <xsl:value-of select="ConsultaTotalesBNCROutput/Resultados/Fecha"/></th>
								<tr class="etiquetaBNCR">

									<th align="center">Colector<br/> BNCR</th>
									<th align="center">Convenio<br/> BNCR</th>
									<th align="center">Moneda<br/> BNCR</th>
									<th align="center">Cantidad de Transacciones <br/>por Colector<br/>BNCR</th>
									<th align="right">Monto Total</th>
								</tr>
							</thead>
							<tbody>
								<xsl:for-each select="ConsultaTotalesBNCROutput/Resultados/TotalesBNCR/Totales/TipoColector">
									<tr class="detalle">
										<td align="center">
											<xsl:value-of select="NColector"/>
										</td>
										<td align="center">
											<xsl:value-of select="NCodConvenio"/>
										</td>
										<td align="center">
											<xsl:value-of select="strCodMoneda"/>
										</td>
										<td align="center">
											<xsl:value-of select="nTotalTransacciones"/>
										</td>
										<td align="right">
											<xsl:value-of select="format-number(nMontoTotal,'###,###,###.00')"/>
										</td>
									</tr>
								</xsl:for-each>
								<tr>
									<td class="etiquetaBNCR"/>
									<td class="etiquetaBNCR"/>
									<td class="etiquetaBNCR" align="right">Totales
										<strong><![CDATA[ ]]></strong>
									</td>

									<td class="etiquetaBNCR" align="center">
										<xsl:value-of select="sum(ConsultaTotalesBNCROutput/Resultados/TotalesBNCR/Totales/TipoColector/nTotalTransacciones)"/>
									</td>
									<td class="etiquetaBNCR" align="right">

										<xsl:value-of select="format-number(sum(ConsultaTotalesBNCROutput/Resultados/TotalesBNCR/Totales/TipoColector/nMontoTotal),'###,###,###,###,###,##0.00')"/>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td width="100%">
						<table class="tabla" align="left" width="100%">
							<thead>
								<th class="etiquetaDAV" colspan="7">Totales Banco DAVIVIENDA para la fecha : <xsl:value-of select="ConsultaTotalesBNCROutput/Resultados/Fecha"/></th>
								<tr class="etiquetaDAV">
									<th colspan="2" align="right">Colector<br/>Local</th>
									<th>Descripcion</th>
									<th align="center">Convenio<br/> Local</th>
									<th align="center">Moneda<br/> Local</th>
									<th align="center">Cantidad de Transacciones <br/>por Colector<br/>Locales</th>
									<th align="right">Monto Total</th>
								</tr>
							</thead>

							<tbody>
								<xsl:for-each select="ConsultaTotalesBNCROutput/Resultados/TotalesDAVIVIENDA/Totales/TipoColector">
									<tr class="detalle">
										<td align="left">BNCR : <xsl:value-of select="NColector"/></td>
										<td align="center">
											<xsl:value-of select="NColectorLocal"/>
										</td>
										<td align="left">
											<xsl:value-of select="NombreColector"/>
										</td>
										<td align="center">
											<xsl:value-of select="NCodConvenio"/>
										</td>
										<td align="center">
											<xsl:value-of select="strCodMoneda"/>
										</td>
										<td align="center">
											<xsl:value-of select="nTotalTransacciones"/>
										</td>
										<td align="right">
											<xsl:value-of select="format-number(nMontoTotal,'###,###,###.00')"/>
										</td>
									</tr>
								</xsl:for-each>


								<tr>
									<td colspan="2" class="etiquetaDAV"/>
									<td class="etiquetaDAV"/>
									<td class="etiquetaDAV"/>
									<td class="etiquetaDAV" align="right">Totales
										<strong><![CDATA[ ]]></strong>
									</td>

									<td class="etiquetaDAV" align="center">
										<xsl:value-of select="sum(ConsultaTotalesBNCROutput/Resultados/TotalesDAVIVIENDA/Totales/TipoColector/nTotalTransacciones)"/>
									</td>
									<td class="etiquetaDAV" align="right">

										<xsl:value-of select="format-number(sum(ConsultaTotalesBNCROutput/Resultados/TotalesDAVIVIENDA/Totales/TipoColector/nMontoTotal),'###,###,###,###,###,##0.00')"/>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</table>
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
					<td class="etiqueta" align="center">Cantidad de Servicios <br/>Procesados en BNCR</td>
					<td class="etiqueta" align="center">Cantidad de Servicios <br/>Procesados Localmente</td>
				</tr>
				<tr class="detalle">
					<td align="center">

						<xsl:value-of select="ConsultaTotalesBNCROutput/Resultados/TotalesDAVIVIENDA/CantidadColectores"/>
					</td>
					<td align="center">
						<xsl:value-of select="ConsultaTotalesBNCROutput/Resultados/TotalesBNCR/CantidadColectores"/>
					</td>
				</tr>
			</table>
			<br/>
			<br/>
		</div>



		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="Estados"/>
				<input type="hidden" name="Filtro" value="~/XML/WEBCierreNC/ParametrosNGConsultaTotalesTransacciones.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="   Volver   "/>
			</form>
		</div>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ConsultaTotalesBNCROutput.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
		          urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
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