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
								<img src="imagenes/Usuarios.PNG" align="baseline" border="0" width="100px" height="100px"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Gestión de los Usuarios</font>
						</td>
					</tr>
				</table>
				<br/>
				<xsl:choose>
					<xsl:when test="AgregarPerfilOutput">
						<xsl:apply-templates select="AgregarPerfilOutput"/>
					</xsl:when>
					<xsl:when test="DVAAgregaPerfilOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAAgregaPerfilOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAAgregaPerfilFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAAgregaPerfilFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al agregar el Usuario.
								<br/>
								<xsl:value-of select="AgregarPerfilFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="AgregarPerfilOutput">
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
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="DVAAgregaPerfil"/>
			<input type="hidden" name="Filtro" value="XML/Gestion/AgregarUsuario.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Información del Nuevo Usuario</div>
		 
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">Usuario :</td>
					<td class="detalle" colSpan="3">
						<input name="Usuario" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Nombre :</td>
					<td class="detalle" colSpan="3">
						<input name="Nombre" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Oficina :</td>
					<td colspan="3" class="detalle">
						<select class="campo" name="Oficina">
							<xsl:for-each select="Oficinas/Fila">
								<option value="{ID}" selected="true">
									<xsl:value-of select="ID"/>/  <xsl:value-of select="Nombre"/></option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Autoriza Reversión :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="AutorizaReversion">
							<OPTION VALUE="1">Si</OPTION>
							<OPTION VALUE="0">No</OPTION>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Activa Bloques :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="ActivaBloque">
							<OPTION VALUE="1">Si</OPTION>
							<OPTION VALUE="0">No</OPTION>
						</SELECT>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonSalvar" class="button_red"  type="submit" value="      Guardar      "/>
				<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaPerfiles&amp;servidorSTX=infoware.STX.Admin&amp;Accion=Todos&amp;Filtro=~/XML/Gestion/ConsultaUsuarios.xsl','Transaccion')"/>
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
			<input name="BtnCerrar" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaPerfiles&amp;servidorSTX=infoware.STX.Admin&amp;Accion=Todos&amp;Filtro=~/XML/Gestion/ConsultaUsuarios.xsl','Transaccion')"/>
		</div>
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