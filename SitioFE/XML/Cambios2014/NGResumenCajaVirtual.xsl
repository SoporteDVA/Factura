<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:NonHtml="http://www.progress.com/StylusStudio/NonHtml" exclude-result-prefixes="NonHtml">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Bitácora Pagos Cajas Virtuales</title>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
				<script type="text/javascript" src="excel.js"></script>
				<script type="text/javascript" src="jquery-1.11.0.min.js"></script>
				<script>function goBack (){
					window.history.back()
					}</script>
			</head>
			<body>
				<xsl:choose>
					<xsl:when test="BitacoraNGResumenCajaVirtualOutput">
						<xsl:for-each select="BitacoraNGResumenCajaVirtualOutput">
							<xsl:call-template name="BitacoraOutput"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="BitacoraObtenerCajasMontosOutput">
						<xsl:for-each select="BitacoraObtenerCajasMontosOutput">
							<xsl:call-template name="BitacoraOutputMontos"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="BitacoraObtenerPagosCajasOutput">
						<xsl:for-each select="BitacoraObtenerPagosCajasOutput">
							<xsl:call-template name="BitacoraOutputPagosCajas"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>
								<div align="center">
									<font class="tituloAzulClaro">Consulta sin Datos de Respuesta!</font>
								</div>
								<br/>
								<xsl:value-of select="BitacoraNGResumenCajaVirtualFault/Mensaje"/>
							</h1>
						</center>
						<div align="center">
							<form action="Transaccion.aspx">
								<input type="hidden" name="Transaccion" value="ConsultaCajasCombo"/>
								<input type="hidden" name="Filtro" value="XML/Cambios2014/ParametrosFechaCajaCAT.xsl"/>
								<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
								<input type="hidden" name="TipoCaja" value="1"/>
								<input name="BotonCerrar" class="button_gris" type="submit" value="      Volver      "/>
							</form>
						</div>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="BitacoraOutput">
		<p>
			<p/>
			<div align="center">
				<font class="tituloAzulClaro">Resumen de Pagos por Tipo Envio</font>
			</div>
			<div align="center"/>

			<div align="right">
				<input class="button" type="button" onclick="tableToExcel('TipoEnvioTable', 'Tabla')" value="Exportar a Excel"/>
			</div>
			<br/>

			<div align="center">
				<table id="TipoEnvioTable" class="tabla" align="center" width="1000">
					<tbody>
						<tr>
							<td class="etiqueta">Tipo Envio</td>
							<td class="etiqueta">Fecha</td>
							<td class="etiqueta">Monto</td>
							<td class="etiqueta">Comision</td>
							<td class="etiqueta">Impresos</td>
							<td class="etiqueta">Sin Imprimir</td>
							<td class="etiqueta">Reversados</td>
							<td class="etiqueta">Error</td>
							<td class="etiqueta">Pendientes</td>
							<td class="etiqueta">Devolucion</td>
							<td class="etiqueta">AConciliar</td>
						</tr>
						<xsl:for-each select="Resultado/Fila">
							<tr>


								<td class="detalle">
									<a href="Transaccion.aspx?Transaccion=BitacoraObtenerCajasMontos&amp;ServidorSTX=infoware.STX.Gestion&amp;TipoEnvio={TipoEnvio}&amp;Fecha={Fecha}&amp;Filtro=XML/Cambios2014/NGResumenCajaVirtual.xsl">
										<xsl:value-of select="NombreEnvio"/>
									</a>
								</td>
								<td class="detalle">
									<xsl:value-of select="Fecha"/>
									<!--<a href = "Transaccion.aspx?Transaccion=BitacoraNGResumen&amp;ServidorSTX=infoware.STX.Gestion&amp;Fecha={concat(substring(Fecha,7,4),concat(substring(Fecha,3,4),substring(Fecha,1,2)))}&amp;Filtro=XML/Bitacora/NGResumenUnaFecha.xsl">
                                        
                                    </a>-->
								</td>

								<td class="detalleNumerico">

									<xsl:value-of select="format-number(Monto,'###,###,###,##0')"/>
								</td>
								<td class="detalleNumerico">

									<xsl:value-of select="format-number(Comision,'###,###,###,##0')"/>
								</td>
								<td class="detalleNumerico">
									<xsl:value-of select="NumeroPagos"/>
								</td>
								<td class="detalleNumerico">
									<xsl:value-of select="PagosSinImprimir"/>
								</td>
								<td class="detalleNumerico">
									<xsl:value-of select="Reversados"/>
								</td>
								<td class="detalleNumerico">
									<xsl:value-of select="ConError"/>
								</td>
								<td class="detalleNumerico">
									<xsl:value-of select="Pendientes"/>
								</td>
								<td class="detalleNumerico">

									<xsl:value-of select="format-number(MAConciliar,'###,###,###,##0')"/>
								</td>
								<td class="detalleNumerico">
									<xsl:value-of select="AConciliar"/>
								</td>
							</tr>
						</xsl:for-each>
						<tr>
							<td class="detalle"/>
							<td class="detalle">Total
								<strong><![CDATA[ ]]></strong>
							</td>
							<td class="detalleNumerico">

								<xsl:value-of select="format-number(sum(Resultado/Fila/Monto),'###,###,###,##0')"/>
							</td>
							<td class="detalleNumerico">

								<xsl:value-of select="format-number(sum(Resultado/Fila/Comision),'###,###,###,##0')"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="sum(Resultado/Fila/NumeroPagos)"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="sum(Resultado/Fila/PagosSinImprimir)"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="sum(Resultado/Fila/Reversados)"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="sum(Resultado/Fila/ConError)"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="sum(Resultado/Fila/Pendientes)"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="format-number(sum(Resultado/Fila/MAConciliar),'###,###,###,##0')"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="sum(Resultado/Fila/AConciliar)"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<br/>
			<div align="center">
				<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="ConsultaCajasCombo"/>
					<input type="hidden" name="Filtro" value="XML/Cambios2014/ParametrosFechaCajaCAT.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
					<input type="hidden" name="TipoCaja" value="1"/>
					<input name="BotonCerrar" class="button_gris" type="submit" value="      Volver      "/>
				</form>
			</div>
		</p>
	</xsl:template>
	<xsl:template name="BitacoraOutputMontos">
		<p>
			<p/>
			<div align="center">
				<font class="tituloAzulClaro">Resumen de Pagos por Cajas Virtuales y Tipo Envio</font>
			</div>
			<div align="center"/>
			<div align="right">
				<input class="button" type="button" onclick="tableToExcel('CajaTable', 'Tabla')" value="Exportar a Excel"/>
			</div>
			<br/>
			<div align="center">
				<table id="CajaTable" class="tabla" align="center" width="1000">
					<tbody>
						<tr>
							<td class="etiqueta">Tipo Envio</td>
							<td class="etiqueta">Fecha</td>
							<td class="etiqueta">Caja</td>
							<td class="etiqueta">Monto</td>
							<td class="etiqueta">Comision</td>
							<td class="etiqueta">Impresos</td>
							<td class="etiqueta">Sin Imprimir</td>
							<td class="etiqueta">Reversados</td>
							<td class="etiqueta">Error</td>
							<td class="etiqueta">Pendientes</td>
							<td class="etiqueta">Devolucion</td>
							<td class="etiqueta">AConciliar</td>
						</tr>
						<xsl:for-each select="Resultado/Fila">
							<tr>


								<td class="detalle">
									<xsl:value-of select="NombreEnvio"/>
								</td>
								<td class="detalle">
									<xsl:value-of select="Fecha"/>
								</td>
								<td class="detalle">
									<a href="Transaccion.aspx?Transaccion=BitacoraObtenerPagosCajas&amp;ServidorSTX=infoware.STX.Gestion&amp;NumeroCaja={Caja}&amp;Fecha={Fecha}&amp;Filtro=XML/Cambios2014/NGResumenCajaVirtual.xsl">
										<xsl:value-of select="Caja"/>-<xsl:value-of select="NombreCaja"/></a>
								</td>
								<td class="detalleNumerico">

									<xsl:value-of select="format-number(Monto,'###,###,###,##0')"/>
								</td>
								<td class="detalleNumerico">

									<xsl:value-of select="format-number(Comision,'###,###,###,##0')"/>
								</td>
								<td class="detalleNumerico">
									<xsl:value-of select="NumeroPagos"/>
								</td>
								<td class="detalleNumerico">
									<xsl:value-of select="PagosSinImprimir"/>
								</td>
								<td class="detalleNumerico">
									<xsl:value-of select="Reversados"/>
								</td>
								<td class="detalleNumerico">
									<xsl:value-of select="ConError"/>
								</td>
								<td class="detalleNumerico">
									<xsl:value-of select="Pendientes"/>
								</td>
								<td class="detalleNumerico">

									<xsl:value-of select="format-number(MAConciliar,'###,###,###,##0')"/>
								</td>
								<td class="detalleNumerico">
									<xsl:value-of select="AConciliar"/>
								</td>
							</tr>
						</xsl:for-each>
						<tr>
							<td class="detalle"/>
							<td class="detalle"/>
							<td class="detalle">Total
								<strong><![CDATA[ ]]></strong>
							</td>
							<td class="detalleNumerico">

								<xsl:value-of select="format-number(sum(Resultado/Fila/Monto),'###,###,###,##0')"/>
							</td>
							<td class="detalleNumerico">

								<xsl:value-of select="format-number(sum(Resultado/Fila/Comision),'###,###,###,##0')"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="sum(Resultado/Fila/NumeroPagos)"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="sum(Resultado/Fila/PagosSinImprimir)"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="sum(Resultado/Fila/Reversados)"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="sum(Resultado/Fila/ConError)"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="sum(Resultado/Fila/Pendientes)"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="format-number(sum(Resultado/Fila/MAConciliar),'###,###,###,##0')"/>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="sum(Resultado/Fila/AConciliar)"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<br/>
			<div align="center">
				<button onclick="goBack()" class="button_gris">Atras</button>
			</div>
			<br/>
			<div align="center">
				<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="ConsultaCajasCombo"/>
					<input type="hidden" name="Filtro" value="XML/Cambios2014/ParametrosFechaCajaCAT.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
					<input type="hidden" name="TipoCaja" value="1"/>
					<input name="BotonCerrar" class="button_red" type="submit" value="Cerrar"/>
				</form>
			</div>
			<br/>
		</p>
	</xsl:template>
	<xsl:template name="BitacoraOutputPagosCajas">
		<div align="center">
			<font class="tituloAzulClaro">Detalle de Pagos Correspondientes a la Caja Virtual</font>
		</div>


		<div align="right">
			<input class="button" type="button" onclick="tableToExcel('PagoTable', 'Tabla')" value="Exportar a Excel"/>
		</div>
		<br/>
		<table id="PagoTable" class="tabla" align="center" width="1200">
			<thead>
				<tr class="etiqueta">
					<th>Placa</th>
					<th>Estado</th>
					<th>Monto</th>
					<th>Comision</th>
					<th>F.Pago</th>
					<th>Comprobante</th>
					<th>Transaccion</th>
					<th>Fecha</th>
					<th>Propietario</th>
					<th>Correo</th>
					<th>Telefono</th>
					<th>Caja</th>
					<th>Origen</th>
					<th>Autorizado</th>
					<th>Direccion</th>
					
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select="Resultado/Fila">
					<tr>


						<!--Escoge el formato de la fila, si es reversión, se pone en rojo   -->
						<xsl:choose>
							<xsl:when test="Estado='DG'">
								<xsl:attribute name="class">tablaDuplicado</xsl:attribute>
							</xsl:when>
							<xsl:when test="Estado='RV' or Estado='PE' or Estado='SVE'">
								<xsl:attribute name="class">tablaConError</xsl:attribute>
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
						<td align="Left">
							<xsl:value-of select="TipoPlaca"/>-
							<xsl:value-of select="Numero"/>
						</td>
						<td>
							<xsl:value-of select="DescEstado"/>
						</td>
						<td align="right">
							<xsl:value-of select="format-number(Monto,'###,###,###,##0')"/>
						</td>
						<td align="right">
							<xsl:value-of select="format-number(Comision,'###,###,###,##0')"/>
						</td>
						<td>
							<xsl:value-of select="FormaPago"/>
						</td>
						<td>
							<xsl:value-of select="NumeroRecibo"/>
						</td>
						<td>
							<xsl:value-of select="Transaccion"/>
						</td>
						<td>
							<xsl:value-of select="Fecha"/>
						</td>
						<td>
							<xsl:value-of select="Nombre"/>
						</td>
						<td>
							<xsl:value-of select="Correo"/>
						</td>
						<td>
							<xsl:value-of select="Telefono"/>
						</td>
						<td align="left">
							<xsl:value-of select="Caja"/>-
							<xsl:value-of select="NombreCaja"/>
						</td>
						<td>
							<xsl:value-of select="OrigenPago"/>
						</td>
						<td>
							<xsl:value-of select="NombreAutorizado"/>
						</td>
						<td>
							<xsl:value-of select="Direccion"/>
						</td>
						
					</tr>
				</xsl:for-each>
				<tr>
					<td class="detalle"/>
					<td class="detalle">Total:
						<strong><![CDATA[ ]]></strong>
					</td>
					<td class="tablaResaltado" align="right">
						<xsl:value-of select="format-number(sum(Resultado/Fila/Monto),'###,###,###,##0')"/>
					</td>
					<td class="tablaResaltado" align="right">
						<xsl:value-of select="format-number(sum(Resultado/Fila/Comision),'###,###,###,##0')"/>
					</td>
					<td class="detalle"/>
					<td class="detalle"/>
					<td class="detalle"/>
					<td class="detalle"/>
					<td class="detalle"/>
					<td class="detalle"/>
					<td class="detalle"/>
					<td class="detalle"/>
					<td class="detalle"/>
					<td class="detalle"/>
					<td class="detalle"/>
				</tr>
			</tbody>
		</table>
		<br/>
		<br/>
		<div align="center">
			<button onclick="goBack()" class="button_gris">Atras</button>
		</div>
		<br/>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="ConsultaCajasCombo"/>
				<input type="hidden" name="Filtro" value="XML/Cambios2014/ParametrosFechaCajaCAT.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
				<input type="hidden" name="TipoCaja" value="1"/>
				<input name="BotonCerrar" class="button_red" type="submit" value="Cerrar"/>
			</form>
		</div>
		<br/>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\Bitacora\BitacoraNGResumen.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
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
			<advancedProp name="xsltVersion" value="2.0"/>
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