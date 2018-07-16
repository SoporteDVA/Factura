<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Consulta de Pagos x Tipo</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
				<link href="jquery-ui.css" rel="stylesheet" type="text/css"/>
				<link href="jquery.datatables.yadcf.css" rel="stylesheet" type="text/css"/>
				<link rel="stylesheet" type="text/css" href="jquery.dataTables.css"/>
				<script src="jquery.min.js"></script>
				<script src="jquery-ui.min.js"></script>
				<script src="jquery.dataTables.yadcf.js"></script>
				<script type="text/javascript" charset="utf8" src="jquery.dataTables.min.js"></script>
				<script type="text/javascript" src="datepicker/prototype.js"></script>
				<script type="text/javascript" src="datepicker/scriptaculous.js"></script>
				<script type="text/javascript" src="datepicker/datepicker.js"></script>
				<link rel="stylesheet" type="text/css" href="datepicker/datepicker.css"/>
				<script language="javascript">function sendForm() {
				if (document.forms[0].FechaPara.value == '') {
				alert('Favor Indicar el día');
				} else {
				document.forms[0].Fecha.value = ddMMYYYY_to_YYYYMMdd(document.forms[0].FechaPara.value);
				document.forms[0].submit()
				}
				}</script>

				<style type="text/css">body {
				font-family:Century Gothic;
				font-size:12px;
				font-weight:bold; }</style>
				<style>.label {
				padding: 0px 10px 0px 10px;
				border: 1px solid #ccc;
				-moz-border-radius: 1em; /* for mozilla-based browsers */
				-webkit-border-radius: 1em; /* for webkit-based browsers */
				border-radius: 1em; /* theoretically for *all* browsers*/
				}
				.label.lightblue {
				background-color: #99CCFF;
				}
				#external_filter_container_wrapper {
				margin-bottom: 20px;
				}
				#external_filter_container {
				display: inline-block;
				}</style>
				<script>$(document).ready(function(){
				$('#pagosremotos').dataTable().yadcf([
				{column_number : 0},
				{column_number : 1,  filter_type: "range_number", filter_container_id: "external_filter_container"},
				{column_number : 2, data: ["Yes", "No"], filter_default_label: "Select Yes/No"},
				{column_number : 3, text_data_delimiter: ",", filter_type: "auto_complete"},
				{column_number : 4, column_data_type: "html", html_data_type: "text", filter_default_label: "Select tag"}]);
				});</script>
			</head>
			<xsl:choose>
				<xsl:when test="ConsultaFormularioExactoOutput">
					<xsl:for-each select="ConsultaFormularioExactoOutput">
						<xsl:call-template name="PagosBIT"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConsultaOficinasOutput">
					<xsl:for-each select="ConsultaOficinasOutput">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<center>
						<xsl:call-template name="Consulta"/>
					</center>
				</xsl:otherwise>
			</xsl:choose>
			<body>
				<!--<script type="text/javascript">
				var dpck	= new DatePicker({
				relative	: 'date-from',
				language	: 'sp'
				});
				</script>-->
			</body>
		</html>
	</xsl:template>

	<xsl:template name="Consulta">
		

        	<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="ConsultaFormularioExacto"/>
			<input type="hidden" name="Filtro" value="XML/virtual/ConsultaFormularioExacto.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
			<br/>
			<p>
			<div align="center" class="tituloAzulClaro">Consulta de Formulario Especifico</div>
			</p>
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">COMPROBANTE :</td>
					<td class="detalle" colSpan="3">
						<input name="Comprobante" onkeypress="return soloNumeros(event)" maxlength="40"/>
					</td>
				</tr>
				
			</table>
			<br/>
			<div align="center">
				<input name="BotonSalvar" class="button_red" type="submit" value="      CONSULTAR      "/>
				
			</div>
		</form>
		
	</xsl:template>
	<xsl:template name="PagosBIT">
		<div align="center">
			<font class="tituloAzulClaro">Detalle de Comprobante Especifico</font>
		</div>
		<br/>
		<table class="tabla" align="center">
			<tbody>
				<tr class="etiqueta">
					<!--<td>#Sucursal</td>-->
					<td align="center">Sucursal</td>
					<td>Caja</td>
					<td>Usuario</td>
					<td>Comprobante</td>
					<td>Transaccion</td>
					<td>Placa</td>
					<td>Estado</td>
					<td>Fecha</td>
					<td>Total</td>
					<!--<td>Direccion Exacta</td>
					<td>Origen</td>-->
				</tr>


				<xsl:for-each select="Pagos/Fila">
					<tr>
						<!-- Escoge el formato de la fila, si es reversión, se pone en rojo   -->
						<xsl:choose>
							<xsl:when test="Estado='Duplicado Generado' or Estado='Pago'">
								<xsl:attribute name="class">tablaDuplicado</xsl:attribute>
							</xsl:when>
							<xsl:when test="Estado='Reversion'  or Estado='Sin Utilizar'">
								<xsl:attribute name="class">tablaConError</xsl:attribute>
							</xsl:when>
							<xsl:when test="Estado='PP' or Estado='DP'">
								<xsl:attribute name="class">tablaPendiente</xsl:attribute>
							</xsl:when>
							<xsl:when test="Reversion='1'">
								<xsl:attribute name="class">tablaResaltado</xsl:attribute>
							</xsl:when>
							<xsl:when test="Reversion!='1' and Estado='PG' and (NumeroRecibo='0' or NumeroRecibo='Sin Imprimir')">
								<xsl:attribute name="class">tablaSinImprimir</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="class">detalle</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>

						<td align="center">
							<xsl:value-of select="Suc"/>--<xsl:value-of select="Sucursal"/></td>

						<td align="left">
							<xsl:value-of select="NumeroCaja"/>
						</td>
						<td align="justify">
							<xsl:value-of select="substring-after(Usuario,'\')"/>
						</td>
						<td>
							<xsl:value-of select="Comprobante"/>
						</td>

						<td>
							<xsl:value-of select="NumeroTransaccion"/>
						</td>

						<td align="justify">
							<xsl:value-of select="Placa"/>
						</td>
						<td align="justify">
							<xsl:value-of select="Estado"/>
						</td>
						<td align="justify">
							<xsl:value-of select="Fecha"/>
						</td>
						<td>¢<xsl:value-of select="format-number(TotalPago,'###,###,###,##0')"/></td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\Compartida\PASEAPRODUCCIONMARCHAMOS\Marchamos\XML\CierreMasivoCajas\ConsultaCierreCajasDetallado.xml"
		          htmlbaseurl="..\..\..\Compartida\PASEAPRODUCCIONMARCHAMOS\Marchamos\XML\CierreMasivoCajas\192.168.1.9" outputurl="" processortype="saxon8" useresolver="yes" profilemode="4" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\..\Compartida\PASEAPRODUCCIONMARCHAMOS\Proyectos\STX-NET\DVANew\xml\BitacoraCJResumen.xml" srcSchemaRoot="BitacoraCJResumen" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="/">
				<block path="html/body/xsl:if/=[0]" x="46" y="62"/>
				<block path="html/body/xsl:if" x="92" y="64"/>
				<block path="html/body/xsl:if/table/tbody/xsl:for-each" x="52" y="64"/>
				<block path="html/body/xsl:if/table/tbody/tr[1]/td[2]/p/strong/xsl:value-of" x="12" y="64"/>
				<block path="html/body/xsl:if/table/tbody/tr[1]/td[3]/p/strong/xsl:value-of" x="92" y="24"/>
				<block path="html/body/xsl:if[1]/=[0]" x="86" y="62"/>
				<block path="html/body/xsl:if[1]" x="132" y="64"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->