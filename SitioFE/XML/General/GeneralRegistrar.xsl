<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="/">
    <html>
      <head>
        <script src="codigo/STUtil.js" language="javascript" type="text/javascript"/>
        <link rel="stylesheet" type="text/css" href="STEstilos.css"/>
      </head>
      <body onload="document.forms[0].NUMPLACA.focus();">
        <form action="Transaccion.aspx" method="post">
          <input type="hidden" name="Transaccion" value="ConsultarPolizaGeneral"/>
		  <input type="hidden" name="ServidorSTX" value="infoware.STX.Gestion"/>
          <input type="hidden" name="Filtro" value="XML/General/General_Page1.xsl"/>
          <br/>
          <table align="center" width="500" border="0">
            <tr>
              <td width="50%">
                <p align="center">
                  <img align="baseline" src="imagenes/ins.gif" border="0" hspace="0" height="60"/>
                </p>
              </td>
              <td width="50%">
                <font class="tituloAzulClaro">Consulta de Póliza General</font>
              </td>
            </tr>
          </table>
          <br/>
          <table class="tabla" align="center">
            <tr>
              <td class="etiqueta">Clase Placa :</td>
              <td colSpan="3" class="detalle">
                <select class="campo" name="CLASEPLACA">
                  <option value="AB">ALAJUELA BUS</option>
                  <option value="AP">ALAJUELA PÚBLICO</option>
                  <option value="BM">BICIMOTOS</option>
                  <option value="C">CARGA PESADA</option>
                  <option value="CB">CARTAGO BUS</option>
                  <option value="CL">CARGA LIVIANA</option>
                  <option value="CP">CARTAGO PÚBLICO</option>
                  <option value="EE">EQUIPO ESPECIAL</option>
                  <option value="EXP">EXPORTACIÓN</option>
                  <option value="GB">GUANACASTE BUS</option>
                  <option value="GP">GUANACASTE PÚBLICO</option>
                  <option value="HB">HEREDIA BUS</option>
                  <option value="HP">HEREDIA PÚBLICO</option>
                  <option value="LB">LIMÓN BUS</option>
                  <option value="LFP">LIMITACIONES FISICAS PERMANENTES</option>
                  <option value="LP">LIMÓN PÚBLICO</option>
                  <option value="MOT">MOTOS</option>
                  <option value="PART" selected="true">PARTICULAR</option>
                  <option value="PB">PUNTARENAS BUS</option>
                  <option value="PEN">PENSIONADOS</option>
                  <option value="PP">PUNTARENAS PÚBLICO</option>
                  <option value="SJB">SAN JOSÉ BUS</option>
                  <option value="SJP">SAN JOSÉ PÚBLICO</option>
                  <option value="TA">TAXI ALAJUELA</option>
                  <option value="TC">TAXI CARTAGO</option>
                  <option value="TG">TAXI GUANACASTE</option>
                  <option value="TH">TAXI HEREDIA</option>
                  <option value="TL">TAXI LIMÓN</option>
                  <option value="TP">TAXI PUNTARENAS</option>
                  <option value="TSJ">TAXI SAN JOSÉ</option>
		  <option value="TUR">TURISMO</option>
		  <option value="T11">TEMPORAL PERIODO 2011</option>
		  <option value="T12">TEMPORAL PERIODO 2012</option>
                  <option value="ZFE">ZONA FRANCA DE EXPORTACIÓN</option>
                </select>
              </td>
            </tr>
            <tr>
              <td class="etiqueta">Número Placa :</td>
              <td colSpan="3">
                <input size="37" name="NUMPLACA" maxlength="10" class="campo" ID="Text1"/>
              </td>
            </tr>
            <tr>
              <td class="etiqueta">Código Gobierno :</td>
              <td colSpan="3">
                <select class="campo" name="CODGOBIERNO">
                  <option value="PAR">Particular</option>
				  <option value="11">Periodo 2011</option>
				  <option value="12">Periodo 2012</option>
                </select>
              </td>
            </tr>
          </table>
          <br/>
          <br/>
          <div align="center">
            <input name="Consultar" type="button" value="Consultar" onclick="if (document.forms[0].NUMPLACA.value == '') alert('Digite el número de placa.'); else submit();" />
          </div>
        </form>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2007. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios/><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->