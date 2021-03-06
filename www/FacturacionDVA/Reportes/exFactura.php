<?php
// (c) Xavier Nicolay
// Exemple de g�n�ration de devis/facture PDF

require('Factura.php');

session_start();

//$lo = $_SESSION["logo"];

require_once "../model/Configuracion.php";

      $objConf = new Configuracion();

      $query_conf = $objConf->Listar();

      $regConf = $query_conf->fetch_object();

require_once "../model/Pedido.php";

$objPedido = new Pedido();


$query_cli = $objPedido->GetVenta($_GET["id"]);

        $reg_cli = $query_cli->fetch_object();

$f = "";

      if ($_SESSION["superadmin"] == "S") {
        $f = $regConf->logo;
      } else {
        $f = $reg_cli->logo;
      }

      $archivo = $f; 
      $trozos = explode(".", $archivo); 
      $extension = end($trozos);

//QR
require "phpqrcode/qrlib.php";    
	
	//Declaramos una carpeta temporal para guardar la imagenes generadas
	$dir = 'temp/';
	
	//Si no existe la carpeta la creamos
	if (!file_exists($dir))
        mkdir($dir);
	
        //Declaramos la ruta y nombre del archivo a generar
	$filename = $dir.'test.png';
 
        //Parametros de Condiguración
	
	$tamaño = 5; //Tamaño de Pixel
	$level = 'H'; //Precisión Baja
  $framSize = 15; //Tamaño en blanco
  $contenido = $reg_cli->clave;
	//$contenido = "50631071800010966001800100001011522774568107756568"; //Clave 50 campos FE,NC,ND,TE
	
        //Enviamos los parametros a la Función para generar código QR 
  QRcode::png($contenido, $filename, $level, $tamaño, $framSize); 
  
  $Q = "";
    
        $Q = $filename;

      $archivoQ = $Q; 
      $trozosQ = explode(".", $archivoQ); 
      $extensionQ = end($trozosQ);
	
	   //Mostrar el codigo del QR Generado
	  // echo '<img src="'.$dir.basename($filename).'" /><hr/>';
	
        //Mostramos la imagen generada
	//echo '<img src="'.$dir.basename($filename).'" /><hr/>';
      $qrimage= $filename;
      

$pdf = new PDF_Invoice( 'P', 'mm', 'A4' );
$pdf->AddPage();
$pdf->addSociete( utf8_decode($reg_cli->razon_social),
                  utf8_decode("$reg_cli->num_sucursal")."\n" .
                  "Direccion:".utf8_decode(" $reg_cli->direccion")."\n".
                  "Telefono: ".utf8_decode("$reg_cli->telefono_suc")."\n" .
                  "email : $reg_cli->email_suc ",
                  "../$f",
                  "$extension");
$pdf->addQR("$qrimage","$extensionQ");

$pdf->fact_dev( "Factura Electronica ", "$reg_cli->serie_comprobante-$reg_cli->num_comprobante" );
$pdf->temporaire( "" );
$pdf->addDate( $reg_cli->fecha);
$pdf->addClave( $reg_cli->clave);
$pdf->addTIpoVenta( $reg_cli->tipo_venta);
//$pdf->addClient("CL01");
//$pdf->addPageNumber("1");

$pdf->addClientAdresse(utf8_decode($reg_cli->nombre),"Domicilio: ".utf8_decode($reg_cli->direccion_calle)." - ".utf8_decode($reg_cli->direccion_departamento),$reg_cli->doc.": ".$reg_cli->num_documento,"Email: ".$reg_cli->email,"Telefono: ".$reg_cli->telefono);
//$pdf->addReglement("Soluciones Innovadoras Per� S.A.C.");
//$pdf->addEcheance("RUC","2147715777");
//$pdf->addNumTVA("Chongoyape, Jos� G�lvez 1368");
//$pdf->addReference("Devis ... du ....");
$cols=array( "CODIGO"    => 23,
             "DESCRIPCION"  => 78,
             "CANTIDAD"     => 22,
             "P.U."      => 25,
             "DSCTO" => 20,
             "SUBTOTAL"          => 22 );
$pdf->addCols( $cols);
$cols=array( "CODIGO"    => "L",
             "DESCRIPCION"  => "L",
             "CANTIDAD"     => "C",
             "P.U."      => "R",
             "DSCTO" => "R",
             "SUBTOTAL"          => "C" );
$pdf->addLineFormat( $cols);
$pdf->addLineFormat($cols);

$y    = 89;

$query_ped = $objPedido->ImprimirDetallePedido($_GET["id"]);

        while ($reg = $query_ped->fetch_object()) {

            $line = array( "CODIGO"    => "'$reg->codigo'",
                           "DESCRIPCION"  => utf8_decode("$reg->articulo Serie:$reg->serie"),
                           "CANTIDAD"     => "$reg->cantidad",
                           "P.U."      => "$reg->precio_venta",
                           "DSCTO" => "$reg->descuento",
                           "SUBTOTAL"          => "$reg->sub_total");
            $size = $pdf->addLine( $y, $line );
            $y   += $size + 2;
        }

$query_total = $objPedido->TotalPedido($_GET["id"]);

$reg_total = $query_total->fetch_object();

require_once "../ajax/Letras.php";

 $V=new EnLetras(); 
 $con_letra=strtoupper($V->ValorEnLetras($reg_total->Total,"Colones")); 
 $Resolucion = "AUTORIZADO MEDIANTE RESOLUCION NUMERO DGR-R-48-2016 DEL 7 OCTUBRE 2016";
//$pdf->addCadreTVAs("---TRES MILLONES CUATROCIENTOS CINCUENTA Y UN MIL DOSCIENTOS CUARENTA PESOS 00/100 M.N.");
 $pdf->addCadreTVAs($Resolucion);


require_once "../model/Configuracion.php";

$objConfiguracion = new Configuracion();


$query_global = $objConfiguracion->Listar();

$reg_igv = $query_global->fetch_object();

$pdf->addTVAs( $reg_cli->impuesto, $reg_total->Total,$reg_igv->simbolo_moneda );
$pdf->addCadreEurosFrancs("$reg_igv->nombre_impuesto". "$reg_cli->impuesto%");
$pdf->Output('Factura','I');
$pdf->Output("DocumentosPDF/".$contenido.".pdf",'F');

?>
