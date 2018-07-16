<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Cargos Automaticos</title>
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
				<script type="text/javascript" language="javascript" src="TableFilter/tablefilter.js"></script>
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
				<xsl:when test="Consulta_BitacoraCAOutput">
					<xsl:for-each select="Consulta_BitacoraCAOutput">
						<xsl:call-template name="DetalleAfiliados"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="EstadosOutput">
					<xsl:for-each select="EstadosOutput/Resultado">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="Consulta_BitacoraCAFault">
					<xsl:for-each select="Consulta_BitacoraCAFault">
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
		<form action="Transaccion.aspx" method="post" target="_blank">
			<input type="hidden" name="Transaccion" value="Consulta_BitacoraCA"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="Filtro" value="XML/WEBConsultas/ParametrosNGListaProcesosCA.xsl"/>
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
						<font class="tituloAzulClaro">Bitacora de Procesos Cargos Automáticos (Rango de Fechas y Ente)</font>
						<font class="tituloAzulClaro"></font>
					</td>
				</tr>
			</table>
			<br/>
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
					<td class="etiqueta">Seleccione el Tipo de Cuenta :</td>
					<td colSpan="3" class="detalle">
						<select class="campo" name="TipoCuenta">
							<option value="A">--TODOS LOS TIPOS--</option>
							<option value="T">TARJETA DE CREDITO</option>
							<option value="C">CUENTA BANCARIA</option>
						</select>
					</td>
				</tr>
			</table>
			<br/>
			<table class="tabla" align="center">
				<tr>
					<td class="etiqueta">Ente (Opcional) :</td>
					<td colSpan="3">
						<input size="30" name="Ente" maxlength="10" class="campo"/>
					</td>
				</tr>
			</table>
			<br/>
			<p>
				<div align="center">
					<input name="Reporte" class="button_red" type="button" value="Consultar" onclick="if (document.forms[0].FechaInicial.value == '') alert('Debe definir una Fecha'); else submit();"/>
				</div>
			</p>
		</form>
	</xsl:template>
	<xsl:template name="DetalleAfiliados">
		<div align="center">
			<table align="center">
				<tr>
					<td width="30%">
						<p align="center">
							<img align="baseline" src="imagenes/DVAEnc.JPG"/>
						</p>
					</td>
					<td>
						<fONT class="tituloAzulClaro">CONSULTA DETALLADA CARGOS AUTOMATICOS</fONT>
						<fONT class="tituloAzulClaro">POR SERVICIO</fONT>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<xsl:for-each select="Resultado">
			<div width="100%" align="left">
				<!--<form action="Transaccion.aspx">
				
					<input type="hidden" name="Transaccion" value="Estados"/>
					<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGAfiliadosXFechaServicio.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
					<input name="BotonCerrar" class="button" type="submit" value="  «« Realizar Otra Consulta   "/>
				</form>-->
				<br/>
				<input type="button" value="SALIR" class="button_gris" onclick="self.close()"/>
				<br/>
				<br/>
				<table class="tabla">

					<thead>
						<tr class="encabezado">
							<th>Monto Total Procesado</th>
							<th>Monto Cobrado</th>
							<th>Monto Reversado</th>
							<th>Monto No Cobrado</th>
							<th>Cantidad Pagos</th>
						</tr>
					</thead>
					<tbody>
						<td class="tablaSinImprimir" align="right">¢<xsl:value-of select="format-number(sum(Fila/Monto),'###,###,###,##0.00')"/></td>
						<td class="tablaSinImprimir" align="right">¢<xsl:value-of select="format-number(sum(Fila/MontoCobrado),'###,###,###,##0.00')"/></td>
						<td class="tablaSinImprimir" align="right">¢<xsl:value-of select="format-number(sum(Fila/MontoReversado),'###,###,###,##0.00')"/></td>
						<td class="tablaSinImprimir" align="right">¢<xsl:value-of select="format-number(sum(Fila/MontoNOCobrado),'###,###,###,##0.00')"/></td>

						<td class="tablaSinImprimir" align="center">
							<xsl:value-of select="format-number(count(Fila/IDProceso),'#')"/>
						</td>
					</tbody>
				</table>
				<!--<br/>
				<input class="button" type="button" onclick="tableToExcel('{Fila/Oficina}', '{Fila/Oficina}')" value="Exportar a Excel"/>-->
			</div>
			<br/>
			<table class="tabla">
				<tr>
					<td align="center" colspan="2">
						<strong>SIGNIFICADO VISUAL DEL DETALLE</strong>
					</td>
				</tr>

				<tr class="detalle">
					<td>Cobrados y Pagados</td>
					<td class="detalle" align="center">--■--</td>
				</tr>

				<tr class="tablaPendiente">
					<td>Cobrados y Reversados</td>
					<td class="tablaPendiente" align="center">--■--</td>
				</tr>

				<tr class="tablaResaltado">
					<td>No Cobrados</td>
					<td class="tablaResaltado" align="center">--■--</td>
				</tr>
			</table>

			<br/>
			<table id="table1" cellspacing="0" class="mytable filterable" alignt="left">
				<thead>
					<tr class="etiqueta">
						<th align="center">Proceso</th>
						<th>Fecha</th>
						<th>Servicio</th>
						<th>Convenio</th>
						<th>Tipo Llave</th>
						<th>Llave</th>
						<th>Ente</th>
						<th>Cuenta Afectada</th>
						<th>Monto</th>
						<th>Moneda</th>
						<th>Descripcion</th>
						<th>Referencia</th>
						<th>Secuencial</th>
						<th>Tipo Cuenta</th>
						<th>Cuenta Primaria</th>
						<th>Cuenta Secundaria</th>
						<th>Fecha Vence</th>
						<th>Rango Dias</th>
						<th>Estado Cobro</th>
						<th>Respuesta Cobro</th>
						<th>Estado Pago</th>
						<th>Respuesta Pago</th>
						<th>Estado Reversion</th>
						<th>Respuesta Reversion</th>
					</tr>
				</thead>
				<tbody>

					<xsl:for-each select="Fila">
						<tr>
							<!--Escoge el formato de la fila, si es reversión, se pone en rojo   -->
							<xsl:choose>
								<!--NO Cobrados-->
								<xsl:when test="EstadoCobro!=0">
									<xsl:attribute name="class">tablaResaltado</xsl:attribute>
								</xsl:when>
								<!--<xsl:when test="EstadoCobro=0 and EstadoPago=0 and EstadoReversion=100">
									<xsl:attribute name="class">tablaConError</xsl:attribute>
								</xsl:when>-->
								<!--Cobrados y Reversados-->
								<xsl:when test="EstadoCobro=0 and EstadoReversion=0">
									<xsl:attribute name="class">tablaPendiente</xsl:attribute>
								</xsl:when>
								<!--<xsl:when test="EstadoCobro=0 and EstadoPago=0 and EstadoReversion=100">
									<xsl:attribute name="class">tablaResaltado</xsl:attribute>
								</xsl:when>-->
								<!--cobrados y pagados correctamente-->
								<xsl:when test="EstadoCobro=0 and EstadoPago=0 and EstadoReversion=100">
									<xsl:attribute name="class">detalle</xsl:attribute>
								</xsl:when>
								<!--cobrados y pagados correctamente-->
								<!--<xsl:when test="EstadoCobro=0 and EstadoPago=0 and EstadoReversion=100">
									<xsl:attribute name="class">tablaSinImprimir</xsl:attribute>
								</xsl:when>-->
								<xsl:otherwise>
									<xsl:attribute name="class">tablaSinImprimir</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
							<td align="center">
								<xsl:value-of select="IDProceso"/>
							</td>
							<!--<td align="left">
								<xsl:choose>
									<xsl:when test="string-length((substring-after(Usuario,'\')))=0">
										<xsl:choose>
											<xsl:when test="Usuario ='banex'">Sitio WEB</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="Ente"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="Usuario ='banex'">Sitio WEB</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="substring-after(Usuario,'\')"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</td>-->
							<td align="justify">
								<xsl:value-of select="Fecha"/>
							</td>
							<td align="left">
								<xsl:value-of select="Colector"/>-<xsl:value-of select="NombreColector"/></td>
							<td align="center">
								<xsl:value-of select="Convenio"/>
							</td>
							<!--<td align="justify">
								<xsl:value-of select="TipoServicio"/>
							</td>-->
							<td align="center">
								<xsl:value-of select="TipoLlave"/>
							</td>
							<!--<td align="right">
								<xsl:choose>
									<xsl:when test="Estado='PE'">0</xsl:when>
									<xsl:when test="Estado='RV'">
										<xsl:value-of select="format-number(TotalPago*-1,'###,###,###,##0.00')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>-->
							<!--<td align="right">
								<xsl:choose>
									<xsl:when test="Estado='PE'">0</xsl:when>
									<xsl:when test="Estado='RV'">
										<xsl:value-of select="format-number(Comision*-1,'###,###,###,##0.00')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="format-number(Comision,'###,###,###,##0.00')"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>-->
							<td align="center">
								<xsl:value-of select="NumeroIdentificador"/>
							</td>
							<td align="center">
								<xsl:value-of select="Ente"/>
							</td>
							<td align="center">
								<xsl:value-of select="CuentaAfectada"/>
							</td>
							<td align="center">
								<xsl:value-of select="Monto"/>
							</td>
							<!--<td align="center">
								<xsl:choose>
									<xsl:when test="Estado='PG'">
										<p align="center">
											<a>
												<xsl:attribute name="href">Transaccion.aspx?Transaccion=xp_BitacoraCJPago&amp;Colector=<xsl:value-of select="Servicio"/>&amp;Convenio=<xsl:value-of select="Convenio"/>&amp;Numero=<xsl:value-of select="Numero"/>&amp;Documento=<xsl:value-of select="NumeroDocumento"/>&amp;FechaConsulta=<xsl:value-of select="Fecha"/>&amp;TipoEmision=Duplicado&amp;ServidorSTX=infoware.STX.Cajas&amp;Filtro=XML/WEBImpresion/WEBImpresion.xsl</xsl:attribute>
												<img hspace="1" src="imagenes/vwicn032.gif" align="center" border="0" alt="Impresion"/>
											</a>
										</p>
									</xsl:when>
									<xsl:otherwise>''</xsl:otherwise>
								</xsl:choose>
							</td>-->
							<td align="justify">
								<xsl:value-of select="Moneda"/>
							</td>
							<td align="justify">
								<xsl:value-of select="Descripcion"/>
							</td>
							<td align="justify">
								<xsl:value-of select="Referencia"/>
							</td>
							<td align="justify">
								<xsl:value-of select="Secuencial"/>
							</td>
							<td align="justify">
								<xsl:value-of select="TipoCuenta"/>
							</td>
							<td align="justify">
								<xsl:value-of select="Cuenta1"/>
							</td>
							<td align="justify">
								<xsl:value-of select="Cuenta2"/>
							</td>
							<td align="justify">
								<xsl:value-of select="FechaVence"/>
							</td>
							<td align="center">
								<xsl:value-of select="TiempoVencimiento"/>
							</td>

							<td align="center">
								<xsl:value-of select="EstadoCobro"/>
							</td>
							<td align="Left">
								<xsl:value-of select="RespuestaCobro"/>
							</td>
							<td align="center">
								<xsl:value-of select="EstadoPago"/>
							</td>
							<td align="left">
								<xsl:value-of select="RespuestaPagoServicio"/>
							</td>
							<td align="center">
								<xsl:value-of select="EstadoReversion"/>
							</td>
							<td align="left">
								<xsl:value-of select="RespuestaReversion"/>
							</td>
						</tr>
					</xsl:for-each>
					<!--<tr>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta">Total
							<strong><![CDATA[ ]]></strong>
						</td>
						<td class="etiqueta" align="right">
							<xsl:value-of select="format-number(sum(Fila/MontoCobrado),'###,###,###,##0.00')"/>
						</td>
						<td class="etiqueta" align="right">

							<xsl:value-of select="format-number(sum(Fila/MontoReversado),'###,###,###,##0.00')"/>
						</td>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
						<td class="etiqueta"/>
					</tr>-->
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
					<td colSpan="3" class="detalle">
						<xsl:value-of select="Mensaje"/>
					</td>
				</tr>
			</table>
			<br/>
			<br/>
		</div>


		<div align="center">

			<br/>
			<input type="button" value="SALIR" class="button_gris" onclick="self.close()"/>
			<br/>
			<!--<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="Estados"/>
				<input type="hidden" name="Filtro" value="~/XML/WEBConsultas/ParametrosNGListaProcesosCA.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="   Volver   "/>
			</form>-->
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