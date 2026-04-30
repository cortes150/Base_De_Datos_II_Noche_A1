-- mostrar eventos en el lugar auditorio
select * from evento where lugar = "Auditorio";
-- mostrar entradas vendidas entrada estado vendida
select * from entrada where estado = "vendida";
-- mostrar entrada precio mayor a 180 
select * from pago where monto > 180;
-- correos que tengan mail
select * from usuario where correo like "%mail.com"
USE unifest_db;
 -- Realizar ejercicios de and, or, in, BETWEEN,  AND + OR, NOT y NOT IN 
 -- 1 Entradas vendidas con precio mayor a 100
   select * from entrada where precio > 100  and estado =  "vendida";
 -- 2 Eventos en junio en "Campus"
    select * from evento where fecha > 20205-06-00 and  fecha > 20205-07-00 and lugar =  "Campus";
 -- 3 Pagos con tarjeta y monto mayor a 100
 select * from pago where monto > 100 and metodo =  "tarjeta";
 -- 4 Entradas vendidas o canceladas
 select * from entrada where estado =  "vendida" or estado =  "cancelada";
 -- 5 Eventos en "Auditorio" o "Campus"
  select * from evento where lugar =  "Auditorio" or lugar =  "Campus";
 -- 6 Pagos en efectivo o tarjeta
  select * from pago where metodo =  "efectivo" or metodo =  "tarjeta";
 -- 7 Eventos en ciertos lugares
  select * from evento 
where lugar in ("Campus","Centro Convenciones");
 -- 8 Pagos con métodos específicos
   select * from pago 
where metodo in ("online","tarjeta");
 -- 9 Usuarios con IDs específicos
    select * from pago 
where metodo in ("online","tarjeta");
 -- 10 Entradas con precio entre 100 y 200
 select * from entrada where precio > 100 and precio < 200;
 -- 11 Eventos entre dos fechas
   select * from evento where fecha > 2025-06-01  and fecha < 2025-06-10;
 -- 12 Pagos entre 100 y 200
 select * from pago where monto > 100 and monto < 200;
 -- 13 Entradas vendidas y precio > 100 o canceladas
  select * from entrada where precio > 100  and estado =  "vendida"  or estado =  "cancelada";
 -- 14  Eventos en Auditorio o Campus en ciertas fechas
  select * from evento where lugar =  "Campus"  or  lugar =  "Auditorio"   and fecha >= 2025-06-01 and fecha >= 2025-06-10 ;
 -- 15 Pagos tarjeta > 100 o efectivo < 100
  select * from pago where monto > 100  and metodo =  "tarjeta"  or  monto < 100  and metodo =  "efectivo" ;
 -- 16 Entradas que NO están vendidas
 select * from entrada 
where not estado = "cancelada";
 -- 17 Eventos que NO son en Campus
 select * from evento 
where not lugar = "Campus";
-- 18 Pagos que NO son online
select * from pago 
where not metodo = "online";
 -- 19 Usuarios que NO están en la lista  
select * from usuario 
where nombre not in ("Juan Perez", "Ana Torres");

 -- 20 Eventos que NO están en ciertos lugares
 select * from evento 
where lugar not in ("Auditorio", "Coliseo");

 -- 21 Pagos que NO son tarjeta ni efectivo
 SELECT * FROM pago 
WHERE metodo NOT IN ("tarjeta", "efectivo");
