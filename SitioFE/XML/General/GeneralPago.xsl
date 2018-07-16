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
				<xsl:choose>
					<xsl:when test="/PagarPolizaGeneralFault">
						<table width="500" align="center" border="0">
							<tbody>
								<tr>
									<td align="center" width="50%">
										<img align="baseline" src="imagenes/Polizas.PNG" border="0" width="60px" height="60px"/>
									</td>
									<td width="50%">
										<font class="tituloAzulClaro">
											<xsl:value-of select="PagarPolizasFault/Respuesta"/>
										</font>
									</td>
								</tr>
							</tbody>
						</table>
					</xsl:when>
					<xsl:otherwise>
						<table width="500" align="center" border="0">
							<tbody>
								<tr>
									<td align="center" width="50%">
										<img height="60" hspace="0" src="imagenes/ins.gif" align="baseline" border="0"/>
									</td>
									<td width="50%">
										<font class="tituloAzulClaro">Pago de Pólizas General</font>
									</td>
								</tr>
							</tbody>
						</table>
						<table class="tabla" width="400" align="center">
							<tbody>
								<tr class="etiqueta">
									<td>Número de placa:</td>
									<td class="detalle">
										<xsl:value-of select="/PagarPolizasOutput/SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA"/>-
										<xsl:value-of select="/PagarPolizasOutput/SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA"/>-
										<xsl:value-of select="/PagarPolizasOutput/SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO"/>
									</td>
								</tr>
								<br/>
								<br/>
								<tr class="detalle">
									<td width="50%" align="center" colspan="2">
										<xsl:value-of select="/PagarPolizasOutput/Respuesta"/>
									</td>
								</tr>
							</tbody>
						</table>
						<br/>
						<form action="Transaccion.aspx">
							<div align="center">
								<!--<input name="BotonPagar" type="button" value="     Duplicado   " onclick="if (document.forms[0].CEDPERSONATRAM.value == '') alert('Digite el número de Cédula de La Persona que Pago el Marchamo!'); else submit();"/>-->
								<input name="OtraConsulta" class="Button_gris" type="button" value="Otra consulta"
								       onclick="cargar(this,'Transaccion.aspx?Transaccion=PolizaGeneral&amp;servidorSTX=infoware.STX.Gestion&amp;Filtro=~/XML/General/ConsultarGeneral.xsl','Transaccion')"/>
							</div>
						</form>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>

<xsl:template match="PagarPolizasOutput">
	
</xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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