<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:NonHtml="http://www.progress.com/StylusStudio/NonHtml" exclude-result-prefixes="NonHtml">
	<xsl:output method="html"/>

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
			</head>
			<body>
				<br/>
				<div align="center">
					<font class="tituloAzulClaro">DETALLE TRANSACCIONES CALL CENTER USUARIO ACTUAL: <xsl:value-of select="BitacoraCJDetalleOutput/Resultado/Fila/Usuario"/> </font>
				</div>
				<br/>
				<table class="tabla" align="center">
					<tbody>
						<tr class="etiqueta">
							<td>Fecha</td>
							<td>Servicio</td>
							<td>No.Documento</td>
							<td>Placa</td>
							<!--<td>Transacción</td>
							<td>Recibo</td>-->
							<td>Estado</td>
							<td>Monto</td>
						</tr>
						<xsl:for-each select="BitacoraCJDetalleOutput/Resultado/Fila">
							<tr>
								<!-- Escoge el formato de la fila, si es reversión, se pone en rojo   -->
								<xsl:choose>
									<xsl:when test="Estado='PE' or Estado='DE' or Estado='SVE'">
										<xsl:attribute name="class">tablaConError</xsl:attribute>
									</xsl:when>
									<xsl:when test="Estado='RV'">
										<xsl:attribute name="class">tablaResaltado</xsl:attribute>
									</xsl:when>
									<xsl:when test="Reversion!='1' and (Estado='PG')and(NumeroRecibo='0' or NumeroRecibo='Sin Imprimir')">
										<xsl:attribute name="class">tablaSinImprimir</xsl:attribute>
									</xsl:when>
									<xsl:when test="(Estado='DG')and(NumeroRecibo='0')">
										<xsl:attribute name="class">tablaSinImprimir</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="class">detalle</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<td>
									<xsl:value-of select="FechaHora"/>
								</td>
								<td>
									<xsl:value-of select="Servicio"/>
								</td>
								<td align="center">

									<xsl:value-of select="NumeroDocumento"/>
								</td>
								<td align="justify">
									<xsl:value-of select="ClasePlaca"/>-
									<xsl:value-of select="Numero"/>-
									<xsl:value-of select="CodigoGobierno"/>
								</td>
								<!--<td>
									<xsl:value-of select="NumeroAutorizacion"/>
								</td>
								<td>
									<xsl:value-of select="NumeroRecibo"/>
								</td>-->
								<td>
									<xsl:value-of select="EstadoDescripcion"/>
								</td>
								<td align="right">
									<xsl:choose>
										<xsl:when test="Moneda = '1'">¢</xsl:when>
										<xsl:otherwise>$</xsl:otherwise>
									</xsl:choose>
									<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
					<br/>
				<table class="tabla" align="center">
					<tbody>
						<tr class="etiqueta">
							<td>Monto Total Pagos Efectivos</td>
						</tr>


						<td align="center" class="tituloAzulClaro">
							<xsl:choose>
								<xsl:when test="Moneda = '1'">¢</xsl:when>
								<xsl:otherwise>¢</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="format-number(BitacoraCJDetalleOutput/Resultado/Fila/TotalGeneral,'###,###,###,##0.00')"/>
						</td>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="TipoComprobanteDesc">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo= 1">MARCHAMO</xsl:when>
			<xsl:when test="$Codigo= 2">SITE</xsl:when>
			<xsl:otherwise>NO ASIGNADO</xsl:otherwise>
		</xsl:choose>
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