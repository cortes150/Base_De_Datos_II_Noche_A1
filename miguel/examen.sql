CREATE DATABASE IF NOT EXISTS Mi_telefericoDB;
USE Mi_telefericoDB;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) unique not null,
    telefono VARCHAR(100),
    tipo_usuario enum ("pasajero","administrador","operador") default "pasajero",
    fecha_registro datetime default current_timestamp
);

CREATE TABLE tarjeta (
    id_tarjeta INT AUTO_INCREMENT PRIMARY KEY,
	id_usuario int NOT NULL,
    saldo DECIMAL(10,2) default 0,
    fecha_emision datetime default current_timestamp,
    foreign key (id_usuario) references usuario (id_usuario)
    on delete cascade
    on update cascade
);
CREATE TABLE recarga (
    id_recarga INT AUTO_INCREMENT PRIMARY KEY,
    id_tarjeta int NOT NULL,
    saldo DECIMAL(10,2),
    fecha_recarga datetime default current_timestamp, 
    FOREIGN KEY (id_tarjeta) REFERENCES tarjeta(id_tarjeta)
);
CREATE TABLE linea (
    id_linea INT AUTO_INCREMENT PRIMARY KEY,
    nombre_linea VARCHAR(30) NOT NULL,
    color VARCHAR(30),
    estado enum ("activo","en_mantenimiento") default "activo"
);
CREATE TABLE estacion (
    id_estacion INT AUTO_INCREMENT PRIMARY KEY,
    id_linea int NOT NULL,
    nombre_estacion VARCHAR(30) NOT NULL,
    fecha_recarga datetime default current_timestamp, 
    FOREIGN KEY (id_linea) REFERENCES linea(id_linea)
        on delete cascade
        on update cascade
);
CREATE TABLE viaje (
    id_viaje INT AUTO_INCREMENT PRIMARY KEY,
    id_linea int NOT NULL,
    id_estacion_origen int NOT NULL,
    id_estacion_destino int NOT NULL,
    fecha_viaje datetime default current_timestamp, 
    FOREIGN KEY (id_linea) REFERENCES linea(id_linea)
        on delete cascade
        on update cascade,
	FOREIGN KEY (id_estacion_origen) REFERENCES estacion(id_estacion)
        on delete cascade
        on update cascade,
	FOREIGN KEY (id_estacion_destino) REFERENCES estacion(id_estacion)
        on delete cascade
        on update cascade
);
CREATE TABLE boleto (
    id_boleto INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario int NOT NULL,
    id_linea int NOT NULL,
    id_viaje int NOT NULL,
    fecha_compra datetime default current_timestamp, 
    precio DECIMAL(10,2),
    estado enum ("activo","usado","cancelado") default "activo",

    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
        on delete cascade
        on update cascade,

    FOREIGN KEY (id_linea) REFERENCES linea(id_linea)
        on delete cascade
        on update cascade,

    FOREIGN KEY (id_viaje) REFERENCES viaje(id_viaje)
        on delete cascade
        on update cascade
);
CREATE TABLE pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_boleto int NOT NULL,
    id_recarga int NOT NULL,
    monto DECIMAL(10,2),
    fecha_pago datetime default current_timestamp, 
    estado enum ("pendiente","completado","cancelado") default "pendiente",
        FOREIGN KEY (id_boleto) REFERENCES boleto(id_boleto)
        on delete cascade
        on update cascade,
	FOREIGN KEY (id_recarga) REFERENCES recarga(id_recarga)
        on delete set null
        on update cascade
);
-- USUARIO
INSERT INTO usuario (nombre, email, telefono, tipo_usuario) VALUES
('Juan Perez', 'juan.perez@gmail.com', '76543210', 'pasajero'),
('Maria Quispe', 'maria.quispe@gmail.com', '71234567', 'administrador'),
('Carlos Mamani', 'carlos.mamani@gmail.com', '79876543', 'operador'),
('Lucia Choque', 'lucia.choque@gmail.com', '70112233', 'pasajero'),
('Diego Flores', 'diego.flores@gmail.com', '77778888', 'pasajero');

-- TARJETA
INSERT INTO tarjeta (id_usuario, saldo) VALUES
(1, 25.50),
(2, 100.00),
(3, 50.00),
(4, 15.75),
(5, 80.20);

-- RECARGA
INSERT INTO recarga (id_tarjeta, saldo) VALUES
(1, 20.00),
(2, 50.00),
(3, 30.00),
(4, 10.00),
(5, 40.00);

-- LINEA
INSERT INTO linea (nombre_linea, color, estado) VALUES
('Linea Roja', 'Rojo', 'activo'),
('Linea Amarilla', 'Amarillo', 'activo'),
('Linea Verde', 'Verde', 'activo'),
('Linea Azul', 'Azul', 'en_mantenimiento'),
('Linea Morada', 'Morado', 'activo');

-- ESTACION
INSERT INTO estacion (id_linea, nombre_estacion) VALUES
(1, 'Central'),
(2, 'Sopocachi'),
(3, 'Irpavi'),
(4, '16 de Julio'),
(5, 'Obrajes');

-- VIAJE
INSERT INTO viaje (id_linea, id_estacion_origen, id_estacion_destino) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 4),
(4, 4, 5),
(5, 5, 1);

-- PAGO
INSERT INTO pago (id_boleto, id_recarga, monto, estado) VALUES
(1, 1, 3.00, 'completado'),
(2, 2, 3.00, 'completado'),
(3, 3, 3.00, 'pendiente'),
(4, 4, 3.00, 'completado'),
(5, 5, 3.00, 'cancelado');

-- BOLETO
INSERT INTO boleto (id_usuario, id_linea, id_viaje, id_pago, precio, estado) VALUES
(1, 1, 1, 1, 3.00, 'usado'),
(2, 2, 2, 2, 3.00, 'activo'),
(3, 3, 3, 3, 3.00, 'cancelado'),
(4, 4, 4, 4, 3.00, 'usado'),
(5, 5, 5, 5, 3.00, 'activo');
-- 1
select id_usuario,tipo_usuario
from usuario where tipo_usuario = 'pasajero';
-- 2 
select COUNT(*) as total_usuarios
from usuario;
-- 3 
select estado, COUNT(*) as cantidad_boletos
from boleto group by estado;
-- 4 
update tarjeta set saldo = saldo + 10 where id_tarjeta = 1;
-- 5 
select avg(saldo) as saldo_promedio from tarjeta; 
-- 6 
select * from usuario;
alter table usuario
add ciudad varchar(50);
update usuario set ciudad = 'La Paz' where id_usuario = 1;
update usuario set ciudad = 'El Alto' where id_usuario = 2;
update usuario set ciudad = 'Cochabamba' where id_usuario = 3;
update usuario set ciudad = 'Santa Cruz' where id_usuario = 4;
update usuario set ciudad = 'Oruro' where id_usuario = 5;
select ciudad, COUNT(*) as cantidad_pasajeros
from usuario where tipo_usuario = 'pasajero'
group by ciudad;
-- 7
select * from recarga where saldo > 20;
-- 8
select u.nombre,t.id_tarjeta,t.saldo
from usuario u inner join tarjeta t
on u.id_usuario = t.id_usuario;
-- 9 
select u.nombre,u.ciudad,t.id_tarjeta,t.saldo
from usuario u inner join tarjeta t
on u.id_usuario = t.id_usuario where t.saldo > 20;
-- 10 
select ciudad, avg(saldo) as saldo_promedio from tarjeta; 