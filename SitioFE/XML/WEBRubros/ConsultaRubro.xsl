<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión de los Rubros asignados a cada Convenio y colector del Sistema</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>


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
				<p align="center">

					<td width="100%">
						<font class="tituloAzulClaro">Rubros o Conceptos del Colector y Convenio</font>
					</td>
				</p>
				<br/>
				<xsl:choose>
					<xsl:when test="ConsultaRubrosFault">
						<table class="tablaDetalle" align="center" border="0">
							<tfoot align="center"/>
							<tbody>
								<tr class="encabezado">


									<td align="center">
										<strong>Estado</strong>
									</td>

									<td>
										<p align="center">
											<strong>Mensaje</strong>
										</p>
									</td>
								</tr>
								<xsl:for-each select="ConsultaRubrosFault">
									<tr class="detalle">

										<td>
											<p align="center">
												<xsl:value-of select="Estado"/>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:value-of select="Mensaje"/>
											</p>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
						<button onclick="goBack()">Volver</button>
					</xsl:when>

					<xsl:when test="ConsultaRubrosOutput/Fila[ID='']">

						<form action="Transaccion.aspx" method="post">
							<input type="hidden" name="Transaccion" value="DatosRubro"/>
							<input type="hidden" name="Filtro" value="XML/WEBRubros/AgregarRubro.xsl"/>
							<input type="hidden" name="IDColector" value="{ConsultaRubrosOutput/Fila/Colector}"/>
							<input type="hidden" name="DescripcionColector" value="{ConsultaRubrosOutput/Fila/DescripcionColector}"/>
							<input type="hidden" name="IDConvenio" value="{ConsultaRubrosOutput/Fila/Convenio}"/>
							<input type="hidden" name="DescripcionConvenio" value="{ConsultaRubrosOutput/Fila/DescripcionConvenio}"/>
							<input type="hidden" name="SinComision" value="{ConsultaRubrosOutput/Fila/SinComision}"/>
							<input type="hidden" name="DescripcionSinComision" value="{ConsultaRubrosOutput/Fila/DescripcionSinComision}"/>
							<input type="hidden" name="Informativo" value="{ConsultaRubrosOutput/Fila/Informativo}"/>
							<input type="hidden" name="DescripcionInformativo" value="{ConsultaRubrosOutput/Fila/DescripcionInformativo}"/>
							<input type="hidden" name="SumaImpuesto" value="{ConsultaRubrosOutput/Fila/SumaImpuesto}"/>
							<input type="hidden" name="DescripcionSumaImpuesto" value="{ConsultaRubrosOutput/Fila/DescripcionSumaImpuesto}"/>
							<div align="center">
								<input name="BotonSalvar" class="button_red" type="submit" value="      Crear Nuevo Rubro      "/>
							</div>
						</form>
						<form action="Transaccion.aspx" method="post">
							<input type="hidden" name="Transaccion" value="ConsultaColectores"/>
							<input type="hidden" name="Filtro" value="XML/WEBRubros/ConsultaColectoresRubro.xsl"/>
							<div align="center">
								<input name="BotonSalvar" class="button_gris" type="submit" value="      Salir      "/>
							</div>
						</form>

						<p align="center">
							<font class="tituloAzulClaro">El Convenio no tiene ningun Rubro o Concepto</font>
						</p>
					</xsl:when>

					<xsl:otherwise>


						<form action="Transaccion.aspx" method="post">
							<input type="hidden" name="Transaccion" value="DatosRubro"/>
							<input type="hidden" name="Filtro" value="XML/WEBRubros/AgregarRubro.xsl"/>
							<input type="hidden" name="IDColector" value="{ConsultaRubrosOutput/Fila/Colector}"/>
							<input type="hidden" name="DescripcionColector" value="{ConsultaRubrosOutput/Fila/DescripcionColector}"/>
							<input type="hidden" name="IDConvenio" value="{ConsultaRubrosOutput/Fila/Convenio}"/>
							<input type="hidden" name="DescripcionConvenio" value="{ConsultaRubrosOutput/Fila/DescripcionConvenio}"/>
							<input type="hidden" name="SinComision" value="{ConsultaRubrosOutput/Fila/SinComision}"/>
							<input type="hidden" name="DescripcionSinComision" value="{ConsultaRubrosOutput/Fila/DescripcionSinComision}"/>
							<input type="hidden" name="Informativo" value="{ConsultaRubrosOutput/Fila/Informativo}"/>
							<input type="hidden" name="DescripcionInformativo" value="{ConsultaRubrosOutput/Fila/DescripcionInformativo}"/>
							<input type="hidden" name="SumaImpuesto" value="{ConsultaRubrosOutput/Fila/SumaImpuesto}"/>
							<input type="hidden" name="DescripcionSumaImpuesto" value="{ConsultaRubrosOutput/Fila/DescripcionSumaImpuesto}"/>
							<div align="center">
								<input name="BotonSalvar" class="button_red" type="submit" value="      Crear Nuevo Rubro      "/>
							</div>
						</form>



						<p>
							<table class="tablaDetalle" align="center" border="0">
								<tfoot align="center"/>
								<tbody>
									<tr class="encabezado">
										<td align="center">
											<strong>Editar</strong>
										</td>
										<td>
											<p align="center">
												<strong>Codigo</strong>
											</p>
										</td>

										<td>
											<p align="center">
												<strong>Descripcion</strong>
											</p>
										</td>

										<td align="center">
											<strong>Colector</strong>
										</td>

										<td>
											<p align="center">
												<strong>Convenio</strong>
											</p>
										</td>
									</tr>
									<xsl:for-each select="ConsultaRubrosOutput/Fila">


										<tr class="detalle">
											<td>
												<p align="center">
													<a>
														<xsl:attribute name="href">Transaccion.aspx?Transaccion=ConsultaRubros&amp;Filtro=~/XML/WEBRubros/ActualizarRubro.xsl&amp;ID=<xsl:value-of select="ID"/>&amp;IDColector=<xsl:value-of select="Colector"/>&amp;IDConvenio=<xsl:value-of select="Convenio"/></xsl:attribute>

														<img hspace="1" src="imagenes/go.gif" align="center" border="0" alt="Administrar el Rubro"/>
													</a>
												</p>
											</td>
											<td>
												<p align="center">
													<xsl:value-of select="Codigo"/>
												</p>
											</td>
											<td>
												<p align="Left">
													<xsl:value-of select="Descripcion"/>
												</p>
											</td>
											<td>
												<p align="center">
													<xsl:value-of select="DescripcionColector"/>
												</p>
											</td>
											<td>
												<p align="center">
													<xsl:value-of select="DescripcionConvenio"/>
												</p>
											</td>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
							<form action="Transaccion.aspx" method="post">
								<input type="hidden" name="Transaccion" value="ConsultaColectores"/>
								<input type="hidden" name="Filtro" value="XML/WEBRubros/ConsultaColectoresRubro.xsl"/>
								<div align="center">
									<input name="BotonSalvar" class="button_red" type="submit" value="      Salir      "/>
								</div>
							</form>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ConsultaRubros.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
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