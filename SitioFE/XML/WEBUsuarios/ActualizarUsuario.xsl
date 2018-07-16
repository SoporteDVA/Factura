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
			<div align="center">
				<table align="center">
					<tr>
						<td width="30%">
							<p align="center">
								<img align="baseline" src="imagenes/DVAEnc.JPG"/>
							</p>
						</td>
					</tr>
				</table>
			</div>
				<table align="center" border="0">
					<tr>
						<!--<td width="50%">
							<p align="center">
								<img src="imagenes/Programas.PNG" align="baseline" border="0" width="60px" height="60px"/>
							</p>
						</td>-->
						<td width="100%">
							<font class="tituloAzulClaro">Gestión de Perfil de Usuario</font>
						</td>
					</tr>
				</table>
								<xsl:choose>
					<xsl:when test="ConsultaUsuariosOutput">
						<xsl:for-each select="ConsultaUsuariosOutput">
							<xsl:call-template name="ConsultaUsuariosOutput"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="AgregaModificaUsuariosOutput">
						<xsl:for-each select="AgregaModificaUsuariosOutput">
							<xsl:call-template name="ConsultaUsuariosOutput"/>
						</xsl:for-each>
					</xsl:when>

					<xsl:when test="ModificarProgramaOutput">
						<!--<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="ModificarProgramaOutput/Fila/Mensaje"/>
						</xsl:call-template>-->
						<xsl:apply-templates select="ModificarProgramaOutput"/>
					</xsl:when>

					<xsl:when test="ModificarProgramaFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="ModificarProgramaFault/Respuesta"/>
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
	<xsl:template name="ConsultaUsuariosOutput">
		<table class="tabla" align="center">
			<tr class="etiqueta">
				<td>Cliente:</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/Fila/Cliente"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">ID:</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/Fila/ID"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Usuario:</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/Fila/Usuario"/>
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
			<input type="hidden" name="Transaccion" value="AgregaModificaUsuarios"/>
			<input type="hidden" name="Filtro" value="XML/WEBUsuarios/ConsultaUsuarios.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="ID" value="{Resultado/Fila/ID}"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Editar Perfil del Usuario</div>

			<table align="center" class="tabla">
				
				<tr>
					<td class="etiqueta">Nombre :</td>
					<td class="detalle" colSpan="3">
						<input name="Nombre" value="{Resultado/Fila/Nombre}" size="50"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Oficina :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Oficina">
							<xsl:if test="Resultado/Fila/Oficina!=''">
							<option value="{Resultado/Fila/Oficina}" selected="selected"><xsl:value-of select="Resultado/Fila/NombreOficina"/></option>
							</xsl:if>
							<xsl:if test="Resultado/Fila/Oficina=''">
							<OPTION VALUE="0"  selected="selected">--Seleccione--</OPTION>
							</xsl:if>	
							<xsl:for-each select="Oficinas/Fila">
								<xsl:if test="Estado='A' and ID != ../../Resultado/Fila/Oficina">
									<option value="{ID}">
										<xsl:value-of select="Descripcion"/>
									</option>
								</xsl:if>								
							</xsl:for-each>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Estado :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Estado">
							<option value="{Resultado/Fila/Estado}" selected="selected">
								<xsl:call-template name="Estado">
									<xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/Estado)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Resultado/Fila/Estado)='A'">
								<OPTION VALUE="I">INACTIVO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/Estado)='I'">
								<OPTION VALUE="A">ACTIVO</OPTION>
								
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/Estado)=''">
								<OPTION VALUE="A" selected="selected">ACTIVO</OPTION>
								<OPTION VALUE="I">INACTIVO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Puede Consultar :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="PuedeConsultar">
							<option value="{Resultado/Fila/PuedeConsultar}" selected="selected">
								<xsl:call-template name="EstadoPermiso">
									<xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/PuedeConsultar)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Resultado/Fila/PuedeConsultar)='1'">
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/PuedeConsultar)='0'">
								<OPTION VALUE="1">SI</OPTION>
								
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/PuedeConsultar)=''">
								<OPTION VALUE="1" selected="selected">SI</OPTION>
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Puede Pagar :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="PuedePagar">
							<option value="{Resultado/Fila/PuedePagar}" selected="selected">
								<xsl:call-template name="EstadoPermiso">
									<xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/PuedePagar)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Resultado/Fila/PuedePagar)='1'">
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/PuedePagar)='0'">
								<OPTION VALUE="1">SI</OPTION>
								
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/PuedePagar)=''">
								<OPTION VALUE="1" selected="selected">SI</OPTION>
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Puede Reversar :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="PuedeReversar">
							<option value="{Resultado/Fila/PuedeReversar}" selected="selected">
								<xsl:call-template name="EstadoPermiso">
									<xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/PuedeReversar)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Resultado/Fila/PuedeReversar)='1'">
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/PuedeReversar)='0'">
								<OPTION VALUE="1">SI</OPTION>
								
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/PuedeReversar)=''">
								<OPTION VALUE="1" selected="selected">SI</OPTION>
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Puede Cerrar :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="PuedeCerrar">
							<option value="{Resultado/Fila/PuedeCerrar}" selected="selected">
								<xsl:call-template name="EstadoPermiso">
									<xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/PuedeCerrar)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Resultado/Fila/PuedeCerrar)='1'">
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/PuedeCerrar)='0'">
								<OPTION VALUE="1">SI</OPTION>
								
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/PuedeCerrar)=''">
								<OPTION VALUE="1" selected="selected">SI</OPTION>
								<OPTION VALUE="0">NO</OPTION>
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
				<input type="hidden" name="Transaccion" value="ConsultaUsuarios"/>
				<input type="hidden" name="Filtro" value="XML/WEBUsuarios/ConsultaUsuarios.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="      Volver      "/>
			</form>
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
			       onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajasProgramas.xsl','Transaccion')"/>
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
	<xsl:template name="Estado1">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 1">Activo</xsl:when>
			<xsl:when test="$Codigo = 0">Inactivo</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Estado">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 'A'">ACTIVO</xsl:when>
			<xsl:when test="$Codigo = 'I'">INACTIVO</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="EstadoPermiso">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 0">NO</xsl:when>
			<xsl:when test="$Codigo = 1">SI</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\Gestion\ActualizarCaja.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
		          urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->