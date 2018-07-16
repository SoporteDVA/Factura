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
			</head>
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
				<table align="center" border="0">
					<tr>
						<!--<td width="50%">
							<p align="center">
								<img src="imagenes/Programas.PNG" align="baseline" border="0" width="60px" height="60px"/>
							</p>
						</td>-->
						<td width="100%">
							<font class="tituloAzulClaro">Gestión del Condiciones de la Nota de Credito</font>
						</td>
					</tr>
				</table>
				<xsl:choose>
					<xsl:when test="ConsultaCondicionesOutput">
						<xsl:for-each select="ConsultaCondicionesOutput">
							<xsl:call-template name="ConsultaCondicionesOutput"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="AgregaModificaColectoresOutput">
						<xsl:for-each select="AgregaModificaColectoresOutput">
							<xsl:call-template name="ConsultaColectoresOutput"/>
						</xsl:for-each>
					</xsl:when>

					<xsl:when test="ModificarProgramaOutput">
						<!--<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="ModificarProgramaOutput/Fila/Mensaje"/>
						</xsl:call-template>-->
						<xsl:apply-templates select="ModificarProgramaOutput"/>
					</xsl:when>

					<xsl:when test="ModificarProgramaFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="ModificarProgramaFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAEliminarCajasOutput">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAEliminarCajasOutput/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="DVAEliminarCajasFault">
						<xsl:call-template name="MostrarMensaje">
							<xsl:with-param name="Mensaje" select="DVAEliminarCajasFault/Respuesta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error con el programa.
								<br/>
								<xsl:value-of select="ActualizarCajasFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="ConsultaCondicionesOutput">
		<table class="tabla" align="center">
			<tr>
				<td class="etiqueta">Cliente:</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/Fila/Recaudador"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Codigo del Sistema:</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/Fila/Colector"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Codigo Colector Alterno (Banco):</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/IDAlterno"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Recaudador Alterno (Banco):</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/Fila/RecaudadorProveedor"/>
				</td>
			</tr>
		</table>
		<xsl:choose>
			<xsl:when test="Accion='Editar'">
				<xsl:call-template name="Actualizar"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="Actualizar"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Actualizar">
		<form action="Transaccion.aspx">
			<input type="hidden" name="Transaccion" value="AgregaModificaCondiciones"/>
			<input type="hidden" name="Filtro" value="XML/WEBCondiciones/ConsultaColectoresNC.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="ID" value="{Resultado/Fila/Colector}"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Editar o Agregar las Condiciones de la Nota de Credito</div>

			<table align="center" class="tabla">

				<tr>
					<td class="etiqueta">Codigo Asignado por el Proveedor:</td>
					<td class="detalle" colSpan="3">
						<input name="RecaudadorProveedor" value="{Resultado/Fila/RecaudadorProveedor}" size="20"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Nota por Colector :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="NCPorColector">
							<option value="{Resultado/Fila/NCPorColector}" selected="selected">
								<xsl:call-template name="EstadoCondiciones">
									<xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/NCPorColector)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Resultado/Fila/NCPorColector)='1'">
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/NCPorColector)='0'">
								<OPTION VALUE="1">SI</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/NCPorColector)=''">
								<OPTION VALUE="1" selected="selected">SI</OPTION>
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Nota por Convenio :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="NCPorConvenio">
							<option value="{Resultado/Fila/NCPorConvenio}" selected="selected">
								<xsl:call-template name="EstadoCondiciones">
									<xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/NCPorConvenio)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Resultado/Fila/NCPorConvenio)='1'">
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/NCPorConvenio)='0'">
								<OPTION VALUE="1">SI</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/NCPorConvenio)=''">
								<OPTION VALUE="1" selected="selected">SI</OPTION>
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Nota por Oficina :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="NCPorOficina">
							<option value="{Resultado/Fila/NCPorOficina}" selected="selected">
								<xsl:call-template name="EstadoCondiciones">
									<xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/NCPorOficina)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Resultado/Fila/NCPorOficina)='1'">
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/NCPorOficina)='0'">
								<OPTION VALUE="1">SI</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/NCPorOficina)=''">
								<OPTION VALUE="1" selected="selected">SI</OPTION>
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Control de Feriados :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="ControlFeriados">
							<option value="{Resultado/Fila/ControlFeriados}" selected="selected">
								<xsl:call-template name="EstadoCondiciones">
									<xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/ControlFeriados)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Resultado/Fila/ControlFeriados)='1'">
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/ControlFeriados)='0'">
								<OPTION VALUE="1">SI</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/ControlFeriados)=''">
								<OPTION VALUE="1" selected="selected">SI</OPTION>
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Control de Fines de Semana :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="ControlFinesSemana">
							<option value="{Resultado/Fila/ControlFinesSemana}" selected="selected">
								<xsl:call-template name="EstadoCondiciones">
									<xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/ControlFinesSemana)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Resultado/Fila/ControlFinesSemana)='1'">
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/ControlFinesSemana)='0'">
								<OPTION VALUE="1">SI</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/ControlFinesSemana)=''">
								<OPTION VALUE="1" selected="selected">SI</OPTION>
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>

				<tr>
					<td class="etiqueta">Cantidad de Digitos de la NC:</td>
					<td class="detalle" colSpan="3">
						<input name="CantidadDigitosNC" value="{Resultado/Fila/CantidadDigitosNC}" size="4"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Cuenta del Colector en el Cliente:</td>
					<td class="detalle" colSpan="3">
						<input name="CuentaBanco" value="{Resultado/Fila/CuentaBanco}" size="30"/>
					</td>
				</tr>


				<tr>
					<td class="etiqueta">Reprocesa DVA :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="ReprocesaDVA">
							<option value="{Resultado/Fila/ControlFinesSemana}" selected="selected">
								<xsl:call-template name="EstadoCondiciones">
									<xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/ReprocesaDVA)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Resultado/Fila/ReprocesaDVA)='1'">
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/ReprocesaDVA)='0'">
								<OPTION VALUE="1">SI</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/ReprocesaDVA)=''">
								<OPTION VALUE="1" selected="selected">SI</OPTION>
								<OPTION VALUE="0">NO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Monto Comision FIJO:</td>
					<td class="detalle" colSpan="3">
						<input name="ComisionFija" value="{Resultado/Fila/ComisionFija}" size="18"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Porcentaje de Comision:</td>
					<td class="detalle" colSpan="3">
						<input name="FactorComision" value="{Resultado/Fila/FactorComision}" size="4"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Monto Maximo Comision:</td>
					<td class="detalle" colSpan="3">
						<input name="MontoComisionTopeMaximo" value="{Resultado/Fila/MontoComisionTopeMaximo}" size="18"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Monto Minimo Comision:</td>
					<td class="detalle" colSpan="3">
						<input name="MontoComisionTopeMinimo" value="{Resultado/Fila/MontoComisionTopeMinimo}" size="18"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Monto Maximo de Pago Tope para Comision:</td>
					<td class="detalle" colSpan="3">
						<input name="MontoPagoTopeMaximo" value="{Resultado/Fila/MontoPagoTopeMaximo}" size="18"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Monto Minimo de Pago Tope para Comision:</td>
					<td class="detalle" colSpan="3">
						<input name="MontoPagoTopeMinimo" value="{Resultado/Fila/MontoPagoTopeMinimo}" size="18"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Hora de Cierre (HH:mm:ss):</td>
					<td class="detalle" colSpan="3">
						<input name="HoraCierre" value="{Resultado/Fila/HoraCierre}" size="8"/>
					</td>
				</tr>
			</table>
			<br/>
			<div align="center">
				<input name="BotonSalvar" class="button_red" type="submit" value="      Guardar      "/>
			</div>
		</form>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="ConsultaColectores"/>
				<input type="hidden" name="Filtro" value="XML/WEBCondiciones/ConsultaColectoresNC.xsl"/>
				<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
				<input name="BotonCerrar" class="button_gris" type="submit" value="      Volver      "/>
			</form>
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
			<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      "
			       onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajasProgramas.xsl','Transaccion')"/>
		</div>
	</xsl:template>


	<xsl:template name="Estado1">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 1">Activo</xsl:when>
			<xsl:when test="$Codigo = 0">Inactivo</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Estado">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 'A'">ACTIVO</xsl:when>
			<xsl:when test="$Codigo = 'I'">INACTIVO</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="EstadoCondiciones">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = '1'">SI</xsl:when>
			<xsl:when test="$Codigo = '0'">NO</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\Gestion\ActualizarCaja.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
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