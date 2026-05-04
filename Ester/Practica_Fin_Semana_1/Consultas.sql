use coca_cola_distribucion;

-- consultas con "where"

-- enunciado: mostrar todos los productos que se encuentran activos.
select * from producto where estado = 'activo';

-- enunciado: mostrar todos los clientes que pertenecen a la ciudad de la paz.
select * from cliente where ciudad = 'la paz';


-- consultas con "like"

-- enunciado: mostrar los productos cuyo nombre contiene la palabra coca.
select * from producto where nombre like '%coca%';

-- enunciado: mostrar los clientes cuyo nombre empieza con la letra s.
select * from cliente where nombre like 's%';


-- consultas con "and"

-- enunciado: mostrar los productos que estén activos y que tengan un precio mayor a 10.
select * from producto where estado = 'activo' and precio_unitario > 10;

-- enunciado: mostrar los clientes que sean supermercados y estén ubicados en la paz.
select * from cliente where ciudad = 'la paz' and tipo_cliente = 'supermercado';


-- consultas con "or"

-- enunciado: mostrar los clientes que sean tiendas o supermercados.
select * from cliente where tipo_cliente = 'tienda' or tipo_cliente = 'supermercado';

-- enunciado: mostrar los distribuidores que estén activos o que pertenezcan a santa cruz.
select * from distribuidor where estado = 'activo' or ciudad = 'santa cruz';


-- consultas con "in"

-- enunciado: mostrar los clientes que estén en la paz, cochabamba o santa cruz.
select * from cliente where ciudad in ('la paz', 'cochabamba', 'santa cruz');

-- enunciado: mostrar los productos que pertenezcan a las categorías con id 1, 2 o 3.
select * from producto where id_categoria in (1, 2, 3);


-- consultas con "between"

-- enunciado: mostrar los productos cuyo precio esté entre 5 y 20.
select * from producto where precio_unitario between 5 and 20;

-- enunciado: mostrar los pedidos realizados durante el mes de mayo de 2026.
select * from pedido where fecha_pedido between '2026-05-01' and '2026-05-31 23:59:59';


-- consultas con "and" y "or"

-- enunciado: mostrar los productos activos con precio mayor a 10 o los productos inactivos.
select * from producto where (estado = 'activo' and precio_unitario > 10) or estado = 'inactivo';

-- enunciado: mostrar los clientes que sean tiendas de la paz o supermercados de cualquier ciudad.
select * from cliente where (tipo_cliente = 'tienda' and ciudad = 'la paz') or tipo_cliente = 'supermercado';


-- consultas con "not"

-- enunciado: mostrar los productos que no estén activos.
select * from producto where not estado = 'activo';

-- enunciado: mostrar los clientes que no sean de la ciudad de la paz.
select * from cliente where not ciudad = 'la paz';


-- consultas con "not in"

-- enunciado: mostrar los clientes que no sean tiendas ni restaurantes.
select * from cliente where tipo_cliente not in ('tienda', 'restaurante');

-- enunciado: mostrar las entregas que no estén pendientes ni en ruta.
select * from entrega where estado_entrega not in ('pendiente', 'en_ruta');


-- consultas con "order by"

-- enunciado: mostrar los productos ordenados por precio de mayor a menor.
select * from producto order by precio_unitario desc;

-- enunciado: mostrar los clientes ordenados alfabéticamente por nombre.
select * from cliente order by nombre asc;


-- consultas con "limit"

-- enunciado: mostrar los 5 productos más caros.
select * from producto order by precio_unitario desc limit 5;

-- enunciado: mostrar los 5 pedidos más recientes.
select * from pedido order by fecha_pedido desc limit 5;


-- consultas con "distinct"

-- enunciado: mostrar las ciudades distintas donde existen clientes registrados.
select distinct ciudad from cliente;

-- enunciado: mostrar los estados distintos que existen en las entregas.
select distinct estado_entrega from entrega;


-- consultas con "sum"

-- enunciado: mostrar el stock total de todos los productos registrados en inventario.
select sum(stock) as stock_total from inventario;

-- enunciado: mostrar el total vendido en dinero según el detalle de los pedidos.
select sum(cantidad * precio_unitario) as total_vendido from detalle_pedido;


-- consultas con "avg"

-- enunciado: mostrar el precio promedio de todos los productos.
select avg(precio_unitario) as promedio_precio_productos from producto;

-- enunciado: mostrar la distancia promedio de todas las rutas.
select avg(distancia_km) as promedio_distancia_rutas from ruta;


-- consultas con "count"

-- enunciado: contar la cantidad total de clientes registrados.
select count(*) as total_clientes from cliente;

-- enunciado: contar la cantidad total de entregas que se encuentran pendientes.
select count(*) as total_entregas_pendientes from entrega where estado_entrega = 'pendiente';


-- consultas con "max"

-- enunciado: mostrar el precio más alto registrado entre todos los productos.
select max(precio_unitario) as precio_maximo from producto;

-- enunciado: mostrar la mayor distancia registrada entre todas las rutas.
select max(distancia_km) as distancia_maxima from ruta;


-- consultas con "min"

-- enunciado: mostrar el precio más bajo registrado entre todos los productos.
select min(precio_unitario) as precio_minimo from producto;

-- enunciado: mostrar la fecha del primer pedido registrado.
select min(fecha_pedido) as primer_pedido from pedido;


-- consultas con "group by"

-- enunciado: mostrar la cantidad de pedidos agrupados por estado.
select estado_pedido, count(*) as total_pedidos from pedido group by estado_pedido;

-- enunciado: mostrar la cantidad de entregas agrupadas por estado.
select estado_entrega, count(*) as total_entregas from entrega group by estado_entrega;


-- consultas con "round"

-- enunciado: mostrar el precio promedio de los productos redondeado a 2 decimales.
select round(avg(precio_unitario), 2) as promedio_precio from producto;

-- enunciado: mostrar la distancia promedio de las rutas redondeada a 2 decimales.
select round(avg(distancia_km), 2) as promedio_distancia from ruta;


-- consultas con "length"

-- enunciado: mostrar la longitud del nombre de cada cliente.
select nombre, length(nombre) as longitud_nombre from cliente;

-- enunciado: mostrar la longitud del nombre de cada producto.
select nombre, length(nombre) as longitud_producto from producto;


-- consultas con "inner join"

-- enunciado: mostrar los productos junto con el nombre de la categoría a la que pertenecen.
select 
    p.id_producto,
    p.nombre as producto,
    c.nombre as categoria,
    p.presentacion,
    p.precio_unitario
from producto p
inner join categoria c
on p.id_categoria = c.id_categoria;

-- enunciado: mostrar los pedidos junto con la información del cliente que los realizó.
select 
    pe.id_pedido,
    cl.nombre as cliente,
    cl.tipo_cliente,
    cl.ciudad,
    pe.fecha_pedido,
    pe.estado_pedido
from pedido pe
inner join cliente cl
on pe.id_cliente = cl.id_cliente;

-- enunciado: mostrar los productos incluidos en cada pedido junto con su cantidad, precio unitario y subtotal.
select 
    dp.id_detalle_pedido,
    pe.id_pedido,
    p.nombre as producto,
    dp.cantidad,
    dp.precio_unitario,
    dp.cantidad * dp.precio_unitario as subtotal
from detalle_pedido dp
inner join pedido pe
on dp.id_pedido = pe.id_pedido
inner join producto p
on dp.id_producto = p.id_producto;

-- enunciado: mostrar las rutas junto con el distribuidor encargado de cada una.
select 
    r.id_ruta,
    r.nombre_ruta,
    r.ciudad_origen,
    r.ciudad_destino,
    d.nombre as distribuidor
from ruta r
inner join distribuidor d
on r.id_distribuidor = d.id_distribuidor;


-- consultas con "left join"

-- enunciado: mostrar todas las categorías, aunque no tengan productos registrados.
select 
    c.id_categoria,
    c.nombre as categoria,
    p.nombre as producto
from categoria c
left join producto p
on c.id_categoria = p.id_categoria;

-- enunciado: mostrar todos los clientes, aunque no hayan realizado pedidos.
select 
    cl.id_cliente,
    cl.nombre as cliente,
    cl.tipo_cliente,
    pe.id_pedido,
    pe.fecha_pedido,
    pe.estado_pedido
from cliente cl
left join pedido pe
on cl.id_cliente = pe.id_cliente;

-- enunciado: mostrar todas las rutas, aunque no tengan pedidos asignados.
select 
    r.id_ruta,
    r.nombre_ruta,
    r.ciudad_destino,
    pe.id_pedido,
    pe.estado_pedido
from ruta r
left join pedido pe
on r.id_ruta = pe.id_ruta;


-- consultas con "right join"

-- enunciado: mostrar todas las rutas, aunque no tengan pedidos asignados.
select 
    pe.id_pedido,
    pe.estado_pedido,
    r.id_ruta,
    r.nombre_ruta,
    r.ciudad_destino
from pedido pe
right join ruta r
on pe.id_ruta = r.id_ruta;

-- enunciado: mostrar todos los productos, aunque no estén registrados en inventario.
select 
    i.id_inventario,
    i.stock,
    i.fecha_actualizacion,
    p.id_producto,
    p.nombre as producto
from inventario i
right join producto p
on i.id_producto = p.id_producto;

-- enunciado: mostrar todos los distribuidores, aunque no tengan rutas asignadas.
select 
    r.id_ruta,
    r.nombre_ruta,
    d.id_distribuidor,
    d.nombre as distribuidor,
    d.ciudad
from ruta r
right join distribuidor d
on r.id_distribuidor = d.id_distribuidor;


-- consultas de reportes del negocio

-- enunciado: mostrar el producto más vendido según la cantidad total solicitada en pedidos.
select 
    p.nombre as producto,
    sum(dp.cantidad) as cantidad_vendida
from detalle_pedido dp
inner join producto p
on dp.id_producto = p.id_producto
group by p.id_producto, p.nombre
order by cantidad_vendida desc
limit 1;

-- enunciado: mostrar todos los productos ordenados desde el más vendido hasta el menos vendido.
select 
    p.nombre as producto,
    sum(dp.cantidad) as cantidad_vendida
from detalle_pedido dp
inner join producto p
on dp.id_producto = p.id_producto
group by p.id_producto, p.nombre
order by cantidad_vendida desc;

-- enunciado: mostrar el total de ventas agrupado por ciudad del cliente.
select 
    cl.ciudad,
    sum(dp.cantidad * dp.precio_unitario) as total_ventas
from pedido pe
inner join cliente cl
on pe.id_cliente = cl.id_cliente
inner join detalle_pedido dp
on pe.id_pedido = dp.id_pedido
group by cl.ciudad
order by total_ventas desc;

-- enunciado: mostrar la cantidad de rutas asignadas a cada distribuidor.
select 
    d.nombre as distribuidor,
    count(r.id_ruta) as total_rutas
from distribuidor d
left join ruta r
on d.id_distribuidor = r.id_distribuidor
group by d.id_distribuidor, d.nombre
order by total_rutas desc;

-- enunciado: mostrar las rutas con mayor cantidad de pedidos asignados.
select 
    r.nombre_ruta,
    count(pe.id_pedido) as total_pedidos
from ruta r
left join pedido pe
on r.id_ruta = pe.id_ruta
group by r.id_ruta, r.nombre_ruta
order by total_pedidos desc;

-- enunciado: mostrar el inventario de productos por planta.
select 
    i.id_inventario,
    pl.nombre as planta,
    pl.ciudad,
    p.nombre as producto,
    i.stock,
    i.stock_minimo,
    i.fecha_actualizacion
from inventario i
inner join planta pl
on i.id_planta = pl.id_planta
inner join producto p
on i.id_producto = p.id_producto
order by pl.nombre, p.nombre;

-- enunciado: mostrar los productos cuyo stock actual es menor al stock mínimo establecido.
select 
    i.id_inventario,
    pl.nombre as planta,
    p.nombre as producto,
    i.stock,
    i.stock_minimo
from inventario i
inner join planta pl
on i.id_planta = pl.id_planta
inner join producto p
on i.id_producto = p.id_producto
where i.stock < i.stock_minimo;
