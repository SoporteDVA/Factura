<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:NonHtml="http://www.progress.com/StylusStudio/NonHtml" exclude-result-prefixes="NonHtml">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"></script>
				<script src="codigo/dist_geo.js" language="javascript" type="text/javascript"></script>
				<script>function goBack (){
					window.history.back()
					}</script>
				<script type="text/javascript"><![CDATA[ 
				function validarForm(formulario) {
				if(formulario.NUMPLACA1.value.length==0) { //comprueba que no esté vacío
				formulario.NUMPLACA1.focus();   
				alert('Debe digitar las placas a partir del primer campo'); 
				return false; //devolvemos el foco
				}
				if(formulario.CLASEPLACA1.value+formulario.NUMPLACA1.value == formulario.CLASEPLACA2.value+formulario.NUMPLACA2.value 
				|| formulario.CLASEPLACA1.value+formulario.NUMPLACA1.value == formulario.CLASEPLACA3.value+formulario.NUMPLACA3.value
				|| formulario.CLASEPLACA1.value+formulario.NUMPLACA1.value == formulario.CLASEPLACA4.value+formulario.NUMPLACA4.value
				|| formulario.CLASEPLACA1.value+formulario.NUMPLACA1.value == formulario.CLASEPLACA5.value+formulario.NUMPLACA5.value 
				|| formulario.NUMPLACA2.value.length>0  && formulario.CLASEPLACA2.value+formulario.NUMPLACA2.value == formulario.CLASEPLACA3.value+formulario.NUMPLACA3.value				
				|| formulario.NUMPLACA2.value.length>0  && formulario.CLASEPLACA2.value+formulario.NUMPLACA2.value == formulario.CLASEPLACA4.value+formulario.NUMPLACA4.value
				|| formulario.NUMPLACA2.value.length>0  && formulario.CLASEPLACA2.value+formulario.NUMPLACA2.value == formulario.CLASEPLACA5.value+formulario.NUMPLACA5.value								
				|| formulario.NUMPLACA3.value.length>0  && formulario.CLASEPLACA3.value+formulario.NUMPLACA3.value == formulario.CLASEPLACA4.value+formulario.NUMPLACA4.value								
				|| formulario.NUMPLACA3.value.length>0  && formulario.CLASEPLACA3.value+formulario.NUMPLACA3.value == formulario.CLASEPLACA5.value+formulario.NUMPLACA5.value								
				|| formulario.NUMPLACA4.value.length>0  && formulario.CLASEPLACA4.value+formulario.NUMPLACA4.value == formulario.CLASEPLACA5.value+formulario.NUMPLACA5.value								
				) { //comprueba que no esté vacío
				formulario.NUMPLACA1.focus();   
				alert('Hay alguna placa repetida por favor validar!'); 
				return false; //devolvemos el foco
				}				
				
				return true;
				}
				]]>
				</script>
			</head>
			<xsl:choose>
				<xsl:when test="ConsultaClasePlacaOutput">
					<xsl:for-each select="ConsultaClasePlacaOutput">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConsultaClasePlacaSiteOutput">
					<xsl:for-each select="ConsultaClasePlacaSiteOutput">
						<xsl:call-template name="Consulta"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConsultarMultiplesPlacasOutput">
					<xsl:for-each select="ConsultarMultiplesPlacasOutput">
						<xsl:call-template name="FormularioPago"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="INSPagoMasicoOutput">
					<xsl:for-each select="INSPagoMasicoOutput">
						<xsl:call-template name="ResultadosPagos"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="ConsultarMultiplesPlacasFault">

					<div align="center">
						<br/>
						<font class="tituloAzulClaro">
							<xsl:value-of select="ConsultarMultiplesPlacasFault/Mensaje"/>
						</font>
						<br/>
						<br/>
					</div>
					<div align="center">
						<button onclick="goBack()" class="button_gris">Atras</button>
					</div>
				</xsl:when>
				<xsl:otherwise>
					<div align="center">
						<br/>
						<font class="tituloAzulClaro">
							<xsl:value-of select="ConsultaClasePlacaFault/Respuesta"/>
						</font>
						<br/>
						<br/>
					</div>
				</xsl:otherwise>
			</xsl:choose>
			<body></body>
		</html>
	</xsl:template>

	<xsl:template name="Consulta">
		<body onload="document.forms[0].NUMPLACA1.focus();">
			<table align="center" width="500" border="0">
				<tr>
					<td width="50%">
						<p align="center">
							<img align="baseline" src="imagenes/pmarchamo.PNG" border="0" hspace="0" height="100" width="100"/>
						</p>
					</td>
					<td width="50%">
						<font class="tituloAzulClaro">Consulta Múltiple de Marchamos</font>
					</td>
				</tr>
			</table>
			<form action="Transaccion.aspx" method="post" onsubmit="return validarForm(this);">
				<input type="hidden" name="Transaccion" value="ConsultarMultiplesPlacas"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.CajasMasivo"/>
				<input type="hidden" name="Filtro" value="XML/ConsultaBlock/ConsultaBloque.xsl"/>
				<table class="tabla" align="center">
					<thead>
						<tr>
							<td align="center" class="etiqueta" colspan="3">PLACA</td>
							<td align="center" class="etiqueta" colspan="5">SEGUROS</td>
						</tr>
						<tr class="etiqueta">
							<td>Clase de Placa</td>
							<td>Numero de Placa</td>
							<td>Codigo Gobierno</td>
							<td>Cobertura(MOTOS)</td>
							<td>Su Vida</td>
							<td>Resp.Civil</td>
							<td>A.Carretera</td>
							<td>Protección</td>
						</tr>
					</thead>
					<tbody>
						<tr class="detalle">
							<td class="detalle">
								<select class="campo" name="CLASEPLACA1">
									<xsl:for-each select="ClasesPlaca/Fila">
										<xsl:if test="Codigo='PART'">
											<option value="{Codigo}" selected="selected">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
										<xsl:if test="Codigo!='PART'">
											<option value="{Codigo}">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
									</xsl:for-each>
								</select>
								<td>
									<input size="37" name="NUMPLACA1" maxlength="10" class="campo" ID="Text1"/>
								</td>
								<td>
									<select class="campo" name="CODGOBIERNO1">
										<xsl:for-each select="CodigosGobierno/Fila">
											<xsl:if test="Codigo='PAR'">
												<option value="{Codigo}" selected="selected">
													<xsl:value-of select="Descripcion"/>
												</option>
											</xsl:if>
											<xsl:if test="Codigo!='PAR'">
												<option value="{Codigo}">
													<xsl:value-of select="Descripcion"/>
												</option>
											</xsl:if>
										</xsl:for-each>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDCOBERTURA1">
										<option value="1">Si</option>
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZASV1">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZASRESCIVIL1">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZAAC1">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>								
								<td class="detalle" align="center">
									<select class="campo" name="INDPROTECCION1">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
							</td>
						</tr>
						<tr class="detalle">
							<td class="detalle">
								<select class="campo" name="CLASEPLACA2">
									<xsl:for-each select="ClasesPlaca/Fila">
										<xsl:if test="Codigo='PART'">
											<option value="{Codigo}" selected="selected">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
										<xsl:if test="Codigo!='PART'">
											<option value="{Codigo}">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
									</xsl:for-each>
								</select>
								<td>
									<input size="37" name="NUMPLACA2" maxlength="10" class="campo" ID="Text1"/>
								</td>
								<td>
									<select class="campo" name="CODGOBIERNO2">
										<xsl:for-each select="CodigosGobierno/Fila">
											<xsl:if test="Codigo='PAR'">
												<option value="{Codigo}" selected="selected">
													<xsl:value-of select="Descripcion"/>
												</option>
											</xsl:if>
											<xsl:if test="Codigo!='PAR'">
												<option value="{Codigo}">
													<xsl:value-of select="Descripcion"/>
												</option>
											</xsl:if>
										</xsl:for-each>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDCOBERTURA2">
										<option value="1">Si</option>
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZASV2">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZASRESCIVIL2">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZAAC2">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								
								<td class="detalle" align="center">
									<select class="campo" name="INDPROTECCION2">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
							</td>
						</tr>
						<tr class="detalle">
							<td class="detalle">
								<select class="campo" name="CLASEPLACA3">
									<xsl:for-each select="ClasesPlaca/Fila">
										<xsl:if test="Codigo='PART'">
											<option value="{Codigo}" selected="selected">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
										<xsl:if test="Codigo!='PART'">
											<option value="{Codigo}">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
									</xsl:for-each>
								</select>
								<td>
									<input size="37" name="NUMPLACA3" maxlength="10" class="campo" ID="Text1"/>
								</td>
								<td>
									<select class="campo" name="CODGOBIERNO3">
										<xsl:for-each select="CodigosGobierno/Fila">
											<xsl:if test="Codigo='PAR'">
												<option value="{Codigo}" selected="selected">
													<xsl:value-of select="Descripcion"/>
												</option>
											</xsl:if>
											<xsl:if test="Codigo!='PAR'">
												<option value="{Codigo}">
													<xsl:value-of select="Descripcion"/>
												</option>
											</xsl:if>
										</xsl:for-each>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDCOBERTURA3">
										<option value="1">Si</option>
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZASV3">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZASRESCIVIL3">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZAAC3">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPROTECCION3">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
							</td>
						</tr>
						<tr class="detalle">
							<td class="detalle">
								<select class="campo" name="CLASEPLACA4">
									<xsl:for-each select="ClasesPlaca/Fila">
										<xsl:if test="Codigo='PART'">
											<option value="{Codigo}" selected="selected">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
										<xsl:if test="Codigo!='PART'">
											<option value="{Codigo}">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
									</xsl:for-each>
								</select>
								<td>
									<input size="37" name="NUMPLACA4" maxlength="10" class="campo" ID="Text1"/>
								</td>
								<td>
									<select class="campo" name="CODGOBIERNO4">
										<xsl:for-each select="CodigosGobierno/Fila">
											<xsl:if test="Codigo='PAR'">
												<option value="{Codigo}" selected="selected">
													<xsl:value-of select="Descripcion"/>
												</option>
											</xsl:if>
											<xsl:if test="Codigo!='PAR'">
												<option value="{Codigo}">
													<xsl:value-of select="Descripcion"/>
												</option>
											</xsl:if>
										</xsl:for-each>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDCOBERTURA4">
										<option value="1">Si</option>
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZASV4">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZASRESCIVIL4">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZAAC4">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPROTECCION4">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
							</td>
						</tr>
						<tr class="detalle">
							<td class="detalle">
								<select class="campo" name="CLASEPLACA5">
									<xsl:for-each select="ClasesPlaca/Fila">
										<xsl:if test="Codigo='PART'">
											<option value="{Codigo}" selected="selected">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
										<xsl:if test="Codigo!='PART'">
											<option value="{Codigo}">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
									</xsl:for-each>
								</select>
								<td>
									<input size="37" name="NUMPLACA5" maxlength="10" class="campo" ID="Text1"/>
								</td>
								<td>
									<select class="campo" name="CODGOBIERNO5">
										<xsl:for-each select="CodigosGobierno/Fila">
											<xsl:if test="Codigo='PAR'">
												<option value="{Codigo}" selected="selected">
													<xsl:value-of select="Descripcion"/>
												</option>
											</xsl:if>
											<xsl:if test="Codigo!='PAR'">
												<option value="{Codigo}">
													<xsl:value-of select="Descripcion"/>
												</option>
											</xsl:if>
										</xsl:for-each>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDCOBERTURA5">
										<option value="1">Si</option>
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZASV5">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZASRESCIVIL5">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								<td class="detalle" align="center">
									<select class="campo" name="INDPOLIZAAC5">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
								
								<td class="detalle" align="center">
									<select class="campo" name="INDPROTECCION5">
										<!--<option value="1">Si</option>-->
										<option value="0" selected="">No</option>
									</select>
								</td>
							</td>
						</tr>
					</tbody>
				</table>
				<br/>
				<div align="center">
					<input class="button_red" type="submit" value="Consulta Multiple"/>
					<br/>
					<br/>
				</div>
			</form>
		</body>
	</xsl:template>
	<xsl:template name="ResultadosPagos">
		<body>
			<table align="center" width="500" border="0">
				<tr>
					<td width="50%">
						<p align="center">
							<img align="baseline" src="imagenes/pmarchamo.PNG" border="0" hspace="0" height="100" width="100"/>
						</p>
					</td>
					<td width="50%">
						<font class="tituloAzulClaro">Resultados del Pago Masivo de Placas</font>
					</td>
				</tr>
			</table>
			<table class="tabla" align="center">

				<thead>
					<tr>
						<td align="center" class="etiqueta"></td>
						<td align="center" class="etiqueta" colspan="5">POLIZAS INCLUIDAS</td>
						<td align="center" class="etiqueta" colspan="2"></td>
					</tr>
					<tr class="etiqueta">
						<td>Placa</td>
						<td>Cobertura A.</td>
						<td>Su Vida</td>
						<td>Resp.Civil</td>
						<td>A.Carretera</td>						
						<td>Protección</td>
						<td align="center">Montos</td>
						<td>Estado</td>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="Resultado/Resultados/SOA_CONFIRM_PAGO/ENCABEZADO">
						<tr class="detalle">
							<td class="detalle">
								<xsl:value-of select="CLASEPLACA"/>-
								<xsl:value-of select="NUMPLACA"/>
							</td>
							<xsl:choose>
								<xsl:when test="../PRODUCTOSADICIONALES[CODPRODUCTO=7 and CODRES=15]">
									<td class="detalle" align="center">SI</td>
								</xsl:when>
								<xsl:otherwise>
									<td class="detalle" align="center">NO</td>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="../PRODUCTOSADICIONALES[CODPRODUCTO=4 and CODRES=15]">
									<td class="detalle" align="center">SI</td>
								</xsl:when>
								<xsl:otherwise>
									<td class="detalle" align="center">NO</td>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="../PRODUCTOSADICIONALES[CODPRODUCTO=5 and CODRES=15]">
									<td class="detalle" align="center">SI</td>
								</xsl:when>
								<xsl:otherwise>
									<td class="detalle" align="center">NO</td>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="../PRODUCTOSADICIONALES[CODPRODUCTO=6 and CODRES=15]">
									<td class="detalle" align="center">SI</td>
								</xsl:when>
								<xsl:otherwise>
									<td class="detalle" align="center">NO</td>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:choose>
								<xsl:when test="../PRODUCTOSADICIONALES[CODPRODUCTO=8 and CODRES=15]">
									<td class="detalle" align="center">SI</td>
								</xsl:when>
								<xsl:otherwise>
									<td class="detalle" align="center">NO</td>
								</xsl:otherwise>
							</xsl:choose>
							<td class="detalleNumerico">
								<font size="1" color="blue">
									<xsl:value-of select="format-number(MONTO,'###,###,##0.00')"/>
								</font>
							</td>
							<td class="detalleTotal">
								<xsl:value-of select="DESRES"/>
							</td>
						</tr>
					</xsl:for-each>
					<tr>
						<td class="detalle" colspan="5"/>

						<td class="detalle" align="right">Total:
							<strong><![CDATA[ ]]></strong>
						</td>
						<td class="detalleTotal">
							<font size="2" color="red">
								<xsl:value-of select="format-number(sum(Resultado/Resultados/SOA_CONFIRM_PAGO/ENCABEZADO[CODRES=0]/MONTO),'###,###,##0.00')"/>
							</font>
						</td>
						<td class="detalle"/>
					</tr>
				</tbody>
			</table>

			<br/>
			<div align="center">
				<input name="OtraConsulta" class="button_gris" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaClasePlaca&amp;Filtro=~/XML/ConsultaBlock/ConsultaBloque.xsl','Transaccion')"/>
			</div>
			<br/>
			<div align="center">
				<form action="Transaccion.aspx">
					<input type="hidden" name="Transaccion" value="ParaImprimirVirtual"/>
					<input type="hidden" name="Filtro" value="XML/virtual/ParaImprimir.xsl"/>
					<input type="hidden" name="ServidorSTX" value="infoware.STX.RC_Impresion"/>
					<input name="BotonCerrar" class="button_red" type="submit" value="Impresion Multiple"/>
				</form>
			</div>
		</body>
	</xsl:template>
	<xsl:template name="FormularioPago">
		<table align="center" width="650" border="0">
			<tr>
				<td width="25%">
					<p align="center">
						<img align="center" src="imagenes/pmarchamo.PNG" border="0" hspace="0" height="50" width="50"/>
					</p>
				</td>
				<td width="75%">
					<p align="Left">
						<font class="tituloAzulClaro">Formulario de Pago Múltiple de Marchamos</font>
					</p>
				</td>
			</tr>
		</table>


		<form action="Transaccion.aspx" method="post">
			<input type="hidden" name="Transaccion" value="INSPagoMasico"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.CajasMasivo"/>
			<input type="hidden" name="Filtro" value="XML/ConsultaBlock/ConsultaBloque.xsl"/>
			<input type="hidden" name="Lista" value="{Resultados/Fila/ID}"/>
			<div align="center" class="tituloAzulClaro">Resultado de la Consulta Multiple</div>
			<table class="tabla" align="center">

				<thead>
					<tr>
						<td align="center" class="etiqueta"></td>
						<td align="center" class="etiqueta" colspan="5">POLIZAS INCLUIDAS</td>
						<td align="center" class="etiqueta" colspan="2"></td>
					</tr>
					<tr class="etiqueta">
						<td>Placa</td>
						<td>Cobertura(MOTOS)</td>
						<td>Su Vida</td>
						<td>Resp.Civil</td>
						<td>A.Carretera</td>
						<td>Protección</td>
						<td align="center">Montos</td>
						<td>Estado</td>
					</tr>
				</thead>
				<tbody>
					<!--<xsl:for-each select="Consultas/Resultados/SOA_RESULT_PLACA/ENCABEZADO[CODRES=0]">-->
					<xsl:for-each select="Consultas/Resultados/SOA_RESULT_PLACA/ENCABEZADO">
						<tr class="detalle">
							<td class="detalle">
								<xsl:value-of select="CLASEPLACA"/>-
								<xsl:value-of select="NUMPLACA"/>
							</td>
							<xsl:choose>
								<xsl:when test="../PRODUCTOSADICIONALES[CODPRODUCTO=7 and CODRES=15]">
									<td class="detalle" align="center">SI</td>
								</xsl:when>
								<xsl:otherwise>
									<td class="detalle" align="center">NO</td>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="../PRODUCTOSADICIONALES[CODPRODUCTO=4 and CODRES=15]">
									<td class="detalle" align="center">SI</td>
								</xsl:when>
								<xsl:otherwise>
									<td class="detalle" align="center">NO</td>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="../PRODUCTOSADICIONALES[CODPRODUCTO=5 and CODRES=15]">
									<td class="detalle" align="center">SI</td>
								</xsl:when>
								<xsl:otherwise>
									<td class="detalle" align="center">NO</td>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="../PRODUCTOSADICIONALES[CODPRODUCTO=6 and CODRES=15]">
									<td class="detalle" align="center">SI</td>
								</xsl:when>
								<xsl:otherwise>
									<td class="detalle" align="center">NO</td>
								</xsl:otherwise>
							</xsl:choose>							
							<xsl:choose>
								<xsl:when test="../PRODUCTOSADICIONALES[CODPRODUCTO=8 and CODRES=15]">
									<td class="detalle" align="center">SI</td>
								</xsl:when>
								<xsl:otherwise>
									<td class="detalle" align="center">NO</td>
								</xsl:otherwise>
							</xsl:choose>

							<xsl:choose>
								<xsl:when test="CODRES=0">
									<td class="detalleNumerico">
										<font size="1" color="blue">
											<xsl:value-of select="format-number(MONTO,'###,###,##0.00')"/>
										</font>
									</td>
								</xsl:when>
								<xsl:otherwise>
									<td class="detalleNumerico">
										<font size="1">
											<xsl:value-of select="format-number(MONTO,'###,###,##0.00')"/>
										</font>
									</td>
								</xsl:otherwise>
							</xsl:choose>

							<td class="detalleTotal">

								<xsl:value-of select="DESRES"/>
							</td>
						</tr>
					</xsl:for-each>
					<tr>
						<td class="detalle" colspan="5"/>

						<td class="detalleTotal" align="right">
							<font size="2" color="black">Total:</font>
							<strong><![CDATA[ ]]></strong>
						</td>
						<td class="detalleTotal">
							<font size="2" color="red">
								<xsl:value-of select="format-number(sum(Consultas/Resultados/SOA_RESULT_PLACA/ENCABEZADO[CODRES=0]/MONTO),'###,###,##0.00')"/>
							</font>
						</td>
						<td class="detalle"/>
					</tr>
				</tbody>
			</table>

			<div align="center">
				    <a href="javascript: void(0);" onclick="window.history.back()">
					<img src="imagenes/back.gif"/>Atras</a>
			</div>

			<xsl:if test="Consultas/Resultados/SOA_RESULT_PLACA/ENCABEZADO/CODRES=0">
				<div align="center" class="tituloAzulClaro">Detalle del Pago para todos los Marchamos</div>
				<table class="tabla" align="center">
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
						<td class="etiqueta">Direccion Entrega (Opcional):</td>
						<td class="detalle" colSpan="3">
							<input name="DireccionExacta" maxlength="50" size="50"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre de la persona que paga los marchamos :</td>
						<td class="detalle" colSpan="3">
							<input name="NombrePagador" size="35"/>
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
											<xsl:value-of select="Descripcion"/></option>
									</xsl:if>
									<xsl:if test="Codigo &gt;0 and PuedePagar=1">
										<option value="{Codigo}">
											<xsl:value-of select="Descripcion"/></option>
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
								<option value="2">Tarjeta</option>
								<option value="2">Mixto</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Cedula Autorizado a Retirar (Opcional):</td>
						<td class="detalle" colSpan="3">
							<input name="IDAutorizado" maxlength="25" size="25"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Nombre Autorizado a Retirar (Opcional):</td>
						<td class="detalle" colSpan="3">
							<input name="NombreAutorizado" maxlength="35" size="35"/>
						</td>
					</tr>
				</table>
				<table align="center">
					<td>
						<input class="button_red" type="submit" value="Pago Multiple"/>
					</td>

					<td>
						<input name="OtraConsulta" class="button_gris" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaClasePlaca&amp;Filtro=~/XML/ConsultaBlock/ConsultaBloque.xsl','Transaccion')"/>
					</td>
				</table>
			</xsl:if>
		</form>
	</xsl:template>
	<xsl:template name="BotonesMarchamo">
		<div align="center">
			<input name="BotonPagar" class="button_red" type="button" value="      Pagar      " onclick="ValidarMarchamo()"/>
			<input name="OtraConsulta" class="button_gris" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaClasePlaca&amp;Filtro=~/XML/INS/INSConsultar.xsl','Transaccion')"/>
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
			<input name="OtraConsulta" class="button_gris" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaClasePlaca&amp;Filtro=~/XML/INS/INSConsultar.xsl','Transaccion')"/>
		</div>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\virtual\ParaImprimir.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
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