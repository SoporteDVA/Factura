<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:NonHtml="http://www.progress.com/StylusStudio/NonHtml" exclude-result-prefixes="NonHtml">
	<xsl:output method="html"/>

	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="STEstilos.css"/>

				<link rel="stylesheet" type="text/css" href="jquery.dataTables.css"/>
				<link href="jquery-ui.css" rel="stylesheet" type="text/css"/>
				<link href="jquery.datatables.yadcf.css" rel="stylesheet" type="text/css"/>
				<script src="jquery.min.js"></script>
				<script src="jquery-ui.min.js"></script>
				<script type="text/javascript" charset="utf8" src="jquery.dataTables.min.js"></script>
				<script src="jquery.dataTables.yadcf.js"></script>
				<style type="text/css">body {
     	font-family:Century Gothic;
        font-size:12px;
        font-weight:bold; }</style>

				<style>.label {
  padding: 0px 10px 0px 10px;
	border: 1px solid #ccc;
	-moz-border-radius: 1em; /* for mozilla-based browsers */
	-webkit-border-radius: 1em; /* for webkit-based browsers */
	border-radius: 1em; /* theoretically for *all* browsers*/
	
}

.label.lightblue {
	background-color: #99CCFF;
}

#external_filter_container_wrapper {
  margin-bottom: 20px;
}

#external_filter_container {
  display: inline-block;
}</style>

				<script>$(document).ready(function(){
  $('#pagos').dataTable().yadcf([
		{column_number : 0},
	    {column_number : 1,  filter_type: "range_number", filter_container_id: "external_filter_container"},
	    {column_number : 2, data: ["Yes", "No"], filter_default_label: "Select Yes/No"},
	    {column_number : 3, text_data_delimiter: ",", filter_type: "auto_complete"},
	    {column_number : 4, column_data_type: "html", html_data_type: "text", filter_default_label: "Select tag"}]);
});</script>
			</head>
			<body>

				<!--<div id="container">

					<div id="external_filter_container_wrapper">
						<label>External filter for "Numbers" column :</label>
						<div id="external_filter_container"></div>
					</div>
					<table cellpadding="0" cellspacing="0" border="0" class="display" id="example2">
						<thead>
							<tr>
								<th>Some Data</th>
								<th>Numbers</th>
								<th>Yes / No</th>
								<th>Values</th>
								<th>Tags</th>
							</tr>
						</thead>
						<tbody>
							<tr class="odd gradeX">
								<td>Some Data 1</td>
								<td>1000</td>
								<td>Yes</td>
								<td>a_value,b_value</td>
								<td>
									<span class="label lightblue">Tag1</span>
									<span class="label lightblue">Tag2</span>
								</td>
							</tr>
							<tr class="even gradeC">
								<td>Some Data 2</td>
								<td>22</td>
								<td>No</td>
								<td>b_value,c_value</td>
								<td>
									<span class="label lightblue">Tag1</span>
									<span class="label lightblue">Tag3</span>
								</td>
							</tr>
							<tr class="odd gradeA">
								<td>Some Data 3</td>
								<td>33</td>
								<td>Yes</td>
								<td>a_value</td>
								<td>
									<span class="label lightblue">Tag2</span>
									<span class="label lightblue">Tag3</span>
								</td>
							</tr>
							<tr class="even gradeA">
								<td>Some Data 4</td>
								<td>44</td>
								<td>No</td>
								<td>b_value</td>
								<td>
									<span class="label lightblue">Tag2</span>
								</td>
							</tr>
							<tr class="odd gradeA">
								<td>Some Data 5</td>
								<td>55</td>
								<td>Yes</td>
								<td>a_value,b_value</td>
								<td>
									<span class="label lightblue">Tag1</span>
									<span class="label lightblue">Tag2</span>
								</td>
							</tr>
							<tr class="even gradeA">
								<td>Some Data 1</td>
								<td>111</td>
								<td>No</td>
								<td>c_value,d_value</td>
								<td>
									<span class="label lightblue">Tag2</span>
								</td>
							</tr>
							<tr class="gradeA">
								<td>Some Data 2</td>
								<td>22</td>
								<td>Yes</td>
								<td>e_value,f_value</td>
								<td>
									<span class="label lightblue">Tag3</span>
									<span class="label lightblue">Tag4</span>
									<span class="label lightblue">Tag5</span>
								</td>
							</tr>
							<tr class="gradeA">
								<td>Some Data 3</td>
								<td>33</td>
								<td>No</td>
								<td>a_value,bb_value</td>
								<td>
									<span class="label lightblue">Tag5</span>
								</td>
							</tr>
							<tr class="gradeA">
								<td>Some Data 4</td>
								<td>44</td>
								<td>Yes</td>
								<td>a_value,f_value</td>
								<td>
									<span class="label lightblue">Tag4</span>
								</td>
							</tr>
							<tr class="gradeA">
								<td>Some Data 5</td>
								<td>55</td>
								<td>No</td>
								<td>a_value,c_value</td>
								<td>
									<span class="label lightblue">Tag1</span>
									<span class="label lightblue">Tag2</span>
								</td>
							</tr>
							<tr class="gradeA">
								<td>Some Data 1</td>
								<td>10</td>
								<td>Yes</td>
								<td>a_value,b_value</td>
								<td>
									<span class="label lightblue">Tag1</span>
									<span class="label lightblue">Tag3</span>
								</td>
							</tr>
							<tr class="gradeA">
								<td>Some Data 2</td>
								<td>22</td>
								<td>No</td>
								<td>d_value,aa_value</td>
								<td>
									<span class="label lightblue">Tag1</span>
								</td>
							</tr>
							<tr class="gradeA">
								<td>Some Data 3</td>
								<td>33</td>
								<td>Yes</td>
								<td>a_value,c_value</td>
								<td>
									<span class="label lightblue">Tag1</span>
									<span class="label lightblue">Tag2</span>
								</td>
							</tr>
							<tr class="gradeA">
								<td>Some Data 4</td>
								<td>44</td>
								<td>No</td>
								<td>a_value,bb_value</td>
								<td>
									<span class="label lightblue">Tag1</span>
									<span class="label lightblue">Tag2</span>
								</td>
							</tr>
							<tr class="gradeA">
								<td>Some Data 5</td>
								<td>55</td>
								<td>Yes</td>
								<td>c_value,e_value</td>
								<td>
									<span class="label lightblue">Tag2</span>
								</td>
							</tr>
							<tr class="gradeA">
								<td>Some Data 1</td>
								<td>101</td>
								<td>No</td>
								<td>a_value,e_value</td>
								<td>
									<span class="label lightblue">Tag1</span>
								</td>
							</tr>
						</tbody>
					</table>
				</div>-->


				<div align="center">


					<table align="center" width="600" border="0">
						<tr>
							<td width="50%">
								<p align="center">
									<img align="baseline" src="imagenes/Envio.png" border="0" hspace="0" height="60" width="60"/>
								</p>
							</td>
							<td width="50%">
								<font class="tituloAzulClaro">Detalle de Pagos Remotos para Domicilio</font>
							</td>
						</tr>
					</table>
				</div>
				<br/>
				<div id="container">

					<table class="tabla" align="center" cellpadding="0" cellspacing="0" border="0" id="pagos">
						<thead>
							<tr class="etiqueta">
								<th>Fecha</th>
								<th>Servicio</th>
								<th>No.Documento</th>
								<th>Placa</th>
								<th>Transacción</th>
								<th>Recibo</th>
								<th>Estado</th>
								<th>Monto</th>
							</tr>
						</thead>

						<tbody>

							<xsl:for-each select="BitacoraCJDetalleEnviosOutput/Resultado/Fila">
								<tr class="odd gradeX">
									<!-- Escoge el formato de la fila, si es reversión, se pone en rojo   -->
									<xsl:choose>
										<xsl:when test="Estado='PE' or Estado='DE' or Estado='SVE'">
											<xsl:attribute name="class">tablaConError</xsl:attribute>
										</xsl:when>
										<xsl:when test="Estado='RV'">
											<xsl:attribute name="class">tablaResaltado</xsl:attribute>
										</xsl:when>
										<xsl:when test="Reversion!='1' and (Estado='PG')and(NumeroRecibo='0' or NumeroRecibo='Sin Imprimir')">
											<xsl:attribute name="class">tablaSinImprimir</xsl:attribute>
										</xsl:when>
										<xsl:when test="(Estado='DG')and(NumeroRecibo='0')">
											<xsl:attribute name="class">tablaSinImprimir</xsl:attribute>
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="class">detalle</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
									<td>
										<xsl:value-of select="FechaHora"/>
									</td>
									<td>
										<xsl:value-of select="Servicio"/>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="Estado='PP' and TipoComprobante=1">
												<xsl:if test="Oficina!=88">
													<a href="Transaccion.aspx?Transaccion=INSReintentoPago&amp;Usuario={Usuario}&amp;Oficina={Oficina}&amp;NumeroDocumento={NumeroDocumento}&amp;DiaPago={DiaPago}&amp;IP={TramaXML/INSPago/IP}&amp;Filtro=XML/INS/INSReintentoPago.xsl">
														<xsl:value-of select="NumeroDocumento"/>
													</a>
												</xsl:if>
												<xsl:if test="Oficina=88">
													<xsl:value-of select="NumeroDocumento"/>
												</xsl:if>
											</xsl:when>
											<xsl:when test="Estado='PP' and TipoComprobante=2">
												<xsl:if test="Oficina!=88">
													<a href="Transaccion.aspx?Transaccion=INSReintentoPago&amp;Usuario={Usuario}&amp;Oficina={Oficina}&amp;NumeroDocumento={NumeroDocumento}&amp;DiaPago={DiaPago}&amp;IP={TramaXML/INSPago/IP}&amp;Filtro=XML/INS/INSReintentoPago.xsl">
														<xsl:value-of select="NumeroDocumento"/>
													</a>
												</xsl:if>
												<xsl:if test="Oficina=88">
													<xsl:value-of select="NumeroDocumento"/>
												</xsl:if>
											</xsl:when>
											<xsl:when test="Estado='PP' and TipoComprobante=3">
												<xsl:if test="Oficina!=88">
													<a href="Transaccion.aspx?Transaccion=INSReintentoPago&amp;Usuario={Usuario}&amp;Oficina={Oficina}&amp;NumeroDocumento={NumeroDocumento}&amp;DiaPago={DiaPago}&amp;IP={TramaXML/INSPago/IP}&amp;Filtro=XML/INS/INSReintentoPago.xsl">
														<xsl:value-of select="NumeroDocumento"/>
													</a>
												</xsl:if>
												<xsl:if test="Oficina=88">
													<xsl:value-of select="NumeroDocumento"/>
												</xsl:if>
											</xsl:when>
											<xsl:when test="(Estado='PE' or Estado='NC')">
												<xsl:value-of select="NumeroDocumento"/>
											</xsl:when>
											<xsl:when test="Estado='PG' or Estado='DG' or Estado='SVG'">
												<a href="Transaccion.aspx?Transaccion=BitacoraObtenerPagoEnvio&amp;UsuarioOrigen={Usuario}&amp;OficinaOrigen={Oficina}&amp;TipoComprobante={TipoComprobante}&amp;NumeroDocumento={NumeroDocumento}&amp;DiaPago={DiaPago}&amp;Filtro=XML/virtual/INSPagofromBitacoraEnvio.xsl">
													<xsl:value-of select="NumeroDocumento"/>
												</a>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="NumeroDocumento"/>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="justify">
										<xsl:value-of select="ClasePlaca"/>-
										<xsl:value-of select="Numero"/>-
										<xsl:value-of select="CodigoGobierno"/>
									</td>
									<td>
										<xsl:value-of select="NumeroAutorizacion"/>
									</td>
									<td>
										<xsl:value-of select="NumeroRecibo"/>
									</td>
									<td>
										<xsl:value-of select="EstadoDescripcion"/>
									</td>
									<td align="right">
										<xsl:choose>
											<xsl:when test="Moneda = '1'">¢</xsl:when>
											<xsl:otherwise>$</xsl:otherwise>
										</xsl:choose>
										<xsl:value-of select="format-number(TotalPago,'###,###,###,##0.00')"/>
									</td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="TipoComprobanteDesc">
		<xsl:param name="Codigo" select="."/>
		<xsl:choose>
			<xsl:when test="$Codigo= 1">MARCHAMO</xsl:when>
			<xsl:when test="$Codigo= 2">CITE</xsl:when>
			<xsl:otherwise>NO ASIGNADO</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->