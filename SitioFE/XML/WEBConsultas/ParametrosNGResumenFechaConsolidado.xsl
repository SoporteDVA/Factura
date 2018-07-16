<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Bitacora de Pagos Detallada</title>
				<link rel="stylesheet" href="jquery.ui.all.css" type="text/css"/>
				<link rel="stylesheet" href="jquery-ui.css" type="text/css"/>
				<link rel="stylesheet" href="STEstilos.css" type="text/css"/>
				<link rel="stylesheet" href="jquery.ui.datepicker" type="text/css"/>
				<link rel="stylesheet" type="text/css" href="filtergrid.css" media="screen"/>
				<script type="text/javascript" src="jquery-1.11.0.min.js"></script>
				<script type="text/javascript" src="excel.js"></script>
				<script src="jquery.min.js"></script>
				<script src="jquery-ui.min.js"></script>
				<script type="text/javascript" src="Buscar.js"></script>
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
				<xsl:when test="Consulta_ConsolidadoOutput">
					<xsl:for-each select="Consulta_ConsolidadoOutput">
						<xsl:call-template name="DetallePagos"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="EstadosOutput">
					<xsl:for-each select="EstadosOutput/Resultado">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="Consulta_ConsolidadoFault">
					<xsl:for-each select="Consulta_ConsolidadoFault">
						<xsl:call-template name="Mensaje"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<center>
						<xsl:call-template name="Mensaje"/>
					</center>
				</xsl:otherwise>
			</xsl:choose>
			<body>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="Consulta">
		<form action="Transaccion.aspx" method="post">
			<input type="hidden" name="Transaccion" value="Consulta_Consolidado"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
      <input type="hidden" name="Oficina" value="1000"/>
			<input type="hidden" name="Filtro" value="XML/WEBConsultas/ParametrosNGResumenFechaConsolidado.xsl"/>
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
			<table align="center" width="500" border="0">
				<tr>
					<td width="50%" align="center">
						<font class="tituloAzulClaro">Consulta Consolidado de Pagos</font>
						<font class="tituloAzulClaro"></font>
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
					<td class="etiqueta">Seleccione el Servicio :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="Colector">
							<option value="1000">--TODOS--</option>
							<xsl:for-each select="Colectores/Fila">
								<option value="{IDAlterno}">
									<xsl:value-of select="Descripcion"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
			</table>
			<br/>
			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta">Estado de los Pagos:</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="EstadoPagos">
							<OPTION VALUE="PG" selected="selected">Pagos Generados</OPTION>
						</SELECT>
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
	<xsl:template name="DetallePagos">
		<div align="center">
			<table align="center">
				<tr>
					<td width="30%">
						<p align="center">
							<img align="baseline" src="imagenes/DVAEnc.JPG"/>
						</p>
					</td>
					<td>
						<fONT class="tituloAzulClaro">CONSULTA CONSOLIDADA DE RECAUDACION</fONT>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<xsl:for-each select="Resultado">
			<div width="100%" align="right">
				<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="Estados"/>
					<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGResumenFechaConsolidado.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
					<input name="BotonCerrar" class="button" type="submit" value="  «« Realizar Otra Consulta   "/>
				</form>
				<table class="tabla">

					<thead>
						<tr class="encabezado">
							<th>Total Recaudado</th>
							<th>Comision Total</th>
							<th>A depositar al Proveedor</th>
							<th>Cantidad Pagos</th>
						</tr>
					</thead>
					<tbody>

						<td class="tablaSinImprimir" align="right">¢<xsl:value-of select="format-number(sum(Fila/TotalReal),'###,###,###,##0.00')"/></td>
						<td class="tablaSinImprimir" align="right">¢<xsl:value-of select="format-number(sum(Fila/ComisionReal),'###,###,###,##0.00')"/></td>
						<td class="tablaSinImprimir" align="right">¢<xsl:value-of select="format-number((sum(Fila/TotalReal)-sum(Fila/ComisionReal)),'###,###,###,##0.00')"/></td>
						<td class="tablaSinImprimir" align="center">
							<xsl:value-of select="format-number(sum(Fila/Cantidad),'#')"/>
						</td>
					</tbody>
				</table>
				<br/>
				<input class="button" type="button" onclick="tableToExcel('{Fila/Oficina}', '{Fila/Oficina}')" value="Exportar a Excel"/>
			</div>
			<br/>
			<table id="{Fila/Oficina}" class="tabla" align="right" width="100%">
				<thead>
					<tr class="etiqueta">
						<th align="center">Fecha</th>
						<th>Servicio</th>
						<th>Cantidad</th>
						<th>Total Recaudado</th>
						<th>Comisioón Total</th>
						<th>A depositar al Proveedor</th>
						<th>Nota Crédito</th>
						<th>Fecha Déposito</th>
					</tr>
				</thead>
				<tbody>

					<xsl:for-each select="Fila">
						<tr>
							<!--Escoge el formato de la fila, si es reversión, se pone en rojo   -->
							<td align="justify" class="detalle">
								<xsl:value-of select="Fecha"/>
							</td>
							<td align="justify" class="detalle">
								<xsl:value-of select="NombreColector"/>
							</td>
							<td align="right" class="detalle">
								<xsl:value-of select="Cantidad"/>
							</td>
							<td align="right" class="detalle">
								<xsl:choose>
									<xsl:when test="Estado='PE'">0</xsl:when>
									<xsl:when test="Estado='RV'">
										<xsl:value-of select="format-number(TotalReal*-1,'###,###,###,##0.00')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="format-number(TotalReal,'###,###,###,##0.00')"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td align="right" class="detalle">
								<xsl:choose>
									<xsl:when test="Estado='PE'">0</xsl:when>
									<xsl:when test="Estado='RV'">
										<xsl:value-of select="format-number(ComisionReal*-1,'###,###,###,##0.00')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="format-number(ComisionReal,'###,###,###,##0.00')"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td align="right" class="detalle">
								<xsl:value-of select="Proveedor"/>
							</td>
							<td align="justify" class="detalle">
								<xsl:value-of select="NotaCredito"/>
							</td>
							<td align="justify" class="detalle">
								<xsl:value-of select="Deposito"/>
							</td>
						</tr>
					</xsl:for-each>
					<tr>
            <td class="etiqueta"/>
						<td class="etiqueta">Totales
							<strong><![CDATA[ ]]></strong>
						</td>
            <td class="etiqueta" align="right">
              <xsl:value-of select="format-number(sum(Fila/Cantidad),'#')"/>
            </td>
						<td class="etiqueta" align="right">
							<xsl:value-of select="format-number(sum(Fila/TotalReal),'###,###,###,##0.00')"/>
						</td>
						<td class="etiqueta" align="right">

							<xsl:value-of select="format-number(sum(Fila/ComisionReal),'###,###,###,##0.00')"/>
						</td>
            <td class="etiqueta" align="right">

              <xsl:value-of select="format-number(sum(Fila/Proveedor),'###,###,###,##0.00')"/>
            </td>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
					</tr>
				</tbody>
			</table>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="Mensaje">
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
		<div align="center">

			<table class="tabla" align="center">

				<tr>
					<td class="etiqueta">Mensaje:</td>
					<td colSpan="3">
						<xsl:value-of select="Mensaje"/>
					</td>
				</tr>
			</table>
			<br/>
			<br/>
		</div>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="Estados"/>
				<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGResumenFechaConsolidado.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="   Volver   "/>
			</form>
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