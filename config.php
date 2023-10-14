<?php
    $servername = "srv1006.hstgr.io";
    $username = "u472469844_grupo4";
    $password = "kYEvmvo7";
    $database = "u472469844_grupo4";

    // Conexión a la base de datos
    $conn = new mysqli($servername, $username, $password, $database);

    if ($conn->connect_error) {
        die("Conexión fallida: " . $conn->connect_error);
    }
?>