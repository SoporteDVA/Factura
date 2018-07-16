<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    version = "1.0"
    xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
    xmlns:NonHtml = "http://www.progress.com/StylusStudio/NonHtml"
    exclude-result-prefixes = "NonHtml">
    <xsl:output method = "html"/>
    <xsl:template match = "/">
        <html>
            <head>
                <title>Bitácora</title>
                <link
                    rel = "stylesheet"
                    type = "text/css"
                    href = "STEstilos.css"/>
					<script
                              type = "text/javascript"
                              src = "excel.js">
							  
                        </script>
            </head>
            <body>
                <xsl:choose>
                    <xsl:when test = "BitacoraNGResumenFechaOficinaOutput">
                        <xsl:for-each select = "BitacoraNGResumenFechaOficinaOutput">
                            <xsl:call-template name = "BitacoraOutput"/>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <center>
                            <h1>
                                <br/>
                                <br/>
                                <xsl:value-of select = "BitacoraNGResumenFechaOficinaFault/Mensaje"/>
                            </h1>
                        </center>
                        <div align = "center">
                            <form action = "Transaccion.aspx">
                                <input
                                    type = "hidden"
                                    name = "Transaccion"
                                    value = "ConsultaOficinas"/>
                                <input
                                    type = "hidden"
                                    name = "Filtro"
                                    value = "XML/Cambios2014/ParametrosFechaOficinaNGResumen.xsl"/>
                                <input
                                    type = "hidden"
                                    name = "ServidorSTX"
                                    value = "infoware.STX.Gestion"/>
                                <input
                                    name = "BotonCerrar"
                                    class = "button_gris"
                                    type = "submit"
                                    value = "      Volver      "/>
                            </form>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
	<xsl:template name="BitacoraOutput">
        <p>
            <p/>
            <div align = "center">
                <font class = "tituloAzulClaro">Resumen de Pagos por Rango de Fechas y Oficina</font>
            </div>
            <div align = "center"/>
			
			<br/>

            <div align = "center">
			 
			<!--<input  class="button" type="button" onclick="tableToExcel('testTable', 'Tabla')" value="Exportar a Excel"/>-->
			 
                <table id="testTable" class = "tabla" align = "center">
				
                    <tbody>
                        <tr>
                            <td class = "etiqueta">Fecha</td>
                            <td class = "etiqueta">Oficina</td>
                            <td class = "etiqueta">Monto</td>
                            <td class = "etiqueta">Comision</td>
                            <td class = "etiqueta">Impresos</td>
                            <td class = "etiqueta">Sin Imprimir</td>
                            <td class = "etiqueta">Reversados</td>
                            <td class = "etiqueta">Error</td>
                            <td class = "etiqueta">Pendientes</td>
                            <td class = "etiqueta">Devolución</td>
                            <td class = "etiqueta">AConciliar</td>
                        </tr>
                        <xsl:for-each select = "Resultado/Fila">
                            <tr>
                                <td class = "detalle">
                                    <a href = "Transaccion.aspx?Transaccion=BitacoraNGResumen&amp;ServidorSTX=infoware.STX.Gestion&amp;Fecha={concat(substring(Fecha,7,4),concat(substring(Fecha,3,4),substring(Fecha,1,2)))}&amp;Filtro=XML/Bitacora/NGResumenUnaFecha.xsl">
                                        <xsl:value-of select = "Fecha"/>
                                    </a>
                                </td>
                                <td class = "detalle">
                                    <a href = "Transaccion.aspx?Transaccion=BitacoraOOResumen&amp;ServidorSTX=infoware.STX.Gestion&amp;OficinaConsultada={CodigoOficina}&amp;Filtro=XML/Bitacora/OOResumen.xsl">
                                        <xsl:value-of select = "Oficina"/>
                                    </a>
                                </td>
                                <td class = "detalleNumerico">
                                  
                                    <xsl:value-of select = "format-number(Monto,'###,###,###,##0')"/>
                                </td>
                                <td class = "detalleNumerico">
                                   
                                    <xsl:value-of select = "format-number(Comision,'###,###,###,##0')"/>
                                </td>
                                <td class = "detalleNumerico">
                                    <xsl:value-of select = "NumeroPagos"/>
                                </td>
                                <td class = "detalleNumerico">
                                    <xsl:value-of select = "PagosSinImprimir"/>
                                </td>
                                <td class = "detalleNumerico">
                                    <xsl:value-of select = "Reversados"/>
                                </td>
                                <td class = "detalleNumerico">
                                    <xsl:value-of select = "ConError"/>
                                </td>
                                <td class = "detalleNumerico">
                                    <xsl:value-of select = "Pendientes"/>
                                </td>
                                <td class = "detalleNumerico">
                                    
                                    <xsl:value-of select = "format-number(MAConciliar,'###,###,###,##0')"/>
                                </td>
                                <td class = "detalleNumerico">
                                    <xsl:value-of select = "AConciliar"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                        <tr>
                            <td class = "detalle"/>
                            <td class = "detalle">
                                Total
                                <strong><![CDATA[ ]]></strong>
                            </td>
                            <td class = "detalleNumerico">
                              
                                <xsl:value-of select = "format-number(sum(Resultado/Fila/Monto),'###,###,###,##0')"/>
                            </td>
                            <td class = "detalleNumerico">
                             
                                <xsl:value-of select = "format-number(sum(Resultado/Fila/Comision),'###,###,###,##0')"/>
                            </td>
                            <td class = "detalleNumerico">
                                <xsl:value-of select = "sum(Resultado/Fila/NumeroPagos)"/>
                            </td>
                            <td class = "detalleNumerico">
                                <xsl:value-of select = "sum(Resultado/Fila/PagosSinImprimir)"/>
                            </td>
                            <td class = "detalleNumerico">
                                <xsl:value-of select = "sum(Resultado/Fila/Reversados)"/>
                            </td>
                            <td class = "detalleNumerico">
                                <xsl:value-of select = "sum(Resultado/Fila/ConError)"/>
                            </td>
                            <td class = "detalleNumerico">
                                <xsl:value-of select = "sum(Resultado/Fila/Pendientes)"/>
                            </td>
                            <td class = "detalleNumerico">
                                <xsl:value-of select = "format-number(sum(Resultado/Fila/MAConciliar),'###,###,###,##0')"/>
                            </td>
                            <td class = "detalleNumerico">
                                <xsl:value-of select = "sum(Resultado/Fila/AConciliar)"/>
                            </td>
                        </tr>
                    </tbody>
					
                </table>
				
            </div>
			
        </p>
    </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\Bitacora\BitacoraNGResumen.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength=""
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