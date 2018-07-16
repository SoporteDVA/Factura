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
								<img align="baseline" src="imagenes/Estaciones.PNG" border="0" hspace="0" height="60"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Asignación de los Usuarios</font>
						</td>
					</tr>
				</table>
				<br/>
				<xsl:choose>
					<xsl:when test="AsignarUsuariosOutput">
						<xsl:apply-templates select="AsignarUsuariosOutput"/>
					</xsl:when>
					<xsl:when test="DVAAsignarUsuariosOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAAsignarUsuariosOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAAsignarUsuariosFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAAsignarUsuariosFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al Asignar el Usuario.
								<br/>
								<xsl:value-of select="AsignarUsuariosFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="AsignarUsuariosOutput">
		<table class="tabla" align="center">
			<tr class="etiqueta">
				<td>Cliente:</td>
				<td class="detalle">
					<xsl:value-of select="Sesion/ClienteNombre"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td>Estación a Asignar:</td>
				<td class="detalle">
					<xsl:value-of select="Estacion"/>
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
								<strong>Usuario</strong>
							</p>
						</td>
						<td>
							<p align="center">
								<strong>Nombre</strong>
							</p>
						</td>
						<td>
							<p align="center">
								<strong>Cliente</strong>
							</p>
						</td>
						<td align="center">
							<strong>Oficina</strong>
						</td>
						<td align="center">
							<strong>Estado</strong>
						</td>
					</tr>
					<xsl:for-each select="Usuarios/Fila">
						<tr class="detalle">
							<td>
								<p align="center">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=DVAAsignarEstaciones&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/AsignarUsuario.xsl&amp;Estacion=<xsl:value-of select="../../Estacion"/>&amp;Usuario=<xsl:value-of select="Usuario"/></xsl:attribute>
										<xsl:value-of select="Usuario"/>
									</a>
								</p>
							</td>
							<td>
								<p align="center">
									<xsl:value-of select="Nombre"/>
								</p>
							</td>
							<td>
								<p align="center">
									<xsl:value-of select="Cliente"/>
								</p>
							</td>
							<td>
								<p align="center">
									<xsl:value-of select="Oficina"/>
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
			<input name="BtnCerrar" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaEstaciones&amp;servidorSTX=infoware.STX.Admin&amp;Accion=Todos&amp;Filtro=~/XML/Gestion/ConsultaEstaciones.xsl','Transaccion')"/>
		</div>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="AsignarUsuarios.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
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