<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:NonHtml="http://www.progress.com/StylusStudio/NonHtml" exclude-result-prefixes="NonHtml">
	<xsl:output method="html"/>

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
			</head>
			<body>
				<p align="center">
					<table border="0">
						<tbody>
							<tr>
								<td width="50%">
									<p align="center">
										<img align="baseline" src="imagenes/Imprimir.png" border="0" hspace="0" height="60" width="60"/>
									</p>
								</td>
								<td width="50%">
									<p align="center">
										<font class="tituloAzulClaro">
											<strong>Gestión y Control de Impresion Masiva</strong>
										</font>
									</p>
								</td>
							</tr>
							
						</tbody>
					</table>
				</p>
				<xsl:choose>
					<xsl:when test="ParaImprimirVirtualOutput">
						<form action="Transaccion.aspx" method="post">
							<input type="hidden" name="Transaccion" value="ImprimirMultiplesVirtual"/>
							<input type="hidden" name="servidorSTX" value="infoware.STX.RC_Impresion"/>
							<input type="hidden" name="Filtro" value="XML/virtual/ParaImprimir.xsl"/>
							<table class="tabla" align="center">
								<tbody>
									<tr class="etiqueta">
										<td>Imprimir</td>
										<td>Fecha</td>
										<td>Usuario</td>
										<td>No.Documento</td>
										<td>Placa</td>
										<td>IP</td>
										<td>Monto</td>
									</tr>
									<xsl:for-each select="ParaImprimirVirtualOutput/Fila">
										<tr class="detalle">
											<td>
												<input type="checkbox" name="IDPago" value="{concat(Oficina,'+',Usuario,'+',NumeroDocumento,'+',DiaPago,'+',IP,'+',IDPermiso)}" checked="true"/>
											</td>
											<td>
												<xsl:value-of select="Fecha"/>
											</td>
											<td>
												<xsl:value-of select="Usuario"/>
											</td>
											<td align="center">
												<xsl:value-of select="NumeroDocumento"/>
											</td>
											<td>
												<xsl:value-of select="TipoPlaca"/>-
												<xsl:value-of select="NumeroPlaca"/>
											</td>
											<td>
												<xsl:value-of select="IP"/>
											</td>
											<td class="detalleNumerico">
												<xsl:value-of select="format-number(TotalPago,'#,##0.00')"/>
											</td>
										</tr>
									</xsl:for-each>
									<div align="center">
										<input class="button_red" type="submit" value="Imprimir seleccionados"/>
										<br/>
										<br/>
									</div>
								</tbody>
							</table>
						</form>
					</xsl:when>
					
					<xsl:otherwise>
					
						<div align="center">
						<table class="tablaDetalle" align="center" border="0">
							<tr class="encabezado">
								<!--<td width="50%">
									<p align="center">
										<strong>Mensaje:</strong>
									</p>
								</td>-->
								<td width="50%">
									<p align="center">
										<strong>
											<xsl:value-of select="ParaImprimirVirtualFault/Respuesta"/>
										</strong>
									</p>
								</td>
							</tr>
							</table>
						
					</div>
				  
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ParaImprimir.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
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