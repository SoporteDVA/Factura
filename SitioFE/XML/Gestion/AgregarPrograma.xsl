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
					<xsl:when test="ConsultaCajasOutput">
						<xsl:apply-templates select="ConsultaCajasOutput"/>
					</xsl:when>
					<xsl:when test="AgregarProgramaOutput">
						<!--<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="AgregarProgramaOutput/Respuesta"/>
							
						</xsl:call-template>-->

						<xsl:apply-templates select="AgregarProgramaOutput"/>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al agregar Programa.
								<br/>
								<xsl:value-of select="ConsultaCajasFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="ConsultaCajasOutput">
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
				<td class="etiqueta">Caja:</td>
				<td class="detalle">
					<xsl:value-of select="Cajas/Fila/NumeroCaja"/>
				</td>
			</tr>
		</table>
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="AgregarPrograma"/>
			<input type="hidden" name="Filtro" value="XML/Gestion/AgregarPrograma.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
			<input type="hidden" name="NumeroCaja" value="{Cajas/Fila/NumeroCaja}"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<p>
				<div align="center" class="tituloAzulClaro">Información del Nuevo Programa</div>
			</p>
			<table align="center" class="tabla">

				<tr>
					<td class="etiqueta">Codigo Plan :</td>
					<td class="detalle" colSpan="3">
						<input name="CodigoPlan" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Nombre :</td>
					<td class="detalle" colSpan="3">
						<input name="Nombre" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Tipo :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Tipo">
						    <OPTION VALUE="00">--Seleccione--</OPTION>
							<OPTION VALUE="T0">Tasa Cero</OPTION>
							<OPTION VALUE="MC">Mini Cuotas</OPTION>
							<OPTION VALUE="PC">Pago Contado</OPTION>
						</SELECT>
					</td>
				</tr>

				<tr>
					<td class="etiqueta">Plazo en Meses :</td>
					<td class="detalle" colSpan="3">
						<input name="PlazoMeses"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Factor :</td>
					<td class="detalle" colSpan="3">
						<input name="Factor"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Afiliado BAC:</td>
					<td class="detalle" colSpan="3">
						<input name="NumeroAfiliado" size="15" maxlength="15"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Terminal BAC:</td>
					<td class="detalle" colSpan="3">
						<input name="NumeroTerminal" size="15" maxlength="15"/>
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
				<input name="BotonSalvar" class="button_red" type="button" value="   Guardar   " onclick="if (document.forms[0].Tipo.value == '00') alert('Debe Seleccionar un Tipo'); else submit();"  />



				<!--<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajasProgramas.xsl','Transaccion')"/>-->
			</div>
		</form>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="ConsultaProgramas"/>
				<input type="hidden" name="Filtro" value="XML/Gestion/ConsultaProgramas.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
				<input type="hidden" name="NumeroCaja" value="{Cajas/Fila/NumeroCaja}"/>

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