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
							<font class="tituloAzulClaro">Gestión de los Ciclos</font>
						</td>
					</tr>
				</table>
				<xsl:choose>
					<xsl:when test="ConsultaCiclosOutput">
						<xsl:for-each select="ConsultaCiclosOutput/Resultados">
							<xsl:call-template name="Actualizar"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="AgregaModificaColectoresOutput">
						<xsl:for-each select="AgregaModificaColectoresOutput">
							<xsl:call-template name="ConsultaColectoresOutput"/>
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
	<xsl:template name="ConsultaCiclosOutput">
		<table class="tabla" align="center">
			<tr>
				<td class="etiqueta">Cliente:</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/Fila/Cliente"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Codigo Sistema:</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/Fila/ID"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Codigo Alterno (Banco):</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/Fila/IDAlterno"/>
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
			<input type="hidden" name="Transaccion" value="ActualizaCiclos"/>
			<input type="hidden" name="Filtro" value="XML/WEBCargosAutomaticos/ConsultaColectoresCA.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="ID" value="{Fila/ID}"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Editar Ciclo</div>

			<table align="center" class="tabla">
				<!--<tr>
					<td class="etiqueta">ID :</td>
					<td class="detalle" colSpan="3">
						<input name="CodigoPlan" size="15" value="{Resultado/Fila/ID}" onkeypress="return soloNumeros(event)" maxlength="2">
						</input>
					</td>
				</tr>-->
				<!--<tr>
					<td class="etiqueta">Numero Caja :</td>
					<td class="detalle" colSpan="3">
						<input name="NumeroCaja" value="{Fila/NumeroCaja}" size="15"/>
					</td>
				</tr>-->
				<tr>
					<td class="etiqueta">Colector:</td>
					<td class="detalle">

						<p align="center">

							<xsl:value-of select="Fila/Descripcion"/>
						</p>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Dia Corte:</td>
					<td class="detalle">

						<p align="Left">
							<xsl:value-of select="Fila/DiaCorte"/> del MES
						</p>
					</td>
				</tr>

				<tr>
					<td class="etiqueta">Estado :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Estado">
							<option value="{Fila/Estado}" selected="selected">
								<xsl:call-template name="Estado">
									<xsl:with-param name="Codigo" select="normalize-space(Fila/Estado)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Fila/Estado)='A'">
								<OPTION VALUE="I">INACTIVO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Fila/Estado)='I'">
								<OPTION VALUE="A">ACTIVO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Fila/Estado)=''">
								<OPTION VALUE="A" selected="selected">ACTIVO</OPTION>
								<OPTION VALUE="I">INACTIVO</OPTION>
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
				<input type="hidden" name="Transaccion" value="ConsultaCiclos"/>
				<input type="hidden" name="Filtro" value="XML/WEBCargosAutomaticos/ConsultaColectoresCA.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="      Volver      "/>
			</form>
		</div>
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
				<tr>
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
				</tr>

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
	<xsl:template match="ModificarProgramaOutput">
		<div align="center">
			<br/>
			<font class="tituloAzulClaro">
				<xsl:value-of select="Fila/Mensaje"/>
			</font>
			<br/>
			<br/>

			<div align="center">
				<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="ConsultaProgramas"/>
					<input type="hidden" name="Filtro" value="XML/Gestion/ConsultaProgramas.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
					<input type="hidden" name="NumeroCaja" value="{Fila/NumeroCaja}"/>

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
			       onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajasProgramas.xsl','Transaccion')"/>
		</div>
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
	<xsl:template name="Destino">
		<xsl:param name="CodigoD" select="."/>
		<xsl:choose>
			<xsl:when test="$CodigoD = '1'">LOCAL</xsl:when>
			<xsl:when test="$CodigoD = '0'">DVA</xsl:when>
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