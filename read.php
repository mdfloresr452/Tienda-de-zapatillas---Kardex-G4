<?php
include('config.php'); // Incluye el archivo de configuración de la base de datos
include('navbar.php');

// Llama al procedimiento almacenado para mostrar usuarios
$sql = "CALL MostrarUsuario()";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<h1>Usuarios</h1>";
    echo "<table border='1'>
        <tr>
            <th>DNI</th>
            <th>Nombre</th>
            <th>Género</th>
            <th>Rol</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>
            <td>" . $row['DNI'] . "</td>
            <td>" . $row['Nombre'] . "</td>
            <td>" . $row['Genero'] . "</td>
            <td>" . $row['Rol'] . "</td>
            <td>" . $row['Estado'] . "</td>
            <td>
                <a href='update.php?dni=" . $row['DNI'] . "'>Actualizar</a> |
                <a href='delete.php?dni=" . $row['DNI'] . "'>Eliminar</a>
            </td>
        </tr>";
    }

    echo "</table>";
} else {
    echo "No se encontraron usuarios.";
}

$conn->close();
?>
