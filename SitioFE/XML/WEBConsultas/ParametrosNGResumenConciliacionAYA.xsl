<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Bitacora de Pagos AYA</title>
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
				<xsl:when test="ConsultaNotasCreditoFromPagosOutput">
					<xsl:for-each select="ConsultaNotasCreditoFromPagosOutput">
						<xsl:call-template name="DetallePagos"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="EstadosOutput/Resultado[Parametro=1]">
					<xsl:for-each select="EstadosOutput/Resultado">
						<xsl:call-template name="ConsultaResumida"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="EstadosOutput">
					<xsl:for-each select="EstadosOutput/Resultado">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConsultaNotasCreditoFromPagosFault">
					<xsl:for-each select="ConsultaNotasCreditoFromPagosFault">
						<xsl:call-template name="Mensaje"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="AYA_ConciliaReciboOutput">
					<xsl:for-each select="AYA_ConciliaReciboOutput">
						<xsl:call-template name="MensajeConciliacion"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="AYA_RevisaTransaccionesOutput">
					<xsl:for-each select="AYA_RevisaTransaccionesOutput/AYA_SBE_ValidaRemesaOutput">
						<xsl:call-template name="DetallePagosConciliacion"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="xp_ReversionServicioFault">
					<xsl:for-each select="xp_ReversionServicioFault">
						<xsl:call-template name="MensajeReversion"/>
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
			<input type="hidden" name="Transaccion" value="ConsultaNotasCreditoFromPagos"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="Filtro" value="XML/WEBConsultas/ParametrosNGResumenConciliacionAYA.xsl"/>
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
						<font class="tituloAzulClaro">Consulta de Remesas (Conciliación de Remesas)</font>
						<br/>

						<font class="tituloAzulClaro">
							<xsl:value-of select="Sesion/CajaUsuario"/>
						</font>
					</td>
				</tr>
			</table>
			<br/>
			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta">Fecha:
						<input name="Fecha" type="text" class="Calendario"/>
					</td>
					<!--<td class="etiqueta">Fecha Final:
						<input name="FechaFinal" type="text" class="Calendario"/>
					</td>-->
				</tr>
			</table>

			<br/>




			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta">Servicio :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="Colector">

							<xsl:for-each select="Colectores/Fila[normalize-space(Descripcion) = 'AYA']">
								<option value="{IDAlterno}">



									<xsl:value-of select="Descripcion"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
			</table>



			<br/>


			<p>
				<div align="center">
					<input name="Reporte" class="button_red" type="button" value="Consultar" onclick="if (document.forms[0].Fecha.value == '') alert('Debe definir una Fecha para la Consulta'); else submit();"/>
				</div>
			</p>
			<br/>
		</form>
	</xsl:template>
	<xsl:template name="ConsultaResumida">
		<form action="Transaccion.aspx" method="post">
			<input type="hidden" name="Transaccion" value="Consulta_Pagos_Usuario"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="Filtro" value="XML/WEBConsultas/ParametrosNGResumenUsuario.xsl"/>
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
						<font class="tituloAzulClaro">Consulta de Pagos Usuario Actual (Resumen)</font>
						<br/>

						<font class="tituloAzulClaro">
							<xsl:value-of select="Sesion/CajaUsuario"/>
						</font>
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
							<OPTION VALUE="PE">Pagos Erroneos</OPTION>
							<OPTION VALUE="RV">Pagos Reversados</OPTION>
							<OPTION VALUE="PP">Pagos Pendientes</OPTION>
							<OPTION value="TODOS">--TODOS--</OPTION>
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
			<br/>
		</form>
	</xsl:template>
	<xsl:template name="DetallePagosConciliacion">
		<div align="center">
			<table align="center">
				<tr>
					<td width="30%">
						<p align="center">
							<img align="baseline" src="imagenes/DVAEnc.JPG"/>
						</p>
						<p align="center">
							<fONT class="tituloAzulClaro">Conciliacion de Pagos por Remesa (nota de crédito)</fONT>
						</p>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="Estados"/>
				<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGResumenConciliacionAYA.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button" type="submit" value="  «« Realizar Otra Consulta   "/>
			</form>
		</div>
		<div align="center">
			<table align="center">
				<tr>
					<td width="30%">

						<p align="center">
							<fONT class="tituloAzulClaro">Validación con el Proveedor</fONT>
						</p>
					</td>
				</tr>
			</table>
		</div>

		<div align="center">
			<table align="center" class="tabla">
				<tr class="Etiqueta">
					<td>Resultado: <xsl:value-of select="RemesaPagosValidar/Encabezado/Resultado"/></td>
				</tr>
				<tr class="Etiqueta">
					<td>Mensaje: <xsl:value-of select="RemesaPagosValidar/Encabezado/Mensaje"/></td>
				</tr>
				<tr class="Etiqueta">
					<td>Remesa: <xsl:value-of select="RemesaPagosValidar/Encabezado/NumeroRemesa"/></td>
				</tr>
				<tr class="Etiqueta">
					<td>Monto Deposito: <xsl:value-of select="format-number((RemesaPagosValidar/Encabezado/MontoDeposito div 100),'###,###,##0.00')"/></td>
				</tr>
				<tr class="Etiqueta">
					<td>Comision: <xsl:value-of select="format-number((RemesaPagosValidar/Encabezado/MontoComision div 100),'###,###,##0.00')"/></td>
				</tr>
				<tr class="Etiqueta">
					<td>Monto Renta: <xsl:value-of select="format-number((RemesaPagosValidar/Encabezado/MontoRenta div 100),'###,###,##0.00')"/></td>
				</tr>
			</table>
		</div>
		<br/>
		<xsl:choose>
			<xsl:when test="RemesaPagosValidar/Diferencias/Recibo/NIR!='' ">
				<table id="{Fila/Oficina}" class="tabla" align="center">
					<thead>
						<tr class="etiqueta">

							<th>NIR</th>
							<th>NIS</th>
							<th>Monto</th>
							<th>Tipo Diferencia</th>
							<th>Comprobante</th>
							<th>Agencia</th>
							<th>Vencimiento</th>
							<th>Factura</th>
							<th>Moneda</th>
							<th>Conciliar</th>
						</tr>
					</thead>
					<tbody>

						<xsl:for-each select="RemesaPagosValidar/Diferencias/Recibo">
							<tr>
								<!--Escoge el formato de la fila, si es reversión, se pone en rojo   -->
								<xsl:choose>
									<xsl:when test="Estado='PG'">
										<xsl:attribute name="class">detalle</xsl:attribute>
									</xsl:when>
									<xsl:when test="Estado='RV' or Estado='PE'">
										<xsl:attribute name="class">tablaConError</xsl:attribute>
									</xsl:when>
									<xsl:when test="Estado='PP'">
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


								<td align="justify">
									<xsl:value-of select="NIR"/>
								</td>

								<td>
									<xsl:value-of select="NIS"/>
								</td>

								<td align="center">

									<xsl:value-of select="format-number((Monto div 100),'###,###,##0.00')"/>
								</td>
								<td align="center">
									<xsl:value-of select="TipDif"/>
									<xsl:choose>
										<xsl:when test="TipDif=1">
											<p align="center">Solo en AYA</p>
										</xsl:when>
										<xsl:when test="TipDif=2">
											<p align="center">Solo en Banco</p>
										</xsl:when>
										<xsl:when test="TipDif=3">
											<p align="center">Montos Diferentes</p>
										</xsl:when>

										<xsl:otherwise>Diferencia No Definida</xsl:otherwise>
									</xsl:choose>
								</td>
								<td align="center">
									<xsl:value-of select="NumComp"/>
								</td>
								<td align="center">
									<xsl:value-of select="Agencia"/>
								</td>
								<td align="center">
									<xsl:value-of select="Venc"/>
								</td>
								<td align="center">
									<xsl:value-of select="Fact"/>
								</td>
								<td align="center">
									<xsl:value-of select="Moneda"/>
								</td>


								<td align="center">
									<xsl:choose>
										<xsl:when test="TipDif=1 or TipDif=2 or TipDif=3">
											<p align="center">
												<a>
													<xsl:attribute name="href">Transaccion.aspx?Transaccion=AYA_ConciliaRecibo&amp;Recaudador=104&amp;Oficina=<xsl:value-of select="Agencia"/>&amp;Colector=<xsl:value-of select="../../../Colector"/>&amp;NotaCredito=<xsl:value-of select="../../../NotaCredito"/>&amp;Fecha=<xsl:value-of select="../../../FechaContable"/>&amp;Recibo=<xsl:value-of select="NIR"/>&amp;NIR=<xsl:value-of select="NIR"/>&amp;NIS=<xsl:value-of select="NIS"/>&amp;Monto=<xsl:value-of select="Monto"/>&amp;TipDif=<xsl:value-of select="TipDif"/>&amp;NumComp=<xsl:value-of select="NumComp"/>&amp;Agencia=<xsl:value-of select="Agencia"/>&amp;NumAut=<xsl:value-of select="NumAut"/>&amp;Venc=<xsl:value-of select="Venc"/>&amp;Fact=<xsl:value-of select="Fact"/>&amp;Moneda=<xsl:value-of select="Moneda"/>&amp;ServidorSTX=infoware.STX.Cajas&amp;Filtro=XML/WEBConsultas/ParametrosNGResumenConciliacionAYA.xsl</xsl:attribute>
													<img hspace="1" src="imagenes/vwicn032.gif" align="center" border="0" alt="Valida"/>
												</a>
											</p>
										</xsl:when>

										<xsl:otherwise>''</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<div align="center">
					<table align="center" class="tabla">
						<tr>
							<td width="30%">

								<p align="center">
									<fONT class="tituloAzulClaro">LA VALIDACION CON EL PROVEEDOR -(AYA)- NO REFLEJA DIFERENCIAS , PUEDE EJECUTAR EL CIERRE</fONT>
								</p>
							</td>
						</tr>
					</table>
				</div>

				<br/>

				<div align="center">
					<form action="Transaccion.aspx">
						<input type="hidden" name="Transaccion" value="xp_CierreServicio"/>
						<input type="hidden" name="Filtro" value="XML/WEBCierreNC/ConsultaServicioFecha.xsl"/>
						<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
						<input type="hidden" name="Colector" value="{IDColector}"/>
						<input type="hidden" name="Fecha" value="{FechaCierre}"/>
						<input type="hidden" name="Convenio" value="1"/>
						<input name="BotonCerrar" class="button_red" type="submit" value="  Cerrar Remesa   "/>
					</form>
				</div>
			</xsl:otherwise>
		</xsl:choose>


		<p align="center">
			<fONT class="tituloAzulClaro">---------------------------------------------------------------------------------</fONT>
		</p>



		<div align="center">
			<table align="center" class="tablaBNCR">
				<tr>
					<td width="30%">

						<p align="center">
							<fONT class="tituloAzulClaro">Pagos Registrados en el AYA</fONT>
						</p>
					</td>
				</tr>
			</table>
		</div>

		<div align="center">
			<table align="center" class="tabla">
				<tr class="Etiqueta">
					<td>Resultado: <xsl:value-of select="RemesaPagos/Encabezado/Resultado"/></td>
				</tr>
				<tr class="Etiqueta">
					<td>Mensaje: <xsl:value-of select="RemesaPagos/Encabezado/Mensaje"/></td>
				</tr>
				<tr class="Etiqueta">
					<td>Remesa: <xsl:value-of select="RemesaPagos/Encabezado/Remesa"/></td>
				</tr>
			</table>
		</div>
		<br/>
		<xsl:choose>
			<xsl:when test="RemesaPagos/Recibos/Recibo/NIR!='' ">
				<table id="{Fila/Oficina}" class="tabla" align="center">
					<thead>
						<tr class="etiqueta">

							<th>Tipo</th>
							<th>NIR</th>
							<th>Monto</th>
							<th>Comisión</th>
							<th>Contrato (NIS)</th>
							<th>Vencimiento</th>
							<th>Factura</th>
							<th>Autorización</th>
							<th>Comprobante</th>
							<th>Agencia</th>
							<th>Usuario</th>
						</tr>
					</thead>
					<tbody>

						<xsl:for-each select="RemesaPagos/Recibos/Recibo">
							<tr>
								<!--Escoge el formato de la fila, si es reversión, se pone en rojo   -->
								<xsl:choose>
									<xsl:when test="Estado='PG'">
										<xsl:attribute name="class">detalle</xsl:attribute>
									</xsl:when>
									<xsl:when test="Estado='RV' or Estado='PE'">
										<xsl:attribute name="class">tablaConError</xsl:attribute>
									</xsl:when>
									<xsl:when test="Estado='PP'">
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


								<td align="justify">
									<xsl:value-of select="Tip"/>
								</td>

								<td>
									<xsl:value-of select="NIR"/>
								</td>

								<td align="right">

									<xsl:value-of select="format-number((Monto div 100),'###,###,##0.00')"/>
								</td>
								<td align="right">

									<xsl:value-of select="format-number((Comision div 100),'###,###,##0.00')"/>
								</td>
								<td align="center">
									<xsl:value-of select="NIS"/>
								</td>
								<td align="center">
									<xsl:value-of select="Venc"/>
								</td>
								<td align="center">
									<xsl:value-of select="Fact"/>
								</td>
								<td align="center">
									<xsl:value-of select="NumAut"/>
								</td>
								<td align="center">
									<xsl:value-of select="NumComp"/>
								</td>
								<td align="center">
									<xsl:value-of select="Agencia"/>
								</td>
								<td align="center">
									<xsl:value-of select="Usuario"/>
								</td>

								<!--<td align="center">
							<xsl:choose>
							<xsl:when test="TipDif=1">
							<p align="center">
							<a>
							<xsl:attribute name="href">Transaccion.aspx?Transaccion=AYA_RevisaTransacciones&amp;Recaudador=54&amp;Colector=<xsl:value-of select="Servicio"/>&amp;NotaCredito=<xsl:value-of select="NotaCredito"/>&amp;FechaContable=<xsl:value-of select="FechaST"/>&amp;ServidorSTX=infoware.STX.Cajas&amp;Filtro=XML/WEBConsultas/ParametrosNGResumenConciliacionAYA.xsl</xsl:attribute>
							<img hspace="1" src="imagenes/vwicn032.gif" align="center" border="0" alt="Valida"/>
							</a>
							</p>
							</xsl:when>
							<xsl:otherwise>''</xsl:otherwise>
							</xsl:choose>
							</td>-->
							</tr>
						</xsl:for-each>
						<tr>


							<td class="etiqueta"/>
							<td class="etiqueta" align="right">Total:
								<strong><![CDATA[ ]]></strong>
							</td>
							<td class="etiqueta" align="right">
								<xsl:value-of select="format-number( (sum(RemesaPagos/Recibos/Recibo/Monto) div 100 )  ,'###,###,###,##0.00')"/>
							</td>
							<td class="etiqueta" align="right">
								<xsl:value-of select="format-number( (sum(RemesaPagos/Recibos/Recibo/Comision) div 100 )  ,'###,###,###,##0.00')"/>
							</td>

							<td class="etiqueta"/>
							<td class="etiqueta"/>
							<td class="etiqueta"/>
							<td class="etiqueta"/>
							<td class="etiqueta"/>
							<td class="etiqueta"/>
							<td class="etiqueta"/>
						</tr>
					</tbody>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<div align="center">
					<table align="center" class="tabla">
						<tr>
							<td width="30%">

								<p align="center">
									<fONT class="tituloAzulClaro">NO HAY PAGOS REGISTRADOS EN EL AYA</fONT>
								</p>
							</td>
						</tr>
					</table>
				</div>
			</xsl:otherwise>
		</xsl:choose>


		<p align="center">
			<fONT class="tituloAzulClaro">---------------------------------------------------------------------------------</fONT>
		</p>



		<div align="center">
			<table align="center">
				<tr>
					<td width="30%">

						<p align="center">
							<fONT class="tituloAzulClaro">Pagos Registrados Localmente (Banco)</fONT>
						</p>
					</td>
				</tr>
			</table>
		</div>


		<br/>
		<xsl:choose>
			<xsl:when test="PagosLocales/Fila/Consecutivo!='' ">
				<table id="{Fila/Oficina}" class="tabla" align="center">
					<thead>
						<tr class="etiqueta">

							<th>Doc. Local</th>
							<th>Cliente</th>
							<th>NIR</th>
							<th>Monto Recibo</th>
							<th>Total Pagado</th>
							<th>Comisión</th>
							<th>Autorización</th>
							<th>Remesa (NC)</th>

							<th>Fecha</th>
							<th>Medio Pago</th>
						</tr>
					</thead>
					<tbody>

						<xsl:for-each select="PagosLocales/Fila">
							<tr>
								<!--Escoge el formato de la fila, si es reversión, se pone en rojo   -->
								<xsl:choose>
									<xsl:when test="Estado='PG'">
										<xsl:attribute name="class">detalle</xsl:attribute>
									</xsl:when>
									<xsl:when test="Estado='RV' or Estado='PE'">
										<xsl:attribute name="class">tablaConError</xsl:attribute>
									</xsl:when>
									<xsl:when test="Estado='PP'">
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




								<td align="justify">
									<xsl:value-of select="format-number((Consecutivo),'#')"/>
								</td>

								<td>
									<xsl:value-of select="NombreCliente"/>
								</td>
								<td align="center">
									<xsl:value-of select="NIR"/>
								</td>

								<td align="right">

									<xsl:value-of select="format-number((MontoRecibo div 100),'###,###,##0.00')"/>
								</td>
								<td align="right">

									<xsl:value-of select="format-number((TotalPago div 100),'###,###,##0.00')"/>
								</td>
								<td align="right">

									<xsl:value-of select="format-number((Comision div 100),'###,###,##0.00')"/>
								</td>

								<td align="center">
									<xsl:value-of select="format-number((NumeroAutorizacion),'#')"/>
								</td>
								<td align="center">
									<xsl:value-of select="NotaCredito"/>
								</td>
								<td align="center">
									<xsl:value-of select="FechaHora"/>
								</td>

								<xsl:choose>
									<xsl:when test="MedioPago=1">
										<td align="center">Solo en AYA</td>
									</xsl:when>
									<xsl:when test="MedioPago=2">
										<td align="center">Solo en Banco</td>
									</xsl:when>
									<xsl:when test="MedioPago=3">
										<td align="center">Montos Diferentes</td>
									</xsl:when>
									<xsl:otherwise>
										<td align="center">Diferencia No Definida</td>
									</xsl:otherwise>
								</xsl:choose>




								<!--<td align="center">
							<xsl:choose>
							<xsl:when test="TipDif=1">
							<p align="center">
							<a>
							<xsl:attribute name="href">Transaccion.aspx?Transaccion=AYA_RevisaTransacciones&amp;Recaudador=54&amp;Colector=<xsl:value-of select="Servicio"/>&amp;NotaCredito=<xsl:value-of select="NotaCredito"/>&amp;FechaContable=<xsl:value-of select="FechaST"/>&amp;ServidorSTX=infoware.STX.Cajas&amp;Filtro=XML/WEBConsultas/ParametrosNGResumenConciliacionAYA.xsl</xsl:attribute>
							<img hspace="1" src="imagenes/vwicn032.gif" align="center" border="0" alt="Valida"/>
							</a>
							</p>
							</xsl:when>
							<xsl:otherwise>''</xsl:otherwise>
							</xsl:choose>
							</td>-->
							</tr>
						</xsl:for-each>
						<tr>

							<td class="etiqueta"/>
							<td class="etiqueta"/>
							<td class="etiqueta" align="right">Total:
								<strong><![CDATA[ ]]></strong>
							</td>
							<td class="etiqueta" align="right">
								<xsl:value-of select="format-number( (sum(PagosLocales/Fila/TotalPago) div 100 )  ,'###,###,###,##0.00')"/>
							</td>
							<td class="etiqueta" align="right">
								<xsl:value-of select="format-number( (sum(PagosLocales/Fila/MontoRecibo) div 100 )  ,'###,###,###,##0.00')"/>
							</td>
							<td class="etiqueta" align="right">
								<xsl:value-of select="format-number( (sum(PagosLocales/Fila/Comision) div 100 ),'###,###,###,##0.00')"/>
							</td>
							<td class="etiqueta"/>
							<td class="etiqueta"/>
							<td class="etiqueta"/>
							<td class="etiqueta"/>
						</tr>
					</tbody>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<div align="center">
					<table align="center" class="tabla">
						<tr>
							<td width="30%">

								<p align="center">
									<fONT class="tituloAzulClaro">NO HAY PAGOS REGISTRADOS LOCALMENTE</fONT>
								</p>
							</td>
						</tr>
					</table>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="DetallePagos">
		<div align="center">
			<table align="center">
				<tr>
					<td width="30%">
						<p align="center">
							<img align="baseline" src="imagenes/DVAEnc.JPG"/>
						</p>
						<p align="center">
							<fONT class="tituloAzulClaro">CONSULTA DE NOTAS DE CREDITO O REMESAS DEL SERVICIO</fONT>
						</p>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<xsl:for-each select="Resultado">
			<div align="center">
				<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="Estados"/>
					<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGResumenConciliacionAYA.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
					<input name="BotonCerrar" class="button" type="submit" value="  «« Realizar Otra Consulta   "/>
				</form>
				<!--<table class="tabla">

					<thead>
						<tr class="encabezado">
							<th>Monto Total</th>
							<th>Comision Total</th>
							<th>Monto Neto</th>
							<th>Cantidad Pagos</th>
						</tr>
					</thead>
					<tbody>

						<td class="tablaSinImprimir" align="right">
							<xsl:value-of select="format-number(sum(Fila/TotalReal),'###,###,###,##0.00')"/>
						</td>
						<td class="tablaSinImprimir" align="right">
							<xsl:value-of select="format-number(sum(Fila/ComisionReal),'###,###,###,##0.00')"/>
						</td>
						<td class="tablaSinImprimir" align="right">
							<xsl:value-of select="format-number((sum(Fila/TotalReal)-sum(Fila/ComisionReal)),'###,###,###,##0.00')"/>
						</td>
						<td class="tablaSinImprimir" align="center">
							<xsl:value-of select="format-number(count(Fila/NumeroDocumento),'#')"/>
						</td>
					</tbody>
				</table>
				<br/>-->
				<!--<input class="button" type="button" onclick="tableToExcel('{Fila/Oficina}', '{Fila/Oficina}')" value="Exportar a Excel"/>-->
			</div>

			<br/>
			<table id="{Fila/Oficina}" class="tabla" align="center">
				<thead>
					<tr class="etiqueta">

						<th>Servicio</th>
						<th>Remesa (NC)</th>
						<th>Estado</th>
						<th>Fecha</th>
						<th>Validar Remesa</th>
					</tr>
				</thead>
				<tbody>

					<xsl:for-each select="Fila">
						<tr>
							<!--Escoge el formato de la fila, si es reversión, se pone en rojo   -->
							<xsl:choose>
								<xsl:when test="Estado='PG'">
									<xsl:attribute name="class">detalle</xsl:attribute>
								</xsl:when>
								<xsl:when test="Estado='RV' or Estado='PE'">
									<xsl:attribute name="class">tablaConError</xsl:attribute>
								</xsl:when>
								<xsl:when test="Estado='PP'">
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


							<td align="justify">
								<xsl:value-of select="Servicio"/>-<xsl:value-of select="NombreServicio"/></td>

							<td>
								<xsl:value-of select="NotaCredito"/>
							</td>

							<td align="center">
								<xsl:value-of select="Estado"/>
							</td>
							<td align="center">
								<xsl:value-of select="Fecha"/>
							</td>


							<td align="center">
								<xsl:choose>
									<xsl:when test="Estado='Abierta'">
										<p align="center">
											<a>
												<xsl:attribute name="href">Transaccion.aspx?Transaccion=AYA_RevisaTransacciones&amp;Recaudador=54&amp;Colector=<xsl:value-of select="Servicio"/>&amp;NotaCredito=<xsl:value-of select="NotaCredito"/>&amp;FechaContable=<xsl:value-of select="FechaST"/>&amp;IDColector=<xsl:value-of select="IDColector"/>&amp;ServidorSTX=infoware.STX.Cajas&amp;Filtro=XML/WEBConsultas/ParametrosNGResumenConciliacionAYA.xsl</xsl:attribute>
												<img hspace="1" src="imagenes/vwicn032.gif" align="center" border="0" alt="Valida"/>
											</a>
										</p>
									</xsl:when>
									<xsl:otherwise>''</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</xsl:for-each>
					<tr>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
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
						<xsl:value-of select="Respuesta"/>
					</td>
				</tr>
			</table>
			<br/>
			<br/>
		</div>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="Estados"/>
				<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGResumenConciliacionAYA.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="   Volver   "/>
			</form>
		</div>
	</xsl:template>
	<xsl:template name="MensajeConciliacion">
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

			<!--<xsl:if test="Mensaje !=''">
		<table class="tabla" align="center">
		        <tr>
					<td class="etiqueta">Mensaje de Error :</td>
					<td colSpan="3" class="detalle">						
						<xsl:value-of select="Mensaje"/>
					</td>
				</tr>
		</table></xsl:if>-->

			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta">Mensaje Conciliación  :</td>
					<xsl:if test="Respuesta !=''">
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Respuesta"/>
						</td>
					</xsl:if>
				</tr>
				<xsl:if test="Resultado/NumeroDocumento !=''">
					<tr>
						<td class="etiqueta">Número Documento:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Resultado/NumeroDocumento"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="Recibo/NIR !=''">
					<tr>
						<td class="etiqueta">Número Recibo (NIR):</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Recibo/NIR"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="Recibo/NIS !=''">
					<tr>
						<td class="etiqueta">Número (NIS):</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Recibo/NIS"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="Recibo/TipDif !=''">
					<tr>
						<td class="etiqueta">Tipo Diferencia:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Recibo/TipDif"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="Recibo/NumAut !=''">
					<tr>
						<td class="etiqueta">Autorización:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Recibo/NumAut"/>
						</td>
					</tr>
				</xsl:if>
			</table>
			<br/>
			<br/>
		</div>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="Estados"/>
				<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGResumenConciliacionAYA.xsl"/>
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