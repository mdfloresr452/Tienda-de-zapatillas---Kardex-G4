<?php
include('config.php'); // Incluye el archivo de configuración de la base de datos

// Verifica si se ha enviado el formulario
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $dni = $_POST['dni'];

    // Llama al procedimiento almacenado para eliminar el usuario
    $sql = "CALL EliminarUsuario($dni)";

    if ($conn->query($sql) === TRUE) {
        header("Location: read.php"); // Redirige de nuevo a la página de lectura después de la eliminación
    } else {
        echo "Error al eliminar el usuario: " . $conn->error;
    }
}

// Obtén el DNI del usuario a eliminar desde la URL
$dniToDelete = $_GET['dni'];

// Consulta para obtener los datos del usuario
$sql = "SELECT Usua_Nombres FROM Usuario WHERE Usua_Dni = $dniToDelete";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $nombre = $row['Usua_Nombres'];
} else {
    echo "Usuario no encontrado.";
}
$conn->close();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Eliminar Usuario</title>
</head>
<body>
    <h1>Eliminar Usuario</h1>
    <p>¿Estás seguro de que deseas eliminar al usuario <?php echo $nombre; ?>?</p>
    <form method="POST" action="delete.php">
        <input type="hidden" name="dni" value="<?php echo $dniToDelete; ?>">
        <input type="submit" value="Eliminar">
        <a href="read.php">Cancelar</a>
    </form>
</body>
</html>
