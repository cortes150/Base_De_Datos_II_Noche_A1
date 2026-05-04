-- 30/04/26
USE unifest_db;
-- precio entre 80 y 200 ordenadas de mayor a menor
select * from entrada where precio between 80 and 200 order by precio asc ;
-- Pagos entre 100 y 250 ordenados de menor a mayor
select * from pago where monto between 100 and 250 order by monto desc ;
-- Eventos entre ciertas fechas ordenados por fecha descendente
select * from evento where fecha between 2025-06-01 and 2025-06-10 order by fecha desc;
-- Mostrar eventos que NO están en Campus ordenados por nombre
select * from evento where not lugar ="Capmus" order by nombre desc ;
-- Pagos que NO son tarjeta ordenados por monto descendente
select * from pago where not metodo ="tarjeta" order by monto desc ;
-- Entradas que NO son vendidas ordenadas por precio
select * from entrada where not estado ="vendida" order by precio asc ;
-- Ordenar pagos por monto descendente (top pagos primero)
select * from pago where monto order by monto desc ;

select * from usuario limit 5; 
select * from pago  order by monto desc limit 2;
select * from pago  order by monto desc limit 2;
select distinct lugar from evento ;

select distinct metodo from pago ;

select distinct estado from entrada ;

select SUM(monto) as dinero_recaudado
from pago;
select SUM(precio) as entradas_total
from entrada;

select SUM(monto) as recaudado_total 
from pago where metodo="tarjeta";

select avg(precio) as promedio 
from entrada;

select *
from pago;

select avg(monto) as promedio 
from pago;
-- count
select count(nombre) as total from usuario;
select avg(precio) as recaudado_total 
from entrada where estado="vendida";

select avg(precio) as recaudado_total 
from entrada where estado="vendida";
select count(nombre) as total from usuario;
select count(estado) as total from entrada where estado="vendida";

select count(*) as total from pago where metodo="tarjeta";

select count(*) as total from pago where metodo="tarjeta";

select *
from pago;
select max(fecha) as lugar from evento;
select max(monto) as total from pago;
select count(*) as total from pago where metodo="tarjeta";
select max(fecha) as lugar from evento group by nombre;
select min(precio) as lugar from entrada;
select nombre,fecha from evento order by fecha desc limit 1;
select min(monto) as pago_menor from pago;
select min(fecha) as fecha_menor from evento;
select * from entrada;
select estado,count(*) as total from entrada group by estado;

select metodo, sum(monto) as total from pago group by metodo;
select estado, avg(precio) as total from entrada group by estado;

select * from pago;

select estado, avg(precio) as total from entrada group by estado;

select round(avg(precio),2) as precioredondeado
from entrada;

select round(avg(precio),2) as precio_redondeado
from entrada;

select round( sum(monto),2) as pago_redondeado
from pago;

select round( sum(monto),0) as pago_total
from pago;


select *
from usuario;

select nombre,length(nombre) as longitud from usuario;

select correo,length(correo) as longitud from usuario;

select * from evento;

select lugar,length(lugar) as longitud from evento;
select * from compra
select * from pago
-- select c.nombre,v.total.v.fecha_venta from Cliente c inner join 
select u.nombre,c.id_compra from usuario u inner join compra c on u.id_usuario= c.id_usuario;

select u.precio,c.id_compra from pago u inner join compra c on u.id_compra;
select * from compra c
inner join entrada e on c.id_entrada= e.id_entrada;
select c.id_compra,e.precio from compra c inner join entrada e on c.id_entrada=e.id_entrada;
-- mostrar usuarios con el m0nto que pagaron 
select u.nombre,p.monto from usuario u inner join compra c on u.id_usuario=c.id_usuario
inner join pago p on c.id_compra=p.id_compra