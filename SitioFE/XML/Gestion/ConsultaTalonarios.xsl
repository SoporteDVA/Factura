<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:a="http://tempuri.org/" exclude-result-prefixes="a soap" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Gestión y Control de Talonarios</title>
				<script src="codigo/STUtil.js" language="javascript" type="text/javascript"></script>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>
				<script>function AgregarTalonario(){					
						var urlImprimir='ComponerXSL.aspx?Transaccion=AddTalonario&amp;Filtro=GCT_AddTalonario.xsl&amp;NombreCliente=<xsl:value-of select="/ConsultaTalonarios/NombreCliente"/>&amp;cli_cedula=<xsl:value-of select="/ConsultaTalonarios/cli_cedula"/>';
		 	  		    /*var winRef = window.open(urlImprimir, 'Talonario','left=20,top=20,witdh=500,height=500,toolbar=0,location=0,status=0,menubar=0,directories=0,resizable=1');		*/
						window.location=urlImprimir;
						return true;
					}</script>
			</head>
			<body>
				<p>&#xA0;</p>
				<p align="center">
					<table width="358" border="0" style="; width: 358px; height: 80px">
						<tbody>
							<tr>
								<td width="50%">
									<p align="center">
										<img hspace="0" src="imagenes/DVA.jpg" align="baseline" border="0"/>
									</p>
								</td>
								<td width="50%">
									<p align="center">
										<font class="tituloAzulClaro">
											<strong>Gestión y Control de Talonarios</strong>
										</font>
									</p>
								</td>
							</tr>
							<tr>
								<xsl:call-template name="Encabezado"/>
							</tr>
						</tbody>
					</table>
				</p>
				<p>&#xA0;</p>
				<xsl:choose>
					<xsl:when test="ConsultarTalonariosOutput">
						<xsl:for-each select="ConsultarTalonariosOutput">
							<xsl:call-template name="Botones"/>
							<xsl:call-template name="Talonarios"/>
							<xsl:call-template name="Botones"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<center>
							<h1>Se presentó un error al agregar la Caja.
								<br/>
								<xsl:value-of select="ActualizarCajasFault/Respuesta"/>
							</h1>
						</center>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="Encabezado">
		<td width="50%">
			<p align="center">
				<strong>Cliente:</strong>
			</p>
		</td>
		<td width="50%">
			<p align="center">
				<strong>
					<xsl:value-of select="/ConsultaTalonarios/Sesion/ClienteNombre"/>
				</strong>
			</p>
		</td>
	</xsl:template>
	<xsl:template name="Botones">
		<table align="center" border="0" style="; width: 438px; height: 30px">
			<tbody>
				<tr>
					<td width="50%">
						<p align="left">
							<button onclick="AgregarTalonario()">
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
	<xsl:template name="Talonarios">
		<table class="tablaDetalle" align="center" border="0">
			<tfoot align="center"/>
			<tbody>
				<tr class="encabezado">
					<td rowspan="2">
						<p align="center">
							<strong>Caja</strong>
						</p>
					</td>
					<td rowspan="2">
						<p align="center">
							<strong>Descripción</strong>
						</p>
					</td>
					<td rowspan="2" align="center">Numero Asignación</td>
					<td align="center" colspan="2">
						<strong>Comprobantes</strong>
					</td>
					<td rowspan="2" align="center">
						<strong>Estado</strong>
					</td>
					<td rowspan="2" align="center">
						<strong>Fecha de Entrega</strong>
					</td>
				</tr>
				<tr class="encabezado">
					<td align="center">
						<strong>Del</strong>
					</td>
					<td align="center">
						<strong>Hasta</strong>
					</td>
				</tr>
				<xsl:for-each select="Formularios/Fila">
					<tr class="detalle">
						<td>
							<p align="center">
								<xsl:value-of select="NumeroCaja"/>
							</p>
						</td>
						<td>
							<p align="center">
								<xsl:value-of select="Descripcion"/>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<a>
									<xsl:attribute name="href">Transaccion.aspx?Transaccion=GCT_ConsultaTalonario&amp;Talonario=<xsl:value-of select="Talonario"/></xsl:attribute>
									<xsl:value-of select="NumeroAsignacion"/>
								</a>
							</p>
						</td>
						<td class="detalle">
							<p align="right">
								<xsl:value-of select="NInicio"/>
							</p>
						</td>
						<td class="detalle">
							<p align="right">
								<xsl:value-of select="NFin"/>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:value-of select="EstadoINS"/>
							</p>
						</td>
						<td class="detalle">
							<p align="center">
								<xsl:value-of select="FechaEntrega"/>
							</p>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="CajasFormularios.xml" htmlbaseurl="" outputurl="" processortype="internal" useresolver="yes" profilemode="4" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator=""/></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no" ><SourceSchema srcSchemaPath="file:///c:/Proyectos/STX&#x2D;NET/DVANew/xml/BitacoraCJResumen.xml" srcSchemaRoot="BitacoraCJResumen" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/></MapperInfo><MapperBlockPosition><template match="/"><block path="html/body/xsl:if/=[0]" x="46" y="62"/><block path="html/body/xsl:if" x="92" y="64"/><block path="html/body/xsl:if/table/tbody/xsl:for&#x2D;each" x="52" y="64"/><block path="html/body/xsl:if/table/tbody/tr[1]/td[2]/p/strong/xsl:value&#x2D;of" x="12" y="64"/><block path="html/body/xsl:if/table/tbody/tr[1]/td[3]/p/strong/xsl:value&#x2D;of" x="92" y="24"/><block path="html/body/xsl:if[1]/=[0]" x="86" y="62"/><block path="html/body/xsl:if[1]" x="132" y="64"/></template></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->