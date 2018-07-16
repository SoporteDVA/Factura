<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes" encoding="UTF-8"/>
	<xsl:template match="/">
		<html>
			<head>
				<meta http-equiv="Pragma" content="no-cache"/>
				<link rel="stylesheet" type="text/css" href="STestilos.css"/>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"></script>
			</head>
			<body>
				<table width="500" align="center" border="0">
					<tbody>
						<tr>
							<td align="center" width="50%">
								<img align="baseline" src="imagenes/crm.png" border="0" hspace="0" height="60" width="60"/>
							</td>
							<td width="50%">
								<font class="tituloAzulClaro">Pago de recibo</font>
								<xsl:if test="INSPagoVirtualOutput/Reversion=1">
									<br/>
									<font class="mensaje">Reversión</font>
								</xsl:if>
							</td>
						</tr>
					</tbody>
				</table>
				<xsl:choose>
					<xsl:when test="PagarPolizaAGVOutput">
						<xsl:for-each select="PagarPolizaAGVOutput">
							<xsl:call-template name="PolizaAGV"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="PagarPolizaTuristaOutput">
						<xsl:for-each select="PagarPolizaTuristaOutput">
							<xsl:call-template name="PolizaTurista"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="PagarRTVOutput">
						<xsl:for-each select="PagarRTVOutput">
							<xsl:call-template name="Marchamo"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="INSPagoVirtualTMPOutput">
						<xsl:for-each select="INSPagoVirtualTMPOutput">
							<xsl:call-template name="Marchamo"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="GenerarPagoTMPOutput">
						<xsl:for-each select="GenerarPagoTMPOutput">
							<xsl:call-template name="Marchamo"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="INSPagoVirtualOutput">
						<xsl:for-each select="INSPagoVirtualOutput">
							<xsl:call-template name="Marchamo"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="PagarSuVidaOutput">
						<xsl:for-each select="PagarSuVidaOutput">
							<xsl:call-template name="PolizaSuVida"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="PagarRespCivilOutput">
						<xsl:for-each select="PagarRespCivilOutput">
							<xsl:call-template name="PolizaRespCivil"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="PagarRTVFault">
						<xsl:for-each select="PagarRTVFault">
							<xsl:call-template name="MostrarMensaje">
								<xsl:with-param name="Mensaje" select="Respuesta"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="PagarPolizaTuristaFault">
						<xsl:for-each select="PagarPolizaTuristaFault">
							<xsl:call-template name="MostrarMensaje">
								<xsl:with-param name="Mensaje" select="Respuesta"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>

					<xsl:when test="PagarPolizaAGVFault">
						<xsl:for-each select="PagarPolizaAGVFault">
							<xsl:call-template name="MostrarMensaje">
								<xsl:with-param name="Mensaje" select="Respuesta"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="PagoPolizaSuVidaFault">
						<xsl:for-each select="PagoPolizaSuVidaFault">
							<xsl:call-template name="MostrarMensaje">
								<xsl:with-param name="Mensaje" select="Respuesta"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="PagoPolizaRespCivilFault">
						<xsl:for-each select="PagoPolizaRespCivilFault">
							<xsl:call-template name="MostrarMensaje">
								<xsl:with-param name="Mensaje" select="Respuesta"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="PagarSuVidaFault">
						<xsl:for-each select="PagarSuVidaFault">
							<xsl:call-template name="MostrarMensaje">
								<xsl:with-param name="Mensaje" select="Respuesta"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="PagarRespCivilFault">
						<xsl:for-each select="PagarRespCivilFault">
							<xsl:call-template name="MostrarMensaje">
								<xsl:with-param name="Mensaje" select="Respuesta"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="INSPagoSinRTVOutput">
						<xsl:for-each select="INSPagoSinRTVOutput">
							<xsl:call-template name="Marchamo"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>

						<br/>
						<center>
							<font class="mensaje">
								<xsl:choose>
									<xsl:when test="normalize-space(INSPagoVirtualFault/Respuesta) != ''">
										<xsl:value-of select="INSPagoVirtualFault/Respuesta"/>
									</xsl:when>
									<xsl:otherwise>Ha ocurrido un error: no fue posible realizar la transacción.</xsl:otherwise>
								</xsl:choose>
							</font>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="PolizaRespCivil">
		<form action="Transaccion.aspx" method="post">
			<input type="hidden" name="Transaccion"/>
			<input type="hidden" name="Filtro"/>
			<input type="hidden" value="{NumeroDocumento}" name="NumeroDocumento"/>
			<input type="hidden" value="{DiaPago}" name="DiaPago"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA}" name="Numero"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA}" name="ClasePlaca"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO}" name="CodigoGobierno"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/PERIODO}" name="Periodo"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO}" name="Nombre"/>
			<input type="hidden" value="{Reversion}" name="Reversion"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMCAJA}" name="NumeroCaja"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/TIPCAJA}" name="TipoCaja"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION}" name="NumeroTransaccion"/>
			<input type="hidden" value="{Empresa}" name="Empresa"/>
			<input type="hidden" value="{TipoComprobante}" name="TipoComprobante"/>
			<input type="hidden" value="{Moneda}" name="Moneda"/>
			<input type="hidden" value="{Input/TotalPago}" name="TotalPago"/>
			<input type="hidden" value="{Input/Efectivo}" name="Efectivo"/>
			<input type="hidden" value="{Input/OtrosValores}" name="OtrosValores"/>
			<table class="tabla" width="400" align="center">
				<tbody>
					<tr class="etiqueta">
						<td>Número de placa:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA"/>-
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA"/>-
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO"/>
						</td>
						<td class="etiqueta">Período:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/PERIODO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
						<td class="etiqueta">Cédula:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Transacción :</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION"/>
						</td>
						<td>No. Documento :</td>
						<td class="detalle">
							<xsl:value-of select="NumeroDocumento"/>
						</td>
					</tr>
				</tbody>
			</table>
			<br/>
			<br/>
			<xsl:call-template name="Botones"/>
		</form>
	</xsl:template>
	<xsl:template name="PolizaSuVida">
		<form action="Transaccion.aspx" method="post">
			<input type="hidden" name="Transaccion"/>
			<input type="hidden" name="Filtro"/>
			<input type="hidden" value="{NumeroDocumento}" name="NumeroDocumento"/>
			<input type="hidden" value="{DiaPago}" name="DiaPago"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA}" name="Numero"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA}" name="ClasePlaca"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO}" name="CodigoGobierno"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/PERIODO}" name="Periodo"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO}" name="Nombre"/>
			<input type="hidden" value="{Reversion}" name="Reversion"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMCAJA}" name="NumeroCaja"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/TIPCAJA}" name="TipoCaja"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION}" name="NumeroTransaccion"/>
			<input type="hidden" value="{Empresa}" name="Empresa"/>
			<input type="hidden" value="{TipoComprobante}" name="TipoComprobante"/>
			<input type="hidden" value="{Moneda}" name="Moneda"/>
			<input type="hidden" value="{Input/TotalPago}" name="TotalPago"/>
			<input type="hidden" value="{Input/Efectivo}" name="Efectivo"/>
			<input type="hidden" value="{Input/OtrosValores}" name="OtrosValores"/>
			<table class="tabla" width="400" align="center">
				<tbody>
					<tr class="etiqueta">
						<td>Número de placa:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA"/>-
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA"/>-
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO"/>
						</td>
						<td class="etiqueta">Período:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/PERIODO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
						<td class="etiqueta">Cédula:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
						</td>
					</tr>
				</tbody>
			</table>
			<br/>
			<br/>
			<xsl:call-template name="Botones"/>
		</form>
	</xsl:template>
	<xsl:template name="PolizaAGV">
		<form action="Transaccion.aspx" method="post">
			<input type="hidden" name="Transaccion"/>
			<input type="hidden" name="Filtro"/>
			<input type="hidden" value="{NumeroDocumento}" name="NumeroDocumento"/>
			<input type="hidden" value="{DiaPago}" name="DiaPago"/>
			<input type="hidden" value="{OficinaOrigen}" name="OficinaOrigen"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA}" name="Numero"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA}" name="ClasePlaca"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO}" name="CodigoGobierno"/>
			<input type="hidden" value="{Periodo}" name="Periodo"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO}" name="Nombre"/>
			<input type="hidden" value="{Reversion}" name="Reversion"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMCAJA}" name="NumeroCaja"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/TIPCAJA}" name="TipoCaja"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION}" name="NumeroTransaccion"/>
			<input type="hidden" value="{TipoComprobante}" name="TipoComprobante"/>
			<input type="hidden" value="{Servicio}" name="TipoOperacion"/>
			<input type="hidden" value="{Servicio}" name="Servicio"/>
			<input type="hidden" value="{Empresa}" name="Empresa"/>
			<input type="hidden" value="{Moneda}" name="Moneda"/>
			<input type="hidden" value="{TotalPago}" name="TotalPago"/>
			<input type="hidden" value="{TotalPago}" name="Efectivo"/>
			<input type="hidden" value="0" name="OtrosValores"/>
			<div class="tituloAzulClaro" align="center">Información de la Poliza AGV</div>
			<br/>
			<table class="tabla" width="400" align="center">
				<tbody>
					<tr class="etiqueta">
						<td>Número de placa:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA"/>-
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA"/>-
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO"/>
						</td>
						<td class="etiqueta">Período:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/PERIODO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
						<td class="etiqueta">Cédula:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Transacción :</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION"/>
						</td>
						<td>No. Recibo :</td>
						<td class="detalle">
							<xsl:value-of select="NumeroRecibo"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Registrada:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/FECHA"/>
						</td>
						<td>Total:</td>
						<td class="detalleTotal">
							<b>
								<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
							</b>
						</td>
					</tr>
				</tbody>
			</table>
			<xsl:if test="SOA_CONFIRM_PAGO/RUBRO[CODRUBROPAGO &gt;0]">
				<xsl:call-template name="InfoRubrosPoliza"/>
			</xsl:if>
			<br/>
			<br/>
			<xsl:call-template name="Botones"/>
		</form>
	</xsl:template>
	<xsl:template name="PolizaTurista">
		<form action="Transaccion.aspx" method="post">
			<input type="hidden" name="Transaccion"/>
			<input type="hidden" name="Filtro"/>
			<input type="hidden" value="{NumeroDocumento}" name="NumeroDocumento"/>
			<input type="hidden" value="{DiaPago}" name="DiaPago"/>
			<input type="hidden" value="{OficinaOrigen}" name="OficinaOrigen"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA}" name="Numero"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA}" name="ClasePlaca"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO}" name="CodigoGobierno"/>
			<input type="hidden" value="{Periodo}" name="Periodo"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO}" name="Nombre"/>
			<input type="hidden" value="{Reversion}" name="Reversion"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMCAJA}" name="NumeroCaja"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/TIPCAJA}" name="TipoCaja"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION}" name="NumeroTransaccion"/>
			<input type="hidden" value="{TipoComprobante}" name="TipoComprobante"/>
			<input type="hidden" value="{Servicio}" name="TipoOperacion"/>
			<input type="hidden" value="{Servicio}" name="Servicio"/>
			<input type="hidden" value="{Empresa}" name="Empresa"/>
			<input type="hidden" value="{Moneda}" name="Moneda"/>
			<input type="hidden" value="{TotalPago}" name="TotalPago"/>
			<input type="hidden" value="{TotalPago}" name="Efectivo"/>
			<input type="hidden" value="0" name="OtrosValores"/>
			<div class="tituloAzulClaro" align="center">Información de la Poliza Turista</div>
			<br/>
			<table class="tabla" width="400" align="center">
				<tbody>
					<tr class="etiqueta">
						<td>Número de placa:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA"/>-
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA"/>-
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO"/>
						</td>
						<td class="etiqueta">Período:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/PERIODO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
						<td class="etiqueta">Cédula:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Modelo:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/ANOMODELO"/>
						</td>
						<td class="etiqueta"># Motor:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMMOTOR"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta"># Chasis / VIN:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMCHASIS"/>
						</td>
						<td class="etiqueta">No. Clase</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMCLASE"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Transacción :</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION"/>
						</td>
						<td>No. Recibo :</td>
						<td class="detalle">
							<xsl:value-of select="NumeroRecibo"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Registrada:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/FECHA"/>
						</td>
						<td>Total:</td>
						<td class="detalleTotal">
							<b>
								<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
							</b>
						</td>
					</tr>
				</tbody>
			</table>
			<br/>
			<xsl:if test="SOA_CONFIRM_PAGO/RUBRO[CODRUBROPAGO &gt;0]">
				<xsl:call-template name="InfoRubrosPoliza"/>
			</xsl:if>
			<br/>
			<xsl:call-template name="Botones"/>
		</form>
	</xsl:template>
	<xsl:template name="Botones">
		<center>
			<!-- Solo se permite modificar los pagos del día actual -->
			<xsl:if test="Edad = 0">
				<!-- Solo para el usuario que realizó la transacción -->
				<xsl:if test="not(UsuarioOrigen) or (UsuarioOrigen = Usuario)">
					<xsl:if test="(ReversionAutorizada = 1) and (Reversion = 2)and(NumeroRecibo!='0')">
						<input type="button" value="Reversar" onclick="document.forms[0].Filtro.value='XML/INS/INSEjecutaReversion.xsl';reversar('SuVidaReversion')"/>
					</xsl:if>
					<xsl:if test="Reversion = 2">
						<input type="button" value="Imprimir" onclick="this.enabled=false;document.forms[0].Filtro.value='XML/INS/INSImprimir.xsl';ejecutarComo('INSObtenerPermiso');"/>
					</xsl:if>
				</xsl:if>
				<!-- El botón de Autorizar reversión solo se presenta a los perfiles que pueden permitir reversión -->
				<xsl:if test="(ReversionAutorizada != 1) and (AutorizaReversion = 1) and (Reversion = 2) and(NumeroRecibo!='0')">
					<input type="button" value="Autorizar Reversión" onclick="document.forms[0].Filtro.value='XML/INS/INSAprobacionReversion.xsl';ejecutarComo('BitacoraAutorizarReversion');"/>
				</xsl:if>
			</xsl:if>
			<xsl:if test="Edad &gt; 0">
				<!-- Solo para el usuario que realizó la transacción -->
				<xsl:if test="not(UsuarioOrigen) or (Usuario = UsuarioOrigen)">
					<xsl:if test="Reversion &gt; 1">
						<input type="button" value="Imprimir" onclick="document.forms[0].Filtro.value='XML/INS/INSImprimir.xsl';ejecutarComo('INSObtenerPermiso');"/>
					</xsl:if>
				</xsl:if>
			</xsl:if>
			<xsl:if test="UsuarioOrigen">
				<font class="tituloAzulClaro">Cajero: <xsl:value-of select="UsuarioOrigen"/></font>
				<input type="hidden" name="UsuarioOrigen" value="{UsuarioOrigen}"/>
			</xsl:if>
		</center>
	</xsl:template>
	<xsl:template name="InfoRubrosPoliza">
		<br/>
		<table class="tabla" align="center">
			<tbody>
				<tr class="encabezado">
					<td>Código</td>
					<td>Descripción</td>
					<td>Monto</td>
				</tr>
				<xsl:for-each select="SOA_CONFIRM_PAGO/RUBRO[CODRUBROPAGO &gt;0]">
					<tr class="detalle">
						<td>
							<xsl:value-of select="CODRUBROPAGO"/>
						</td>
						<td>
							<xsl:call-template name="RubroPolizas">
								<xsl:with-param name="CodigoRubro" select="CODRUBROPAGO"/>
							</xsl:call-template>
						</td>
						<td class="detalleNumerico">
							<xsl:value-of select="format-number(MONTOTRUBRO,'###,###,###,##0.00')"/>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template name="RubroPolizas">
		<xsl:param name="CodigoRubro" select="."/>
		<xsl:choose>
			<xsl:when test="$CodigoRubro = 1">APORTE SEGURO OBLIGATORIO DE AUTOMOVIL</xsl:when>
			<xsl:when test="$CodigoRubro = 2">PRIMA SEGURO OBLIGATORIO DE AUTOMOVIL</xsl:when>
			<xsl:when test="$CodigoRubro = 3">IMPUESTO DE VENTAS</xsl:when>
			<xsl:when test="$CodigoRubro = 4">APORTE LEY 4% BOMBEROS</xsl:when>
			<xsl:otherwise>NO DEFINIDO</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Marchamo">
		<form action="Transaccion.aspx" method="post">
			<input type="hidden" name="Transaccion"/>
			<input type="hidden" name="Filtro"/>
			<input type="hidden" value="{NumeroDocumento}" name="NumeroDocumento"/>
			<input type="hidden" value="{DiaPago}" name="DiaPago"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA}" name="Numero"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA}" name="ClasePlaca"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO}" name="CodigoGobierno"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/PERIODO}" name="Periodo"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO}" name="Nombre"/>
			<input type="hidden" value="{Reversion}" name="Reversion"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMCAJA}" name="NumeroCaja"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/TIPCAJA}" name="TipoCaja"/>
			<input type="hidden" value="{SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION}" name="NumeroTransaccion"/>
			<input type="hidden" value="{Empresa}" name="Empresa"/>
			<input type="hidden" value="{TipoComprobante}" name="TipoComprobante"/>
			<input type="hidden" value="{Moneda}" name="Moneda"/>
			<input type="hidden" value="{Input/TotalPago}" name="TotalPago"/>
			<input type="hidden" value="{Input/Efectivo}" name="Efectivo"/>
			<input type="hidden" value="{Input/OtrosValores}" name="OtrosValores"/>
			<div class="tituloAzulClaro" align="center">Información del Marchamo</div>
			<table class="tabla" width="400" align="center">
				<tbody>
					<tr class="etiqueta">
						<td>Número de placa:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA"/>-
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA"/>-
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO"/>
						</td>
						<td class="etiqueta">Período:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/PERIODO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
						<td class="etiqueta">Cédula:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Marca:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/DESMARCA"/>
						</td>
						<td class="etiqueta">Estilo:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/DESESTILO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Modelo:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/ANOMODELO"/>
						</td>
						<td class="etiqueta"># Motor:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMMOTOR"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta"># Chasis / VIN:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMCHASIS"/>
						</td>
						<td class="etiqueta">No. Clase</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMCLASE"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Capacidad:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/CAPACIDAD"/>
						</td>
						<td>Valor Fiscal:</td>
						<td class="detalleNumerico">
							<xsl:value-of select="format-number(SOA_CONFIRM_PAGO/ENCABEZADO/VALORFISCAL,'###,###,###,##0.00')"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Transacción:</td>
						<td class="detalle">
							<xsl:value-of select="SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION"/>
						</td>
						<td>No.Recibo</td>
						<td class="detalleTotal">
							<b>
								<xsl:value-of select="NumeroRecibo"/>
							</b>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Total:</td>
						<td class="detalle">
						</td>
						<td class="detalle"></td>
						<td class="detalleTotal">
							<b>
								<font size="3" color="red">
									<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
								</font>
							</b>
						</td>
					</tr>
				</tbody>
			</table>
			<xsl:if test="substring(Respuesta,1,7)='GANADOR'">
				<br/>
				<div class="tituloAzulClaro" align="center">
					<xsl:value-of select="Respuesta"/>
				</div>
			</xsl:if>
			<br/>
			<div class="tituloAzulClaro" align="center">Detalle del pago</div>
			<table class="tabla" align="center">
				<tbody>
					<tr class="encabezado">
						<td>Código</td>
						<td>Descripción</td>
						<td>Monto</td>
					</tr>
					<xsl:for-each select="SOA_CONFIRM_PAGO/RUBRO">
						<tr class="detalle">
							<td>
								<xsl:value-of select="CODRUBROPAGO"/>
							</td>
							<td>
								<xsl:call-template name="DescripcionRubro">
									<xsl:with-param name="CodigoRubro" select="CODRUBROPAGO"/>
								</xsl:call-template>
							</td>
							<td class="detalleNumerico">
								<xsl:value-of select="format-number(MONTOTRUBRO,'###,###,###,##0.00')"/>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
			<br/>

			<center>
				<!-- Solo se permite modificar los pagos del día actual -->
				<xsl:choose>
					<xsl:when test="Estado='XDG'">
						<xsl:if test="NumeroRecibo=0">
							<input onclick="document.forms[0].Filtro.value='XML/INS/INSImprimir.xsl';ejecutarComo('INSObtenerPermiso');" value="Imprimir" type="button"/>
						</xsl:if>
					</xsl:when>
					<xsl:when test="Estado='XPG' or Estado='XRV'">
						<xsl:if test="Edad = 0">
							<!-- Solo para el usuario que realizó la transacción -->
							<xsl:if test="not(UsuarioOrigen) or (UsuarioOrigen = Usuario)">
								<xsl:if test="(ReversionAutorizada = 1) and (Reversion = 2) and(NumeroRecibo!='0')">
									<input type="button" value="Reversar" onclick="document.forms[0].Filtro.value='XML/INS/INSEjecutaReversion.xsl';reversar('INSReversion')"/>
								</xsl:if>
								<xsl:if test="Reversion = X2">
									<input onclick="document.forms[0].Filtro.value='XML/INS/INSImprimir.xsl';ejecutarComo('INSObtenerPermiso');" value="Imprimir" type="button"/>
								</xsl:if>
							</xsl:if>
							<!-- El botón de Autorizar reversión solo se presenta a los perfiles que pueden permitir reversión -->
							<xsl:if test="(AutorizaReversion = X1) and (Reversion = X2) and(NumeroRecibo!='X0')">
								<input type="button" value="Autorizar Reversión" onclick="document.forms[0].Filtro.value='XML/INS/INSAprobacionReversion.xsl';ejecutarComo('BitacoraAutorizarReversion')"/>
							</xsl:if>
						</xsl:if>
						<xsl:if test="Edad &gt;10 and NumeroRecibo=X0">
							<xsl:if test="(UsuarioOrigen = Usuario)">
								<input onclick="document.forms[0].Filtro.value='XML/INS/INSImprimir.xsl';ejecutarComo('INSObtenerPermiso');" value="Imprimir" type="button"/>
							</xsl:if>
						</xsl:if>


						<xsl:if test="UsuarioOrigen">
							<br/>
							<br/>
							<font class="tituloAzulClaro">Cajero:&#xA0;
								<xsl:value-of select="UsuarioOrigen"/>
							</font>
							<input type="hidden" value="{UsuarioOrigen}" name="UsuarioOrigen"/>
						</xsl:if>
					</xsl:when>
				</xsl:choose>
				<font class="tituloAzulClaro">Se ha procesado el Pago en la sucursal virtual seleccionada: <xsl:value-of select="DescripcionCaja"/></font>
				<div align="center">
					<input name="OtraConsulta" class="button_gris" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaClasePlaca&amp;Filtro=~/XML/virtual/INSConsultarVirtual.xsl','Transaccion')"/>
				</div>
			</center>
		</form>
	</xsl:template>
	<xsl:template name="MostrarMensaje">
		<xsl:param name="Mensaje" select="."/>
		<xsl:param name="TipoComprobante" select="."/>
		<div align="center">
			<br/>
			<font class="tituloAzulClaro">
				<xsl:value-of select="$Mensaje"/>
			</font>
			<br/>
			<br/>
			<input name="BtnCerrar" type="button" value="      Cerrar      "
			       onclick="cargar(this,'Transaccion.aspx?Transaccion=ObtenerCajasFormularios&amp;servidorSTX=infoware.STX.Gestion&amp;Filtro=~/XML/Gestion/Formularios/AsignarFormularios.xsl&amp;TipoComprobante={$TipoComprobante}','Transaccion')"/>
		</div>
	</xsl:template>
	<xsl:template name="DescripcionRubro">
		<xsl:param name="CodigoRubro" select="."/>
		<xsl:choose>
			<xsl:when test="$CodigoRubro = 1">SEGURO OBLIGATORIO, PERIODO ANTERIOR</xsl:when>
			<xsl:when test="$CodigoRubro = 2">SEGURO OBLIGATORIO, RECARGO PERIODO ANTERIOR</xsl:when>
			<xsl:when test="$CodigoRubro = 3">SEGURO OBLIGATORIO, PERIODO ACTUAL</xsl:when>
			<xsl:when test="$CodigoRubro = 4">SEGURO OBLIGATORIO, RECARGO PERIODO ACTUAL</xsl:when>
			<xsl:when test="$CodigoRubro = 5">SEGURO OBLIGATORIO, AJUSTES</xsl:when>
			<xsl:when test="$CodigoRubro = 6">IMPUESTO DE VENTAS</xsl:when>
			<xsl:when test="$CodigoRubro = 7">CONSEJO SEGURIDAD VIAL, PERIODO ANTERIOR</xsl:when>
			<xsl:when test="$CodigoRubro = 8">CONSEJO SEGURIDAD VIAL, RECARGO PERIODO ANTERIOR</xsl:when>
			<xsl:when test="$CodigoRubro = 9">CONSEJO SEGURIDAD VIAL, APORTE</xsl:when>
			<xsl:when test="$CodigoRubro = 10">CONSEJO SEGURIDAD VIAL, RECARGO DEL APORTE</xsl:when>
			<xsl:when test="$CodigoRubro = 11">INFRACCIONES, MONTO</xsl:when>
			<xsl:when test="$CodigoRubro = 12">INFRACCIONES, TIMBRE FISCAL</xsl:when>
			<xsl:when test="$CodigoRubro = 13">INFRACCIONES, INTERES TIMBRE FISCAL</xsl:when>
			<xsl:when test="$CodigoRubro = 14">IINFRACCIONES, INTERESES</xsl:when>
			<xsl:when test="$CodigoRubro = 15">INFRACCIONES, AJUSTES</xsl:when>
			<xsl:when test="$CodigoRubro = 16">ESTACIONOMETROS, MONTO</xsl:when>
			<xsl:when test="$CodigoRubro = 17">ESTACIONOMETROS, INTERES</xsl:when>
			<xsl:when test="$CodigoRubro = 18">ESTACIONOMETROS, AJUSTES</xsl:when>
			<xsl:when test="$CodigoRubro = 19">IMPUESTO A LA PROPIEDAD, PERIODO ANTERIOR</xsl:when>
			<xsl:when test="$CodigoRubro = 20">IMPUESTO A LA PROPIEDAD, RECARGO PERIODO ANTERIOR</xsl:when>
			<xsl:when test="$CodigoRubro = 21">IMPUESTO A LA PROPIEDAD, PERIODO ACTUAL</xsl:when>
			<xsl:when test="$CodigoRubro = 22">IMPUESTO A LA PROPIEDAD, RECARGO PERIODO ACTUAL</xsl:when>
			<xsl:when test="$CodigoRubro = 23">IMPUESTO A LA PROPIEDAD, AJUSTES</xsl:when>
			<xsl:when test="$CodigoRubro = 24">ARESEP, PERIODO ACTUAL</xsl:when>
			<xsl:when test="$CodigoRubro = 25">ARESEP, RECARGO PERIODO ACTUAL</xsl:when>
			<xsl:when test="$CodigoRubro = 26">ARESEP, PERIODO ANTERIOR</xsl:when>
			<xsl:when test="$CodigoRubro = 27">ARESEP, RECARGO PERIODO ANTERIOR</xsl:when>
			<xsl:when test="$CodigoRubro = 28">ARESEP, AJUSTES</xsl:when>
			<xsl:when test="$CodigoRubro = 29">CONSEJO TRANSP.PUBLICO, PERIODO ACTUAL</xsl:when>
			<xsl:when test="$CodigoRubro = 30">CONSEJO TRANSP.PUBLICO, RECARGO PERIODO ACTUAL</xsl:when>
			<xsl:when test="$CodigoRubro = 31">CONSEJO TRANSP.PUBLICO, PERIODO ANTERIOR</xsl:when>
			<xsl:when test="$CodigoRubro = 32">CONSEJO TRANSP.PUBLICO, RECARGO PERIODO ANTERIOR</xsl:when>
			<xsl:when test="$CodigoRubro = 33">CONSEJO TRANSP.PUBLICO, AJUSTES</xsl:when>
			<xsl:when test="$CodigoRubro = 34">INSTITUTO DE FOMENTO MUNICIPAL (IFAM)</xsl:when>
			<xsl:when test="$CodigoRubro = 35">TIMBRE FAUNA SILVESTRE</xsl:when>
			<xsl:when test="$CodigoRubro = 36">LEY 7088 Y REFERENCIAS.</xsl:when>
			<xsl:when test="$CodigoRubro = 37">LEY DE CONTINGENCIA FISCAL</xsl:when>
			<xsl:when test="$CodigoRubro = 38">RECARGO LEY DE CONTINGENCIA FISCAL</xsl:when>
			<xsl:when test="$CodigoRubro = 39">LEY DE PACTO FISCAL</xsl:when>
			<xsl:when test="$CodigoRubro = 40">RECARGO LEY DE PACTO FISCAL</xsl:when>
			<xsl:when test="$CodigoRubro = 41">OTROS (APORTE A BOMBEROS 4%)</xsl:when>
			<xsl:when test="$CodigoRubro = 42">SEGUROS SU VIDA</xsl:when>
			<xsl:when test="$CodigoRubro = 43">PERÍODO ANTERIOR SEGURO RESPONSABILIDAD CIVIL</xsl:when>
			<xsl:when test="$CodigoRubro = 44">PERÍODO ACTUAL SEGURO RESPONSABILIDAD CIVIL</xsl:when>
			<xsl:when test="$CodigoRubro = 45">PERÍODO ACTUAL SEGURO ASISTENCIA EN CARRETERA</xsl:when>
			<xsl:when test="$CodigoRubro = 46">AUTOEXPEDIBLE MAS PROTECCION</xsl:when>
			<xsl:otherwise>No definido</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template match="/"></template>
			<template name="DescripcionRubro"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->