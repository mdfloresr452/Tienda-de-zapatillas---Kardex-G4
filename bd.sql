CREATE TABLE Genero_modelo (
  IdGenero_modelo INT NOT NULL AUTO_INCREMENT,
  Gmod_tipo VARCHAR(45) NOT NULL,
  PRIMARY KEY (IdGenero_modelo)
) ENGINE = InnoDB;

CREATE TABLE Modelo (
  IdModelo VARCHAR(45) NOT NULL,
  Mode_Nombre VARCHAR(45) NOT NULL,
  Mod_IdGenero_modelo INT NOT NULL,
  PRIMARY KEY (IdModelo),
  INDEX Mod_IdGenero_modelo_idx (Mod_IdGenero_modelo ASC),
  CONSTRAINT Mod_IdGenero_modelo
    FOREIGN KEY (Mod_IdGenero_modelo)
    REFERENCES Genero_modelo (IdGenero_modelo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE Marca (
  IdMarca INT NOT NULL,
  Marc_Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (IdMarca)
) ENGINE = InnoDB;

CREATE TABLE Detalle_Precios (
  IdDetalle_Precios INT NOT NULL,
  DPre_Precio FLOAT NOT NULL,
  Detalle_PrecioscolFecha VARCHAR(45) NOT NULL,
  PRIMARY KEY (IdDetalle_Precios)
) ENGINE = InnoDB;

CREATE TABLE Productos (
  IdProductos VARCHAR(10) NOT NULL,
  Prod_Nombre VARCHAR(45) NOT NULL,
  Prod_Stock INT NOT NULL,
  Prod_Descripcion VARCHAR(50) NOT NULL,
  Prod_IdModelo VARCHAR(45) NOT NULL,
  Prod_IdMarca VARCHAR(45) NOT NULL,
  Detalle_Precios_IdDetalle_Precios INT NOT NULL,
  PRIMARY KEY (IdProductos),
  INDEX Prod_IdModelo_idx (Prod_IdModelo ASC) ,
  INDEX Prod_IdMarca_idx (Prod_IdMarca ASC) ,
  INDEX fk_Productos_Detalle_Precios1_idx (Detalle_Precios_IdDetalle_Precios ASC) ,
  CONSTRAINT Prod_IdModelo
    FOREIGN KEY (Prod_IdModelo)
    REFERENCES Modelo (IdModelo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE Pais (
  IdPais INT NOT NULL AUTO_INCREMENT,
  Pais_Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (IdPais)
) ENGINE = InnoDB;

CREATE TABLE Departamento (
  IdDepartamento INT NOT NULL,
  Regi_Nombre VARCHAR(45) NOT NULL,
  Regi_IdPais INT NOT NULL,
  PRIMARY KEY (IdDepartamento),
  INDEX Regi_IdPais_idx (Regi_IdPais ASC) ,
  CONSTRAINT Regi_IdPais
    FOREIGN KEY (Regi_IdPais)
    REFERENCES Pais (IdPais)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE Rol (
  IdRol INT NOT NULL,
  Rol_Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (IdRol)
) ENGINE = InnoDB;

CREATE TABLE Genero (
  IdGenero INT NOT NULL,
  Gene_Sexo VARCHAR(45) NOT NULL,
  PRIMARY KEY (IdGenero)
) ENGINE = InnoDB;

CREATE TABLE Estado (
  IdEstado INT NOT NULL,
  Esta_Estatus VARCHAR(45) NOT NULL,
  PRIMARY KEY (IdEstado)
) ENGINE = InnoDB;

CREATE TABLE Usuario (
  Usua_Dni INT NOT NULL,
  Usua_Nombres VARCHAR(45) NOT NULL,
  Usua_Contrasenha VARCHAR(45) NOT NULL,
  Usua_Saldo FLOAT NOT NULL DEFAULT 0.00,
  Usua_IdGenero INT NOT NULL,
  Usua_IdRegion INT NOT NULL,
  Usua_IdRol INT NOT NULL,
  Usua_IdEstado INT NOT NULL,
  PRIMARY KEY (Usua_Dni),
  INDEX Usua_IdRegion_idx (Usua_IdRegion ASC) ,
  INDEX Usua_IdRol_idx (Usua_IdRol ASC) ,
  INDEX Usua_IdGenero_idx (Usua_IdGenero ASC) ,
  INDEX Usua_IdEstado_idx (Usua_IdEstado ASC) ,
  CONSTRAINT Usua_IdRegion
    FOREIGN KEY (Usua_IdRegion)
    REFERENCES Departamento (IdDepartamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT Usua_IdRol
    FOREIGN KEY (Usua_IdRol)
    REFERENCES Rol (IdRol)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT Usua_IdGenero
    FOREIGN KEY (Usua_IdGenero)
    REFERENCES Genero (IdGenero)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT Usua_IdEstado
    FOREIGN KEY (Usua_IdEstado)
    REFERENCES Estado (IdEstado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE Codigo_Descuento (
  IdCodigo_Descuento INT NOT NULL,
  CDes_Codigo VARCHAR(45),
  CDes_Porcentaje FLOAT,
  CDes_Estado ENUM('Valido', 'No valido'),
  PRIMARY KEY (IdCodigo_Descuento)
) ENGINE = InnoDB;

CREATE TABLE Metodo_Pago (
  IdMetodo_Pago INT NOT NULL,
  Metodo_Pagocol VARCHAR(45) NOT NULL,
  PRIMARY KEY (IdMetodo_Pago)
) ENGINE = InnoDB;

CREATE TABLE Tarjeta (
  IdTarjeta INT NOT NULL,
  TCre_Numero VARCHAR(16) NOT NULL,
  TCre_Cvc VARCHAR(3) NOT NULL,
  TCre_Expiracion VARCHAR(5) NOT NULL,
  TCre_Nombre_Propietario VARCHAR(45) NOT NULL,
  TCre_Apellido_Propietario VARCHAR(45) NOT NULL,
  TCre_IdMetodo INT NOT NULL,
  PRIMARY KEY (IdTarjeta),
  INDEX TCre_IdMetodo_idx (TCre_IdMetodo ASC) ,
  CONSTRAINT TCre_IdMetodo
    FOREIGN KEY (TCre_IdMetodo)
    REFERENCES Metodo_Pago (IdMetodo_Pago)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE Ventas (
  IdVentas INT NOT NULL AUTO_INCREMENT,
  Vent_Total FLOAT NOT NULL,
  Vent_Fecha DATE NOT NULL,
  Vent_Usua_Dni INT NOT NULL,
  Vent_IdCodigo_Descuento INT NULL,
  Vent_IdTarjeta INT NULL,
  Vent_Direccion VARCHAR(45) NOT NULL,
  PRIMARY KEY (IdVentas),
  INDEX Vent_Usua_Dni_idx (Vent_Usua_Dni ASC) ,
  INDEX Vent_IdCodigo_Descuento_idx (Vent_IdCodigo_Descuento ASC) ,
  INDEX Vent_IdTarjeta_Credito_idx (Vent_IdTarjeta ASC) ,
  CONSTRAINT Vent_Usua_Dni
    FOREIGN KEY (Vent_Usua_Dni)
    REFERENCES Usuario (Usua_Dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT Vent_IdCodigo_Descuento
    FOREIGN KEY (Vent_IdCodigo_Descuento)
    REFERENCES Codigo_Descuento (IdCodigo_Descuento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT Vent_IdTarjeta
    FOREIGN KEY (Vent_IdTarjeta)
    REFERENCES Tarjeta (IdTarjeta)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE Detalle_Venta (
  IdDetalle_Venta INT NOT NULL,
  DVen_Vent_IdVentas INT NOT NULL,
  DVent_Prod_IdProductos VARCHAR(10) NOT NULL,
  DVen_Cantidad INT NOT NULL,
  DVen_PrecioMomento FLOAT NOT NULL,
  PRIMARY KEY (IdDetalle_Venta),
  INDEX DVen_Vent_IdVentas_idx (DVen_Vent_IdVentas ASC) ,
  INDEX DVent_Prod_IdProductos_idx (DVent_Prod_IdProductos ASC) ,
  CONSTRAINT DVen_Vent_IdVentas
    FOREIGN KEY (DVen_Vent_IdVentas)
    REFERENCES Ventas (IdVentas)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT DVent_Prod_IdProductos
    FOREIGN KEY (DVent_Prod_IdProductos)
    REFERENCES Productos (IdProductos)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE Carrito (
  Carr_IdProductos VARCHAR(10) NOT NULL,
  Precio VARCHAR(45) NULL,
  Cantidad VARCHAR(45) NULL,
  PRIMARY KEY (Carr_IdProductos)
) ENGINE = InnoDB;

CREATE TABLE Compras (
  Id_compra INT NOT NULL AUTO_INCREMENT,
  Comp_Costo FLOAT NOT NULL,
  Comp_Fecha DATE NOT NULL,
  Comp_Prov_Ruc VARCHAR(45) NOT NULL,
  Comp_IdTarjeta_Credito INT NULL,
  PRIMARY KEY (Id_compra),
  INDEX Comp_IdTarjeta_Credito_idx (Comp_IdTarjeta_Credito ASC) ,
  CONSTRAINT Comp_IdTarjeta
    FOREIGN KEY (Comp_IdTarjeta_Credito)
    REFERENCES Tarjeta (IdTarjeta)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE Tallas (
  IdTallas INT NOT NULL,
  Talla_Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (IdTallas)
) ENGINE = InnoDB;

CREATE TABLE Historial (
  IdHistorial INT NOT NULL AUTO_INCREMENT,
  Hist_Accion VARCHAR(45) NOT NULL,
  Hist_Usua_Dni INT NOT NULL,
  Hist_Fecha_Hora DATETIME NOT NULL,
  PRIMARY KEY (IdHistorial),
  INDEX Hist_Usua_Dni_idx (Hist_Usua_Dni ASC) ,
  CONSTRAINT Hist_Usua_Dni
    FOREIGN KEY (Hist_Usua_Dni)
    REFERENCES Usuario (Usua_Dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE prod_por_talla (
  Productos_IdProductos VARCHAR(10) NOT NULL,
  Tallas_IdTallas INT NOT NULL,
  Cantidad INT NOT NULL,
  INDEX fk_table1_Productos1_idx (Productos_IdProductos ASC) ,
  INDEX fk_table1_Tallas1_idx (Tallas_IdTallas ASC) ,
  CONSTRAINT fk_table1_Productos1
    FOREIGN KEY (Productos_IdProductos)
    REFERENCES Productos (IdProductos)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_table1_Tallas1
    FOREIGN KEY (Tallas_IdTallas)
    REFERENCES Tallas (IdTallas)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;
