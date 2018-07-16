<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión y Control de Cierres de Caja</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"></script>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
			</head>
			<body>
				<p>&#xA0;</p>
				<p align="center">
					<table border="0">
						<tbody>
							<tr>
								<td width="50%">
									<p align="center">
										<img hspace="0" src="imagenes/DVA.jpg" align="baseline" border="0"/>
									</p>
								</td>
								<td width="50%">
									<p align="center">
										<font class="tituloAzulClaro">
											<strong>Gestión y Control de Cierre Cajas</strong>
										</font>
									</p>
								</td>
							</tr>
							<xsl:choose>
								<xsl:when test="EjecutarPasoPrevioOutput">
									<xsl:call-template name="MostrarMensaje">
										<xsl:with-param name="Mensaje" select="EjecutarPasoPrevioOutput/Respuesta"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="ConsultaPreviaOutput">
									<xsl:for-each select="ConsultaPreviaOutput">
										<xsl:call-template name="Encabezado"/>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="ConsultaCierreCajasOutput">
									<xsl:for-each select="ConsultaCierreCajasOutput">
										<xsl:call-template name="Encabezado"/>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="GeneraCierreCajaOutput">
									<xsl:for-each select="GeneraCierreCajaOutput">
										<xsl:call-template name="Encabezado"/>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="ConsultaCierreDetalladoOutput">
									<xsl:for-each select="ConsultaCierreDetalladoOutput">
										<xsl:call-template name="Encabezado"/>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="CierreCajaOutput">
									<xsl:for-each select="CierreCajaOutput">
										<xsl:call-template name="Encabezado"/>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="ConsultaPreviaFault">
									<xsl:for-each select="ConsultaPreviaFault">
										<xsl:call-template name="Encabezado"/>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="ConsultaCierreCajasFault">
									<xsl:for-each select="ConsultaCierreCajasFault">
										<xsl:call-template name="Encabezado"/>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="GeneraCierreCajaFault">
									<xsl:for-each select="GeneraCierreCajaFault">
										<xsl:call-template name="Encabezado"/>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="ConsultaCierreDetalladoFault">
									<xsl:for-each select="ConsultaCierreDetalladoFault">
										<xsl:call-template name="Encabezado"/>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="CierreCajaFault">
									<xsl:for-each select="CierreCajaFault">
										<xsl:call-template name="Encabezado"/>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="Encabezado2">
										<xsl:with-param name="Mensaje">Ha ocurrido un error.</xsl:with-param>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</tbody>
					</table>
				</p>
				<p>&#xA0;</p>
				<xsl:choose>
					<xsl:when test="EjecutarPasoPrevioOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="EjecutarPasoPrevioOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="ConsultaPreviaOutput">
						<xsl:for-each select="ConsultaPreviaOutput">
							<xsl:call-template name="CierreCajas"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="ConsultaCierreCajasOutput">
						<xsl:for-each select="ConsultaCierreCajasOutput">
							<xsl:call-template name="CierreCajas"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="GeneraCierreCajaOutput">
						<xsl:for-each select="GeneraCierreCajaOutput">
							<xsl:call-template name="CierreCajas"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="ConsultaCierreDetalladoOutput">
						<xsl:for-each select="ConsultaCierreDetalladoOutput">
							<xsl:call-template name="CierreCajas"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="CierreCajaOutput">
						<xsl:for-each select="CierreCajaOutput">
							<xsl:call-template name="CierreCajas"/>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="MostrarMensaje">
		<xsl:param name="Mensaje" select="."/>
		<div align="center">
			<br/>
			<font class="tituloAzulClaro">
				<xsl:value-of select="$Mensaje"/>
			</font>
			<br/>
			<br/>
		</div>
	</xsl:template>
	<xsl:template name="Encabezado">
		<tr>
			<td width="50%">
				<p align="center">
					<strong>Cliente:</strong>
				</p>
			</td>
			<td width="50%">
				<p align="center">
					<strong>
						<xsl:value-of select="Sesion/ClienteNombre"/>
					</strong>
				</p>
			</td>
		</tr>
		<xsl:if test="Respuesta!=''">
			<tr>
				<td width="50%">
					<p align="center">
						<strong>Aviso:</strong>
					</p>
				</td>
				<td width="50%">
					<p align="center">
						<strong>
							<xsl:value-of select="Respuesta"/>
						</strong>
					</p>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>
	<xsl:template name="Encabezado2">
		<xsl:param name="Mensaje" select="."/>
		<td width="50%">
			<p align="center">
				<strong>Cliente:</strong>
			</p>
		</td>
		<td width="50%">
			<p align="center">
				<strong>
					<xsl:value-of select="$Mensaje"/>
				</strong>
			</p>
		</td>
	</xsl:template>
	<xsl:template name="CierreCajas">
		<table class="tablaDetalle" align="center" border="0">
			<tfoot align="center"/>
			<tbody>
				<tr class="encabezado">
					<td rowspan="2">
						<p align="center">
							<strong>Caja</strong>
						</p>
					</td>
					<!--<td rowspan="2">
						<p align="center">
							<strong>Descripción</strong>
						</p>
					</td>-->
					<td rowspan="2" align="center">
						<strong>Fecha</strong>
						<p/>
						<strong>Recaudación</strong>
					</td>
					<td rowspan="2" align="center">
						<strong>Estado</strong>
					</td>
					<td colspan="2" align="center">
						<strong>Recaudado</strong>
					</td>
					<td rowspan="2" align="center">
						<strong>Comisión</strong>
					</td>
					<td align="center" colspan="18">
						<strong>Transacciones SOA</strong>
					</td>
					<!--<td align="center" colspan="2">
						<strong>Su Vida</strong>
					</td>-->
					<td align="center" colspan="3">
						<strong>Acciones</strong>
					</td>
				</tr>
				<tr class="encabezado">
					<td align="center">
						<strong>Local</strong>
					</td>
					<td align="center">
						<strong>INS</strong>
					</td>
					<td align="center">
						<strong>Total</strong>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/vwicn036.gif" align="baseline" border="0" alt="Exitosos"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/vwicn157.gif" align="baseline" border="0" alt="Reversados"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/vwicn032.gif" align="baseline" border="0" alt="Duplicados"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/vwicn160.gif" align="baseline" border="0" alt="Polizas Turista"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/PolizaAGV2.jpg" align="baseline" border="0" alt="Polizas AGV"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/SinRTV.jpg" align="baseline" border="0" alt="Pagos Sin RTV"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/ConRTV.jpg" align="baseline" border="0" alt="Pagos Sin RTV a Marchamos"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/auto.gif" align="baseline" border="0" alt="Pagos Temporales"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/SuVida.jpg" align="baseline" border="0" alt="Pagos SuVida"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/Ley.jpg" align="baseline" border="0" alt="Pagos RespCivil"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/Asis.gif" align="baseline" border="0" alt="Pagos Asistencia"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/Cobertura.gif" align="baseline" border="0" alt="Pagos Cobertura"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/Proteccion.gif" align="baseline" border="0" alt="Pagos Proteccion"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/vwicn038.gif" align="baseline" border="0" alt="Con Problemas"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/vwicn039.gif" align="baseline" border="0" alt="Pendientes"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/vwicn132.gif" align="baseline" border="0" alt="Comprobantes Sin Imprimir"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/vwicn071.gif" align="baseline" border="0" alt="Sin Conciliar"/>
					</td>
					<!--<td align="center">Cantidad</td>
					<td align="center">Monto</td>-->
					<td align="center">
						<strong>Recalcular</strong>
					</td>

					<td align="center">
						<strong>INS</strong>
					</td>
					<td align="center">
						<strong>Siguiente</strong>
					</td>
				</tr>
				<xsl:for-each select="Cierres/Fila[NumeroCaja&gt;0]">
					<tr class="detalle">
						<td>
							<p align="center">
								<xsl:value-of select="NumeroCaja"/>
							</p>
						</td>
						<!--<td>
							<p align="center">
								<xsl:value-of select="NombreCaja"/>
							</p>
						</td>-->
						<td class="detalle">
							<p align="center">
								<xsl:value-of select="FechaCaja"/>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:value-of select="EstadoCaja"/>
							</p>
						</td>
						<td class="detalle">
							<p align="right">
								<xsl:value-of select="format-number(TotalPago,'###,##0')"/>
							</p>
						</td>
						<td class="detalle">
							<p align="right">
								<xsl:value-of select="format-number(INSTotalPago,'###,##0')"/>
							</p>
						</td>
						<td class="detalle">
							<p align="right">
								<xsl:value-of select="format-number(Comision,'###,##0')"/>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosTotales &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=Todas&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosTotales"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosTotales = 0">
									<xsl:value-of select="PagosTotales"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosExito &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=PG&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosExito"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosExito = 0">
									<xsl:value-of select="PagosExito"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosReversados &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=RV&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosReversados"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosReversados = 0">
									<xsl:value-of select="PagosReversados"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosDuplicados &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=DG&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosDuplicados"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosDuplicados = 0">
									<xsl:value-of select="PagosDuplicados"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosTUR &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=TUR&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosTUR"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosTUR = 0">
									<xsl:value-of select="PagosTUR"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosAGV &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=AGV&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosAGV"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosAGV = 0">
									<xsl:value-of select="PagosAGV"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosSinRTV &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=SRTV&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosSinRTV"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosSinRTV = 0">
									<xsl:value-of select="PagosSinRTV"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosGenSinRTV &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=GRTV&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosGenSinRTV"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosGenSinRTV = 0">
									<xsl:value-of select="PagosGenSinRTV"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosTemporales &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=TMP&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosTemporales"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosTemporales = 0">
									<xsl:value-of select="PagosTemporales"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosSuVida &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=SV&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosSuVida"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosSuVida = 0">
									<xsl:value-of select="PagosSuVida"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosRespCivil &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=RC&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosRespCivil"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosRespCivil = 0">
									<xsl:value-of select="PagosRespCivil"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosAsistencia &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=AC&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosAsistencia"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosAsistencia = 0">
									<xsl:value-of select="PagosAsistencia"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosCobertura &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=AC&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosCobertura"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosCobertura = 0">
									<xsl:value-of select="PagosCobertura"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosProteccion &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=MP&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosProteccion"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosProteccion = 0">
									<xsl:value-of select="PagosProteccion"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosError &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=PE&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosError"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosError = 0">
									<xsl:value-of select="PagosError"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosPendientes &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=PP&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosPendientes"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosPendientes = 0">
									<xsl:value-of select="PagosPendientes"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="PagosSinImprimir &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=SP&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosSinImprimir"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosSinImprimir = 0">
									<xsl:value-of select="PagosSinImprimir"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:if test="SinConciliar !=0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=ObtenerPagosAConciliar&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=Todas&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalleSC.xsl</xsl:attribute>
										<xsl:value-of select="SinConciliar"/>
									</a>
								</xsl:if>
								<xsl:if test="SinConciliar = 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=ObtenerPagosAConciliar&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=Todas&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalleSC.xsl</xsl:attribute>
										<xsl:value-of select="SinConciliar"/>
									</a>
								</xsl:if>
							</p>
						</td>
						<!--<td class="detalle">
							<p align="center">
								<xsl:if test="PagosSuVida &gt; 0">
									<a>
										<xsl:attribute name="href">Transaccion.aspx?Transaccion=CajaConsultaPagos&amp;NumeroCaja=<xsl:value-of select="NumeroCaja"/>&amp;Fecha=<xsl:value-of select="FechaCaja"/>&amp;Estado=SVG&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/Cajas/CajaDetalle.xsl</xsl:attribute>
										<xsl:value-of select="PagosSuVida"/>
									</a>
								</xsl:if>
								<xsl:if test="PagosSuVida = 0">
									<xsl:value-of select="PagosSuVida"/>
								</xsl:if>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:value-of select="format-number(MontoSuVida,'#,##0')"/>
							</p>
						</td>-->
						<td>
							<p align="center">
								<xsl:choose>
									<xsl:when test="CodigoEstado&lt;7">
										<img hspace="0" src="imagenes/vwicn033.gif" align="baseline" border="0"
										     onclick="cargar(this,'Transaccion.aspx?Transaccion=GeneraCierreCaja&amp;NumeroCaja={NumeroCaja}&amp;Fecha={FechaCaja}&amp;Accion=Una&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/CierreCajas/ConsultaCierreCajas.xsl','Transaccion')"
										     alt="Recalcular"/>
									</xsl:when>
									<xsl:when test="CodigoEstado=7 and PagosTotales&gt;0">
										<img hspace="0" src="imagenes/vwicn033.gif" align="baseline" border="0"
										     onclick="cargar(this,'Transaccion.aspx?Transaccion=GeneraCierreCaja&amp;NumeroCaja={NumeroCaja}&amp;Fecha={FechaCaja}&amp;Accion=Una&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/CierreCajas/ConsultaCierreCajas.xsl','Transaccion')"
										     alt="Recalcular"/>
									</xsl:when>
									<xsl:otherwise>
										<img hspace="0" src="imagenes/vwicn165.gif" align="baseline" border="0" alt="Caja Cerrada"/>
									</xsl:otherwise>
								</xsl:choose>
							</p>
						</td>
						<td>
							<xsl:if test="CodigoEstado&gt;3">
								<p align="center">
									<xsl:if test="CodigoEstado&lt;7">
										<img hspace="0" src="imagenes/vwicn180.gif" align="baseline" border="0"
										     onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaPrevia&amp;NumeroCaja={NumeroCaja}&amp;FechaCaja={FechaCaja}&amp;Accion=Una&amp;Estado=1&amp;CajaRecaudador={CajaRecaudador}&amp;UsuarioINS={UsuarioINS}&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/CierreCajas/ConsultaCierreCajas.xsl','Transaccion')"
										     alt="Recalcular INS"/>
									</xsl:if>
									<xsl:if test="CodigoEstado&gt;6">
										<img hspace="0" src="imagenes/vwicn164.gif" align="baseline" border="0"
										     onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCierreDetallado&amp;NumeroCaja={NumeroCaja}&amp;FechaCaja={FechaCaja}&amp;Accion=Una&amp;Estado={CodigoEstado}&amp;CajaRecaudador={CajaRecaudador}&amp;UsuarioINS={UsuarioINS}&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/CierreCajas/ConsultaCierreCajas.xsl','Transaccion')"
										     alt="Recalcular INS"/>
									</xsl:if>
								</p>
							</xsl:if>
						</td>
						<td>
							<xsl:choose>
								<xsl:when test="CodigoEstado=3">
									<img hspace="0" src="imagenes/vwicn121.gif" align="baseline" border="0"
									     onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaPrevia&amp;NumeroCaja={NumeroCaja}&amp;FechaCaja={FechaCaja}&amp;Accion=Una&amp;Estado=1&amp;CajaRecaudador={CajaRecaudador}&amp;UsuarioINS={UsuarioINS}&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/CierreCajas/ConsultaCierreCajas.xsl','Transaccion')"
									     alt="Consulta Previa INS"/>
								</xsl:when>
								<xsl:when test="CodigoEstado=3">
									<img hspace="0" src="imagenes/vwicn071.gif" align="baseline" border="0"
									     onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaPrevia&amp;NumeroCaja={NumeroCaja}&amp;FechaCaja={FechaCaja}&amp;Accion=Una&amp;Estado=1&amp;CajaRecaudador={CajaRecaudador}&amp;UsuarioINS={UsuarioINS}&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/CierreCajas/ConsultaCierreCajas.xsl','Transaccion')"
									     alt="Conciliar INS"/>
								</xsl:when>
								<xsl:when test="CodigoEstado&gt;4 and CodigoEstado&lt;7 and SinConciliar=0">
									<img hspace="0" src="imagenes/vwicn123.gif" align="baseline" border="0"
									     onclick="Preguntar('¿Esta seguro que desea realizar el Cierre de la Caja {NumeroCaja} para el {FechaCaja}?', this,'Transaccion.aspx?Transaccion=CierreCaja&amp;NumeroCaja={NumeroCaja}&amp;FechaCaja={FechaCaja}&amp;Accion=Una&amp;Estado=1&amp;CajaRecaudador={CajaRecaudador}&amp;UsuarioINS={UsuarioINS}&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/CierreCajas/ConsultaCierreCajas.xsl','Transaccion')"
									     alt="Cierre Caja"/>
								</xsl:when>
								<xsl:when test="CodigoEstado&gt;6">
									<img hspace="0" src="imagenes/vwicn165.gif" align="baseline" border="0" alt="Caja Cerrada"/>
								</xsl:when>
								<xsl:otherwise></xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template name="Estado">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 1">Activo</xsl:when>
			<xsl:when test="$Codigo = 0">Inactivo</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ConsultaCierreCajasDetallado.xml" htmlbaseurl="192.168.1.9" outputurl="" processortype="saxon8" useresolver="yes" profilemode="4" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
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
			<SourceSchema srcSchemaPath="..\..\..\Proyectos\STX-NET\DVANew\xml\BitacoraCJResumen.xml" srcSchemaRoot="BitacoraCJResumen" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
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