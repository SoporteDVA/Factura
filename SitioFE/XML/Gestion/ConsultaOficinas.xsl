<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:decimal-format decimal-separator="." grouping-separator="," zero-digit="0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión de Oficinas</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
				<script src="codigo/buttons.js" language="javascript" type="text/javascript"/>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
				<link rel="stylesheet" type="text/css" href="styles/buttons.css"/>
				<!--<link rel="stylesheet" type="text/css" href="styles/font-awesome-ie7.min.css"/>-->
				<link rel="stylesheet" type="text/css" href="styles/font-awesome.min.css"/>
				
			</head>
			<body>
				<p>&#xA0;</p>
				<p align="center">
					<table width="358" border="0" style="; width: 358px; height: 80px">
						<thead>
							<tr>
								<td width="50%">
									<p align="center">
										<img hspace="0" src="imagenes/Oficinas.PNG" align="baseline" border="0" width="100px" height="100px"/>
									</p>
								</td>
								<td width="50%">
									<p align="center">
										<font class="tituloAzulClaro">
											<strong>Gestión de Oficinas</strong>
										</font>
									</p>
								</td>
							</tr>
						</thead>
						<tbody>
							<tr class="detalle">
								<td class="encabezado" align="right">Cliente:</td>
								<td>
									<p align="center">
										<strong>
											<xsl:value-of select="ObtenerOficinasOutput/Sesion/ClienteNombre"/>
										</strong>
									</p>
								</td>
							</tr>
						</tbody>
					</table>
				</p>
				<p>
					<td>
						<div align="center">
							<input name="BtnCerrar" class="button_marchamos"  type="button" value="      CREAR OFICINA      " onclick="cargar(this,'Transaccion.aspx?Transaccion=AgregarOficina&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/AgregarOficina.xsl','Transaccion')"/>
							<!--<a href="Transaccion.aspx?Transaccion=AgregarOficina&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/AgregarOficina.xsl" class="button button-pill button-caution">CREAR</a>
						<span class="button-wrap"><a href="Transaccion.aspx?Transaccion=AgregarOficina&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/AgregarOficina.xsl" class="button button-pill ">Crear</a></span>-->
						</div>
					</td>
				</p>
				<form action="--WEBBOT-SELF--" method="post">

					<table class="tablaDetalle" align="center" border="0">
						<tfoot align="center"/>
						<tbody>
							<tr class="encabezado">
								<td>
									<p align="center">
										<strong>Oficina</strong>
									</p>
								</td>
								<td>
									<p align="center">
										<strong>Nombre</strong>
									</p>
								</td>
								<td align="center">
									<strong>Descripción</strong>
								</td>
								<td align="center">
									<strong>Estado</strong>
								</td>
							</tr>
							<xsl:for-each select="ObtenerOficinasOutput/Oficinas/Fila">
								<tr class="detalle">
									<td>
										<p align="center">
											<xsl:value-of select="ID"/>
										</p>
									</td>
									<td class="detalle">
										<p align="Left">
											<a>
												<xsl:attribute name="href">Transaccion.aspx?Transaccion=ActualizarOficina&amp;servidorSTX=infoware.STX.Admin&amp;Filtro=~/XML/Gestion/ActualizarOficina.xsl&amp;Oficina=<xsl:value-of select="ID"/></xsl:attribute>
												<xsl:value-of select="Nombre"/>
											</a>
										</p>
									</td>

									<td>
										<p align="left">
											<xsl:value-of select="Descripcion"/>
										</p>
									</td>
									<td class="detalle">
										<p align="right">
											<xsl:call-template name="Estado">
												<xsl:with-param name="Codigo" select="Estado"/>
											</xsl:call-template>
										</p>
									</td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
					<!--<xsl:call-template name="Botones"/>-->
				</form>
				<p>&#xA0;</p>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="Botones">
		<table align="center" border="0" style="; width: 338px; height: 30px">
			<tbody>
				<tr>
				
					
					
					<!--<td width="50%">
						<p align="left">
							<button onclick="AgregarOficina();">
								<div align="center">
									<strong>Agregar</strong>
								</div>
							</button>
						</p>
					</td>-->
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
			<xsl:when test="$Codigo = 1">Activo</xsl:when>
			<xsl:when test="$Codigo = 0">Inactivo</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ConsultarOficinas.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="4" profiledepth="" profilelength="" urlprofilexml=""
		          commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
			<SourceSchema srcSchemaPath="..\..\..\Proyectos\STX-NET\DVANew\xml\BitacoraCJResumen.xml" srcSchemaRoot="BitacoraCJResumen" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
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