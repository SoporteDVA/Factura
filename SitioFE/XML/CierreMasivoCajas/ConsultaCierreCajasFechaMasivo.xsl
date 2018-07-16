<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    xmlns:a = "http://tempuri.org/"
    exclude-result-prefixes = "a soap"
    xmlns:soap = "http://schemas.xmlsoap.org/soap/envelope/"
    version = "1.0"
    xmlns:xsl = "http://www.w3.org/1999/XSL/Transform">
    <xsl:output method = "html"/>
    <xsl:decimal-format
        decimal-separator = "."
        grouping-separator = ","
        zero-digit = "0"/>
    <xsl:template match = "/">
        <html>
            <head>
                <title>Cierre Cajas</title>
                <script
                    src = "codigo/STUtil.js"
                    language = "javascript"
                    type = "text/javascript"/>
                <link
                    rel = "stylesheet"
                    type = "text/css"
                    href = "STEstilos.css"/>
                <script type = "text/javascript" src = "datepicker/prototype.js"></script>
                <script type = "text/javascript" src = "datepicker/scriptaculous.js"></script>
                <script type = "text/javascript" src = "datepicker/datepicker.js"></script>
                <link
                    rel = "stylesheet"
                    type = "text/css"
                    href = "datepicker/datepicker.css"/>
                <script language = "javascript">
                    function sendForm() {
                    if (document.forms[0].FechaPara.value == '') {
                    alert('Favor Indicar el día');
                    } else {
                    document.forms[0].Fecha.value = ddMMYYYY_to_YYYYMMdd(document.forms[0].FechaPara.value);
                    document.forms[0].submit()
                    }
                    }
                </script>
            </head>
            <body>
                <form action = "Transaccion.aspx" method = "post">
                    <input
                        name = "Transaccion"
                        type = "hidden"
                        value = "ConsultaCierreCajasFechas"/>
                    <input
                        name = "Filtro"
                        type = "hidden"
                        value = "XML/CierreMasivoCajas/ConsultaCierreCajasMasivo.xsl"/>
                    <input
                        type = "hidden"
                        name = "ServidorSTX"
                        value = "infoware.STX.Gestion"/>
                    <input
                        name = "Accion"
                        type = "hidden"
                        value = "Todas"/>
                    <input
                        name = "Estado"
                        type = "hidden"
                        value = "1"/>
                    <input name = "Fecha" type = "hidden"/>
                    <br/>
                    <table
                        align = "center"
                        width = "500"
                        border = "0">
                        <tr>
                            <td width = "50%">
                                <p align = "center">
                                    <img
                                        align = "baseline"
                                        src = "imagenes/cmasivo.PNG"
                                        border = "0"
                                        hspace = "0"
                                        height = "120"
                                        width = "120"/>
                                </p>
                            </td>
                            <td width = "50%">
                                <font class = "tituloAzulClaro">Cierre de Cajas Masivo</font>
                            </td>
                        </tr>
                    </table>
                    <br/>
                    <table class = "tabla" align = "center">
                        <tr>
                            <td class = "etiqueta">Seleccione el dia que desea consultar :</td>
                            <td colSpan = "3">
                                <input id = "date-from" name = "FechaPara"/>
                            </td>
                        </tr>
                    </table>
                    <p>
                        <div align = "center">
                            <input
                                name = "Reporte"
                                class = "button_gris"
                                type = "button"
                                value = "Consultar"
                                onclick = "sendForm();"/>
                        </div>
                    </p>
                </form>
                <script type = "text/javascript">
                    <!--<[CDATA[-->
                    var dpck	= new DatePicker({
                    relative	: 'date-from',
                    language	: 'sp'
                    });
                    <!--]]>-->
                </script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="ConsultaCierreCajasDetallado.xml" htmlbaseurl="192.168.1.9" outputurl="" processortype="saxon8" useresolver="yes" profilemode="4" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
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