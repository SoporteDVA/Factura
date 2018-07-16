<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Bitacora de Transacciones Detallada</title>
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
				<xsl:when test="BNCR_RevisaTransaccionesOutput">
					<xsl:for-each select="BNCR_RevisaTransaccionesOutput">
						<xsl:call-template name="DetallePagos"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="EstadosOutput">
					<xsl:for-each select="EstadosOutput/Resultado">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="BNCR_RevisaTransaccionesFault">
					<xsl:for-each select="BNCR_RevisaTransaccionesFault">
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
		<table align="center">
			<tr>
				<td width="30%">
					<p align="center">
						<img align="baseline" src="imagenes/DVAEnc.JPG"/>
					</p>
				</td>
			</tr>
		</table>
		<form action="Transaccion.aspx" method="post">
			<input type="hidden" name="Transaccion" value="BNCR_RevisaTransacciones"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="Filtro" value="XML/WEBConsultas/ParametrosNGResumenFechaOficinaTT.xsl"/>

			<table align="center" width="500" border="0">
				<tr>
					<td width="50%" align="center">
						<font class="tituloAzulClaro">Validacion de Transacciones Individuales BNCR</font>
						<font class="tituloAzulClaro"></font>
					</td>
				</tr>
			</table>
			<br/>
			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta">Fecha:
						<input name="Fecha" type="text" class="Calendario"/>
					</td>
					<!--<td class="etiqueta">Fecha Final:
						<input name="FechaFinal" type="text" class="Calendario"/>
					</td>-->
				</tr>
			</table>
			<br/>


			<p>
				<div align="center">
					<input name="Reporte" class="button_red" type="button" value="Procesar" onclick="if (document.forms[0].Fecha.value == '') alert('Debe definir una Fecha'); else submit();"/>
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
						<fONT class="tituloAzulClaro">VALIDACION DETALLADA DE TRANSACCIONES del BNCR</fONT>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<xsl:for-each select="Resultados">
			<div width="100%" align="right">
				<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="Estados"/>
					<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGResumenFechaOficinaTT.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
					<input name="BotonCerrar" class="button" type="submit" value="  «« Realizar Otra Consulta   "/>
				</form>
			</div>
			<br/>
			<table class="tablaTrans">
				<thead>
					<tr class="etiquetaTrans">
					    <th colspan="3" class="etiquetaBlanca"></th>
						<th colspan="6" class="etiquetaBNCR">Info de Transaccion en BNCR</th>
						<th colspan="7" class="etiquetaDAV">Info de Transaccion Local</th>
					</tr>
					<tr class="etiquetaTrans">
						<th >Documento</th>
						<th>Factura</th>
						<th>Informacion</th>
						<th colspan="2" class="etiquetaBNCR">Emp  ~  Conv</th>
						<th class="etiquetaBNCR">EstadoBNCR</th>
						<th class="etiquetaBNCR">MontoBNCR</th>
						<th class="etiquetaBNCR">NumeroBNCR</th>
						<th class="etiquetaBNCR">PeriodoBNCR</th>						
						<th colspan="2" class="etiquetaDAV">Col  ~  Conv</th>
						<th class="etiquetaDAV">Doc.Local</th>
						<th class="etiquetaDAV">Estado</th>
						<th class="etiquetaDAV">Monto</th>
						<th class="etiquetaDAV">Numero</th>
						<th class="etiquetaDAV">Periodo</th>
					</tr>
				</thead>
				<tbody>

					<xsl:for-each select="Fila">
						<tr>
							<!--Escoge el formato de la fila, si es reversión, se pone en rojo   -->
							<xsl:choose>
								<xsl:when test="normalize-space(EstadoBNCR)='01'">
									<xsl:attribute name="class">tablaResaltado</xsl:attribute>
								</xsl:when>
								<xsl:when test="normalize-space(EstadoBNCR)='2'">
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
									<xsl:attribute name="class">detalleTRANS</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
							<td>
							<a href="#" class="balloon">
									<xsl:value-of select="NumeroDocumento"/>

									<div align="center">
										<table>
											<xsl:choose>
												<xsl:when test="MontoLocal&gt;0">
													<xsl:attribute name="class">tablaToolTip</xsl:attribute>
												</xsl:when>
												<xsl:when test="DocumentoLocal =''">
													<xsl:attribute name="class">tablaConError</xsl:attribute>
												</xsl:when>
												<xsl:otherwise>
													<xsl:attribute name="class">tablaToolTipP</xsl:attribute>
												</xsl:otherwise>
											</xsl:choose>
											<thead>

												<th colspan="2" class="etiqueta">Informacion<br/>del Documento <xsl:value-of select="DocumentoLocal"/></th>
											</thead>
											<xsl:choose>
												<xsl:when test="NumeroDocumento !=''">
													<tbody class="tablaDetalle">
														<tr>
															<td>Documento :</td>
															<td align="left">
																<xsl:value-of select="NumeroDocumento"/>
															</td>
														</tr>
														<tr>
															<td>Numero :</td>
															<td>
																<xsl:value-of select="NumeroLocal"/>
															</td>
														</tr>
														<tr>
															<td>Servicio :</td>
															<td>
																<xsl:value-of select="Colector"/>- <xsl:value-of select="DColector"/></td>
														</tr>
														<tr>
															<td>Convenio :</td>
															<td>
																<xsl:value-of select="Convenio"/>- <xsl:value-of select="DCConvenio"/></td>
														</tr>
														<tr>
															<td>Fecha :</td>
															<td>
																<xsl:value-of select="Fecha"/>
															</td>
														</tr>
														<tr>

															<td>Periodo :</td>
															<td>
																<xsl:choose>
																	<xsl:when test="substring(PeriodoLocal,1,2)='00'">
																		<xsl:value-of select="substring(PeriodoLocal,7,2)"/>-<xsl:value-of select="substring(PeriodoLocal,3,4)"/></xsl:when>
																	<xsl:when test="substring(PeriodoLocal,1,2)='20'">
																		<xsl:value-of select="substring(PeriodoLocal,7,2)"/>-<xsl:value-of select="substring(PeriodoLocal,5,2)"/>-<xsl:value-of select="substring(PeriodoLocal,1,4)"/></xsl:when>
																</xsl:choose>
															</td>
														</tr>
														<tr>
															<td>Factura :</td>
															<td>
																<xsl:value-of select="format-number(NumeroFactura,'#')"/>
															</td>
														</tr>
														<tr>
															<td>Monto :</td>
															<td>
																<xsl:value-of select="format-number(MontoLocal,'###,###.00')"/>
															</td>
														</tr>
														
														
														<tr>
															<td>Informacion :</td>
															<td>
																<xsl:value-of select="Informacion"/>
															</td>
														</tr>
														
													</tbody>
												</xsl:when>
												<xsl:otherwise>
													<tbody>
														<tr>
															<td>Informacion :</td>
															<td>
																<xsl:value-of select="Informacion"/>
															</td>
														</tr>
													</tbody>
												</xsl:otherwise>
											</xsl:choose>
										</table>
									</div>
								</a>
								</td>
							
							<td>
								<xsl:value-of select="NumeroFactura"/>
							</td>
							<td>
								<xsl:value-of select="Informacion"/>
							</td>
							<td align="center">
								<xsl:value-of select="ColectorBNCR"/>
							</td>
							<td align="center">
								<xsl:value-of select="ConvenioBNCR"/>
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="normalize-space(EstadoBNCR)='1'">Pagada</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="normalize-space(EstadoBNCR)='2'">Reversada</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="normalize-space(EstadoBNCR)='01'">No Registrada</xsl:when>
								</xsl:choose>
							</td>
							<td>
								<xsl:value-of select="MontoBNCR"/>
							</td>
							<td>
								<xsl:value-of select="NumeroBNCR"/>
							</td>
							<td>
								<xsl:value-of select="PeriodoBNCR"/>
							</td>
							
							<td align="center">
								<xsl:value-of select="Colector"/>
							</td>
							<td align="center">
								<xsl:value-of select="Convenio"/>
							</td>
							<td align="center">
								<xsl:value-of select="NumeroDocumento"/>
							</td>
							<td>
								<xsl:value-of select="Estado"/>
							</td>
							<td>
								<xsl:value-of select="MontoLocal"/>
							</td>
							<td>
								<xsl:value-of select="NumeroLocal"/>
							</td>
							<td>
								<xsl:value-of select="PeriodoLocal"/>
							</td>
						</tr>
					</xsl:for-each>
					<!--<tr>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta">Total
							<strong><![CDATA[ ]]></strong>
						</td>
						<td class="etiqueta" align="right">
							<xsl:value-of select="format-number(sum(Fila/TotalReal),'###,###,###,##0.00')"/>
						</td>
						<td class="etiqueta" align="right">

							<xsl:value-of select="format-number(sum(Fila/ComisionReal),'###,###,###,##0.00')"/>
						</td>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
					</tr>-->
				</tbody>
			</table>
		</xsl:for-each>
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
				<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGResumenFechaOficinaTT.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="   Volver   "/>
			</form>
		</div>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="Consulta_PagosOutput.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
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