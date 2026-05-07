CREATE DATABASE if NOT EXISTS MiTelefericoDB;
USE MiTelefericoDB;
CREATE TABLE usuario(
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    ciudad VARCHAR(50),
    tipo_usuario ENUM('pasajero', 'administrador', 'operador') DEFAULT 'pasajero',
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE tarjeta(
    id_tarjeta INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    saldo DECIMAL(10,2) DEFAULT 0,
    fecha_emision DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);
CREATE TABLE recarga(
    id_recarga INT AUTO_INCREMENT PRIMARY key,
    id_tarjeta INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_recarga DATETIME DEFAULT CURRENT_TIMESTAMP,
    metodo_pago ENUM('efectivo', 'tarjeta', 'transferencia', 'qr') DEFAULT 'efectivo',
    FOREIGN KEY (id_tarjeta) REFERENCES tarjeta(id_tarjeta)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);
CREATE TABLE linea(
    id_linea INT AUTO_INCREMENT PRIMARY KEY,
    nombre_linea VARCHAR(30),
    color VARCHAR(30),
    estado ENUM('activo','en_mantenimiento') DEFAULT 'activo'
);
CREATE TABLE estacion(
    id_estacion INT AUTO_INCREMENT PRIMARY KEY,
    id_linea INT NOT NULL,
    nombre_estacion VARCHAR(50) NOT NULL,
    orden INT NOT NULL,
    FOREIGN KEY (id_linea) REFERENCES linea(id_linea)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);
CREATE TABLE viaje(
    id_viaje INT AUTO_INCREMENT PRIMARY KEY,
    id_linea INT NOT NULL,
    id_estacion_origen INT NOT NULL,
    id_estacion_destino INT NOT NULL,
    fecha_viaje DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('pendiente','en_curso','finalizado') DEFAULT 'pendiente'
    FOREIGN KEY (id_linea) REFERENCES linea(id_linea),
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (id_estacion_origen) REFERENCES estacion(id_estacion)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (id_estacion_destino) REFERENCES estacion(id_estacion)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);
CREATE TABLE boleto(
    id_boleto INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_linea INT NOT NULL,
    id_viaje INT NOT NULL,
    id_pago INT NOT NULL,
    fecha_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    precio DECIMAL(10,2) NOT NULL DEFAULT 3.00,
    estado ENUM('activo','usado','cancelado') DEFAULT 'activo',
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (id_linea) REFERENCES linea(id_linea)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (id_viaje) REFERENCES viaje(id_viaje)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);
CREATE TABLE pago(
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_boleto INT NOT NULL,
    id_recarga INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    metodo_pago ENUM('pendiente','completado','cancelado') DEFAULT 'pendiente',
    FOREIGN KEY (id_boleto) REFERENCES boleto(id_boleto)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (id_recarga) REFERENCES recarga(id_recarga)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);
--parte 2
--SELECT * from usuario WHERE tipo_usuario = "pasajero";
--SELECT * from usuario WHERE usuario;
--SELECT * from boleto WHERE boleto = "activo","usado","cancelado";
