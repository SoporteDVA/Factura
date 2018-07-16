<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes" encoding="utf-8"/>
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
								<img height="60" hspace="0" src="imagenes/ins.gif" align="baseline" border="0"/>
							</td>
							<td width="50%">
								<font class="tituloAzulClaro">Pago de recibo</font>
								<xsl:if test="Fila/Reversion=1">
									<br/>
									<font class="mensaje">Reversión</font>
								</xsl:if>
							</td>
						</tr>
					</tbody>
				</table>
				<xsl:choose>
					<xsl:when test="BitacoraObtenerPagoOutput">
						<xsl:for-each select="BitacoraObtenerPagoOutput">
							<xsl:choose>
								<xsl:when test="Servicio=5">
									<xsl:call-template name="PolizaSuVida"/>
								</xsl:when>
								<xsl:when test="Servicio=3">
									<xsl:call-template name="PolizaAGV"/>
								</xsl:when>
								<xsl:when test="Servicio=2">
									<xsl:call-template name="PolizaTurista"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="InfoPago"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<br/>
						<br/>
						<br/>
						<center>
							<font class="mensaje">
								<xsl:choose>
									<xsl:when test="normalize-space(BitacoraObtenerPagoFault/Respuesta) != ''">
										<xsl:value-of select="BitacoraObtenerPagoFault/Respuesta"/>
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
	<xsl:template name="PolizaSuVida">
		<form action="Transaccion.aspx" method="post">
			<input type="hidden" name="Transaccion"/>
			<input type="hidden" name="Filtro"/>
			<input type="hidden" value="{NumeroDocumento}" name="NumeroDocumento"/>
			<input type="hidden" value="{DiaPago}" name="DiaPago"/>
			<input type="hidden" value="{OficinaOrigen}" name="OficinaOrigen"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA}" name="Numero"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA}" name="ClasePlaca"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO}" name="CodigoGobierno"/>
			<input type="hidden" value="{Periodo}" name="Periodo"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO}" name="Nombre"/>
			<input type="hidden" value="{Reversion}" name="Reversion"/>
			<input type="hidden" value="{NumeroCaja}" name="NumeroCaja"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/TIPCAJA}" name="TipoCaja"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION}" name="NumeroTransaccion"/>
			<input type="hidden" value="{TipoComprobante}" name="TipoComprobante"/>
			<input type="hidden" value="{NumeroRecibo}" name="NumeroRecibo"/>
			<input type="hidden" value="{Servicio}" name="TipoOperacion"/>
			<input type="hidden" value="{Servicio}" name="Servicio"/>
			<input type="hidden" value="{Empresa}" name="Empresa"/>
			<input type="hidden" value="{Moneda}" name="Moneda"/>
			<input type="hidden" value="{TotalPago}" name="TotalPago"/>
			<input type="hidden" value="{TotalPago}" name="Efectivo"/>
			<input type="hidden" value="0" name="OtrosValores"/>
			<div class="tituloAzulClaro" align="center">Información de la Poliza Su Vida</div>
			<table class="tabla" width="400" align="center">
				<tbody>
					<tr class="etiqueta">
						<td>Número de placa:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA"/>-
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA"/>-
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO"/>
						</td>
						<td class="etiqueta">Período:</td>
						<td class="detalle">
							<xsl:value-of select="Periodo"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
						<td class="etiqueta">Cédula:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Transacción :</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION"/>
						</td>
						<td>No. Recibo :</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMCOMPROBANTE"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Registrada:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/FECHA"/>
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
<xsl:if test="(ReversionAutorizada != 1) and (AutorizaReversion = 1) and (Reversion = 2) and(NumeroRecibo!='0')">
						<input type="button" value="Autorizar Reversión" onclick="document.forms[0].Filtro.value='XML/INS/INSAprobacionReversion.xsl';ejecutarComo('BitacoraAutorizarReversion');"/>
					</xsl:if>
<xsl:if test="(ReversionAutorizada = 1) and (Reversion = 2)and(NumeroRecibo!='0')">
							<input type="button" value="Reversar" onclick="document.forms[0].Filtro.value='XML/INS/INSEjecutaReversion.xsl';reversar('SuVidaReversion')"/>
						</xsl:if>
						<xsl:if test="Reversion &gt; 1">
							<input type="button" value="Imprimir" onclick="document.forms[0].Filtro.value='XML/INS/INSImprimir.xsl';ejecutarComo('INSObtenerPermiso');"/>
						</xsl:if>
					</xsl:if>
				</xsl:if>
				<xsl:if test="UsuarioOrigen">
					<br/>
					<br/>
					<font class="tituloAzulClaro">Cajero: <xsl:value-of select="UsuarioOrigen"/></font>
					<input type="hidden" name="UsuarioOrigen" value="{UsuarioOrigen}"/>
				</xsl:if>
			</center>
		</form>
	</xsl:template>
	<xsl:template name="PolizaAGV">
		<form action="Transaccion.aspx" method="post">
			<input type="hidden" name="Transaccion"/>
			<input type="hidden" name="Filtro"/>
			<input type="hidden" value="{NumeroDocumento}" name="NumeroDocumento"/>
			<input type="hidden" value="{DiaPago}" name="DiaPago"/>
			<input type="hidden" value="{OficinaOrigen}" name="OficinaOrigen"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA}" name="Numero"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA}" name="ClasePlaca"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO}" name="CodigoGobierno"/>
			<input type="hidden" value="{Periodo}" name="Periodo"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO}" name="Nombre"/>
			<input type="hidden" value="{Reversion}" name="Reversion"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMCAJA}" name="NumeroCaja"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/TIPCAJA}" name="TipoCaja"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION}" name="NumeroTransaccion"/>
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
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA"/>-
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA"/>-
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO"/>
						</td>
						<td class="etiqueta">Período:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/PERIODO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
						<td class="etiqueta">Cédula:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Transacción :</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION"/>
						</td>
						<td>No. Recibo :</td>
						<td class="detalle">
							<xsl:value-of select="NumeroRecibo"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Registrada:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/FECHA"/>
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
			<xsl:if test="TramaXML/Pago/SOA_CONFIRM_PAGO/RUBRO[CODRUBROPAGO &gt;0]">
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
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA}" name="Numero"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA}" name="ClasePlaca"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO}" name="CodigoGobierno"/>
			<input type="hidden" value="{Periodo}" name="Periodo"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO}" name="Nombre"/>
			<input type="hidden" value="{Reversion}" name="Reversion"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMCAJA}" name="NumeroCaja"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/TIPCAJA}" name="TipoCaja"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION}" name="NumeroTransaccion"/>
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
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA"/>-
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA"/>-
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO"/>
						</td>
						<td class="etiqueta">Período:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/PERIODO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
						<td class="etiqueta">Cédula:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Modelo:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/ANOMODELO"/>
						</td>
						<td class="etiqueta"># Motor:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMMOTOR"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta"># Chasis / VIN:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMCHASIS"/>
						</td>
						<td class="etiqueta">No. Clase</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMCLASE"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Transacción :</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION"/>
						</td>
						<td>No. Recibo :</td>
						<td class="detalle">
							<xsl:value-of select="NumeroRecibo"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Registrada:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/FECHA"/>
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
			<xsl:if test="TramaXML/Pago/SOA_CONFIRM_PAGO/RUBRO[CODRUBROPAGO &gt;0]">
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
				<br/>
				<br/>
				<font class="tituloAzulClaro">Cajero: <xsl:value-of select="UsuarioOrigen"/></font>
				<input type="hidden" name="UsuarioOrigen" value="{UsuarioOrigen}"/>
			</xsl:if>
		</center>
	</xsl:template>
	<xsl:template name="InfoPago">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="BitacoraAutorizarReversion"/>
			<input type="hidden" name="Filtro"/>
			<input type="hidden" value="{NumeroDocumento}" name="NumeroDocumento"/>
			<input type="hidden" value="{DiaPago}" name="DiaPago"/>
			<input type="hidden" value="{OficinaOrigen}" name="OficinaOrigen"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA}" name="Numero"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA}" name="ClasePlaca"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO}" name="CodigoGobierno"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/PERIODO}" name="Periodo"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO}" name="Nombre"/>
			<input type="hidden" value="{Reversion}" name="Reversion"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMCAJA}" name="NumeroCaja"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/TIPCAJA}" name="TipoCaja"/>
			<input type="hidden" value="{TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION}" name="NumeroTransaccion"/>
			<input type="hidden" value="{Empresa}" name="Empresa"/>
			<input type="hidden" value="{TipoComprobante}" name="TipoComprobante"/>
			<input type="hidden" value="{TipoComprobante}" name="TipoOperacion"/>
			<input type="hidden" value="{Moneda}" name="Moneda"/>
			<input type="hidden" value="{TotalPago}" name="TotalPago"/>
			<input type="hidden" value="{TotalPago}" name="Efectivo"/>
			<input type="hidden" value="0" name="OtrosValores"/>
			<div class="tituloAzulClaro" align="center">Información del Marchamo</div>
			<table class="tabla" width="400" align="center">
				<tbody>
					<tr class="etiqueta">
						<td>Número de placa:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CLASEPLACA"/>-
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMPLACA"/>-
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CODGOBIERNO"/>
						</td>
						<td class="etiqueta">Período:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/PERIODO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
						<td class="etiqueta">Cédula:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Marca:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/DESMARCA"/>
						</td>
						<td class="etiqueta">Estilo:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/DESESTILO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Modelo:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/ANOMODELO"/>
						</td>
						<td class="etiqueta"># Motor:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMMOTOR"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta"># Chasis / VIN:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMCHASIS"/>
						</td>
						<td class="etiqueta">No. Clase</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMCLASE"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Capacidad:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CAPACIDAD"/>
						</td>
						<td>Valor Fiscal:</td>
						<td class="detalleNumerico">
							<xsl:value-of select="format-number(TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/VALORFISCAL,'###,###,###,##0.00')"/>
						</td>
					</tr>
					<tr class="etiqueta">
						<td>Transacción:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION"/>
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
			<div class="tituloAzulClaro" align="center">Detalle del pago</div>
			<table class="tabla" align="center">
				<tbody>
					<tr class="encabezado">
						<td>Código</td>
						<td>Descripción</td>
						<td>Monto</td>
					</tr>
					<xsl:for-each select="TramaXML/Pago/SOA_CONFIRM_PAGO/RUBRO">
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
			<br/>
			<br/>
			<center>
				<!-- Solo se permite modificar los pagos de dias anteriores -->
				<xsl:if test="(Edad &gt; 0)">
					<!-- Solo para el usuario que realizó la transacción -->
					<xsl:if test="Sesion/Conciliar=1">
						<xsl:if test="(ReversionAutorizada = 1) and (Reversion = 2)and(NumeroRecibo!='0')">
							<input type="button" value="Reversar" onclick="document.forms[0].Filtro.value='XML/INS/INSEjecutaReversion.xsl';reversar('INSReversion')"/>
						</xsl:if>
						<xsl:if test="Reversion = 2">
							<input type="button" value="Imprimir" onclick="document.forms[0].Filtro.value='XML/CierreCajas/INSImprimirConciliacion.xsl';ejecutarComo('INSObtenerPermiso');"/>
						</xsl:if>
					</xsl:if>
					<!-- El botón de Autorizar reversión solo se presenta a los perfiles que pueden permitir reversión -->
					<xsl:if test="(ReversionAutorizada != 1) and (AutorizaReversion = 1) and (Reversion = 2)">
						<input type="button" value="Autorizar Reversión" onclick="document.forms[0].Filtro.value='XML/INS/INSAprobacionReversion.xsl';ejecutarComo('BitacoraAutorizarReversion');"/>
					</xsl:if>
				</xsl:if>

				<xsl:if test="UsuarioOrigen">
					<br/>
					<br/>
					<font class="tituloAzulClaro">Cajero: <xsl:value-of select="UsuarioOrigen"/></font>
					<input type="hidden" name="UsuarioOrigen" value="{UsuarioOrigen}"/>
				</xsl:if>
			</center>
		</form>
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
				<xsl:for-each select="TramaXML/Pago/SOA_CONFIRM_PAGO/RUBRO[CODRUBROPAGO &gt;0]">
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
			<xsl:when test="$CodigoRubro = 46">LEY SOLIDARIDAD TRIBUTARIA</xsl:when>
			<xsl:when test="$CodigoRubro = 47">RECARGO LEY SOLIDARIDAD TRIBUTARIA</xsl:when>
			<xsl:otherwise>No definido</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="no" externalpreview="no" url="file:///c:/WebSite/INTRANET/XML/INS/toSuVida.xml" htmlbaseurl="http://bcr0106ctv07/conectividadesNET/" outputurl="" processortype="internal" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator=""/></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->