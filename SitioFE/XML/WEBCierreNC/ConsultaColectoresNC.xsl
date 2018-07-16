<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión de los Colectores del Sistema</title>
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
						<font class="tituloAzulClaro">Cierre de las Notas de Credito para los Colectores del Sistema</font>
					</td>
				</p>
				<p>
				</p>
				<form action="--WEBBOT-SELF--" method="post">
					<p>
						<table class="tablaDetalle" align="center" border="0">
							<tfoot align="center"/>
							<tbody>
								<tr class="encabezado">
									<td align="center">
										<strong>ID</strong>
									</td>
									<td>
										<p align="center">
											<strong>Codigo Alterno</strong>
										</p>
									</td>
									<td>
										<p align="center">
											<strong>Descripcion</strong>
										</p>
									</td>

									<td align="center">
										<strong>Estado</strong>
									</td>
								</tr>
								<xsl:for-each select="ConsultaColectoresOutput/Resultado/Fila">
									<tr class="detalle">
										<td>
											<p align="center">
												<a>
													<xsl:attribute name="href">ComponerXSL.aspx?Transaccion=ConsultaNotasFecha&amp;Filtro=~/XML/WEBCierreNC/ConsultaNotasFecha.xsl&amp;IDColector=<xsl:value-of select="ID"/>&amp;IDAlterno=<xsl:value-of select="IDAlterno"/></xsl:attribute>
													<xsl:value-of select="ID"/>
													<img hspace="1" src="imagenes/go.gif" align="center" border="0" alt="Buscar el dia de la Nota Credito"/>
												</a>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:value-of select="IDAlterno"/>
											</p>
										</td>
										<td>
											<p align="Left">
												<xsl:value-of select="Descripcion"/>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:value-of select="Estado"/>
											</p>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</p>
				</form>
			</body>
		</html>
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\Gestion\ConsultaCajas.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
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