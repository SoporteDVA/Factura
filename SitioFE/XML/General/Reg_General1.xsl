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
				<script type="text/javascript" src="datepicker/prototype.js"></script>
				<script type="text/javascript" src="datepicker/scriptaculous.js"></script>
				<script type="text/javascript" src="datepicker/datepicker.js"></script>
				<script language="javascript">function revisarRangoFechas() {
						var FechaDesde=document.forms[0].FechaDesde;
						var FechaHasta=document.forms[0].FechaHasta;					
						if (FechaDesde.value == '') {
							alert('Favor Indicar Fecha Desde!');
						} else if (FechaHasta.value == '') {
							alert('Favor Indicar Fecha Hasta!');
						} else if (FechaDesde.value > FechaHasta.value) {
							alert('Revise por favor las fechas desde/hasta!');
						} 
						if (FechaIngreso.value == '') {
							alert('Favor Indicar Fecha de Ingreso del Vehículo!');
							} 
						document.forms[0].submit();
				
					}</script>
				<style type="text/css">div.datepicker {
 position: absolute;
 text-align: center;
 border: 1px #C4D5E3 solid;
 font-family: arial;
}
div.datepicker-header {
 font-size: 12px;
 font-weight: bold;
 background: #e9eff4;
 border-bottom:1px solid #c4d5e3;
 padding: 2px;
}
div.datepicker-footer {
 font-size: 10px;
 background: #e9eff4;
 border-top:1px solid #c4d5e3;
 cursor: pointer;
 text-align: center;
 padding: 2px;
}
div.datepicker-calendar {
 font-size: 10px;
 background:#FFFFFF;
 padding: 2px;
 text-align: center;
}
div.datepicker-calendar table {
 font-size: 10px;
 border: 1px white solid;
 margin: 0px;
 padding: 0px;
 text-align: center;
}
div.datepicker-calendar table tr {
 border: 1px white solid;
 margin: 0px;
 padding: 0px;
}
div.datepicker-calendar table td {
 border: 1px #eaeaea solid;
 margin: 0px;
 padding: 0px;
 text-align: center;
}
div.datepicker-calendar table td:hover, 
div.datepicker-calendar table td.outbound:hover,
div.datepicker-calendar table td.today:hover {
 border: 1px #c4d5e3 solid;
 background: #e9eff4;
 cursor: pointer;
}
div.datepicker-calendar table td.wday {
 border: 1px #ffffff solid;
 background: #ffffff;
 cursor: text;
}
div.datepicker-calendar table td.outbound {
 background: #e8e4e4;
}
div.datepicker-calendar table td.today {
 border: 1px #16518e solid;
 background: #c4d5e3;
}</style>
			</head>
			<body>
				<table width="400" align="center" border="0">
					<tbody>
						<tr>
							<td align="center" width="50%">
								<img height="60" hspace="0" src="imagenes/ins.gif" align="baseline" border="0"/>
							</td>
							<td width="50%">
								<font class="tituloAzulClaro">Renovación de Póliza General</font>
							</td>
						</tr>
					</tbody>
				</table>
				<xsl:choose>
					<xsl:when test="ConsultarPolizaGeneralOutput">
						<xsl:apply-templates select="ConsultarPolizaGeneralOutput"/>
						<center>
							<h1>
								<xsl:value-of select="ConsultarPolizaGeneralOutput/Respuesta"/>
							</h1>
						</center>
											</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>
								<xsl:value-of select="ConsultarPolizaGeneralFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="/ConsultarPolizaGeneralOutput">
		<table class="tabla" width="400" align="center">
			<tbody>
				<tr class="etiqueta">
					<td>Número de placa:</td>
					<td class="detalle">
						<xsl:value-of select="/ConsultarPolizaGeneralOutput/ENCABEZADO/CLASEPLACA"/>-
						<xsl:value-of select="/ConsultarPolizaGeneralOutput/ENCABEZADO/NUMPLACA"/>-
						<xsl:value-of select="/ConsultarPolizaGeneralOutput/ENCABEZADO/CODGOBIERNO"/>
					</td>
				</tr>
			</tbody>
		</table>
		<br/>
		<xsl:if test="COD_RESULT =0">
			<table class="tabla" width="400" align="center">
				<tbody>
					<td width="50%" class="etiqueta" colspan="3">
						<div align="center" class="tituloAzulClaro">Información de la Póliza</div>
					</td>
					<tr class="etiqueta">
						<td>Nombre Propietario:</td>
						<td class="detalle">
							<xsl:value-of select="/ConsultarPolizaGeneralOutput/NOMPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>
							<xsl:call-template name="Descripcion">
								<xsl:with-param name="TipoIdPersonaPropietario" select="/ConsultarPolizaGeneralOutput/TIPOIDPERSONAPROPIETARIO"/>
							</xsl:call-template>:</td>
						<td class="detalle">
							<xsl:value-of select="/ConsultarPolizaGeneralOutput/CEDPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Numero Motor:</td>
						<td class="detalle">
							<xsl:value-of select="/ConsultarPolizaGeneralOutput/NUMMOTOR"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Numero Chasis:</td>
						<td class="detalle">
							<xsl:value-of select="/ConsultarPolizaGeneralOutput/NUMCHASIS"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Modelo:</td>
						<td class="detalle">
							<xsl:value-of select="/ConsultarPolizaGeneralOutput/ANOMODELO"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Fecha Ingreso:</td>
						<td class="detalle">
							<xsl:value-of select="/ConsultarPolizaGeneralOutput/FECINGRESOPAIS"/>
						</td>
					</tr>
				</tbody>
			</table>
			<form action="Transaccion.aspx" method="post" onsubmit="return VerificarData();">
				<input type="hidden" name="Transaccion" value="RenovarPolizaGeneralINS"/>
				<input type="hidden" name="Filtro" value="XML/General/GeneralRenovar.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
				<input type="hidden" name="CLASEPLACA" value="{/ConsultarPolizaGeneralOutput/ENCABEZADO/CLASEPLACA}"/>
				<input type="hidden" name="NUMPLACA" value="{/ConsultarPolizaGeneralOutput/ENCABEZADO/NUMPLACA}"/>
				<input type="hidden" name="CODGOBIERNO" value="{/ConsultarPolizaGeneralOutput/ENCABEZADO/CODGOBIERNO}"/>
				<input type="hidden" name="Registrar" value="1"/>
				<!--<input type="hidden" name="FechaInicial" value="{/ConsultarPolizaGeneralOutput/FECFVPOLIZAGeneral}"/>
				<input type="hidden" name="FechaFinal" value="{/ConsultarPolizaGeneralOutput/FECFVPOLIZAGeneral}"/>
	-->			<!-- Revisar estos valores -->
				<!-- -->
				<!--<div align="center" class="tituloAzulClaro">Información de la Póliza</div>
				<br/>-->
				<table align="center" class="tabla">
					<tr>
						<td class="etiqueta">Fecha Inicio de Vigencia :</td>
						<td colSpan="3">
							<input id="date-from" name="FechaInicial"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Fecha Final de Vigencia :</td>
						<td colSpan="3">
							<input id="date-to" name="FechaFinal"/>
						</td>
					</tr>
				</table>
				<br/>
				<div align="center">
					<input name="BotonSalvar" type="submit" value="      Renovar      "/>
					<input name="BtnCerrar" type="button" value="      Cerrar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=FlotillaConsultar&amp;ServidorSTX=infoware.STX.Flotilla&amp;Filtro=~/XML/Flotillas/ConsultaFlotillas.xsl','Transaccion')"/>
				</div>
			</form>
		</xsl:if>
		<script type="text/javascript">var dpck	= new DatePicker({
          relative	: 'date-from',
          language	: 'sp'
          });</script>
		<script type="text/javascript">var dpck	= new DatePicker({
          relative	: 'date-to',
          language	: 'sp'
          });</script>
	</xsl:template>
	<xsl:template name="Descripcion" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		<xsl:param name="TipoIdPersonaPropietario" select="."/>
		<xsl:choose>
			<xsl:when test="$TipoIdPersonaPropietario = 0">Cedula Fisica nacional</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 1">Cedula de Residencia</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 4">Cedula Institucion Autonoma</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 5">Indocumentados</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 6">Documento Unico</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 8">Permiso de Trabajo</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 9">Pasaporte</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 15">Cedula Refugiados</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 16">Cedula Asociada a Tramites</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2007. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios/><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->