-- 30/04/26

-- Entradas con precio entre 80 y 200 ordenadas de mayor a menor
select * from entrada where precio between 80 and 200 order by precio desc;
-- Pagos entre 100 y 250 ordenados de menor a mayor
select * from pago where monto between 100 and 250 order by monto asc;
-- Eventos entre ciertas fechas ordenados por fecha descendente
select * from evento where fecha between '2025-06-01' and '2025-06-30' order by fecha desc;
-- Mostrar eventos que NO están en Campus ordenados por nombre
select * from evento where not lugar = "campus" order by nombre;
-- Pagos que NO son tarjeta ordenados por monto descendente
select * from pago where not metodo = "tarjeta";
-- Entradas que NO son vendidas ordenadas por precio
select * from entrada where not estado = "vendida" order by precio;
-- Ordenar pagos por monto descendente (top 5 pagos primero)
select * from pago order by monto desc limit 5;