<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes" encoding="utf-8"/>
	<xsl:template match="/">
		<html>
			<head>
				<meta http-equiv="Pragma" content="no-cache"/>
				<link rel="stylesheet" type="text/css" href="STestilos.css"/>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"></script>
				<script src="codigo/dist_geo.js" language="javascript" type="text/javascript"></script>
			</head>
			<body>

				<table align="center" width="500" border="0">
					<tr>
						<td width="50%">
							<p align="center">
								<img align="baseline" src="imagenes/ins.gif" border="0" hspace="0" height="60"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Asignación de las Estaciones</font>
						</td>
					</tr>
				</table>
				<br/>
				<xsl:choose>
					<xsl:when test="AsignarEstacionesOutput">
						<xsl:apply-templates select="AsignarEstacionesOutput"/>
					</xsl:when>
					<xsl:when test="DVAAsignarEstacionesOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAAsignarEstacionesOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAAsignarEstacionesFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAAsignarEstacionesFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al Asignar la Estación.
								<br/>
								<xsl:value-of select="AsignarEstacionesFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="AsignarEstacionesOutput">
		<table class="tabla" align="center">
			<tr class="etiqueta">
				<td>Cliente:</td>
				<td class="detalle">
					<xsl:value-of select="Sesion/ClienteNombre"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td> Usuario a Asignar:</td>
				<td class="detalle">
					<xsl:value-of select="Usuario"/>
				</td>
			</tr>
		</table>
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
					</tr>
					<xsl:for-each select="Estaciones/Fila">
						<tr class="detalle">
							<td>
								<p align="center">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=DVAAsignarEstaciones&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/AsignarUsuario.xsl&amp;Usuario=<xsl:value-of select="../../Usuario"/>&amp;Estacion=<xsl:value-of select="Estacion"/></xsl:attribute>
										<xsl:value-of select="Estacion"/>
									</a>
								</p>
							</td>
							<td>
								<p align="center">
									<xsl:value-of select="Descripcion"/>
								</p>
							</td>
							<td>
								<p align="center">
									<xsl:value-of select="IP"/>
								</p>
							</td>
							<td>
								<p align="center">
									<xsl:value-of select="NumeroCaja"/>
								</p>
							</td>
							<td>
								<p align="center">
									<xsl:value-of select="Oficina"/>
								</p>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
			<br/>
		</form>
	</xsl:template>
	<xsl:template name="MostrarMensaje">
		<xsl:param name="Mensaje" select="."/>
		<div align="center">
			<br/>
			<font class="tituloAzulClaro">
				<xsl:value-of select="$Mensaje"/>
			</font>
			<br/>
			<br/>
			<input name="BtnCerrar" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaPerfiles&amp;servidorSTX=infoware.STX.Admin&amp;Accion=Todos&amp;Filtro=~/XML/Gestion/ConsultaUsuarios.xsl','Transaccion')"/>
		</div>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2007. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ObtenerEstacionesPendientes.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="" ><advancedProp name="sInitialMode" value=""/><advancedProp name="bXsltOneIsOkay" value="true"/><advancedProp name="bSchemaAware" value="true"/><advancedProp name="bXml11" value="false"/><advancedProp name="iValidation" value="0"/><advancedProp name="bExtensions" value="true"/><advancedProp name="iWhitespace" value="0"/><advancedProp name="sInitialTemplate" value=""/><advancedProp name="bTinyTree" value="true"/><advancedProp name="bWarnings" value="true"/><advancedProp name="bUseDTD" value="false"/><advancedProp name="iErrorHandling" value="fatal"/></scenario></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->