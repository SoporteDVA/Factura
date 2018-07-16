<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión de las Comisiones por Convenios del BNCR</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
			</head>
			<body>
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
				<p align="center">

					<td width="100%">
						<font class="tituloAzulClaro">Comisiones correspondientes a los convenios del BNCR</font>
					</td>
				</p>

				<xsl:choose>
					<xsl:when test="AgregaModificaConveniosFault">
						<table class="tablaDetalle" align="center" border="0">
							<tfoot align="center"/>
							<tbody>
								<tr class="encabezado">
									<td align="center">
										<strong>Estado</strong>
									</td>
									<td>
										<p align="center">
											<strong>Mensaje</strong>
										</p>
									</td>
								</tr>
								<xsl:for-each select="AgregaModificaConveniosFault">
									<tr class="detalle">
										<td>
											<p align="center">
												<xsl:value-of select="Estado"/>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:value-of select="Mensaje"/>
											</p>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</xsl:when>
					<xsl:otherwise>
						<form action="--WEBBOT-SELF--" method="post">
							<p>
								<table class="tabla" align="center" border="0">
									<tfoot align="center"/>
									<tbody>
										<tr class="etiqueta">
											<td>
												<p align="center">
													<strong>ID</strong>
												</p>
											</td>
											<td>
												<p align="center">
													<strong>Codigo</strong>
												</p>
											</td>

											<td>
												<p align="center">
													<strong>Empresa</strong>
												</p>
											</td>

											<td align="center">
												<strong>Convenio</strong>
											</td>

											<td>
												<p align="center">
													<strong>Descripción</strong>
												</p>
											</td>
											<td>
												<p align="center">
													<strong>Límite Superior</strong>
												</p>
											</td>
											<td>
												<p align="center">
													<strong>Porcentaje</strong>
												</p>
											</td>
											<td>
												<p align="center">
													<strong>Monto Fijo</strong>
												</p>
											</td>
											<td>
												<p align="center">
													<strong>Mínimo Comisión</strong>
												</p>
											</td>
										</tr>
										<xsl:for-each select="Consulta_ComisionesBNCROutput/Resultado/Fila">
											<tr class="detalle">
												<td>
													<p align="left">
														<xsl:value-of select="ID"/>
													</p>
												</td>

												<td>
													<p align="center">
														<xsl:value-of select="CodigoComision"/>
													</p>
												</td>
												<td>
													<p align="Left">
														<xsl:value-of select="Empresa"/>
													</p>
												</td>
												<td>
													<p align="left">
														<xsl:value-of select="Convenio"/>
													</p>
												</td>
												<td>
													<p align="left">
														<xsl:value-of select="DescripcionComision"/>
													</p>
												</td>
												<td>
													<p align="right">
														<xsl:value-of select="LimiteSuperior"/>
													</p>
												</td>
												<td>
													<p align="right">
														<xsl:value-of select="Porcentaje"/>
													</p>
												</td>
												<td>
													<p align="right">
														<xsl:value-of select="MontoFijo"/>
													</p>
												</td>
												<td>
													<p align="right">
														<xsl:value-of select="MinimoComision"/>
													</p>
												</td>
											</tr>
										</xsl:for-each>
									</tbody>
								</table>
							</p>
						</form>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="Botones">
		<table align="center" border="0" style="; width: 338px; height: 30px">
			<tbody>
				<tr>
					<td width="50%">
						<p align="left">
							<button onclick="AgregarCaja();">
								<div align="center">
									<strong>Agregar</strong>
								</div>
							</button>
						</p>
					</td>
					<td/>
					<td/>
					<td/>
					<td/>
				</tr>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template name="Estado">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = A">Activo</xsl:when>
			<xsl:when test="$Codigo = I">Inactivo</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ConsultaComisiones.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
		          commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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