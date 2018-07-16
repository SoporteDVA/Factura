
<CierreCaja>
	<Original>
		<SOA_SOLIC_CIERRE_TRANSACCIONAL>
			<CODGRUPORC>81</CODGRUPORC>
			<NUMCAJARC>6000</NUMCAJARC>
			<CODRECAUDADOR>6000</CODRECAUDADOR>
			<IDENTIFICACION>Web_HSBC</IDENTIFICACION>
			<FECCIERRE>01/10/2007</FECCIERRE>
			<NUMCAJA>5009</NUMCAJA>
		</SOA_SOLIC_CIERRE_TRANSACCIONAL>
	</Original>
	<Entrada>
		<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
			<soap:Body>
				<GenerarCierreTransaccionalSOAXML xmlns="http://www.ins.go.cr/WSSOA_PAGOS/">
					<xmlInfoCierreCajaIndividual>Wnb6Km1PAMpRJWW5Yq5FnAMQFVfBQ12EtdFHIDgQzISj/tuH48gI88kNzLTMXYP71/6eA7NC6FPl1SUguziD02C2hnicskkNikz5JyA3uBqyJOIrhj5mAwgrMa2WMKObn0FU9mcR5C/xbPYg8V9yYxG9QirX6ftH2t/baObVIzbkI9weeOk1d6fjWz44OMsYWVZm1QLVzLLAe0quv+EJPXpMIr5XOXvO9npuhLAEBoKb2qDhzgZ+3kNPM2IC2nOMK7qzK4ov4UfleKCOMEZfyRxBpSynq5cAg0kIYaD17Rk7xi/iRGTWyC5PWRSaZMQ84bWhHiWKhcrhukLjH7t31Q==</xmlInfoCierreCajaIndividual>
				</GenerarCierreTransaccionalSOAXML>
			</soap:Body>
		</soap:Envelope>
	</Entrada>
	<Salida>
		<SOA_RESULT_CIERRE_TRANSACCIONAL>
			<ENCABEZADO>
				<CODGRUPORC>81</CODGRUPORC>
				<NUMCAJARC>6000</NUMCAJARC>
				<CODRECAUDADOR>6000</CODRECAUDADOR>
				<IDENTIFICACION>Web_HSBC</IDENTIFICACION>
				<NUMCAJA>5009</NUMCAJA>
				<FECCIERRE>01/10/2007</FECCIERRE>
			</ENCABEZADO>
			<COD_RESULT>6</COD_RESULT>
			<DES_RESULT>Existe alguna transaccion que no tiene un numero de comprobante asociado.</DES_RESULT>
		</SOA_RESULT_CIERRE_TRANSACCIONAL>
	</Salida>
</CierreCaja><!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios/><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->