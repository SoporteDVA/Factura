<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Bitacora de Pagos Reversados Fecha y Oficina</title>
				<link rel="stylesheet" href="jquery.ui.all.css" type="text/css"/>
				<link rel="stylesheet" href="jquery-ui.css" type="text/css"/>
				<link rel="stylesheet" href="STEstilos.css" type="text/css"/>
				<link rel="stylesheet" href="jquery.ui.datepicker" type="text/css"/>
				<script src="jquery.min.js"></script>
				<script src="jquery-ui.min.js"></script>
				<script type="text/javascript" src="excel.js">
				</script>
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
				<xsl:when test="BitacoraFechaOficinaNGResumenRVOutput">
					<xsl:for-each select="BitacoraFechaOficinaNGResumenRVOutput">
						<xsl:call-template name="PagosBIT"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConsultaCajasComboOutput">
					<xsl:for-each select="ConsultaCajasComboOutput">
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
			<input name="Transaccion" type="hidden" value="BitacoraNGResumenCajaVirtual"/>
			<input name="Filtro" type="hidden" value="XML/Cambios2014/NGResumenCajaVirtual.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
			
			<br/>
			<table align="center" width="500" border="0">
				<tr>
					<td width="50%" align="center">
						<font class="tituloAzulClaro">Parametros Consulta de Pagos Virtuales Consolidados y Detallados</font>
					</td>
				</tr>
			</table>
			<br/>
			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta">Fecha Inicial:
						<input name="FechaInicial" type="text" class="Calendario"/>
					</td>
					<td class="etiqueta">Fecha Final:
						<input name="FechaFinal" type="text" class="Calendario"/>
					</td>
				</tr>
			</table>
			<br/>
			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta">Seleccione la Caja Virtual :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="NumeroCaja">
							<xsl:for-each select="Cajas/Fila">
								<option value="{NumeroCaja}">
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
					<input name="Reporte" class="button_red" type="button" value="Consultar" onclick="if (document.forms[0].FechaInicial.value == '') alert('Debe definir una Fecha Fecha Inicial'); else submit();"/>
				</div>
			</p>
		</form>
	</xsl:template>
	<xsl:template name="PagosBIT">
		<div align="center">
			<font class="tituloAzulClaro">Detalle de Pagos Reversados</font>
		</div>
		<div align="right">
			<input class="button" type="button" onclick="tableToExcel('testTable', 'Tabla')" value="Exportar a Excel"/>
		</div>
		<br/>
		<table id="testTable" class="tabla" align="center" width="1000">
			<thead>
				<tr class="etiqueta">
					<th align="center">Sucursal</th>
					<th>Caja</th>
					<th>Origen</th>
					<th>Usuario</th>
					<th>Autoriza RV</th>
					<th>Comprobante</th>
					<th>Placa</th>
					<th>Estado</th>
					<th>Fecha</th>
					<th>Fecha Reversion</th>
					<th>Monto Original</th>
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select="Resultado/Fila">
					<tr>
						<!--Escoge el formato de la fila, si es reversión, se pone en rojo   -->
						<xsl:choose>
							<xsl:when test="Estado='Duplicado Generado'">
								<xsl:attribute name="class">tablaDuplicado</xsl:attribute>
							</xsl:when>
							<xsl:when test="Estado='Reversion' or Estado='PE' or Estado='SVE'">
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
						<td align="Left">
							<xsl:value-of select="Suc"/>--
							<xsl:value-of select="Sucursal"/>
						</td>
						<td align="left">
							<xsl:value-of select="NumeroCaja"/>-
							<xsl:value-of select="NombreCaja"/>
						</td>
						<td align="justify">
							<xsl:value-of select="Origen"/>
						</td>
						<td align="justify">
							<xsl:value-of select="substring-after(Usuario,'\')"/>
						</td>
						<td align="justify">
							<xsl:value-of select="substring-after(UsuarioAutoriza,'\')"/>
						</td>
						<td>
							<xsl:value-of select="Comprobante"/>
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
						<td align="justify">
							<xsl:value-of select="FechaReversion"/>
						</td>

						<td>

							<xsl:value-of select="format-number(MontoTransaccion,'###,###,###,##0')"/>
						</td>
					</tr>
				</xsl:for-each>
				<!-- <tr>
                              <td class = "detalle"/>
                              <td class = "detalle"/>
                              <td class = "detalle"/>
                              <td class = "detalle"/>
                              <td class = "detalle"/>
                              <td class = "detalle"/>
							  <td class = "detalle"/>
							  <td class = "detalle"/>
                              <td class = "detalle"/>
                              <td class = "detalle">
                                    Total
                                    <strong><![CDATA[ ]]></strong>
                              </td>
                              <td class = "detalleNumerico">
                                    
                                    <xsl:value-of select = "format-number(sum(Resultado/Fila/TotalPago),'###,###,###,##0')"/>
                              </td>
                              <td class = "detalle"/>
                        </tr>-->
			</tbody>
		</table>
		<div id="target" style="width: 600px; height: 400px">
		</div>
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