use unifest_db;
-- mostrar las entradas con precio mayor al promedio
select * from entrada where precio > (select avg(precio) from entrada);
-- mostrar los pagos con el monto más pequeño.
select * from pago where monto = (select min(monto) from pago);
-- mostrar eventos que tiene entradas canceladas
select * from evento where id_evento in (select id_evento from entrada where estado = 'cancelada');
-- mostrar los usuarios que no hicieron compras
select * from usuario where id_usuario not in (select id_usuario from compra);
-- mostrar eventos y cantidades de entrada
select nombre, (select count(id_evento) from entrada where evento.id_evento = entrada.id_evento ) as cantidad_por_evento from evento;
-- mostrar eventos y promedios de precios
select nombre, (select avg(precio) from entrada where evento.id_evento = entrada.id_evento) as promedio_entrada from evento;