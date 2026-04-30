use unifest_db;
-- Realizar ejercicios de and, or, in, BETWEEN,  AND + OR, NOT y NOT IN 
 -- Entradas vendidas con precio mayor a 100
 select * from entrada where estado = "vendida" and precio>100;
 -- Eventos en junio en "Campus"
 select * from evento where fecha like '2025-06%' and lugar = "Campus";
 -- Pagos con tarjeta y monto mayor a 100
 select * from pago where monto>100 and metodo="tarjeta";
 -- Entradas vendidas o canceladas
 select * from entrada where estado = "cancelada" or estado = "vendida";
 -- Eventos en "Auditorio" o "Campus"
 select * from evento where lugar = "Campus" or lugar = "Auditorio";
 -- Pagos en efectivo o tarjeta
 select * from pago where metodo = "tarjeta" or metodo = "efectivo";
 -- Eventos en ciertos lugares
 select * from evento where lugar in ('Coliseo', 'Campus');
 -- Pagos con métodos específicos
 select * from pago where metodo in ('online', 'efectivo');
 -- Usuarios con IDs específicos
 select * from usuario where id_usuario in ('1', '5');
 -- Entradas con precio entre 100 y 200
 select * from entrada where precio between 100 and 200 ;
 -- Eventos entre dos fechas
 select * from evento where fecha between "2025-06-05" and "2025-06-15";
 -- Pagos entre 100 y 200
 select * from pago where monto between 100 and 200;
 -- Entradas vendidas y precio > 100 o canceladas
 select * from entradas where (estado="vendida" and precio > 100) or estado = "cancelada";
 --  Eventos en Auditorio o Campus en ciertas fechas
 select * from evento where lugar = "auditorio" or (lugar="campus" and fecha in ('2025-06-05', '2025-06-15'));
 -- Pagos tarjeta > 100 o efectivo < 100
 select * from pago where (metodo = "tarjeta" and monto>100) or (metodo="efectivo" and monto<100);
 -- Entradas que NO están vendidas
 select * from entrada where not estado = "vendida";
 -- Eventos que NO son en Campus
 select * from evento where not lugar = "campus";
 -- Pagos que NO son online
 select * from pago where not metodo = "online";
 -- Usuarios que NO están en la lista
 select * from usuario where id_usuario not in (2, 3);
 -- Eventos que NO están en ciertos lugares
 select * from evento where lugar not in ('coliseo', 'campus');
 -- Pagos que NO son tarjeta ni efectivo  
 select * from pago where metodo not in ('tarjeta','efectivo');
