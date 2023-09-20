CREATE TABLE `Modelo` (
    `IdModelo` INT NOT NULL AUTO_INCREMENT,
    `Mode_Nombre` VARCHAR(45) NOT NULL,
    `Mode_Genero` ENUM('Todos', 'Hombre', 'Mujer', 'Niño', 'Niña') NOT NULL,
    PRIMARY KEY (`IdModelo`)
);

CREATE TABLE `Marca` (
    `IdMarca` INT NOT NULL AUTO_INCREMENT,
    `Marc_Nombre` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`IdMarca`)
);

CREATE TABLE `Detalle_Precios` (
    `IdDetalle_Precios` INT NOT NULL AUTO_INCREMENT,
    `DPre_Precio` FLOAT NOT NULL,
    `Detalle_PrecioscolFecha` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`IdDetalle_Precios`)
);

CREATE TABLE `Productos` (
    `IdProductos` INT NOT NULL AUTO_INCREMENT,
    `Prod_Nombre` VARCHAR(45) NOT NULL,
    `Prod_Stock` INT NOT NULL,
    `Prod_Descripcion` VARCHAR(50) NOT NULL,
    `Prod_IdModelo` INT NOT NULL,
    `Prod_IdMarca` INT NOT NULL,
    `Detalle_Precios_IdDetalle_Precios` INT NOT NULL,
    PRIMARY KEY (`IdProductos`),
    FOREIGN KEY (`Prod_IdModelo`) REFERENCES `Modelo` (`IdModelo`),
    FOREIGN KEY (`Prod_IdMarca`) REFERENCES `Marca` (`IdMarca`),
    FOREIGN KEY (`Detalle_Precios_IdDetalle_Precios`) REFERENCES `Detalle_Precios` (`IdDetalle_Precios`)
);

CREATE TABLE `Pais` (
    `IdPais` INT NOT NULL AUTO_INCREMENT,
    `Pais_Nombre` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`IdPais`)
);

CREATE TABLE `Region` (
    `IdRegion` INT NOT NULL AUTO_INCREMENT,
    `Regi_Nombre` VARCHAR(45) NOT NULL,
    `Regi_Direccion` VARCHAR(45) NOT NULL,
    `Regi_IdPais` INT NOT NULL,
    PRIMARY KEY (`IdRegion`),
    FOREIGN KEY (`Regi_IdPais`) REFERENCES `Pais` (`IdPais`)
);

CREATE TABLE `Usuario` (
    `Usua_Dni` INT NOT NULL AUTO_INCREMENT,
    `Usua_Nombres` VARCHAR(45) NOT NULL,
    `Usua_Contrasenha` VARCHAR(45) NOT NULL,
    `Usua_Rol` ENUM('Cliente', 'Administrador') NOT NULL,
    `Usua_Saldo` FLOAT NOT NULL,
    `Usua_Estado` ENUM('Despedido', 'Contratado', 'Cuenta Suspendida', 'Activo') NOT NULL,
    `Usua_IdPais` INT NOT NULL,
    `Usua_IdRegion` INT NOT NULL,
    PRIMARY KEY (`Usua_Dni`),
    FOREIGN KEY (`Usua_IdPais`) REFERENCES `Pais` (`IdPais`),
    FOREIGN KEY (`Usua_IdRegion`) REFERENCES `Region` (`IdRegion`)
);

CREATE TABLE `Codigo_Descuento` (
    `IdCodigo_Descuento` INT NOT NULL AUTO_INCREMENT,
    `CDes_Codigo` VARCHAR(45) NULL,
    `CDes_Porcentaje` FLOAT NULL,
    `CDes_Estado` ENUM('Valido', 'No valido') NULL,
    PRIMARY KEY (`IdCodigo_Descuento`)
);

CREATE TABLE `Tarjeta_Credito` (
    `IdTarjeta_Credito` INT NOT NULL AUTO_INCREMENT,
    `TCre_Numero` VARCHAR(16) NOT NULL,
    `TCre_Cvc` VARCHAR(3) NOT NULL,
    `TCre_Expiracion` VARCHAR(5) NOT NULL,
    `TCre_Nombre_Propietario` VARCHAR(45) NOT NULL,
    `TCre_Apellido_Propietario` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`IdTarjeta_Credito`)
);

CREATE TABLE `Ventas` (
    `IdVentas` INT NOT NULL AUTO_INCREMENT,
    `Vent_Total` FLOAT NOT NULL,
    `Vent_Fecha` DATE NOT NULL,
    `Vent_Usua_Dni` INT NOT NULL,
    `Vent_IdCodigo_Descuento` INT NULL,
    `Vent_IdTarjeta_Credito` INT NULL,
    PRIMARY KEY (`IdVentas`),
    FOREIGN KEY (`Vent_Usua_Dni`) REFERENCES `Usuario` (`Usua_Dni`),
    FOREIGN KEY (`Vent_IdCodigo_Descuento`) REFERENCES `Codigo_Descuento` (`IdCodigo_Descuento`),
    FOREIGN KEY (`Vent_IdTarjeta_Credito`) REFERENCES `Tarjeta_Credito` (`IdTarjeta_Credito`)
);

CREATE TABLE `Detalle_Venta` (
    `IdDetalle_Venta` INT NOT NULL AUTO_INCREMENT,
    `DVen_Vent_IdVentas` INT NOT NULL,
    `DVent_Prod_IdProductos` INT NOT NULL,
    `DVen_Cantidad` INT NOT NULL,
    PRIMARY KEY (`IdDetalle_Venta`),
    FOREIGN KEY (`DVen_Vent_IdVentas`) REFERENCES `Ventas` (`IdVentas`),
    FOREIGN KEY (`DVent_Prod_IdProductos`) REFERENCES `Productos` (`IdProductos`)
);

CREATE TABLE `Carrito` (
    `Carr_IdProductos` INT NOT NULL AUTO_INCREMENT,
    `Precio` VARCHAR(45) NULL,
    `Cantidad` VARCHAR(45) NULL,
    PRIMARY KEY (`Carr_IdProductos`)
);

CREATE TABLE `Compras` (
    `Id_compra` INT NOT NULL AUTO_INCREMENT,
    `Comp_Costo` FLOAT NOT NULL,
    `Comp_Fecha` DATE NOT NULL,
    `Comp_Prov_Ruc` VARCHAR(45) NOT NULL,
    `Comp_IdTarjeta_Credito` INT NULL,
    PRIMARY KEY (`Id_compra`),
    FOREIGN KEY (`Comp_IdTarjeta_Credito`) REFERENCES `Tarjeta_Credito` (`IdTarjeta_Credito`)
);

CREATE TABLE `Metodo_Pago` (
    `IdMetodo_Pago` INT NOT NULL AUTO_INCREMENT,
    `Mpeg_Id_Tarjeta_Credito` INT NOT NULL,
    `Metodo_Pagocol` VARCHAR(45) NULL,
    PRIMARY KEY (`IdMetodo_Pago`),
    FOREIGN KEY (`Mpeg_Id_Tarjeta_Credito`) REFERENCES `Tarjeta_Credito` (`IdTarjeta_Credito`)
);

CREATE TABLE `Tallas` (
    `IdTallas` INT NOT NULL AUTO_INCREMENT,
    `Talla_Nombre` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`IdTallas`)
);

CREATE TABLE `Historial` (
    `IdHistorial` INT NOT NULL AUTO_INCREMENT,
    `Hist_Accion` VARCHAR(45) NOT NULL,
    `Hist_Usua_Dni` INT NOT NULL,
    `Hist_Fecha_Hora` DATETIME NOT NULL,
    PRIMARY KEY (`IdHistorial`),
    FOREIGN KEY (`Hist_Usua_Dni`) REFERENCES `Usuario` (`Usua_Dni`)
);

CREATE TABLE `Inventario` (
    `IdInventario` INT NOT NULL AUTO_INCREMENT,
    `Productos_IdProductos` INT NOT NULL,
    `Tallas_IdTallas` INT NOT NULL,
    `Cantidad` INT NOT NULL,
    PRIMARY KEY (`IdInventario`),
    FOREIGN KEY (`Productos_IdProductos`) REFERENCES `Productos` (`IdProductos`),
    FOREIGN KEY (`Tallas_IdTallas`) REFERENCES `Tallas` (`IdTallas`)
);
