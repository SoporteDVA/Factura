<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión de los programas de Credito</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
			</head>
			<body>



				<p>&#xA0;</p>
				<p align="center">

					<td width="100%">
						<font class="tituloAzulClaro">Programas de Credito de la Caja</font>
					</td>
				</p>
				<p>

					<form action="Transaccion.aspx" method="post">
						<input type="hidden" name="Transaccion" value="ConsultaCajas"/>
						<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
						<input type="hidden" name="Filtro" value="XML/Gestion/AgregarPrograma.xsl"/>
						<input type="hidden" value="{ConsultaProgramasOutput/Cajas/Fila/NumeroCaja}" name="NumeroCaja"/>
						<br/>
					<div align="center">
					<input name="Crear" class="button_red" type="button" value="Crear Programa" onclick="if (document.forms[0].NumeroCaja.value == '') alert('No hay número de caja.'); else submit();"/>
					</div>
					</form>



					<!--<td>
						<div align="center">
							<input name="BtnCerrar" class="button_marchamos" type="button" value="CREAR PROGRAMA"
							       onclick="cargar(this,'Transaccion.aspx?Transaccion=AgregarCaja&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/AgregarCaja.xsl','Transaccion')"/>
						</div>
					</td>
					<td>
						<p align="center">
							<a>
								<xsl:attribute name="href">Transaccion.aspx?Transaccion=ActualizarProgramas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarPrograma.xsl&amp;NumeroCaja=<xsl:value-of select="ConsultaProgramasOutput/Cajas/Fila/NumeroCaja"/>&amp;CodigoPlan=<xsl:value-of select="ConsultaProgramasOutput/Cajas/Fila/CodigoPlan"/></xsl:attribute>
								<xsl:value-of select="CodigoPlan"/>
								<img hspace="1" src="imagenes/Caja.gif" align="center" border="0" alt="Administrar Programa"/>
							</a>
						</p>
					</td>-->
				</p>
				<form action="--WEBBOT-SELF--" method="post">
					<p>
						<table class="tablaDetalle" align="center" border="0">
							<tfoot align="center"/>
							<tbody>
								<tr class="encabezado">
									<td align="center">
										<strong>Programa</strong>
									</td>
									<td>
										<p align="center">
											<strong>Numero Caja</strong>
										</p>
									</td>
									<!--<td>
										<p align="center">
											<strong>Recaudador</strong>
										</p>
									</td>-->
									<td>
										<p align="center">
											<strong>Descripción</strong>
										</p>
									</td>

									<td align="center">
										<strong>Tipo</strong>
									</td>
								</tr>
								<xsl:for-each select="ConsultaProgramasOutput/Cajas/Fila">
									<tr class="detalle">
										<td>
											<p align="center">
												<a>
													<xsl:attribute name="href">Transaccion.aspx?Transaccion=ActualizarProgramas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarPrograma.xsl&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;CodigoPlan=<xsl:value-of select="CodigoPlan"/></xsl:attribute>
													<xsl:value-of select="CodigoPlan"/>
													<img hspace="1" src="imagenes/Caja.gif" align="center" border="0" alt="Administrar Programa"/>
												</a>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:value-of select="NumeroCaja"/>
											</p>
										</td>
										<td>
											<p align="Left">
												<xsl:value-of select="Nombre"/>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:value-of select="Tipo"/>
											</p>
										</td>

										<!--<td class="detalle">
											<p align="right">
												<xsl:call-template name="Estado">
													<xsl:with-param name="Codigo" select="Estado"/>
												</xsl:call-template>
											</p>
										</td>-->
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</p>

					<!--<xsl:call-template name="Botones"/>-->
				</form>
				<div align="center">

				<input name="BtnCerrar" type="button" class="button_gris" value="      Volver      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajasVirtuales&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajasProgramas.xsl','Transaccion')"/>
				</div>
				<p>&#xA0;</p>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="Botones">
		<table align="center" border="0" style="; width: 338px; height: 30px">
			<tbody>
				<tr>
					<td width="50%">
						<p align="left">
							<button onclick="AgregarCaja();">
								<div align="center">
									<strong>Agregar</strong>
								</div>
							</button>
						</p>
					</td>
					<td/>
					<td/>
					<td/>
					<td/>
				</tr>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template name="Estado">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 1">Activo</xsl:when>
			<xsl:when test="$Codigo = 0">Inactivo</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ConsultaCajas.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
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