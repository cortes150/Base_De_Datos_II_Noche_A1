
-- mostrar eventos en el lugar auditorio;

SELECT * from evento WHERE lugar = "auditorio";

-- mostrar entradas vendidas;

SELECT * from entrada WHERE estado = "vendida";

-- mostrar el precio mayores a 180;

select * from entrada WHERE precio => 180;

-- correos que terminen en mail.com;

select * from usuario WHERE correo like '%mail.com'