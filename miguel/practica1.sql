-- mostrar eventos en el lugar auditorio
select * from evento where lugar = "Auditorio";
-- mostrar entradas vendidas entrada estado vendida
select * from entrada where estado = "vendida";
-- mostrar entrada precio mayor a 180 
select * from pago where monto > 180;