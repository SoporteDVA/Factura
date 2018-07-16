<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
			</head>
			<xsl:choose>
				<xsl:when test="ConsultaClasePlacaOutput">
					<xsl:for-each select="ConsultaClasePlacaOutput">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConsultaClasePlacaSiteOutput">
					<xsl:for-each select="ConsultaClasePlacaSiteOutput">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<div align="center">
						<br/>
						<font class="tituloAzulClaro">
							<xsl:value-of select="ConsultaClasePlacaFault/Respuesta"/>
						</font>
						<br/>
						<br/>
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</html>
	</xsl:template>

	<xsl:template name="Consulta">
		<body onload="document.forms[0].NUMPLACA.focus();">
			<form action="Transaccion.aspx" method="post">
				<input type="hidden" name="Transaccion" value="ConsultarPagosGeneral"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
				<input type="hidden" name="Filtro" value="XML/General/ConsultaGeneral.xsl"/>
				<br/>
				<table align="center" width="500" border="0">
					<tr>
						<td width="50%">
							<p align="center">
								<img align="baseline" src="imagenes/Polizas.PNG" border="0" width="100px" height="100px"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Consulta de Póliza General</font>
						</td>
					</tr>
				</table>
				<br/>
				<table class="tabla" align="center">
					<tr>
						<td class="etiqueta">Clase Placa :</td>
						<td colSpan="3" class="detalle">
							<select class="campo" name="CLASEPLACA">
								<xsl:for-each select="ClasesPlaca/Fila">
									<xsl:if test="Codigo='PART'">
										<option value="{Codigo}" selected="selected">
											<xsl:value-of select="Descripcion"/>
										</option>
									</xsl:if>
									<xsl:if test="Codigo!='PART'">
										<option value="{Codigo}">
											<xsl:value-of select="Descripcion"/>
										</option>
									</xsl:if>
								</xsl:for-each>
							</select>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Número Placa :</td>
						<td colSpan="3">
							<input size="37" name="NUMPLACA" maxlength="10" class="campo" ID="Text1"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Código Gobierno :</td>
						<td colSpan="3" class="detalle">
							<select class="campo" name="CODGOBIERNO">
								<xsl:for-each select="CodigosGobierno/Fila">
									<xsl:if test="Codigo='PAR'">
										<option value="{Codigo}" selected="selected">
											<xsl:value-of select="Descripcion"/>
										</option>
									</xsl:if>
									<xsl:if test="Codigo!='PAR'">
										<option value="{Codigo}">
											<xsl:value-of select="Descripcion"/>
										</option>
									</xsl:if>
								</xsl:for-each>
							</select>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Periodo:</td>
						<td class="detalle" colSpan="3">
							<select class="campo" name="PERIODO">
								<option value="2012">2012</option>
								<option value="2013">2013</option>
								<option value="2014" >2014</option>
								<option value="2015" selected="">2015</option>
								<option value="2016">2016</option>
								<option value="2017">2017</option>
								<option value="2018">2018</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
								
							</select>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Incluye Póliza "Su Vida"</td>
						<td class="detalle" colSpan="3">
							<select class="campo" name="INDPOLIZASV">
								<option value="1" selected="">Si</option>
								<option value="0">No</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Incluye Póliza "Responsabilidad Civil"</td>
						<td class="detalle" colSpan="3">
							<select class="campo" name="INDPOLIZARESCIVIL">
								<option value="1" selected="">Si</option>
								<option value="0">No</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Incluye Póliza "Asistencia en Carretera"</td>
						<td class="detalle" colSpan="3">
							<select class="campo" name="INDPOLIZAAC">
								<option value="1" selected="">Si</option>
								<option value="0">No</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Incluye Póliza "Cobertura Adicional"</td>
						<td class="detalle" colSpan="3">
							<select class="campo" name="INDCOBERTURA">
								<option value="1" selected="">Si</option>
								<option value="0">No</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Incluye Póliza "Mas Protección"</td>
						<td class="detalle" colSpan="3">
							<select class="campo" name="INDPROTECCION">
								<option value="1" selected="">Si</option>
								<option value="0">No</option>
							</select>
						</td>
					</tr>
				</table>

				<div align="center">
					<input name="Consultar" class="Button_red" type="button" value="Consultar" onclick="if (document.forms[0].NUMPLACA.value == '') alert('Digite el número de placa.'); else submit();"/>
				</div>
			</form>
		</body>
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