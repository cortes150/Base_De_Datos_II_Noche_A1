use unifest_db;
-- 1. mostrar las entradas que tienen el precio más alto.
select * from entrada where precio = (select max(precio) from entrada);

-- 2. mostrar los pagos con el monto más pequeño.
select * from pago where monto = (select min(monto) from pago);

-- 3. mostrar los eventos cuya fecha sea la más reciente.
select * from evento where fecha = (select max(fecha) from evento);

-- 4. mostrar las entradas con precio mayor al promedio de todas las entradas.
select * from entrada where precio > (select avg(precio) from entrada);

-- 5. mostrar los pagos mayores al promedio de pagos.
select * from pago where monto > (select avg(monto) from pago);

-- 6. mostrar los eventos que tienen entradas canceladas.
select * from evento where id_evento in (select id_evento from entrada where estado = 'cancelada');

-- 7. mostrar los usuarios que realizaron compras.
select * from usuario where id_usuario in (select id_usuario from compra);

-- 8. mostrar los usuarios que no realizaron compras.
select * from usuario where id_usuario not in (select id_usuario from compra);

-- 9. mostrar los eventos que tienen entradas vendidas.
select * from evento where id_evento in (select id_evento from entrada where estado = 'vendida');

-- 10. mostrar los pagos realizados con tarjeta.
select * from pago where metodo = 'tarjeta';  -- (no requiere subconsulta, pero también se puede con in: where id_compra in (select id_compra from pago where metodo='tarjeta'))

-- 11. mostrar cada usuario junto con la cantidad de compras que realizó.
select nombre, (select count(*) from compra where compra.id_usuario = usuario.id_usuario) as cantidad_compras from usuario;

-- 12. mostrar cada evento junto con la cantidad de entradas registradas.
select nombre, (select count(*) from entrada where entrada.id_evento = evento.id_evento) as cantidad_entradas from evento;

-- 13. mostrar cada evento junto con el promedio de precios de sus entradas.
select nombre, (select avg(precio) from entrada where entrada.id_evento = evento.id_evento) as precio_promedio from evento;

-- 14. mostrar cada usuario junto con el total de dinero pagado.
select nombre, (select sum(p.monto) from compra c join pago p on c.id_compra = p.id_compra where c.id_usuario = usuario.id_usuario) as total_pagado from usuario;

-- 15. mostrar cada evento junto con el precio máximo de sus entradas.
select nombre, (select max(precio) from entrada where entrada.id_evento = evento.id_evento) as precio_maximo from evento;

-- 16. mostrar cada usuario junto con la cantidad de asistencias registradas.
select nombre, (select count(*) from asistencia where asistencia.id_usuario = usuario.id_usuario and asistio = 1) as cantidad_asistencias from usuario;

-- 17. mostrar cada evento junto con la cantidad de entradas canceladas.
select nombre, (select count(*) from entrada where entrada.id_evento = evento.id_evento and estado = 'cancelada') as canceladas from evento;

-- 18. mostrar cada usuario junto con la cantidad de pagos realizados.
select nombre, (select count(*) from compra c join pago p on c.id_compra = p.id_compra where c.id_usuario = usuario.id_usuario) as cantidad_pagos from usuario;

-- 19. mostrar cada evento junto con la suma total de precios de sus entradas.
select nombre, (select sum(precio) from entrada where entrada.id_evento = evento.id_evento) as suma_precios from evento;

-- 20. mostrar cada usuario junto con el pago más alto que realizó.
select nombre, (select max(p.monto) from compra c join pago p on c.id_compra = p.id_compra where c.id_usuario = usuario.id_usuario) as pago_mas_alto from usuario;

-- 21. mostrar el promedio de los montos totales agrupados por método de pago.
select avg(total_metodo) as promedio_totales from (select metodo, sum(monto) as total_metodo from pago group by metodo) as tmp;

-- 22. mostrar los métodos de pago cuyo total recaudado sea mayor a 200.
select metodo, total from (select metodo, sum(monto) as total from pago group by metodo) as tmp where total > 200;

-- 23. mostrar los eventos cuyo precio máximo de entrada sea mayor a 150.
select e.nombre, sub.precio_max from evento e join (select id_evento, max(precio) as precio_max from entrada group by id_evento) as sub on e.id_evento = sub.id_evento where sub.precio_max > 150;

-- 24. mostrar la cantidad de entradas agrupadas por estado.
select estado, count(*) as cantidad from entrada group by estado;  -- o usando subconsulta from: select * from (select estado, count(*) as cantidad from entrada group by estado) as tmp;

-- 25. mostrar el promedio de entradas vendidas por evento.
select avg(vendidas) as promedio_entradas_vendidas_por_evento from (select id_evento, count(*) as vendidas from entrada where estado = 'vendida' group by id_evento) as tmp;

-- 26. mostrar los usuarios que realizaron al menos una compra (exists).
select * from usuario u where exists (select 1 from compra c where c.id_usuario = u.id_usuario);

-- 27. mostrar los eventos que tienen al menos una entrada cancelada (exists).
select * from evento e where exists (select 1 from entrada ent where ent.id_evento = e.id_evento and ent.estado = 'cancelada');

-- 28. mostrar los usuarios que asistieron al menos a un evento (exists).
select * from usuario u where exists (select 1 from asistencia a where a.id_usuario = u.id_usuario and a.asistio = 1);

-- 29. mostrar los usuarios que no realizaron pagos (not exists).
select * from usuario u where not exists (select 1 from compra c join pago p on c.id_compra = p.id_compra where c.id_usuario = u.id_usuario);

-- 30. mostrar los eventos que no tienen entradas canceladas (not exists).
select * from evento e where not exists (select 1 from entrada ent where ent.id_evento = e.id_evento and ent.estado = 'cancelada');
