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
								<img src="imagenes/Recaudador.PNG"  align="baseline" border="0" width="100px" height="100px"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Gestión del Recaudador</font>
						</td>
					</tr>
				</table>
				<br/>
				<xsl:choose>
					<xsl:when test="ActualizaRecaudadorOutput">
						<xsl:for-each select="ActualizaRecaudadorOutput">
							<xsl:call-template name="ActualizaRecaudadorOutput"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="DVAModificarRecaudadorOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAModificarRecaudadorOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAModificarRecaudadorFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAModificarRecaudadorFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al Actualizar el Cliente.
								<br/>
								<xsl:value-of select="ActualizaRecaudadorFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="ActualizaRecaudadorOutput">
		<table class="tabla" align="center">
			<tr class="etiqueta">
				<td>Cliente:</td>
				<td class="detalle">
					<xsl:value-of select="Sesion/ClienteNombre"/>
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
		<form action="Transaccion.aspx" method="post">
			<input type="hidden" name="Transaccion" value="DVAModificarRecaudador"/>
			<input type="hidden" name="Filtro" value="~/XML/Gestion/ActualizarRecaudador.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Información del Cliente</div>
			<br/>
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">Nombre :</td>
					<td class="detalle" colSpan="3">
						<input name="Nombre" value="{Fila/Nombre}" maxlength="200">
						</input>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Codigo RC :</td>
					<td class="detalle" colSpan="3">
						<input name="CodigoGrupoRC" value="{Fila/CodigoGrupoRC}" size="8"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Recaudador RC :</td>
					<td class="detalle" colSpan="3">
						<input name="RecaudadorRC" value="{Fila/RecaudadorRC}" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Numero Caja RC :</td>
					<td class="detalle" colSpan="3">
						<input name="NumeroCajaRC" value="{Fila/NumeroCajaRC}" onkeypress="return solonumeros(event);" size="8"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Usuario INSRC :</td>
					<td class="detalle" colSpan="3">
						<input name="Usuario_INSRC" value="{Fila/Usuario_INSRC}" size="36"/>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonSalvar" class="button_red" type="submit" value="      Guardar      "/>
				<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaRecaudador&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaRecaudador.xsl','Transaccion')"/>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="Ver">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="ActualizaRecaudador"/>
			<input type="hidden" name="Accion" value="Editar"/>
			<input type="hidden" name="Cliente" value="{Sesion/Cliente}"/>
			<input type="hidden" name="Filtro" value="~/XML/Gestion/ActualizarRecaudador.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>

			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Información de la Caja</div>
			<br/>
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">Nombre :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/Nombre"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Codigo RC :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/CodigoGrupoRC"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Recaudador RC :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/RecaudadorRC"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Numero Caja RC :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/NumeroCajaRC"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Usuario INSRC :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/Usuario_INSRC"/>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonEditar" class="button_red" type="submit" value="      Editar      "/>
				<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaRecaudador&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaRecaudador.xsl','Transaccion')"/>
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
			<input name="BtnCerrar" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaRecaudador&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaRecaudador.xsl','Transaccion')"/>
		</div>
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
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->