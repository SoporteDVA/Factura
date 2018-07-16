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
			</head>
			<body>
				<table width="500" align="center" border="0">
					<tbody>
						<tr>
							<td align="center" width="50%">
								<img height="60" hspace="0" src="imagenes/DVA.jpg" align="baseline" border="0"/>
							</td>
							<td width="50%">
								<font class="tituloAzulClaro">Informacion de Marchamos</font>
								<xsl:if test="Fila/Reversion=1">
									<br/>
									<font class="mensaje">Reversión</font>
								</xsl:if>
							</td>
						</tr>
					</tbody>
				</table>
				<xsl:choose>
					<xsl:when test="BitacoraObtenerPagoSucursalOutput">
						<xsl:for-each select="BitacoraObtenerPagoSucursalOutput">
							<xsl:choose>
								<xsl:when test="Servicio=94">
									<xsl:call-template name="PolizaSuVida"/>
								</xsl:when>
								<xsl:when test="Servicio=95">
									<xsl:call-template name="PolizaRespCivil"/>
								</xsl:when>
								<xsl:when test="Servicio=96">
									<xsl:call-template name="PolizaAsistencia"/>
								</xsl:when>
								<xsl:when test="Servicio=98">
									<xsl:call-template name="PolizaCoberturaAdicional"/>
								</xsl:when>
								<xsl:when test="Servicio=100">
									<xsl:call-template name="PolizaMasProteccion"/>
								</xsl:when>
								<xsl:when test="Servicio=3">
									<xsl:call-template name="PolizaAGV"/>
								</xsl:when>
								<xsl:when test="Servicio=2">
									<xsl:call-template name="PolizaTurista"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="BitacoraObtenerPagoSucursalOutput"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="BitacoraObtenerPagoEnvioOutput">
						<xsl:for-each select="BitacoraObtenerPagoEnvioOutput">
							<xsl:choose>
								<xsl:when test="Servicio=94">
									<xsl:call-template name="PolizaSuVida"/>
								</xsl:when>
								<xsl:when test="Servicio=95">
									<xsl:call-template name="PolizaRespCivil"/>
								</xsl:when>
								<xsl:when test="Servicio=96">
									<xsl:call-template name="PolizaAsistencia"/>
								</xsl:when>
								<xsl:when test="Servicio=98">
									<xsl:call-template name="PolizaCoberturaAdicional"/>
								</xsl:when>
								<xsl:when test="Servicio=100">
									<xsl:call-template name="PolizaMasProteccion"/>
								</xsl:when>
								<xsl:when test="Servicio=3">
									<xsl:call-template name="PolizaAGV"/>
								</xsl:when>
								<xsl:when test="Servicio=2">
									<xsl:call-template name="PolizaTurista"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="BitacoraObtenerPagoEnvioOutput"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>

						<center>
							<font class="mensaje">
								<xsl:choose>
									<xsl:when test="normalize-space(BitacoraObtenerPagoSucursalFault/Respuesta) != ''">
										<xsl:value-of select="BitacoraObtenerPagoFault/Respuesta"/>
									</xsl:when>
									<xsl:when test="normalize-space(BitacoraObtenerPagoEnvioFault/Respuesta) != ''">
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
	<xsl:template name="PolizaMasProteccion">
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
			<div class="tituloAzulClaro" align="center">Información de la Poliza Mas Protección</div>
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
						<td>No. Documento :</td>
						<td class="detalle">
							<xsl:value-of select="NumeroDocumento"/>
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
	<xsl:template name="PolizaCoberturaAdicional">
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
			<div class="tituloAzulClaro" align="center">Información de la Poliza Cobertura Adicional</div>
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
						<td>No. Documento :</td>
						<td class="detalle">
							<xsl:value-of select="NumeroDocumento"/>
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
	<xsl:template name="PolizaAsistencia">
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
			<div class="tituloAzulClaro" align="center">Información de la Poliza Asistencia</div>
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
						<td>No. Documento :</td>
						<td class="detalle">
							<xsl:value-of select="NumeroDocumento"/>
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
	<xsl:template name="PolizaRespCivil">
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
			<div class="tituloAzulClaro" align="center">Información de la Poliza Responsabilidad Civil</div>
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
						<td>No. Documento :</td>
						<td class="detalle">
							<xsl:value-of select="NumeroDocumento"/>
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
			<input type="hidden" value="{Servicio}" name="TipoComprobante"/>
			<input type="hidden" value="{NumeroRecibo}" name="NumeroRecibo"/>
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
			<input type="hidden" value="{NumeroRecibo}" name="NumeroRecibo"/>
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
						<input type="button" class="button_delete" value="Reversar" onclick="document.forms[0].Filtro.value='XML/INS/INSEjecutaReversion.xsl';reversar('INSReversion')"/>
					</xsl:if>
					<xsl:if test="Reversion = 2">
						<input type="button" class="button_red" value="Imprimir" onclick="this.enabled=false;document.forms[0].Filtro.value='XML/INS/INSImprimir.xsl';ejecutarComo('INSObtenerPermiso');"/>
					</xsl:if>
				</xsl:if>
				<!-- El botón de Autorizar reversión solo se presenta a los perfiles que pueden permitir reversión -->
				<xsl:if test="(ReversionAutorizada != 1) and (AutorizaReversion = 1) and (Reversion = 2) and(NumeroRecibo!='0')">
					<input type="button" class="button_delete" value="Autorizar Reversión" onclick="document.forms[0].Filtro.value='XML/INS/INSAprobacionReversion.xsl';ejecutarComo('BitacoraAutorizarReversion');"/>
				</xsl:if>
			</xsl:if>
			<xsl:if test="Edad &gt; 0">
				<!-- Solo para el usuario que realizó la transacción -->
				<xsl:if test="not(UsuarioOrigen) or (Usuario = UsuarioOrigen)">
					<xsl:if test="Reversion &gt; 1">
						<input type="button" class="button_red" value="Imprimir" onclick="document.forms[0].Filtro.value='XML/INS/INSImprimir.xsl';ejecutarComo('INSObtenerPermiso');"/>
					</xsl:if>
				</xsl:if>
			</xsl:if>
			<br/>
			<xsl:if test="UsuarioOrigen">
				<font class="tituloAzulClaro">Cajero: <xsl:value-of select="UsuarioOrigen"/></font>
				<input type="hidden" name="UsuarioOrigen" value="{UsuarioOrigen}"/>
			</xsl:if>
		</center>
	</xsl:template>
	<xsl:template name="BotonesSuVida">
		<center>
			<!-- Solo se permite modificar los pagos del día actual -->
			<xsl:if test="Edad = 0">
				<!-- Solo para el usuario que realizó la transacción -->
				<xsl:if test="not(UsuarioOrigen) or (UsuarioOrigen = Usuario)">
					<xsl:if test="(ReversionAutorizada = 1) and (Reversion = 2)and(NumeroRecibo!='0')">
						<input type="button" class="button_delete" value="Reversar" onclick="document.forms[0].Filtro.value='XML/INS/INSEjecutaReversion.xsl';reversar('SuVidaReversion')"/>
					</xsl:if>
					<xsl:if test="Reversion = 2">
						<input type="button" class="button_red" value="Imprimir" onclick="this.enabled=false;document.forms[0].Filtro.value='XML/INS/INSImprimir.xsl';ejecutarComo('INSObtenerPermiso');"/>
					</xsl:if>
				</xsl:if>
				<!-- El botón de Autorizar reversión solo se presenta a los perfiles que pueden permitir reversión -->
				<xsl:if test="(ReversionAutorizada != 1) and (AutorizaReversion = 1) and (Reversion = 2) and(NumeroRecibo!='0')">
					<input type="button" class="button_delete" value="Autorizar Reversión" onclick="document.forms[0].Filtro.value='XML/INS/INSAprobacionReversion.xsl';ejecutarComo('BitacoraAutorizarReversion');"/>
				</xsl:if>
			</xsl:if>
			<xsl:if test="Edad &gt; 0">
				<!-- Solo para el usuario que realizó la transacción -->
				<xsl:if test="not(UsuarioOrigen) or (Usuario = UsuarioOrigen)">
					<xsl:if test="Reversion &gt; 1">
						<input type="button" class="button_red" value="Imprimir" onclick="document.forms[0].Filtro.value='XML/INS/INSImprimir.xsl';ejecutarComo('INSObtenerPermiso');"/>
					</xsl:if>
				</xsl:if>
			</xsl:if>
			<br/>
			<xsl:if test="UsuarioOrigen">

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
			<input type="hidden" value="{Servicio}" name="TipoOperacion"/>
			<input type="hidden" value="{Servicio}" name="Servicio"/>
			<input type="hidden" value="{TipoComprobante}" name="TipoComprobante"/>
			<input type="hidden" value="{NumeroRecibo}" name="NumeroRecibo"/>
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
								<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
							</b>
						</td>
					</tr>
				</tbody>
			</table>

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

			<center>
				<!-- Solo se permite modificar los pagos de dias anteriores -->
				<xsl:if test="(Edad &gt; 0)">
					<!-- Solo para el usuario que realizó la transacción -->
					<xsl:if test="Sesion/Conciliar=1">
						<xsl:if test="(ReversionAutorizada = 1) and (Reversion = 2)and(NumeroRecibo!='0')">
							<input type="button" class="button_delete" value="Reversar" onclick="document.forms[0].Filtro.value='XML/INS/INSEjecutaReversion.xsl';reversar('INSReversion')"/>
						</xsl:if>
						<xsl:if test="Reversion = 2">
							<input type="button" class="button_red" value="Imprimir" onclick="document.forms[0].Filtro.value='XML/CierreCajas/INSImprimirConciliacion.xsl';ejecutarComo('INSObtenerPermiso');"/>
						</xsl:if>
					</xsl:if>
					<!-- El botón de Autorizar reversión solo se presenta a los perfiles que pueden permitir reversión -->
					<xsl:if test="(ReversionAutorizada != 1) and (AutorizaReversion = 1) and (Reversion = 2)">
						<input type="button" class="button_delete" value="Autorizar Reversión" onclick="document.forms[0].Filtro.value='XML/INS/INSAprobacionReversion.xsl';ejecutarComo('BitacoraAutorizarReversion');"/>
					</xsl:if>
				</xsl:if>
				<xsl:if test="UsuarioOrigen">
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
	<xsl:template name="BitacoraObtenerPagoOutput">
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
			<input type="hidden" value="{Servicio}" name="TipoOperacion"/>
			<input type="hidden" value="{Servicio}" name="Servicio"/>
			<input type="hidden" value="{TipoComprobante}" name="TipoComprobante"/>
			<input type="hidden" value="{NumeroRecibo}" name="NumeroRecibo"/>
			<input type="hidden" value="{Empresa}" name="Empresa"/>
			<input type="hidden" value="{Moneda}" name="Moneda"/>
			<input type="hidden" value="{TotalPago}" name="TotalPago"/>
			<input type="hidden" value="{TotalPago}" name="Efectivo"/>
			<input type="hidden" value="0" name="OtrosValores"/>
			<div class="tituloAzulClaro" align="center">Información del Marchamo !</div>
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

			<center>
				<!-- Solo se permite modificar los pagos del día actual -->
				<xsl:if test="/BitacoraObtenerPagoOutput/Edad = 0">
					<!-- Solo para el usuario que realizó la transacción -->
					<xsl:if test="not(/BitacoraObtenerPagoOutput/UsuarioOrigen) or (UsuarioOrigen = Usuario)">
						<xsl:if test="(ReversionAutorizada = 1) and (Reversion = 2)and(NumeroRecibo!='0')">
							<input type="button" class="button_delete" value="Reversar" onclick="document.forms[0].Filtro.value='XML/INS/INSEjecutaReversion.xsl';reversar('INSReversion')"/>
						</xsl:if>
						<xsl:if test="Reversion = 2">
							<input type="button" class="button_red" value="Imprimir" onclick="this.enabled=false;document.forms[0].Filtro.value='XML/INS/INSImprimir.xsl';ejecutarComo('INSObtenerPermiso');"/>
						</xsl:if>
					</xsl:if>
					<!-- El botón de Autorizar reversión solo se presenta a los perfiles que pueden permitir reversión -->
					<xsl:if test="(ReversionAutorizada != 1) and (AutorizaReversion = 1) and (Reversion = 2) and(NumeroRecibo!='0')">
						<input type="button" class="button_delete" value="Autorizar Reversión" onclick="document.forms[0].Filtro.value='XML/INS/INSAprobacionReversion.xsl';ejecutarComo('BitacoraAutorizarReversion');"/>
					</xsl:if>
				</xsl:if>
				<xsl:if test="Edad &gt; 0">
					<!-- Solo para el usuario que realizó la transacción -->
					<xsl:if test="not(/BitacoraObtenerPagoOutput/UsuarioOrigen) or (Usuario = UsuarioOrigen)">
						<xsl:if test="Reversion &gt; 1">
							<input type="button" class="button_red" value="Imprimir" onclick="document.forms[0].Filtro.value='XML/INS/INSImprimir.xsl';ejecutarComo('INSObtenerPermiso');"/>
						</xsl:if>
					</xsl:if>
				</xsl:if>
				<br/>
				<xsl:if test="UsuarioOrigen">

					<font class="tituloAzulClaro">Cajero: <xsl:value-of select="UsuarioOrigen"/></font>
					<input type="hidden" name="UsuarioOrigen" value="{UsuarioOrigen}"/>
				</xsl:if>
			</center>
		</form>
	</xsl:template>
	<xsl:template name="BitacoraObtenerPagoSucursalOutput">
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
			<input type="hidden" value="{Servicio}" name="TipoOperacion"/>
			<input type="hidden" value="{Servicio}" name="Servicio"/>
			<input type="hidden" value="{TipoComprobante}" name="TipoComprobante"/>
			<input type="hidden" value="{NumeroRecibo}" name="NumeroRecibo"/>
			<input type="hidden" value="{Empresa}" name="Empresa"/>
			<input type="hidden" value="{Moneda}" name="Moneda"/>
			<input type="hidden" value="{TotalPago}" name="TotalPago"/>
			<input type="hidden" value="{TotalPago}" name="Efectivo"/>
			<input type="hidden" value="0" name="OtrosValores"/>
			<div class="tituloAzulClaro" align="center">Información del Marchamo a Entregar</div>
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
						<td class="etiqueta">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
						<td class="etiqueta">Cédula:</td>
						<td class="etiqueta">
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
						<td>Transacción:</td>
						<td class="detalleTotal">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION"/>
						</td>
						<td>No.Formulario</td>
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
								<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
							</b>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="tituloAzulClaro" align="center">Detalles de Entrega</div>
			<table class="tabla" align="center">
				<tbody>

					<tr>
						<td class="etiqueta">Cédula Propietario:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre Propietario:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Cedula Cliente:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CEDPERSONAPAGADOR"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre Cliente:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPAGADOR"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Telefono Cliente:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/TELPERSONAPAGADOR"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Cedula Autorizado: </td>
						<td class="detalle">
							<xsl:value-of select="Idautorizado"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre Autorizado: </td>
						<td class="detalle">
							<xsl:value-of select="Autorizado"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Provincia: </td>
						<td class="detalle">
							<xsl:for-each select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO">
								<xsl:choose>
									<xsl:when test="PROVINCIAPAGADOR=1">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=2">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=3">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=4">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=5">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=6">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=7">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</td>
					</tr>

					<tr>
						<td class="etiqueta">Canton:</td>
						<td class="detalle">
							<xsl:for-each select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO">
								<xsl:choose>
									<xsl:when test="PROVINCIAPAGADOR=1">
										<xsl:call-template name="CantonesSanJose">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=2">
										<xsl:call-template name="CantonesAlajuela">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=3">
										<xsl:call-template name="CantonesCartago">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=4">
										<xsl:call-template name="CantonesHeredia">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=5">
										<xsl:call-template name="CantonesGuanacaste">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=6">
										<xsl:call-template name="CantonesPuntarenas">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=7">
										<xsl:call-template name="CantonesLimon">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</td>
					</tr>
					
				</tbody>
			</table>
			<div class="tituloAzulClaro" align="center">Detalle del Autorizado</div>
			<table class="tabla" align="center">
				<tbody>
					<tr class="encabezado">
						<td class="etiqueta">Cedula Autorizado</td>
						<td class="etiqueta">Autorizado</td>
					</tr>

					<tr class="detalle">
						<td>
							<xsl:value-of select="Idautorizado"/>
						</td>
						<td>
							<xsl:value-of select="Autorizado"/>
						</td>
					</tr>
					
				</tbody>
			</table>

			<center>
				
				<input type="button" class="button_gris" value="Cerrar" onclick="cargar(this,'Transaccion.aspx?Transaccion=BitacoraCJDetalleSucursal&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=~/XML/virtual/EntregaCJDetalle.xsl','Transaccion')"/>
				
				<br/>
				<xsl:if test="UsuarioOrigen">

					<font class="tituloAzulClaro">Usuario Emisor: <xsl:value-of select="UsuarioOrigen"/></font>
					<input type="hidden" name="UsuarioOrigen" value="{UsuarioOrigen}"/>
				</xsl:if>
			</center>
		</form>
	</xsl:template>
	<xsl:template name="BitacoraObtenerPagoEnvioOutput">
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
			<input type="hidden" value="{Servicio}" name="TipoOperacion"/>
			<input type="hidden" value="{Servicio}" name="Servicio"/>
			<input type="hidden" value="{TipoComprobante}" name="TipoComprobante"/>
			<input type="hidden" value="{NumeroRecibo}" name="NumeroRecibo"/>
			<input type="hidden" value="{Empresa}" name="Empresa"/>
			<input type="hidden" value="{Moneda}" name="Moneda"/>
			<input type="hidden" value="{TotalPago}" name="TotalPago"/>
			<input type="hidden" value="{TotalPago}" name="Efectivo"/>
			<input type="hidden" value="0" name="OtrosValores"/>
			<div class="tituloAzulClaro" align="center">Información del Marchamo a Domicilio</div>
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
						<td class="etiqueta">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
						<td class="etiqueta">Cédula:</td>
						<td class="etiqueta">
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
						<td>Transacción:</td>
						<td class="detalleTotal">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NUMTRANSACCION"/>
						</td>
						<td>No.Formulario</td>
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
								<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
							</b>
						</td>
					</tr>
				</tbody>
			</table>
			<br/>
			<div class="tituloAzulClaro" align="center">Detalle del Envio</div>
			<table class="tabla" align="center">
				<tbody>

					<tr>
						<td class="etiqueta">Cédula Propietario:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre Propietario:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Cedula Cliente:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/CEDPERSONAPAGADOR"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre Cliente:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPAGADOR"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Telefono Cliente:</td>
						<td class="detalle">
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/TELPERSONAPAGADOR"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Cedula Destinatario Autorizado</td>
						<td class="detalle">
							<xsl:value-of select="Idautorizado"/>
						</td>
					</tr>


					<tr>
						<td class="etiqueta">Destinatario Autorizado</td>
						<td class="detalle">
							<xsl:value-of select="Autorizado"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Provincia</td>
						<td class="detalle">
							<xsl:for-each select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO">
								<xsl:choose>
									<xsl:when test="PROVINCIAPAGADOR=1">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=2">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=3">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=4">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=5">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=6">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=7">
										<xsl:call-template name="Provincias">
											<xsl:with-param name="CodigoProvincia" select="PROVINCIAPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</td>
					</tr>

					<tr>
						<td class="etiqueta">Canton</td>
						<td class="detalle">
							<xsl:for-each select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO">
								<xsl:choose>
									<xsl:when test="PROVINCIAPAGADOR=1">
										<xsl:call-template name="CantonesSanJose">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=2">
										<xsl:call-template name="CantonesAlajuela">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=3">
										<xsl:call-template name="CantonesCartago">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=4">
										<xsl:call-template name="CantonesHeredia">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=5">
										<xsl:call-template name="CantonesGuanacaste">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=6">
										<xsl:call-template name="CantonesPuntarenas">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="PROVINCIAPAGADOR=7">
										<xsl:call-template name="CantonesLimon">
											<xsl:with-param name="CodigoCanton" select="CANTONPAGADOR"/>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Distrito</td>
						<td class="detalle">
							<xsl:value-of select="NombreDistrito"/>
						</td>
					</tr>
				</tbody>
			</table>
			<br/>
			<table class="tabla" align="center">
				<tbody>
					<tr class="encabezado">
						<td class="etiqueta">Direccion Exacta</td>
					</tr>

					<tr class="detalle">
						<td>
							<xsl:value-of select="DireccionExacta"/>
						</td>
					</tr>
				</tbody>
			</table>

			<center>
				<input type="button" class="button_gris" value="Cerrar" onclick="cargar(this,'Transaccion.aspx?Transaccion=BitacoraCJDetalleEnvios&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=~/XML/virtual/DomicilioCJDetalle.xsl','Transaccion')"/>
				<br/>
				<xsl:if test="UsuarioOrigen">

					<font class="tituloAzulClaro">Usuario Emisor: <xsl:value-of select="UsuarioOrigen"/></font>
					<input type="hidden" name="UsuarioOrigen" value="{UsuarioOrigen}"/>
				</xsl:if>
			</center>
		</form>
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
	<xsl:template name="Provincias">
		<xsl:param name="CodigoProvincia" select="."/>
		<xsl:choose>
			<xsl:when test="$CodigoProvincia = 1">SAN JOSE</xsl:when>
			<xsl:when test="$CodigoProvincia = 2">ALAJUELA</xsl:when>
			<xsl:when test="$CodigoProvincia = 3">CARTAGO</xsl:when>
			<xsl:when test="$CodigoProvincia = 4">HEREDIA</xsl:when>
			<xsl:when test="$CodigoProvincia = 5">GUANACASTE</xsl:when>
			<xsl:when test="$CodigoProvincia = 6">PUNTARENAS</xsl:when>
			<xsl:when test="$CodigoProvincia = 7">LIMON</xsl:when>
			<xsl:otherwise>No definido</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CantonesSanJose">
		<xsl:param name="CodigoCanton" select="."/>
		<xsl:choose>
			<xsl:when test="$CodigoCanton = 1">SAN JOSE</xsl:when>
			<xsl:when test="$CodigoCanton = 2">ESCAZU</xsl:when>
			<xsl:when test="$CodigoCanton = 3">DESAMPARADOS</xsl:when>
			<xsl:when test="$CodigoCanton = 4">PURISCAL</xsl:when>
			<xsl:when test="$CodigoCanton = 5">TARRAZU</xsl:when>
			<xsl:when test="$CodigoCanton = 6">ASERRI</xsl:when>
			<xsl:when test="$CodigoCanton = 7">MORA</xsl:when>
			<xsl:when test="$CodigoCanton = 8">GOICOECHEA</xsl:when>
			<xsl:when test="$CodigoCanton = 9">SANTA ANA</xsl:when>
			<xsl:when test="$CodigoCanton = 10">ALAJUELITA</xsl:when>
			<xsl:when test="$CodigoCanton = 11">VAZQUEZ DE CORONADO</xsl:when>
			<xsl:when test="$CodigoCanton = 12">ACOSTA</xsl:when>
			<xsl:when test="$CodigoCanton = 13">TIBAS</xsl:when>
			<xsl:when test="$CodigoCanton = 14">MORAVIA</xsl:when>
			<xsl:when test="$CodigoCanton = 15">MONTES DE OCA</xsl:when>
			<xsl:when test="$CodigoCanton = 16">TURRUBARES</xsl:when>
			<xsl:when test="$CodigoCanton = 17">DOTA</xsl:when>
			<xsl:when test="$CodigoCanton = 18">CURRIDABAT</xsl:when>
			<xsl:when test="$CodigoCanton = 19">PEREZ ZELEDON</xsl:when>
			<xsl:when test="$CodigoCanton = 20">LEON CORTES</xsl:when>
			<xsl:otherwise>No definido</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CantonesAlajuela">
		<xsl:param name="CodigoCanton" select="."/>
		<xsl:choose>
			<xsl:when test="$CodigoCanton = 1">ALAJUELA</xsl:when>
			<xsl:when test="$CodigoCanton = 2">SAN RAMON</xsl:when>
			<xsl:when test="$CodigoCanton = 3">GRECIA</xsl:when>
			<xsl:when test="$CodigoCanton = 4">SAN MATEO</xsl:when>
			<xsl:when test="$CodigoCanton = 5">ATENAS</xsl:when>
			<xsl:when test="$CodigoCanton = 6">NARANJO</xsl:when>
			<xsl:when test="$CodigoCanton = 7">PALMARES</xsl:when>
			<xsl:when test="$CodigoCanton = 8">POAS</xsl:when>
			<xsl:when test="$CodigoCanton = 9">OROTINA</xsl:when>
			<xsl:when test="$CodigoCanton = 10">SAN CARLOS</xsl:when>
			<xsl:when test="$CodigoCanton = 11">ALFARO RUIZ</xsl:when>
			<xsl:when test="$CodigoCanton = 12">VALVERDE VEGA</xsl:when>
			<xsl:when test="$CodigoCanton = 13">UPALA</xsl:when>
			<xsl:when test="$CodigoCanton = 14">LOS CHILES</xsl:when>
			<xsl:when test="$CodigoCanton = 15">GUATUSO</xsl:when>
			<xsl:otherwise>No definido</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CantonesCartago">
		<xsl:param name="CodigoCanton" select="."/>
		<xsl:choose>
			<xsl:when test="$CodigoCanton = 1">CARTAGO</xsl:when>
			<xsl:when test="$CodigoCanton = 2">PARAISO</xsl:when>
			<xsl:when test="$CodigoCanton = 3">LA UNION</xsl:when>
			<xsl:when test="$CodigoCanton = 4">JIMENEZ</xsl:when>
			<xsl:when test="$CodigoCanton = 5">TURRIALBA</xsl:when>
			<xsl:when test="$CodigoCanton = 6">ALVARADO</xsl:when>
			<xsl:when test="$CodigoCanton = 7">OREAMUNO</xsl:when>
			<xsl:when test="$CodigoCanton = 8">EL GUARCO</xsl:when>

			<xsl:otherwise>No definido</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CantonesHeredia">
		<xsl:param name="CodigoCanton" select="."/>
		<xsl:choose>
			<xsl:when test="$CodigoCanton = 1">HEREDIA</xsl:when>
			<xsl:when test="$CodigoCanton = 2">BARVA</xsl:when>
			<xsl:when test="$CodigoCanton = 3">SANTO DOMINGO</xsl:when>
			<xsl:when test="$CodigoCanton = 4">SANTA BARBARA</xsl:when>
			<xsl:when test="$CodigoCanton = 5">SAN RAFAEL</xsl:when>
			<xsl:when test="$CodigoCanton = 6">SAN ISIDRO</xsl:when>
			<xsl:when test="$CodigoCanton = 7">BELEN</xsl:when>
			<xsl:when test="$CodigoCanton = 8">FLORES</xsl:when>
			<xsl:when test="$CodigoCanton = 9">SAN PABLO</xsl:when>
			<xsl:when test="$CodigoCanton = 10">SARAPIQUI</xsl:when>

			<xsl:otherwise>No definido</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CantonesGuanacaste">
		<xsl:param name="CodigoCanton" select="."/>
		<xsl:choose>
			<xsl:when test="$CodigoCanton = 1">LIBERIA</xsl:when>
			<xsl:when test="$CodigoCanton = 2">NICOYA</xsl:when>
			<xsl:when test="$CodigoCanton = 3">SANTA CRUZ</xsl:when>
			<xsl:when test="$CodigoCanton = 4">BAGACES</xsl:when>
			<xsl:when test="$CodigoCanton = 5">CARRILLO</xsl:when>
			<xsl:when test="$CodigoCanton = 6">CAÑAS</xsl:when>
			<xsl:when test="$CodigoCanton = 7">ABANGARES</xsl:when>
			<xsl:when test="$CodigoCanton = 8">TILARAN</xsl:when>
			<xsl:when test="$CodigoCanton = 9">NANDAYURE</xsl:when>
			<xsl:when test="$CodigoCanton = 10">LA CRUZ</xsl:when>
			<xsl:when test="$CodigoCanton = 11">HOJANCHA</xsl:when>
			<xsl:otherwise>No definido</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CantonesPuntarenas">
		<xsl:param name="CodigoCanton" select="."/>
		<xsl:choose>
			<xsl:when test="$CodigoCanton = 1">PUNTARENAS</xsl:when>
			<xsl:when test="$CodigoCanton = 2">ESPARZA</xsl:when>
			<xsl:when test="$CodigoCanton = 3">BUENOS AIRES</xsl:when>
			<xsl:when test="$CodigoCanton = 4">MONTES DE ORO</xsl:when>
			<xsl:when test="$CodigoCanton = 5">OSA</xsl:when>
			<xsl:when test="$CodigoCanton = 6">AGUIRRE</xsl:when>
			<xsl:when test="$CodigoCanton = 7">GOLFITO</xsl:when>
			<xsl:when test="$CodigoCanton = 8">COTO BRUS</xsl:when>
			<xsl:when test="$CodigoCanton = 9">PARRITA</xsl:when>
			<xsl:when test="$CodigoCanton = 10">CORREDORES</xsl:when>
			<xsl:when test="$CodigoCanton = 11">GARABITO</xsl:when>
			<xsl:otherwise>No definido</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CantonesLimon">
		<xsl:param name="CodigoCanton" select="."/>
		<xsl:choose>
			<xsl:when test="$CodigoCanton = 1">LIMON</xsl:when>
			<xsl:when test="$CodigoCanton = 2">POCOCI</xsl:when>
			<xsl:when test="$CodigoCanton = 3">SIQUIRRES</xsl:when>
			<xsl:when test="$CodigoCanton = 4">TALAMANCA</xsl:when>
			<xsl:when test="$CodigoCanton = 5">MATINA</xsl:when>
			<xsl:when test="$CodigoCanton = 6">GUACIMO</xsl:when>
			<xsl:otherwise>No definido</xsl:otherwise>
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