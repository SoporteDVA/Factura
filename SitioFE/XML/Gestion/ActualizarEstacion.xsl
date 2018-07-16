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
								<img src="imagenes/Estaciones.PNG" align="baseline" border="0" width="100px" height="100px"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Gestión de las Estaciones</font>
						</td>
					</tr>
				</table>
				
				<xsl:choose>
					<xsl:when test="ActualizarEstacionOutput">
						<xsl:for-each select="ActualizarEstacionOutput">
							<xsl:call-template name="ActualizarEstacionOutput"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="DVAModificarEstacionesOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAModificarEstacionesOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAModificarEstacionesFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAModificarEstacionesFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVADesAsignarEstacionesOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVADesAsignarEstacionesOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAEliminarEstacionesOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAEliminarEstacionesOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAEliminarEstacionesFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAEliminarEstacionesFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVADVADesAsignarEstacionesFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVADVADVADesAsignarEstacionesFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al agregar la Oficina.
								<br/>
								<xsl:value-of select="ActualizarEstacionFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="ActualizarEstacionOutput">
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
			<input type="hidden" name="Transaccion" value="DVAModificarEstaciones"/>
			<input type="hidden" name="Filtro" value="XML/Gestion/ActualizarEstacion.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Información de la Estación</div>
			<br/>
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">Estación :</td>
					<td class="detalle" colSpan="3">
						<input name="Estacion" value="{Estacion}" onkeypress="return soloNumeros(event)" maxlength="4">
						</input>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Descripción :</td>
					<td class="detalle" colSpan="3">
						<input name="Descripcion" value="{Descripcion}" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Dirección IP :</td>
					<td class="detalle" colSpan="3">
						<input name="IP" value="{IP}" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Caja INS :</td>
					<td colspan="3" class="detalle">
						<select class="campo" name="NumeroCaja">
							<xsl:for-each select="Cajas/Fila[Estado=1]">
								<xsl:if test="NumeroCaja=../../NumeroCaja">
									<option value="{NumeroCaja}" selected="true">
										<xsl:value-of select="NumeroCaja"/>/  <xsl:value-of select="Descripcion"/></option>
								</xsl:if>
								<xsl:if test="NumeroCaja!=../../NumeroCaja">
									<option value="{NumeroCaja}">
										<xsl:value-of select="NumeroCaja"/>/  <xsl:value-of select="Descripcion"/></option>
								</xsl:if>
							</xsl:for-each>
						</select>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Numero de Oficina :</td>
					<td colspan="3" class="detalle">
						<select class="campo" name="Oficina">
							<xsl:for-each select="Oficinas/Fila">
								<xsl:if test="ID=../../Oficina">
									<option value="{ID}" selected="true">
										<xsl:value-of select="ID"/>/  <xsl:value-of select="Nombre"/></option>
								</xsl:if>
								<xsl:if test="ID!=../../Oficina">
									<option value="{ID}">
										<xsl:value-of select="ID"/>/  <xsl:value-of select="Nombre"/></option>
								</xsl:if>
							</xsl:for-each>
						</select>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Estado :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Estado">
							<xsl:if test="Estado=1">
								<OPTION VALUE="1" selected="true">Activa</OPTION>
								<OPTION VALUE="0">Inactiva</OPTION>
							</xsl:if>
							<xsl:if test="Estado=0">
								<OPTION VALUE="1">Activa</OPTION>
								<OPTION VALUE="0" selected="true">Inactiva</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonSalvar" class="button_red" type="submit" value="      Guardar      "/>
				<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaEstaciones&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaEstaciones.xsl','Transaccion')"/>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="Ver">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="ActualizarEstacion"/>
			<input type="hidden" name="Accion" value="Editar"/>
			<input type="hidden" name="Estacion" value="{Estacion}"/>
			<input type="hidden" name="Descripcion" value="{Descripcion}"/>
			<input type="hidden" name="IP" value="{IP}"/>
			<input type="hidden" name="NumeroCaja" value="{NumeroCaja}"/>
			<input type="hidden" name="Oficina" value="{Oficina}"/>
			<input type="hidden" name="Filtro" value="~/XML/Gestion/ActualizarEstacion.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Información de la Estación</div>
			<br/>
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">Estación :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Estacion"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Descripción :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Descripcion"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Dirección IP :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="IP"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Caja INS :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="NumeroCaja"/>/  <xsl:value-of select="CajaDescripcion"/></td>
				</tr>
				<tr>
					<td class="etiqueta">Oficina :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Oficina"/>/  <xsl:value-of select="OficinaNombre"/></td>
				</tr>
				<tr>
					<td class="etiqueta">Estado :</td>
					<td colspan="3" class="detalle">
						<xsl:call-template name="Estado">
							<xsl:with-param name="Codigo" select="Estado"/>
						</xsl:call-template>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Usuario Asignado :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Usuario_Asignado"/>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonEditar" class="button_red" type="submit" value="      Editar        "/>
				<xsl:choose>
					<xsl:when test="Usuario_Asignado = ''">
						<input name="BtnAsignar" class="button_gris"  type="button" value="       Asignar       " onclick="return CambiarTransaccion('AsignarUsuarios','~/XML/Gestion/AsignarEstacion.xsl');"/>
					</xsl:when>
					<xsl:otherwise>
						<input name="BtnDesAsignar" class="button_delete"  type="button" value="    DesAsignar    "
						       onclick="cargar(this,'Transaccion.aspx?Transaccion=DVADesAsignarEstaciones&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarEstacion.xsl&amp;Usuario={Usuario_Asignado}&amp;Estacion={Estacion}','Transaccion')"/>
					</xsl:otherwise>
				</xsl:choose>
				<input name="BtnEliminar" class="button_delete" type="button" value="      Eliminar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=DVAEliminarEstaciones&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarEstacion.xsl&amp;Oficina={Oficina}&amp;Estacion={Estacion}','Transaccion')"/>
				<input name="BtnCerrar"  class="button_gris" type="button" value="        Cerrar        " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaEstaciones&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaEstaciones.xsl','Transaccion')"/>
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
			<input name="BtnCerrar" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaEstaciones&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaEstaciones.xsl','Transaccion')"/>
		</div>
	</xsl:template>
	<xsl:template name="Estado">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 1">Activa</xsl:when>
			<xsl:when test="$Codigo = 0">Inactiva</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="ID">
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ActualizarEstacion.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
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