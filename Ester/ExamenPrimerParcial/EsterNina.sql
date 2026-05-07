create database MiTelefericoDB;
use MiTelefericoDB;
create table usuario(
id_usuario int auto_increment primary key,
nombre varchar (100) not null,
email varchar(100) unique not null, 
telefeono varchar (20),
ciudad varchar (50), 
tipo_usuario enum ('pasajero', 'administrador', 'operador') default 'pasajero',
fecha_registro datetime default current_timestamp
);
create table tarjeta(
id_tarjeta int auto_increment primary key,
id_usuario int not null,
saldo decimal(10,2) default 0, 
fecha_emision datetime default current_timestamp,
foreign key (id_usuario) references usuario(id_usuario)
on delete cascade
on update cascade
);
create table recarga(
id_recarga int auto_increment primary key,
id_tarjeta int not null,
monto decimal(10,2) not null, 
fecha_recarga datetime default current_timestamp,
metodo_pago enum ('efectivo', 'tarjeta', 'transferencia', 'qr') default 'efectivo',
foreign key (id_tarjeta) references tarjeta(id_tarjeta)
on delete cascade
on update cascade
);
create table linea(
id_linea int auto_increment primary key,
nombre_linea varchar(50) not null,
color varchar(30),
estado enum ('activo', 'en_mantenimiento') default 'activo'
);
create table estacion(
id_estacion int auto_increment primary key,
id_linea int not null,
nombre_estacion varchar(50) not null,
orden int not null,
foreign key (id_linea) references linea(id_linea)
on delete cascade
on update cascade
);
create table viaje(
id_viaje int auto_increment primary key,
id_linea int not null,
id_estacion_origen int not null,
id_estacion_destino int not null, 
fecha_viaje datetime default current_timestamp,
estado enum ('pendiente', 'en_curso', 'finalizado') default 'pendiente',
foreign key (id_linea) references linea(id_linea)
on delete cascade
on update cascade,
foreign key (id_estacion_origen) references estacion(id_estacion)
on delete cascade
on update cascade,
foreign key (id_estacion_destino) references estacion(id_estacion)
on delete cascade
on update cascade
);
create table boleto(
id_boleto int auto_increment primary key,
id_usuario int not null,
id_linea int not null,
id_viaje int not null, 
id_pago int not null, 
fecha_compra datetime default current_timestamp,
precio decimal(10,2) not null default 3.00, 
estado enum ('activo', 'usado', 'cancelado') default 'activo',
foreign key (id_usuario) references usuario(id_usuario)
on delete cascade
on update cascade,
foreign key (id_linea) references linea(id_linea)
on delete cascade
on update cascade,
foreign key (id_viaje) references viaje(id_viaje)
on delete cascade
on update cascade
);
create table pago(
id_pago int auto_increment primary key,
id_boleto int null,
id_recarga int null,
monto decimal(10,2) not null, 
metodo_pago enum ('efectivo', 'tarjeta', 'transferencia', 'qr') default 'efectivo',
fecha_pago datetime default current_timestamp,
estado enum ('pendiente', 'completado', 'cancelado') default 'pendiente',
foreign key (id_boleto) references boleto(id_boleto)
on delete cascade
on update cascade,
foreign key (id_recarga) references recarga(id_recarga)
on delete cascade
on update cascade
);

insert into usuario (nombre, email, telefeono, ciudad, tipo_usuario) values
('juan pérez', 'juan.perez@gmail.com', '70123456', 'la paz', 'pasajero'),
('maría lópez', 'maria.lopez@gmail.com', '70234567', 'el alto', 'pasajero'),
('carlos quispe', 'carlos.quispe@gmail.com', '70345678', 'la paz', 'operador'),
('ana mamani', 'ana.mamani@gmail.com', '70456789', 'el alto', 'administrador');
insert into tarjeta (id_usuario, saldo) values
(1, 25.00),
(2, 15.50),
(3, 40.00),
(4, 10.00);
insert into recarga (id_tarjeta, monto, metodo_pago) values
(1, 20.00, 'efectivo'),
(2, 15.00, 'qr'),
(3, 30.00, 'transferencia'),
(4, 10.00, 'tarjeta');
insert into linea (nombre_linea, color, estado) values
('línea roja', 'rojo', 'activo'),
('línea amarilla', 'amarillo', 'activo'),
('línea verde', 'verde', 'activo'),
('línea azul', 'azul', 'en_mantenimiento');
insert into estacion (id_linea, nombre_estacion, orden) values
(1, 'estación central', 1),
(1, 'estación 16 de julio', 2),
(2, 'estación libertador', 1),
(3, 'estación irpavi', 1);
insert into viaje (id_linea, id_estacion_origen, id_estacion_destino, estado) values
(1, 1, 2, 'finalizado'),
(1, 2, 1, 'en_curso'),
(2, 3, 1, 'pendiente'),
(3, 4, 3, 'finalizado');
insert into boleto (id_usuario, id_linea, id_viaje, id_pago, precio, estado) values
(1, 1, 1, 1, 3.00, 'usado'),
(2, 1, 2, 2, 3.00, 'activo'),
(3, 2, 3, 3, 3.00, 'activo'),
(4, 3, 4, 4, 3.00, 'usado');
insert into pago (id_boleto, id_recarga, monto, metodo_pago, estado) values
(1, null, 3.00, 'efectivo', 'completado'),
(2, null, 3.00, 'qr', 'pendiente'),
(3, null, 3.00, 'tarjeta', 'completado'),
(4, null, 3.00, 'transferencia', 'completado');

-- 1  muestra unicamente los usuario cuyo tipo_usuario sea 'pasajero';
select* from usuario;
select * from usuario where tipo_usuario = 'pasajero';
-- 2 obten el numero total de usuarios registrados
select count(nombre) from usuario ;
-- 3 cuenta cuantos boletos hay por cada estado(activo, usado, etc)
select * from boleto;
select estado, count(id_boleto) from boleto group by estado;
-- 4 incrementa 10 Bs en la tarjeta con id_tarjeta = 1
update tarjeta set saldo = saldo + 10 where id_tarjeta = 1;
-- 5 calcula el saldo promedio de todas las tarjetas 
select avg (saldo) as promedio_tarjeta from tarjeta;
-- 6 muestra cuantos pasajeros hay en cada ciudad
select ciudad, COUNT(id_usuario) as total_pasajeros from usuario where tipo_usuario = "pasajero" group by ciudad;
-- 7 filtra todas las recargas donde el monto fue mayor a 20bs
select * from recarga where monto > 20;
-- 8 muestra el nombre del pasajero junto con el boleto que compró
select u.nombre AS pasajero, b.id_boleto,b.fecha_compra,b.precio, b.estado
from usuario u
inner join boleto b on u.id_usuario = b.id_usuario
where u.tipo_usuario = 'pasajero';
-- 9 encuenttra todas las tarjetas con saldo menor a 20 bs y muestra el usuario correspondiente
select u.nombre as usuario, t.id_tarjeta, t.saldo
from usuario u
inner join tarjeta t on u.id_usuario = t.id_usuario
where t.saldo < 20;
-- 10 calcula el saldo promedio de tarjetas por ciudad de los usuarios
select u.ciudad, avg(t.saldo) as saldo_promedio_ciudad
from usuario u
inner join tarjeta t on u.id_usuario = t.id_usuario
group by u.ciudad;