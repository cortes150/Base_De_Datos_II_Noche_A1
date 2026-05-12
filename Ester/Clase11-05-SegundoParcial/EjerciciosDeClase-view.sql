use unifest_db;
-- crea una vista que muestre unicamente los nombre y correos de usuarios
create view nombres_correo as 
select nombre, correo from usuario;
select * from nombres_correo;

-- crear una vista que muestre solamente los eventos realizados en campus
create view eventos_campus as 
select * from evento where lugar = "campus";
select * from eventos_campus;

-- mostrar una vista que muestre entradas con precios entre 100 y 200
create view entradas_entre100a200 as 
select * from entrada where precio between 100 and 200;
select * from entradas_entre100a200;

-- crear una vista que muestre el pago maximo registrado
create view pago_maximo as
select * from pago where monto = (select max(monto) from pago );
select * from pago_maximo;
-- crear que muestre la cantidad total de usuarios
create view cantidad_usuarios as
select count(*) from usuario;
select * from cantidad_usuarios;
-- crear una vista que muestre cantidad de entradas por estado
create view entradas_por_estado as
select estado, count(*) as cantidad from entrada group by estado;
-- crear una vista que muestre el total recaudado por metodo de pago
create view recaudado_por_metodo as
select metodo, sum(monto) as total_recaudado from pago group by metodo;
-- crear una vista que muestre cantidad de entradas por evento
create view entradas_por_evento as
select nombre, (select count(*) from entrada where evento.id_evento = entrada.id_evento) as cantidad from evento;
-- crear una vista que muestre usuarios y los montos pagados en total
create view pagado_por_usuario as
select u.nombre, sum(p.monto) as total_gastado
from usuario u
inner join compra c on u.id_usuario = c.id_usuario
inner join pago p on c.id_compra = p.id_compra
group by u.id_usuario, u.nombre;
-- crear una vista que muestre eventos y el precio de sus entradas
create view eventos_con_precios as
select e.nombre as evento, ent.precio
from evento e
inner join entrada ent on e.id_evento = ent.id_evento
order by e.nombre, ent.precio;
-- crear una vista que muestre usuarios y eventos a los que asistieron
create view asistencias_usuario_evento as
select u.nombre as usuario, e.nombre as evento, a.asistio
from usuario u
inner join asistencia a on u.id_usuario = a.id_usuario
inner join evento e on a.id_evento = e.id_evento
where a.asistio = 1;
-- crear una vista que muestre usuarios, compras, metodos de pagos
create view usuarios_compras_metodos as
select u.nombre as usuario, c.id_compra, p.monto, p.metodo
from usuario u
inner join compra c on u.id_usuario = c.id_usuario
inner join pago p on c.id_compra = p.id_compra;