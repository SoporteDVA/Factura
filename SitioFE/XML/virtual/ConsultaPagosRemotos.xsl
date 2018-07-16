<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Consulta de Pagos x Tipo</title>


				<link
                              rel = "stylesheet"
                              href = "jquery.ui.all.css"
                              type = "text/css"/>
                        <link
                              rel = "stylesheet"
                              href = "jquery-ui.css"
                              type = "text/css"/>
                        <link
                              rel = "stylesheet"
                              href = "STEstilos.css"
                              type = "text/css"/>
                        <link
                              rel = "stylesheet"
                              href = "jquery.ui.datepicker"
                              type = "text/css"/>
                        <script
                              type = "text/javascript"
                              src = "jquery-1.11.0.min.js">
							  
                        </script>
						  <script
                              type = "text/javascript"
                              src = "excel.js">
							  
                        </script>						
                        <script src = "jquery.min.js"></script>
                        <script src = "jquery-ui.min.js"></script>
                        <style>
                              body{
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
                              }
                        </style>
                        <script>
                              $(function() {
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
                              });
                        </script>
			</head>
			<xsl:choose>
				<xsl:when test="ConsultaPagosRemotosxFechaOutput">
					<xsl:for-each select="ConsultaPagosRemotosxFechaOutput">
						<xsl:call-template name="PagosBIT"/>
					</xsl:for-each>
				</xsl:when>

				<xsl:otherwise>
					<center>
						<xsl:call-template name="Consulta"/>
					</center>
				</xsl:otherwise>
			</xsl:choose>
			<body>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="Consulta">
		<form action="Transaccion.aspx" method="post">
			<input name="Transaccion" type="hidden" value="ConsultaPagosRemotosxFecha"/>
			<input name="Filtro" type="hidden" value="XML/virtual/ConsultaPagosRemotos.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
			<br/>
			<table align="center" width="500" border="0">
				<tr>
					
					<td width="50%" align="center">
						<font class="tituloAzulClaro">Consulta Pagos Remotos</font>
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
					<td class="etiqueta">Seleccione el Tipo Envio :</td>
					<td colSpan="3">
						<SELECT class="inputAzul" NAME="TipoEnvio">
							<OPTION VALUE="1" selected="selected">Entrega Personal en Sucursal</OPTION>
							<OPTION VALUE="2">Domicilio Call Center</OPTION>
							<OPTION VALUE="0">Domicilio Sucursal Electronica</OPTION>
						</SELECT>
					</td>
				</tr>
			</table>
			<br/>
			 <p>
                        <div align = "center">
                              <input
                                    name = "Reporte"
                                    class = "button_red"
                                    type = "button"
                                    value = "Consultar"
                                    onclick = "if (document.forms[0].FechaInicial.value == '') alert('Debe definir una Fecha Fecha Inicial'); else submit();"/>
                        </div>
                  </p>

			<!--<p>
				<div align="center">
					<input name="Reporte" class="button_gris" type="button" value="Consultar" onclick="sendForm();"/>
				</div>
			</p>-->
		</form>
	</xsl:template>
	<xsl:template name="Pagos">

		<br/>

		<div id="container">

			<table class="tabla" align="center" cellpadding="0" cellspacing="0" border="0" id="pagosremotos">


				<tbody>
					<tr>
						<!--<th>Oficina</th>-->
						<td class="etiqueta">Usuario</td>
						<td class="etiqueta">NumeroDocumento</td>
						<!--<td class="etiqueta">DiaPago</td>-->
						<td class="etiqueta">TotalPago</td>
						<td class="etiqueta">Comision</td>
						<td class="etiqueta">Fecha</td>
						<td class="etiqueta">Numero de Placa</td>
						<!--<td class="etiqueta">Estado</td>-->
						<td class="etiqueta">NumeroRecibo</td>
						<td class="etiqueta">Nombre</td>
						<!--<td class="etiqueta">Periodo</td>-->
						<td class="etiqueta">CedulaPagador</td>
						<td class="etiqueta">Correo</td>
						<td class="etiqueta">Telefono</td>
						<td class="etiqueta">Direccion</td>
						<td class="etiqueta">CedulaAutorizado</td>
						<td class="etiqueta">NombreAutorizado</td>
						<td class="etiqueta">OrigenPago</td>
					</tr>
					<xsl:for-each select="Fila">
						<tr>

							<td align="center" class="detalle">
								<xsl:value-of select="Usuario"/>
							</td>
							<td align="center" class="detallenumerico">
								<xsl:value-of select="NumeroDocumento"/>
							</td>

							<td align="right" class="detallenumerico">
								<xsl:choose>
									<xsl:when test="Moneda = '1'">¢</xsl:when>
									<xsl:otherwise>¢</xsl:otherwise>
								</xsl:choose>
								<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
							</td>
							<td class="detallenumerico" align="right">
								<xsl:choose>
									<xsl:when test="Moneda = '1'">¢</xsl:when>
									<xsl:otherwise>¢</xsl:otherwise>
								</xsl:choose>
								<xsl:value-of select="format-number(Comision,'###,###,###,##0.00')"/>
							</td>
							<td class="detallenumerico">
								<xsl:value-of select="FechaHora"/>
							</td>
							<td class="detallenumerico" align="left">
								<xsl:value-of select="Placa"/>
							</td>
							<!--<td>
								<xsl:value-of select="Estado"/>
							</td>-->
							<td class="detallenumerico">
								<xsl:value-of select="NumeroRecibo"/>
							</td>
							<td class="detallenumerico">
								<xsl:value-of select="Nombre"/>
							</td>
							<!--<td>
								<xsl:value-of select="Periodo"/>
							</td>-->
							<td class="detallenumerico">
								<xsl:value-of select="CedulaPagador"/>
							</td>
							<td class="detallenumerico">
								<xsl:value-of select="Correo"/>
							</td>
							<td class="detallenumerico">
								<xsl:value-of select="Telefono"/>
							</td>
							<td class="detallenumerico">
								<xsl:value-of select="Direccion"/>
							</td>
							<td class="detallenumerico">
								<xsl:value-of select="CedulaAutorizado"/>
							</td>
							<td class="detallenumerico">
								<xsl:value-of select="NombreAutorizado"/>
							</td>
							<td class="detallenumerico">
								<xsl:value-of select="OrigenPago"/>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</div>
	</xsl:template>
	<xsl:template name="PagosBIT">
		<!--<div align="center">
			<font class="tituloAzulClaro">Detalle de transacciones Remotas</font>
		</div>-->
		<br/>
		<div align="left">
			<input class="button" type="button" onclick="tableToExcel('testTable', 'Tabla')" value="Exportar a Excel"/>
		</div>
		<br/>
		<table id="testTable" class="tabla" align="center" width="2500">
			<tbody>
				<tr class="etiqueta">
					<td>Usuario</td>
					<td>Nombre del Pagador</td>
					<td>Nombre del Autorizado</td>
					<td>Cedula Autorizado</td>
					<td>Telefono</td>
					<td>Email</td>
					<td>Fecha</td>
					<td>Hora</td>
					<td>Tipo de Placa</td>
					<td>Placa</td>
					<td>Propietario</td>
					<td>Tipo</td>
					<td>#Autorizacion</td>
					<td>SuVida</td>
					<td>Estado</td>
					<td>#Provincia</td>
					<td>Provincia</td>
					<td>Canton</td>
					<td>Distrito</td>
					<td>Direccion</td>
					<!--<td>Area</td>-->
					<td>#Oficina</td>
					<td>Origen</td>
					<td>Total</td>
				</tr>


				<xsl:for-each select="Pagos/Fila">
					<tr>
						<!-- Escoge el formato de la fila, si es reversión, se pone en rojo   -->
						<xsl:choose>
							<xsl:when test="Estado='PG'">
								<xsl:attribute name="class">tablaResaltado</xsl:attribute>
							</xsl:when>
							<xsl:when test="Estado='PG' or Estado='PE' or Estado='SVE'">
								<xsl:attribute name="class">tablaConError</xsl:attribute>
							</xsl:when>
							<xsl:when test="Estado='PP' or Estado='DP'">
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
							<xsl:value-of select="substring-after(Usuario,'\')"/>
						</td>
						<td>
							<xsl:value-of select="Nombre"/>
						</td>
						<td>
							<xsl:value-of select="NombreAutorizado"/>
						</td>
						<td align="left">
							<xsl:value-of select="CedulaAutorizado"/>
						</td>
						<td>
							<xsl:value-of select="Telefono"/>
						</td>
						<td>
							<xsl:value-of select="Correo"/>
						</td>
						<td>
							<xsl:value-of select="Fecha"/>
						</td>
						<td>
							<xsl:value-of select="Hora"/>
						</td>
						<td>
							<xsl:value-of select="TipoPlaca"/>
						</td>
						<td>
							<xsl:value-of select="Placa"/>
						</td>
						<td>
							<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
						</td>
						<td>
							<xsl:value-of select="Tipo"/>
						</td>
						<td>
							<xsl:value-of select="NumeroRecibo"/>
						</td>
						<td>
							<xsl:value-of select="SUVIDA"/>
						</td>
						<td>
							<xsl:value-of select="Estado"/>
						</td>
						<td>
							<xsl:choose>
								<xsl:when test="TipoEnvio=0">
									<xsl:value-of select="IdProvinciaEnvio"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="TramaXML/Pago/SOA_CONFIRM_PAGO/ENCABEZADO/PROVINCIAPAGADOR"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
						<td>
							<xsl:value-of select="NombreProvincia"/>
						</td>
						<td>
							<xsl:value-of select="NombreCanton"/>
						</td>
						<td>
							<xsl:value-of select="NombreDistrito"/>
						</td>
						<td align="justify">
							<xsl:value-of select="Direccion"/>
						</td>
						<td>
							<xsl:value-of select="Oficina"/>
						</td>
						<td align="justify">
							<xsl:value-of select="OrigenPago"/>
						</td>
						<td>
							<xsl:value-of select="format-number(TotalPago,'###,###,###,##0')"/>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\Compartida\PASEAPRODUCCIONMARCHAMOS\Marchamos\XML\CierreMasivoCajas\ConsultaCierreCajasDetallado.xml"
		          htmlbaseurl="..\..\..\Compartida\PASEAPRODUCCIONMARCHAMOS\Marchamos\XML\CierreMasivoCajas\192.168.1.9" outputurl="" processortype="saxon8" useresolver="yes" profilemode="4" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
			<SourceSchema srcSchemaPath="..\..\..\Compartida\PASEAPRODUCCIONMARCHAMOS\Proyectos\STX-NET\DVANew\xml\BitacoraCJResumen.xml" srcSchemaRoot="BitacoraCJResumen" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
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