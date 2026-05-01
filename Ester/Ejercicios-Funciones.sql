-- mostrar los distintos lugares de eventos
select distinct lugar from evento; 
-- mostrar metodos de pagos unicos
select distinct metodo from pago;
-- mostrar estados unicos de entradas;
select distinct estado from entrada;
-- select FUNCION (columna) as precio promedio from tabla;
-- mostrar el total de dinero recaudado
select sum(monto) as dinero_recaudado from pago;
-- suma de precios de todas las entradas
select sum(precio) as entradas_total from entrada;
-- total recaudado solo en pagos con tarjeta
select * from entrada;
select sum(monto) as total_pago_tarjeta  from pago where metodo = "tarjeta";
-- mostrar el precio promedio de entradas
select avg(precio) as promedio_precio_entradas from entrada;
-- promedio de los pagos
select avg(monto) as promedio_monto_entradas from pago;
-- prom entradas vendidas
select avg(precio) as promedio_entradas_vendidas from entrada where estado= "vendida" ;
-- cantidad total de usuarios
select count(id_usuario) from usuario;

select count(*) from entrada where estado="vendida";
-- mostrar cantidad de pagos con tarjeta
select count(*) from pago where metodo = "tarjeta";
-- mostrar el precio maximo de entradas
select max(precio) as precio_maximo from entrada;
-- mostrar el pago mas alto
select max(monto) as pago_maximo from pago;
-- mostrar la fecha mas reciente y el nombre del evento
select nombre, fecha from evento order by fecha desc limit 1;
-- precio minimo de la entrada
select min(precio) as precio_minimo from entrada;
-- pago mas pequeño
select min(monto) as pago_minimo from pago;
-- primera fecha del evento
select min(fecha) as primera_fecha from evento;

-- GROUP BY
-- cantidad de entradas por estado
select estado, count(*) as total_por_estado from entrada group by estado;
-- total recaudado por metodo de pago
select metodo, sum(monto) as total_pagado from pago group by metodo;
-- promedio de precios por estado
select estado, avg(precio) as promedio from entrada group by estado;
-- promedio de precios por estado redondeado
select estado, round(avg(precio),2) as promedio from entrada group by estado;
-- redondear el total monto de pagos 
select round(sum(monto),0) as total from pago;

-- Length
-- mostrar la longitud de los nombres de los usuarios
select nombre, length(nombre) as longitud from usuario;
-- mostrar la longitud de los correos de usuarios
select correo, length(correo) as longitud from usuario;

-- inner join
-- SELECT C.NOMBRE, V.TOTAL, V.FECHA_VENTA FROM CLIENTE C INNER JOIN VENTA V ON C.ID_CLIENTE = V.ID_CLIENTE
-- mostrar usuarios consus compras

select u.nombre as usuario, c.id_compra as compra 
from usuario u 
inner join compra c on u.id_usuario=c.id_usuario;
-- mostrar compras con el precio de la entrada
select c.id_compra, e.precio 
from compra c
inner join entrada e on c.id_entrada=e.id_entrada;

select *  
from compra c
inner join entrada e on c.id_entrada=e.id_entrada;

-- mostrar usuarios con el monto que pagaron
select u.nombre, sum(p.monto)
from usuario u
inner join compra c on u.id_usuario = c.id_usuario
inner join pago p on c.id_compra = p.id_compra 
group by u.nombre, u.id_usuario;

