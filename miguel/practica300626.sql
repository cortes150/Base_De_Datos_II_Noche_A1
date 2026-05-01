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
-- 30/06/2026
-- pago menor
select min(monto) as pago_menor from pago;
-- fecha menor
select min(fecha) as fecha_menor from evento;
