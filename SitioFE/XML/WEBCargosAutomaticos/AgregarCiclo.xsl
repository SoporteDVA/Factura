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
					<xsl:when test="AgregarProgramaOutput">
						<!--<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="AgregarProgramaOutput/Respuesta"/>
							
						</xsl:call-template>-->

						<xsl:apply-templates select="AgregarProgramaOutput"/>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al agregar el Ciclo.
								<br/>
								<xsl:value-of select="ConsultaCajasFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="AgregarOutput">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="AgregaCiclos"/>
			<input type="hidden" name="Filtro" value="XML/WEBCargosAutomaticos/ConsultaColectoresCA.xsl"/>
			<input type="hidden" name="Cliente" value="{Resultado/Sesion/Cliente}"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<p>
				<div align="center" class="tituloAzulClaro">Información del Nuevo Ciclo</div>
			</p>
			<table align="center" class="tabla">

				
				<tr>
					<td class="etiqueta">Servicio :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="Colector">
							<option value="1000">--Seleccione el Servicio--</option>
							<xsl:for-each select="Resultado/Colectores/Fila">
								<option value="{IDAlterno}">
									<xsl:value-of select="Descripcion"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
			
				

				<!--<tr>
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
				</tr>-->
				<tr>
					<td class="etiqueta">Dia del Mes :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="DiaCorte">
							<OPTION VALUE="1" selected="selected">1</OPTION>
							<OPTION VALUE="2">2</OPTION>							
							<OPTION VALUE="3">3</OPTION>
							<OPTION VALUE="4">4</OPTION>
							
							<OPTION VALUE="6">6</OPTION>
							<OPTION VALUE="7">7</OPTION>
							<OPTION VALUE="8">8</OPTION>
							<OPTION VALUE="9">9</OPTION>
							
							<OPTION VALUE="11">11</OPTION>
							<OPTION VALUE="12">12</OPTION>
							<OPTION VALUE="13">13</OPTION>
							<OPTION VALUE="14">14</OPTION>
							
							<OPTION VALUE="16">16</OPTION>
							<OPTION VALUE="17">17</OPTION>
							<OPTION VALUE="18">18</OPTION>
							<OPTION VALUE="19">19</OPTION>
							
							<OPTION VALUE="21">21</OPTION>
							<OPTION VALUE="22">22</OPTION>
							<OPTION VALUE="23">23</OPTION>
							<OPTION VALUE="24">24</OPTION>

							<OPTION VALUE="26">26</OPTION>
							<OPTION VALUE="27">27</OPTION>
							<OPTION VALUE="28">28</OPTION>
							<OPTION VALUE="29">29</OPTION>

							
							<OPTION VALUE="31">31</OPTION>
						</SELECT>
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

			</table>
			<br/>
			<div align="center">
				<!--<input name="BotonSalvar" class="button_red" type="submit" value="      Guardar      "/>-->
				<input name="BotonSalvar" class="button_red" type="button" value="   Guardar   " onclick="if (document.forms[0].DiaCorte.value == '') alert('Debe definir un valor para el campo Día del Mes'); else submit();"/>
				<!--<input name="BotonSalvar" type="submit" value="      Salvar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=DVAModificarCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarCaja.xsl','Transaccion')"/>-->
				<!--<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      "
				       onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajasProgramas.xsl','Transaccion')"/>-->
			</div>
		</form>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="ConsultaCiclos"/>
				<input type="hidden" name="Filtro" value="XML/WEBCargosAutomaticos/ConsultaColectoresCA.xsl"/>
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