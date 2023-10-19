<?php
    include('config.php'); // Incluye el archivo de configuración de la base de datos
    include('navbar.php');
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
            <th>Modelo</th>
            <th>Marca</th>
            <th>Precio</th>
            <th>Acciones</th>
        </tr>
        <?php
        // Consulta SQL para obtener los datos de los productos
        $productosQuery = "SELECT IdProductos, Prod_Nombre, Prod_Stock, Prod_IdModelo, Prod_IdMarca, Prod_Precios FROM Productos";

        $resultProductos = $conn->query($productosQuery);

        if ($resultProductos->num_rows > 0) {
            while ($row = $resultProductos->fetch_assoc()) {
                echo "<tr>";
                echo "<td>" . $row['IdProductos'] . "</td>";
                echo "<td>" . $row['Prod_Nombre'] . "</td>";
                echo "<td>" . $row['Prod_Stock'] . "</td>";
                echo "<td>" . $row['Prod_IdModelo'] . "</td>";
                echo "<td>" . $row['Prod_IdMarca'] . "</td>";
                echo "<td>" . $row['Prod_Precios'] . "</td>";
                echo "<td><button onclick=\"agregarAlCarrito('" . $row['IdProductos'] . "', '" . $row['Prod_Nombre'] . "', " . $row['Prod_Stock'] . ", " . $row['Prod_Precios'] . ")\">Agregar al Carrito</button></td>";
                echo "</tr>";
            }
        } else {
            echo "<tr><td colspan='7'>No hay productos disponibles.</td></tr>";
        }

        $conn->close(); // Cierra la conexión a la base de datos
        ?>
    </table>

    <!-- El carrito se mostrará aquí -->
    <h2>Carrito de Compras</h2>
    <table border="1">
        <tr>
            <th>ID Producto</th>
            <th>Nombre</th>
            <th>Cantidad</th>
            <th>Precio Unitario</th>
            <th>Subtotal</th>
            <th>Acciones</th>
        </tr>
        <tbody id="carrito-items">
        </tbody>
    </table>

    <script>
        const carrito = [];

        function agregarAlCarrito(idProducto, nombreProducto, cantidadProducto, precioProducto) {
            const itemEnCarrito = carrito.find(item => item.id === idProducto);

            if (itemEnCarrito) {
                itemEnCarrito.cantidad += 1;
            } else {
                carrito.push({
                    id: idProducto,
                    nombre: nombreProducto,
                    cantidad: 1,
                    precio: precioProducto
                });
            }

            actualizarCarrito();
        }

        function actualizarCarrito() {
            const carritoItems = document.getElementById("carrito-items");
            carritoItems.innerHTML = "";

            let total = 0;

            carrito.forEach(item => {
                const subtotal = item.precio * item.cantidad;
                total += subtotal;

                carritoItems.innerHTML += `
                    <tr>
                        <td>${item.id}</td>
                        <td>${item.nombre}</td>
                        <td>${item.cantidad}</td>
                        <td>${item.precio}</td>
                        <td>${subtotal}</td>
                        <td><button onclick="eliminarDelCarrito('${item.id}')">Eliminar</button></td>
                    </tr>
                `;
            });

            carritoItems.innerHTML += `
                <tr>
                    <td colspan="4">Total:</td>
                    <td>${total}</td>
                    <td><button onclick="vaciarCarrito()">Vaciar Carrito</button></td>
                </tr>
            `;
        }

        function eliminarDelCarrito(idProducto) {
            const index = carrito.findIndex(item => item.id === idProducto);

            if (index !== -1) {
                carrito[index].cantidad -= 1;

                if (carrito[index].cantidad <= 0) {
                    carrito.splice(index, 1);
                }

                actualizarCarrito();
            }
        }

        function vaciarCarrito() {
            carrito.length = 0;
            actualizarCarrito();
        }
    </script>
</body>
</html>
