<div class="navbar">
    <button id="menuButton">Menú</button>
    <button id="productosButton">Productos</button>
    <button id="ventasButton">Ventas</button>
    <div id="menuDropdown" hidden>
        <a href="create.php">Crear Usuario</a>
        <a href="read.php">Ver Usuarios</a>
        <a href="update.php">Actualizar Usuario</a>
        <a href="delete.php">Borrar Usuario</a>
        <!-- Agrega más enlaces al menú cuando sea necesario -->
    </div>
    <div id="productosDropdown" hidden>
        <a href="gestionar_producto.php">Gestionar Producto</a>
        <a href="ver_producto.php">Ver Producto</a>
        <a href="productos3.php">Producto 3</a>
        <!-- Agrega más enlaces de productos cuando sea necesario -->
    </div>
    <div id="ventasDropdown" hidden>
        <a href="ventas1.php">Venta 1</a>
        <a href="ventas2.php">Venta 2</a>
        <a href="ventas3.php">Venta 3</a>
        <!-- Agrega más enlaces de ventas cuando sea necesario -->
    </div>
</div>

<script>
    function toggleDropdown(dropdownId) {
        const dropdown = document.getElementById(dropdownId);
        if (dropdown.hidden) {
            // Oculta todos los menús desplegables
            hideAllDropdowns();
            dropdown.removeAttribute("hidden");
        } else {
            dropdown.setAttribute("hidden", "hidden");
        }
    }

    function hideAllDropdowns() {
        const dropdowns = document.querySelectorAll(".navbar div:not([hidden])");
        dropdowns.forEach((dropdown) => {
            dropdown.setAttribute("hidden", "hidden");
        });
    }

    document.getElementById("menuButton").addEventListener("click", function () {
        toggleDropdown("menuDropdown");
    });

    document.getElementById("productosButton").addEventListener("click", function () {
        toggleDropdown("productosDropdown");
    });

    document.getElementById("ventasButton").addEventListener("click", function () {
        toggleDropdown("ventasDropdown");
    });
</script>