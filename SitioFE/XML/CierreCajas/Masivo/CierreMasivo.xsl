<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/variables" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		<ToXMLOutput>
			<Cajas>
			<xsl:for-each select="ConsultaOutput/Cierres/Fila">
				<Caja>
					<UsuarioINS>
						<xsl:value-of select="UsuarioINS"/>
					</UsuarioINS>
					<FechaCaja>
						<xsl:value-of select="FechaCaja"/>
					</FechaCaja>
					<Recaudador>
						<xsl:value-of select="CajaRecaudador"/>
					</Recaudador>
					<NumeroCaja>
						<xsl:value-of select="NumeroCaja"/>
					</NumeroCaja>
					<Sesion>
						<Cliente>
							<xsl:value-of select="../../../EjecutarPasoPrevioInput/Sesion/Cliente"/>
						</Cliente>
						<ClienteCodigo>
							<xsl:value-of select="../../../EjecutarPasoPrevioInput/Sesion/ClienteCodigo"/>
						</ClienteCodigo>
						<ClienteCaja>
							<xsl:value-of select="../../../EjecutarPasoPrevioInput/Sesion/ClienteCaja"/>
						</ClienteCaja>
						<ClienteUsuario>
							<xsl:value-of select="../../../EjecutarPasoPrevioInput/Sesion/ClienteUsuario"/>
						</ClienteUsuario>
						<ClienteRecaudador>
							<xsl:value-of select="../../../EjecutarPasoPrevioInput/Sesion/ClienteRecaudador"/>
						</ClienteRecaudador>
						<ClienteNombre>
							<xsl:value-of select="../../../EjecutarPasoPrevioInput/Sesion/ClienteNombre"/>
						</ClienteNombre>
						<Usuario>
							<xsl:value-of select="../../../EjecutarPasoPrevioInput/Sesion/Usuario"/>
						</Usuario>
						<UsuarioNombre>
							<xsl:value-of select="../../../EjecutarPasoPrevioInput/Sesion/UsuarioNombre"/>
						</UsuarioNombre>
					</Sesion>
				</Caja>
			</xsl:for-each>
			</Cajas>
		</ToXMLOutput>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="CierreMasivo.xml" htmlbaseurl="" outputurl="" processortype="internal" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator=""/></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->