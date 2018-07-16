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
								<img align="baseline" src="imagenes/ins.gif" border="0" hspace="0" height="60"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Gestión de las Cajas</font>
						</td>
					</tr>
				</table>
				<br/>
				<xsl:choose>
					<xsl:when test="AgregarCajaOutput">
						<xsl:apply-templates select="AgregarCajaOutput"/>
					</xsl:when>
					<xsl:when test="DVAAgregarCajasOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAAgregarCajasOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al agregar la Caja.
								<br/>
								<xsl:value-of select="AgregarCajaFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="AgregarCajaOutput">
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
			<input type="hidden" name="Transaccion" value="DVAAgregarCajas"/>
			<input type="hidden" name="Filtro" value="XML/Gestion/AgregarCaja.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Información de la Nueva Caja</div>
			<br/>
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">Numero Caja :</td>
					<td class="detalle" colSpan="3">
						<input name="NumeroCaja" onkeypress="return soloNumeros(event)" maxlength="4"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Recaudador :</td>
					<td class="detalle" colSpan="3">
						<input name="Recaudador" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Usuario INS :</td>
					<td class="detalle" colSpan="3">
						<input name="Usuario_INS" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Descripción :</td>
					<td class="detalle" colSpan="3">
						<input name="Descripcion" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Estado :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Estado">
							<OPTION VALUE="1">Activa</OPTION>
							<OPTION VALUE="0">Inactiva</OPTION>
						</SELECT>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonSalvar" type="submit" value="      Salvar      "/>
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
			<input name="BtnCerrar" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajas.xsl','Transaccion')"/>
		</div>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2007. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios/><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->