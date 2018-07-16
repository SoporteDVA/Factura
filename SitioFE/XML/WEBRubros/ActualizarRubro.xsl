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
							<font class="tituloAzulClaro">Modificación del Rubro</font>
						</td>
					</tr>
				</table>
				<xsl:choose>
					<xsl:when test="ConsultaRubrosOutput">
						<xsl:for-each select="ConsultaRubrosOutput">
							<xsl:call-template name="ConsultaOutput"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="EditarRubrosOutput">
						<xsl:for-each select="EditarRubrosOutput/Fila">
							<xsl:call-template name="ModificarRubroOutput"/>
						</xsl:for-each>
					</xsl:when>


					<xsl:otherwise>
						<center>
							<h1>Se presentó un error con el Rubro.
								<br/>
								<xsl:value-of select="ActualizarCajasFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="ConsultaOutput">
		<table class="tabla" align="center">
			<tr>
				<td class="etiqueta">ID:</td>
				<td class="detalle">
					<xsl:value-of select="Fila/ID"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Colector:</td>
				<td class="detalle">
					<xsl:value-of select="Fila/DescripcionColector"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Convenio:</td>
				<td class="detalle">
					<xsl:value-of select="Fila/DescripcionConvenio"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Codigo:</td>
				<td class="detalle">
					<xsl:value-of select="Fila/Codigo"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Descripcion:</td>
				<td class="detalle">
					<xsl:value-of select="Fila/Descripcion"/>
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
			<input type="hidden" name="Transaccion" value="EditarRubros"/>
			<input type="hidden" name="Filtro" value="XML/WEBRubros/ActualizarRubro.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="ID" value="{Fila/ID}"/>
			<input type="hidden" name="Colector" value="{Fila/Colector}"/>
			<input type="hidden" name="Convenio" value="{Fila/Convenio}"/>
			<input type="hidden" name="Codigo" value="{Fila/Codigo}"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Datos Editables del Rubro o Concepto</div>

			<table align="center" class="tabla">

				<tr>
					<td class="etiqueta">Descripcion :</td>
					<td class="detalle" colSpan="3">
						<input name="Descripcion" value="{Fila/Descripcion}" size="25"/>
					</td>
				</tr>

				<tr>
					<td class="etiqueta">Exento Comision :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="SinComision">
							<option value="{Fila/SinComision}" selected="selected">
								<xsl:call-template name="SINO">
									<xsl:with-param name="Codigo" select="normalize-space(Fila/SinComision)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Fila/SinComision)='0'">
								<OPTION VALUE="1">SI</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Fila/SinComision)='1'">
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Fila/SinComision)=''">
								<OPTION VALUE="1" selected="selected">SI</OPTION>
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Es Informativo :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Informativo">
							<option value="{Fila/Informativo}" selected="selected">
								<xsl:call-template name="SINO">
									<xsl:with-param name="Codigo" select="normalize-space(Fila/Informativo)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Fila/Informativo)='0'">
								<OPTION VALUE="1">SI</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Fila/Informativo)='1'">
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Fila/Informativo)=''">
								<OPTION VALUE="1" selected="selected">SI</OPTION>
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Suma al Impuesto :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="SumaImpuesto">
							<option value="{Fila/SumaImpuesto}" selected="selected">
								<xsl:call-template name="SINO">
									<xsl:with-param name="Codigo" select="normalize-space(Fila/SumaImpuesto)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Fila/SumaImpuesto)='0'">
								<OPTION VALUE="1">SI</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Fila/SumaImpuesto)='1'">
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Fila/SumaImpuesto)=''">
								<OPTION VALUE="1" selected="selected">SI</OPTION>
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Tipo de Dato :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="TipoDato">
							<option value="{Fila/TipoDato}" selected="selected">
								<xsl:value-of select="Fila/TipoDato"/>
							</option>
							<xsl:for-each select="TipoDatos/TipoDato">
								<option value="{Valor}">
									<xsl:value-of select="Valor"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Formato Origen:</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="Formato">
							<option value="{Fila/Formato}" selected="selected">
								<xsl:value-of select="Fila/Formato"/>
							</option>
							<xsl:for-each select="Formatos/Formato">
								<option value="{Valor}">
									<xsl:value-of select="Valor"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>

				<tr>
					<td class="etiqueta">Formato Destino:</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="FormatoDestino">
							<option value="{Fila/FormatoDestino}" selected="selected">
								<xsl:value-of select="Fila/FormatoDestino"/>
							</option>
							<xsl:for-each select="Formatos/Formato">
								<option value="{ValorDestino}">
									<xsl:value-of select="ValorDestino"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>

				
			</table>
			<br/>
			<div align="center">
				<input name="BotonSalvar" class="button_red" type="submit" value="      Guardar      "/>
			</div>
		</form>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="ConsultaRubros"/>
				<input type="hidden" name="Filtro" value="XML/WEBRubros/ConsultaRubro.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input type="hidden" name="IDColector" value="{Fila/Colector}"/>
				<input type="hidden" name="IDConvenio" value="{Fila/Convenio}"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="      Volver      "/>
			</form>
		</div>
	</xsl:template>
	<xsl:template name="ModificarRubroOutput">
		<div align="center">
			<br/>
			<font class="tituloAzulClaro">
				<xsl:value-of select="Respuesta"/>
			</font>
			<br/>
			<br/>

			<div align="center">
				<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="ConsultaRubros"/>
					<input type="hidden" name="Filtro" value="XML/WEBRubros/ConsultaRubro.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
					<input type="hidden" name="IDColector" value="{IDColector}"/>
					<input type="hidden" name="IDConvenio" value="{IDConvenio}"/>
					<input name="BotonCerrar" class="button_gris" type="submit" value="      Volver      "/>
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
	<xsl:template name="SINO">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = '1'">SI</xsl:when>
			<xsl:when test="$Codigo = '0'">NO</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="RubroEs.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
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