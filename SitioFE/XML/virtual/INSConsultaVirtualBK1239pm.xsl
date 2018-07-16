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

				<table align="center" width="500" border="0">
					<tr>
						<td width="50%">
							<p align="center">
								<img align="baseline" src="imagenes/ins.gif" border="0" hspace="0" height="60"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Formulario de Pago de Marchamo</font>
						</td>
					</tr>
				</table>
				<br/>
				<xsl:choose>
					<xsl:when test="INSConsultaVirtualOutput">
						<xsl:for-each select="INSConsultaVirtualOutput">
							<xsl:call-template name="Consulta"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="INSConsultaConfirmarOutput">
						<xsl:for-each select="INSConsultaConfirmarOutput">
							<xsl:call-template name="ConsultaVirtualConfirmar"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error en la consulta del marchamo!
								<br/>
								<xsl:value-of select="INSConsultaConfirmarFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>


	<xsl:template name="Consulta">
		<table class="tabla" align="center">
			<tr class="etiqueta">
				<td>Placa:</td>
				<td class="detalle">
					<xsl:value-of select="SOA_RESULT_PLACA/ENCABEZADO/CLASEPLACA"/>-
					<xsl:value-of select="SOA_RESULT_PLACA/ENCABEZADO/NUMPLACA"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Marca:</td>
				<td class="detalle">
					<xsl:value-of select="SOA_RESULT_PLACA/ENCABEZADO/DESMARCA"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Período:</td>
				<td class="detalle">
					<xsl:value-of select="SOA_RESULT_PLACA/ENCABEZADO/PERIODO"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Nombre:</td>
				<td class="detalle">
					<xsl:value-of select="SOA_RESULT_PLACA/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Identificación:</td>
				<td class="detalle">
					<xsl:value-of select="SOA_RESULT_PLACA/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
				</td>
			</tr>
			<xsl:if test="INSConsultaVirtualOutput/TipoComprobante = 100">
				<tr align="center" class="etiqueta">
					<td colspan="2">Pólizas a pagar</td>
				</tr>
				<tr>
					<td class="etiqueta">Incluye Su Vida:</td>
					<xsl:choose>
						<xsl:when test="SOA_RESULT_PLACA/PRODUCTOSADICIONALES[CODPRODUCTO=4 and CODRES=15]">
							<td class="detalle">SI</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="detalle">NO</td>
						</xsl:otherwise>
					</xsl:choose>
				</tr>
				<tr>
					<td class="etiqueta">Incluye Responsabilidad Civil :</td>
					<xsl:choose>
						<xsl:when test="SOA_RESULT_PLACA/PRODUCTOSADICIONALES[CODPRODUCTO=5 and CODRES=15]">
							<td class="detalle">SI</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="detalle">NO</td>
						</xsl:otherwise>
					</xsl:choose>
				</tr>
				<tr>
					<td class="etiqueta">Incluye Asistencia Carretera :</td>
					<xsl:choose>
						<xsl:when test="SOA_RESULT_PLACA/PRODUCTOSADICIONALES[CODPRODUCTO=6 and CODRES=15]">
							<td class="detalle">SI</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="detalle">NO</td>
						</xsl:otherwise>
					</xsl:choose>
				</tr>
				<tr>
					<td class="etiqueta">Incluye Cobertura Adicional :</td>
					<xsl:choose>
						<xsl:when test="SOA_RESULT_PLACA/PRODUCTOSADICIONALES[CODPRODUCTO=7 and CODRES=15]">
							<td class="detalle">SI</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="detalle">NO</td>
						</xsl:otherwise>
					</xsl:choose>
				</tr>
				<tr>
					<td class="etiqueta">Incluye Mas Protección :</td>
					<xsl:choose>
						<xsl:when test="SOA_RESULT_PLACA/PRODUCTOSADICIONALES[CODPRODUCTO=8 and CODRES=15]">
							<td class="detalle">SI</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="detalle">NO</td>
						</xsl:otherwise>
					</xsl:choose>
				</tr>
			</xsl:if>
			<tr>
				<td class="etiqueta">Monto :</td>
				<td class="detalleTotal">
					<font size="3" color="red">
						<xsl:value-of select="format-number(SOA_RESULT_PLACA/ENCABEZADO/MONTO,'###,###,##0.00')"/>
					</font>
				</td>
			</tr>

			<tr align="center" class="etiqueta">
				<td colspan="2">Detalle del Monto a Cancelar</td>
			</tr>

			<xsl:for-each select="SOA_RESULT_PLACA/RUBRO">
				<tr>
					<td class="etiqueta">
						<xsl:value-of select="DESRUBRO"/>
					</td>
					<td class="detalleTotal">
						<xsl:value-of select="format-number(MONTOTRUBRO,'###,###,##0.00')"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>

		<form action="Transaccion.aspx">
			<xsl:choose>
				<xsl:when test="SOA_RESULT_PLACA/ENCABEZADO/CODRES = 9 or SOA_RESULT_PLACA/ENCABEZADO/CODRES = 0 or SOA_RESULT_PLACA/ENCABEZADO/CODRES = 7 or SOA_RESULT_PLACA/ENCABEZADO/CODRES = 6">
					<xsl:if test="SOA_RESULT_PLACA/ENCABEZADO/CODRES = 9">
						<div align="center">
							<br/>
							<font size="3" color="red">
								<xsl:value-of select="SOA_RESULT_PLACA/ENCABEZADO/DESRES"/>
							</font>
							<!--<font class="tituloAzulClaro">La placa se encuentra pagada.</font>-->
						</div>
					</xsl:if>
					<xsl:if test="SOA_RESULT_PLACA/ENCABEZADO/CODRES = 6">
						<div align="center">
							<font class="tituloAzulClaro">El vehículo sólo se podrá pagar por medio de Pago Temporal.</font>
							<br/>
						</div>
					</xsl:if>
					<xsl:if test="SOA_RESULT_PLACA/ENCABEZADO/CODRES = 7">
						<div align="center">
							<br/>
							<font class="tituloAzulClaro">El vehículo sólo se podrá pagar por medio de Pago sin RTV.</font>
							<font class="tituloAzulClaro">Asegurese de seleccionar una caja con ese tipo de formulario!.</font>
							<br/>
						</div>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="NumeroConsecutivo!= ''">
							<input type="hidden" name="Transaccion" value="INSConsultaConfirmar"/>
							<input type="hidden" name="Filtro" value="XML/virtual/INSConsultaVirtual.xsl"/>
							<input type="hidden" name="CLASEPLACA" value="{SOA_RESULT_PLACA/ENCABEZADO/CLASEPLACA}"/>
							<input type="hidden" name="NUMPLACA" value="{SOA_RESULT_PLACA/ENCABEZADO/NUMPLACA}"/>
							<input type="hidden" name="CODGOBIERNO" value="{SOA_RESULT_PLACA/ENCABEZADO/CODGOBIERNO}"/>
							<input type="hidden" name="INDPOLIZARESCIVIL" value="{INDPOLIZASRESCIVIL}"/>
							<input type="hidden" name="INDPOLIZASV" value="{INDPOLIZASV}"/>
							<input type="hidden" name="INDPOLIZAAC" value="{INDPOLIZAAC}"/>
							<input type="hidden" name="INDPROTECCION" value="{INDPROTECCION}"/>
							<input type="hidden" name="INDCOBERTURA" value="{INDCOBERTURA}"/>
							<br/>
														<!--<xsl:if test="SOA_RESULT_PLACA/ENCABEZADO/CODRES&lt;9">-->
							<!--Se controla que el estado sea 0 para poder realizar el pago de la placa-->
							<xsl:if test="SOA_RESULT_PLACA/ENCABEZADO/CODRES=0">
								<table align="center" class="tabla">
									<tr>
										<td class="etiqueta">Sucursal Entrega :</td>
										<td colSpan="3" class="detalle">
											<select class="campo" name="NUMEROCAJAVIRTUAL">
												<OPTION VALUE="">--- Seleccione ---</OPTION>
												<xsl:for-each select="Cajas/Fila">

													<option value="{NumeroCaja}">
														<xsl:value-of select="DescripcionCaja"/>
													</option>
												</xsl:for-each>
											</select>
										</td>
									</tr>
								</table>
							</xsl:if>
							<br/>
							<xsl:choose>
								<xsl:when test="TipoComprobante=100">
									<xsl:call-template name="BotonesConfirmar"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="BotonesMarchamo"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="MostrarMensaje">
								<xsl:with-param name="Mensaje">
									<xsl:value-of select="Respuesta"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="SOA_RESULT_PLACA/ENCABEZADO/CODRES = 8">
					<xsl:call-template name="MostrarMensaje">
						<xsl:with-param name="Mensaje">El vehículo no tiene revisión técnica.</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="MostrarMensaje">
						<xsl:with-param name="Mensaje">La placa tiene algún tipo de problema y no se podrá pagar.</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</form>
	</xsl:template>
	<xsl:template name="ConsultaVirtualConfirmar">
		<table class="tabla" align="center">
			<tr class="etiqueta">
				<td>Sucursal Entrega:</td>
				<td class="detalle">
					<xsl:value-of select="NumeroCajaVirtual"/>
				</td>
			</tr>

			<tr class="etiqueta">
				<td>Número de placa:</td>
				<td class="detalle">
					<xsl:value-of select="SOA_RESULT_PLACA/ENCABEZADO/CLASEPLACA"/>-
					<xsl:value-of select="SOA_RESULT_PLACA/ENCABEZADO/NUMPLACA"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Marca:</td>
				<td class="detalle">
					<xsl:value-of select="SOA_RESULT_PLACA/ENCABEZADO/DESMARCA"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Período:</td>
				<td class="detalle">
					<xsl:value-of select="SOA_RESULT_PLACA/ENCABEZADO/PERIODO"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Nombre:</td>
				<td class="detalle">
					<xsl:value-of select="SOA_RESULT_PLACA/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Identificación:</td>
				<td class="detalle">
					<xsl:value-of select="SOA_RESULT_PLACA/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
				</td>
			</tr>
			<tr align="center" class="etiqueta">
				<td colspan="2">Pólizas a pagar</td>
			</tr>
			<tr>
				<td class="etiqueta">Incluye Su Vida:</td>
				<xsl:choose>
					<xsl:when test="SOA_RESULT_PLACA/PRODUCTOSADICIONALES[CODPRODUCTO=4 and CODRES=15]">
						<td class="detalle">SI</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="detalle">NO</td>
					</xsl:otherwise>
				</xsl:choose>
			</tr>
			<tr>
				<td class="etiqueta">Incluye Responsabilidad Civil :</td>
				<xsl:choose>
					<xsl:when test="SOA_RESULT_PLACA/PRODUCTOSADICIONALES[CODPRODUCTO=5 and CODRES=15]">
						<td class="detalle">SI</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="detalle">NO</td>
					</xsl:otherwise>
				</xsl:choose>
			</tr>
			<tr>
				<td class="etiqueta">Incluye Asistencia Carretera :</td>
				<xsl:choose>
					<xsl:when test="SOA_RESULT_PLACA/PRODUCTOSADICIONALES[CODPRODUCTO=6 and CODRES=15]">
						<td class="detalle">SI</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="detalle">NO</td>
					</xsl:otherwise>
				</xsl:choose>
			</tr>
			<tr>
				<td class="etiqueta">Incluye Cobertura Adicional :</td>
				<xsl:choose>
					<xsl:when test="SOA_RESULT_PLACA/PRODUCTOSADICIONALES[CODPRODUCTO=7 and CODRES=15]">
						<td class="detalle">SI</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="detalle">NO</td>
					</xsl:otherwise>
				</xsl:choose>
			</tr>
			<tr>
				<td class="etiqueta">Incluye Mas Protección :</td>
				<xsl:choose>
					<xsl:when test="SOA_RESULT_PLACA/PRODUCTOSADICIONALES[CODPRODUCTO=8 and CODRES=15]">
						<td class="detalle">SI</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="detalle">NO</td>
					</xsl:otherwise>
				</xsl:choose>
			</tr>
			<tr>
				<td class="etiqueta">Monto :</td>
				<td class="detalleTotal">
					<xsl:value-of select="format-number(SOA_RESULT_PLACA/ENCABEZADO/MONTO,'###,###,##0.00')"/>
				</td>
			</tr>
		</table>
		<form action="Transaccion.aspx">
			<xsl:choose>
				<xsl:when test="SOA_RESULT_PLACA/ENCABEZADO/CODRES = 9 or SOA_RESULT_PLACA/ENCABEZADO/CODRES = 0 or SOA_RESULT_PLACA/ENCABEZADO/CODRES = 7 or SOA_RESULT_PLACA/ENCABEZADO/CODRES = 6">
					<xsl:if test="SOA_RESULT_PLACA/ENCABEZADO/CODRES = 9">
						<div align="center">
							<font class="tituloAzulClaro">La placa se encuentra pagada.</font>
						</div>
					</xsl:if>
					<xsl:if test="SOA_RESULT_PLACA/ENCABEZADO/CODRES = 6">
						<div align="center">
							<font class="tituloAzulClaro">El vehículo sólo se podrá pagar por medio de Pago Temporal.</font>
							<br/>
						</div>
					</xsl:if>
					<xsl:if test="SOA_RESULT_PLACA/ENCABEZADO/CODRES = 7">
						<div align="center">
							<br/>
							<font class="tituloAzulClaro">El vehículo sólo se podrá pagar por medio de Pago sin RTV.</font>
							<font class="tituloAzulClaro">Asegurese de seleccionar una caja con ese tipo de formulario!.</font>
							<br/>
						</div>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="NumeroConsecutivo!= ''">
							<xsl:if test="TipoComprobante=1">
								<input type="hidden" name="Transaccion" value="INSPagoVirtual"/>
							</xsl:if>
							<xsl:if test="TipoComprobante=2">
								<input type="hidden" name="Transaccion" value="INSPagoVirtualSinRTV"/>
							</xsl:if>
							<xsl:if test="TipoComprobante=3">
								<input type="hidden" name="Transaccion" value="INSPagoVirtualTMP"/>
							</xsl:if>
							<input type="hidden" name="TipoComprobante" value="{TipoComprobante}"/>
							<input type="hidden" name="Filtro" value="XML/virtual/INSPagoVirtual.xsl"/>
							<input type="hidden" name="NumeroDocumento" value="{NumeroDocumento}"/>
							<input type="hidden" name="TipoPlaca" value="{SOA_RESULT_PLACA/ENCABEZADO/CLASEPLACA}"/>
							<input type="hidden" name="CodigoGobierno" value="{SOA_RESULT_PLACA/ENCABEZADO/CODGOBIERNO}"/>
							<input type="hidden" name="TotalPago" value="{SOA_RESULT_PLACA/ENCABEZADO/MONTO}"/>
							<input type="hidden" name="INDPOLIZARESCIVIL" value="{INDPOLIZASRESCIVIL}"/>
							<input type="hidden" name="INDPOLIZASV" value="{INDPOLIZASV}"/>
							<input type="hidden" name="INDPOLIZAAC" value="{INDPOLIZAAC}"/>
							<input type="hidden" name="INDCOBERTURA" value="{INDCOBERTURA}"/>
							<input type="hidden" name="INDPROTECCION" value="{INDPROTECCION}"/>
							<input type="hidden" name="Numero" value="{SOA_RESULT_PLACA/ENCABEZADO/NUMPLACA}"/>
							<input type="hidden" name="TipoId" value="{SOA_RESULT_PLACA/ENCABEZADO/TIPOIDERSONAPROPIETARIO}"/>
							<input type="hidden" name="Nombre" value="{SOA_RESULT_PLACA/ENCABEZADO/NOMPERSONAPROPIETARIO}"/>
							<input type="hidden" name="Identificacion" value="{SOA_RESULT_PLACA/ENCABEZADO/CEDPERSONAPROPIETARIO}"/>
							<input type="hidden" name="IP" value="{SOA_RESULT_PLACA/ENCABEZADO/IP}"/>
							<input type="hidden" name="Periodo" value="{SOA_RESULT_PLACA/ENCABEZADO/PERIODO}"/>
							<input type="hidden" name="Efectivo" value="0"/>
							<input type="hidden" name="OtrosValores" value="0"/>
							<input type="hidden" name="DESMARCA" value="{SOA_RESULT_PLACA/ENCABEZADO/DESMARCA}"/>
							<input type="hidden" name="ANOMODELO" value="{SOA_RESULT_PLACA/ENCABEZADO/ANOMODELO}"/>
							<input type="hidden" name="ANOSADEUDADOS" value="{SOA_RESULT_PLACA/ENCABEZADO/ANOSADEUDADOS}"/>
							<input type="hidden" name="CODGRUPO" value="{SOA_RESULT_PLACA/ENCABEZADO/CODGRUPO}"/>
							<input type="hidden" name="FECIVPOLIZA" value="{SOA_RESULT_PLACA/ENCABEZADO/FECIVPOLIZA}"/>
							<input type="hidden" name="FECFVPOLIZA" value="{SOA_RESULT_PLACA/ENCABEZADO/FECFVPOLIZA}"/>
							<input type="hidden" name="DESESTILO" value="{SOA_RESULT_PLACA/ENCABEZADO/DESESTILO}"/>
							<input type="hidden" name="CAPACIDAD" value="{SOA_RESULT_PLACA/ENCABEZADO/CAPACIDAD}"/>
							<input type="hidden" name="NUMCHASIS" value="{SOA_RESULT_PLACA/ENCABEZADO/NUMCHASIS}"/>
							<input type="hidden" name="VALORFISCAL" value="{SOA_RESULT_PLACA/ENCABEZADO/VALORFISCAL}"/>
							<input type="hidden" name="NUMMOTOR" value="{SOA_RESULT_PLACA/ENCABEZADO/NUMMOTOR}"/>
							<input type="hidden" name="NUMCLASE" value="{SOA_RESULT_PLACA/ENCABEZADO/NUMCLASE}"/>
							<input type="hidden" name="CajaVirtual" value="{NumeroCajaVirtual}"/>
							<!-- -->
							<div align="center" class="tituloAzulClaro">Detalle del pago</div>
							<table align="center" class="tabla">
								<tr>
									<td class="etiqueta">Provincia:</td>
									<td class="detalle" colSpan="3">
										<SELECT class="inputAzul" NAME="Provincia"
										        onChange="fillSelectFromArray(this.form.Canton, ((this.selectedIndex == -1) ? null : canton[this.selectedIndex-1])); fillSelectFromArray(this.form.Distrito, ((Canton.selectedIndex == -1) ? null : distrito[this.selectedIndex-1][0]));">
											<OPTION VALUE="-1">--- Seleccione ---</OPTION>
											<OPTION VALUE="1">SAN JOSE</OPTION>
											<OPTION VALUE="2">ALAJUELA</OPTION>
											<OPTION VALUE="3">CARTAGO</OPTION>
											<OPTION VALUE="4">HEREDIA</OPTION>
											<OPTION VALUE="5">GUANACASTE</OPTION>
											<OPTION VALUE="6">PUNTARENAS</OPTION>
											<OPTION VALUE="7">LIMON</OPTION>
										</SELECT>
									</td>
								</tr>
								<tr>
									<td class="etiqueta">Cantón:</td>
									<td class="detalle" colSpan="3">
										<SELECT NAME="Canton" onChange="fillSelectFromArray(this.form.Distrito, ((this.selectedIndex == -1) ? null : distrito[Provincia.selectedIndex-1][this.selectedIndex]));">
											<OPTION>&#xA0; &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; 
          &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;</OPTION>
										</SELECT>
									</td>
								</tr>
								<tr>
									<td class="etiqueta">Distrito:</td>
									<td class="detalle" colSpan="3">
										<SELECT NAME="Distrito">
											<OPTION>&#xA0; &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; 
          &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;</OPTION>
										</SELECT>
									</td>
								</tr>

								<tr>
									<td class="etiqueta">Nombre de la persona que paga el marchamo :</td>
									<td class="detalle" colSpan="3">
										<input name="NombrePagador" size="35" value="{SOA_RESULT_PLACA/ENCABEZADO/NOMPERSONAPROPIETARIO}"/>
									</td>
								</tr>
								<tr>
									<td class="etiqueta">Teléfono :</td>
									<td class="detalle" colSpan="3">
										<input name="TelefonoPagador" maxlength="8" size="8"/>
									</td>
								</tr>
								<tr>
									<td class="etiqueta">Correo Electrónico :</td>
									<td class="detalle" colSpan="3">
										<input name="CORREO" value="" maxlength="50" size="35"/>
									</td>
								</tr>
								<tr>
									<td class="etiqueta">
										<select class="campo" name="TipoIdPagador">
											<xsl:for-each select="TipoIds/TipoId">
												<xsl:if test="Codigo=0">
													<option value="{Codigo}" selected="selected">
														<xsl:value-of select="Descripcion"/>
													</option>
												</xsl:if>
												<xsl:if test="Codigo &gt;0 and PuedePagar=1">
													<option value="{Codigo}">
														<xsl:value-of select="Descripcion"/>
													</option>
												</xsl:if>
											</xsl:for-each>
										</select>
									</td>
									<td class="detalle" colSpan="3">
										<input name="CedulaPagador" maxlength="25" size="25"/>
									</td>
								</tr>
								<tr>
									<td class="etiqueta">Forma de pago :</td>
									<td colspan="3" class="detalle">
										<select class="campo" name="FormaPago">
											<option value="1" selected="true">Efectivo</option>
										</select>
									</td>
								</tr>
								<tr>
									<td class="etiqueta">Total a pagar :</td>
									<td colspan="3" class="detalleTotal">
										<xsl:value-of select="format-number(SOA_RESULT_PLACA/ENCABEZADO/MONTO,'###,###,##0.00')"/>
									</td>
								</tr>
								<tr>
									<td class="etiqueta">Direccion Exacta :</td>
									<td class="detalle" colSpan="3">
										<input name="DireccionExacta" value="" maxlength="90" size="55"/>
									</td>
								</tr>
								<tr>
									<td class="etiqueta">Nombre de Persona Autorizada a Retirar:</td>
									<td class="detalle" colSpan="3">
										<input name="NombreAutorizado" value="" maxlength="90" size="55"/>
									</td>
								</tr>
								<tr>
									<td class="etiqueta">Cedula de Autorizado :</td>
									<td class="detalle" colSpan="3">
										<input name="IDAutorizado" value="" maxlength="25" size="25"/>
									</td>
								</tr>
							</table>
							<br/>
							<xsl:choose>
								<xsl:when test="TipoComprobante=2">
									<xsl:call-template name="BotonesSITE"/>
								</xsl:when>
								<xsl:when test="TipoComprobante=3">
									<xsl:call-template name="BotonesTMP"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="BotonesMarchamo"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="MostrarMensaje">
								<xsl:with-param name="Mensaje">
									<xsl:value-of select="Respuesta"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="SOA_RESULT_PLACA/ENCABEZADO/CODRES = 8">
					<xsl:call-template name="MostrarMensaje">
						<xsl:with-param name="Mensaje">El vehículo no tiene revisión técnica.</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="MostrarMensaje">
						<xsl:with-param name="Mensaje">La placa tiene algún tipo de problema y NO se podrá pagar.</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</form>
	</xsl:template>
	<xsl:template name="BotonesMarchamo">
		<div align="center">
			<input name="BotonPagar" class="button_red" type="button" value="      Pagar      " onclick="ValidarMarchamo()"/>
			<input name="OtraConsulta" class="button_gris" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaClasePlaca&amp;Filtro=~/XML/virtual/INSConsultarVirtual.xsl','Transaccion')"/>
		</div>
	</xsl:template>
	<xsl:template name="BotonesConfirmar">
		<div align="center">
			<xsl:if test="SOA_RESULT_PLACA/ENCABEZADO/CODRES=0">
				<input name="Consultar" class="button_red" type="button" value="Confirmar" onclick="if (document.forms[0].NUMEROCAJAVIRTUAL.value == '') alert('Seleccione la Sucursal de Entrega. Por Favor!'); else submit();"/>
			</xsl:if>
			<input name="OtraConsulta" class="button_gris" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaClasePlaca&amp;Filtro=~/XML/virtual/INSConsultarVirtual.xsl','Transaccion')"/>
		</div>
	</xsl:template>
	<xsl:template name="BotonesSITE">
		<div align="center">
			<input name="BotonPagar" type="button" value="   Pagar SIN RTV  " onclick="ValidarMarchamo()"/>
			<input name="OtraConsulta" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaClasePlaca&amp;Filtro=~/XML/virtual/INSConsultarVirtual.xsl','Transaccion')"/>
		</div>
	</xsl:template>
	<xsl:template name="BotonesTMP">
		<div align="center">
			<input name="BotonPagar" type="button" value="   Pagar Temporal  " onclick="ValidarMarchamo()"/>
			<input name="OtraConsulta" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaClasePlaca&amp;Filtro=~/XML/virtual/INSConsultarVirtual.xsl','Transaccion')"/>
		</div>
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
			<input name="OtraConsulta" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaClasePlaca&amp;Filtro=~/XML/virtual/INSConsultarVirtual.xsl','Transaccion')"/>
		</div>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="file:///c:/Documents and Settings/Administrator/Desktop/INSConsultaOutput.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
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