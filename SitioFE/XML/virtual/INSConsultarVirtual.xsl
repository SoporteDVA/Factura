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
				<input type="hidden" name="Transaccion" value="INSConsultaVirtualTipo"/>
				<input type="hidden" name="Filtro" value="XML/virtual/INSConsultaVirtual.xsl"/>
				<br/>
				<table align="center" width="500" border="0">
					<tr>
						<td width="50%">
							<p align="center">
								<img align="baseline" src="imagenes/crm.png" border="0" hspace="0" height="120" width="120"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Consulta Remota de Marchamos</font>
						</td>
					</tr>
				</table>
				<br/>
				<p>
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
						<!--<tr>
							<td class="etiqueta">Incluye Póliza "Su Vida"</td>
							<td class="detalle" colSpan="3">
								<select class="campo" name="INDPOLIZASV">
									<option value="1">Si</option>
									<option value="0" selected="">No</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Incluye Póliza "Responsabilidad Civil"</td>
							<td class="detalle" colSpan="3">
								<select class="campo" name="INDPOLIZASRESCIVIL">
									<option value="1">Si</option>
									<option value="0" selected="">No</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Incluye Póliza "Asistencia en Carretera"</td>
							<td class="detalle" colSpan="3">
								<select class="campo" name="INDPOLIZAAC">
									<option value="1">Si</option>
									<option value="0" selected="">No</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Incluye Póliza "Cobertura Adicional"</td>
							<td class="detalle" colSpan="3">
								<select class="campo" name="INDCOBERTURA">
									<option value="1">Si</option>
									<option value="0" selected="">No</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="etiqueta">Incluye Póliza "Mas Protección"</td>
							<td class="detalle" colSpan="3">
								<select class="campo" name="INDPROTECCION">
									<option value="1">Si</option>
									<option value="0" selected="">No</option>
								</select>
							</td>
						</tr>-->
					</table>
				</p>
				<p>
					<div align="center">
						<input name="Consultar" class="Button_red" type="button" value="Consulta" onclick="if (document.forms[0].NUMPLACA.value == '') alert('Digite el número de placa.'); else submit();"/>
					</div>
				</p>
			</form>
		</body>
	</xsl:template>
	<xsl:template name="ClasesPlaca">
		<select class="campo" name="CLASEPLACA">
			<option value="AB">ALAJUELA BUS</option>
			<option value="AP">ALAJUELA PÚBLICO</option>
			<option value="BM">BICIMOTOS</option>
			<option value="C">CARGA PESADA</option>
			<option value="CB">CARTAGO BUS</option>
			<option value="CL">CARGA LIVIANA</option>
			<option value="CP">CARTAGO PÚBLICO</option>
			<option value="CD">CUERPO DIPLOMATICO</option>
			<option value="D">DISCAPACITADOS</option>
			<option value="VE">VEHICULO ESPECIAL</option>
			<option value="EE">EQUIPO ESPECIAL</option>
			<option value="EXP">EXPORTACIÓN</option>
			<option value="GB">GUANACASTE BUS</option>
			<option value="GP">GUANACASTE PÚBLICO</option>
			<option value="HB">HEREDIA BUS</option>
			<option value="HP">HEREDIA PÚBLICO</option>
			<option value="LB">LIMÓN BUS</option>
			<option value="LFP">LIMITACIONES FISICAS PERMANENTES</option>
			<option value="LP">LIMÓN PÚBLICO</option>
			<option value="MOT">MOTOS</option>
			<option value="PART" selected="true">PARTICULAR</option>
			<option value="PB">PUNTARENAS BUS</option>
			<option value="PEN">PENSIONADOS</option>
			<option value="PP">PUNTARENAS PÚBLICO</option>
			<option value="SJB">SAN JOSÉ BUS</option>
			<option value="SJP">SAN JOSÉ PÚBLICO</option>
			<option value="TA">TAXI ALAJUELA</option>
			<option value="TC">TAXI CARTAGO</option>
			<option value="TG">TAXI GUANACASTE</option>
			<option value="TH">TAXI HEREDIA</option>
			<option value="TL">TAXI LIMÓN</option>
			<option value="TP">TAXI PUNTARENAS</option>
			<option value="TSJ">TAXI SAN JOSÉ</option>
			<option value="T12">TEMPORAL PERIODO 2012</option>
			<option value="T13">TEMPORAL PERIODO 2013</option>
			<option value="ZFE">ZONA FRANCA DE EXPORTACIÓN</option>
		</select>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\INS\ConsultaClasePlacaOutput.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
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