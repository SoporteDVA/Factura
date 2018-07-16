<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión de los Usuarios del Sistema</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
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
				<p align="center">

					<td width="100%">
						<font class="tituloAzulClaro">Usuarios del Sistema</font>
					</td>
				</p>
				<p>

					<form action="Transaccion.aspx" method="post">
						<input type="hidden" name="Transaccion" value="Estados"/>
						<input type="hidden" name="ServidorSTX" value="infoware.STX.Cajas"/>
						<input type="hidden" name="Filtro" value="XML/WEBUsuarios/AgregarUsuario.xsl"/>
					<div align="center">
				<input name="BotonSalvar" class="button_red" type="submit" value="      Crear Usuario      "/>
				<!--<input name="BotonSalvar" type="submit" value="      Salvar      " onclick="cargar(this,'Transaccion.aspx?Transaccion=DVAModificarCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarCaja.xsl','Transaccion')"/>-->
				<!--<input name="BtnCerrar" class="button_gris" type="button" value="      Cerrar      "
				       onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajas&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajasProgramas.xsl','Transaccion')"/>-->
			</div>
					</form>
				</p>
				<form action="--WEBBOT-SELF--" method="post">
					<p>
						<table class="tablaDetalle" align="center" border="0">
							<tfoot align="center"/>
							<tbody>
								<tr class="encabezado">
									<td align="center">
										<strong>ID</strong>
									</td>
									<td>
										<p align="center">
											<strong>Usuario</strong>
										</p>
									</td>
									
									<td>
										<p align="center">
											<strong>Nombre</strong>
										</p>
									</td>

									<td align="center">
										<strong>Estado</strong>
									</td>
									<td align="center">
										<strong>Puede Consultar</strong>
									</td>
									<td align="center">
										<strong>Puede Pagar</strong>
									</td>
									<td align="center">
										<strong>Puede Reversar</strong>
									</td>
									<td align="center">
										<strong>Puede Cerrar</strong>
									</td>
									<td align="center">
										<strong>Oficina</strong>
									</td>
								</tr>
								<xsl:for-each select="ConsultaUsuariosOutput/Resultado/Fila">
									<tr class="detalle">
										<td>
											<p align="center">
												<a>
													<xsl:attribute name="href">Transaccion.aspx?Transaccion=ConsultaUsuarios&amp;Filtro=~/XML/WEBUsuarios/ActualizarUsuario.xsl&amp;Usuario=<xsl:value-of select="Usuario"/>&amp;ID=<xsl:value-of select="ID"/></xsl:attribute>
													<xsl:value-of select="ID"/>
													<img hspace="1" src="imagenes/Proteccion.gif" align="center" border="0" alt="Administrar Perfil de Usuario"/>
												</a>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:value-of select="Usuario"/>
											</p>
										</td>
										<td>
											<p align="Left">
												<xsl:value-of select="Nombre"/>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:value-of select="Estado"/>
											</p>
										</td>

										<td class="detalle">
											<p align="center">
												<xsl:call-template name="EstadoPermiso">
													<xsl:with-param name="Codigo" select="PuedeConsultar"/>
												</xsl:call-template>
											</p>
										</td>
										<td class="detalle">
											<p align="center">
												<xsl:call-template name="EstadoPermiso">
													<xsl:with-param name="Codigo" select="PuedePagar"/>
												</xsl:call-template>
											</p>
										</td>
										<td class="detalle">
											<p align="center">
												<xsl:call-template name="EstadoPermiso">
													<xsl:with-param name="Codigo" select="PuedeReversar"/>
												</xsl:call-template>
											</p>
										</td>
										<td class="detalle">
											<p align="center">
												<xsl:call-template name="EstadoPermiso">
													<xsl:with-param name="Codigo" select="PuedeCerrar"/>
												</xsl:call-template>
											</p>
										</td>
										<td>
											<p align="center">
												<xsl:value-of select="NombreOficina"/>
											</p>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</p>

					<!--<xsl:call-template name="Botones"/>-->
				</form>
				<!--<div align="center">

				<input name="BtnCerrar" type="button" class="button_gris" value="      Volver      " onclick="cargar(this,'Transaccion.aspx?Transaccion=ConsultaCajasVirtuales&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ConsultaCajasProgramas.xsl','Transaccion')"/>
				</div>-->
				<p>&#xA0;</p>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="Botones">
		<table align="center" border="0" style="; width: 338px; height: 30px">
			<tbody>
				<tr>
					<td width="50%">
						<p align="left">
							<button onclick="AgregarCaja();">
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
	<xsl:template name="Estado">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = A">Activo</xsl:when>
			<xsl:when test="$Codigo = I">Inactivo</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="EstadoPermiso">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo = 0">NO</xsl:when>
			<xsl:when test="$Codigo = 1">SI</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\Gestion\ConsultaCajas.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
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