<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/variables" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		<ToFlotillaOutput>
			<Vehiculos>
				<xsl:for-each select="ConsultaINSOutput/VEHICULOSPAGABLES/VEHICULO[string-length(NUMPLACA)&gt;0]">
					<Vehiculo>
						<Sesion>
							<Cliente>
								<xsl:value-of select="../../../FlotillaConsultaPreviaWSInput/Sesion/Cliente"/>
							</Cliente>
							<Usuario>
								<xsl:value-of select="../../../FlotillaConsultaPreviaWSInput/Sesion/Usuario"/>
							</Usuario>
						</Sesion>
						<Flotilla>
							<xsl:value-of select="../../../FlotillaConsultaPreviaWSInput/Flotilla"/>
						</Flotilla>
						<NumeroCaja>
							<xsl:value-of select="../../../FlotillaConsultaPreviaWSInput/NumeroCaja"/>
						</NumeroCaja>
						<NumeroLista>
							<xsl:value-of select="../../../FlotillaConsultaPreviaWSInput/NumeroLista"/>
						</NumeroLista>
						<TipoPlaca>
							<xsl:value-of select="CLASEPLACA"/>
						</TipoPlaca>
						<NumeroPlaca>
							<xsl:value-of select="NUMPLACA"/>
						</NumeroPlaca>
						<CodigoGobierno>
							<xsl:value-of select="CODGOBIERNO"/>
						</CodigoGobierno>
						<PersonaLista>
							<xsl:value-of select="NOMPERSONALISTA"/>
						</PersonaLista>
						<SOA>
							<xsl:value-of select="MONTO"/>
						</SOA>
						<PersonaVehiculo>
							<xsl:value-of select="NOMPERSONAVEHICULO"/>
						</PersonaVehiculo>
						<ImpuestoRuedo>
							<xsl:value-of select="MONIMPRUEDO"/>
						</ImpuestoRuedo>
						<Infracciones>
							<xsl:value-of select="MONINFRACCIONES"/>
						</Infracciones>
						<Estacionometros>
							<xsl:value-of select="MONESTACIONOMETROS"/>
						</Estacionometros>
						<Otros>
							<xsl:value-of select="MONOTROS"/>
						</Otros>
						<TotalPago>
							<xsl:value-of select="MONRECIBO"/>
						</TotalPago>
						<Aresep>
							<xsl:value-of select="MONARESEP"/>
						</Aresep>
						<IP>
							<xsl:value-of select="IP"/>
						</IP>
						<MsgINS>Placa pagable</MsgINS>
						<CodINS>0</CodINS>
						<Tipo>1</Tipo>
					</Vehiculo>
				</xsl:for-each>
				<xsl:for-each select="ConsultaINSOutput/VEHICULOSNOPAGABLES/VEHICULO[string-length(NUMPLACA)&gt;0]">
					<Vehiculo>
						<Cliente>
							<xsl:value-of select="../../../FlotillaConsultaPreviaWSInput/Sesion/Cliente"/>
						</Cliente>
						<Usuario>
							<xsl:value-of select="../../../FlotillaConsultaPreviaWSInput/Sesion/Usuario"/>
						</Usuario>
						<Flotilla>
							<xsl:value-of select="../../../FlotillaConsultaPreviaWSInput/Flotilla"/>
						</Flotilla>
						<NumeroCaja>
							<xsl:value-of select="../../../FlotillaConsultaPreviaWSInput/NumeroCaja"/>
						</NumeroCaja>
						<NumeroLista>
							<xsl:value-of select="../../../FlotillaConsultaPreviaWSInput/NumeroLista"/>
						</NumeroLista>
						<TipoPlaca>
							<xsl:value-of select="CLASEPLACA"/>
						</TipoPlaca>
						<NumeroPlaca>
							<xsl:value-of select="NUMPLACA"/>
						</NumeroPlaca>
						<CodigoGobierno>
							<xsl:value-of select="CODGOBIERNO"/>
						</CodigoGobierno>
						<PersonaLista>
							<xsl:value-of select="NOMPERSONALISTA"/>
						</PersonaLista>
						<SOA>
							<xsl:value-of select="MONTO"/>
						</SOA>
						<PersonaVehiculo>
							<xsl:value-of select="NOMPERSONAVEHICULO"/>
						</PersonaVehiculo>
						<ImpuestoRuedo>
							<xsl:value-of select="MONIMPRUEDO"/>
						</ImpuestoRuedo>
						<Infracciones>
							<xsl:value-of select="MONINFRACCIONES"/>
						</Infracciones>
						<Estacionometros>
							<xsl:value-of select="MONESTACIONOMETROS"/>
						</Estacionometros>
						<Otros>
							<xsl:value-of select="MONOTROS"/>
						</Otros>
						<TotalPago>
							<xsl:value-of select="MONRECIBO"/>
						</TotalPago>
						<Aresep>
							<xsl:value-of select="MONARESEP"/>
						</Aresep>
						<MonSuVida>
							<xsl:value-of select="MONARESEP"/>
						</MonSuVida>
						<MonResCivil>
							<xsl:value-of select="MONARESEP"/>
						</MonResCivil>
						<INDPOLIZASV>
							<xsl:value-of select="MONSUVIDA"/>
						</INDPOLIZASV>
						<INDPOLIZARESCIVIL>
							<xsl:value-of select="MONRESCIVIL"/>
						</INDPOLIZARESCIVIL>
						<IP>
							<xsl:value-of select="IP"/>
						</IP>
						<MsgINS>
							<xsl:if test="PROBLEMA=''">Placa no pagable</xsl:if>
							<xsl:if test="PROBLEMA!=''">
								<xsl:value-of select="PROBLEMA"/>
							</xsl:if>
						</MsgINS>
						<CodINS>1</CodINS>
						<Tipo>1</Tipo>
					</Vehiculo>
				</xsl:for-each>
			</Vehiculos>
		</ToFlotillaOutput>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2007. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="file:///c:/Users/Administrator/Desktop/Untitled2.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="" ><advancedProp name="sInitialMode" value=""/><advancedProp name="bXsltOneIsOkay" value="true"/><advancedProp name="bSchemaAware" value="true"/><advancedProp name="bXml11" value="false"/><advancedProp name="iValidation" value="0"/><advancedProp name="bExtensions" value="true"/><advancedProp name="iWhitespace" value="0"/><advancedProp name="sInitialTemplate" value=""/><advancedProp name="bTinyTree" value="true"/><advancedProp name="bWarnings" value="true"/><advancedProp name="bUseDTD" value="false"/><advancedProp name="iErrorHandling" value="fatal"/></scenario></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->