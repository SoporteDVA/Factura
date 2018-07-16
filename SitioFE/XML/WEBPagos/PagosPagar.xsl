<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"></script>
				
			</head>
			<xsl:choose>
				<xsl:when test="xp_ConsultaServicioOutput">
					<xsl:for-each select="xp_ConsultaServicioOutput">
						<xsl:call-template name="FormularioPago"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="xp_ConsultaServicioFault">
					<xsl:for-each select="xp_ConsultaServicioFault">
						<xsl:call-template name="Mensaje"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="xp_PagoServicioOutput">
					<xsl:for-each select="xp_PagoServicioOutput">
						<xsl:call-template name="RespuestaPago"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="xp_PagoServicioFault">
					<xsl:for-each select="xp_PagoServicioFault">
						<xsl:call-template name="Mensaje"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<div align="center">
						<br/>
						<font class="tituloAzulClaro">
							<xsl:value-of select="xp_ConsultaServicioFault/Respuesta"/>
						</font>
						<br/>
						<br/>
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</html>
	</xsl:template>
	<xsl:template name="FormularioPago">
		<body>
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
			<table align="center" width="300" border="0">
				<tr>
					<td width="50%" align="center">
						<font class="tituloAzulClaro">Confirmacion de Pago Servicios</font>
					</td>
				</tr>
			</table>

			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta" align="right">Estado:</td>
					<td colSpan="3" class="detalle">
						<xsl:value-of select="Respuesta"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta" align="right">Usuario:</td>
					<td colSpan="3" class="detalle">
						<xsl:value-of select="Sesion/Usuario"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta" align="right">Oficina:</td>
					<td colSpan="3" class="detalle">
						<xsl:value-of select="Sesion/OficinaUsuario"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta" align="right">Servicio:</td>
					<td colSpan="3" class="detalle">
						<input type="hidden" name="Colector" value="{Colector}"/>
						<xsl:value-of select="DescripcionColector"/>
					</td>
				</tr>

				<xsl:if test="Convenio != '' ">
					<tr>
						<td class="etiqueta" align="right">Convenio:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="DescripcionConvenio"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="Monto != '' ">
					<tr>
						<td class="etiqueta" align="right">Monto:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Monto"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="Identificacion !='' and Monto = ''">
					<tr>
						<td class="etiqueta" align="right">Identificacion:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Identificacion"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="Nombre !=''">
					<tr>
						<td class="etiqueta" align="right">Nombre:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Nombre"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="Servicios/Servicio/Contrato !=''">
					<tr>
						<td class="etiqueta" align="right">Contrato:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Servicios/Servicio/Contrato"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="Servicios/Servicio/NRecibos !=''">
					<xsl:if test="Servicios/Servicio/NRecibos &gt; 3">
						<tr>
							<td class="etiqueta" align="right">Recibos Pendientes:</td>
							<td colSpan="3" class="detalle">
								<xsl:value-of select="Servicios/Servicio/NRecibos"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="Servicios/Servicio/NRecibos = 3">
						<tr>
							<td class="etiqueta" align="right">Recibos Pendientes:</td>
							<td colSpan="3" class="detalle">
								<xsl:value-of select="Servicios/Servicio/NRecibos"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="Servicios/Servicio/NRecibos = 2">
						<tr>
							<td class="etiqueta" align="right">Recibos Pendientes:</td>
							<td colSpan="3" class="detalle">
								<xsl:value-of select="Servicios/Servicio/NRecibos"/>
							</td>
						</tr>
					</xsl:if>
				</xsl:if>
				<xsl:if test="Servicios/Servicio/TotalPago !=''">
					<tr>
						<td class="etiqueta" align="right">Total:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="format-number(Servicios/Servicio/TotalPago,'###,###,###,##0.00')"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="ParametrosConvenio/Moneda!=''">
						<tr>
							<td class="etiqueta" align="right">Moneda:</td>
							<td colSpan="3" class="detalle">
								<xsl:value-of select="ParametrosConvenio/Moneda"/>
							</td>
						</tr>
						<tr>
							<td class="etiqueta" align="right">Monto del Pago:</td>
							<td colSpan="3" class="detalle">
								<xsl:value-of select="ParametrosConvenio/TipoPago"/>
							</td>
						</tr>
						<tr>
							<td class="etiqueta" align="right">Cancela Recibos Atrasados:</td>
							<td colSpan="3" class="detalle">
								<xsl:choose>
									<xsl:when test="ParametrosConvenio/CobroTardio='S'">SI</xsl:when>
									<xsl:otherwise>NO</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</xsl:when>
				</xsl:choose>
			</table>
			<xsl:choose>
				<xsl:when test="ParametrosConvenio/TipoPago='MontoExacto' or ParametrosConvenio/TipoPago='' or  ParametrosConvenio/TipoPago='X'">
					<table align="center" width="300" border="0">
						<tr>
							<td width="50%" align="center">
								<font class="tituloAzulClaro">Recibos Pendientes</font>
							</td>
						</tr>
					</table>
					<xsl:for-each select="Servicios/Servicio/Recibos/Recibo">
						<table class="tabla" align="center">
							<xsl:if test="Periodo !=''">
								<tr>
									<td class="etiqueta" align="right">Periodo:</td>
									<td colSpan="3" class="detalle">
										<xsl:value-of select="Periodo"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="TotalPago !=''">
								<tr>
									<td class="etiqueta" align="right">Monto Recibo:</td>
									<td colSpan="3" class="detalle">
										<!--<xsl:value-of select="TotalPago"/>-->
										<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="NumeroRecibo !=''">
								<tr>
									<td class="etiqueta" align="right">Numero Recibo:</td>
									<td colSpan="3" class="detalle">
										<xsl:value-of select="NumeroRecibo"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="FechaVence !=''">
								<tr>
									<td class="etiqueta" align="right">Vencimiento:</td>
									<td colSpan="3" class="detalle">
										<xsl:value-of select="FechaVence"/>
									</td>
								</tr>
							</xsl:if>
							<tr>
								<td class="etiqueta" align="right">
									<b>Clic para Pagar »»»</b>
									<td class="detalle" align="right">
										<xsl:if test="../../../../Monto !=''">
											<p align="center">
												<a>
													<xsl:attribute name="href">Transaccion.aspx?Transaccion=xp_PagoServicio&amp;DescripcionConvenio=<xsl:value-of select="../../../../DescripcionConvenio"/>&amp;DescripcionColector=<xsl:value-of select="../../../../DescripcionColector"/>&amp;Colector=<xsl:value-of select="../../../../Colector"/>&amp;Convenio=<xsl:value-of select="../../../../Convenio"/>&amp;Numero=<xsl:value-of select="NumeroRecibo"/>&amp;LlavePago=<xsl:value-of select="LlavePago"/>&amp;TotalPago=<xsl:value-of select="format-number(../../../../Monto,'######.00')"/>&amp;ServidorSTX=infoware.STX.Cajas&amp;Filtro=XML/WEBPagos/PagosPagar.xsl</xsl:attribute>
													<xsl:value-of select="format-number(../../../../Monto,'###,###,###,##0.00')"/>
												</a>
											</p>
										</xsl:if>
										<xsl:if test="TotalPago !=''">
											<p align="center">
												<a>
													<xsl:attribute name="href">Transaccion.aspx?Transaccion=xp_PagoServicio&amp;DescripcionConvenio=<xsl:value-of select="../../../../DescripcionConvenio"/>&amp;DescripcionColector=<xsl:value-of select="../../../../DescripcionColector"/>&amp;Colector=<xsl:value-of select="../../../../Colector"/>&amp;Convenio=<xsl:value-of select="../../../../Convenio"/>&amp;Numero=<xsl:value-of select="../../Contrato"/>&amp;LlavePago=<xsl:value-of select="LlavePago"/>&amp;TotalPago=<xsl:value-of select="format-number(TotalPago,'#######.00')"/>&amp;ServidorSTX=infoware.STX.Cajas&amp;Filtro=XML/WEBPagos/PagosPagar.xsl</xsl:attribute>
													<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
												</a>
											</p>
										</xsl:if>
									</td>
								</td>
							</tr>
						</table>
						<br/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ParametrosConvenio/TipoPago='MontosMayores'">
					<table align="center" width="300" border="0">
						<tr>
							<td width="50%" align="center">
								<font class="tituloAzulClaro">El convenio permite cancelar</font>
								<br/>
								<font class="tituloAzulClaro">Montos Iguales o Mayores al monto del recibo original</font>
							</td>
						</tr>
						<tr align="center">
							<td class="etiqueta">
								<br/>
								<font class="tituloAzulClaro">Recibos Pendientes</font>
								<br/>
							</td>
						</tr>
					</table>
					<xsl:for-each select="Servicios/Servicio/Recibos/Recibo">
						<form action="Transaccion.aspx" method="post" name="myForm">
							<table align="center" width="300" border="0">
								<input type="hidden" name="Transaccion" value="xp_PagoServicio"/>
								<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
								<input type="hidden" name="Filtro" value="XML/WEBPagos/PagosPagar.xsl"/>
								<input type="hidden" name="DescripcionConvenio" value="{../../../../DescripcionConvenio}"/>
								<input type="hidden" name="DescripcionColector" value="{../../../../DescripcionColector}"/>
								<input type="hidden" name="Colector" value="{../../../../Colector}"/>
								<input type="hidden" name="Convenio" value="{../../../../Convenio}"/>
								<input type="hidden" name="Numero" value="{../../Contrato}"/>
								<input type="hidden" name="LlavePago" value="{LlavePago}"/>
								<xsl:if test="Periodo !=''">
									<tr>
										<td class="etiqueta" align="right">Periodo:</td>
										<td colSpan="3" class="detalle">
											<xsl:value-of select="Periodo"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="TotalPago !=''">
									<tr>
										<td class="etiqueta" align="right">Monto Recibo:</td>
										<td colSpan="3" class="detalle">
											<!--<xsl:value-of select="TotalPago"/>-->
											<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="NumeroRecibo !=''">
									<tr>
										<td class="etiqueta" align="right">Numero Recibo:</td>
										<td colSpan="3" class="detalle">
											<xsl:value-of select="NumeroRecibo"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="FechaVence !=''">
									<tr>
										<td class="etiqueta" align="right">Vencimiento:</td>
										<td colSpan="3" class="detalle">
											<xsl:value-of select="FechaVence"/>
										</td>
									</tr>
								</xsl:if>

								<tr>
									<td class="etiqueta" align="right">Monto:</td>
									<td class="detalle">
										<input size="20" name="TotalPago" maxlength="10" class="campo" value="{format-number(TotalPago,'#######.00')}"/>
									</td>
								</tr>
								<tr>
									<td align="center" colspan="2">
										<input name="Consultar" type="button" value="Pagar Recibo" onclick="if ( {format-number(TotalPago,'#######.00')} > document.forms[0].TotalPago.value  ) alert('El monto del pago debe ser mayor o igual al monto del recibo'); else submit();"/>
									</td>
								</tr>
							</table>
							<br/>
							<!--<div align="center">
								<input name="Consultar" class="Button_red" type="button" value="Pagar Recibo" onclick="submit();"/>
							</div>-->
						</form>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ParametrosConvenio/TipoPago='MontosMenores'">
					<table align="center" width="300" border="0">
						<tr>
							<td width="50%" align="center">
								<font class="tituloAzulClaro">El convenio permite cancelar</font>
								<br/>
								<font class="tituloAzulClaro">Montos Iguales o Menores</font>
								
							</td>
						</tr>
						<tr align="center">
							<td class="etiqueta">
								<br/>
								<font class="tituloAzulClaro">Recibos Pendientes</font>
								<br/>
							</td>
						</tr>
					</table>
					<xsl:for-each select="Servicios/Servicio/Recibos/Recibo">
						<form action="Transaccion.aspx" method="post" name="myForm2">
							<table align="center" width="300" border="0">
								<input type="hidden" name="Transaccion" value="xp_PagoServicio"/>
								<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
								<input type="hidden" name="Filtro" value="XML/WEBPagos/PagosPagar.xsl"/>
								<input type="hidden" name="DescripcionConvenio" value="{../../../../DescripcionConvenio}"/>
								<input type="hidden" name="DescripcionColector" value="{../../../../DescripcionColector}"/>
								<input type="hidden" name="Colector" value="{../../../../Colector}"/>
								<input type="hidden" name="Convenio" value="{../../../../Convenio}"/>
								<input type="hidden" name="Numero" value="{../../Contrato}"/>
								<input type="hidden" name="LlavePago" value="{LlavePago}"/>
								<xsl:if test="Periodo !=''">
									<tr>
										<td class="etiqueta" align="right">Periodo:</td>
										<td colSpan="3" class="detalle">
											<xsl:value-of select="Periodo"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="TotalPago !=''">
									<tr>
										<td class="etiqueta" align="right">Monto Recibo:</td>
										<td colSpan="3" class="detalle">
											<!--<xsl:value-of select="TotalPago"/>-->
											<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="NumeroRecibo !=''">
									<tr>
										<td class="etiqueta" align="right">Numero Recibo:</td>
										<td colSpan="3" class="detalle">
											<xsl:value-of select="NumeroRecibo"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="FechaVence !=''">
									<tr>
										<td class="etiqueta" align="right">Vencimiento:</td>
										<td colSpan="3" class="detalle">
											<xsl:value-of select="FechaVence"/>
										</td>
									</tr>
								</xsl:if>

								<tr>
									<td class="etiqueta" align="right">Monto:</td>
									<td class="detalle">
										<input size="20" name="TotalPago" maxlength="10" class="campo" value="{format-number(TotalPago,'#######.00')}"/>
									</td>
								</tr>
								<tr>
									<td align="center" colspan="2">
										<input name="Consultar" type="button" value="Pagar Recibo" onclick=" if (  document.forms[0].TotalPago.value > {format-number(TotalPago,'#######.00')}  ) alert('El monto del pago debe ser menor o igual al monto del recibo'); else submit();"/>
									</td>
								</tr>
							</table>
							<br/>
							
						</form>
					</xsl:for-each>
				</xsl:when>

				<xsl:when test="ParametrosConvenio/TipoPago='CualquierMonto'">
					<table align="center" width="300" border="0">
						<tr>
							<td width="50%" align="center">
								<font class="tituloAzulClaro">El convenio permite cancelar</font>
								<br/>
								<font class="tituloAzulClaro">el monto</font>
								<br/>
								<font class="tituloAzulClaro">Igual, Mayor o Menor</font>
							</td>
						</tr>
						<tr align="center">
							<td class="etiqueta">
								<br/>
								<font class="tituloAzulClaro">Recibos Pendientes</font>
								<br/>
							</td>
						</tr>
					</table>
					<xsl:for-each select="Servicios/Servicio/Recibos/Recibo">
						<form action="Transaccion.aspx" method="post">
							<table align="center" width="300" border="0">
								<input type="hidden" name="Transaccion" value="xp_PagoServicio"/>
								<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
								<input type="hidden" name="Filtro" value="XML/WEBPagos/PagosPagar.xsl"/>
								<input type="hidden" name="DescripcionConvenio" value="{../../../../DescripcionConvenio}"/>
								<input type="hidden" name="DescripcionColector" value="{../../../../DescripcionColector}"/>
								<input type="hidden" name="Colector" value="{../../../../Colector}"/>
								<input type="hidden" name="Convenio" value="{../../../../Convenio}"/>
								<input type="hidden" name="Numero" value="{../../Contrato}"/>
								<input type="hidden" name="LlavePago" value="{LlavePago}"/>
								<xsl:if test="Periodo !=''">
									<tr>
										<td class="etiqueta" align="right">Periodo:</td>
										<td colSpan="3" class="detalle">
											<xsl:value-of select="Periodo"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="TotalPago !=''">
									<tr>
										<td class="etiqueta" align="right">Monto Recibo:</td>
										<td colSpan="3" class="detalle">
											<!--<xsl:value-of select="TotalPago"/>-->
											<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="NumeroRecibo !=''">
									<tr>
										<td class="etiqueta" align="right">Numero Recibo:</td>
										<td colSpan="3" class="detalle">
											<xsl:value-of select="NumeroRecibo"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="FechaVence !=''">
									<tr>
										<td class="etiqueta" align="right">Vencimiento:</td>
										<td colSpan="3" class="detalle">
											<xsl:value-of select="FechaVence"/>
										</td>
									</tr>
								</xsl:if>

								<tr>
									<td class="etiqueta" align="right">Monto:</td>
									<td class="detalle">
										<input size="20" name="TotalPago" maxlength="10" class="campo" value="{format-number(TotalPago,'#######.00')}"/>
									</td>
								</tr>

								<tr>
									<td align="center" colspan="2">
										<input name="Consultar" type="button" value="Pagar Recibo" onclick="if (document.forms[0].TotalPago.value == '') alert('El monto del pago debe ser mayor a 0'); else submit();"/>
									</td>
								</tr>
							</table>
							
						</form>
					</xsl:for-each>
				</xsl:when>
			</xsl:choose>



			<div align="center">
				<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="ConsultaMaestros"/>
					<input type="hidden" name="Filtro" value="XML/WEBPagos/PagosConsultar.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
					<input name="BotonCerrar" class="button_gris" type="submit" value="   Cancelar   "/>
				</form>
			</div>
		</body>
	</xsl:template>
	<xsl:template name="RespuestaPago">
		<div align="center">
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
			<br/>
			<table align="center" width="300" border="0">
				<tr>
					<td width="50%" align="center">
						<font class="tituloAzulClaro">Resultado del Pago</font>
					</td>
				</tr>
			</table>
			<table class="tabla" align="center">

				<tr>
					<td class="etiqueta" align="right">Mensaje:</td>
					<td colSpan="3" class="tablaResaltado">
						<xsl:value-of select="Respuesta"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta" align="right">Servicio:</td>
					<td colSpan="3" class="detalle">
						<xsl:value-of select="Colector"/>-<xsl:value-of select="DescripcionColector"/></td>
				</tr>
				<tr>
					<td class="etiqueta" align="right">Convenio:</td>
					<td colSpan="3" class="detalle">
						<xsl:value-of select="Convenio"/>-<xsl:value-of select="ConvenioDesc"/></td>
				</tr>
				<tr>
					<td class="etiqueta" align="right">Documento:</td>
					<td colSpan="3" class="detalle">
						<xsl:value-of select="NumeroDocumento"/>
					</td>
				</tr>
				<xsl:if test="Servicio/Identificacion !=''">
					<tr>
						<td class="etiqueta" align="right">Identificacion:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Servicio/Identificacion"/>
						</td>
					</tr>
				</xsl:if>
				<tr>
					<td class="etiqueta" align="right">Nombre:</td>
					<td colSpan="3" class="detalle">
						<xsl:value-of select="Servicio/Nombre"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta" align="right">Numero:</td>
					<td colSpan="3" class="detalle">
						<xsl:value-of select="Servicio/Numero"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta" align="right">Total:</td>
					<td colSpan="3" class="detalle">

						<xsl:value-of select="format-number(Servicio/TotalPago,'###,###,###,##0.00')"/>
					</td>
				</tr>
				<xsl:if test="Servicio/Recibo/NumeroRecibo !=''">
					<tr>
						<td class="etiqueta" align="right">Factura o Recibo:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Servicio/Recibo/NumeroRecibo"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="Servicio/Recibo/FechaPago !=''">
					<tr>
						<td class="etiqueta" align="right">Fecha Pago:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Servicio/Recibo/FechaPago"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="Servicio/Recibo/FechaVence !=''">
					<tr>
						<td class="etiqueta" align="right">Fecha Vencimiento:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="substring(Servicio/Recibo/FechaVence,7,2)"/>/<xsl:value-of select="substring(Servicio/Recibo/FechaVence,5,2)"/>/<xsl:value-of select="substring(Servicio/Recibo/FechaVence,1,4)"/></td>
					</tr>
				</xsl:if>
				<xsl:if test="Servicio/Recibo/Periodo !=''">
					<tr>
						<td class="etiqueta" align="right">Periodo:</td>
						<td colSpan="3" class="detalle">
							<xsl:value-of select="Servicio/Recibo/Periodo"/>
						</td>
					</tr>
				</xsl:if>
			</table>
			<br/>
			<xsl:if test="Servicio/Recibo/NRubros !=''">
				<table align="center" width="300" border="0">
					<tr>
						<td width="50%" align="center">
							<font class="tituloAzulClaro">Rubros del Pago</font>
						</td>
					</tr>
				</table>
				<table class="tabla" align="center" width="300">
					<thead>
						<tr class="etiqueta">
							<xsl:if test="Servicio/Recibo/Rubros/Rubro/Codigo != ''">
								<th class="etiqueta" align="center">Rubro</th>
							</xsl:if>
							<xsl:if test="Servicio/Recibo/Rubros/Rubro/Descripcion != ''">
								<th class="etiqueta" align="center">Descripcion</th>
							</xsl:if>
							<xsl:if test="Servicio/Recibo/Rubros/Rubro/Monto != ''">
								<th class="etiqueta" align="center">Valor</th>
							</xsl:if>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="Servicio/Recibo/Rubros/Rubro[Codigo!='']">
							<tr>
								<xsl:if test="Codigo !=''">
									<td class="detalle">
										<xsl:if test="Codigo !='EXFV'">
											<xsl:value-of select="Codigo"/>
										</xsl:if>
									</td>
								</xsl:if>
								<xsl:if test="Descripcion !=''">
									<td class="detalle">
										<xsl:if test="Codigo !='EXFV'">
											<xsl:value-of select="Descripcion"/>
										</xsl:if>
									</td>
								</xsl:if>
								<xsl:if test="Monto !=''">
									<td class="detalle">
										<xsl:if test="Codigo != 'EXFV'">
											<xsl:value-of select="Monto"/>
										</xsl:if>
									</td>
								</xsl:if>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</xsl:if>
		</div>

		<br/>

		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="xp_BitacoraCJPago"/>
				<input type="hidden" name="Filtro" value="XML/WEBImpresion/WEBImpresion.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input type="hidden" name="Colector" value="{Colector}"/>
				<input type="hidden" name="Canal" value="Sitio"/>
				<input type="hidden" name="Documento" value="{NumeroDocumento}"/>
				<input type="hidden" name="FechaConsulta" value="{Servicio/Recibo/FechaPago}"/>
				<input type="hidden" name="DescripcionColector" value="{DescripcionColector}"/>
				<input type="hidden" name="DescripcionConvenio" value="{ConvenioDesc}"/>
				<input type="hidden" name="TipoEmision" value="Original"/>
				<input name="BotonCerrar" class="button_red" type="submit" value="   Imprimir Tiquete  "/>
			</form>
		</div>

		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="ConsultaMaestros"/>
				<input type="hidden" name="Filtro" value="XML/WEBPagos/PagosConsultar.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="   Otra Consulta   "/>
			</form>
		</div>
	</xsl:template>
	<xsl:template name="Mensaje">
		<div align="center">
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
			<br/>
			<table class="tabla" align="center">

				<tr>
					<td class="etiqueta">Mensaje:</td>
					<td colSpan="3" class="tablaResaltado">
						<xsl:value-of select="Mensaje"/>
					</td>
				</tr>
			</table>
			<br/>
		</div>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="ConsultaMaestros"/>
				<input type="hidden" name="Filtro" value="XML/WEBPagos/PagosConsultar.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="   Otra Consulta   "/>
			</form>
		</div>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="xp_ConsultaServicioOutput.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->