<?php
require_once('lib/nusoap.php');
$soapclient = new soap_server;


//Codifica base 64
function parseBase64($invoice)
{
    //set $data to UTF-8 format
    $invoiceUTF8 = '';
    $len         = strlen($invoice);
    for ($i = 0; $i < $len; $i++) {
        $invoiceUTF8 .= sprintf("%08b", ord($invoice{$i}));
    }
    //parse byte_array to base64
    $base64 = base64_encode($invoiceUTF8);
    return $base64;
}

//Obtiene el token
function tokenAuth($usuarioFE, $Pass)
    {
        $url = 'https://idp.comprobanteselectronicos.go.cr/auth/realms/rut-stag/protocol/openid-connect/token';//access token url
        $data = array('client_id' => 'api-stag',//Test: 'api-stag' Production: 'api-prod'
                      'client_secret' => '',//always empty
                      'grant_type' => 'password', //always 'password'
                      //go to https://www.hacienda.go.cr/ATV/login.aspx to generate a username and password credentials
                      'username' => $usuarioFE,//'cpf-01-1160-0029@stag.comprobanteselectronicos.go.cr', 
                      'password' => $Pass,//'{_+beoH@cx_[l@t##1c/', 
                      'scope' =>'');//always empty
        // use key 'http' even if you send the request to https://...
        $options = array(
            'http' => array(
                'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
                'method'  => 'POST',
                'content' => http_build_query($data)
            )
        );

        $context  = stream_context_create($options);
        $result = file_get_contents($url, false, $context);        
        if (!$result = file_get_contents($url, false, $context)) {
        $error = error_get_last();
        return new soap_fault('99',"Error","Error en el llamado :", $error['message']);
        } else {
        $token = json_decode($result);
        $Tokenn = 'bearer ' . $token->{'access_token'};
        $expires_in = $token->{'expires_in'};
		$refresh_expires_in = $token->{'refresh_expires_in'};
        $refresh_token = $token->{'refresh_token'};
		$token_type = $token->{'token_type'};
        $id_token = $token->{'id_token'};
        return array($Tokenn, $expires_in, $refresh_expires_in, $refresh_token, $token_type, $id_token);
        }

        
    }


    //Obtiene el token refresh

    function tokenRefreshAuth($usuarioFE, $Pass,$RToken)
    {
        $url = 'https://idp.comprobanteselectronicos.go.cr/auth/realms/rut-stag/protocol/openid-connect/token';//access token url
        $data = array('client_id' => 'api-stag',//Test: 'api-stag' Production: 'api-prod'
                      'client_secret' => '',//always empty
                      'grant_type' => 'refresh_token', //always 'refresh_token'
                      //go to https://www.hacienda.go.cr/ATV/login.aspx to generate a username and password credentials
                      'refresh_token' =>$RToken,
                      'username' => $usuarioFE,//'cpf-01-1160-0029@stag.comprobanteselectronicos.go.cr', 
                      'password' => $Pass,//'{_+beoH@cx_[l@t##1c/', 
                      'scope' =>'');//always empty
        // use key 'http' even if you send the request to https://...
        $options = array(
            'http' => array(
                'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
                'method'  => 'POST',
                'content' => http_build_query($data)
            )
        );

        $context  = stream_context_create($options);
        $result = file_get_contents($url, false, $context);        
        if (!$result = file_get_contents($url, false, $context)) {
        $error = error_get_last();
        return new soap_fault('99',"Error","Error en el llamado :", $error['message']);
        } else {
        $token = json_decode($result);
        $Tokenn = 'bearer ' . $token->{'access_token'};
        $expires_in = $token->{'expires_in'};
		$refresh_expires_in = $token->{'refresh_expires_in'};
        $refresh_token = $token->{'refresh_token'};
		$token_type = $token->{'token_type'};
        $id_token = $token->{'id_token'};
        return array($Tokenn, $expires_in, $refresh_expires_in, $refresh_token, $token_type, $id_token);
        }

        
    }

    //GENERA EL XML DE LA FACTURA

    function genXMLFe($clave,$consecutivo ,$fechaEmision ,$emisorNombre ,$emisorTipoIdentif ,$emisorNumIdentif ,
    $nombreComercial ,$emisorProv ,$meisorCanton ,$emisorDistrito ,$emisorBarrio ,$emisorOtrasSenas ,$emisorCodPaisTel ,
    $emisorTel ,$emisorCodPaisFax ,$emisorFax ,$emisorEmail ,$receptorNombre ,$receptorTipoIdentif ,$recenprotNumIdentif ,
    $receptorProvincia ,$receptorCanton ,$receptorDistrito ,$receptorBarrio ,$receptorOtrasSenas ,$receptorCodPaisTel ,
    $receptorTel ,$receptorCodPaisFax ,$receptorFax ,$receptorEmail ,$condVenta ,$plazoCredito ,$medioPago ,$codMoneda ,
    $tipoCambio ,$totalServGravados ,$totalServExentos ,$totalMercGravadas ,$totalMercExentas ,$totalGravados ,
    $totalExentos ,$totalVentas ,$totalDescuentos ,$totalVentasNeta ,$totalImp ,$totalComprobante ,$infoRefeTipoDoc, $infoRefeNumero,
    $infoRefeFechaEmision, $infoRefeCodigo, $infoRefeRazon,$otros,$detalles)
     {
        
         //detalles de la compra
    $detalles = json_decode($detalles);
    //grace_debug($detalles);
     

        $xmlString = '<?xml version="1.0" encoding="utf-8"?>
        <FacturaElectronica xmlns="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd">
            <Clave>' . $clave . '</Clave>
            <NumeroConsecutivo>' . $consecutivo . '</NumeroConsecutivo>
            <FechaEmision>' . $fechaEmision . '</FechaEmision>
            <Emisor>
                <Nombre>' . $emisorNombre . '</Nombre>
                <Identificacion>
                    <Tipo>' . $emisorTipoIdentif . '</Tipo>
                    <Numero>' . $emisorNumIdentif . '</Numero>
                </Identificacion>
                <NombreComercial>' . $nombreComercial . '</NombreComercial>
                <Ubicacion>
                    <Provincia>' . $emisorProv . '</Provincia>
                    <Canton>' . $meisorCanton . '</Canton>
                    <Distrito>' . $emisorDistrito . '</Distrito>
                    <Barrio>' . $emisorBarrio . '</Barrio>
                    <OtrasSenas>' . $emisorOtrasSenas . '</OtrasSenas>
                </Ubicacion>
                <Telefono>
                    <CodigoPais>' . $emisorCodPaisTel . '</CodigoPais>
                    <NumTelefono>' . $emisorTel . '</NumTelefono>
                </Telefono>
                <Fax>
                    <CodigoPais>' . $emisorCodPaisFax . '</CodigoPais>
                    <NumTelefono>' . $emisorFax . '</NumTelefono>
                </Fax>
                <CorreoElectronico>' . $emisorEmail . '</CorreoElectronico>
            </Emisor>
            <Receptor>
                <Nombre>' . $receptorNombre . '</Nombre>
                <Identificacion>
                    <Tipo>' . $receptorTipoIdentif . '</Tipo>
                    <Numero>' . $recenprotNumIdentif . '</Numero>
                </Identificacion>
                <Ubicacion>
                    <Provincia>' . $receptorProvincia . '</Provincia>
                    <Canton>' . $receptorCanton . '</Canton>
                    <Distrito>' . $receptorDistrito . '</Distrito>
                    <Barrio>' . $receptorBarrio . '</Barrio>
                    <OtrasSenas>' . $receptorOtrasSenas . '</OtrasSenas>
                </Ubicacion>
                <Telefono>
                    <CodigoPais>' . $receptorCodPaisTel . '</CodigoPais>
                    <NumTelefono>' . $receptorTel . '</NumTelefono>
                </Telefono>
                <Fax>
                    <CodigoPais>' . $receptorCodPaisFax . '</CodigoPais>
                    <NumTelefono>' . $receptorFax . '</NumTelefono>
                </Fax>
                <CorreoElectronico>' . $receptorEmail . '</CorreoElectronico>
            </Receptor>
            <CondicionVenta>' . $condVenta . '</CondicionVenta>
            <PlazoCredito>' . $plazoCredito . '</PlazoCredito>
            <MedioPago>' . $medioPago . '</MedioPago>
            <DetalleServicio>
            ';
        //cant - unidad medida - detalle - precio unitario - monto total - subtotal - monto total linea - Monto desc -Naturaleza Desc - Impuesto : Codigo / Tarifa / Monto
        
        /* EJEMPLO DE DETALLES
          {
            "1":["1","Sp","Honorarios","100000","100000","100000","100000","1000","Pronto pago",{"Imp": [{"cod": 122,"tarifa": 1,"monto": 100},{"cod": 133,"tarifa": 1,"monto": 1300}]}],
            "2":["1","Sp","Honorarios","100000","100000","100000","100000"]
          }
         */
        $l = 1;
        foreach ($detalles as $d) {
            $xmlString .= '<LineaDetalle>
                      <NumeroLinea>' . $l . '</NumeroLinea>
                      <Cantidad>' . $d->cantidad . '</Cantidad>
                      <UnidadMedida>' . $d->unidadMedida . '</UnidadMedida>
                      <Detalle>' . $d->detalle . '</Detalle>
                      <PrecioUnitario>' . $d->precioUnitario . '</PrecioUnitario>
                      <MontoTotal>' . $d->montoTotal . '</MontoTotal>';
            if (isset($d->montoDescuento) && $d->montoDescuento != "") {
                $xmlString .= '<MontoDescuento>' . $d->montoDescuento . '</MontoDescuento>';
            }
            if (isset($d->naturalezaDescuento) && $d->naturalezaDescuento != "") {
                $xmlString .= '<NaturalezaDescuento>' . $d->naturalezaDescuento . '</NaturalezaDescuento>';
            }
            if (isset($d->impuesto) && $d->impuesto != "") {
                foreach($d->impuesto as $i)
                {
                    $xmlString .= '<Impuesto>
                    <Codigo>' . $i->codigo . '</Codigo>
                    <Tarifa>' . $i->tarifa . '</Tarifa>
                    <Monto>' . $i->monto . '</Monto>';
                    if(isset($i->exoneracion) && $i->exoneracion!=""){
                        $xmlString .= '
                        <Exoneracion>
                            <TipoDocumento>' . $i->exoneracion->tipoDocumento . '</TipoDocumento>
                            <NumeroDocumento>' . $i->exoneracion->numeroDocumento . '</NumeroDocumento>
                            <NombreInstitucion>' . $i->exoneracion->nombreInstitucion . '</NombreInstitucion>
                            <FechaEmision>' . $i->exoneracion->fechaEmision . '</FechaEmision>
                            <MontoImpuesto>' . $i->exoneracion->montoImpuesto . '</MontoImpuesto>
                            <PorcentajeCompra>' . $i->exoneracion->porcentajeCompra . '</PorcentajeCompra>
                        </Exoneracion>';
                    }
    
                    $xmlString .= '</Impuesto>';
                }
            }
            $xmlString .= '<SubTotal>' . $d->subtotal . '</SubTotal>
            <MontoTotalLinea>' . $d->montoTotalLinea . '</MontoTotalLinea>';
            $xmlString .= '</LineaDetalle>';
            $l++;
        }

        if ($infoRefeTipoDoc=="" )
        {$xmlString .= '</DetalleServicio>
            <ResumenFactura>
            <CodigoMoneda>' . $codMoneda . '</CodigoMoneda>
            <TipoCambio>' . $tipoCambio . '</TipoCambio>
            <TotalServGravados>' . $totalServGravados . '</TotalServGravados>
            <TotalServExentos>' . $totalServExentos . '</TotalServExentos>
            <TotalMercanciasGravadas>' . $totalMercGravadas . '</TotalMercanciasGravadas>
            <TotalMercanciasExentas>' . $totalMercExentas . '</TotalMercanciasExentas>
            <TotalGravado>' . $totalGravados . '</TotalGravado>
            <TotalExento>' . $totalExentos . '</TotalExento>
            <TotalVenta>' . $totalVentas . '</TotalVenta>
            <TotalDescuentos>' . $totalDescuentos . '</TotalDescuentos>
            <TotalVentaNeta>' . $totalVentasNeta . '</TotalVentaNeta>
            <TotalImpuesto>' . $totalImp . '</TotalImpuesto>
            <TotalComprobante>' . $totalComprobante . '</TotalComprobante>
            </ResumenFactura>
            <Normativa>
            <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>
            <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>
            </Normativa>
            <Otros>
            <OtroTexto>' . $otros . '</OtroTexto>
            </Otros>
            </FacturaElectronica>';}

            ELSE

           { $xmlString .= '</DetalleServicio>
            <ResumenFactura>
            <CodigoMoneda>' . $codMoneda . '</CodigoMoneda>
            <TipoCambio>' . $tipoCambio . '</TipoCambio>
            <TotalServGravados>' . $totalServGravados . '</TotalServGravados>
            <TotalServExentos>' . $totalServExentos . '</TotalServExentos>
            <TotalMercanciasGravadas>' . $totalMercGravadas . '</TotalMercanciasGravadas>
            <TotalMercanciasExentas>' . $totalMercExentas . '</TotalMercanciasExentas>
            <TotalGravado>' . $totalGravados . '</TotalGravado>
            <TotalExento>' . $totalExentos . '</TotalExento>
            <TotalVenta>' . $totalVentas . '</TotalVenta>
            <TotalDescuentos>' . $totalDescuentos . '</TotalDescuentos>
            <TotalVentaNeta>' . $totalVentasNeta . '</TotalVentaNeta>
            <TotalImpuesto>' . $totalImp . '</TotalImpuesto>
            <TotalComprobante>' . $totalComprobante . '</TotalComprobante>
            </ResumenFactura>
            <InformacionReferencia>
            <TipoDoc>' . $infoRefeTipoDoc . '</TipoDoc>
            <Numero>' . $infoRefeNumero . '</Numero>
            <FechaEmision>' . $infoRefeFechaEmision . '</FechaEmision>
            <Codigo>' . $infoRefeCodigo . '</Codigo>
            <Razon>' . $infoRefeRazon . '</Razon>
           </InformacionReferencia>
            <Normativa>
            <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>
            <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>
            </Normativa>
            <Otros>
            <OtroTexto>' . $otros . '</OtroTexto>
            </Otros>
            </FacturaElectronica>';}
       // $arrayResp = array(
         //   "clave" => $clave,
           // "xml" => base64_encode($xmlString)
        //);
       // return $arrayResp;

       $arrayResp = base64_encode($xmlString);
       return $arrayResp;
       


}

function genXMLTe($clave, $consecutivo, $fechaEmision, $emisorNombre, $emisorTipoIdentif, $emisorNumIdentif,
$nombreComercial, $emisorProv, $meisorCanton, $emisorDistrito, $emisorBarrio, $emisorOtrasSenas, $emisorCodPaisTel,
$emisorTel, $emisorCodPaisFax, $emisorFax, $emisorEmail, $receptorNombre, $receptorTipoIdentif, $receptorNumIdentif,
$receptorProvincia, $receptorCanton, $receptorDistrito, $receptorBarrio, $receptorOtrasSenas, $receptorCodPaisTel,
$receptorTel, $receptorCodPaisFax, $receptorFax, $receptorEmail,$condVenta, $plazoCredito, $medioPago, $codMoneda,
$tipoCambio, $totalServGravados, $totalServExentos, $totalMercGravadas, $totalMercExentas, $totalGravados, $totalExentos,
$totalVentas, $totalDescuentos, $totalVentasNeta, $totalImp, $totalComprobante,$infoRefeTipoDoc, $infoRefeNumero,
$infoRefeFechaEmision, $infoRefeCodigo, $infoRefeRazon,$otros,$detalles)
 {
    
     //detalles de la compra
$detalles = json_decode($detalles);



//GENERA XML TIQUETE ELECTRONICO

        $xmlString = '<?xml version="1.0" encoding="utf-8"?>
        <TiqueteElectronico xmlns="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/tiqueteElectronico" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/tiqueteElectronico TiqueteElectronico_V4.2.xsd">
        <Clave>' . $clave . '</Clave>
        <NumeroConsecutivo>' . $consecutivo . '</NumeroConsecutivo>
        <FechaEmision>' . $fechaEmision . '</FechaEmision>
        <Emisor>
            <Nombre>' . $emisorNombre . '</Nombre>
            <Identificacion>
                <Tipo>' . $emisorTipoIdentif . '</Tipo>
                <Numero>' . $emisorNumIdentif . '</Numero>
            </Identificacion>
            <NombreComercial>' . $nombreComercial . '</NombreComercial>
            <Ubicacion>
                <Provincia>' . $emisorProv . '</Provincia>
                <Canton>' . $meisorCanton . '</Canton>
                <Distrito>' . $emisorDistrito . '</Distrito>
                <Barrio>' . $emisorBarrio . '</Barrio>
                <OtrasSenas>' . $emisorOtrasSenas . '</OtrasSenas>
            </Ubicacion>
            <Telefono>
                <CodigoPais>' . $emisorCodPaisTel . '</CodigoPais>
                <NumTelefono>' . $emisorTel . '</NumTelefono>
            </Telefono>
            <Fax>
                <CodigoPais>' . $emisorCodPaisFax . '</CodigoPais>
                <NumTelefono>' . $emisorFax . '</NumTelefono>
            </Fax>
            <CorreoElectronico>' . $emisorEmail . '</CorreoElectronico>
        </Emisor>
        <Receptor>
            <Nombre>' . $receptorNombre . '</Nombre>
            <Identificacion>
                <Tipo>' . $receptorTipoIdentif . '</Tipo>
                <Numero>' . $receptorNumIdentif . '</Numero>
            </Identificacion>
            <Ubicacion>
                <Provincia>' . $receptorProvincia . '</Provincia>
                <Canton>' . $receptorCanton . '</Canton>
                <Distrito>' . $receptorDistrito . '</Distrito>
                <Barrio>' . $receptorBarrio . '</Barrio>
                <OtrasSenas>' . $receptorOtrasSenas . '</OtrasSenas>
            </Ubicacion>
            <Telefono>
                <CodigoPais>' . $receptorCodPaisTel . '</CodigoPais>
                <NumTelefono>' . $receptorTel . '</NumTelefono>
            </Telefono>
            <Fax>
                <CodigoPais>' . $receptorCodPaisFax . '</CodigoPais>
                <NumTelefono>' . $receptorFax . '</NumTelefono>
            </Fax>
            <CorreoElectronico>' . $receptorEmail . '</CorreoElectronico>
        </Receptor>
        <CondicionVenta>' . $condVenta . '</CondicionVenta>
        <PlazoCredito>' . $plazoCredito . '</PlazoCredito>
        <MedioPago>' . $medioPago . '</MedioPago>
        <DetalleServicio>';
        
        /* EJEMPLO DE DETALLES
          {
            "1":["1","Sp","Honorarios","100000","100000","100000","100000","1000","Pronto pago",{"Imp": [{"cod": 122,"tarifa": 1,"monto": 100},{"cod": 133,"tarifa": 1,"monto": 1300}]}],
            "2":["1","Sp","Honorarios","100000","100000","100000","100000"]
          }
         */
        $l = 1;
        foreach ($detalles as $d) {
            $xmlString .= '<LineaDetalle>
                      <NumeroLinea>' . $l . '</NumeroLinea>
                      <Cantidad>' . $d->cantidad . '</Cantidad>
                      <UnidadMedida>' . $d->unidadMedida . '</UnidadMedida>
                      <Detalle>' . $d->detalle . '</Detalle>
                      <PrecioUnitario>' . $d->precioUnitario . '</PrecioUnitario>
                      <MontoTotal>' . $d->montoTotal . '</MontoTotal>';
            if (isset($d->montoDescuento) && $d->montoDescuento != "") {
                $xmlString .= '<MontoDescuento>' . $d->montoDescuento . '</MontoDescuento>';
            }
            if (isset($d->naturalezaDescuento) && $d->naturalezaDescuento != "") {
                $xmlString .= '<NaturalezaDescuento>' . $d->naturalezaDescuento . '</NaturalezaDescuento>';
            }
            if (isset($d->impuesto) && $d->impuesto != "") {
                foreach($d->impuesto as $i)
                {
                    $xmlString .= '<Impuesto>
                    <Codigo>' . $i->codigo . '</Codigo>
                    <Tarifa>' . $i->tarifa . '</Tarifa>
                    <Monto>' . $i->monto . '</Monto>';
                    if(isset($i->exoneracion) && $i->exoneracion!=""){
                        $xmlString .= '<Exoneracion>
                            <TipoDocumento>' . $i->exoneracion->tipoDocumento . '</TipoDocumento>
                            <NumeroDocumento>' . $i->exoneracion->numeroDocumento . '</NumeroDocumento>
                            <NombreInstitucion>' . $i->exoneracion->nombreInstitucion . '</NombreInstitucion>
                            <FechaEmision>' . $i->exoneracion->fechaEmision . '</FechaEmision>
                            <MontoImpuesto>' . $i->exoneracion->montoImpuesto . '</MontoImpuesto>
                            <PorcentajeCompra>' . $i->exoneracion->porcentajeCompra . '</PorcentajeCompra>
                        </Exoneracion>';
                    }
    
                    $xmlString .= '</Impuesto>';
                }
            }
            $xmlString .= '<SubTotal>' . $d->subtotal . '</SubTotal>
            <MontoTotalLinea>' . $d->montoTotalLinea . '</MontoTotalLinea>';
            $xmlString .= '</LineaDetalle>';
            $l++;
        }

        if ($infoRefeTipoDoc=="" )
        {$xmlString .= '</DetalleServicio>
        <ResumenFactura>
            <CodigoMoneda>' . $codMoneda . '</CodigoMoneda>
            <TipoCambio>' . $tipoCambio . '</TipoCambio>
            <TotalServGravados>' . $totalServGravados . '</TotalServGravados>
            <TotalServExentos>' . $totalServExentos . '</TotalServExentos>
            <TotalMercanciasGravadas>' . $totalMercGravadas . '</TotalMercanciasGravadas>
            <TotalMercanciasExentas>' . $totalMercExentas . '</TotalMercanciasExentas>
            <TotalGravado>' . $totalGravados . '</TotalGravado>
            <TotalExento>' . $totalExentos . '</TotalExento>
            <TotalVenta>' . $totalVentas . '</TotalVenta>
            <TotalDescuentos>' . $totalDescuentos . '</TotalDescuentos>
            <TotalVentaNeta>' . $totalVentasNeta . '</TotalVentaNeta>
            <TotalImpuesto>' . $totalImp . '</TotalImpuesto>
            <TotalComprobante>' . $totalComprobante . '</TotalComprobante>
        </ResumenFactura>
        <Normativa>
            <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>
            <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>
        </Normativa>
        <Otros>
            <OtroTexto>' . $otros . '</OtroTexto>
        </Otros>
            </TiqueteElectronico>';}

            else

            {$xmlString .= '</DetalleServicio>
        <ResumenFactura>
            <CodigoMoneda>' . $codMoneda . '</CodigoMoneda>
            <TipoCambio>' . $tipoCambio . '</TipoCambio>
            <TotalServGravados>' . $totalServGravados . '</TotalServGravados>
            <TotalServExentos>' . $totalServExentos . '</TotalServExentos>
            <TotalMercanciasGravadas>' . $totalMercGravadas . '</TotalMercanciasGravadas>
            <TotalMercanciasExentas>' . $totalMercExentas . '</TotalMercanciasExentas>
            <TotalGravado>' . $totalGravados . '</TotalGravado>
            <TotalExento>' . $totalExentos . '</TotalExento>
            <TotalVenta>' . $totalVentas . '</TotalVenta>
            <TotalDescuentos>' . $totalDescuentos . '</TotalDescuentos>
            <TotalVentaNeta>' . $totalVentasNeta . '</TotalVentaNeta>
            <TotalImpuesto>' . $totalImp . '</TotalImpuesto>
            <TotalComprobante>' . $totalComprobante . '</TotalComprobante>
        </ResumenFactura>
            <InformacionReferencia>
            <TipoDoc>' . $infoRefeTipoDoc . '</TipoDoc>
            <Numero>' . $infoRefeNumero . '</Numero>
            <FechaEmision>' . $infoRefeFechaEmision . '</FechaEmision>
            <Codigo>' . $infoRefeCodigo . '</Codigo>
            <Razon>' . $infoRefeRazon . '</Razon>
       </InformacionReferencia>
        <Normativa>
            <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>
            <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>
        </Normativa>
        <Otros>
            <OtroTexto>' . $otros . '</OtroTexto>
        </Otros>
            </TiqueteElectronico>';}

            $arrayResp = base64_encode($xmlString);
       return $arrayResp;

      

    }

//GENERA XML NOTA CREDITO
function genXMLNC($clave, $consecutivo, $fechaEmision, $emisorNombre, $emisorTipoIdentif, $emisorNumIdentif,
$nombreComercial, $emisorProv, $meisorCanton, $emisorDistrito, $emisorBarrio, $emisorOtrasSenas, $emisorCodPaisTel,
$emisorTel, $emisorCodPaisFax, $emisorFax, $emisorEmail, $receptorNombre, $receptorTipoIdentif, $recenprotNumIdentif,
$receptorProvincia, $receptorCanton, $receptorDistrito, $receptorBarrio, $receptorOtrasSenas, $receptorCodPaisTel,
$receptorTel, $receptorCodPaisFax, $receptorFax, $receptorEmail,$condVenta, $plazoCredito, $medioPago, $codMoneda,
$tipoCambio, $totalServGravados, $totalServExentos, $totalMercGravadas, $totalMercExentas, $totalGravados, $totalExentos,
$totalVentas, $totalDescuentos, $totalVentasNeta, $totalImp, $totalComprobante, $otros, $infoRefeTipoDoc, $infoRefeNumero,
 $infoRefeFechaEmision, $infoRefeCodigo, $infoRefeRazon,$detalles) 
{

    $detalles = json_decode($detalles);
    
    //return $detalles;


    $xmlString = '<?xml version = "1.0" encoding = "utf-8"?>
<NotaCreditoElectronica xmlns="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/notaCreditoElectronica" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/notaCreditoElectronica NotaCreditoElectronica_V4.2.xsd">
    <Clave>' . $clave . '</Clave>
    <NumeroConsecutivo>' . $consecutivo . '</NumeroConsecutivo>
    <FechaEmision>' . $fechaEmision . '</FechaEmision>
    <Emisor>
        <Nombre>' . $emisorNombre . '</Nombre>
        <Identificacion>
            <Tipo>' . $emisorTipoIdentif . '</Tipo>
            <Numero>' . $emisorNumIdentif . '</Numero>
        </Identificacion>
        <NombreComercial>' . $nombreComercial . '</NombreComercial>
        <Ubicacion>
            <Provincia>' . $emisorProv . '</Provincia>
            <Canton>' . $meisorCanton . '</Canton>
            <Distrito>' . $emisorDistrito . '</Distrito>
            <Barrio>' . $emisorBarrio . '</Barrio>
            <OtrasSenas>' . $emisorOtrasSenas . '</OtrasSenas>
        </Ubicacion>
        <Telefono>
            <CodigoPais>' . $emisorCodPaisTel . '</CodigoPais>
            <NumTelefono>' . $emisorTel . '</NumTelefono>
        </Telefono>
        <Fax>
            <CodigoPais>' . $emisorCodPaisFax . '</CodigoPais>
            <NumTelefono>' . $emisorFax . '</NumTelefono>
        </Fax>
        <CorreoElectronico>' . $emisorEmail . '</CorreoElectronico>
    </Emisor>
    <Receptor>
        <Nombre>' . $receptorNombre . '</Nombre>
        <Identificacion>
            <Tipo>' . $receptorTipoIdentif . '</Tipo>
            <Numero>' . $recenprotNumIdentif . '</Numero>
        </Identificacion>
        <NombreComercial/>
        <Ubicacion>
            <Provincia>' . $receptorProvincia . '</Provincia>
            <Canton>' . $receptorCanton . '</Canton>
            <Distrito>' . $receptorDistrito . '</Distrito>
            <Barrio>' . $receptorBarrio . '</Barrio>
            <OtrasSenas>' . $receptorOtrasSenas . '</OtrasSenas>
        </Ubicacion>
        <Telefono>
            <CodigoPais>' . $receptorCodPaisTel . '</CodigoPais>
            <NumTelefono>' . $receptorTel . '</NumTelefono>
        </Telefono>
        <Fax>
            <CodigoPais>' . $receptorCodPaisFax . '</CodigoPais>
            <NumTelefono>' . $receptorFax . '</NumTelefono>
        </Fax>
        <CorreoElectronico>' . $receptorEmail . '</CorreoElectronico>
    </Receptor>
    <CondicionVenta>' . $condVenta . '</CondicionVenta>
    <PlazoCredito>' . $plazoCredito . '</PlazoCredito>
    <MedioPago>' . $medioPago . '</MedioPago>
    <DetalleServicio>';
    /* EJEMPLO DE DETALLES
      {
        "1":["1","Sp","Honorarios","100000","100000","100000","100000","1000","Pronto pago",{"Imp": [{"cod": 122,"tarifa": 1,"monto": 100},{"cod": 133,"tarifa": 1,"monto": 1300}]}],
        "2":["1","Sp","Honorarios","100000","100000","100000","100000"]
      }
     */
    $l = 1;
    foreach ($detalles as $d) {
        $xmlString .= '<LineaDetalle>
                  <NumeroLinea>' . $l . '</NumeroLinea>
                  <Cantidad>' . $d->cantidad . '</Cantidad>
                  <UnidadMedida>' . $d->unidadMedida . '</UnidadMedida>
                  <Detalle>' . $d->detalle . '</Detalle>
                  <PrecioUnitario>' . $d->precioUnitario . '</PrecioUnitario>
                  <MontoTotal>' . $d->montoTotal . '</MontoTotal>';
        if (isset($d->montoDescuento) && $d->montoDescuento != "") {
            $xmlString .= '<MontoDescuento>' . $d->montoDescuento . '</MontoDescuento>';
        }
        if (isset($d->naturalezaDescuento) && $d->naturalezaDescuento != "") {
            $xmlString .= '<NaturalezaDescuento>' . $d->naturalezaDescuento . '</NaturalezaDescuento>';
        }
        if (isset($d->impuesto) && $d->impuesto != "") {
            foreach($d->impuesto as $i)
            {
                $xmlString .= '<Impuesto>
                <Codigo>' . $i->codigo . '</Codigo>
                <Tarifa>' . $i->tarifa . '</Tarifa>
                <Monto>' . $i->monto . '</Monto>';
                if(isset($i->exoneracion) && $i->exoneracion!=""){
                    $xmlString .= '<Exoneracion>
                        <TipoDocumento>' . $i->exoneracion->tipoDocumento . '</TipoDocumento>
                        <NumeroDocumento>' . $i->exoneracion->numeroDocumento . '</NumeroDocumento>
                        <NombreInstitucion>' . $i->exoneracion->nombreInstitucion . '</NombreInstitucion>
                        <FechaEmision>' . $i->exoneracion->fechaEmision . '</FechaEmision>
                        <MontoImpuesto>' . $i->exoneracion->montoImpuesto . '</MontoImpuesto>
                        <PorcentajeCompra>' . $i->exoneracion->porcentajeCompra . '</PorcentajeCompra>
                    </Exoneracion>';
                }

                $xmlString .= '</Impuesto>';
            }
        }
        $xmlString .= '<SubTotal>' . $d->subtotal . '</SubTotal>
        <MontoTotalLinea>' . $d->montoTotalLinea . '</MontoTotalLinea>';
        $xmlString .= '</LineaDetalle>';
        $l++;
    }
    $xmlString .= '</DetalleServicio>
    <ResumenFactura>
        <CodigoMoneda>' . $codMoneda . '</CodigoMoneda>
        <TipoCambio>' . $tipoCambio . '</TipoCambio>
        <TotalServGravados>' . $totalServGravados . '</TotalServGravados>
        <TotalServExentos>' . $totalServExentos . '</TotalServExentos>
        <TotalMercanciasGravadas>' . $totalMercGravadas . '</TotalMercanciasGravadas>
        <TotalMercanciasExentas>' . $totalMercExentas . '</TotalMercanciasExentas>
        <TotalGravado>' . $totalGravados . '</TotalGravado>
        <TotalExento>' . $totalExentos . '</TotalExento>
        <TotalVenta>' . $totalVentas . '</TotalVenta>
        <TotalDescuentos>' . $totalDescuentos . '</TotalDescuentos>
        <TotalVentaNeta>' . $totalVentasNeta . '</TotalVentaNeta>
        <TotalImpuesto>' . $totalImp . '</TotalImpuesto>
        <TotalComprobante>' . $totalComprobante . '</TotalComprobante>
    </ResumenFactura>
    <InformacionReferencia>
        <TipoDoc>' . $infoRefeTipoDoc . '</TipoDoc>
        <Numero>' . $infoRefeNumero . '</Numero>
        <FechaEmision>' . $infoRefeFechaEmision . '</FechaEmision>
        <Codigo>' . $infoRefeCodigo . '</Codigo>
        <Razon>' . $infoRefeRazon . '</Razon>
    </InformacionReferencia>
    <Normativa>
        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>
        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>
    </Normativa>
    <Otros>
        <OtroTexto>' . $otros . '</OtroTexto>
    </Otros>
</NotaCreditoElectronica>';
    
    $arrayResp = base64_encode($xmlString);
       return $arrayResp;
}



//GENERA XML NOTA DEBITO

function genXMLND($clave, $consecutivo, $fechaEmision, $emisorNombre, $emisorTipoIdentif, $emisorNumIdentif,
$nombreComercial, $emisorProv, $meisorCanton, $emisorDistrito, $emisorBarrio, $emisorOtrasSenas, $emisorCodPaisTel,
$emisorTel, $emisorCodPaisFax, $emisorFax, $emisorEmail, $receptorNombre, $receptorTipoIdentif, $recenprotNumIdentif,
$receptorProvincia, $receptorCanton, $receptorDistrito, $receptorBarrio, $receptorOtrasSenas, $receptorCodPaisTel,
$receptorTel, $receptorCodPaisFax, $receptorFax, $receptorEmail,$condVenta, $plazoCredito, $medioPago, $codMoneda,
$tipoCambio, $totalServGravados, $totalServExentos, $totalMercGravadas, $totalMercExentas, $totalGravados, $totalExentos,
$totalVentas, $totalDescuentos, $totalVentasNeta, $totalImp, $totalComprobante, $otros, $infoRefeTipoDoc, $infoRefeNumero,
 $infoRefeFechaEmision, $infoRefeCodigo, $infoRefeRazon,$detalles) 
{

    $detalles = json_decode($detalles);


    $xmlString = '<?xml version="1.0" encoding="utf-8"?>
    <NotaDebitoElectronica xmlns="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/notaDebitoElectronica" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/notaDebitoElectronica NotaDebitoElectronica_V4.2.xsd">
        <Clave>' . $clave . '</Clave>
        <NumeroConsecutivo>' . $consecutivo . '</NumeroConsecutivo>
        <FechaEmision>' . $fechaEmision . '</FechaEmision>
        <Emisor>
            <Nombre>' . $emisorNombre . '</Nombre>
            <Identificacion>
                <Tipo>' . $emisorTipoIdentif . '</Tipo>
                <Numero>' . $emisorNumIdentif . '</Numero>
            </Identificacion>
            <NombreComercial>' . $nombreComercial . '</NombreComercial>
            <Ubicacion>
                <Provincia>' . $emisorProv . '</Provincia>
                <Canton>' . $meisorCanton . '</Canton>
                <Distrito>' . $emisorDistrito . '</Distrito>
                <Barrio>' . $emisorBarrio . '</Barrio>
                <OtrasSenas>' . $emisorOtrasSenas . '</OtrasSenas>
            </Ubicacion>
            <Telefono>
                <CodigoPais>' . $emisorCodPaisTel . '</CodigoPais>
                <NumTelefono>' . $emisorTel . '</NumTelefono>
            </Telefono>
            <Fax>
                <CodigoPais>' . $emisorCodPaisFax . '</CodigoPais>
                <NumTelefono>' . $emisorFax . '</NumTelefono>
            </Fax>
            <CorreoElectronico>' . $emisorEmail . '</CorreoElectronico>
        </Emisor>
        <Receptor>
            <Nombre>' . $receptorNombre . '</Nombre>
            <Identificacion>
                <Tipo>' . $receptorTipoIdentif . '</Tipo>
                <Numero>' . $recenprotNumIdentif . '</Numero>
            </Identificacion>
            <Ubicacion>
                <Provincia>' . $receptorProvincia . '</Provincia>
                <Canton>' . $receptorCanton . '</Canton>
                <Distrito>' . $receptorDistrito . '</Distrito>
                <Barrio>' . $receptorBarrio . '</Barrio>
                <OtrasSenas>' . $receptorOtrasSenas . '</OtrasSenas>
            </Ubicacion>
            <Telefono>
                <CodigoPais>' . $receptorCodPaisTel . '</CodigoPais>
                <NumTelefono>' . $receptorTel . '</NumTelefono>
            </Telefono>
            <Fax>
                <CodigoPais>' . $receptorCodPaisFax . '</CodigoPais>
                <NumTelefono>' . $receptorFax . '</NumTelefono>
            </Fax>
            <CorreoElectronico>' . $receptorEmail . '</CorreoElectronico>
        </Receptor>
        <CondicionVenta>' . $condVenta . '</CondicionVenta>
        <PlazoCredito>' . $plazoCredito . '</PlazoCredito>
        <MedioPago>' . $medioPago . '</MedioPago>
        <DetalleServicio>';
        
        /* EJEMPLO DE DETALLES
          {
            "1":["1","Sp","Honorarios","100000","100000","100000","100000","1000","Pronto pago",{"Imp": [{"cod": 122,"tarifa": 1,"monto": 100},{"cod": 133,"tarifa": 1,"monto": 1300}]}],
            "2":["1","Sp","Honorarios","100000","100000","100000","100000"]
          }
         */
        $l = 1;
        foreach ($detalles as $d) {
            $xmlString .= '<LineaDetalle>
                      <NumeroLinea>' . $l . '</NumeroLinea>
                      <Cantidad>' . $d->cantidad . '</Cantidad>
                      <UnidadMedida>' . $d->unidadMedida . '</UnidadMedida>
                      <Detalle>' . $d->detalle . '</Detalle>
                      <PrecioUnitario>' . $d->precioUnitario . '</PrecioUnitario>
                      <MontoTotal>' . $d->montoTotal . '</MontoTotal>';
            if (isset($d->montoDescuento) && $d->montoDescuento != "") {
                $xmlString .= '<MontoDescuento>' . $d->montoDescuento . '</MontoDescuento>';
            }
            if (isset($d->naturalezaDescuento) && $d->naturalezaDescuento != "") {
                $xmlString .= '<NaturalezaDescuento>' . $d->naturalezaDescuento . '</NaturalezaDescuento>';
            }
            if (isset($d->impuesto) && $d->impuesto != "") {
                foreach($d->impuesto as $i)
                {
                    $xmlString .= '<Impuesto>
                    <Codigo>' . $i->codigo . '</Codigo>
                    <Tarifa>' . $i->tarifa . '</Tarifa>
                    <Monto>' . $i->monto . '</Monto>';
                    if(isset($i->exoneracion) && $i->exoneracion!=""){
                        $xmlString .= '<Exoneracion>
                            <TipoDocumento>' . $i->exoneracion->tipoDocumento . '</TipoDocumento>
                            <NumeroDocumento>' . $i->exoneracion->numeroDocumento . '</NumeroDocumento>
                            <NombreInstitucion>' . $i->exoneracion->nombreInstitucion . '</NombreInstitucion>
                            <FechaEmision>' . $i->exoneracion->fechaEmision . '</FechaEmision>
                            <MontoImpuesto>' . $i->exoneracion->montoImpuesto . '</MontoImpuesto>
                            <PorcentajeCompra>' . $i->exoneracion->porcentajeCompra . '</PorcentajeCompra>
                        </Exoneracion>';
                    }
    
                    $xmlString .= '</Impuesto>';
                }
            }
            $xmlString .= '<SubTotal>' . $d->subtotal . '</SubTotal>
            <MontoTotalLinea>' . $d->montoTotalLinea . '</MontoTotalLinea>';
            $xmlString .= '</LineaDetalle>';
            $l++;
        }
        $xmlString .= '</DetalleServicio>
        <ResumenFactura>
            <CodigoMoneda>' . $codMoneda . '</CodigoMoneda>
            <TipoCambio>' . $tipoCambio . '</TipoCambio>
            <TotalServGravados>' . $totalServGravados . '</TotalServGravados>
            <TotalServExentos>' . $totalServExentos . '</TotalServExentos>
            <TotalMercanciasGravadas>' . $totalMercGravadas . '</TotalMercanciasGravadas>
            <TotalMercanciasExentas>' . $totalMercExentas . '</TotalMercanciasExentas>
            <TotalGravado>' . $totalGravados . '</TotalGravado>
            <TotalExento>' . $totalExentos . '</TotalExento>
            <TotalVenta>' . $totalVentas . '</TotalVenta>
            <TotalDescuentos>' . $totalDescuentos . '</TotalDescuentos>
            <TotalVentaNeta>' . $totalVentasNeta . '</TotalVentaNeta>
            <TotalImpuesto>' . $totalImp . '</TotalImpuesto>
            <TotalComprobante>' . $totalComprobante . '</TotalComprobante>
        </ResumenFactura>
        <InformacionReferencia>
            <TipoDoc>' . $infoRefeTipoDoc . '</TipoDoc>
            <Numero>' . $infoRefeNumero . '</Numero>
            <FechaEmision>' . $infoRefeFechaEmision . '</FechaEmision>
            <Codigo>' . $infoRefeCodigo . '</Codigo>
            <Razon>' . $infoRefeRazon . '</Razon>
        </InformacionReferencia>
        <Normativa>
            <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>
            <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>
        </Normativa>
        <Otros>
            <OtroTexto>' . $otros . '</OtroTexto>
        </Otros>
    </NotaDebitoElectronica>';

    $arrayResp = base64_encode($xmlString);
       return $arrayResp;
}


//GENERA XML MENSAJE RECEPTOR

function genXMLMR($clave,$NumeroCedulaEmisor,$fechaEmisionDoc,$Mensaje,$DetalleMensaje,$MontoTotalImpuesto,$TotalFactura,
$NumeroCedulaReceptor, $ConsecutivoReceptor) 
{
  
 /*Si el documento(FE,NC,CD) enviado a Hacienda no tenia impuestos cuando se arma el
xml el tag se omite, no lo pinta, de lo contrario se incluye en el xml*/
    if ($MontoTotalImpuesto=="" ) {

        $xmlString = '<?xml version="1.0" encoding="utf-8"?>
        <MensajeReceptor xmlns="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/mensajeReceptor" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/mensajeReceptor">
            <Clave>' . $clave . '</Clave>
            <NumeroCedulaEmisor>' . $NumeroCedulaEmisor . '</NumeroCedulaEmisor>
            <FechaEmisionDoc>' . $fechaEmisionDoc . '</FechaEmisionDoc>
            <Mensaje>' . $Mensaje . '</Mensaje>
            <DetalleMensaje>' . $DetalleMensaje . '</DetalleMensaje>
            <TotalFactura>' . $TotalFactura . '</TotalFactura>
            <NumeroCedulaReceptor>' . $NumeroCedulaReceptor . '</NumeroCedulaReceptor>
            <NumeroConsecutivoReceptor>' . $ConsecutivoReceptor . '</NumeroConsecutivoReceptor>
        </MensajeReceptor>';
        $arrayResp = base64_encode($xmlString);
        return $arrayResp;
        
    } else {
      
       $xmlString2 ='<?xml version="1.0" encoding="utf-8"?>
        <MensajeReceptor xmlns="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/mensajeReceptor" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/mensajeReceptor">
            <Clave>' . $clave . '</Clave>
            <NumeroCedulaEmisor>' . $NumeroCedulaEmisor . '</NumeroCedulaEmisor>
            <FechaEmisionDoc>' . $fechaEmisionDoc . '</FechaEmisionDoc>
            <Mensaje>' . $Mensaje . '</Mensaje>
            <DetalleMensaje>' . $DetalleMensaje . '</DetalleMensaje>
            <MontoTotalImpuesto>' . $MontoTotalImpuesto . '</MontoTotalImpuesto>
            <TotalFactura>' . $TotalFactura . '</TotalFactura>
            <NumeroCedulaReceptor>' . $NumeroCedulaReceptor . '</NumeroCedulaReceptor>
            <NumeroConsecutivoReceptor>' . $ConsecutivoReceptor . '</NumeroConsecutivoReceptor>
        </MensajeReceptor>';
          $arrayResp2 = base64_encode($xmlString2);
        return $arrayResp2;

    }
}

//FUNCION QUE FIRMA EL XML

function signFE($p12Url,$pinP12,$inXml,$tipoDoc) {
    require 'Firmador/Firmadohaciendacr.php';
    //modules_loader("files");
    $p12Url = 'Firmas/010966001806.p12';
    $pinP12 = '1977';
    $inXml = $inXml;
    $tipoDoc = $tipoDoc;
    $tipoDocumento;
    $tipos = array("FE", "ND", "NC", "TE","CCE","CPCE","RCE");
    if (in_array($tipoDoc, $tipos)) {
        switch ($tipoDoc) {
            case 'FE': //Factura Electronica
                $tipoDocumento = "01";
                break;
            case 'ND': // Nota de Debito
                $tipoDocumento = "02";
                break;
            case 'NC': // Nota de Credito
                $tipoDocumento = "03";
                break;
            case 'TE': // Tiquete Electronico
                $tipoDocumento = "04";
                break;
            case 'CCE': // Confirmacion Comprabante Electronico
                $tipoDocumento = "05";
                break;
            case 'CPCE': // Confirmacion Parcial Comprbante Electronico
                $tipoDocumento = "06";
                break;
            case 'RCE': // Rechazo Comprobante Electronico
                $tipoDocumento = "07";
                break;
        }
    } else {
        return "No se encuentra tipo de documento";
    }


    $fac = new Firmadocr();
    //$inXmlUrl debe de ser en Base64 
    //$p12Url es un downloadcode previamente suministrado al subir el certificado en el modulo fileUploader -> subir_certif
    //Tipo es el tipo de documento 
    //01 FE
    //02 ND
    //03 NC
    //04 TE
    //05 06 07 Mensaje Receptor

    $returnFile = $fac->firmar($p12Url, $pinP12, $inXml, $tipoDocumento);
    //$arrayResp = array(
      //  "xmlFirmado" => $returnFile
    //);

    return $returnFile;
}




function EnviaFAC($clave,$fecha,$emi_tipoid,$emi_identificacion,$recp_tipoid, $recp_identificacion, $XMLIN, $token ) {
    
$url = 'https://api.comprobanteselectronicos.go.cr/recepcion-sandbox/v1/recepcion';//URL del SandBox
$datos = array(
'clave' => $clave,
'fecha' => $fecha,
'emisor' => array(
    'tipoIdentificacion' => $emi_tipoid,
    'numeroIdentificacion' => $emi_identificacion
),
'receptor' => array(
    'tipoIdentificacion' => $recp_tipoid,
    'numeroIdentificacion' => $recp_identificacion
),
'comprobanteXml' => $XMLIN
);
//$datosJ= http_build_query($datos);
$mensaje = json_encode($datos);
$header = array(
'Authorization: ' . $token,
'Content-Type: application/json'
);
$curl = curl_init($url);
curl_setopt($curl, CURLOPT_HEADER, true);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "POST");
curl_setopt($curl, CURLOPT_POSTFIELDS, $mensaje);
$respuesta = curl_exec($curl);
$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);


$Estado = $status;
//$arrayResp->{'Status'};

curl_close($curl);

return $Estado;

}



//FUNCION QUE ENVIA EL MENSAJE RECEPTOR
function EnviaMR($clave,$fecha,$emi_tipoid,$emi_identificacion,$recp_tipoid, $recp_identificacion, $XMLIN, $consecutivoReceptor,$token) {
    
    $url = 'https://api.comprobanteselectronicos.go.cr/recepcion-sandbox/v1/recepcion';//URL del SandBox
    $datos = array(
    'clave' => $clave,
    'fecha' => $fecha,
    'emisor' => array(
        'tipoIdentificacion' => $emi_tipoid,
        'numeroIdentificacion' => $emi_identificacion
    ),
    'receptor' => array(
        'tipoIdentificacion' => $recp_tipoid,
        'numeroIdentificacion' => $recp_identificacion
    ),
    'consecutivoReceptor'=>$consecutivoReceptor,
    'comprobanteXml' => $XMLIN
    );
    //$datosJ= http_build_query($datos);
    $mensaje = json_encode($datos);
    $header = array(
    'Authorization: ' . $token,
    'Content-Type: application/json'
    );
    $curl = curl_init($url);
    curl_setopt($curl, CURLOPT_HEADER, true);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
    curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "POST");
    curl_setopt($curl, CURLOPT_POSTFIELDS, $mensaje);
    $respuesta = curl_exec($curl);
    $status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    
    
    $Estado = $status;
    //$arrayResp->{'Status'};
    
    curl_close($curl);
    
    return $Estado;
    
    }


//FUNCION QUE OBTIENE TODOS LOS COMPROBANTES EMITIDOS POR UN EMISOR HACIA 
//CUALQUIER RECEPTOR O UN RECEPTOR ESPECIFICO 

function ObtieneComprobantes($token,
$PosicionInicial,
$Cantidad,
$emisorIdentificacion,
$receptorIdentificacion)
    {
        $url = 'https://api.comprobanteselectronicos.go.cr/recepcion-sandbox/v1/comprobantes';//URL del SandBox
        
        $builtHeader = array(
            'Authorization: ' . $token,
            'Content-Type: application/json',
            'emisor:' .$emisorIdentificacion, //se debe enviar en formato tipoid mas cedula de 12.  01000109660018
            'receptor: ' .$receptorIdentificacion,
            'offset: ' .$PosicionInicial,
            'limit: ' .$Cantidad            
             );

             $options = array(
                'http' => array(
                    'header'  => $builtHeader,
                    'method'  => 'GET'
                )
            );

                   
             $context  = stream_context_create($options);
             $result = file_get_contents($url, false, $context);        
             if (!$result = file_get_contents($url, false, $context)) {
             $error = error_get_last();
             return new soap_fault('99',"Error","Error en el llamado :", $error['message']);
             } else {
             

             
             $salida = json_to_xml($result);
            
             return $salida;


             }

    
        
    }


include("XML/Serializer.php");

function json_to_xml($json) {

    $serializer_options = array (
        'addDecl' => TRUE,
        'encoding' => 'UTF-8',
        'indent' => '',
        'rootName' => 'TramaOutput',
        'mode' => 'simplexml'
      );
    $serializer = new XML_Serializer($serializer_options);
    $obj = json_decode($json);

         

    if ($serializer->serialize($obj)) {
        return $serializer->getSerializedData();
    }
    else {
        return null;
    }
}

    

function ConsultaComprobante($clave, $token)
    {
        $url = 'https://api.comprobanteselectronicos.go.cr/recepcion-sandbox/v1/recepcion/'.$clave;//URL del SandBox
        
        $builtHeader = array(
        'Authorization: ' . $token,
        'Content-Type: application/json'
         );

        $options = array(
            'http' => array(
                'header'  => $builtHeader,
                'method'  => 'GET'
            )
        );

        $context  = stream_context_create($options);
        $result = file_get_contents($url, false, $context);        
        if (!$result = file_get_contents($url, false, $context)) {
        $error = error_get_last();
        return new soap_fault('99',"Error","Error en el llamado :", $error['message']);
        } else {
            $salida = json_to_xml($result);
            
            return $salida;
        }

        
    }

//Obtiene de Hacienda la informacion de una factura

function ObtieneFactura($clave, $token)
    {
        $url = 'https://api.comprobanteselectronicos.go.cr/recepcion-sandbox/v1/Comprobantes/'.$clave;//URL del SandBox
        
              $builtHeader = array(
            'Authorization: ' . $token,
            'Content-Type: application/json'
             );
    
            $options = array(
                'http' => array(
                    'header'  => $builtHeader,
                    'method'  => 'GET'
                )
            );
    
            $context  = stream_context_create($options);
            $result = file_get_contents($url, false, $context);  
            $json_data = json_decode($result, true);

            if($json_data === NULL) 
            
             {
            $error = error_get_last();
            return new soap_fault('99',"Error","Error en el llamado :", $error['message']);
            } else {
             $EstadoC = json_decode($result);
             /* $ClaveR = $EstadoC->{'clave'};
             $FechaR = $EstadoC->{'fecha'};
             $EmisorR = $EstadoC->{'emisor'};
             $ReceptorR = $EstadoC->{'receptor'};
             $NotasCredito=$EstadoC->{'notasCredito'};
             $NotasDebito=$EstadoC->{'notasDebito'};


             $Emisordata =  json_encode($EmisorR);
             $EmisorC = json_decode($Emisordata);
         
             $TipoIDEmisor = $EmisorC->{'tipoIdentificacion'};
             $IdEmisor =  $EmisorC->{'numeroIdentificacion'};
             $NombreEmi = $EmisorC->{'nombre'};

             $Receptordata =  json_encode($ReceptorR);
             $ReceptorC = json_decode($Receptordata);

             $TipoIDReceptor = $ReceptorC->{'tipoIdentificacion'};
             $IdReceptor =  $ReceptorC->{'numeroIdentificacion'};
             $NombreReceptor = $ReceptorC->{'nombre'}; */

             //return array($ClaveR,$FechaR, $TipoIDEmisor,$IdEmisor,$NombreEmi,$TipoIDReceptor,$IdReceptor,$NombreReceptor);
            
             $salida = json_to_xml($result);
            
             return $salida;
            
            }
        

        
    }

    

// Publicación de los Servicios en SOAP

$ns = "http://127.0.0.1/ServicioFE";
$soapclient->configureWSDL('AplicacionDeServiciosFE', $ns);
$soapclient->wsdl->schemaTargetNamespace = $ns;


$soapclient->register('tokenAuth',
array('usuarioFE' => 'xsd:string', 'Pass'=>'xsd:string' ),
array('Token' => 'xsd:string', 'Expires_in'=> 'xsd:string', 'Refresh_expires_in'=> 'xsd:string', 'Refresh_token'=> 'xsd:string', 'token_type'=> 'xsd:string', 'ID_token'=> 'xsd:string'),
$ns);

$soapclient->register('tokenRefreshAuth',
array('usuarioFE' => 'xsd:string', 'Pass'=>'xsd:string','RToken'=>'xsd:string' ),
array('Token' => 'xsd:string', 'Expires_in'=> 'xsd:string', 'Refresh_expires_in'=> 'xsd:string', 'Refresh_token'=> 'xsd:string', 'token_type'=> 'xsd:string', 'ID_token'=> 'xsd:string'),
$ns);


//$clave,$consecutivo ,$fechaEmision ,$emisorNombre ,$emisorTipoIdentif ,$emisorNumIdentif ,$nombreComercial ,$emisorProv ,
//$meisorCanton ,$emisorDistrito ,$emisorBarrio ,$emisorOtrasSenas ,$emisorCodPaisTel ,$emisorTel ,$emisorCodPaisFax ,$emisorFax ,
//$emisorEmail ,$receptorNombre ,$receptorTipoIdentif ,$recenprotNumIdentif ,$receptorProvincia ,$receptorCanton ,$receptorDistrito ,
//$receptorBarrio ,$receptorOtrasSenas ,$receptorCodPaisTel ,$receptorTel ,$receptorCodPaisFax ,$receptorFax ,$receptorEmail ,
//$condVenta ,$plazoCredito ,$medioPago ,$codMoneda ,$tipoCambio ,$totalServGravados ,$totalServExentos ,$totalMercGravadas ,$totalMercExentas ,
//$totalGravados ,$totalExentos ,$totalVentas ,$totalDescuentos ,$totalVentasNeta ,$totalImp ,$totalComprobante ,$otros,$detalles
#Configuramos el array para los detalles
$soapclient->wsdl->
addComplexType('detalleA', 'complexType', 'struct', 'all', '', 
array('linea' => array('linea' => 'linea', 'type' => 'xsd:int')));

$soapclient->wsdl->
addComplexType('EmisorTC', 'complexType', 'struct', 'all', '', 
array('tipoIdentificacion' => array('tipoIdentificacion' => 'tipoIdentificacion', 'type' => 'xsd:string'))

);

/*{"1":{
    "cantidad":"1",
    "unidadMedida":"Sp",
    "detalle":"DESARROLLO",
    "precioUnitario":"65",
    "montoTotal":"65",
    "subtotal":"65",
    "montoTotalLinea":"65"}
}*/

//SOAP FACTURAELECTRONICA
$soapclient->register('genXMLFe', array(
    'clave' => 'xsd:string',
    'consecutivo' => 'xsd:string',
    'fechaEmision' => 'xsd:string',
    'emisorNombre' => 'xsd:string',
    'emisorTipoIdentif' => 'xsd:string',
    'emisorNumIdentif' => 'xsd:string',
    'nombreComercial' => 'xsd:string',
    'emisorProv' => 'xsd:string',
    'meisorCanton' => 'xsd:string',
    'emisorDistrito' => 'xsd:string',
    'emisorBarrio' => 'xsd:string',
    'emisorOtrasSenas' => 'xsd:string',
    'emisorCodPaisTel' => 'xsd:string',
    'emisorTel' => 'xsd:string',
    'emisorCodPaisFax' => 'xsd:string',
    'emisorFax' => 'xsd:string',
    'emisorEmail' => 'xsd:string',
    'receptorNombre' => 'xsd:string', 
    'receptorTipoIdentif' => 'xsd:string',
    'recenprotNumIdentif' => 'xsd:string',
    'receptorProvincia' => 'xsd:string',
    'receptorCanton' => 'xsd:string',
    'receptorDistrito' => 'xsd:string',
    'receptorBarrio' => 'xsd:string',
    'receptorOtrasSenas' => 'xsd:string',
    'receptorCodPaisTel' => 'xsd:string',
    'receptorTel' => 'xsd:string',
    'receptorCodPaisFax' => 'xsd:string',
    'receptorFax' => 'xsd:string',
    'receptorEmail' => 'xsd:string',
    'condVenta' => 'xsd:string',
    'plazoCredito' => 'xsd:string',
    'medioPago' => 'xsd:string',
    'codMoneda' => 'xsd:string',
    'tipoCambio' => 'xsd:string',
    'totalServGravados' => 'xsd:string',
    'totalServExentos' => 'xsd:string',
    'totalMercGravadas' => 'xsd:string',
    'totalMercExentas' => 'xsd:string',
    'totalGravados' => 'xsd:string',
    'totalExentos' => 'xsd:string',
    'totalVentas' => 'xsd:string',
    'totalDescuentos' => 'xsd:string',
    'totalVentasNeta' => 'xsd:string',
    'totalImp' => 'xsd:string',
    'totalComprobante' => 'xsd:string',
    'infoRefeTipoDoc' => 'xsd:string',
    'infoRefeNumero' => 'xsd:string',
    'infoRefeFechaEmision' => 'xsd:string',
    'infoRefeCodigo' => 'xsd:string',
    'infoRefeRazon' => 'xsd:string',
    'otros'=> 'xsd:string',
    'detalles'=> 'xsd:string'
    ), array(
        'Factura' => 'xsd:string'
    ), $ns);


//SOAP TIQUETE ELECTRONICO

$soapclient->register('genXMLTe', array(
    'clave' => 'xsd:string',
    'consecutivo' => 'xsd:string',
    'fechaEmision' => 'xsd:string',
    'emisorNombre' => 'xsd:string',
    'emisorTipoIdentif' => 'xsd:string',
    'emisorNumIdentif' => 'xsd:string',
    'nombreComercial' => 'xsd:string',
    'emisorProv' => 'xsd:string',
    'meisorCanton' => 'xsd:string',
    'emisorDistrito' => 'xsd:string',
    'emisorBarrio' => 'xsd:string',
    'emisorOtrasSenas' => 'xsd:string',
    'emisorCodPaisTel' => 'xsd:string',
    'emisorTel' => 'xsd:string',
    'emisorCodPaisFax' => 'xsd:string',
    'emisorFax' => 'xsd:string',
    'emisorEmail' => 'xsd:string',
    'receptorNombre' => 'xsd:string',
    'receptorTipoIdentif' => 'xsd:string',
    'receptorNumIdentif' => 'xsd:string',
    'receptorProvincia' => 'xsd:string',
    'receptorCanton' => 'xsd:string',
    'receptorDistrito' => 'xsd:string',
    'receptorBarrio' => 'xsd:string',
    'receptorOtrasSenas' => 'xsd:string',
    'receptorCodPaisTel' => 'xsd:string',
    'receptorTel' => 'xsd:string',
    'receptorCodPaisFax' => 'xsd:string',
    'receptorFax' => 'xsd:string',
    'receptorEmail' => 'xsd:string',
    'condVenta' => 'xsd:string',
    'plazoCredito' => 'xsd:string',
    'medioPago' => 'xsd:string',
    'codMoneda' => 'xsd:string',
    'tipoCambio' => 'xsd:string',
    'totalServGravados' => 'xsd:string',
    'totalServExentos' => 'xsd:string',
    'totalMercGravadas' => 'xsd:string',
    'totalMercExentas' => 'xsd:string',
    'totalGravados' => 'xsd:string',
    'totalExentos' => 'xsd:string',
    'totalVentas' => 'xsd:string',
    'totalDescuentos' => 'xsd:string',
    'totalVentasNeta' => 'xsd:string',
    'totalImp' => 'xsd:string',
    'totalComprobante' => 'xsd:string',
    'infoRefeTipoDoc' => 'xsd:string',
    'infoRefeNumero' => 'xsd:string',
    'infoRefeFechaEmision' => 'xsd:string',
    'infoRefeCodigo' => 'xsd:string',
    'infoRefeRazon' => 'xsd:string',
    'otros' => 'xsd:string',
    'detalles' => 'xsd:string',
    ), array(
        'Tiquete' => 'xsd:string'
    ), $ns);


//SOAP NOTACREDITO
$soapclient->register('genXMLNC', array(
'clave' => 'xsd:string',
'consecutivo' => 'xsd:string',
'fechaEmision' => 'xsd:string',
'emisorNombre' => 'xsd:string',
'emisorTipoIdentif' => 'xsd:string',
'emisorNumIdentif' => 'xsd:string',
'nombreComercial' => 'xsd:string',
'emisorProv' => 'xsd:string',
'meisorCanton' => 'xsd:string',
'emisorDistrito' => 'xsd:string',
'emisorBarrio' => 'xsd:string',
'emisorOtrasSenas' => 'xsd:string',
'emisorCodPaisTel' => 'xsd:string',
'emisorTel' => 'xsd:string',
'emisorCodPaisFax' => 'xsd:string',
'emisorFax' => 'xsd:string',
'emisorEmail' => 'xsd:string',
'receptorNombre' => 'xsd:string',
'receptorTipoIdentif' => 'xsd:string',
'recenprotNumIdentif' => 'xsd:string',
'receptorProvincia' => 'xsd:string',
'receptorCanton' => 'xsd:string',
'receptorDistrito' => 'xsd:string',
'receptorBarrio' => 'xsd:string',
'receptorOtrasSenas' => 'xsd:string',
'receptorCodPaisTel' => 'xsd:string',
'receptorTel' => 'xsd:string',
'receptorCodPaisFax' => 'xsd:string',
'receptorFax' => 'xsd:string',
'receptorEmail' => 'xsd:string',
'condVenta' => 'xsd:string',
'plazoCredito' => 'xsd:string',
'medioPago' => 'xsd:string',
'codMoneda' => 'xsd:string',
'tipoCambio' => 'xsd:string',
'totalServGravados' => 'xsd:string',
'totalServExentos' => 'xsd:string',
'totalMercGravadas' => 'xsd:string',
'totalMercExentas' => 'xsd:string',
'totalGravados' => 'xsd:string',
'totalExentos' => 'xsd:string',
'totalVentas' => 'xsd:string',
'totalDescuentos' => 'xsd:string',
'totalVentasNeta' => 'xsd:string',
'totalImp' => 'xsd:string',
'totalComprobante' => 'xsd:string',
'otros' => 'xsd:string',
'infoRefeTipoDoc' => 'xsd:string',
'infoRefeNumero' => 'xsd:string',
'infoRefeFechaEmision' => 'xsd:string',
'infoRefeCodigo' => 'xsd:string',
'infoRefeRazon' => 'xsd:string',
'detalles' => 'xsd:string',
),array(
    'NotaCredito' => 'xsd:string'
), $ns);


//SOAP NOTADEBITO
$soapclient->register('genXMLND', array(
    'clave' => 'xsd:string',
    'consecutivo' => 'xsd:string',
    'fechaEmision' => 'xsd:string',
    'emisorNombre' => 'xsd:string',
    'emisorTipoIdentif' => 'xsd:string',
    'emisorNumIdentif' => 'xsd:string',
    'nombreComercial' => 'xsd:string',
    'emisorProv' => 'xsd:string',
    'meisorCanton' => 'xsd:string',
    'emisorDistrito' => 'xsd:string',
    'emisorBarrio' => 'xsd:string',
    'emisorOtrasSenas' => 'xsd:string',
    'emisorCodPaisTel' => 'xsd:string',
    'emisorTel' => 'xsd:string',
    'emisorCodPaisFax' => 'xsd:string',
    'emisorFax' => 'xsd:string',
    'emisorEmail' => 'xsd:string',
    'receptorNombre' => 'xsd:string',
    'receptorTipoIdentif' => 'xsd:string',
    'recenprotNumIdentif' => 'xsd:string',
    'receptorProvincia' => 'xsd:string',
    'receptorCanton' => 'xsd:string',
    'receptorDistrito' => 'xsd:string',
    'receptorBarrio' => 'xsd:string',
    'receptorOtrasSenas' => 'xsd:string',
    'receptorCodPaisTel' => 'xsd:string',
    'receptorTel' => 'xsd:string',
    'receptorCodPaisFax' => 'xsd:string',
    'receptorFax' => 'xsd:string',
    'receptorEmail' => 'xsd:string',
    'condVenta' => 'xsd:string',
    'plazoCredito' => 'xsd:string',
    'medioPago' => 'xsd:string',
    'codMoneda' => 'xsd:string',
    'tipoCambio' => 'xsd:string',
    'totalServGravados' => 'xsd:string',
    'totalServExentos' => 'xsd:string',
    'totalMercGravadas' => 'xsd:string',
    'totalMercExentas' => 'xsd:string',
    'totalGravados' => 'xsd:string',
    'totalExentos' => 'xsd:string',
    'totalVentas' => 'xsd:string',
    'totalDescuentos' => 'xsd:string',
    'totalVentasNeta' => 'xsd:string',
    'totalImp' => 'xsd:string',
    'totalComprobante' => 'xsd:string',
    'otros' => 'xsd:string',
    'infoRefeTipoDoc' => 'xsd:string',
    'infoRefeNumero' => 'xsd:string',
    'infoRefeFechaEmision' => 'xsd:string',
    'infoRefeCodigo' => 'xsd:string',
    'infoRefeRazon' => 'xsd:string',
    'detalles' => 'xsd:string',
    ),array(
        'NotaDebito' => 'xsd:string'
    ), $ns);

    //SOAP NOTADEBITO

$soapclient->register('genXMLMR', array(
        'clave' => 'xsd:string',
        'NumeroCedulaEmisor' => 'xsd:string' ,
        'fechaEmisionDoc' => 'xsd:string',
        'Mensaje' => 'xsd:string',
        'DetalleMensaje' => 'xsd:string',
        'MontoTotalImpuesto' => 'xsd:string',
        'TotalFactura' => 'xsd:string',
        'NumeroCedulaReceptor' => 'xsd:string',
        'ConsecutivoReceptor' => 'xsd:string',
    ), array(
        'MensajeReceptor' => 'xsd:string'
    ), $ns);   

$soapclient->register('signFE', array(
    'p12Url' => 'xsd:string','pinP12' => 'xsd:string' ,'inXml' => 'xsd:string','tipoDoc' => 'xsd:string'
), array(
    'xmlOUT' => 'xsd:string'
), $ns);


$soapclient->register('EnviaFAC',
array('clave' => 'xsd:string', 'fecha'=>'xsd:string','emi_tipoid'=>'xsd:string','emi_identificacion'=>'xsd:string','recp_tipoid'=>'xsd:string','recp_identificacion'=>'xsd:string','XMLIN'=>'xsd:string','token'=>'xsd:string' ),
array('Estado' => 'xsd:string'),
$ns);


$soapclient->register('EnviaMR',
array('clave' => 'xsd:string', 'fecha'=>'xsd:string','emi_tipoid'=>'xsd:string','emi_identificacion'=>'xsd:string','recp_tipoid'=>'xsd:string','recp_identificacion'=>'xsd:string','XMLIN'=>'xsd:string','consecutivoReceptor'=>'xsd:string','token'=>'xsd:string' ),
array('Estado' => 'xsd:string'),
$ns);

//CONSULTA EL ESTADO DEL COMPROBANTE EN HACIENDA

$soapclient->register('ConsultaComprobante',
array('clave' => 'xsd:string', 'token'=>'xsd:string' ),
array('Respuesta' => 'xsd:string'),
$ns);

//CONSULTA TODOS LOS COMPROBANTES EMITIDOS POR EL EMISOR 
$soapclient->register('ObtieneComprobantes',
array(
'token'=>'xsd:string',
'PosicionInicial' => 'xsd:string',
'Cantidad' => 'xsd:string',
'emisorIdentificacion' => 'xsd:string',
'receptorIdentificacion' => 'xsd:string'
  ),
array(
    'Resultado' => 'xsd:string'
//'Clave' => 'xsd:string',
//'Fecha' => 'xsd:string',
//'Emisor' => 'xsd:string',
//'Receptor' => 'xsd:string',
//'NotasCredito' => 'xsd:string',
//'NotasDedito' => 'xsd:string'
),
$ns);


//OBTIENE FACTURA

$soapclient->register('ObtieneFactura',
array('clave' => 'xsd:string', 'token'=>'xsd:string' ),
array('Comprobante' => 'xsd:string'
//,
/* 'Fecha' => 'xsd:string',
'TipoIDEmisor' => 'xsd:string',
'IDEmisor' => 'xsd:string',
'NombreEmisor' => 'xsd:string',
'TipoIDReceptor' => 'xsd:string',
'IDReceptor' => 'xsd:string',
'NombreReceptor' => 'xsd:string' */
),
$ns);





if (isset($HTTP_RAW_POST_DATA)) {
    $input = $HTTP_RAW_POST_DATA;
} else {
    $input = implode("\r\n", file('php://input'));
}
$soapclient->service($input);

exit;



?>