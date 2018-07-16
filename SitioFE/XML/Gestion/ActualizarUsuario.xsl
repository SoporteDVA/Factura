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
								<img src="imagenes/Usuarios.PNG" align="baseline" border="0" width="100px" height="100px"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Gestión del Usuario</font>
						</td>
					</tr>
				</table>
				<br/>
				<xsl:choose>
					<xsl:when test="ActualizarPerfilOutput">
						<xsl:for-each select="ActualizarPerfilOutput">
							<xsl:call-template name="ActualizarPerfilOutput"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="DVAModificaPerfilOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAModificaPerfilOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAEliminaPerfilOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAEliminaPerfilOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVADesAsignarUsuariosOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVADesAsignarUsuariosOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAModificaPerfilFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAModificaPerfilFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAEliminaPerfilFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAEliminaPerfilFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVADesAsignarUsuariosFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVADesAsignarUsuariosFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al Actualizar el Usuario.
								<br/>
								<xsl:value-of select="ActualizarPerfilFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="ActualizarPerfilOutput">
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
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="DVAModificaPerfil"/>
			<input type="hidden" name="Filtro" value="XML/Gestion/ActualizarUsuario.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Información del Usuario</div>
			 
			<xsl:for-each select="Usuario">
				<table align="center" class="tabla">
					<tr>
						<td class="etiqueta">Usuario :</td>
						<td class="detalle" colSpan="3">
							<input name="Usuario" value="{Usuario}" maxlength="200">
							</input>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre :</td>
						<td class="detalle" colSpan="3">
							<input name="Nombre" value="{Nombre}" size="50" maxlength="200"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Oficina :</td>
						<td class="detalle" colSpan="3">
							<select class="campo" name="Oficina">
								<xsl:for-each select="../Oficinas/Fila">
									<xsl:if test="ID=../../Usuario/Oficina">
										<option value="{ID}" selected="selected">
											<xsl:value-of select="ID"/>/  <xsl:value-of select="Nombre"/></option>
									</xsl:if>
									<xsl:if test="ID!=../../Usuario/Oficina">
										<option value="{ID}">
											<xsl:value-of select="ID"/>/ <xsl:value-of select="Nombre"/></option>
									</xsl:if>
								</xsl:for-each>
							</select>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Autoriza Reversión :</td>
						<td colspan="3" class="detalle">
							<SELECT class="inputAzul" NAME="AutorizaReversion">
								<xsl:if test="AutorizaReversion=1">
									<OPTION VALUE="1" selected="true">Si</OPTION>
									<OPTION VALUE="0">No</OPTION>
								</xsl:if>
								<xsl:if test="AutorizaReversion=0">
									<OPTION VALUE="1">Si</OPTION>
									<OPTION VALUE="0" selected="true">No</OPTION>
								</xsl:if>
							</SELECT>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Estado :</td>
						<td colspan="3" class="detalle">
							<SELECT class="inputAzul" NAME="Estado">
								<xsl:if test="Estado=1">
									<OPTION VALUE="1" selected="true">Activo</OPTION>
									<OPTION VALUE="0">Inactivo</OPTION>
								</xsl:if>
								<xsl:if test="Estado=0">
									<OPTION VALUE="1">Activo</OPTION>
									<OPTION VALUE="0" selected="true">Inactivo</OPTION>
								</xsl:if>
							</SELECT>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Activa Bloque :</td>
						<td colspan="3" class="detalle">
							<SELECT class="inputAzul" NAME="ActivaBloque">
								<xsl:if test="ActivaBloque=1">
									<OPTION VALUE="1" selected="true">Activo</OPTION>
									<OPTION VALUE="0">Inactivo</OPTION>
								</xsl:if>
								<xsl:if test="ActivaBloque=0">
									<OPTION VALUE="1">Activo</OPTION>
									<OPTION VALUE="0" selected="true">Inactivo</OPTION>
								</xsl:if>
							</SELECT>
						</td>
					</tr>
				</table>
			</xsl:for-each>
			<br/>
			<div align="center">
				<input name="BotonSalvar" class="button_red"  type="submit" value="      Guardar      "/>
				<input name="BtnCerrar" class="button_gris"  type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaPerfiles&amp;servidorSTX=infoware.STX.Admin&amp;Accion=Todos&amp;Filtro=~/XML/Gestion/ConsultaUsuarios.xsl','Transaccion')"/>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="Ver">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="ActualizarPerfil"/>
			<input type="hidden" name="Accion" value="Editar"/>
			<input type="hidden" name="Usuario" value="{Usuario/Usuario}"/>
			<input type="hidden" name="Oficina" value="{Usuario/Oficina}"/>
			<input type="hidden" name="OficinaNombre" value="{Usuario/NombreOficina}"/>
			<input type="hidden" name="UsuarioNombre" value="{Usuario/Nombre}"/>
			<input type="hidden" name="Filtro" value="~/XML/Gestion/ActualizarUsuario.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>

			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Información del Usuario</div>
			<br/>
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">Usuario :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Usuario/Usuario"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Nombre :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Usuario/Nombre"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Oficina :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Usuario/Oficina"/>/  <xsl:value-of select="Usuario/NombreOficina"/></td>
				</tr>
				<tr>
					<td class="etiqueta">Autoriza Reversión :</td>
					<td colspan="3" class="detalle">
						<xsl:call-template name="AutorizaReversion">
							<xsl:with-param name="Codigo" select="Usuario/AutorizaReversion"/>
						</xsl:call-template>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Estación Asignada :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Usuario/Estacion"/>/  <xsl:value-of select="Usuario/Estacion_Asignada"/></td>
				</tr>
				<tr>
					<td class="etiqueta">Estado :</td>
					<td colspan="3" class="detalle">
						<xsl:call-template name="Estado">
							<xsl:with-param name="Codigo" select="Usuario/Estado"/>
						</xsl:call-template>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Activa Bloque :</td>
					<td colspan="3" class="detalle">
						<xsl:call-template name="ActivaBloque">
							<xsl:with-param name="Codigo" select="Usuario/ActivaBloque"/>
						</xsl:call-template>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonEditar" class="button_red"  type="submit" value="      Editar      "/>
				<xsl:choose>
					<xsl:when test="Usuario/Estacion = ''">
						<input name="BtnAsignar" class="button_delete"  type="button" value="      Asignar      " onclick="return CambiarTransaccion('AsignarEstaciones','~/XML/Gestion/AsignarUsuario.xsl');"/>
					</xsl:when>
					<xsl:otherwise>
						<input name="BtnDesAsignar" class="button_delete"  type="button" value="      DesAsignar      "
						       onclick="cargar(this,'Transaccion.aspx?Transaccion=DVADesAsignarUsuarios&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarUsuario.xsl&amp;Estacion={Usuario/Estacion}&amp;Usuario={Usuario/Usuario}','Transaccion')"/>
					</xsl:otherwise>
				</xsl:choose>
				<input name="BtnEliminar" class="button_delete"  type="button" value="      Eliminar      "
				       onclick="cargar(this,'Transaccion.aspx?Transaccion=DVAEliminaPerfil&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarUsuario.xsl&amp;Oficina={Usuario/Oficina}&amp;Usuario={Usuario/Usuario}','Transaccion')"/>
				<input name="BtnCerrar" class="button_gris"  type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaPerfiles&amp;servidorSTX=infoware.STX.Admin&amp;Accion=Todos&amp;Filtro=~/XML/Gestion/ConsultaUsuarios.xsl','Transaccion')"/>
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
	<xsl:template name="AutorizaReversion">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 0">NO</xsl:when>
			<xsl:when test="$Codigo = 1">SI</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Estado">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 1">Activo</xsl:when>
			<xsl:when test="$Codigo = 0">Inactivo</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="ActivaBloque">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 0">NO</xsl:when>
			<xsl:when test="$Codigo = 1">SI</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ActualizarUsuario.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
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