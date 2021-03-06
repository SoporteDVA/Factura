<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="variables" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		<TransformacionOutput>
			<xsl:for-each select="ImprimirMultiplesInput/IDPago">				
				<IDPago>
				    <xsl:copy-of select="../Sesion"/>
					<Oficina>
						<xsl:value-of select="substring-before(.,'+')"/>
					</Oficina>
					<xsl:variable name="UsuarioNumeroDocumentoDiaPagoIP" select="substring-after(.,'+')"/>
					<Usuario>
						<xsl:value-of select="substring-before($UsuarioNumeroDocumentoDiaPagoIP,'+')"/>
					</Usuario>
					<xsl:variable name="NumeroDocumentoDiaPagoIP" select="substring-after($UsuarioNumeroDocumentoDiaPagoIP,'+')"/>
					<NumeroDocumento>
						<xsl:value-of select="substring-before($NumeroDocumentoDiaPagoIP,'+')"/>
					</NumeroDocumento>
					<xsl:variable name="DiaPagoIP" select="substring-after($NumeroDocumentoDiaPagoIP,'+')"/>
					<DiaPago>
						<xsl:value-of select="substring-before($DiaPagoIP,'+')"/>
					</DiaPago>
					<xsl:variable name="IP" select="substring-after($DiaPagoIP,'+')"/>
					<IP>
						<xsl:value-of select="substring-before($IP,'+')"/>
					</IP>
					<IDPermiso>
						<xsl:value-of select="substring-after($IP,'+')"/>
					</IDPermiso>
				</IDPago>
			</xsl:for-each>
		</TransformacionOutput>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ToPrint.xml" htmlbaseurl="" outputurl="" processortype="internal" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator=""/></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->