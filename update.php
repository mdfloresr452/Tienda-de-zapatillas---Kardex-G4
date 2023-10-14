<?php
include('config.php'); // Incluye el archivo de configuración de la base de datos
include('navbar.php');

// Verifica si se ha enviado el formulario
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Obtiene los valores del formulario
    $dni = $_POST['dni']; // DNI no se actualiza
    $nombres = $_POST['nombres'];
    $contrasenha = $_POST['contrasenha'];
    $saldo = $_POST['saldo']; // Saldo se mantiene igual
    $generoId = $_POST['generoId'];
    $regionId = $_POST['regionId'];
    $rolId = $_POST['rolId'];
    $estadoId = $_POST['estadoId'];

    // Llama al procedimiento almacenado para actualizar el usuario
    $sql = "CALL ActualizarUsuario($dni, '$nombres', '$contrasenha', $saldo, $generoId, $regionId, $rolId, $estadoId)";

    if ($conn->query($sql) === TRUE) {
        // Redirecciona a read.php
        header("Location: read.php");
        exit; // Asegura que el script se detenga aquí
    } else {
        echo "Error al actualizar usuario: " . $conn->error;
    }
}

// Obtén el DNI del usuario a actualizar desde la URL
$dniToUpdate = $_GET['dni'];

// Verifica si el DNI es válido
if (isset($dniToUpdate) && is_numeric($dniToUpdate)) {
    // Consulta para obtener los datos del usuario
    $sql = "SELECT * FROM Usuario WHERE Usua_Dni = $dniToUpdate";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $nombres = $row['Usua_Nombres'];
        $saldo = $row['Usua_Saldo'];
        $generoId = $row['Usua_IdGenero'];
        $regionId = $row['Usua_IdRegion'];
        $rolId = $row['Usua_IdRol'];
        $estadoId = $row['Usua_IdEstado'];
    } else {
        echo "Usuario no encontrado.";
    }
} else {
    echo "DNI no válido.";
}

// Consultas para obtener datos de las tablas Genero, Departamento, Rol y Estado
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
    <title>Actualizar Usuario</title>
</head>
<body>
    <h1>Formulario para Actualizar Usuario</h1>
    <form method="POST" action="update.php">
        <input type="hidden" name="dni" value="<?php echo $dniToUpdate; ?>">
        
        <!-- DNI no editable -->
        <label>DNI:</label>
        <input type="text" name="dni" value="<?php echo $dniToUpdate; ?>" readonly><br>

        <label>Nombres:</label>
        <input type="text" name="nombres" value="<?php echo $nombres; ?>" required><br>

        <label>Contraseña:</label>
        <input type="password" name="contrasenha" required><br>

        <!-- Saldo se mantiene igual -->
        <input type="hidden" name="saldo" value="<?php echo $saldo; ?>">

        <!-- Selecciona el género del usuario -->
        <label>Género:</label>
        <select name="generoId" required>
            <?php
            while ($row = $resultGenero->fetch_assoc()) {
                $selected = ($row['IdGenero'] == $generoId) ? 'selected' : '';
                echo "<option value='" . $row['IdGenero'] . "' $selected>" . $row['Gene_Sexo'] . "</option>";
            }
            ?>
        </select><br>

        <!-- Selecciona la región del usuario -->
        <label>Región:</label>
        <select name="regionId" required>
            <?php
            while ($row = $resultDepartamento->fetch_assoc()) {
                $selected = ($row['IdDepartamento'] == $regionId) ? 'selected' : '';
                echo "<option value='" . $row['IdDepartamento'] . "' $selected>" . $row['Regi_Nombre'] . "</option>";
            }
            ?>
        </select><br>

        <!-- Selecciona el rol del usuario -->
        <label>Rol:</label>
        <select name="rolId" required>
            <?php
            while ($row = $resultRol->fetch_assoc()) {
                $selected = ($row['IdRol'] == $rolId) ? 'selected' : '';
                echo "<option value='" . $row['IdRol'] . "' $selected>" . $row['Rol_Nombre'] . "</option>";
            }
            ?>
        </select><br>

        <!-- Selecciona el estado del usuario -->
        <label>Estado:</label>
        <select name="estadoId" required>
            <?php
            while ($row = $resultEstado->fetch_assoc()) {
                $selected = ($row['IdEstado'] == $estadoId) ? 'selected' : '';
                echo "<option value='" . $row['IdEstado'] . "' $selected>" . $row['Esta_Estatus'] . "</option>";
            }
            ?>
        </select><br>

        <input type="submit" value="Actualizar Usuario">
    </form>
</body>
</html>
