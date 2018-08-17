<?php

	$conexion = new mysqli("167.114.58.131", "dbsolventas", "dbsolventas", "dbsolventas");
	
	if (mysqli_connect_errno()) {
	    printf("Connect failed: %s\n", mysqli_connect_error());
	    exit();
	}
