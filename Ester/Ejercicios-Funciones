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
