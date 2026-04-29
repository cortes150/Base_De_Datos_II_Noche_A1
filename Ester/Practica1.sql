-- mostrar eventos en el lugar auditorio
select * from evento where lugar = "Auditorio";
-- mostrar entradas vendidas
select * from entrada where estado = "vendida" ;
-- mostrar el precio de la entrada mayores a 180
select * from entrada where precio > 180;
-- correos que terminen mail.com de usuarios
select * from usuario where correo like '%mail.com'