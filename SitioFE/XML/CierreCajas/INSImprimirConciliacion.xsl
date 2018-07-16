<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	<xsl:output method="html" indent="yes" encoding="utf-8"/>
	<xsl:template match="/">
		<html>
			<head>
				<meta http-equiv="Pragma" content="no-cache"/>
				<link rel="stylesheet" type="text/css" href="STestilos.css"/>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"></script>
			</head>
			<body>
				<form action="Transaccion.aspx" method="post">
					<table align="center" width="500" border="0">
						<tr>
							<td width="50%">
								<p align="center">
									<img align="baseline" src="imagenes/ins.gif" border="0" hspace="0" height="60"/>
								</p>
							</td>
							<td width="50%">
								<font class="tituloAzulClaro">Confirmación de impresión - Proceso Conciliación</font>
							</td>
						</tr>
					</table>
					<br/>
					<xsl:choose>
						<xsl:when test="INSObtenerPermisoOutput">
							<xsl:apply-templates select="INSObtenerPermisoOutput"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="INSObtenerPermisoFault"/>
						</xsl:otherwise>
					</xsl:choose>
				</form>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="INSObtenerPermisoOutput">
		<input type="hidden" name="NumeroDocumento" value="{NumeroDocumento}"/>
		<input type="hidden" name="IDPermiso" value="{IDPermiso}"/>
		<input type="hidden" name="DiaPago" value="{DiaPago}"/>
		<input type="hidden" name="UsuarioOrigen" value="{UsuarioOrigen}"/>
		<input type="hidden" name="OficinaOrigen" value="{OficinaOrigen}"/>
		<table class="tabla" align="center">
		<tr>
				<td class="etiqueta">Comprobante a utilizar:</td>
				<td class="detalle">
					<strong>
						<font class="tituloAzulClaro">
							<xsl:value-of select="TipoComprobanteDesc"/>-
							<xsl:value-of select="NumeroRecibo"/>
						</font>
					</strong>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Placa:</td>
				<td class="detalle">
					<xsl:value-of select="ClasePlaca"/>-
					<xsl:value-of select="Numero"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Periodo:</td>
				<td class="detalle">
					<xsl:value-of select="Periodo"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Nombre :</td>
				<td class="detalle">
					<xsl:value-of select="Nombre"/>
					<input type="hidden" name="Nombre" value="{Nombre}"/>
				</td>
			</tr>
		</table>
		<div align="center">
			<xsl:choose>
				<xsl:when test="EstadoPermiso = 'AP'">
					<input type="hidden" name="Transaccion" value="INSImprimir"/>
					<input type="hidden" name="Filtro" value="XML/INS/INSImpresion.xsl"/>
					<br/>
					<div align="center" class="tituloAzulClaro">Confirme que todo esta bien para imprimir y
						<br/>luego haga click en el botón "Continuar"</div>
					<br/>
					<input name="Continuar" type="submit" value="Continuar"/>
				</xsl:when>
				<xsl:otherwise>
					<br/>
					<font class="tituloAzulClaro">Su solicitud de impresión no ha sido aprobada aún.</font>
					<br/>
					<br/>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>

	<xsl:template match="INSObtenerPermisoFault">
		<input type="hidden" name="Transaccion" value="INSSolicitarPermiso"/>
		<input type="hidden" name="Filtro" value="XML/INS/INSSolicitudPermiso.xsl"/>
		<input type="hidden" name="NumeroDocumento" value="{NumeroDocumento}"/>
		<input type="hidden" name="DiaPago" value="{DiaPago}"/>
		<input type="hidden" name="UsuarioOrigen" value="{UsuarioOrigen}"/>
		<input type="hidden" name="OficinaOrigen" value="{OficinaOrigen}"/>
		<table class="tabla" align="center">
			<tr>
				<td class="etiqueta">Placa:</td>
				<td class="detalle">
					<xsl:value-of select="ClasePlaca"/>-
					<xsl:value-of select="Numero"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Periodo:</td>
				<td class="detalle">
					<xsl:value-of select="Periodo"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Nombre :</td>
				<td class="detalle">
					<xsl:value-of select="Nombre"/>
					<input type="hidden" name="Nombre" value="{Nombre}"/>
				</td>
			</tr>
		</table>
		<xsl:if test="UsuarioOrigen!=Sesion/Usuario">
			<div align="center">
				<br/>
				<font class="tituloAzulClaro">No tiene permiso de imprimir este marchamo.
					<br/>Solicite al cajero que realizo el pago que proceda a imprimirlo.</font>
				<br/>
				<br/>
			</div>
		</xsl:if>
		<xsl:if test="UsuarioOrigen=Sesion/Usuario">
			<div align="center">
				<br/>
				<font class="tituloAzulClaro">No tiene permiso de imprimir este marchamo.
					<br/>¿Desea solicitar un permiso de reimpresión?</font>
				<br/>
				<br/>
				<input name="ObtenerPermiso" type="submit" value="Obtener Permiso"/>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario2" userelativepaths="yes" externalpreview="no" url="..\INSObtenerPermisoOk.xml" htmlbaseurl="..\..\ConectividadesNET" outputurl="" processortype="internal" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator=""/></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->