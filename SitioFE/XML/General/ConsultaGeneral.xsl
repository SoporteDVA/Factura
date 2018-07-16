<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes" encoding="UTF-8"/>
	<xsl:template match="/">
		<html>
			<head>
				<meta http-equiv="Pragma" content="no-cache"/>
				<link rel="stylesheet" type="text/css" href="STestilos.css"/>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"></script>
				<script src="codigo/dist_geo.js" language="javascript" type="text/javascript"></script>
				<script language="javascript" type="text/javascript">function VerificarData(){
				    var estado=1;
					var f=document.forms[0];
					if (f.NombrePagador.value=="") { 
						alert('Por favor digíte el Nombre del pagador.');
						return false;}
					if (f.TelefonoPagador.value=="") { 
						alert('Por favor digíte el Teléfono del pagador.');
						return false;}
					if (f.CedulaPagador.value=='') { 
						alert('Por favor digíte la Identificación del pagador.');
						return false;}		
					return true;
				}</script>
			</head>
			<body>

				<table align="center" width="500" border="0">
					<tr>
						<td width="50%">
							<p align="center">
								<img align="baseline" src="imagenes/Polizas.PNG" border="0" width="60px" height="60px"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Pago de Pólizas General</font>
						</td>
					</tr>
				</table>
				<br/>
				<xsl:choose>
					<xsl:when test="ConsultarPagosGeneralOutput">
						<xsl:for-each select="ConsultarPagosGeneralOutput">
							<xsl:call-template name="Consulta"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>
								<br/>
								<xsl:value-of select="ConsultarPagosGeneralFault/Respuesta"/>
							</h1>
							<br/>
							<input name="OtraConsulta" class="button_gris" type="button" value="Otra consulta"
							       onclick="cargar(this,'ComponerXSL.aspx?Transaccion=PolizasGeneral&amp;servidorSTX=infoware.STX.Gestion&amp;Filtro=~/XML/General/ConsultarGeneral.xsl','Transaccion')"/>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="Consulta">
		<br/>
		<table class="tabla" width="400" align="center">
			<tbody>
				<td width="50%" class="etiqueta" colspan="3">
					<div align="center" class="tituloAzulClaro">Información del Propietario</div>
				</td>
				<tr class="etiqueta">
					<td>Número de placa:</td>
					<td class="detalle">
						<xsl:value-of select="SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/CLASEPLACA"/>-
						<xsl:value-of select="SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/NUMPLACA"/>-
						<xsl:value-of select="SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/CODGOBIERNO"/>
					</td>
				</tr>
				<tr class="etiqueta">
					<td>Nombre Propietario:</td>
					<td class="detalle">
						<xsl:value-of select="SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
					</td>
				</tr>
				<tr class="etiqueta">
					<td>
						<xsl:call-template name="Descripcion">
							<xsl:with-param name="TipoIdPersonaPropietario" select="SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/TIPOIDPERSONAPROPIETARIO"/>
						</xsl:call-template>:</td>
					<td class="detalle">
						<xsl:value-of select="SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
					</td>
				</tr>
				<tr class="etiqueta">
					<td>Marca:</td>
					<td class="detalle">
						<xsl:value-of select="SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/DESMARCA"/>
					</td>
				</tr>
				<tr class="etiqueta">
					<td>Año Modelo:</td>
					<td class="detalle">
						<xsl:value-of select="SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/ANOMODELO"/>
					</td>
				</tr>
			</tbody>
		</table>
		<br/>
		<form action="Transaccion.aspx" method="post" onsubmit="return VerificarData();">
			<table class="tabla" width="400" align="center">
				<tbody>
					<td width="50%" class="etiqueta" colspan="6">
						<div align="center" class="tituloAzulClaro">Información de la Póliza</div>
					</td>
					<tr class="etiqueta" align="center">
						<td>Póliza</td>
						<td>Monto:</td>
						<td>Fecha Inicio:</td>
						<td>Fecha Final:</td>
						<td>Pagable:</td>
					</tr>
					<xsl:for-each select="SOA_RESULT_PLACA_PRODUC_ADIC/PRODUCTOSADICIONALES">
						<!--					<xsl:if test="CODPRODUCTO =94 or CODPRODUCTO =95 or CODPRODUCTO =96 or CODPRODUCTO =98 or CODPRODUCTO =100 and CODRES=15">
						<input type="hidden" name="IP" value="{IP}"/>
						<input type="hidden" name="CODPRODUCTO" value="{CODPRODUCTO}"/>
						<input type="hidden" name="TotalPago" value="{MONTOTOTAL}"/>
					</xsl:if>-->
						<tr class="detalle">
							<td>
								<xsl:if test="CODPRODUCTO =4">Incluye Su Vida:</xsl:if>
								<xsl:if test="CODPRODUCTO =5">Incluye Responsabilidad Civil:</xsl:if>
								<xsl:if test="CODPRODUCTO =6">Incluye Asistencia en Carretera:</xsl:if>
								<xsl:if test="CODPRODUCTO =7">Incluye Cobertura Adicional:</xsl:if>
								<xsl:if test="CODPRODUCTO =8">Incluye Mas Protección:</xsl:if>
							</td>
							<td>
								<xsl:value-of select="format-number(MONTOTOTAL,'##,###')"/>
							</td>
							<td>
								<xsl:copy-of select="FECIVPOLIZA"/>
							</td>
							<td>
								<xsl:copy-of select="FECFVPOLIZA"/>
							</td>
							<td align="center">
								<xsl:if test="CODPRODUCTO =4 and CODRES=15">
									<input type="hidden" name="IDPago" value="{concat(IP,'+',CODPRODUCTO,'+',MONTOTOTAL)}" checked="true"/>SI</xsl:if>
								<xsl:if test="CODPRODUCTO =5 and CODRES=15">
									<input type="hidden" name="IDPago" value="{concat(IP,'+',CODPRODUCTO,'+',MONTOTOTAL)}" checked="true"/>SI</xsl:if>
								<xsl:if test="CODPRODUCTO =6 and CODRES=15">
									<input type="hidden" name="IDPago" value="{concat(IP,'+',CODPRODUCTO,'+',MONTOTOTAL)}" checked="true"/>SI</xsl:if>
								<xsl:if test="CODPRODUCTO =7 and CODRES=15">
									<input type="hidden" name="IDPago" value="{concat(IP,'+',CODPRODUCTO,'+',MONTOTOTAL)}" checked="true"/>SI</xsl:if>
								<xsl:if test="CODPRODUCTO =8 and CODRES=15">
									<input type="hidden" name="IDPago" value="{concat(IP,'+',CODPRODUCTO,'+',MONTOTOTAL)}" checked="true"/>SI</xsl:if>
								<xsl:if test="CODPRODUCTO =4 and CODRES!=15">NO</xsl:if>
								<xsl:if test="CODPRODUCTO =5 and CODRES!=15">NO</xsl:if>
								<xsl:if test="CODPRODUCTO =6 and CODRES!=15">NO</xsl:if>
								<xsl:if test="CODPRODUCTO =7 and CODRES!=15">NO</xsl:if>
								<xsl:if test="CODPRODUCTO =8 and CODRES!=15">NO</xsl:if>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
			<input type="hidden" name="Transaccion" value="PagarPolizas"/>
			<input type="hidden" name="Filtro" value="XML/General/GeneralPago.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
			<input type="hidden" name="ClasePlaca" value="{SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/CLASEPLACA}"/>
			<input type="hidden" name="NumeroPlaca" value="{SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/NUMPLACA}"/>
			<input type="hidden" name="Periodo" value="{SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/PERIODO}"/>
			<input type="hidden" name="CodigoGobierno" value="{SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/CODGOBIERNO}"/>
			<input type="hidden" name="Nombre" value="{SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/NOMPERSONAPROPIETARIO}"/>
			<xsl:if test="sum(SOA_RESULT_PLACA_PRODUC_ADIC/PRODUCTOSADICIONALES[CODRES=15]/MONTOTOTAL)&gt;0">
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
						<td class="etiqueta">Nombre de la persona que paga la póliza :</td>
						<td class="detalle" colSpan="3">
							<input name="NombrePagador" size="36" value="{SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/NOMPERSONAPROPIETARIO}"/>
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
							<input name="CORREO" value="autoexpedibles@ins-cr.com" maxlength="´50" size="35"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">
							<select class="campo" name="TipoIdPagador">
								<xsl:for-each select="TipoIds/TipoId">
									<xsl:if test="Codigo=0">
										<xsl:if test="Codigo=/ConsultarPagosGeneralOutput/SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/TIPOIDPERSONAPROPIETARIO">
											<option value="{Codigo}" selected="selected">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
									</xsl:if>
									<xsl:if test="Codigo &gt;0 and PuedePagar=1">
										<xsl:if test="Codigo =/ConsultarPagosGeneralOutput/SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/TIPOIDPERSONAPROPIETARIO">
											<option value="{Codigo}" selected="selected">
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
									</xsl:if>
									<xsl:if test="Codigo &gt;0 and PuedePagar=1">
										<xsl:if test="Codigo !=/ConsultarPagosGeneralOutput/SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/TIPOIDPERSONAPROPIETARIO">
											<option value="{Codigo}" >
												<xsl:value-of select="Descripcion"/>
											</option>
										</xsl:if>
									</xsl:if>
								</xsl:for-each>
							</select>
						</td>
						<td class="detalle" colSpan="3">
							<input name="CedulaPagador" maxlength="25" size="25" value="{SOA_RESULT_PLACA_PRODUC_ADIC/ENCABEZADO/CEDPERSONAPROPIETARIO}"/>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Forma de pago :</td>
						<td colspan="3" class="detalle">
							<select class="campo" name="FormaPago">
								<option value="1" selected="true">Efectivo</option>
								<option value="2" >Tarjeta</option>
								<option value="3" >Mixto</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="etiqueta">Total a pagar :</td>
						<td colspan="3" class="detalleTotal">
							<xsl:value-of select="format-number(sum(SOA_RESULT_PLACA_PRODUC_ADIC/PRODUCTOSADICIONALES[CODRES=15]/MONTOTOTAL),'###,##0.00')"/>
						</td>
					</tr>
				</table>
				<br/>
			</xsl:if>
			<div align="center">
				<xsl:if test="sum(SOA_RESULT_PLACA_PRODUC_ADIC/PRODUCTOSADICIONALES[CODRES=15]/MONTOTOTAL)&gt;0">
				<input name="BotonPagar" class="Button_red" type="submit" value="      Pagar      "/>
				</xsl:if>
				<input name="OtraConsulta" class="Button_gris" type="button" value="Otra consulta"
				       onclick="cargar(this,'Transaccion.aspx?Transaccion=CargaCaracteristicasPolizas&amp;servidorSTX=infoware.STX.Gestion&amp;Filtro=~/XML/General/ConsultarGeneral.xsl','Transaccion')"/>
			</div>
		</form>
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
			<input name="OtraConsulta" class="Button_gris" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=CargaCaracteristicasPolizas&amp;servidorSTX=infoware.STX.Gestion&amp;Filtro=~/XML/AGV/Reg_AGV.xsl','Transaccion')"/>
		</div>
	</xsl:template>
	<xsl:template name="Descripcion" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		<xsl:param name="TipoIdPersonaPropietario" select="."/>
		<xsl:choose>
			<xsl:when test="$TipoIdPersonaPropietario = 0">Cédula Física Nacional (999999999)</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 1">Cédula de Residencia (99999999999999999)</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 4">Cédula Persona Autonoma (9999999999)</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 3">Cedula Personeria Juridica</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 5">Indocumentados (FMAA99999999AAA9)</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 6">Documento Único (999999999999)</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 8">Permiso de Trabajo (9999999999999999)</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 9">Pasaporte (FMXXXXXXXXXXX)</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 15">Cédula Refugiados (999AAA999999999)</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 16">Cédula Asociada a Tramites (FMXXXXXXXXXXXXXXXXX)</xsl:when>

                                    


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