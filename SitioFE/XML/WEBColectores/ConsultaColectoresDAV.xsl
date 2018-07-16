<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión de los Colectores del Sistema EXTERNO</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
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
						<font class="tituloAzulClaro">Colectores REMOTOS para Conectividad</font>
					</td>
				</p>
				<p>

					<form action="Transaccion.aspx" method="post">
						<input type="hidden" name="Transaccion" value="Estados"/>
						<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
						<input type="hidden" name="Filtro" value="XML/WEBColectores/AgregarColectorDAV.xsl"/>
						<div align="center">
							<input name="BotonSalvar" class="button_red" type="submit" value="      Crear Colector EXTERNO     "/>
						</div>
					</form>
				</p>
				<form action="--WEBBOT-SELF--" method="post">
					<p>
						<table class="tablaDetalle" align="center" border="0">
							<tfoot align="center"/>
							<tbody>
								<tr class="encabezado">
									<td align="center">
										<strong>Editar</strong>
									</td>
									<td align="center">
										<strong>#COLECTOR BANCO</strong>
									</td>
									<td>
										<p align="center">
											<strong>DESCRIPCION</strong>
										</p>
									</td>

									<td align="center">
										<strong>ESTADO</strong>
									</td>
									<td>
										<p align="center">
											<strong>PAGINADO</strong>
										</p>
									</td>
									<td>
										<p align="center">
											<strong>CANAL</strong>
										</p>
									</td>
								</tr>
								<xsl:for-each select="ConsultaColectoresDAVOutput/Resultado/Fila">
									<tr class="detalle">
										<td>
											<p align="center">
												<a>
													<xsl:attribute name="href">Transaccion.aspx?Transaccion=ConsultaColectoresDAV&amp;Filtro=~/XML/WEBColectores/ActualizarColectorDAV.xsl&amp;colector=<xsl:value-of select="colector"/></xsl:attribute>
													<xsl:value-of select="colector"/>
													<img hspace="1" src="imagenes/go.gif" align="center" border="0" alt="Administrar el Colector"/>
												</a>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:value-of select="colector"/>
											</p>
										</td>
										<td>
											<p align="Left">
												<xsl:value-of select="nombre"/>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:choose>
													<xsl:when test="estado='V'">Valido</xsl:when>
													<xsl:otherwise>Invalido</xsl:otherwise>
												</xsl:choose>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:choose>
													<xsl:when test="paginado=1">SI</xsl:when>
													<xsl:when test="paginado=0">NO</xsl:when>
													<xsl:otherwise>SIN DEFINIR</xsl:otherwise>
												</xsl:choose>
											</p>
										</td>
										<td>
											<xsl:choose>
												<xsl:when test="string-length(canal)!= 0">
													<xsl:value-of select="canal"/>
												</xsl:when>
												<xsl:otherwise>SIN DEFINIR</xsl:otherwise>
											</xsl:choose>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</p>
				</form>

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
				</tr>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template name="Estado">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = A">Activo</xsl:when>
			<xsl:when test="$Codigo = I">Inactivo</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\RecaudacionPruebasSitios\XML\Gestion\ConsultaCajas.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator="">
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