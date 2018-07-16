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
				<table align="center" border="0">
					<tr>
						<!--<td width="50%">
							<p align="center">
								<img src="imagenes/Programas.PNG" align="baseline" border="0" width="60px" height="60px"/>
							</p>
						</td>-->
						<td width="100%">
							<font class="tituloAzulClaro">Gestión de Codigos Adicionales</font>
						</td>
					</tr>
				</table>
				<br/>
				<xsl:choose>
					<xsl:when test="ConsultaCodigosAdicionalesOutput">
						<xsl:for-each select="ConsultaCodigosAdicionalesOutput">
							<xsl:call-template name="ConsultaCodigosAdicionalesOutput"/>
						</xsl:for-each>
					</xsl:when>

					<xsl:when test="ModificarCodigoAdicionalOutput">
						<!--<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="ModificarProgramaOutput/Fila/Mensaje"/>
						</xsl:call-template>-->
						<xsl:apply-templates select="ModificarCodigoAdicionalOutput"/>
					</xsl:when>

					<xsl:when test="ModificarCodigoAdicionalFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="ModificarCodigoAdicionalFault/Respuesta"/>
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
							<h1>Se presentó un error con el programa.
								<br/>
								<xsl:value-of select="ActualizarCajasFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="ConsultaCodigosAdicionalesOutput">
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
			<tr>
				<td class="etiqueta">Codigo:</td>
				<td class="detalle">
					<xsl:value-of select="Fila/Codigo"/>-<xsl:value-of select="Fila/Descripcion"/></td>
			</tr>
		</table>
		<xsl:choose>
			<xsl:when test="Accion='Modificar'">
				<xsl:call-template name="Actualizar"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="Actualizar"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Actualizar">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="ModificarCodigoAdicional"/>
			<input type="hidden" name="Filtro" value="XML/Gestion/ActualizarCodigoAdicional.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
			<input type="hidden" name="Codigo" value="{Fila/Codigo}"/>

			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Información del Codigo Adicional</div>

			<table align="center" class="tabla">


				<tr>
					<td class="etiqueta">Tipo :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Tipo">
							<option value="{Fila/Tipo}" selected="selected">
								<xsl:call-template name="TipoCodigo">
									<xsl:with-param name="TipoCodigo" select="normalize-space(Fila/Tipo)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Fila/Tipo)='1'">
								<OPTION VALUE="5">Clase Placa</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Fila/Tipo)='5'">
								<OPTION VALUE="1">Codigo Gobierno</OPTION>
							</xsl:if>

							<xsl:if test="normalize-space(Fila/Tipo)=''">
								<OPTION VALUE="1" selected="selected">Codigo Gobierno</OPTION>
								<OPTION VALUE="5">Clase Placa</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>

				<tr>
					<td class="etiqueta">Descripcion :</td>
					<td class="detalle" colSpan="3">
						<input name="Descripcion" value="{Fila/Descripcion}" size="30"/>
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
							<xsl:if test="Fila/Estado=0">
								<OPTION VALUE="1">Activo</OPTION>
							</xsl:if>
							<xsl:if test="Fila/Estado=1">
								<OPTION VALUE="0">Inactivo</OPTION>
							</xsl:if>
							<xsl:if test="Fila/Estado=''">
								<OPTION VALUE="1" selected="selected">Activo</OPTION>
								<OPTION VALUE="0">Inactivo</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonSalvar" class="button_red" type="submit" value="      Guardar      "/>
				<!--<input name="BotonSalvar" type="submit" value="      Salvar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=DVAModificarCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarCaja.xsl','Transaccion')"/>-->
				<!--<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      "
				       onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajasProgramas.xsl','Transaccion')"/>-->
			</div>
		</form>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="ConsultaCodigosAdicionales"/>
				<input type="hidden" name="Filtro" value="XML/Gestion/ConsultaCodigosAdicionales.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
				<input type="hidden" name="Codigo" value="0"/>

				<input name="BotonCerrar" class="button_gris" type="submit" value="      Volver      "/>
			</form>
		</div>
	</xsl:template>


	<xsl:template match="ModificarCodigoAdicionalOutput">
		<div align="center">
			<br/>
			<font class="tituloAzulClaro">
				<xsl:value-of select="Fila/Mensaje"/>
			</font>
			<br/>
			<br/>

			<div align="center">
				<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="ConsultaCodigosAdicionales"/>
					<input type="hidden" name="Filtro" value="XML/Gestion/ConsultaCodigosAdicionales.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
					<input type="hidden" name="Codigo" value="0"/>

					<input name="BotonCerrar" class="button_gris" type="submit" value="      Cerrar      "/>
				</form>
			</div>


			<!--<input name="BtnCerrar" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajas.xsl','Transaccion')"/>-->
		</div>
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
			<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      "
			       onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCodigosAdicionales&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCodigosAdicionales.xsl','Transaccion')"/>
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
	<xsl:template name="TipoCodigo">
		<xsl:param name="TipoCodigo" select="."/>
		<xsl:choose>
			<xsl:when test="$TipoCodigo = 5">Clase Placa</xsl:when>
			<xsl:when test="$TipoCodigo = 1">Codigo GOB</xsl:when>
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