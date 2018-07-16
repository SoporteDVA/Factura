<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión de Codigos Adicionales</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
			</head>
			<body>
				<p align="center">
					<table width="358" border="0" style=" width: 358px; height: 80px">
						<thead>
							<tr>
								<td width="50%">
									<p align="center">
										<img hspace="0" src="imagenes/Generico.gif" align="baseline" border="0" width="100px" height="100px"/>
									</p>
								</td>
								<td width="50%">
									<p align="center">
										<font class="tituloAzulClaro">
											<strong>Gestión de Codigos Adicionales</strong>
										</font>
									</p>
								</td>
							</tr>
						</thead>
						<tbody>
							<tr class="detalle">
								<td class="encabezado" align="right">Cliente:</td>
								<td>
									<p align="center">
										<strong>
											<xsl:value-of select="ConsultaCodigosAdicionalesOutput/Sesion/ClienteNombre"/>
										</strong>
									</p>
								</td>
							</tr>
						</tbody>
					</table>
				</p>
								<p>

					<form action="Transaccion.aspx" method="post">
						<input type="hidden" name="Transaccion" value="ConsultaCodigosAdicionales"/>
						<input type="hidden" name="ServidorSTX" value="infoware.STX.Admin"/>
						<input type="hidden" name="Filtro" value="XML/Gestion/AgregarCodigosAdicionales.xsl"/>
						<br/>
						<div align="center">
							<input name="Crear" class="button_red" type="button" value="Crear Codigo" onclick="submit();"/>
						</div>
					</form>
					<!--<div align="center">

						<input name="BtnCerrar" type="button" class="button_gris" value="      Volver      "
						       onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajasVirtuales&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajasProgramas.xsl','Transaccion')"/>
					</div>-->



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
									<td>
										<p align="center">
											<strong>Codigo</strong>
										</p>
									</td>
									<td align="center">
										<strong>Tipo</strong>
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
										<strong>Estado</strong>
									</td>
								</tr>
								<xsl:for-each select="ConsultaCodigosAdicionalesOutput/Fila">
									<tr class="detalle">
										<td>
											<p align="left">
												<a>
													<xsl:attribute name="href">Transaccion.aspx?Transaccion=ConsultaCodigosAdicionales&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarCodigoAdicional.xsl&amp;Codigo=<xsl:value-of select="Codigo"/></xsl:attribute>
													<xsl:value-of select="Codigo"/>
													<!--<img hspace="1" src="imagenes/Devolver.gif" align="center" border="0" alt="Administrar Programa"/>-->
												</a>
											</p>
										</td>
										<td class="detalle">
											<p align="right">
												<xsl:call-template name="TipoCodigo">
													<xsl:with-param name="TipoCodigo" select="Tipo"/>
												</xsl:call-template>
											</p>
										</td>


										<td>
											<p align="Left">
												<xsl:value-of select="Descripcion"/>
											</p>
										</td>

										<td class="detalle">
											<p align="right">
												<xsl:call-template name="Estado">
													<xsl:with-param name="Codigo" select="Estado"/>
												</xsl:call-template>
											</p>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</p>

					<!--<xsl:call-template name="Botones"/>-->
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
	<xsl:template name="TipoCodigo">
		<xsl:param name="TipoCodigo" select="."/>
		<xsl:choose>
			<xsl:when test="$TipoCodigo = 5">Clase Placa</xsl:when>
			<xsl:when test="$TipoCodigo = 1">Codigo GOB</xsl:when>
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