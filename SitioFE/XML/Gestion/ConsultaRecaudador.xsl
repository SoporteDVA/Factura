<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión del Recaudador</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
				<script>function AgregarOficina(){					
						var urlImprimir='Transaccion.aspx?Transaccion=AgregarRecaudador&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/AgregarRecaudador.xsl';		 	  		    
						window.location=urlImprimir;
						return true;
					}</script>
				
			</head>
			<body>
				<p>&#xA0;</p>
				<p align="center">
					<table width="358" border="0" style="; width: 358px; height: 80px">
						<thead>
							<tr>
								<td width="50%">
									<p align="center">
										<img hspace="0" src="imagenes/Recaudador.PNG"  align="baseline" border="0" width="100px" height="100px"/>
									</p>
								</td>
								<td width="50%">
									<p align="center">
										<font class="tituloAzulClaro">
											<strong>Gestión de Recaudador</strong>
										</font>
									</p>
								</td>
							</tr>
						</thead>
						<tbody>
							<tr class="detalle">
								<td class="encabezado" align="right">Cliente:</td>
								<td>
									<p align="center">
										<strong>
											<xsl:value-of select="ConsultaRecaudadorOutput/Sesion/ClienteNombre"/>
										</strong>
									</p>
								</td>
							</tr>
						</tbody>
					</table>
				</p>

				

				<form action="--WEBBOT-SELF--" method="post">
					<table class="tablaDetalle" align="center">
						<tfoot align="center"/>
						<tbody>
							<tr class="encabezado">
								<td>
									<p align="center">
										<strong>Cliente</strong>
									</p>
								</td>
								<td>
									<p align="center">
										<strong>Nombre</strong>
									</p>
								</td>
								<td align="center">
									<strong>CodigoGrupoRC</strong>
								</td>
								<td align="center">
									<strong>RecaudadorRC</strong>
								</td>
								<td align="center">
									<strong>Numero CajaRC</strong>
								</td>
								<td align="center">
									<strong>Usario INSRC</strong>
								</td>
							</tr>
							<xsl:for-each select="ConsultaRecaudadorOutput">
								<tr class="detalle">
									<td>
										<p align="center">
											<a>
												<xsl:attribute name="href">Transaccion.aspx?Transaccion=ActualizaRecaudador&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarRecaudador.xsl&amp;Cliente=<xsl:value-of select="Sesion/Cliente"/></xsl:attribute>
												<xsl:value-of select="Sesion/Cliente"/>
											</a>
										</p>
									</td>
									<td class="detalle">
										<p align="center">
											<xsl:value-of select="Fila/Nombre"/>
										</p>
									</td>
									<td>
										<p align="left">
											<xsl:value-of select="Fila/CodigoGrupoRC"/>
										</p>
									</td>
									<td class="detalle">
										<p align="center">
											<xsl:value-of select="Fila/RecaudadorRC"/>
										</p>
									</td>
									<td class="detalle">
										<p align="center">
											<xsl:value-of select="Fila/NumeroCajaRC"/>
										</p>
									</td>
									<td class="detalle">
										<p align="center">
											<xsl:value-of select="Fila/Usuario_INSRC"/>
										</p>
									</td>
									<!--<td class="detalle">
										<p align="right">
											<xsl:call-template name="Estado">
												<xsl:with-param name="Codigo" select="Estado"/>
											</xsl:call-template>
										</p>
									</td>-->
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</form>
				<p>&#xA0;</p>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="Estado">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 1">Activo</xsl:when>
			<xsl:when test="$Codigo = 0">Inactivo</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ConsultaRecaudador.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
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