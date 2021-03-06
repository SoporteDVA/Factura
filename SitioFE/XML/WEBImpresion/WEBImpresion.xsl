<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
				<link rel="stylesheet" type="text/css" href="Impresion.css" media="print"/>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"></script>
				<style type="text/css" media="print">.nover {display:none}</style>
			</head>
			<xsl:choose>
				<xsl:when test="xp_BitacoraCJPagoOutput">
					<xsl:for-each select="xp_BitacoraCJPagoOutput">
						<xsl:call-template name="Impresion"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="xp_BitacoraCJPagoFault">
					<xsl:for-each select="xp_BitacoraCJPagoFault">
						<xsl:call-template name="Mensaje"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<div align="center">
						<br/>
						<font class="tituloAzulClaro">
							<xsl:value-of select="Respuesta"/>
						</font>
						<br/>
						<br/>
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</html>
	</xsl:template>
	<xsl:template name="Impresion">
		<br/>
		<div align="left">
			<form>
				<input type="button" onclick="window.print();" value="Imprimir" class="nover"/>
			</form>
		</div>
		<div align="Left">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="ConsultaMaestros"/>
				<input type="hidden" name="Filtro" value="XML/WEBPagos/PagosConsultar.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="nover" type="submit" value="   Otra Consulta   "/>
			</form>
		</div>

		<!--<div align="left">
		<form>
			<input type="button" value="Print Popup" onclick="if (window.print) winref.print()"/>
		</form>
		</div>-->



		<div id="contenido">
			<table align="left" border="1">

				<thead>
					<tr>
						<td colSpan="7" class="Etiqueta" align="left">Banco DAVIVIENDA (Costa Rica)</td>
					</tr>



					<xsl:for-each select="xp_ReimpresionServicioOutput/Encabezado/Campos/Campo[Tipo='Fecha' or Tipo='Numero' or Tipo='Texto' or Tipo='Text']">
						<tr>
							<td colSpan="7" class="Etiqueta" align="left">
								<xsl:value-of select="Etiqueta"/>
								<!--<xsl:choose>
									<xsl:when test="contains(Tipo,'Fecha')">
										<xsl:value-of select="Etiqueta"/>
									</xsl:when>
									<xsl:when test="contains(Tipo,'Num')">
										<xsl:value-of select="Etiqueta"/>
									</xsl:when>
									<xsl:when test="contains(Etiqueta,'Perio')">
										<xsl:value-of select="Etiqueta"/>
									</xsl:when>
								</xsl:choose>-->
								<xsl:choose>

									<xsl:when test="contains(Tipo,'Fecha')">: <xsl:value-of select="Valor"/></xsl:when>

									<xsl:when test="contains(Tipo,'Num')">: <xsl:value-of select="Valor"/></xsl:when>

									<xsl:when test="contains(Etiqueta,'Perio')">: <xsl:value-of select="Valor"/></xsl:when>

									<xsl:when test="Tipo!='Mensaje'">: <xsl:value-of select="Valor"/></xsl:when>
									<!--<xsl:otherwise>
										<xsl:value-of select="Valor"/>
									</xsl:otherwise>-->
								</xsl:choose>
							</td>
						</tr>
					</xsl:for-each>
					<tr>
						<td colSpan="7" align="center"></td>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="xp_ReimpresionServicioOutput/Detalle/Campos/Campo">
						
						<tr>

							<td colSpan="4" align="left">
								<xsl:choose>
									<xsl:when test="contains(Etiqueta,'Moneda')">
										<xsl:attribute name="class">Etiqueta</xsl:attribute>
										<xsl:value-of select="Etiqueta"/>
									</xsl:when>
									<xsl:when test="contains(Etiqueta,'Total')">
										<xsl:attribute name="class">Etiqueta</xsl:attribute>
										<xsl:value-of select="Etiqueta"/>										
									</xsl:when>									
									<xsl:otherwise>
										<xsl:attribute name="class">detalleNumerico</xsl:attribute>
										<xsl:value-of select="Etiqueta"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td colSpan="3" align="right">
								<xsl:choose>
									<xsl:when test="contains(Etiqueta,'Moneda')">
										<xsl:attribute name="class">Etiqueta</xsl:attribute>
										<xsl:value-of select="Valor"/>
									</xsl:when>
									<xsl:when test="contains(Etiqueta,'Total')">
										<xsl:attribute name="class">Etiqueta</xsl:attribute>
										<xsl:value-of select="Valor"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="class">detalleNumerico</xsl:attribute>
										<xsl:value-of select="Valor"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>


					</xsl:for-each>
					<tr>
						<td colSpan="7" align="center"></td>
					</tr>
					<xsl:for-each select="xp_ReimpresionServicioOutput/Encabezado/Campos/Campo[Tipo='Mensaje']">
						<tr>
							<td colSpan="7" class="Etiqueta" align="center">
								<xsl:choose>
									<xsl:when test="contains(Tipo,'Mens') and contains(Valor,'/') and contains(Etiqueta,'Emisi')">
										<xsl:attribute name="class">Etiqueta</xsl:attribute>Emitido el: <xsl:value-of select="Valor"/></xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="class">Etiqueta</xsl:attribute>
										<xsl:value-of select="Valor"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</xsl:for-each>
					<tr>
						<td colSpan="7" class="Etiqueta" align="center">Usuario Emisor: <xsl:value-of select="Sesion/Usuario"/></td>
					</tr>
				</tbody>
			</table>
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\Impresion\ToPrint.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
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