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
				<xsl:choose>
					<xsl:when test="EstadosOutput">
						<xsl:for-each select="EstadosOutput">
							<xsl:call-template name="AgregarOutput"/>
						</xsl:for-each>
					</xsl:when>
					
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al agregar la oficina.
								<br/>
								<xsl:value-of select="ConsultaOficinasFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="AgregarOutput">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="AgregaModificaOficinas"/>
			<input type="hidden" name="Filtro" value="XML/WEBOficinas/ConsultaOficinas.xsl"/>
			<input type="hidden" name="Cliente" value="{Resultado/Sesion/Cliente}"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<p>
				<div align="center" class="tituloAzulClaro">Información de la Nueva Oficina</div>
			</p>
			<table align="center" class="tabla">

				<tr>
					<td class="etiqueta">Codigo Alterno:</td>
					<td class="detalle" colSpan="3">
						<input name="IDAlterno" size="5"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Descripcion:</td>
					<td class="detalle" colSpan="3">
						<input name="Descripcion" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Estado :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="Estado">
							<xsl:for-each select="Resultado/Fila">
								<xsl:if test="Codigo='1'">
									<option value="{Codigo}" selected="selected">
										<xsl:value-of select="Descripcion"/>
									</option>
								</xsl:if>
								<xsl:if test="Codigo!='1'">
									<option value="{Codigo}">
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
				
				<input name="BotonSalvar" class="button_red" type="button" value="   Guardar   " onclick="if (document.forms[0].IDAlterno.value == '') alert('Debe definir un valor para el campo Codigo Alterno'); else submit();"  />
				<!--<input name="BotonSalvar" type="submit" value="      Salvar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=DVAModificarCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarCaja.xsl','Transaccion')"/>-->
				<!--<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      "
				       onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajasProgramas.xsl','Transaccion')"/>-->
			</div>
		</form>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="ConsultaOficinas"/>
				<input type="hidden" name="Filtro" value="XML/WEBOficinas/ConsultaOficinas.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="      Volver      "/>
			</form>
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