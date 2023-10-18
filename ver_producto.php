<?php
include('config.php'); // Incluye el archivo de configuración de la base de datos
include('navbar.php');

// Consulta para obtener los datos de los productos
$productosQuery = "SELECT IdProductos, Prod_Nombre, Prod_Stock FROM Productos";

$resultProductos = $conn->query($productosQuery);

$conn->close();
?>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Productos</title>
</head>
<body>
    <h1>Lista de Productos</h1>

    <table border="1">
        <tr>
            <th>ID Producto</th>
            <th>Nombre</th>
            <th>Cantidad</th>
        </tr>
        <?php
        while ($row = $resultProductos->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row['IdProductos'] . "</td>";
            echo "<td>" . $row['Prod_Nombre'] . "</td>";
            echo "<td>" . $row['Prod_Stock'] . "</td>";
            echo "</tr>";
        }
        ?>
    </table>
</body>
</html>
