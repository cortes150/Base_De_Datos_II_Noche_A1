use unifest_db;
-- mostrar el monto mas pequeños
select* from evento where id_evento in (select id_evento from entrada where estado = "cancelada" );
-- mostrar usuarios que no relizaron compras
select * from usuario where  id_usuario not in (
select id_compra from compra ) ;
select * from pago;
select * from compra;
select * from entrada;
select nombre, (select count(id_evento) from entrada where id_evento = entrada.id_evento);
select* from evento, (select id_evento in (select id_evento from entrada where avg(precio));
select evento, (select id_pago from monto where id_evento = entrada.id_evento);


SELECT * FROM vista_productos_caros;
select * from evento;
create view eventos_realizados_en_Campus as
select nombre,lugar
from evento where lugar = "Campus";
SELECT * FROM eventos_realizados_en_Campus;
select * from nombres_correos_usuario;
select * from entrada;

create view precio_entre_100_200 as
select precio,id_entrada
from entrada where precio between 100 and 200;
select * from precio_entre_100_200;
create view vista_entradas_caras as
select id_entrada,precio,estado
from entrada where precio>100;
select * from vista_entradas_caras;


create view precio_entre_100_200 as
select nombre
from usuario where precio between 100 and 200;
select * from precio_entre_100_200;


-- 1 que muestre la cantidad total de usuarios
create view total_usuarios as
select count(id_usuario) as total
from usuario;

select * from total_usuarios;

-- 2 que muestre la cantidad de entradas por estado
create view cantidad_entradas_por_estado as
select estado,count(*) as cantidad
from entrada
group by estado;

select * from cantidad_entradas_por_estado;

-- 3 que muestre el total recaudado por metodo de pago
create view total_recaudado_metodo_pago as
select metodo_pago,sum(monto) as total
from pago
group by metodo_pago;

select * from total_recaudado_metodo_pago;

-- 4 que muestre la cantidad total de entradas por evento
create view total_entradas_evento as
select e.nombre,count(en.id_entrada) as total
from evento e
join entrada en on e.id_evento = en.id_evento
group by e.nombre;

select * from total_entradas_evento;

-- 5 que muestre los usuarios y los montos pagados
create view usuarios_montos_pagados as
select u.nombre,p.monto
from usuario u
join compra c on u.id_usuario = c.id_usuario
join pago p on c.id_compra = p.id_compra;

select * from usuarios_montos_pagados;

-- 6 que muestre el precio de las entradas
create view precios_entradas as
select id_entrada,precio
from entrada;

select * from precios_entradas;

-- 7 usuarios y eventos a los que asistieron
create view usuarios_eventos as
select u.nombre,e.nombre as evento
from usuario u
join compra c on u.id_usuario = c.id_usuario
join entrada en on c.id_entrada = en.id_entrada
join evento e on en.id_evento = e.id_evento;

select * from usuarios_eventos;

-- 8 usuarios compras y metodos de pago
create view usuarios_compras_metodos as
select u.nombre,c.id_compra,p.metodo_pago
from usuario u
join compra c on u.id_usuario = c.id_usuario
join pago p on c.id_compra = p.id_compra;

select * from usuarios_compras_metodos;