<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión de los programas de Credito por Cajas</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
			</head>
			<body>
				<p>&#xA0;</p>
				<p align="center">
					<font class="tituloAzulClaro">Gestión de Programas de Credito por Caja Virtual</font>
					<table width="358" border="0" style=" width: 358px; height: 30px">
						<thead>
							<tr>
								<!--<td width="50%">
									<p align="center">
										<img hspace="0" src="imagenes/Programas.PNG" align="baseline" border="0" width="100px" height="100px"/>
									</p>
								</td>-->
								
							</tr>
						</thead>
						<tbody>
							<tr class="detalle">
								<td class="encabezado" align="right">Cliente:</td>
								<td>
									<p align="center">
										<strong>
											<xsl:value-of select="ConsultaCajasVirtualesOutput/Sesion/ClienteNombre"/>
										</strong>
									</p>
								</td>
							</tr>
						</tbody>
					</table>
				</p>
				<!--<p>
					<td>
						<div align="center">
							<input name="BtnCerrar" class="button_marchamos" type="button" value="CREAR CAJA"
							       onclick="cargar(this,'Transaccion.aspx?Transaccion=AgregarCaja&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/AgregarCaja.xsl','Transaccion')"/>
						</div>
					</td>
				</p>-->
				<form action="--WEBBOT-SELF--" method="post">
					<p>
						<table class="tablaDetalle" align="center" border="0">
							<tfoot align="center"/>
							<tbody>
								<tr class="encabezado">
									<td>
										<p align="center">
											<strong>Numero Caja</strong>
										</p>
									</td>
									<td>
										<p align="center">
											<strong>Recaudador</strong>
										</p>
									</td>
									<td>
										<p align="center">
											<strong>Descripción</strong>
										</p>
									</td>
									<td align="center">
										<strong>Usuario INS</strong>
									</td>
									<td align="center">
										<strong>Estado</strong>
									</td>
									<td align="center">
										<strong>Tipo CAJA</strong>
									</td>
								</tr>
								<xsl:for-each select="ConsultaCajasVirtualesOutput/Cajas/Fila">
									<tr class="detalle">
										<td>
											<p align="center">
												<a>
													<xsl:attribute name="href">Transaccion.aspx?Transaccion=ConsultaProgramas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaProgramas.xsl&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/></xsl:attribute>
													<xsl:value-of select="NumeroCaja"/>
													<img hspace="1" src="imagenes/Caja.gif" align="center" border="0" alt="Agregar Consecutivos a la Caja"/>
												</a>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:value-of select="Recaudador"/>
											</p>
										</td>
										<td>
											<p align="Left">
												<xsl:value-of select="Descripcion"/>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:value-of select="Usuario_INS"/>
											</p>
										</td>

										<td class="detalle">
											<p align="right">
												<xsl:call-template name="Estado">
													<xsl:with-param name="Codigo" select="Estado"/>
												</xsl:call-template>
											</p>
										</td>
										<td>
											<p align="center">
													<strong>Virtual</strong>
											</p>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</p>

					<!--<xsl:call-template name="Botones"/>-->
				</form>

				<p>&#xA0;</p>
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
			<xsl:when test="$Codigo = 1">Activo</xsl:when>
			<xsl:when test="$Codigo = 0">Inactivo</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ConsultaCajas.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
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