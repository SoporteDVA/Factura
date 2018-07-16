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
							<font class="tituloAzulClaro">Gestión del Convenio</font>
						</td>
					</tr>
				</table>
				<xsl:choose>
					<xsl:when test="ConsultaConveniosOutput">
						<xsl:for-each select="ConsultaConveniosOutput">
							<xsl:call-template name="ConsultaOutput"/>
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
	<xsl:template name="ConsultaOutput">
		<table class="tabla" align="center">
			<tr>
				<td class="etiqueta">Cliente:</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/Fila/Cliente"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Codigo Sistema:</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/Fila/ID"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Codigo Alterno (Banco):</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/Fila/IDAlterno"/>
				</td>
			</tr>
			<tr>
				<td class="etiqueta">Colector:</td>
				<td class="detalle">
					<xsl:value-of select="Resultado/Fila/Colector"/>
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
			<input type="hidden" name="Transaccion" value="AgregaModificaConvenios"/>
			<input type="hidden" name="Filtro" value="XML/WEBConvenios/ConsultaConvenios.xsl"/>
			<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
			<input type="hidden" name="ID" value="{Resultado/Fila/ID}"/>
			<!-- Revisar estos valores -->
			<!-- -->
			<div align="center" class="tituloAzulClaro">Editar Convenio</div>

			<table align="center" class="tabla">
				<!--<tr>
					<td class="etiqueta">ID :</td>
					<td class="detalle" colSpan="3">
						<input name="CodigoPlan" size="15" value="{Resultado/Fila/ID}" onkeypress="return soloNumeros(event)" maxlength="2">
						</input>
					</td>
				</tr>-->
				<!--<tr>
					<td class="etiqueta">Numero Caja :</td>
					<td class="detalle" colSpan="3">
						<input name="NumeroCaja" value="{Fila/NumeroCaja}" size="15"/>
					</td>
				</tr>-->
				<tr>
					<td class="etiqueta">Descripcion :</td>
					<td class="detalle" colSpan="3">
						<input name="Descripcion" value="{Resultado/Fila/Descripcion}" size="50"/>
					</td>
				</tr>
				<!--<tr>
					<td class="etiqueta">Tipo :</td>
					<td class="detalle" colSpan="3">
						<input name="Tipo" value="{Fila/Tipo}" size="15" maxlength="2"/>
					</td>
				</tr>-->
				<tr>
					<td class="etiqueta">Estado :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Estado">
							<option value="{Resultado/Fila/Estado}" selected="selected">
								<xsl:call-template name="Estado">
									<xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/Estado)"/>
								</xsl:call-template>
							</option>
							<xsl:if test="normalize-space(Resultado/Fila/Estado)='A'">
								<OPTION VALUE="I">INACTIVO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/Estado)='I'">
								<OPTION VALUE="A">ACTIVO</OPTION>
							</xsl:if>
							<xsl:if test="normalize-space(Resultado/Fila/Estado)=''">
								<OPTION VALUE="A" selected="selected">ACTIVO</OPTION>
								<OPTION VALUE="I">INACTIVO</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>
        <tr>
          <td class="etiqueta">CobroTardio :</td>
          <td colspan="3" class="detalle">
            <SELECT class="inputAzul" NAME="CobroTardio">
              <option value="{Resultado/Fila/CobroTardio}" selected="selected">
                <xsl:call-template name="CobroTardio">
                  <xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/CobroTardio)"/>
                </xsl:call-template>
              </option>
              <xsl:if test="normalize-space(Resultado/Fila/CobroTardio)='S'">
                <OPTION VALUE="N">NO</OPTION>
              </xsl:if>
              <xsl:if test="normalize-space(Resultado/Fila/CobroTardio)='N'">
                <OPTION VALUE="S">SI</OPTION>
              </xsl:if>
              <xsl:if test="normalize-space(Resultado/Fila/CobroTardio)=''">
                <OPTION VALUE="" selected="selected">--SELECCIONE--</OPTION>
				<OPTION VALUE="S">SI</OPTION>
                <OPTION VALUE="N">NO</OPTION>
              </xsl:if>
            </SELECT>
          </td>
        </tr>
<tr>
          <td class="etiqueta">Moneda :</td>
          <td colspan="3" class="detalle">
            <SELECT class="inputAzul" NAME="Moneda">
              <option value="{Resultado/Fila/Moneda}" selected="selected">
                <xsl:call-template name="Moneda">
                  <xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/Moneda)"/>
                </xsl:call-template>
              </option>
              <xsl:if test="normalize-space(Resultado/Fila/Moneda)='COL'">
				<OPTION VALUE="DOL">DOLARES</OPTION>
				<OPTION VALUE="EUR">EUROS</OPTION>
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/Moneda)='DOL'">
				<OPTION VALUE="COL">COLONES</OPTION>
				<OPTION VALUE="EUR">EUROS</OPTION>
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/Moneda)='EUR'">
				<OPTION VALUE="COL">COLONES</OPTION>
				<OPTION VALUE="DOL">DOLARES</OPTION>
				</xsl:if>

              <xsl:if test="normalize-space(Resultado/Fila/Moneda)=''">
                <OPTION VALUE="" selected="selected">--SELECCIONE--</OPTION>
				<OPTION VALUE="COL">COLONES</OPTION>
                <OPTION VALUE="DOL">DOLARES</OPTION>
				<OPTION VALUE="EUR">EUROS</OPTION>
              </xsl:if>
            </SELECT>
          </td>
        </tr>

		<tr>
          <td class="etiqueta">Periodo :</td>
          <td colspan="3" class="detalle">
            <SELECT class="inputAzul" NAME="Periodo">
              <option value="{Resultado/Fila/Periodo}" selected="selected">
                <xsl:call-template name="Periodo">
                  <xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/Periodo)"/>
                </xsl:call-template>
              </option>
              <xsl:if test="normalize-space(Resultado/Fila/Periodo)='1'">
				<OPTION VALUE="2">ANUAL</OPTION>
				<OPTION VALUE="3">TRIMESTRAL</OPTION>
				<OPTION VALUE="4">DIARIA</OPTION>
				<OPTION VALUE="5">SEMANAL</OPTION>
				<OPTION VALUE="6">CUATRIMESTRE</OPTION>
				<OPTION VALUE="7">SEMESTRE</OPTION>
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/Periodo)='2'">
				<OPTION VALUE="1">MENSUAL</OPTION>
				<OPTION VALUE="3">TRIMESTRAL</OPTION>
				<OPTION VALUE="4">DIARIA</OPTION>
				<OPTION VALUE="5">SEMANAL</OPTION>
				<OPTION VALUE="6">CUATRIMESTRE</OPTION>
				<OPTION VALUE="7">SEMESTRE</OPTION>
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/Periodo)='3'">
				<OPTION VALUE="1">MENSUAL</OPTION>
				<OPTION VALUE="2">ANUAL</OPTION>
				<OPTION VALUE="4">DIARIA</OPTION>
				<OPTION VALUE="5">SEMANAL</OPTION>
				<OPTION VALUE="6">CUATRIMESTRE</OPTION>
				<OPTION VALUE="7">SEMESTRE</OPTION>
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/Periodo)='4'">
				<OPTION VALUE="1">MENSUAL</OPTION>
				<OPTION VALUE="2">ANUAL</OPTION>
				<OPTION VALUE="3">TRIMESTRAL</OPTION>
				<OPTION VALUE="5">SEMANAL</OPTION>
				<OPTION VALUE="6">CUATRIMESTRE</OPTION>
				<OPTION VALUE="7">SEMESTRE</OPTION>
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/Periodo)='5'">
				<OPTION VALUE="1">MENSUAL</OPTION>
				<OPTION VALUE="2">ANUAL</OPTION>
				<OPTION VALUE="3">TRIMESTRAL</OPTION>
				<OPTION VALUE="4">DIARIA</OPTION>
				<OPTION VALUE="6">CUATRIMESTRE</OPTION>
				<OPTION VALUE="7">SEMESTRE</OPTION>
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/Periodo)='6'">
				<OPTION VALUE="1">MENSUAL</OPTION>
				<OPTION VALUE="2">ANUAL</OPTION>
				<OPTION VALUE="3">TRIMESTRAL</OPTION>
				<OPTION VALUE="4">DIARIA</OPTION>
				<OPTION VALUE="5">SEMANAL</OPTION>
				<OPTION VALUE="7">SEMESTRE</OPTION>
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/Periodo)='7'">
				<OPTION VALUE="1">MENSUAL</OPTION>
				<OPTION VALUE="2">ANUAL</OPTION>
				<OPTION VALUE="3">TRIMESTRAL</OPTION>
				<OPTION VALUE="4">DIARIA</OPTION>
				<OPTION VALUE="5">SEMANAL</OPTION>
				<OPTION VALUE="6">CUATRIMESTRE</OPTION>
				</xsl:if>
				

              <xsl:if test="normalize-space(Resultado/Fila/Periodo)=''">
                <OPTION VALUE="" selected="selected">--SELECCIONE--</OPTION>
				<OPTION VALUE="1">MENSUAL</OPTION>
                <OPTION VALUE="2">ANUAL</OPTION>
				<OPTION VALUE="3">TRIMESTRAL</OPTION>
				<OPTION VALUE="4">DIARIA</OPTION>
				<OPTION VALUE="5">SEMANAL</OPTION>
				<OPTION VALUE="6">CUATRIMESTRE</OPTION>
				<OPTION VALUE="7">SEMESTRE</OPTION>
              </xsl:if>
			  <xsl:if test="normalize-space(Resultado/Fila/Periodo)='0'">
                <OPTION VALUE="1" selected="selected">MENSUAL</OPTION>
                <OPTION VALUE="2">ANUAL</OPTION>
				<OPTION VALUE="3">TRIMESTRAL</OPTION>
				<OPTION VALUE="4">DIARIA</OPTION>
				<OPTION VALUE="5">SEMANAL</OPTION>
				<OPTION VALUE="6">CUATRIMESTRE</OPTION>
				<OPTION VALUE="7">SEMESTRE</OPTION>
              </xsl:if>
            </SELECT>
          </td>
        </tr>
<tr>
          <td class="etiqueta">TipoPago :</td>
          <td colspan="3" class="detalle">
            <SELECT class="inputAzul" NAME="TipoPago">
              <option value="{Resultado/Fila/TipoPago}" selected="selected">
                <xsl:call-template name="TipoPago">
                  <xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/TipoPago)"/>
                </xsl:call-template>
              </option>
              <xsl:if test="normalize-space(Resultado/Fila/TipoPago)='MontoExacto'">
				<OPTION VALUE="C">CUALQUIER MONTO</OPTION>
				<OPTION VALUE="M">PUEDE PAGAR MONTOS MAYORES</OPTION>
				<OPTION VALUE="N">PUEDE PAGAR MONTOS MENORES</OPTION>
				<OPTION VALUE="X">PUEDE PAGAR MONTOS EN RECIBOS FIJOS PREPAGO</OPTION>
				<OPTION VALUE="Y">PUEDE PAGAR CUALQUIER MONTO PREPAGO</OPTION>
		
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/TipoPago)='CualquierMonto'">
				<OPTION VALUE="MontoExacto">MONTO EXACTO</OPTION>
				<OPTION VALUE="M">PUEDE PAGAR MONTOS MAYORES</OPTION>
				<OPTION VALUE="N">PUEDE PAGAR MONTOS MENORES</OPTION>
				<OPTION VALUE="X">PUEDE PAGAR MONTOS EN RECIBOS FIJOS PREPAGO</OPTION>
				<OPTION VALUE="Y">PUEDE PAGAR CUALQUIER MONTO PREPAGO</OPTION>
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/TipoPago)='MontosMayores'">
				<OPTION VALUE="E">MONTO EXACTO</OPTION>
				<OPTION VALUE="C">CUALQUIER MONTO</OPTION>
				<OPTION VALUE="N">PUEDE PAGAR MONTOS MENORES</OPTION>
				<OPTION VALUE="X">PUEDE PAGAR MONTOS EN RECIBOS FIJOS PREPAGO</OPTION>
				<OPTION VALUE="Y">PUEDE PAGAR CUALQUIER MONTO PREPAGO</OPTION>
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/TipoPago)='MontosMenores'">
				<OPTION VALUE="E">MONTO EXACTO</OPTION>
				<OPTION VALUE="C">CUALQUIER MONTO</OPTION>
				<OPTION VALUE="M">PUEDE PAGAR MONTOS MAYORES</OPTION>
				<OPTION VALUE="X">PUEDE PAGAR MONTOS EN RECIBOS FIJOS PREPAGO</OPTION>
				<OPTION VALUE="Y">PUEDE PAGAR CUALQUIER MONTO PREPAGO</OPTION>
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/TipoPago)='X'">
				<OPTION VALUE="E">MONTO EXACTO</OPTION>
				<OPTION VALUE="C">CUALQUIER MONTO</OPTION>
				<OPTION VALUE="M">PUEDE PAGAR MONTOS MAYORES</OPTION>
				<OPTION VALUE="N">PUEDE PAGAR MONTOS MENORES</OPTION>
				<OPTION VALUE="Y">PUEDE PAGAR CUALQUIER MONTO PREPAGO</OPTION>
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/TipoPago)='Y'">
				<OPTION VALUE="E">MONTO EXACTO</OPTION>
				<OPTION VALUE="C">CUALQUIER MONTO</OPTION>
				<OPTION VALUE="M">PUEDE PAGAR MONTOS MAYORES</OPTION>
				<OPTION VALUE="N">PUEDE PAGAR MONTOS MENORES</OPTION>
				<OPTION VALUE="X">PUEDE PAGAR MONTOS EN RECIBOS FIJOS PREPAGO</OPTION>
				</xsl:if>
				<xsl:if test="normalize-space(Resultado/Fila/TipoPago)=''">
				<OPTION VALUE="" selected="selected">--SELECCIONE--</OPTION>
				<OPTION VALUE="E">MONTO EXACTO</OPTION>
				<OPTION VALUE="C">CUALQUIER MONTO</OPTION>
				<OPTION VALUE="M">PUEDE PAGAR MONTOS MAYORES</OPTION>
				<OPTION VALUE="N">PUEDE PAGAR MONTOS MENORES</OPTION>
				<OPTION VALUE="X">PUEDE PAGAR MONTOS EN RECIBOS FIJOS PREPAGO</OPTION>
				</xsl:if>
				
              </SELECT>
            </td>
        </tr>

<tr>
          <td class="etiqueta">ValidarAntiguedad :</td>
          <td colspan="3" class="detalle">
            <SELECT class="inputAzul" NAME="ValidarAntiguedad">
              <option value="{Resultado/Fila/ValidarAntiguedad}" selected="selected">
                <xsl:call-template name="ValidarAntiguedad">
                  <xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/ValidarAntiguedad)"/>
                </xsl:call-template>
              </option>
              <xsl:if test="normalize-space(Resultado/Fila/ValidarAntiguedad)='S'">
                <OPTION VALUE="N">NO</OPTION>
              </xsl:if>
              <xsl:if test="normalize-space(Resultado/Fila/ValidarAntiguedad)='N'">
                <OPTION VALUE="S">SI</OPTION>
              </xsl:if>
              <xsl:if test="normalize-space(Resultado/Fila/ValidarAntiguedad)=''">
                <OPTION VALUE="" selected="selected">--SELECCIONE--</OPTION>
				<OPTION VALUE="S">SI</OPTION>
                <OPTION VALUE="N">NO</OPTION>
              </xsl:if>
            </SELECT>
          </td>
        </tr>

		<tr>
          <td class="etiqueta">Esquema :</td>
          <td colspan="3" class="detalle">
            <SELECT class="inputAzul" NAME="Esquema">
              <option value="{Resultado/Fila/Esquema}" selected="selected">
                <xsl:call-template name="Esquema">
                  <xsl:with-param name="Codigo" select="normalize-space(Resultado/Fila/Esquema)"/>
                </xsl:call-template>
              </option>
              <xsl:if test="normalize-space(Resultado/Fila/Esquema)='1'">
                <OPTION VALUE="2">RN</OPTION>
                <OPTION VALUE="3">LOCAL</OPTION>
              </xsl:if>
              <xsl:if test="normalize-space(Resultado/Fila/Esquema)='2'">
                <OPTION VALUE="1">ADN</OPTION>
                <OPTION VALUE="3">LOCAL</OPTION>
              </xsl:if>
              <xsl:if test="normalize-space(Resultado/Fila/Esquema)='3'">
                <OPTION VALUE="1">ADN</OPTION>
                <OPTION VALUE="2">RN</OPTION>
              </xsl:if>
              <xsl:if test="normalize-space(Resultado/Fila/Esquema)=''">
			    <OPTION VALUE="" selected="selected">--SELECCIONE ESQUEMA--</OPTION>
                <OPTION VALUE="1">ADN</OPTION>
                <OPTION VALUE="2">RN</OPTION>
                <OPTION VALUE="3">LOCAL</OPTION>
              </xsl:if>
            </SELECT>
          </td>
        </tr>
				<!--<tr>
					<td class="etiqueta">Tipo CAJA BAC :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="TIPO_CAJA">
							<option value="{Fila/tipo_caja}" selected="selected">
								<xsl:call-template name="TipoCajaBAC">
									<xsl:with-param name="TipoCaja" select="Fila/tipo_caja"/>
								</xsl:call-template>
							</option>
							<xsl:if test="Fila/tipo_caja=2">
								<OPTION VALUE="1">Regular</OPTION>
								
							</xsl:if>
							<xsl:if test="Fila/tipo_caja=1">
								<OPTION VALUE="2">Virtual</OPTION>
								
							</xsl:if>
							<xsl:if test="Fila/tipo_caja=''">
								<OPTION VALUE="1" selected="selected">Regular</OPTION>
								<OPTION VALUE="2">Virtual</OPTION>
								
							</xsl:if>
						</SELECT>
					</td>
				</tr>-->


				<!--<tr>
					<td class="etiqueta">Plazo en Meses :</td>
					<td class="detalle" colSpan="3">
						<input name="PlazoMeses" value="{Fila/PlazoMeses}" size="15" maxlength="15"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Factor :</td>
					<td class="detalle" colSpan="3">
						<input name="Factor" value="{Fila/Factor}" size="15" maxlength="15"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Afiliado :</td>
					<td class="detalle" colSpan="3">
						<input name="NumeroAfiliado" value="{Fila/NumeroAfiliado}" size="15" maxlength="15"/>
					</td>
				</tr>

				<tr>
					<td class="etiqueta">Terminal :</td>
					<td class="detalle" colSpan="3">
						<input name="NumeroTerminal" value="{Fila/NumeroTerminal}" size="15" maxlength="15"/>
					</td>
				</tr>
				<tr>
					<td class="etiqueta">Estado :</td>
					<td colspan="3" class="detalle">
						<SELECT class="inputAzul" NAME="Estado">
							<option value="{Fila/Estado}" selected="selected">
								<xsl:call-template name="Estado">
									<xsl:with-param name="Codigo" select="Fila/Estado"/>
								</xsl:call-template>
							</option>
							<xsl:if test="Fila/Estado=0">
								<OPTION VALUE="1">Activo</OPTION>
							</xsl:if>
							<xsl:if test="Fila/Estado=1">
								<OPTION VALUE="0">Inactivo</OPTION>
							</xsl:if>
							<xsl:if test="Fila/Estado=''">
								<OPTION VALUE="1" selected="selected">Activo</OPTION>
								<OPTION VALUE="0">Inactivo</OPTION>
							</xsl:if>
						</SELECT>
					</td>
				</tr>-->
			</table>
			<br/>
			<div align="center">
				<input name="BotonSalvar" class="button_red" type="submit" value="      Guardar      "/>
				<!--<input name="BotonSalvar" type="submit" value="      Salvar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=DVAModificarCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarCaja.xsl','Transaccion')"/>-->
				<!--<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      "
				       onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajasProgramas.xsl','Transaccion')"/>-->
			</div>
		</form>
		<div align="center">
			<form action="Transaccion.aspx">
				<input type="hidden" name="Transaccion" value="ConsultaConvenios"/>
				<input type="hidden" name="Filtro" value="XML/WEBConvenios/ConsultaConvenios.xsl"/>
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
  
  <xsl:template name="CobroTardio">
    <xsl:param name="Codigo" select="."/>
    <xsl:choose>
      <xsl:when test="$Codigo = 'S'">SI</xsl:when>
      <xsl:when test="$Codigo = 'N'">NO</xsl:when>
    </xsl:choose>
  </xsl:template>
   <xsl:template name="Moneda">
    <xsl:param name="Codigo" select="."/>
    <xsl:choose>
      <xsl:when test="$Codigo = 'COL'">COLONES</xsl:when>
      <xsl:when test="$Codigo = 'DOL'">DOLARES</xsl:when>
	  <xsl:when test="$Codigo = 'EUR'">EUROS</xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="Periodo">
    <xsl:param name="Codigo" select="."/>
    <xsl:choose>
      <xsl:when test="$Codigo = '1'">MENSUAL</xsl:when>
      <xsl:when test="$Codigo = '2'">ANUAL</xsl:when>
	  <xsl:when test="$Codigo = '3'">TRIMESTRAL</xsl:when>
	  <xsl:when test="$Codigo = '4'">DIARIA</xsl:when>
      <xsl:when test="$Codigo = '5'">SEMANAL</xsl:when>
	  <xsl:when test="$Codigo = '6'">CUATRIMESTRE</xsl:when>
	  <xsl:when test="$Codigo = '7'">SEMESTRE</xsl:when>
	  
    </xsl:choose>
  </xsl:template>
  <xsl:template name="TipoPago">
    <xsl:param name="Codigo" select="."/>
    <xsl:choose>
      <xsl:when test="$Codigo = 'MontoExacto'">MONTO EXACTO</xsl:when>
      <xsl:when test="$Codigo = 'CualquierMonto'">CUALQUIER MONTO</xsl:when>
	  <xsl:when test="$Codigo = 'MontosMayores'">PUEDE PAGAR MONTOS MAYORES</xsl:when>
	  <xsl:when test="$Codigo = 'MontosMenores'">PUEDE PAGAR MONTOS MENORES</xsl:when>
      <xsl:when test="$Codigo = 'X'">PUEDE PAGAR MONTOS EN RECIBOS FIJOS PREPAGOS</xsl:when>
	  <xsl:when test="$Codigo = 'Y'">PUEDE PAGAR CUALQUIER MONTO PREPAGO</xsl:when>
	   
    </xsl:choose>
  </xsl:template>

  <xsl:template name="ValidarAntiguedad">
    <xsl:param name="Codigo" select="."/>
    <xsl:choose>
      <xsl:when test="$Codigo = 'S'">SI</xsl:when>
      <xsl:when test="$Codigo = 'N'">NO</xsl:when>
    </xsl:choose>
	</xsl:template>

	<xsl:template name="Esquema">
    <xsl:param name="Codigo" select="."/>
    <xsl:choose>
      <xsl:when test="$Codigo = '1'">ADN</xsl:when>
      <xsl:when test="$Codigo = '2'">RN</xsl:when>
      <xsl:when test="$Codigo = '3'">LOCAL</xsl:when>
    </xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\Respaldo\Recaudacion\XML\Gestion\ActualizarCaja.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator="">
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