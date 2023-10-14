<?php
include('config.php'); // Incluye el archivo de configuración de la base de datos
include('navbar.php');
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $dni = $_POST['dni'];
    $nombres = $_POST['nombres'];
    $contrasenha = $_POST['contrasenha'];
    $generoId = $_POST['generoId'];
    $regionId = $_POST['regionId'];
    $rolId = $_POST['rolId'];
    $estadoId = $_POST['estadoId'];

    // Verificar que los campos requeridos estén completos
    if (!empty($dni) && !empty($nombres) && !empty($contrasenha) && !empty($generoId) && !empty($regionId) && !empty($rolId) && !empty($estadoId)) {
        $saldo = 0.00; // Establece el saldo predeterminado en 0.00

        // Llama al procedimiento almacenado para insertar un nuevo usuario
        $sql = "CALL InsertarUsuario($dni, '$nombres', '$contrasenha', $saldo, $generoId, $regionId, $rolId, $estadoId)";

        if ($conn->query($sql) === TRUE) {
            header("Location: read.php"); // Redirige al usuario a read.php
        } else {
            echo "Error al insertar usuario: " . $conn->error;
        }
    } else {
        echo "Por favor, complete todos los campos del formulario.";
    }
}

// Consulta para obtener datos de las tablas Genero, Departamento, Rol y Estado
$generoQuery = "SELECT IdGenero, Gene_Sexo FROM Genero";
$departamentoQuery = "SELECT IdDepartamento, Regi_Nombre FROM Departamento";
$rolQuery = "SELECT IdRol, Rol_Nombre FROM Rol";
$estadoQuery = "SELECT IdEstado, Esta_Estatus FROM Estado";

$resultGenero = $conn->query($generoQuery);
$resultDepartamento = $conn->query($departamentoQuery);
$resultRol = $conn->query($rolQuery);
$resultEstado = $conn->query($estadoQuery);

$conn->close();
?>
<!DOCTYPE html>
<html>
<head>
    <title>Insertar Usuario</title>
</head>
<body>
    <h1>Formulario para Insertar Usuario</h1>
    <form method="POST" action="create.php">
        <label>DNI:</label>
        <input type="text" name="dni" required><br>

        <label>Nombres:</label>
        <input type="text" name="nombres" required><br>

        <label>Contraseña:</label>
        <input type="password" name="contrasenha" required><br>

        <!-- El saldo se establece predeterminadamente en 0.00 (invisible) -->
        <input type="hidden" name="saldo" value="0.00">

        <label>Género:</label>
        <select name="generoId" required>
            <?php
            while ($row = $resultGenero->fetch_assoc()) {
                echo "<option value='" . $row['IdGenero'] . "'>" . $row['Gene_Sexo'] . "</option>";
            }
            ?>
        </select><br>

        <label>Región:</label>
        <select name="regionId" required>
            <?php
            while ($row = $resultDepartamento->fetch_assoc()) {
                echo "<option value='" . $row['IdDepartamento'] . "'>" . $row['Regi_Nombre'] . "</option>";
            }
            ?>
        </select><br>

        <label>Rol:</label>
        <select name="rolId" required>
            <?php
            while ($row = $resultRol->fetch_assoc()) {
                echo "<option value='" . $row['IdRol'] . "'>" . $row['Rol_Nombre'] . "</option>";
            }
            ?>
        </select><br>

        <label>Estado:</label>
        <select name="estadoId" required>
            <?php
            while ($row = $resultEstado->fetch_assoc()) {
                echo "<option value='" . $row['IdEstado'] . "'>" . $row['Esta_Estatus'] . "</option>";
            }
            ?>
        </select><br>

        <input type="submit" value="Insertar Usuario">
    </form>
</body>
</html>
