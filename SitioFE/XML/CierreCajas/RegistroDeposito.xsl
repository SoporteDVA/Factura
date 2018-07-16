<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Registro de Depósitos</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"></script>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
			</head>
			<body>
				<p>&#xA0;</p>
				<p align="center">
					<table class="Tabla" border="0">
						<thead>
							<th>
								<tr>
									<td>buenas</td>
								</tr>
							</th>
						</thead>
						<tbody>
							<tr>
								<td>Banco:</td>
								<td>
									<select name="Banco" onchange="this.NumeroCuenta.selectedIndex=this.Banco.selectedIndex;">
										<option value="1">BCAC - Banco Credito Agricola</option>
										<option value="2" selected="selected">BCR  - Banco de Costa Rica</option>
										<option value="3">BNCR - Banco Nacional de Costa Rica</option>
										<option value="4">BPDC - Banco Popular</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>Número de Cuenta</td>
								<td>
									<select name="NumeroCuenta">
										<option>3480324</option>
										<option selected="selected">1604520</option>
										<option>1602564</option>
										<option>8410109761</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</p>
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
	<xsl:template name="Botones">
		<table align="center" border="0" style="; width: 438px; height: 30px">
			<tbody>
				<tr>
					<td width="50%">
						<p align="left">
							<button onclick="AgregarTalonario()">
								<div align="center">
									<strong>Agregar</strong>
								</div>
							</button>
						</p>
					</td>
					<td/>
					<td/>
					<td/>
					<td/>
				</tr>
			</tbody>
		</table>
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
					<td rowspan="2">
						<p align="center">
							<strong>Descripción</strong>
						</p>
					</td>
					<td rowspan="2" align="center">
						<strong>Fecha</strong>
						<p/>
						<strong>Recaudación</strong>
					</td>
					<td rowspan="2" align="center">
						<strong>Estado</strong>
					</td>
					<td rowspan="2" align="center">
						<strong>Recaudado</strong>
					</td>
					<td rowspan="2" align="center">
						<strong>Comisión</strong>
					</td>
					<td align="center" colspan="7">
						<strong>Pagos</strong>
					</td>
					<td align="center" colspan="3">
						<strong>Acciones</strong>
					</td>
				</tr>
				<tr class="encabezado">
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
						<img hspace="0" src="imagenes/vwicn038.gif" align="baseline" border="0" alt="Con Problemas"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/vwicn039.gif" align="baseline" border="0" alt="Pendientes"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/vwicn132.gif" align="baseline" border="0" alt="Sin Imprimir"/>
					</td>
					<td align="center">
						<img hspace="0" src="imagenes/vwicn071.gif" align="baseline" border="0" alt="Sin Conciliar"/>
					</td>
					<td align="center">
						<strong>Recalcular</strong>
					</td>
					<xsl:if test="EstadoCaja&gt;3">
						<td align="center">
							<strong>Recalcular INS</strong>
						</td>
					</xsl:if>
					<td align="center">
						<strong>Siguiente</strong>
					</td>
				</tr>
				<xsl:for-each select="Cierres/Fila">
					<tr class="detalle">
						<td>
							<p align="center">
								<xsl:value-of select="NumeroCaja"/>
							</p>
						</td>
						<td>
							<p align="center">
								<xsl:value-of select="NombreCaja"/>
							</p>
						</td>
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
									<xsl:value-of select="SinConciliar"/>
								</xsl:if>
							</p>
						</td>
						<td>
							<p align="center">
								<xsl:if test="CodigoEstado&lt;7">
									<img hspace="0" src="imagenes/vwicn033.gif" align="baseline" border="0"
									     onclick="cargar(this,'Transaccion.aspx?Transaccion=GeneraCierreCaja&amp;NumeroCaja={NumeroCaja}&amp;Fecha={FechaCaja}&amp;Accion=Todas&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/CierreCajas/ConsultaCierreCajas.xsl','Transaccion')"
									     alt="Recalcular"/>
								</xsl:if>
								<xsl:if test="CodigoEstado&gt;6">
									<img hspace="0" src="imagenes/vwicn165.gif" align="baseline" border="0" alt="Caja Cerrada"/>
								</xsl:if>
							</p>
						</td>
						<xsl:if test="EstadoCaja&gt;3">
							<td>
								<p align="center">
									<xsl:if test="CodigoEstado&lt;8">
										<img hspace="0" src="imagenes/vwicn033.gif" align="baseline" border="0"
										     onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaPrevia&amp;NumeroCaja={NumeroCaja}&amp;FechaCaja={FechaCaja}&amp;Accion=Todas&amp;Estado=1&amp;CajaRecaudador={CajaRecaudador}&amp;UsuarioINS={UsuarioINS}&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/CierreCajas/ConsultaCierreCajas.xsl','Transaccion')"
										     alt="Recalcular INS"/>
									</xsl:if>
									<xsl:if test="CodigoEstado&gt;7">
										<img hspace="0" src="imagenes/vwicn165.gif" align="baseline" border="0" alt="Caja Cerrada"/>
									</xsl:if>
								</p>
							</td>
						</xsl:if>
						<td>
							<xsl:choose>
								<xsl:when test="CodigoEstado=3">
									<img hspace="0" src="imagenes/vwicn121.gif" align="baseline" border="0"
									     onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaPrevia&amp;NumeroCaja={NumeroCaja}&amp;FechaCaja={FechaCaja}&amp;Accion=Todas&amp;Estado=1&amp;CajaRecaudador={CajaRecaudador}&amp;UsuarioINS={UsuarioINS}&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/CierreCajas/ConsultaCierreCajas.xsl','Transaccion')"
									     alt="Consulta Previa INS"/>
								</xsl:when>
								<xsl:when test="CodigoEstado=4">
									<img hspace="0" src="imagenes/vwicn071.gif" align="baseline" border="0"
									     onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaPrevia&amp;NumeroCaja={NumeroCaja}&amp;FechaCaja={FechaCaja}&amp;Accion=Todas&amp;Estado=1&amp;CajaRecaudador={CajaRecaudador}&amp;UsuarioINS={UsuarioINS}&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/CierreCajas/ConsultaCierreCajas.xsl','Transaccion')"
									     alt="Conciliar INS"/>
								</xsl:when>
								<xsl:when test="CodigoEstado&gt;4 and CodigoEstado&lt;7 and SinConciliar=0">
									<img hspace="0" src="imagenes/vwicn123.gif" align="baseline" border="0"
									     onclick="cargar(this,'Transaccion.aspx?Transaccion=CierreCaja&amp;NumeroCaja={NumeroCaja}&amp;FechaCaja={FechaCaja}&amp;Accion=Todas&amp;Estado=1&amp;CajaRecaudador={CajaRecaudador}&amp;UsuarioINS={UsuarioINS}&amp;ServidorSTX=infoware.STX.Gestion&amp;Filtro=XML/CierreCajas/ConsultaCierreCajas.xsl','Transaccion')"
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
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ConsultaCierreCajasDetallado.xml" htmlbaseurl="" outputurl="" processortype="internal" useresolver="yes" profilemode="4" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator=""/></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no" ><SourceSchema srcSchemaPath="file:///c:/Proyectos/STX&#x2D;NET/DVANew/xml/BitacoraCJResumen.xml" srcSchemaRoot="BitacoraCJResumen" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/></MapperInfo><MapperBlockPosition><template match="/"><block path="html/body/xsl:if/=[0]" x="46" y="62"/><block path="html/body/xsl:if" x="92" y="64"/><block path="html/body/xsl:if/table/tbody/xsl:for&#x2D;each" x="52" y="64"/><block path="html/body/xsl:if/table/tbody/tr[1]/td[2]/p/strong/xsl:value&#x2D;of" x="12" y="64"/><block path="html/body/xsl:if/table/tbody/tr[1]/td[3]/p/strong/xsl:value&#x2D;of" x="92" y="24"/><block path="html/body/xsl:if[1]/=[0]" x="86" y="62"/><block path="html/body/xsl:if[1]" x="132" y="64"/></template></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->