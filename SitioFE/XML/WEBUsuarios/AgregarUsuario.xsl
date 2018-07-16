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
				<br/>
				<xsl:choose>
					<xsl:when test="EstadosOutput">
						<xsl:for-each select="EstadosOutput">
							<xsl:call-template name="AgregarUsuarioOutput"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="AgregarProgramaOutput">
						<!--<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="AgregarProgramaOutput/Respuesta"/>
							
						</xsl:call-template>-->

						<xsl:apply-templates select="AgregarProgramaOutput"/>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al agregar el usuario.
								<br/>
								<xsl:value-of select="ConsultaCajasFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="AgregarUsuarioOutput">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="AgregaModificaUsuarios"/>
			<input type="hidden" name="Filtro" value="XML/WEBUsuarios/ConsultaUsuarios.xsl"/>
			<input type="hidden" name="Cliente" value="{Resultado/Sesion/Cliente}"/>
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
			<p>
				<div align="center" class="tituloAzulClaro">Información del Nuevo Perfil de Usuario</div>
			</p>
			<table align="center" class="tabla">

				<tr>
					<td class="etiqueta">Usuario:</td>
					<td class="detalle" colSpan="3">
						<input name="Usuario" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Nombre:</td>
					<td class="detalle" colSpan="3">
						<input name="Nombre" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Estado :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="Estado">
							<xsl:for-each select="Resultado/Fila">
								<xsl:if test="Codigo='A'">
									<option value="{Codigo}" selected="selected">
										<xsl:value-of select="Descripcion"/>
									</option>
								</xsl:if>
								<xsl:if test="Codigo!='A'">
									<option value="{Codigo}">
										<xsl:value-of select="Descripcion"/>
									</option>
								</xsl:if>
							</xsl:for-each>
						</select>
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
								<OPTION VALUE="1">SI</OPTION>
								<OPTION VALUE="0" selected="selected">NO</OPTION>
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
								<OPTION VALUE="1">SI</OPTION>
								<OPTION VALUE="0" selected="selected">NO</OPTION>
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
								<OPTION VALUE="1">SI</OPTION>
								<OPTION VALUE="0" selected="selected">NO</OPTION>
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
								<OPTION VALUE="1">SI</OPTION>
								<OPTION VALUE="0" selected="selected">NO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>	
				<tr>
					<td class="etiqueta">Oficina :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="Oficina">
						    <OPTION VALUE="0"  selected="selected">--Seleccione--</OPTION>
							<xsl:for-each select="Resultado/Oficinas/Fila">
								<xsl:if test="Estado='A'">
									<option value="{ID}">
										<xsl:value-of select="Descripcion"/>
									</option>
								</xsl:if>								
							</xsl:for-each>
						</select>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<!--<input name="BotonSalvar" class="button_red" type="submit" value="      Guardar      "/>-->
				<input name="BotonSalvar" class="button_red" type="button" value="   Guardar   " onclick="if (document.forms[0].Usuario.value == '') alert('Debe definir un valor para el campo Usuario'); else submit();"  />
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
	<xsl:template match="AgregarProgramaOutput">
		<div align="center">
			<br/>
			<font class="tituloAzulClaro">
				<xsl:value-of select="Respuesta"/>
			</font>
			<br/>
			<br/>

			<div align="center">
				<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="ConsultaProgramas"/>
					<input type="hidden" name="Filtro" value="XML/Gestion/ConsultaProgramas.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
					<input type="hidden" name="NumeroCaja" value="{NumeroCaja}"/>

					<input name="BotonCerrar" class="button_gris" type="submit" value="      Cerrar      "/>
				</form>
			</div>


			<!--<input name="BtnCerrar" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajas.xsl','Transaccion')"/>-->
		</div>
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
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->