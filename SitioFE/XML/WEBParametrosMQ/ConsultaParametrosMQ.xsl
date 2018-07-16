<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión de Parametros MQ y WS</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
			</head>
			<body>
				<p align="center">
					<table width="358" border="0" style=" width: 358px; height: 80px">
						<thead>
							<tr>

								<td width="100%">
									<p align="center">
										<font class="tituloAzulClaro">
											<strong>Gestión de Parametros MQ y WS</strong>
										</font>
									</p>
								</td>
							</tr>
						</thead>
					</table>
				</p>
				<div align="Center">
					<form action="Transaccion.aspx">
						<p>
							<table class="tablaDetalle" align="center" border="0">
								<tfoot align="center"/>
								<xsl:for-each select="ConsultaParametrosMQOutput/Resultado/Fila">
									<tbody>
										<tr class="encabezado">
											<td>
												<p align="right">
													<strong>Canal</strong>
												</p>
											</td>
											<td class="detalle">
												<p align="center">
													<xsl:value-of select="Canal"/>
												</p>
											</td>
										</tr>
										<tr class="encabezado">
											<td align="right">
												<strong>Producto</strong>
											</td>
											<td class="detalle">
												<p align="center">
													<xsl:value-of select="Producto"/>
												</p>
											</td>
										</tr>
										<tr class="encabezado">
											<td align="right">
												<strong>Causa</strong>
											</td>
											<td class="detalle">
												<p align="center">
													<xsl:value-of select="Causa"/>
												</p>
											</td>
										</tr>
										<tr class="encabezado">
											<td align="right">
												<strong>Afectación</strong>
											</td>
											<td class="detalle">
												<p align="center">
													<xsl:value-of select="Afectacion"/>
												</p>
											</td>
										</tr>
										<tr class="encabezado">
											<td align="right">
												<strong>Producto Origen</strong>
											</td>
											<td class="detalle">
												<p align="center">
													<xsl:value-of select="ProdOrigen"/>
												</p>
											</td>
										</tr>
										<tr class="encabezado">
											<td align="right">
												<strong>Usuario</strong>
											</td>
											<td class="detalle">
												<p align="center">
													<xsl:value-of select="Usuario"/>
												</p>
											</td>
										</tr>
										<tr class="encabezado">
											<td align="right">
												<strong>Terminal</strong>
											</td>
											<td class="detalle">
												<p align="center">
													<xsl:value-of select="Terminal"/>
												</p>
											</td>
										</tr>
										<tr class="encabezado">
											<td align="right">
												<strong>Oficina</strong>
											</td>
											<td class="detalle">
												<p align="center">
													<xsl:value-of select="Oficina"/>
												</p>
											</td>
										</tr>
										<tr class="encabezado">
											<td align="right">
												<strong>EnLinea</strong>
											</td>
											<td class="detalle">
												<p align="center">
													<xsl:value-of select="EnLinea"/>
												</p>
											</td>
										</tr>
										<tr class="encabezado">
											<td align="right">
												<strong>Corrige Pago</strong>
											</td>
											<td class="detalle">
												<p align="center">
													<xsl:value-of select="CorrecionPago"/>
												</p>
											</td>
										</tr>
										<tr class="encabezado">
											<td align="right">
												<strong>Corrige Reversion</strong>
											</td>
											<td class="detalle">
												<p align="center">
													<xsl:value-of select="CorrecionReversion"/>
												</p>
											</td>
										</tr>
										<tr class="encabezado">
											<td align="right">
												<strong>Contabiliza</strong>
											</td>
											<td class="detalle">
												<p align="center">
													<xsl:value-of select="Contabiliza"/>
												</p>
											</td>
										</tr>
										<tr class="encabezado">
											<td class="etiqueta" align="right">Medio de Procesamiento</td>
											<td colspan="3" class="detalle">
												<SELECT class="inputAzul" NAME="Destino">
													<option value="{Destino}" selected="selected">
														<xsl:call-template name="Estado">
															<xsl:with-param name="Codigo" select="normalize-space(Destino)"/>
														</xsl:call-template>
													</option>
													<xsl:if test="normalize-space(Destino)='Cola'">
														<OPTION VALUE="WS">WEBService</OPTION>
													</xsl:if>
													<xsl:if test="normalize-space(Destino)='WS'">
														<OPTION VALUE="Cola">Cola MQ</OPTION>
													</xsl:if>
													<xsl:if test="normalize-space(Destino)=''">
														<OPTION VALUE="WS" selected="selected">WEBService</OPTION>
														<OPTION VALUE="Cola">Cola MQ</OPTION>
													</xsl:if>
												</SELECT>
											</td>
										</tr>
									</tbody>
								</xsl:for-each>
							</table>
						</p>

						<input type="hidden" name="Transaccion" value="ActualizaParametrosMQ"/>
						<input type="hidden" name="Filtro" value="XML/WEBParametrosMQ/ConsultaParametrosMQ.xsl"/>
						<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
						<input name="BotonCerrar" class="button_red" type="submit" value="      Actualizar      "/>
					</form>
				</div>
				<p>&#xA0;</p>
			</body>
		</html>
	</xsl:template>


	<xsl:template name="Estado">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 'Cola'">Cola MQ</xsl:when>
			<xsl:when test="$Codigo = 'WS'">WEBService</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="TipoCodigo">
		<xsl:param name="TipoCodigo" select="."/>
		<xsl:choose>
			<xsl:when test="$TipoCodigo = 5">Clase Placa</xsl:when>
			<xsl:when test="$TipoCodigo = 1">Codigo GOB</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\RecaudacionPruebasSitios\XML\Gestion\ConsultaCajas.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator="">
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