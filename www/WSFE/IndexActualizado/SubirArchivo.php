<?php


//OBTENEMOS LA EXTENSION DEL ARCHIVO PARA VALIDARLA

$Nombre =  $_FILES['archivo']['name']; 

// sin sensibilidad a letras mayúsculas ni minúsculas 
$patron = "%\.(p12)$%i"; 
// Ejemplo de visualización del resultado 
$ExtArchivo= preg_match($patron, $Nombre) == 1 ? 'valido' : 'invalido';


function FileUploadErrorMsg($error_code) {
  switch ($error_code) { 
      case UPLOAD_ERR_INI_SIZE: 
          return "El archivo es más grande que lo permitido por el Servidor."; 
      case UPLOAD_ERR_FORM_SIZE: 
          return "El archivo subido es demasiado grande."; 
      // case UPLOAD_ERR_PARTIAL: 
          return "El archivo subido no se terminó de cargar (probablemente cancelado por el usuario)."; 
      case UPLOAD_ERR_NO_FILE: 
          return "No se subió ningún archivo"; 
      case UPLOAD_ERR_NO_TMP_DIR: 
          return "Error del servidor: Falta el directorio temporal."; 
      case UPLOAD_ERR_CANT_WRITE: 
          return "Error del servidor: Error de escritura en disco"; 
      case UPLOAD_ERR_EXTENSION: 
          return "Error del servidor: Subida detenida por la extención";
    default: 
          return "Error del servidor: ".$error_code; 
  } 
}


//Validamos los errores

if ($_FILES["archivo"]["error"] > 0) {
echo FileUploadErrorMsg($_FILES["archivo"]["error"]);
exit;
}


//Validamos que la extension sea de tipo".p12"

if ($ExtArchivo != 'valido'){
  echo "La extensión del archivo debe de ser .p12";
  exit;}

else {
echo "Nombre del Archivo: " . $_FILES['archivo']['name'] . "<br>"."<br>";  
echo "!!Archivo cargado correctamente!!";
}


move_uploaded_file($_FILES['archivo']['tmp_name'],

"subidas/" . $_FILES['archivo']['name']) 
?>