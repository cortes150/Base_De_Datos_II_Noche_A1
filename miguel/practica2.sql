use unifest_db;
-- 1. mostrar las entradas que tienen el precio más alto
select * from entrada
where precio = (select max(precio) from entrada);

-- 2. mostrar los pagos con el monto más pequeño
select * from pago
where monto = (select min(monto) from pago);

-- 3. mostrar los eventos cuya fecha sea la más reciente
select * from evento
where fecha = (select max(fecha) from evento);

-- 4. mostrar las entradas con precio mayor al promedio de todas las entradas
select * from entrada
where precio > (select avg(precio) from entrada);

-- 5. mostrar los pagos mayores al promedio de pagos
select * from pago
where monto > (select avg(monto) from pago);

-- 6. mostrar los eventos que tienen entradas canceladas
select * from evento
where id_evento in (
    select id_evento from entrada
    where estado = "cancelada"
);

-- 7. mostrar los usuarios que realizaron compras
select * from usuario
where id_usuario in (
    select id_usuario from compra
);

-- 8. mostrar los usuarios que no realizaron compras
select * from usuario
where id_usuario not in (
    select id_usuario from compra
);

-- 9. mostrar los eventos que tienen entradas vendidas
select * from evento
where id_evento in (
    select id_evento from entrada
    where estado = "vendida"
);

-- 10. mostrar los pagos realizados con tarjeta
select * from pago
where metodo = "tarjeta";

-- 11. mostrar cada usuario junto con la cantidad de compras que realizó
select u.nombre, count(c.id_compra) as cantidad_compras
from usuario u
left join compra c on u.id_usuario = c.id_usuario
group by u.nombre;

-- 12. mostrar cada evento junto con la cantidad de entradas registradas
select e.nombre, count(en.id_entrada) as cantidad_entradas
from evento e
left join entrada en on e.id_evento = en.id_evento
group by e.nombre;

-- 13. mostrar cada evento junto con el promedio de precios de sus entradas
select e.nombre, avg(en.precio) as promedio_precio
from evento e
inner join entrada en on e.id_evento = en.id_evento
group by e.nombre;

-- 14. mostrar cada usuario junto con el total de dinero pagado
select u.nombre, sum(p.monto) as total_pagado
from usuario u
inner join compra c on u.id_usuario = c.id_usuario
inner join pago p on c.id_compra = p.id_compra
group by u.nombre;

-- 15. mostrar cada evento junto con el precio máximo de sus entradas
select e.nombre, max(en.precio) as precio_maximo
from evento e
inner join entrada en on e.id_evento = en.id_evento
group by e.nombre;

-- 16. mostrar cada usuario junto con la cantidad de asistencias registradas
select u.nombre, count(a.id_asistencia) as total_asistencias
from usuario u
left join asistencia a on u.id_usuario = a.id_usuario
group by u.nombre;

-- 17. mostrar cada evento junto con la cantidad de entradas canceladas
select e.nombre, count(en.id_entrada) as entradas_canceladas
from evento e
inner join entrada en on e.id_evento = en.id_evento
where en.estado = "cancelada"
group by e.nombre;

-- 18. mostrar cada usuario junto con la cantidad de pagos realizados
select u.nombre, count(p.id_pago) as cantidad_pagos
from usuario u
inner join compra c on u.id_usuario = c.id_usuario
inner join pago p on c.id_compra = p.id_compra
group by u.nombre;

-- 19. mostrar cada evento junto con la suma total de precios de sus entradas
select e.nombre, sum(en.precio) as total_precios
from evento e
inner join entrada en on e.id_evento = en.id_evento
group by e.nombre;

-- 20. mostrar cada usuario junto con el pago más alto que realizó
select u.nombre, max(p.monto) as pago_mayor
from usuario u
inner join compra c on u.id_usuario = c.id_usuario
inner join pago p on c.id_compra = p.id_compra
group by u.nombre;

-- 21. mostrar el promedio de los montos totales agrupados por método de pago
select metodo, avg(monto) as promedio_monto
from pago
group by metodo;

-- 22. mostrar los métodos de pago cuyo total recaudado sea mayor a 200
select metodo, sum(monto) as total_recaudado
from pago
group by metodo
having sum(monto) > 200;

-- 23. mostrar los eventos cuyo precio máximo de entrada sea mayor a 150
select e.nombre, max(en.precio) as precio_maximo
from evento e
inner join entrada en on e.id_evento = en.id_evento
group by e.nombre
having max(en.precio) > 150;

-- 24. mostrar la cantidad de entradas agrupadas por estado
select estado, count(*) as cantidad
from entrada
group by estado;

-- 25. mostrar el promedio de entradas vendidas por evento
select e.nombre, avg(en.precio) as promedio_entradas_vendidas
from evento e
inner join entrada en on e.id_evento = en.id_evento
where en.estado = "vendida"
group by e.nombre;

-- 26. mostrar los usuarios que realizaron al menos una compra
select * from usuario
where id_usuario in (
    select id_usuario from compra
);

-- 27. mostrar los eventos que tienen al menos una entrada cancelada
select * from evento
where id_evento in (
    select id_evento from entrada
    where estado = "cancelada"
);

-- 28. mostrar los usuarios que asistieron al menos a un evento
select * from usuario
where id_usuario in (
    select id_usuario from asistencia
    where asistio = 1
);

-- 29. mostrar los usuarios que no realizaron pagos
select * from usuario
where id_usuario not in (
    select c.id_usuario
    from compra c
    inner join pago p on c.id_compra = p.id_compra
);

-- 30. mostrar los eventos que no tienen entradas canceladas
select * from evento
where id_evento not in (
    select id_evento from entrada
    where estado = "cancelada"
);