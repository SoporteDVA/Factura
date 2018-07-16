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
				<script>function goBack() {
    window.history.back();
}</script>
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
					<xsl:when test="DatosRubroOutput">
						<xsl:for-each select="DatosRubroOutput">
							<xsl:call-template name="AgregarOutput"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="AgregarRubrosOutput">

						<xsl:for-each select="AgregarRubrosOutput">
							<xsl:call-template name="AgregarRubrosOutput"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al agregar el Rubro.
								<br/>
								<xsl:value-of select="AgregarRubrosFault/Respuesta"/>
							</h1>
							<button onclick="goBack()">Volver</button>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="AgregarOutput">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="AgregarRubros"/>
			<input type="hidden" name="Filtro" value="XML/WEBRubros/AgregarRubro.xsl"/>
			<input type="hidden" name="IDColector" value="{IDColector}"/>
			<input type="hidden" name="IDConvenio" value="{IDConvenio}"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<p>
				<div align="center" class="tituloAzulClaro">Información del Nuevo Rubro o Concepto</div>
			</p>
			<table align="center" class="tabla">
				<tr>

					<td class="etiqueta" colspan="2" align="center">Colector :  <xsl:value-of select="DescripcionColector"/></td>
				</tr>
				<tr>

					<td class="etiqueta" colspan="2" align="center">Convenio :  <xsl:value-of select="DescripcionConvenio"/></td>
				</tr>


				<tr>
					<td class="etiqueta">Codigo:</td>
					<td class="detalle" colSpan="3">
						<input name="Codigo" size="5"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Descripcion:</td>
					<td class="detalle" colSpan="3">
						<input name="Descripcion" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Exento Comision :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="SinComision">

							<xsl:if test="SinComision=0">
								<option value="1">SI</option>
								<option value="0" selected="selected">NO</option>
							</xsl:if>
						</select>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Informativo :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="Informativo">
							<xsl:if test="Informativo=0">
								<option value="1">SI</option>
								<option value="0" selected="selected">NO</option>
							</xsl:if>
						</select>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Se Suma al Impuesto :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="SumaImpuesto">
							<xsl:if test="SumaImpuesto=0">
								<option value="1">SI</option>
								<option value="0" selected="selected">NO</option>
							</xsl:if>
						</select>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Tipo de Dato :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="TipoDato">
							<option value="0" selected="selected">--Seleccione--</option>
							<xsl:for-each select="TiposDatos/TipoDato">
								<option value="{Valor}">
									<xsl:value-of select="Valor"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Formato :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="Formato">
							<option value="0" selected="selected">--Seleccione--</option>
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
							<option value="0" selected="selected">--Seleccione--</option>
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

				<input name="BotonSalvar" class="button_red" type="button" value="   Guardar   " onclick="if (document.forms[0].Codigo.value == '') alert('Debe definir un valor para el campo Codigo'); else submit();"/>
			</div>
		</form>
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
	</xsl:template>
	<xsl:template name="AgregarRubrosOutput">
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
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="DatosRubro.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
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