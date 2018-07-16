<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
			</head>
			<xsl:choose>
				<xsl:when test="LogonOutput">
					<xsl:for-each select="LogonOutput">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>				
				<xsl:otherwise>
					<div align="center">
						<br/>
						<font class="tituloAzulClaro">
							<xsl:value-of select="LogonFault/Respuesta"/>
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
				<input type="hidden" name="servidorSTX" value="infoware.STX.Seguro"/>			
				<input type="hidden" name="UsuarioIDExterno" value="{normalize-space(substring-before(Sesion/UsuarioNombre,'-'))}"/>	
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
						<td colSpan="3" class="detalle"><xsl:value-of select="Sesion/UsuarioNombre"/>							
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Clave :</td>
						<td colSpan="3">
							<input size="20" name="Clave" maxlength="20" type="password" ID="Clave"/>						
						</td>
					</tr>					
				</table>
				<br/>
				<br/>
				<div align="center">
					<input name="Consultar" type="button" value="Consulta" onclick="submit();"/>
				</div>
			</form>
		</body>
	</xsl:template>	
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ConsultaClasePlacaOutput.xml" htmlbaseurl="" outputurl="" processortype="internal" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="" ><advancedProp name="sInitialMode" value=""/><advancedProp name="bSchemaAware" value="true"/><advancedProp name="bXsltOneIsOkay" value="true"/><advancedProp name="bXml11" value="false"/><advancedProp name="iValidation" value="0"/><advancedProp name="bExtensions" value="true"/><advancedProp name="iWhitespace" value="0"/><advancedProp name="sInitialTemplate" value=""/><advancedProp name="bTinyTree" value="true"/><advancedProp name="bUseDTD" value="false"/><advancedProp name="bWarnings" value="true"/><advancedProp name="iErrorHandling" value="fatal"/></scenario></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->