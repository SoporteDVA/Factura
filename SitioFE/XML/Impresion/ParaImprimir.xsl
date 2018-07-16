<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:NonHtml="http://www.progress.com/StylusStudio/NonHtml" exclude-result-prefixes="NonHtml">
	<xsl:output method="html"/>

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
			</head>
			<body>
				<div align="center">
					<br/>
					<font class="tituloAzulClaro">Primeros 20 marchamos para imprimir</font>
				</div>
				<br/>
				<xsl:choose>
					<xsl:when test="ParaImprimirOutput">
						<form action="Transaccion.aspx" method="post">
							<input type="hidden" name="Transaccion" value="ImprimirMultiples"/>
							<input type="hidden" name="servidorSTX" value="infoware.STX.RC_Impresion"/>
							<input type="hidden" name="Filtro" value="XML/Impresion/ParaImprimir.xsl"/>
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
									<xsl:for-each select="ParaImprimirOutput/Fila">
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
										<input type="submit" value="Imprimir seleccionados"/>
										<br/>
										<br/>
									</div>
								</tbody>
							</table>
						</form>
					</xsl:when>
					<xsl:otherwise>
						<h1 align="center">Error:<br/>
							<xsl:choose>
								<xsl:when test="normalize-space(ParaImprimirFault/Mensaje)='' and normalize-space(ParaImprimirFault/Mensaje)=''">
								Tiempo de espera excedido.
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="ParaImprimirFault/Mensaje"/>
									<br/>
									<xsl:value-of select="ParaImprimirFault/ErrorTecnico"/>
								</xsl:otherwise>
							</xsl:choose>
						</h1>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ParaImprimir.xml" htmlbaseurl="" outputurl="" processortype="internal" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator=""/></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->