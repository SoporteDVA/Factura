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
								<img src="imagenes/Cajas.PNG" align="baseline" border="0" width="60px" height="60px"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Gestión de las Cajas</font>
						</td>
					</tr>
				</table>
				<br/>
				<xsl:choose>
					<xsl:when test="ActualizarCajasOutput">
						<xsl:for-each select="ActualizarCajasOutput">
							<xsl:call-template name="ActualizarCajasOutput"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="DVAModificarCajasOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAModificarCajasOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>

					<xsl:when test="DVAModificarCajasFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAModificarCajasFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAEliminarCajasOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAEliminarCajasOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAEliminarCajasFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAEliminarCajasFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al agregar la Caja.
								<br/>
								<xsl:value-of select="ActualizarCajasFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="ActualizarCajasOutput">
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
				<xsl:call-template name="Actualizar"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Actualizar">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="DVAModificarCajas"/>
			<input type="hidden" name="Filtro" value="XML/Gestion/ActualizarCaja.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Información de la Caja</div>
			<br/>
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">Numero Caja :</td>
					<td class="detalle" colSpan="3">
						<input name="NumeroCaja" size="15" value="{Fila/NumeroCaja}" onkeypress="return soloNumeros(event)" maxlength="4">
						</input>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Recaudador :</td>
					<td class="detalle" colSpan="3">
						<input name="Recaudador" value="{Fila/Recaudador}" size="15"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Usuario INS :</td>
					<td class="detalle" colSpan="3">
						<input name="Usuario_INS" value="{Fila/Usuario_INS}" size="15"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Descripción :</td>
					<td class="detalle" colSpan="3">
						<input name="Descripcion" value="{Fila/Descripcion}" size="50"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Estado :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Estado">
							<option value="{Fila/Estado}" selected="selected">
								<xsl:call-template name="Estado">
									<xsl:with-param name="Codigo" select="Fila/Estado"/>
								</xsl:call-template>
							</option>
							<xsl:if test="Fila/Estado=1">
								<OPTION VALUE="0">Inactivo</OPTION>
							</xsl:if>
							<xsl:if test="Fila/Estado=0">
								<OPTION VALUE="1">Activo</OPTION>
							</xsl:if>
							<xsl:if test="Fila/Estado=''">
								<OPTION VALUE="1" selected="selected">Activo</OPTION>
								<OPTION VALUE="0">Inactivo</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>


				<tr>
					<td class="etiqueta">Tipo CAJA BAC :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="TIPO_CAJA">
							<option value="{Fila/tipo_caja}" selected="selected">
								<xsl:call-template name="TipoCajaBAC">
									<xsl:with-param name="TipoCaja" select="Fila/tipo_caja"/>
								</xsl:call-template>
							</option>
							<xsl:if test="Fila/tipo_caja=2">
								<OPTION VALUE="1">Regular</OPTION>
								
							</xsl:if>
							<xsl:if test="Fila/tipo_caja=1">
								<OPTION VALUE="2">Virtual</OPTION>
								
							</xsl:if>
							<xsl:if test="Fila/tipo_caja=''">
								<OPTION VALUE="1" selected="selected">Regular</OPTION>
								<OPTION VALUE="2">Virtual</OPTION>
								
							</xsl:if>
						</SELECT>
					</td>
				</tr>


				<tr>
					<td class="etiqueta">CTA Destino :</td>
					<td class="detalle" colSpan="3">
						<input name="NUMERO_CUENTA_DESTINO" value="{Fila/numero_cuenta_destino}" size="15" maxlength="15"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Codigo BAC :</td>
					<td class="detalle" colSpan="3">
						<input name="CODIGO_BANCO" value="{Fila/codigo_banco}" size="15" maxlength="15"/>
					</td>
				</tr>
				<!--<tr>
					<td class="etiqueta">Afiliado :</td>
					<td class="detalle" colSpan="3">
						<input name="NUMERO_AFILIADO" value="{Fila/numero_afiliado}" size="15" maxlength="15"/>
					</td>
				</tr>

				<tr>
					<td class="etiqueta">Terminal :</td>
					<td class="detalle" colSpan="3">
						<input name="NUMERO_TERMINAL" value="{Fila/numero_terminal}" size="15" maxlength="15"/>
					</td>
				</tr>-->
				<tr>
					<td class="etiqueta">Tipo Envio BAC :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="TIPO_ENVIO">
							<option value="{Fila/tipo_envio}" selected="selected">
								<xsl:call-template name="TipoEnvioBAC">
									<xsl:with-param name="TipoEnvio" select="Fila/tipo_envio"/>
								</xsl:call-template>
							</option>
							<xsl:if test="Fila/tipo_envio=1">
								<OPTION VALUE="0">Domicilio SEC</OPTION>
								<OPTION VALUE="2">Domicilio CAT</OPTION>
							</xsl:if>
							<xsl:if test="Fila/tipo_envio=0">
								<OPTION VALUE="1">Sucursal</OPTION>
								<OPTION VALUE="2">Domicilio CAT</OPTION>
							</xsl:if>
							<xsl:if test="Fila/tipo_envio=2">
								<OPTION VALUE="1">Sucursal</OPTION>
								<OPTION VALUE="0">Domicilio SEC</OPTION>
							</xsl:if>
							<xsl:if test="Fila/tipo_envio=''">
								<OPTION VALUE="0" selected="selected">Domicilio SEC</OPTION>
								<OPTION VALUE="1">Sucursal</OPTION>
								<OPTION VALUE="2">Domicilio CAT</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonSalvar" class="button_red" type="submit" value="      Guardar      "/>
				<!--<input name="BotonSalvar" type="submit" value="      Salvar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=DVAModificarCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarCaja.xsl','Transaccion')"/>-->
				<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajas.xsl','Transaccion')"/>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="Ver">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="ActualizarCajas"/>
			<input type="hidden" name="Accion" value="Editar"/>
			<input type="hidden" name="NumeroCaja" value="{Fila/NumeroCaja}"/>
			<input type="hidden" name="Filtro" value="~/XML/Gestion/ActualizarCaja.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>

			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Información de la Caja</div>
			<br/>
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">Numero Caja :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/NumeroCaja"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Recaudador :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/Recaudador"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Usuario INS :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/Usuario_INS"/>
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

				<tr>
					<td class="etiqueta">Tipo CAJA BAC :</td>
					<td class="detalle" colSpan="3">

						<xsl:call-template name="TipoCajaBAC">
							<xsl:with-param name="TipoCaja" select="Fila/tipo_caja"/>
						</xsl:call-template>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">CTA Destino :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/numero_cuenta_destino"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Codigo BAC :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/codigo_banco"/>
					</td>
				</tr>
				<!--<tr>
					<td class="etiqueta">Afiliado :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/numero_afiliado"/>
					</td>
				</tr>

				<tr>
					<td class="etiqueta">Terminal :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/numero_terminal"/>
					</td>
				</tr>-->

				<!--<tr>
					<td class="etiqueta">Tipo Envio :</td>
					<td class="detalle" colSpan="3">
						<xsl:value-of select="Fila/tipo_envio"/>
					</td>
				</tr>-->
				<tr>
					<td class="etiqueta">Tipo Envio  :</td>
					<td class="detalle" colSpan="3">

						<xsl:call-template name="TipoEnvioBAC">
							<xsl:with-param name="TipoEnvio" select="Fila/tipo_envio"/>
						</xsl:call-template>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonEditar" type="submit" value="      Editar      "/>
				<input name="BtnEliminar" type="button" value="      Eliminar      "
				       onclick="cargar(this,'Transaccion.aspx?Transaccion=DVAEliminarCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarCaja.xsl&amp;NumeroCaja={Fila/NumeroCaja}&amp;Recaudador={Fila/Recaudador}','Transaccion')"/>
				<input name="BtnCerrar" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajas.xsl','Transaccion')"/>
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
			<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajas.xsl','Transaccion')"/>
		</div>
	</xsl:template>
	<xsl:template name="TipoCajaBAC">
		<xsl:param name="TipoCaja" select="."/>
		<xsl:choose>
			<xsl:when test="$TipoCaja = 1">Regular</xsl:when>
			<xsl:when test="$TipoCaja = 2">Virtual</xsl:when>
			
		</xsl:choose>
	</xsl:template>
	<xsl:template name="TipoEnvioBAC">
		<xsl:param name="TipoEnvio" select="."/>
		<xsl:choose>
			<xsl:when test="$TipoEnvio = 0">Domicilio SEC</xsl:when>
			<xsl:when test="$TipoEnvio = 1">Sucursal</xsl:when>
			<xsl:when test="$TipoEnvio = 2">Domicilio CAT</xsl:when>
		</xsl:choose>
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ActualizarCaja.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
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