<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión de las Estaciones</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
			</head>
			<body>
				<p>&#xA0;</p>
				<p align="center">
					<table width="358" border="0" style="; width: 358px; height: 80px">
						<thead>
							<tr>
								<td width="50%">
									<p align="center">
										<img hspace="0" src="imagenes/Estaciones.PNG" align="baseline" border="0" width="100px" height="100px"/>
									</p>
								</td>
								<td width="50%">
									<p align="center">
										<font class="tituloAzulClaro">
											<strong>Gestión de las Estaciones</strong>
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
											<xsl:value-of select="ConsultaEstacionesOutput/Sesion/ClienteNombre"/>
										</strong>
									</p>
								</td>
							</tr>
						</tbody>
					</table>
				</p>
				<p>
					<td>
						<div align="center">
							<input name="BtnCerrar" type="button" class="button_marchamos" value="CREAR ESTACION"
							       onclick="cargar(this,'Transaccion.aspx?Transaccion=AgregarEstacion&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/AgregarEstacion.xsl','Transaccion')"/>
						</div>
					</td>
				</p>
				
				<form action="--WEBBOT-SELF--" method="post">
					<table class="tablaDetalle" align="center" border="0">
						<tfoot align="center"/>
						<tbody>
							<tr class="encabezado">
								<td>
									<p align="center">
										<strong>Estación</strong>
									</p>
								</td>
								<td>
									<p align="center">
										<strong>Descripción</strong>
									</p>
								</td>
								<td>
									<p align="center">
										<strong>Dirección IP</strong>
									</p>
								</td>
								<td align="center">
									<strong>Numero Caja</strong>
								</td>

								<td align="center">
									<strong>Oficina</strong>
								</td>
								<td align="center">
									<strong>Estado</strong>
								</td>
								<td align="center">
									<strong>Usuario Asignado</strong>
								</td>
							</tr>
							<xsl:for-each select="ConsultaEstacionesOutput/Estacion/Fila">
								<tr class="detalle">
									<td>
										<p align="center">
											<a>
												<xsl:attribute name="href">Transaccion.aspx?Transaccion=ActualizarEstacion&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarEstacion.xsl&amp;Estacion=<xsl:value-of select="Estacion"/></xsl:attribute>
												<xsl:value-of select="Estacion"/>
												<img hspace="3" src="imagenes/Estacion.gif" align="center" border="0" alt="Actualizar la Estacion"/>
											</a>
										</p>
									</td>
									<td>
										<p align="Left">
											<xsl:value-of select="Descripcion"/>
										</p>
									</td>
									<td>
										<p align="Left">
											<xsl:value-of select="IP"/>
										</p>
									</td>
									<td>
										<p align="center">
											<xsl:value-of select="NumeroCaja"/>
										</p>
									</td>
									<td>
										<p align="Left">
											<xsl:value-of select="OficinaNombre"/>
										</p>
									</td>
									<td class="detalle">
										<p align="Left">
											<xsl:call-template name="Estado">
												<xsl:with-param name="Codigo" select="Estado"/>
											</xsl:call-template>
										</p>
									</td>
									<td>
										<p align="Left">
											<xsl:value-of select="Usuario_Asignado"/>
										</p>
									</td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
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
							<button onclick="AgregarEstacion();">
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
			<xsl:when test="$Codigo = 1">Activa</xsl:when>
			<xsl:when test="$Codigo = 0">Inactiva</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ConsultaUsuarios.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
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