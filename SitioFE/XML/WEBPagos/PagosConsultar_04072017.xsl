<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"></script>
			</head>
			<xsl:choose>
				<xsl:when test="ConsultaMaestrosOutput">
					<xsl:for-each select="ConsultaMaestrosOutput">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConsultaMaestrosFault">
					<xsl:for-each select="ConsultaMaestrosFault">
						<xsl:call-template name="Mensaje"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<div align="center">
						<br/>
						<font class="tituloAzulClaro">
							<xsl:value-of select="ConsultaMaestrosFault/Respuesta"/>
						</font>
						<br/>
						<br/>
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</html>
	</xsl:template>
	<xsl:template name="Consulta">
		<body onload="document.forms[0].Numero.focus();">
			<form action="Transaccion.aspx" method="post">
				<input type="hidden" name="Transaccion" value="xp_ConsultaServicio"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input type="hidden" name="Filtro" value="XML/WEBPagos/PagosPagar.xsl"/>
				<input type="hidden" name="Canal" value="SITIO"/>
				<input type="hidden" name="Moneda" value="{Convenios/Fila/Moneda}"/>
				<input type="hidden" name="Periodo" value="{Convenios/Fila/Periodo}"/>
				<input type="hidden" name="TipoPago" value="{Convenios/Fila/TipoPago}"/>
				<input type="hidden" name="CobroTardio" value="{Convenios/Fila/CobroTardio}"/>
				<input type="hidden" name="ValidarAntiguedad" value="{Convenios/Fila/ValidarAntiguedad}"/>
				<br/>
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
				<table align="center" width="300" border="0">
					<tr>
						<td width="50%" align="center">
							<font class="tituloAzulClaro">Consulta de Servicios</font>
						</td>
					</tr>
				</table>
				<br/>
				<table class="tabla" align="center">
					<tr>
						<td class="etiqueta">Colector o Servicio :</td>
						<td colSpan="3" class="detalle">
							<xsl:if test="Etapa='1'">
								<select class="campo" name="Colector" onchange="document.forms[0].Filtro.value='XML/WEBPagos/PagosConsultar.xsl';ejecutarComo('ConsultaMaestros');">
									<option value="0" selected="selected">--Seleccione--</option>
									<xsl:for-each select="Colectores/Fila">
										<xsl:if test="Estado='A'">
											<option value="{ID}">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
									</xsl:for-each>
								</select>
							</xsl:if>
							<xsl:if test="Etapa='2'">
								<input type="hidden" name="Colector" value="{Colectores/Fila/ID}"/>
								<xsl:value-of select="Colectores/Fila/Descripcion"/>
							</xsl:if>
							<xsl:if test="Etapa='3'">
								<input type="hidden" name="Colector" value="{Colectores/Fila/ID}"/>
								<xsl:value-of select="Colectores/Fila/Descripcion"/>
							</xsl:if>
						</td>
					</tr>

					<xsl:if test="Convenios/Fila/ID != '' ">
						<tr>
							<td class="etiqueta">Convenio :</td>
							<td colSpan="3" class="detalle">
								<xsl:if test="Etapa='2'">
									<select class="campo" name="Convenio" onchange="document.forms[0].Filtro.value='XML/WEBPagos/PagosConsultar.xsl';ejecutarComo('ConsultaMaestros');">
										<option value="0" selected="selected">--Seleccione--</option>
										<xsl:for-each select="Convenios/Fila">
											<xsl:if test="Estado='A'">
												<option value="{ID}">
													<xsl:value-of select="Descripcion"/>
												</option>
											</xsl:if>
										</xsl:for-each>
									</select>
								</xsl:if>
								<xsl:if test="Etapa='3'">
									<input type="hidden" name="Convenio" value="{Convenios/Fila/ID}"/>
									<xsl:value-of select="Convenios/Fila/Descripcion"/>
								</xsl:if>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="TipoIdentificador/Fila/ID != '' ">
						<tr>
							<td class="etiqueta">Tipo de Identificador :</td>
							<td colSpan="3" class="detalle">
								<select class="campo" name="TipoLlave">
									<xsl:for-each select="TipoIdentificador/Fila">
										<xsl:if test="Estado='A'">
											<option value="{ID}" selected="selected">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
									</xsl:for-each>
								</select>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="Etapa='2' or Etapa='3'">
						<xsl:if test="Colectores/Fila/ID != '' ">
							<tr>
								<td class="etiqueta">Numero:</td>
								<td colSpan="3">
									<input size="37" name="Numero" maxlength="30" class="campo" ID="Text1"/>
								</td>
							</tr>
						</xsl:if>
					</xsl:if>
					<xsl:if test="Etapa='3' and Colectores/Fila/IDAlterno = 70">
						<xsl:if test="Colectores/Fila/ID != '' ">
							<tr>
								<td class="etiqueta">Monto:</td>
								<td colSpan="3">
									<input size="37" name="Monto" maxlength="10" class="campo"/>
								</td>
							</tr>
						</xsl:if>
					</xsl:if>
				</table>
				<br/>

				<div align="center">
					<input name="Consultar" class="Button_red" type="button" value="Consultar" onclick="if (document.forms[0].Numero.value == '') alert('Digite el Numero o Valor que desea Consultar.'); else submit();"/>
				</div>
			</form>
			<xsl:if test="Etapa='2' or Etapa='3'">
				<div align="center">
					<form action="Transaccion.aspx">
						<input type="hidden" name="Transaccion" value="ConsultaMaestros"/>
						<input type="hidden" name="Filtro" value="XML/WEBPagos/PagosConsultar.xsl"/>
						<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
						<input name="BotonCerrar" class="button_gris" type="submit" value="   Comenzar Nuevamente   "/>
					</form>
				</div>
			</xsl:if>
		</body>
	</xsl:template>
	<xsl:template name="Mensaje">
		<div align="center">
			<br/>
			<br/>
			<br/>
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
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\RecaudacionPruebas\XML\INS\ConsultaClasePlacaOutput.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0"
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