<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Busqueda de Pagos para Autorizar Reversion</title>
				<link rel="stylesheet" href="jquery.ui.all.css" type="text/css"/>
				<link rel="stylesheet" href="jquery-ui.css" type="text/css"/>
				<link rel="stylesheet" href="STEstilos.css" type="text/css"/>
				<link rel="stylesheet" href="jquery.ui.datepicker" type="text/css"/>
				<script src="jquery.min.js"></script>
				<script src="jquery-ui.min.js"></script>
				<style>body{
                    font: 62.5% "Trebuchet MS", sans-serif;
                    margin: 50px;
                    }
                    .demoHeaders {
                    margin-top: 2em;
                    }
                    #dialog-link {
                    padding: .4em 1em .4em 20px;
                    text-decoration: none;
                    position: relative;
                    }
                    #dialog-link span.ui-icon {
                    margin: 0 5px 0 0;
                    position: absolute;
                    left: .2em;
                    top: 50%;
                    margin-top: -8px;
                    }
                    #icons {
                    margin: 0;
                    padding: 0;
                    }
                    #icons li {
                    margin: 2px;
                    position: relative;
                    padding: 4px 0;
                    cursor: pointer;
                    float: left;
                    list-style: none;
                    }
                    #icons span.ui-icon {
                    float: left;
                    margin: 0 4px;
                    }
                    .fakewindowcontain .ui-widget-overlay {
                    position: absolute;
                    }
                    select {
                    width: 200px;
                    }</style>
				<script>$(function() {
					var currentDate = new Date();
                    $( ".Calendario" ).datepicker({
                    closeText: 'Cerrar',
                    prevText: 'Ant',
                    nextText: 'Sig',
                    currentText: 'Hoy',
                    monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                    monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
                    dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
                    dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
                    dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
                    weekHeader: 'Sm',
                    dateFormat: 'dd/mm/yy',
                    firstDay: 1,
					defaultDate: new Date(),
                    isRTL: false,
					showMonthAfterYear: false,
                    yearSuffix: ''
                    });
					$(".Calendario").datepicker("setDate", currentDate);
                    });</script>
			</head>
			<xsl:choose>
				<xsl:when test="ConsultaPagosxFechaOutput">
					<xsl:for-each select="ConsultaPagosxFechaOutput">
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
			<body></body>
		</html>
	</xsl:template>
	<xsl:template name="Consulta">
		<form action="Transaccion.aspx" method="post">
			<input name="Transaccion" type="hidden" value="BitacoraCJDetalleTodos"/>
			<input name="Filtro" type="hidden" value="XML/Reversiones/CJDetalle.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
			<!--<input name="Fecha" type="hidden"/>-->
			<br/>
			<table align="center" width="500" border="0">
				<tr>
					<td width="50%" align="center">
						<font class="tituloAzulClaro">Consulta de Pagos a Autorizar por Placa o Formulario y Oficina</font>
					</td>
				</tr>
			</table>
			<br/>
			<table class="tabla" align="center">
				
				<td class="etiqueta">PLACA O FORMULARIO:
						<input name="Numero" type="text"/>
					</td>
					<td align="center" class="etiqueta">El Valor en blanco traerá todos los pagos del día!!</td>
			</table>
			<br/>
			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta">Seleccione la Oficina :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="Oficina">
							<xsl:for-each select="Oficinas/Fila">
								<option value="{Codigo}">
									<xsl:value-of select="Nombre"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
			</table>
			<br/>
			<p>
				<div align="center">
					<input name="Reporte" class="button_red" type="button" value="Consultar" onclick="submit();"/>
				</div>
			</p>
		</form>
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