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
								<img align="baseline" src="imagenes/ins.gif" border="0" hspace="0" height="60"/>
							</p>
						</td>
						<td width="50%">
							<font class="tituloAzulClaro">Registro de Pólizas Generals</font>
						</td>
					</tr>
				</table>
				<br/>
				<xsl:choose>
					<xsl:when test="RenovarPolizaGeneralINSOutput">
						<xsl:for-each select="RenovarPolizaGeneralINSOutput">
							<xsl:call-template name="Consulta"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="RenovarPolizaAGVINSOutput">
						<xsl:for-each select="RenovarPolizaAGVINSOutput">
							<xsl:call-template name="Consulta"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="RegistrarPolizaGeneralOutput">
						<xsl:call-template name="Pagar"/>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>
								<br/>
								<xsl:value-of select="RenovarPolizaGeneralINSFault/Respuesta"/>
							</h1>
							<br/>
							<input name="OtraConsulta" type="button" value="Otra consulta"
							       onclick="cargar(this,'Transaccion.aspx?Transaccion=CargaCaracteristicasPolizas&amp;servidorSTX=infoware.STX.Gestion&amp;Filtro=~/XML/General/ConsultarGeneral.xsl','Transaccion')"/>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="Consulta">
		<table class="tabla" align="center">
			<td class="etiqueta" colspan="2">
				<div align="center" class="tituloAzulClaro">Información del propietario</div>
			</td>
			<tr class="etiqueta">
				<td>Nombre Propietario:</td>
				<td class="detalle">
					<xsl:value-of select="NOMPERSONAPROPIETARIO"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td>
					<xsl:call-template name="Descripcion">
						<xsl:with-param name="TipoIdPersonaPropietario" select="TIPOIDPERSONAPROPIETARIO"/>
					</xsl:call-template>:</td>
				<td class="detalle">
					<xsl:value-of select="CEDPERSONAPROPIETARIO"/>
				</td>
			</tr>
			<td class="etiqueta" colspan="2">
				<div align="center" class="tituloAzulClaro">Información de la Póliza</div>
			</td>
			<tr class="etiqueta">
				<td>Número de Placa:</td>
				<td class="detalle">
					<xsl:value-of select="ENCABEZADO/NUMPLACA"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td>Número de Chasis:</td>
				<td class="detalle">
					<xsl:value-of select="Arrastre/CHASIS"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td>Número de Motor:</td>
				<td class="detalle">
					<xsl:value-of select="Arrastre/MOTOR"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td>Fecha Ingreso:</td>
				<td class="detalle">
					<xsl:value-of select="Arrastre/INGRESOPAIS"/>
				</td>
			</tr>
			<!--<tr class="etiqueta">
				<td>Fecha Emisión:</td>
				<td class="detalle">
					<xsl:value-of select="POLIZA/FECEMISIONPOLIZA"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td>Fecha Bono:</td>
				<td class="detalle">
					<xsl:value-of select="POLIZA/FECFVBONO"/>
				</td>
			</tr>-->
			<tr class="etiqueta">
				<td>Fecha de Inicio Póliza:</td>
				<td class="detalle">
					<xsl:value-of select="ENCABEZADO/FECIVPOLIZAGeneralTMP"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td>Fecha Final de Póliza:</td>
				<td class="detalle">
					<xsl:value-of select="ENCABEZADO/FECFVPOLIZAGeneralTMP"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Monto :</td>
				<td class="detalleTotal">
					<xsl:value-of select="format-number(MONTOTALPAGAR,'###,##0.00')"/>
				</td>
			</tr>
		</table>
		<form action="Transaccion.aspx" method="post" onsubmit="return VerificarData();">
			<input type="hidden" name="Transaccion" value="PagarPolizaGeneral"/>
			<input type="hidden" name="Filtro" value="XML/General/GeneralPago.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
			<input type="hidden" name="IP" value="{IP}"/>
			<input type="hidden" name="ClasePlaca" value="{ENCABEZADO/CLASEPLACA}"/>
			<input type="hidden" name="NumeroPlaca" value="{ENCABEZADO/NUMPLACA}"/>
			<input type="hidden" name="CodigoGobierno" value="{ENCABEZADO/CODGOBIERNO}"/>
			<input type="hidden" name="TotalPago" value="{MONTOTALPAGAR}"/>
			<input type="hidden" name="Nombre" value="{NOMPERSONAPROPIETARIO}"/>
			<div align="center" class="tituloAzulClaro">Detalle del pago</div>
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">Provincia:</td>
					<td class="detalle" colSpan="3">
						<SELECT class="inputAzul" NAME="Provincia"
						        onChange="fillSelectFromArray(this.form.Canton, ((this.selectedIndex == -1) ? null : canton[this.selectedIndex-1])); fillSelectFromArray(this.form.Distrito, ((Canton.selectedIndex == -1) ? null : distrito[this.selectedIndex-1][0]));">
							<OPTION VALUE="-1">--- Selecione ---</OPTION>
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
						<input name="NombrePagador" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Teléfono :</td>
					<td class="detalle" colSpan="3">
						<input name="TelefonoPagador" maxlength="8" size="8"/>
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
						<input name="CedulaPagador" maxlength="10" size="10"/>
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
						<xsl:value-of select="format-number(MONTOTALPAGAR,'###,##0.00')"/>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonPagar" type="submit" value="      Pagar      "/>
				<input name="OtraConsulta" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=CargaCaracteristicasPolizas&amp;servidorSTX=infoware.STX.Gestion&amp;Filtro=~/XML/General/ConsultarGeneral.xsl','Transaccion')"/>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="Pagar">
		<table class="tabla" align="center">
			<td class="etiqueta" colspan="2">
				<div align="center" class="tituloAzulClaro">Información del propietario</div>
			</td>
			<tr class="etiqueta">
				<td>Nombre Propietario:</td>
				<td class="detalle">
					<xsl:value-of select="RegistrarPolizaGeneralOutput/ENCABEZADO/NOMPERSONAPROPIETARIO"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td>
					<xsl:call-template name="Descripcion">
						<xsl:with-param name="TipoIdPersonaPropietario" select="RegistrarPolizaGeneralOutput/ENCABEZADO/TIPOIDPERSONAPROPIETARIO"/>
					</xsl:call-template>:</td>
				<td class="detalle">
					<xsl:value-of select="RegistrarPolizaGeneralOutput/ENCABEZADO/CEDPERSONAPROPIETARIO"/>
				</td>
			</tr>
			<td class="etiqueta" colspan="2">
				<div align="center" class="tituloAzulClaro">Información de la Póliza</div>
			</td>
			<tr class="etiqueta">
				<td>Número de Placa:</td>
				<td class="detalle">
					<xsl:value-of select="RegistrarPolizaGeneralOutput/ENCABEZADO/PLACAEXTRANJERA"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td>Número de Chasis:</td>
				<td class="detalle">
					<xsl:value-of select="RegistrarPolizaGeneralOutput/ENCABEZADO/NUMCHASIS"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td>Número de Motor:</td>
				<td class="detalle">
					<xsl:value-of select="RegistrarPolizaGeneralOutput/ENCABEZADO/NUMMOTOR"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td>Fecha Ingreso:</td>
				<td class="detalle">
					<xsl:value-of select="RegistrarPolizaGeneralOutput/ENCABEZADO/FECINGRESOPAIS"/>
				</td>
			</tr>
			<!--<tr class="etiqueta">
				<td>Fecha Emisión:</td>
				<td class="detalle">
					<xsl:value-of select="POLIZA/FECEMISIONPOLIZA"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td>Fecha Bono:</td>
				<td class="detalle">
					<xsl:value-of select="POLIZA/FECFVBONO"/>
				</td>
			</tr>-->
			<tr class="etiqueta">
				<td>Fecha de Inicio Póliza:</td>
				<td class="detalle">
					<xsl:value-of select="RegistrarPolizaGeneralOutput/ENCABEZADO/FECIVPOLIZAGeneral"/>
				</td>
			</tr>
			<tr class="etiqueta">
				<td>Fecha Final de Póliza:</td>
				<td class="detalle">
					<xsl:value-of select="RegistrarPolizaGeneralOutput/ENCABEZADO/FECFVPOLIZAGeneral"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Monto :</td>
				<td class="detalleTotal">
					<xsl:value-of select="format-number(RegistrarPolizaGeneralOutput/MONTOTALPAGAR,'###,##0.00')"/>
				</td>
			</tr>
		</table>
		<form action="Transaccion.aspx" method="post" onsubmit="return VerificarData();">
			<input type="hidden" name="Transaccion" value="PagarPolizaGeneral"/>
			<input type="hidden" name="Filtro" value="XML/General/GeneralPago.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
			<input type="hidden" name="IP" value="{RegistrarPolizaGeneralOutput/IP}"/>
			<input type="hidden" name="ClasePlaca" value="{RegistrarPolizaGeneralOutput/CLASEPLACA}"/>
			<input type="hidden" name="NumeroPlaca" value="{RegistrarPolizaGeneralOutput/NUMPLACA}"/>
			<input type="hidden" name="CodigoGobierno" value="{RegistrarPolizaGeneralOutput/CODGOBIERNO}"/>
			<input type="hidden" name="TotalPago" value="{RegistrarPolizaGeneralOutput/MONTOTALPAGAR}"/>
			<div align="center" class="tituloAzulClaro">Detalle del pago</div>
			<table align="center" class="tabla">
				<tr>
					<td class="etiqueta">Provincia:</td>
					<td class="detalle" colSpan="3">
						<SELECT class="inputAzul" NAME="Provincia"
						        onChange="fillSelectFromArray(this.form.Canton, ((this.selectedIndex == -1) ? null : canton[this.selectedIndex-1])); fillSelectFromArray(this.form.Distrito, ((Canton.selectedIndex == -1) ? null : distrito[this.selectedIndex-1][0]));">
							<OPTION VALUE="-1">--- Selecione ---</OPTION>
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
						<input name="NombrePagador" size="36"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Teléfono :</td>
					<td class="detalle" colSpan="3">
						<input name="TelefonoPagador" maxlength="8" size="8"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">
						<select class="campo" name="TipoIdPagador">
							<xsl:for-each select="RegistrarPolizaGeneralOutput/TipoIds/TipoId">
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
						<input name="CedulaPagador" maxlength="10" size="10"/>
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
						<xsl:value-of select="format-number(RegistrarPolizaGeneralOutput/MONTOTALPAGAR,'###,##0.00')"/>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonPagar" type="submit" value="      Pagar      "/>
				<input name="OtraConsulta" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=CargaCaracteristicasPolizas&amp;servidorSTX=infoware.STX.Gestion&amp;Filtro=~/XML/AGV/Reg_AGV.xsl','Transaccion')"/>
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
			<input name="OtraConsulta" type="button" value="Otra consulta" onclick="cargar(this,'Transaccion.aspx?Transaccion=CargaCaracteristicasPolizas&amp;servidorSTX=infoware.STX.Gestion&amp;Filtro=~/XML/AGV/Reg_AGV.xsl','Transaccion')"/>
		</div>
	</xsl:template>
	<xsl:template name="Descripcion" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		<xsl:param name="TipoIdPersonaPropietario" select="."/>
		<xsl:choose>
			<xsl:when test="$TipoIdPersonaPropietario = 0">Cedula Fisica nacional</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 1">Cedula de Residencia</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 4">Cedula Institucion Autonoma</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 3">Cedula Personeria Juridica</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 5">Indocumentados</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 6">Documento Unico</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 8">Permiso de Trabajo</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 9">Pasaporte</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 15">Cedula Refugiados</xsl:when>
			<xsl:when test="$TipoIdPersonaPropietario = 16">Cedula Asociada a Tramites</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2007. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="file:///c:/Users/Administrator/Desktop/Untitled1.xml" htmlbaseurl="http://192.168.1.9/default.aspx" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="" ><advancedProp name="sInitialMode" value=""/><advancedProp name="bXsltOneIsOkay" value="true"/><advancedProp name="bSchemaAware" value="true"/><advancedProp name="bXml11" value="false"/><advancedProp name="iValidation" value="0"/><advancedProp name="bExtensions" value="true"/><advancedProp name="iWhitespace" value="0"/><advancedProp name="sInitialTemplate" value=""/><advancedProp name="bTinyTree" value="true"/><advancedProp name="bWarnings" value="true"/><advancedProp name="bUseDTD" value="false"/><advancedProp name="iErrorHandling" value="fatal"/></scenario></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->