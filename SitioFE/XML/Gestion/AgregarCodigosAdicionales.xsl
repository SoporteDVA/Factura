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
					<xsl:when test="ConsultaCodigosAdicionalesOutput">
						<xsl:apply-templates select="ConsultaCodigosAdicionalesOutput"/>
					</xsl:when>
					<xsl:when test="AgregarCodigosAdicionalesOutput">
						<!--<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="AgregarProgramaOutput/Respuesta"/>
							
						</xsl:call-template>-->

						<xsl:apply-templates select="AgregarCodigosAdicionalesOutput"/>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al agregar Codigo Adicional.
								<br/>
								<xsl:value-of select="ConsultaCajasFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="ConsultaCodigosAdicionalesOutput">
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
			<!--<tr>
				<td class="etiqueta">Caja:</td>
				<td class="detalle">
					<xsl:value-of select="Cajas/Fila/NumeroCaja"/>
				</td>
			</tr>-->
		</table>
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="AgregarCodigosAdicionales"/>
			<input type="hidden" name="Filtro" value="XML/Gestion/AgregarCodigosAdicionales.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>

			<!-- Revisar estos valores -->
			<!-- -->
			<p>
				<div align="center" class="tituloAzulClaro">Información del Nuevo Codigo Adicional</div>
			</p>
			<table align="center" class="tabla">

				<tr>
					<td class="etiqueta">Tipo :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Tipo">
							<OPTION VALUE="00">--Seleccione--</OPTION>
							<OPTION VALUE="1">Codigo Gobierno</OPTION>
							<OPTION VALUE="5">Clase Placa</OPTION>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Codigo :</td>
					<td class="detalle" colSpan="3">
						<input name="Codigo" size="10"/>
					</td>
				</tr>

				<tr>
					<td class="etiqueta">Descripcion :</td>
					<td class="detalle" colSpan="3">
						<input name="Descripcion" size="30"/>
					</td>
				</tr>
				
				<tr>
					<td class="etiqueta">Estado :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Estado">
							<OPTION VALUE="1" selected="selected">Activo</OPTION>
							<OPTION VALUE="0">Inactivo</OPTION>
						</SELECT>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonSalvar" class="button_red" type="button" value="   Guardar   " onclick="if (document.forms[0].Tipo.value == '00') alert('Debe Seleccionar un Tipo'); else submit();"/>



				<!--<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajasProgramas.xsl','Transaccion')"/>-->
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
	<xsl:template match="AgregarCodigosAdicionalesOutput">
		<div align="center">
			<br/>
			<font class="tituloAzulClaro">
				<xsl:value-of select="Respuesta"/>
			</font>
			<br/>
			<br/>

			<div align="center">
				<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="ConsultaCodigosAdicionales"/>
					<input type="hidden" name="Filtro" value="XML/Gestion/ConsultaCodigosAdicionales.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
					

					<input name="BotonCerrar" class="button_gris" type="submit" value="      Cerrar      "/>
				</form>
			</div>


			<!--<input name="BtnCerrar" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajas.xsl','Transaccion')"/>-->
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