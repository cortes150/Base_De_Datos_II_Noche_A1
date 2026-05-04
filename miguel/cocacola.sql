create database cocacola;
use cocacola;
create table categoria (
  id_categoria int auto_increment primary key,
  nombre varchar(100) not null,
  descripcion varchar(255)
);

create table producto (
  id_producto int auto_increment primary key,
  id_categoria int not null,
  nombre varchar(100) not null,
  presentacion varchar(50),
  precio decimal(10,2) not null,
  estado varchar(20) default 'activo',
  foreign key (id_categoria) references categoria(id_categoria)
);

create table planta (
  id_planta int auto_increment primary key,
  nombre varchar(100) not null,
  ciudad varchar(100),
  direccion varchar(150)
);

create table inventario (
  id_inventario int auto_increment primary key,
  id_planta int not null,
  id_producto int not null,
  cantidad int not null,
  fecha_actualizacion datetime,
  foreign key (id_planta) references planta(id_planta),
  foreign key (id_producto) references producto(id_producto)
);

create table distribuidor (
  id_distribuidor int auto_increment primary key,
  nombre varchar(100) not null,
  telefono varchar(20),
  correo varchar(100)
);

create table cliente (
  id_cliente int auto_increment primary key,
  nombre varchar(100) not null,
  tipo_cliente varchar(50),
  telefono varchar(20),
  direccion varchar(150)
);

create table rutadistribucion (
  id_ruta int auto_increment primary key,
  id_distribuidor int not null,
  nombre_ruta varchar(100) not null,
  ciudad varchar(100),
  estado varchar(20) default 'activa',
  foreign key (id_distribuidor) references distribuidor(id_distribuidor)
);

create table pedido (
  id_pedido int auto_increment primary key,
  id_cliente int not null,
  id_ruta int not null,
  fecha_pedido datetime not null,
  estado varchar(20) default 'registrado',
  total decimal(10,2),
  foreign key (id_cliente) references cliente(id_cliente),
  foreign key (id_ruta) references rutadistribucion(id_ruta)
);

create table detallepedido (
  id_detalle int auto_increment primary key,
  id_pedido int not null,
  id_producto int not null,
  cantidad int not null,
  precio_unitario decimal(10,2) not null,
  subtotal decimal(10,2) not null,
  foreign key (id_pedido) references pedido(id_pedido),
  foreign key (id_producto) references producto(id_producto)
);

create table entrega (
  id_entrega int auto_increment primary key,
  id_pedido int not null unique,
  fecha_entrega datetime,
  estado varchar(20) default 'pendiente',
  observacion varchar(255),
  foreign key (id_pedido) references pedido(id_pedido)
);
use cocacola;

-- categoria
insert into categoria (nombre, descripcion) values
('gaseosas','bebidas con gas'),
('jugos','bebidas naturales'),
('energizantes','bebidas energeticas'),
('agua','agua purificada'),
('te','bebidas de te'),
('isotonicas','bebidas deportivas'),
('light','bajas en azucar'),
('premium','productos premium'),
('familiares','presentacion grande'),
('individuales','presentacion pequeña');

-- producto
insert into producto (id_categoria, nombre, presentacion, precio, estado) values
(1,'coca cola','500ml',5.50,'activo'),
(1,'coca cola','2l',10.00,'activo'),
(2,'del valle','1l',7.00,'activo'),
(3,'burn','500ml',12.00,'activo'),
(4,'ciel','600ml',4.00,'activo'),
(5,'fuze tea','500ml',6.50,'activo'),
(6,'powerade','600ml',8.00,'activo'),
(7,'coca cola light','500ml',5.80,'activo'),
(8,'coca cola premium','1l',15.00,'activo'),
(9,'sprite','2l',9.50,'activo');

-- planta
insert into planta (nombre, ciudad, direccion) values
('planta la paz','la paz','zona sur'),
('planta el alto','el alto','avenida 6'),
('planta cochabamba','cochabamba','zona norte'),
('planta santa cruz','santa cruz','centro'),
('planta oruro','oruro','zona industrial'),
('planta potosi','potosi','calle 10'),
('planta sucre','sucre','zona sur'),
('planta tarija','tarija','avenida central'),
('planta beni','beni','zona este'),
('planta pando','pando','zona oeste');

-- inventario
insert into inventario (id_planta,id_producto,cantidad,fecha_actualizacion) values
(1,1,100,'2026-05-01'),
(1,2,200,'2026-05-01'),
(2,3,150,'2026-05-02'),
(2,4,80,'2026-05-02'),
(3,5,120,'2026-05-03'),
(3,6,90,'2026-05-03'),
(4,7,110,'2026-05-04'),
(4,8,70,'2026-05-04'),
(5,9,60,'2026-05-04'),
(5,10,50,'2026-05-04');

-- distribuidor
insert into distribuidor (nombre,telefono,correo) values
('dist la paz','77711111','lapaz@dist.com'),
('dist el alto','77722222','alto@dist.com'),
('dist cbba','77733333','cbba@dist.com'),
('dist scz','77744444','scz@dist.com'),
('dist oruro','77755555','oruro@dist.com'),
('dist potosi','77766666','potosi@dist.com'),
('dist sucre','77777777','sucre@dist.com'),
('dist tarija','77788888','tarija@dist.com'),
('dist beni','77799999','beni@dist.com'),
('dist pando','77700000','pando@dist.com');

-- cliente
insert into cliente (nombre,tipo_cliente,telefono,direccion) values
('cliente1','minorista','70000001','zona 1'),
('cliente2','mayorista','70000002','zona 2'),
('cliente3','minorista','70000003','zona 3'),
('cliente4','mayorista','70000004','zona 4'),
('cliente5','minorista','70000005','zona 5'),
('cliente6','mayorista','70000006','zona 6'),
('cliente7','minorista','70000007','zona 7'),
('cliente8','mayorista','70000008','zona 8'),
('cliente9','minorista','70000009','zona 9'),
('cliente10','mayorista','70000010','zona 10');

-- rutadistribucion
insert into rutadistribucion (id_distribuidor,nombre_ruta,ciudad,estado) values
(1,'ruta 1','la paz','activa'),
(2,'ruta 2','el alto','activa'),
(3,'ruta 3','cbba','activa'),
(4,'ruta 4','scz','activa'),
(5,'ruta 5','oruro','activa'),
(6,'ruta 6','potosi','activa'),
(7,'ruta 7','sucre','activa'),
(8,'ruta 8','tarija','activa'),
(9,'ruta 9','beni','activa'),
(10,'ruta 10','pando','activa');

-- pedido
insert into pedido (id_cliente,id_ruta,fecha_pedido,estado,total) values
(1,1,'2026-05-01','registrado',50),
(2,2,'2026-05-01','entregado',80),
(3,3,'2026-05-02','registrado',60),
(4,4,'2026-05-02','entregado',90),
(5,5,'2026-05-03','registrado',70),
(6,6,'2026-05-03','entregado',100),
(7,7,'2026-05-04','registrado',110),
(8,8,'2026-05-04','entregado',120),
(9,9,'2026-05-04','registrado',130),
(10,10,'2026-05-04','entregado',140);

-- detallepedido
insert into detallepedido (id_pedido,id_producto,cantidad,precio_unitario,subtotal) values
(1,1,5,5.50,27.50),
(2,2,4,10.00,40.00),
(3,3,6,7.00,42.00),
(4,4,3,12.00,36.00),
(5,5,10,4.00,40.00),
(6,6,8,6.50,52.00),
(7,7,7,8.00,56.00),
(8,8,5,15.00,75.00),
(9,9,6,9.50,57.00),
(10,1,4,5.50,22.00);

-- entrega
insert into entrega (id_pedido,fecha_entrega,estado,observacion) values
(1,'2026-05-02','entregado','ok'),
(2,'2026-05-02','entregado','ok'),
(3,'2026-05-03','pendiente','en proceso'),
(4,'2026-05-03','entregado','ok'),
(5,'2026-05-04','pendiente','retraso'),
(6,'2026-05-04','entregado','ok'),
(7,'2026-05-05','pendiente','ruta larga'),
(8,'2026-05-05','entregado','ok'),
(9,'2026-05-05','pendiente','demora'),
(10,'2026-05-05','entregado','ok');

-- 1) mostrar categorias que contienen la palabra "a"
select * from categoria 
where nombre like "%a%";

-- 2) mostrar categorias que no sean "agua" ni "te"
select * from categoria 
where nombre not in ("agua","te");

-- 1) productos con precio entre 5 y 10 y activos
select * from producto 
where precio between 5 and 10 
and estado="activo";

-- 2) productos de categoria 1 o 2
select * from producto 
where id_categoria=1 or id_categoria=2;

-- 1) plantas en la paz o santa cruz
select * from planta 
where ciudad="la paz" or ciudad="santa cruz";

-- 2) plantas que no están en el alto
select * from planta 
where not ciudad="el alto";

-- 1) inventario con cantidad mayor a 80 y menor a 150
select * from inventario 
where cantidad > 80 and cantidad < 150;

-- 2) inventario de plantas 1,2 o 3
select * from inventario 
where id_planta in (1,2,3);

-- 1) distribuidores con correo que contenga "dist"
select * from distribuidor 
where correo like "%dist%";

-- 2) distribuidores que no tengan telefono especifico
select * from distribuidor 
where telefono not in ("77711111","77722222");

-- 1) clientes mayoristas o minoristas con telefono mayor a 70000005
select * from cliente 
where tipo_cliente="mayorista" or telefono > "70000005";

-- 2) clientes que no son mayoristas
select * from cliente 
where not tipo_cliente="mayorista";

-- 1) rutas activas en la paz o el alto
select * from rutadistribucion 
where ciudad="la paz" or ciudad="el alto"
and estado="activa";

-- 2) rutas que no están en ciertas ciudades

select * from rutadistribucion 
where ciudad not in ("pando","beni");

-- 1) pedidos con total entre 50 y 100 y estado registrado
select * from pedido 
where total between 50 and 100 
and estado="registrado";

-- 2) pedidos entregados o con total mayor a 120
select * from pedido 
where estado="entregado" or total > 120;

-- 1) detalles con cantidad mayor a 5 y subtotal mayor a 40
select * from detallepedido 
where cantidad > 5 and subtotal > 40;

-- 2) detalles que no sean del producto 1
select * from detallepedido 
where id_producto not in (1);

-- 1) entregas pendientes o con fecha mayor a 2026-05-03
select * from entrega 
where estado="pendiente" or fecha_entrega > "2026-05-03";

-- 2) entregas que no están entregadas
select * from entrega 
where not estado="entregado";

-- 1) inner join pedidos con clientes
select c.nombre,p.total 
from cliente c 
inner join pedido p on c.id_cliente=p.id_cliente;

-- 2) inner join producto con categoria
select p.nombre,c.nombre 
from producto p 
inner join categoria c on p.id_categoria=c.id_categoria;

-- 3) inner join inventario con planta
select i.cantidad,pl.nombre 
from inventario i 
inner join planta pl on i.id_planta=pl.id_planta;

-- 4) inner join detalle con producto
select d.cantidad,p.nombre 
from detallepedido d 
inner join producto p on d.id_producto=p.id_producto;

-- 5) inner join pedido con entrega
select p.id_pedido,e.estado 
from pedido p 
inner join entrega e on p.id_pedido=e.id_pedido;

-- 6) left join clientes con pedidos (aunque no tengan pedidos)
select c.nombre,p.total 
from cliente c 
left join pedido p on c.id_cliente=p.id_cliente;

-- 7) left join productos con inventario
select p.nombre,i.cantidad 
from producto p 
left join inventario i on p.id_producto=i.id_producto;

-- 8) right join pedidos con clientes
select c.nombre,p.total 
from cliente c 
right join pedido p on c.id_cliente=p.id_cliente;

-- 9) right join inventario con producto
select p.nombre,i.cantidad 
from producto p 
right join inventario i on p.id_producto=i.id_producto;

-- 10) inner join ruta con distribuidor
select r.nombre_ruta,d.nombre 
from rutadistribucion r 
inner join distribuidor d on r.id_distribuidor=d.id_distribuidor;