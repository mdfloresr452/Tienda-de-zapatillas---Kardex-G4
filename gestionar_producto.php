<?php
require 'config.php'; // Incluye el archivo de configuración de la base de datos
include 'navbar.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $productoId = $_POST['productoId'];
    $tallaId = $_POST['tallaId'];
    $cantidad = $_POST['cantidad'];

    // Verificar que los campos requeridos estén completos
    if (!empty($productoId) && !empty($tallaId) && !empty($cantidad)) {
        // Actualizar el stock en la tabla prod_por_talla
        $sql = "UPDATE prod_por_talla SET Cantidad = Cantidad + $cantidad 
                WHERE Productos_IdProductos = '$productoId' AND Tallas_IdTallas = $tallaId";

        if ($conn->query($sql) === TRUE) {
            // Actualizar el stock general en la tabla Productos
            $sql = "UPDATE Productos SET Prod_Stock = Prod_Stock + $cantidad 
                    WHERE IdProductos = '$productoId'";

            if ($conn->query($sql) === TRUE) {
                header("Location: ver_producto.php"); // Redirige al usuario a la página de listado de productos
            } else {
                echo "Error al actualizar el stock general del producto: " . $conn->error;
            }
        } else {
            echo "Error al actualizar el stock del producto por talla: " . $conn->error;
        }
    } else {
        echo "Por favor, complete todos los campos del formulario.";
    }
}

// Consulta para obtener la lista de productos
$listaProductosQuery = "SELECT IdProductos, Prod_Nombre FROM Productos";
$resultProductos = $conn->query($listaProductosQuery);

// Consulta para obtener la lista de tallas
$listaTallasQuery = "SELECT IdTallas, Talla_Nombre FROM Tallas";
$resultTallas = $conn->query($listaTallasQuery);

$conn->close();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Actualizar Stock de Producto por Talla</title>
</head>
<body>
    <h1>Actualizar Stock de Producto por Talla</h1>
    <form method="POST" action="gestionar_producto.php">
        <label>Seleccione un Producto:</label>
        <select name="productoId" required>
            <?php
            while ($row = $resultProductos->fetch_assoc()) {
                echo "<option value='" . $row['IdProductos'] . "'>" . $row['Prod_Nombre'] . "</option>";
            }
            ?>
        </select><br>

        <label>Seleccione una Talla:</label>
        <select name="tallaId" required>
            <?php
            while ($row = $resultTallas->fetch_assoc()) {
                echo "<option value='" . $row['IdTallas'] . "'>" . $row['Talla_Nombre'] . "</option>";
            }
            ?>
        </select><br>

        <label>Cantidad a Agregar al Stock:</label>
        <input type="text" name="cantidad" required><br>

        <input type="submit" value="Actualizar Stock">
    </form>
</body>
</html>
