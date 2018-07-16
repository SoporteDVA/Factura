<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes" encoding="UTF-8"/>
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
								<img src="imagenes/Oficinas.PNG" align="baseline" border="0" width="100px" height="100px"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Gestión de Oficinas</font>
						</td>
					</tr>
				</table>
			
				<xsl:choose>
					<xsl:when test="ActualizarOficinaOutput">
						<xsl:for-each select="ActualizarOficinaOutput">
							<xsl:call-template name="ActualizarOficinaOutput"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="DVAModificarOficinasOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAModificarOficinasOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAModificarOficinasFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAModificarOficinasFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAEliminarOficinasOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAEliminarOficinasOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAEliminarOficinasFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAEliminarOficinasFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al agregar la Oficina.
								<br/>
								<xsl:value-of select="ActualizarOficinaFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="ActualizarOficinaOutput">
		<table class="tabla" align="center">
			<tr class="etiqueta">
				<td>Cliente:</td>
				<td class="detalle">
					<xsl:value-of select="Sesion/ClienteNombre"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Usuario:</td>
				<td class="detalle">
					<xsl:value-of select="Sesion/UsuarioNombre"/>
				</td>
			</tr>
		</table>
		<xsl:choose>
			<xsl:when test="Accion='Editar'">
				<xsl:call-template name="Actualizar"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="Ver"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Actualizar">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="DVAModificarOficinas"/>
			<input type="hidden" name="Filtro" value="XML/Gestion/ActualizarOficina.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Información de la Oficina</div>
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">Codigo :</td>
					<td class="detalle" colSpan="3">
						<input name="Oficina" value="{Fila/ID}" onkeypress="return soloNumeros(event)" maxlength="4">
						</input>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Nombre Oficina :</td>
					<td class="detalle" colSpan="3">
						<input name="Nombre" value="{Fila/Nombre}" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Descripción :</td>
					<td class="detalle" colSpan="3">
						<input name="Descripcion" value="{Fila/Descripcion}" size="36"/>
					</td>
				</tr>
					<tr>
					<td class="etiqueta">Estado :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Estado">
							<OPTION VALUE="1">Activo</OPTION>
							<OPTION VALUE="0">Inactivo</OPTION>
						</SELECT>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonSalvar" class="button_red" type="submit" value="      Guardar      "/>
				<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ObtenerOficinas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaOficinas.xsl','Transaccion')"/>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="Ver">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="ActualizarOficina"/>
			<input type="hidden" name="Accion" value="Editar"/>
			<input type="hidden" name="Oficina" value="{Fila/ID}"/>
			<input type="hidden" name="Filtro" value="~/XML/Gestion/ActualizarOficina.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>

			<!-- Revisar estos valores -->
			<!-- -->
			<p>
			<div align="center" class="tituloAzulClaro">Información de la Oficina</div>
			</p>
			<p>
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">Codigo :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/ID"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Nombre Oficina :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/Nombre"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Descripción :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/Descripcion"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Estado :</td>
					<td colspan="3" class="detalle">
						<xsl:call-template name="Estado">
							<xsl:with-param name="Codigo" select="Fila/Estado"/>
						</xsl:call-template>
					</td>
				</tr>
			</table>
			</p>
			<br/>
			<div align="center">
				<input name="BotonEditar" class="button_red" type="submit" value="      Editar      "/>
				<input name="BtnEliminar" class="button_delete" type="button" value="      Eliminar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=DVAEliminarOficinas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarOficina.xsl&amp;Oficina={Fila/ID}','Transaccion')"/>
				<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ObtenerOficinas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaOficinas.xsl','Transaccion')"/>
			</div>
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
			<input name="BtnCerrar" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ObtenerOficinas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaOficinas.xsl','Transaccion')"/>
		</div>
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ActualizarOficina.xml" htmlbaseurl="http://192.168.1.110/" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="ActualizarOficina.xml" srcSchemaRoot="ActualizarOficinaOutput" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="/">
				<block path="html/body/xsl:choose" x="158" y="0"/>
				<block path="html/body/xsl:choose/xsl:when/xsl:for-each" x="268" y="17"/>
				<block path="html/body/xsl:choose/xsl:when/xsl:for-each/xsl:call-template" x="218" y="47"/>
				<block path="html/body/xsl:choose/xsl:otherwise/center/h1/xsl:value-of" x="178" y="47"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->