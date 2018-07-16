<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Proceso Conciliacion BNCR</title>
				<!--<link rel="stylesheet" href="jquery.ui.all.css" type="text/css"/>
				<link rel="stylesheet" href="jquery-ui.css" type="text/css"/>-->
				<link rel="stylesheet" href="STEstilos.css" type="text/css"/>
				<!--<link rel="stylesheet" href="jquery.ui.datepicker" type="text/css"/>
				<link rel="stylesheet" type="text/css" href="filtergrid.css" media="screen"/>-->
				<!--<script type="text/javascript" src="jquery-1.11.0.min.js"></script>
				<script type="text/javascript" src="excel.js"></script>-->
				<!--<script src="jquery.min.js"></script>
				<script src="jquery-ui.min.js"></script>
				<script type="text/javascript" src="Buscar.js"></script>-->
				<!--<style>body{
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
                              });</script>-->
			</head>
			<xsl:choose>
				<xsl:when test="ConciliacionBNCROutput">
					<xsl:for-each select="ConciliacionBNCROutput">
						<xsl:call-template name="DetallePagosConsulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="EstadosOutput">
					<xsl:for-each select="EstadosOutput/Resultado">
						<xsl:call-template name="Carga"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConsultaArchivoBNCROutput">
					<xsl:for-each select="ConsultaArchivoBNCROutput">
						<xsl:call-template name="DetallePagosConsulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConciliacionBNCRFault">
					<xsl:for-each select="ConciliacionBNCRFault">
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
	<xsl:template name="Carga">
		<form action="Transaccion.aspx" method="post" target="_blank">
			<input type="hidden" name="Transaccion" value="ConciliacionBNCR"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="Filtro" value="XML/WEBCierreNC/CargaArchivoBNCR.xsl"/>
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
						<font class="tituloAzulClaro">Carga de Archivo Conciliacion del Banco Nacional de Costa Rica</font>
						<font class="tituloAzulClaro"></font>
					</td>
				</tr>
			</table>
			<table align="center" width="500" border="0" class="tabla">
				<tr>
					<td class="etiqueta">Nombre del Archivo</td>
					<td class="detalle" colSpan="3">
						<input name="NombreArchivo" size="50"/>
					</td>
				</tr>
				<!--<tr>
					<td class="etiqueta">Nombre o Direccion IP del equipo donde esta el Archivo</td>

					<td class="detalle" colSpan="3">
						<input name="IDEquipo" size="50"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Nombre Carpeta Compartida</td>
					<td class="detalle" colSpan="3">
						<input name="CarpetaCompartida" size="50"/>
					</td>
				</tr>-->
			</table>
			<p>
				<div align="center">
					<input name="Carga" class="button_red" type="button" value="Cargar" onclick="if (document.forms[0].NombreArchivo.value == '') alert('Debe indicar un nombre de archivo'); else submit();"/>
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
						<fONT class="tituloAzulClaro">Informacion del Archivo Cargado</fONT>
					</td>
				</tr>
				<tr>
					<td width="30%">
					</td>
					<td>
						<p class="tituloAzulClaro">
							<fONT class="tituloAzulClaro">Numero de Registro:</fONT>
							<xsl:value-of select="Resultado/Fila/RegistroProceso"/>
						</p>
					</td>
				</tr>
				<tr>
					<td width="30%">
					</td>
					<td>

						<p class="tituloAzulClaro">
							<fONT class="tituloAzulClaro">Fecha Carga:</fONT>
							<xsl:value-of select="FechaCarga"/>
						</p>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<input type="button" value="SALIR" class="button_gris" onclick="self.close()"/>
		<br/>
		<br/>

		<xsl:for-each select="Resultado">
			<div width="100%" align="left">
				<!--<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="Estados"/>
					<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGListaConciliacionesBNCR.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
					<input name="BotonCerrar" class="button" type="submit" value="  «« Realizar Otra Consulta   "/>
				</form>-->
				<table class="tabla" width="50%">
					<thead>
						<tr>
							<th colspan="7" class="etiquetaBNCR">Totales BNCR</th>
						</tr>
						<tr class="etiquetaBNCR">
							<th>Nota Credito</th>
							<th>Monto Total</th>
							<th>100% Comision</th>
							<th>40% Comision BNCR</th>
							<th>60% Comision BNCR</th>
							<th>Monto Rubros sin Comision</th>
							<th>Cantidad Pagos</th>
						</tr>
					</thead>
					<tbody class="detalle">
						<td>
							<xsl:value-of select="Fila/NotaCreditoBNCR"/>
						</td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number(sum(Fila/TotalPago),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number(sum(Fila/Comision),'###,###,###,##0.00')"/></td>

						<td class="detalle" align="right">¢<xsl:value-of select="format-number((sum(Fila/Comision)*0.4),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number((sum(Fila/Comision)*0.6),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number((sum(Fila/MontoRubrosSinComision)-sum(Fila/ComisionReal)),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="center">
							<xsl:value-of select="format-number(count(Fila/ID),'#')"/>
						</td>
					</tbody>
				</table>
				<br/>
				<table class="tabla" width="50%">
					<thead>
						<tr>
							<th colspan="5" class="etiqueta">Totales DAVIVIENDA</th>
						</tr>
						<tr class="etiqueta">
							<th>Monto Total</th>
							<th>100% Comision</th>
							<th>60% Comision Local</th>
							<th>40% Comision Local</th>
							<th>Cantidad Pagos</th>
						</tr>
					</thead>
					<tbody>

						<td class="detalle" align="right">¢<xsl:value-of select="format-number(sum(Fila/TotalPagoLocal),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number(sum(Fila/ComisionLocal),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number((sum(Fila/ComisionLocal)*0.6),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number((sum(Fila/ComisionLocal)*0.4),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="center">
							<xsl:value-of select="format-number(count(Fila[DocumentoLocal&gt;0]),'#')"/>
						</td>
					</tbody>
				</table>
			</div>

			<br/>
			<table class="tabla">
				<thead>
					<tr class="etiqueta">

						<th colspan="12" class="etiquetaBNCR">Datos del Archivo BNCR a Conciliar</th>
						<th colspan="2" class="etiquetaDAV">Diferencias</th>
						<th colspan="6">Datos Registrados en Banco DAVIVIENDA</th>
					</tr>
					<tr>

						<th class="etiquetaBNCR">S<br/>E<br/>R<br/>V<br/>I<br/>C<br/>I<br/>O</th>
						<th class="etiquetaBNCR">C<br/>O<br/>N<br/>V<br/>E<br/>N<br/>I<br/>O</th>
						<th class="etiquetaBNCR">Factura</th>
						<th class="etiquetaBNCR">Valor<br/>Servicio<br/>(Numero)</th>
						<th class="etiquetaBNCR">Documento</th>
						<th class="etiquetaBNCR">Periodo</th>
						<th class="etiquetaBNCR">Fecha Pago</th>
						<th class="etiquetaBNCR">Impuesto</th>
						<th class="etiquetaBNCR">Total</th>
						<th class="etiquetaBNCR">Comision</th>
						<th class="etiquetaBNCR">Rubros<br/>sin Comision</th>
						<th class="etiquetaBNCR">Monto<br/>sin Comision</th>
						<th class="etiquetaDAV">Dif. <br/>Totales</th>
						<th class="etiquetaDAV">Dif. <br/>Comision</th>
						<th class="etiqueta">Doc. local</th>
						<th class="etiqueta">Numero Local</th>
						<th class="etiqueta">Monto Local</th>
						<th class="etiqueta">Comision Local</th>
						<th class="etiqueta">Impuesto Local</th>
						<th class="etiqueta">Periodo<br/>Local</th>
					</tr>
				</thead>
				<tbody>

					<xsl:for-each select="Fila">
						<tr>
							<!--Escoge el formato de la fila, si es reversión, se pone en rojo   -->
							<xsl:choose>
								<xsl:when test="Estado='PG'">
									<xsl:attribute name="class">detalleCON</xsl:attribute>
								</xsl:when>
								<xsl:when test="Estado='Reversion' or Estado='PE' or Estado='SVE'">
									<xsl:attribute name="class">tablaConError</xsl:attribute>
								</xsl:when>
								<xsl:when test="Estado='PP' or Estado='DP'">
									<xsl:attribute name="class">tablaPendiente</xsl:attribute>
								</xsl:when>
								<xsl:when test="DiferenciaMonto=800">
									<xsl:attribute name="class">tablaResaltado</xsl:attribute>
								</xsl:when>
								<xsl:when test="Reversion!='1' and Estado='PG' and (NumeroRecibo='0' or NumeroRecibo='Sin Imprimir')">
									<xsl:attribute name="class">tablaSinImprimir</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="class">detalleCON</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>

							<td align="center" class="detalle">
								<xsl:value-of select="format-number(Colector,'###')"/>
							</td>
							<td align="center" class="detalle">
								<xsl:value-of select="format-number(Convenio,'###')"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(Factura,'#')"/>
							</td>
							<td align="left">
								<xsl:value-of select="Numero"/>
							</td>
							<td align="center">
								<xsl:value-of select="format-number(Comprobante,'#')"/>
							</td>

							<td align="center">
								<xsl:value-of select="Periodo"/>
							</td>

							<td align="justify">
								<xsl:value-of select="substring(FechaPago,7,2)"/>/<xsl:value-of select="substring(FechaPago,5,2)"/>/<xsl:value-of select="substring(FechaPago,1,4)"/></td>
							<td align="right">
								<xsl:value-of select="format-number(Impuesto,'###,###,###,##0.00')"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(Comision,'###,###,###,##0.00')"/>
							</td>
							<td align="center">
								<xsl:value-of select="RubrosSinComision"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(MontoRubrosSinComision,'###,###,###,##0.00')"/>
							</td>

							<td align="right">
								<xsl:choose>
									<xsl:when test="DiferenciaMonto&gt;0">
										<xsl:attribute name="class">detalleCONDIF</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="class">detalleCONDIF</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:value-of select="format-number(DiferenciaMonto,'###,###,###,##0.00')"/>
							</td>


							<td align="right">
								<xsl:choose>
									<xsl:when test="DiferenciaComision&gt;0">
										<xsl:attribute name="class">detalleCONDIF</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="class">detalleCONDIF</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:value-of select="format-number(DiferenciaComision,'###,###,###,##0.00')"/>
							</td>



							<td align="center">
								<xsl:value-of select="DocumentoLocal"/>
							</td>
							<td align="left">
								<xsl:value-of select="NumeroLocal"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(TotalPagoLocal,'###,###,###,##0.00')"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(ComisionLocal,'###,###,###,##0.00')"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(ImpuestoLocal,'###,###,###,##0.00')"/>
							</td>

							<td align="right" colspan="2">
								<xsl:value-of select="PeriodoLocal"/>
							</td>
						</tr>
					</xsl:for-each>
					<tr>
						<td class="etiquetaBNCR"/>
						<td class="etiquetaBNCR"/>
						<td class="etiquetaBNCR"/>
						<td class="etiquetaBNCR"/>
						<td class="etiquetaBNCR"/>
						<td class="etiquetaBNCR"/>
						<td class="etiquetaBNCR">Totales :
							<strong><![CDATA[ ]]></strong>
						</td>
						<td class="etiquetaBNCR" align="right">
							<xsl:value-of select="format-number(sum(Fila/Impuesto),'###,###,###,##0.00')"/>
						</td>

						<td class="etiquetaBNCR" align="right">
							<xsl:value-of select="format-number(sum(Fila/TotalPago),'###,###,###,##0.00')"/>
						</td>
						<td class="etiquetaBNCR" align="right">

							<xsl:value-of select="format-number(sum(Fila/Comision),'###,###,###,##0.00')"/>
						</td>
						<td class="etiquetaBNCR" align="center">

							<xsl:value-of select="format-number(sum(Fila/RubrosSinComision),'#')"/>
						</td>
						<td class="etiquetaBNCR" align="right">

							<xsl:value-of select="format-number(sum(Fila/MontoRubrosSinComision),'###,###,###,##0.00')"/>
						</td>
						<td align="right">
							<xsl:choose>
								<xsl:when test="sum(Fila/DiferenciaMonto)&gt;0">
									<xsl:attribute name="class">etiquetaDAV</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="class">etiquetaDAV</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>

							<xsl:value-of select="format-number(sum(Fila/DiferenciaMonto),'###,###,###,##0.00')"/>
						</td>
						<td align="right">
							<xsl:choose>
								<xsl:when test="sum(Fila/DiferenciaComision)&gt;0">
									<xsl:attribute name="class">etiquetaDAV</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="class">etiquetaDAV</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>

							<xsl:value-of select="format-number(sum(Fila/DiferenciaComision),'###,###,###,##0.00')"/>
						</td>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta" align="right">
							<xsl:value-of select="format-number(sum(Fila/TotalPagoLocal),'###,###,###,##0.00')"/>
						</td>
						<td class="etiqueta" align="right">
							<xsl:value-of select="format-number(sum(Fila/ComisionLocal),'###,###,###,##0.00')"/>
						</td>
						<td class="etiqueta" align="right">
							<xsl:value-of select="format-number(sum(Fila/ImpuestoLocal),'###,###,###,##0.00')"/>
						</td>
						<td class="etiqueta"/>
					</tr>
				</tbody>
			</table>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="DetallePagosConsulta">
		<div align="center">
			<table align="center">
				<tr>
					<td width="30%">
						<p align="center">
							<img align="baseline" src="imagenes/DVAEnc.JPG"/>
						</p>
					</td>
					<td>
						<fONT class="tituloAzulClaro">Informacion del Archivo Cargado</fONT>
					</td>
				</tr>
				<tr>
					<td width="30%">
					</td>
					<td>
						<p class="tituloAzulClaro">
							<fONT class="tituloAzulClaro">Numero de Registro:</fONT>
							<xsl:value-of select="Resultado/Fila/RegistroProceso"/>
						</p>
					</td>
				</tr>
				<tr>
					<td width="30%">
					</td>
					<td>

						<p class="tituloAzulClaro">
							<fONT class="tituloAzulClaro">Fecha Carga:</fONT>
							<xsl:value-of select="FechaCarga"/>
						</p>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<input type="button" value="SALIR" class="button_gris" onclick="self.close()"/>
		<br/>
		<br/>

		<xsl:for-each select="Resultado">
			<div width="100%" align="left">
				<!--<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="Estados"/>
					<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGListaConciliacionesBNCR.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
					<input name="BotonCerrar" class="button" type="submit" value="  «« Realizar Otra Consulta   "/>
				</form>-->
				<table class="tabla" width="50%">
					<thead>
						<tr>
							<th colspan="7" class="etiquetaBNCR">Totales BNCR</th>
						</tr>
						<tr class="etiquetaBNCR">
							<th>Nota Credito</th>
							<th>Monto Total</th>
							<th>100% Comision</th>
							<th>40% Comision BNCR</th>
							<th>60% Comision BNCR</th>
							<th>Monto Rubros sin Comision</th>
							<th>Cantidad Pagos</th>
						</tr>
					</thead>
					<tbody class="detalle">
						<td>
							<xsl:value-of select="Fila/NotaCreditoBNCR"/>
						</td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number(sum(Fila/TotalPago),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number(sum(Fila/Comision),'###,###,###,##0.00')"/></td>

						<td class="detalle" align="right">¢<xsl:value-of select="format-number((sum(Fila/Comision)*0.4),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number((sum(Fila/Comision)*0.6),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number((sum(Fila/MontoRubrosSinComision)-sum(Fila/ComisionReal)),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="center">
							<xsl:value-of select="format-number(count(Fila/ID),'#')"/>
						</td>
					</tbody>
				</table>
				<br/>
				<table class="tabla" width="50%">
					<thead>
						<tr>
							<th colspan="5" class="etiqueta">Totales DAVIVIENDA</th>
						</tr>
						<tr class="etiqueta">
							<th>Monto Total</th>
							<th>100% Comision</th>
							<th>60% Comision Local</th>
							<th>40% Comision Local</th>
							<th>Cantidad Pagos</th>
						</tr>
					</thead>
					<tbody>

						<td class="detalle" align="right">¢<xsl:value-of select="format-number(sum(Fila/TotalPagoLocal),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number(sum(Fila/ComisionLocal),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number((sum(Fila/ComisionLocal)*0.6),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="right">¢<xsl:value-of select="format-number((sum(Fila/ComisionLocal)*0.4),'###,###,###,##0.00')"/></td>
						<td class="detalle" align="center">
							<xsl:value-of select="format-number(count(Fila[DocumentoLocal&gt;0]),'#')"/>
						</td>
					</tbody>
				</table>
			</div>

			<br/>
			<table class="tabla">
				<thead>
					<tr class="etiqueta">

						<th colspan="12" class="etiquetaBNCR">Datos del Archivo BNCR a Conciliar</th>
						<th colspan="2" class="etiquetaDAV">Diferencias</th>
						<th colspan="7">Datos Registrados en Banco DAVIVIENDA</th>
					</tr>
					<tr>

						<th class="etiquetaBNCR">S<br/>E<br/>R<br/>V<br/>I<br/>C<br/>I<br/>O</th>
						<th class="etiquetaBNCR">C<br/>O<br/>N<br/>V<br/>E<br/>N<br/>I<br/>O</th>
						<th class="etiquetaBNCR">Factura</th>
						<th class="etiquetaBNCR">Valor<br/>Servicio<br/>(Numero)</th>
						<th class="etiquetaBNCR">Documento</th>
						<th class="etiquetaBNCR">Periodo</th>
						<th class="etiquetaBNCR">Fecha Pago</th>
						<th class="etiquetaBNCR">Impuesto</th>
						<th class="etiquetaBNCR">Total</th>
						<th class="etiquetaBNCR">Comision</th>
						<th class="etiquetaBNCR">Rubros<br/>sin Comision</th>
						<th class="etiquetaBNCR">Monto<br/>sin Comision</th>
						<th class="etiquetaDAV">Dif. <br/>Totales</th>
						<th class="etiquetaDAV">Dif. <br/>Comision</th>
						<th class="etiqueta">Info</th>
						<th class="etiqueta">Doc. local</th>
						<th class="etiqueta">Numero Local</th>
						<th class="etiqueta">Monto Local</th>
						<th class="etiqueta">Comision Local</th>
						<th class="etiqueta">Impuesto Local</th>
						<th class="etiqueta">Periodo<br/>Local</th>
					</tr>
				</thead>
				<tbody>

					<xsl:for-each select="Fila">
						<tr>
							<!--Escoge el formato de la fila, si es reversión, se pone en rojo   -->
							<xsl:choose>
								<xsl:when test="Estado='PG'">
									<xsl:attribute name="class">detalleCON</xsl:attribute>
								</xsl:when>
								<xsl:when test="Estado='Reversion' or Estado='PE' or Estado='SVE'">
									<xsl:attribute name="class">tablaConError</xsl:attribute>
								</xsl:when>
								<xsl:when test="Estado='PP' or Estado='DP'">
									<xsl:attribute name="class">tablaPendiente</xsl:attribute>
								</xsl:when>
								<xsl:when test="DiferenciaMonto=800">
									<xsl:attribute name="class">tablaResaltado</xsl:attribute>
								</xsl:when>
								<xsl:when test="Reversion!='1' and Estado='PG' and (NumeroRecibo='0' or NumeroRecibo='Sin Imprimir')">
									<xsl:attribute name="class">tablaSinImprimir</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="class">detalleCON</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>



							<td align="center" class="detalle">
								<xsl:value-of select="format-number(Colector,'###')"/>
							</td>
							<td align="center" class="detalle">
								<xsl:value-of select="format-number(Convenio,'###')"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(Factura,'#')"/>
							</td>
							<td align="left">
								<xsl:value-of select="Numero"/>
							</td>
							<td align="center">
								<xsl:value-of select="format-number(Comprobante,'#')"/>
							</td>

							<td align="center">
								<xsl:value-of select="Periodo"/>
							</td>

							<td align="justify">
								<xsl:value-of select="substring(FechaPago,7,2)"/>/<xsl:value-of select="substring(FechaPago,5,2)"/>/<xsl:value-of select="substring(FechaPago,1,4)"/></td>
							<td align="right">
								<xsl:value-of select="format-number(Impuesto,'###,###,###,##0.00')"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(Comision,'###,###,###,##0.00')"/>
							</td>
							<td align="center">
								<xsl:value-of select="RubrosSinComision"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(MontoRubrosSinComision,'###,###,###,##0.00')"/>
							</td>

							<td align="right">
								<xsl:choose>
									<xsl:when test="DiferenciaMonto&gt;0">
										<xsl:attribute name="class">detalleCONDIF</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="class">detalleCONDIF</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:value-of select="format-number(DiferenciaMonto,'###,###,###,##0.00')"/>
							</td>


							<td align="right">
								<xsl:choose>
									<xsl:when test="DiferenciaComision&gt;0">
										<xsl:attribute name="class">detalleCONDIF</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="class">detalleCONDIF</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:value-of select="format-number(DiferenciaComision,'###,###,###,##0.00')"/>
							</td>
							<td align="center">
								<a href="#" class="balloon">
									<xsl:value-of select="ID"/>

									<div align="center">
										<table>
											<xsl:choose>
												<xsl:when test="TotalPagoLocal&gt;0">
													<xsl:attribute name="class">tablaToolTip</xsl:attribute>
												</xsl:when>
												<xsl:when test="DocumentoLocal =''">
													<xsl:attribute name="class">tablaConError</xsl:attribute>
												</xsl:when>
												<xsl:otherwise>
													<xsl:attribute name="class">tablaToolTipP</xsl:attribute>
												</xsl:otherwise>
											</xsl:choose>
											<thead>

												<th colspan="2" class="etiqueta">Informacion LOCAL<br/>Detalle del Documento  <xsl:value-of select="DocumentoLocal"/></th>
											</thead>
											<xsl:choose>
												<xsl:when test="DocumentoLocal !=''">
													<tbody class="tablaDetalle">
														<tr>
															<td>Documento :</td>
															<td align="left">
																<xsl:value-of select="DocumentoLocal"/>
															</td>
														</tr>
														<tr>
															<td>Numero :</td>
															<td>
																<xsl:value-of select="NumeroLocal"/>
															</td>
														</tr>
														<tr>
															<td>Servicio :</td>
															<td>
																<xsl:value-of select="ColectorLocal"/>- <xsl:value-of select="DescColectorLocal"/></td>
														</tr>
														<tr>
															<td>Convenio :</td>
															<td>
																<xsl:value-of select="ConvenioLocal"/>- <xsl:value-of select="DescConvenioLocal"/></td>
														</tr>
														<tr>
															<td>Fecha :</td>
															<td>
																<xsl:value-of select="FechaPagoLocal"/>
															</td>
														</tr>
														<tr>

															<td>Periodo :</td>
															<td>
																<xsl:choose>
																	<xsl:when test="substring(PeriodoLocal,1,2)='00'">
																		<xsl:value-of select="substring(PeriodoLocal,7,2)"/>-<xsl:value-of select="substring(PeriodoLocal,3,4)"/></xsl:when>
																	<xsl:when test="substring(PeriodoLocal,1,2)='20'">
																		<xsl:value-of select="substring(PeriodoLocal,7,2)"/>-<xsl:value-of select="substring(PeriodoLocal,5,2)"/>-<xsl:value-of select="substring(PeriodoLocal,1,4)"/></xsl:when>
																</xsl:choose>
															</td>
														</tr>
														<tr>
															<td>Factura :</td>
															<td>
																<xsl:value-of select="format-number(NumeroFacturaLocal,'#')"/>
															</td>
														</tr>
														<tr>
															<td>Monto :</td>
															<td>
																<xsl:value-of select="format-number(TotalPagoLocal,'###,###.00')"/>
															</td>
														</tr>
														<tr>
															<td>Comision :</td>
															<td>
																<xsl:value-of select="format-number(ComisionLocal,'###,###.00')"/>
															</td>
														</tr>
														<xsl:choose>
															<xsl:when test="ImpuestoLocal&gt;0">
																<tr>
																	<td>Impuesto :</td>
																	<td>
																		<xsl:value-of select="format-number(ImpuestoLocal,'###,###.00')"/>
																	</td>
																</tr>
															</xsl:when>
														</xsl:choose>
														<tr>
															<td>Informacion :</td>
															<td>
																<xsl:value-of select="Informacion"/>
															</td>
														</tr>
														<tr>
															<td>Nota Credito :</td>
															<td>
																<xsl:value-of select="NotaCreditoLocal"/>
															</td>
														</tr>
													</tbody>
												</xsl:when>
												<xsl:otherwise>
													<tbody>
														<tr>
															<td>Informacion :</td>
															<td>
																<xsl:value-of select="Informacion"/>
															</td>
														</tr>
													</tbody>
												</xsl:otherwise>
											</xsl:choose>
										</table>
									</div>
								</a>
							</td>



							<td align="center">
								<xsl:value-of select="DocumentoLocal"/>
							</td>
							<td align="left">
								<xsl:value-of select="NumeroLocal"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(TotalPagoLocal,'###,###,###,##0.00')"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(ComisionLocal,'###,###,###,##0.00')"/>
							</td>
							<td align="right">
								<xsl:value-of select="format-number(ImpuestoLocal,'###,###,###,##0.00')"/>
							</td>

							<td align="right" colspan="2">
								<xsl:value-of select="PeriodoLocal"/>
							</td>
						</tr>
					</xsl:for-each>
					<tr>
						<td class="etiquetaBNCR"/>
						<td class="etiquetaBNCR"/>
						<td class="etiquetaBNCR"/>
						<td class="etiquetaBNCR"/>
						<td class="etiquetaBNCR"/>
						<td class="etiquetaBNCR"/>

						<td class="etiquetaBNCR">Totales :
							<strong><![CDATA[ ]]></strong>
						</td>
						<td class="etiquetaBNCR" align="right">
							<xsl:value-of select="format-number(sum(Fila/Impuesto),'###,###,###,##0.00')"/>
						</td>

						<td class="etiquetaBNCR" align="right">
							<xsl:value-of select="format-number(sum(Fila/TotalPago),'###,###,###,##0.00')"/>
						</td>
						<td class="etiquetaBNCR" align="right">

							<xsl:value-of select="format-number(sum(Fila/Comision),'###,###,###,##0.00')"/>
						</td>
						<td class="etiquetaBNCR" align="center">

							<xsl:value-of select="format-number(sum(Fila/RubrosSinComision),'#')"/>
						</td>
						<td class="etiquetaBNCR" align="right">

							<xsl:value-of select="format-number(sum(Fila/MontoRubrosSinComision),'###,###,###,##0.00')"/>
						</td>
						<td align="right">
							<xsl:choose>
								<xsl:when test="sum(Fila/DiferenciaMonto)&gt;0">
									<xsl:attribute name="class">etiquetaDAV</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="class">etiquetaDAV</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>

							<xsl:value-of select="format-number(sum(Fila/DiferenciaMonto),'###,###,###,##0.00')"/>
						</td>
						<td align="right">
							<xsl:choose>
								<xsl:when test="sum(Fila/DiferenciaComision)&gt;0">
									<xsl:attribute name="class">etiquetaDAV</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="class">etiquetaDAV</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>

							<xsl:value-of select="format-number(sum(Fila/DiferenciaComision),'###,###,###,##0.00')"/>
						</td>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta" align="right">
							<xsl:value-of select="format-number(sum(Fila/TotalPagoLocal),'###,###,###,##0.00')"/>
						</td>
						<td class="etiqueta" align="right">
							<xsl:value-of select="format-number(sum(Fila/ComisionLocal),'###,###,###,##0.00')"/>
						</td>
						<td class="etiqueta" align="right">
							<xsl:value-of select="format-number(sum(Fila/ImpuestoLocal),'###,###,###,##0.00')"/>
						</td>
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
				<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGResumenFechaOficina.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="   Volver   "/>
			</form>
		</div>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="ConciliacionBNCROutput" userelativepaths="yes" externalpreview="no" url="ConciliacionBNCROutput.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="ConciliacionBNCROutput.xml" srcSchemaRoot="ConciliacionBNCROutput" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="/">
				<block path="html/xsl:choose" x="262" y="0"/>
				<block path="html/xsl:choose/xsl:when/xsl:for-each" x="372" y="0"/>
				<block path="html/xsl:choose/xsl:when/xsl:for-each/xsl:call-template" x="322" y="18"/>
				<block path="html/xsl:choose/xsl:when[1]/xsl:for-each" x="132" y="0"/>
				<block path="html/xsl:choose/xsl:when[1]/xsl:for-each/xsl:call-template" x="202" y="18"/>
				<block path="html/xsl:choose/xsl:when[2]/xsl:for-each" x="12" y="0"/>
				<block path="html/xsl:choose/xsl:when[2]/xsl:for-each/xsl:call-template" x="82" y="18"/>
				<block path="html/xsl:choose/xsl:otherwise/center/xsl:call-template" x="322" y="76"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->