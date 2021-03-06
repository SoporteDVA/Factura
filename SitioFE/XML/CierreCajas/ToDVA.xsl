<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/variables" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		<ToSTXOutput>
			<xsl:for-each select="ConsultaOutput/SOA_RESULT_REP_TRANSACCIONES_CAJA_INDIVIDUAL">
				<xsl:copy-of select="ENCABEZADO"/>
				<COD_RESULT>
					<xsl:value-of select="COD_RESULT"/>
				</COD_RESULT>
				<DES_RESULT>
					<xsl:value-of select="DES_RESULT"/>
				</DES_RESULT>
				<TIPOCAJA>
					<xsl:value-of select="TIPOCAJA"/>
				</TIPOCAJA>
				<DESCAJA>
					<xsl:value-of select="DESCAJA"/>
				</DESCAJA>
				<CANTCOMPROBORIG>
					<xsl:value-of select="CANTCOMPROBORIG"/>
				</CANTCOMPROBORIG>
				<CANTCOMPROBANULADOS>
					<xsl:value-of select="CANTCOMPROBANULADOS"/>
				</CANTCOMPROBANULADOS>
				<CANTCOMPROBREIMPRESOS>
					<xsl:value-of select="CANTCOMPROBREIMPRESOS"/>
				</CANTCOMPROBREIMPRESOS>
				<CANTCOMPROBRECASEG>
					<xsl:value-of select="CANTCOMPROBRECASEG"/>
				</CANTCOMPROBRECASEG>
				<CANTCOMPROBDUPLICADOS>
					<xsl:value-of select="CANTCOMPROBDUPLICADOS"/>
				</CANTCOMPROBDUPLICADOS>
				<CANTCOMPROBPERDIDOS>
					<xsl:value-of select="CANTCOMPROBPERDIDOS"/>
				</CANTCOMPROBPERDIDOS>
				<CANTCOMPROBSINPAGINSGOB>
					<xsl:value-of select="CANTCOMPROBSINPAGINSGOB"/>
				</CANTCOMPROBSINPAGINSGOB>
				<CANTCOMPROBREVCHKSINFOND>
					<xsl:value-of select="CANTCOMPROBREVCHKSINFOND"/>
				</CANTCOMPROBREVCHKSINFOND>
				<CANTCOMPROBORIGPAGOGOB>
					<xsl:value-of select="CANTCOMPROBORIGPAGOGOB"/>
				</CANTCOMPROBORIGPAGOGOB>
				<CANTCOMPROBREVERSCHKFALTCARACT>
					<xsl:value-of select="CANTCOMPROBREVERSCHKFALTCARACT"/>
				</CANTCOMPROBREVERSCHKFALTCARACT>
				<CANTCOMPROBDEVUELPAGHIST>
					<xsl:value-of select="CANTCOMPROBDEVUELPAGHIST"/>
				</CANTCOMPROBDEVUELPAGHIST>
				<CANTCOMPROBDUPLANULADOS>
					<xsl:value-of select="CANTCOMPROBDUPLANULADOS"/>
				</CANTCOMPROBDUPLANULADOS>
				<ConComprobante>
					<xsl:value-of select="count(TRANSACCIONESXTIPOCOMPROBANTE/TRANSACCION[NUMCOMPROBANTE&gt;0])"/>
				</ConComprobante>
				<INSPagosTotal>
					<xsl:value-of select="count(TRANSACCIONESXTIPOCOMPROBANTE/TRANSACCION)"/>
				</INSPagosTotal>				
				<TRANSACCIONESXTIPOCOMPROBANTE>
					<xsl:for-each select="TRANSACCIONESXTIPOCOMPROBANTE/TRANSACCION">
						<TRANSACCION>
							<NUMCAJA>
								<xsl:value-of select="../../ENCABEZADO/NUMCAJA"/>
							</NUMCAJA>
							<FECHA>
								<xsl:value-of select="../../ENCABEZADO/FECCIERRE"/>
							</FECHA>
							<TIPCAJA>
								<xsl:value-of select="../../TIPOCAJA"/>
							</TIPCAJA>
							<NUMTRANSACCION>
								<xsl:value-of select="NUMTRANSACCION"/>
							</NUMTRANSACCION>
							<NUMCOMPROBANTE>
								<xsl:value-of select="NUMCOMPROBANTE"/>
							</NUMCOMPROBANTE>
							<CLASEPLACA>
								<xsl:value-of select="CLASEPLACA"/>
							</CLASEPLACA>
							<NUMPLACA>
								<xsl:value-of select="NUMPLACA"/>
							</NUMPLACA>
							<CODGOBIERNO>
								<xsl:value-of select="CODGOBIERNO"/>
							</CODGOBIERNO>
							<MONTO>
								<xsl:value-of select="MONTO"/>
							</MONTO>
							<COMISIONNETA>
								<xsl:value-of select="COMISIONNETA"/>
							</COMISIONNETA>
							<ESTCOMPROBANTE>
								<xsl:value-of select="ESTCOMPROBANTE"/>
							</ESTCOMPROBANTE>
							<PERIODO>
								<xsl:value-of select="PERIODO"/>
							</PERIODO>
							<IP>
								<xsl:value-of select="IP"/>
							</IP>
							<DESTIPOCOMPROBANTE>
								<xsl:value-of select="../@DESTIPCOMPROBANTE"/>
							</DESTIPOCOMPROBANTE>
						</TRANSACCION>
					</xsl:for-each>
				</TRANSACCIONESXTIPOCOMPROBANTE>
			</xsl:for-each>
		</ToSTXOutput>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ToDVA.xml" htmlbaseurl="" outputurl="" processortype="internal" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator=""/></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->