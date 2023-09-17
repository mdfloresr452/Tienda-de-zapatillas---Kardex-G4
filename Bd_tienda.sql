
CREATE TABLE IF NOT EXISTS `mydb`.`Modelo` (
  `IdModelo` VARCHAR(45) NOT NULL,
  `Mode_Nombre` VARCHAR(45) NOT NULL,
  `Mode_Genero` ENUM('Todos', 'Hombre', 'Mujer', 'Niño', 'Niña') NOT NULL,
  PRIMARY KEY (`IdModelo`));


-- -----------------------------------------------------
-- Table `mydb`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Marca` (
  `IdMarca` INT NOT NULL,
  `Marc_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdMarca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Detalle_Precios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Detalle_Precios` (
  `IdDetalle_Precios` INT NOT NULL,
  `DPre_Precio` FLOAT NOT NULL,
  `Detalle_PrecioscolFecha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdDetalle_Precios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Productos` (
  `IdProductos` VARCHAR(10) NOT NULL,
  `Prod_Nombre` VARCHAR(45) NOT NULL,
  `Prod_Stock` INT NOT NULL,
  `Prod_Descripcion` VARCHAR(50) NOT NULL,
  `Prod_IdModelo` VARCHAR(45) NOT NULL,
  `Prod_IdMarca` VARCHAR(45) NOT NULL,
  `Detalle_Precios_IdDetalle_Precios` INT NOT NULL,
  PRIMARY KEY (`IdProductos`),
  INDEX `Prod_IdModelo_idx` (`Prod_IdModelo` ASC) VISIBLE,
  INDEX `Prod_IdMarca_idx` (`Prod_IdMarca` ASC) VISIBLE,
  INDEX `fk_Productos_Detalle_Precios1_idx` (`Detalle_Precios_IdDetalle_Precios` ASC) VISIBLE,
  CONSTRAINT `Prod_IdModelo`
    FOREIGN KEY (`Prod_IdModelo`)
    REFERENCES `mydb`.`Modelo` (`IdModelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Prod_IdMarca`
    FOREIGN KEY (`Prod_IdMarca`)
    REFERENCES `mydb`.`Marca` (`IdMarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_Detalle_Precios1`
    FOREIGN KEY (`Detalle_Precios_IdDetalle_Precios`)
    REFERENCES `mydb`.`Detalle_Precios` (`IdDetalle_Precios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pais` (
  `IdPais` INT NOT NULL AUTO_INCREMENT,
  `Pais_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdPais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Region` (
  `IdRegion` INT NOT NULL,
  `Regi_Nombre` VARCHAR(45) NOT NULL,
  `Regi_Direccion` VARCHAR(45) NOT NULL,
  `Regi_IdPais` INT NOT NULL,
  PRIMARY KEY (`IdRegion`),
  INDEX `Regi_IdPais_idx` (`Regi_IdPais` ASC) VISIBLE,
  CONSTRAINT `Regi_IdPais`
    FOREIGN KEY (`Regi_IdPais`)
    REFERENCES `mydb`.`Pais` (`IdPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `Usua_Dni` INT NOT NULL,
  `Usua_Nombres` VARCHAR(45) NOT NULL,
  `Usua_Contrasenha` VARCHAR(45) NOT NULL,
  `Usua_Rol` ENUM('Cliente', 'Administrador') NOT NULL,
  `Usua_Saldo` FLOAT NOT NULL,
  `Usua_Estado` ENUM('Despedido', 'Contratado', 'Cuenta Suspendida', 'Activo') NOT NULL,
  `Usua_IdPais` INT NOT NULL,
  `Usua_IdRegion` INT NOT NULL,
  PRIMARY KEY (`Usua_Dni`, `Usua_Contrasenha`),
  INDEX `Usua_IdPais_idx` (`Usua_IdPais` ASC) VISIBLE,
  INDEX `Usua_IdRegion_idx` (`Usua_IdRegion` ASC) VISIBLE,
  CONSTRAINT `Usua_IdPais`
    FOREIGN KEY (`Usua_IdPais`)
    REFERENCES `mydb`.`Pais` (`IdPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Usua_IdRegion`
    FOREIGN KEY (`Usua_IdRegion`)
    REFERENCES `mydb`.`Region` (`IdRegion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Codigo_Descuento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Codigo_Descuento` (
  `IdCodigo_Descuento` INT NOT NULL,
  `CDes_Codigo` VARCHAR(45) NULL,
  `CDes_Porcentaje` FLOAT NULL,
  `CDes_Estado` ENUM('Valido', 'No valido') NULL,
  PRIMARY KEY (`IdCodigo_Descuento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tarjeta_Credito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tarjeta_Credito` (
  `IdTarjeta_Credito` INT NOT NULL,
  `TCre_Numero` VARCHAR(16) NOT NULL,
  `TCre_Cvc` VARCHAR(3) NOT NULL,
  `TCre_Expiracion` VARCHAR(5) NOT NULL,
  `TCre_Nombre_Propietario` VARCHAR(45) NOT NULL,
  `TCre_Apellido_Propietario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdTarjeta_Credito`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ventas` (
  `IdVentas` INT NOT NULL AUTO_INCREMENT,
  `Vent_Total` FLOAT NOT NULL,
  `Vent_Fecha` DATE NOT NULL,
  `Vent_Usua_Dni` INT NOT NULL,
  `Vent_IdCodigo_Descuento` INT NULL,
  `Vent_IdTarjeta_Credito` INT NULL,
  PRIMARY KEY (`IdVentas`),
  INDEX `Vent_Usua_Dni_idx` (`Vent_Usua_Dni` ASC) VISIBLE,
  INDEX `Vent_IdCodigo_Descuento_idx` (`Vent_IdCodigo_Descuento` ASC) VISIBLE,
  INDEX `Vent_IdTarjeta_Credito_idx` (`Vent_IdTarjeta_Credito` ASC) VISIBLE,
  CONSTRAINT `Vent_Usua_Dni`
    FOREIGN KEY (`Vent_Usua_Dni`)
    REFERENCES `mydb`.`Usuario` (`Usua_Dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Vent_IdCodigo_Descuento`
    FOREIGN KEY (`Vent_IdCodigo_Descuento`)
    REFERENCES `mydb`.`Codigo_Descuento` (`IdCodigo_Descuento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Vent_IdTarjeta_Credito`
    FOREIGN KEY (`Vent_IdTarjeta_Credito`)
    REFERENCES `mydb`.`Tarjeta_Credito` (`IdTarjeta_Credito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Detalle_Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Detalle_Venta` (
  `IdDetalle_Venta` INT NOT NULL,
  `DVen_Vent_IdVentas` INT NOT NULL,
  `DVent_Prod_IdProductos` VARCHAR(10) NOT NULL,
  `DVen_Cantidad` INT NOT NULL,
  PRIMARY KEY (`IdDetalle_Venta`),
  INDEX `DVen_Vent_IdVentas_idx` (`DVen_Vent_IdVentas` ASC) VISIBLE,
  INDEX `DVent_Prod_IdProductos_idx` (`DVent_Prod_IdProductos` ASC) VISIBLE,
  CONSTRAINT `DVen_Vent_IdVentas`
    FOREIGN KEY (`DVen_Vent_IdVentas`)
    REFERENCES `mydb`.`Ventas` (`IdVentas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DVent_Prod_IdProductos`
    FOREIGN KEY (`DVent_Prod_IdProductos`)
    REFERENCES `mydb`.`Productos` (`IdProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Carrito` (
  `Carr_IdProductos` VARCHAR(10) NOT NULL,
  `Precio` VARCHAR(45) NULL,
  `Cantidad` VARCHAR(45) NULL,
  PRIMARY KEY (`Carr_IdProductos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Compras` (
  `Id_compra` INT NOT NULL AUTO_INCREMENT,
  `Comp_Costo` FLOAT NOT NULL,
  `Comp_Fecha` DATE NOT NULL,
  `Comp_Prov_Ruc` VARCHAR(45) NOT NULL,
  `Comp_IdTarjeta_Credito` INT NULL,
  PRIMARY KEY (`Id_compra`),
  INDEX `Comp_IdTarjeta_Credito_idx` (`Comp_IdTarjeta_Credito` ASC) VISIBLE,
  CONSTRAINT `Comp_IdTarjeta_Credito`
    FOREIGN KEY (`Comp_IdTarjeta_Credito`)
    REFERENCES `mydb`.`Tarjeta_Credito` (`IdTarjeta_Credito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Metodo_Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Metodo_Pago` (
  `IdMetodo_Pago` INT NOT NULL,
  `Mpeg_Id_Tarjeta_Credito` INT NOT NULL,
  `Metodo_Pagocol` VARCHAR(45) NULL,
  PRIMARY KEY (`IdMetodo_Pago`),
  INDEX `Mpeg_Id_Tarjeta_Credito_idx` (`Mpeg_Id_Tarjeta_Credito` ASC) VISIBLE,
  CONSTRAINT `Mpeg_Id_Tarjeta_Credito`
    FOREIGN KEY (`Mpeg_Id_Tarjeta_Credito`)
    REFERENCES `mydb`.`Tarjeta_Credito` (`IdTarjeta_Credito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tallas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tallas` (
  `IdTallas` INT NOT NULL,
  `Talla_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdTallas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Historial` (
  `IdHistorial` INT NOT NULL AUTO_INCREMENT,
  `Hist_Accion` VARCHAR(45) NOT NULL,
  `Hist_Usua_Dni` INT NOT NULL,
  `Hist_Fecha_Hora` DATETIME NOT NULL,
  PRIMARY KEY (`IdHistorial`),
  INDEX `Hist_Usua_Dni_idx` (`Hist_Usua_Dni` ASC) VISIBLE,
  CONSTRAINT `Hist_Usua_Dni`
    FOREIGN KEY (`Hist_Usua_Dni`)
    REFERENCES `mydb`.`Usuario` (`Usua_Dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Inventario` (
  `Productos_IdProductos` VARCHAR(10) NOT NULL,
  `Tallas_IdTallas` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  INDEX `fk_table1_Productos1_idx` (`Productos_IdProductos` ASC) VISIBLE,
  INDEX `fk_table1_Tallas1_idx` (`Tallas_IdTallas` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Productos1`
    FOREIGN KEY (`Productos_IdProductos`)
    REFERENCES `mydb`.`Productos` (`IdProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_Tallas1`
    FOREIGN KEY (`Tallas_IdTallas`)
    REFERENCES `mydb`.`Tallas` (`IdTallas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;