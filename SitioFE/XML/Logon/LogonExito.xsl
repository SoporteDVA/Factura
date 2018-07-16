<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<meta http-equiv="Pragma" content="no-cache"/>
				<link rel="stylesheet" type="text/css" href="STestilos.css"/>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"></script>
			</head>
			<xsl:choose>
				<xsl:when test="ValidarUsuarioOutput">
					<xsl:for-each select="ValidarUsuarioOutput">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<div align="center">
						<br/>
						<font class="tituloAzulClaro">
							<xsl:value-of select="ValidarUsuarioFault/Respuesta"/>
						</font>
						<br/>
						<br/>
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</html>
	</xsl:template>
	<xsl:template name="Consulta">
		<body>
			<form action="Transaccion.aspx" method="post">
				<input type="hidden" name="Transaccion" value="ValidarUsuario"/>
				<input type="hidden" name="Filtro" value="XML/Logon/LogonExito.xsl"/>
				<br/>
				<table align="center" width="500" border="0">
					<tr>
						<td width="50%">
							<p align="center">
								<img align="baseline" src="imagenes/ins.gif" border="0" hspace="0" height="60"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Logon Sistema SICC</font>
						</td>
					</tr>
				</table>
				<br/>
				<table class="tabla" align="center">
					<tr>
						<td class="etiqueta">Usuario :</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Sesion/UsuarioNombre"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Resultado :</td>
						<td class="detalle" colSpan="3">
							<xsl:value-of select="Respuesta"/>
						</td>
					</tr>
				</table>
				<br/>
				<br/>
				<div align="center">
					<input name="Consultar" type="button" value="Consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaClasePlaca&amp;Filtro=~/XML/INS/INSConsultar.xsl','Transaccion');"/>
				</div>
			</form>
		</body>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ConsultaClasePlacaOutput.xml" htmlbaseurl="" outputurl="" processortype="internal" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="" ><advancedProp name="sInitialMode" value=""/><advancedProp name="bXsltOneIsOkay" value="true"/><advancedProp name="bSchemaAware" value="true"/><advancedProp name="bXml11" value="false"/><advancedProp name="iValidation" value="0"/><advancedProp name="bExtensions" value="true"/><advancedProp name="iWhitespace" value="0"/><advancedProp name="sInitialTemplate" value=""/><advancedProp name="bTinyTree" value="true"/><advancedProp name="bWarnings" value="true"/><advancedProp name="bUseDTD" value="false"/><advancedProp name="iErrorHandling" value="fatal"/></scenario></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->