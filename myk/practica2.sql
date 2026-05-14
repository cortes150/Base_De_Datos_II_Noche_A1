-- mostrar eventos que tienen entradas canceladas 
SELECT * from entrada;
SELECT * from entrada WHERE estado='cancelada';
SELECT * from evento WHERE id_evento in(SELECT id_evento from entrada WHERE estado='cancelada');
-- mostrar usuarios que no realizaron compras
SELECT * from 
-- mostrar eventos y cantidades de entrada
SELECT nombre, (SELECT count(id_evento) from entrada WHERE evento.id_evento = entrada.id_evento);
-- Vista: resumen de eventos (entradas vendidas, ingresos, disponibilidad)
CREATE VIEW vista_resumen_eventos AS
SELECT 
    e.id_evento,
    e.nombre,
    e.fecha,
    e.lugar,
    COUNT(CASE WHEN ent.estado = 'vendida' THEN 1 END) AS entradas_vendidas,
    COUNT(CASE WHEN ent.estado = 'cancelada' THEN 1 END) AS entradas_canceladas,
    COUNT(*) AS total_entradas_configuradas,
    COALESCE(SUM(CASE WHEN ent.estado = 'vendida' THEN ent.precio ELSE 0 END), 0) AS ingreso_total,
    ROUND(AVG(CASE WHEN ent.estado = 'vendida' THEN ent.precio ELSE NULL END), 2) AS precio_promedio_vendido
FROM evento e
LEFT JOIN entrada ent ON e.id_evento = ent.id_evento
GROUP BY e.id_evento, e.nombre, e.fecha, e.lugar;
-- Vista: cada usuario con número de compras, entradas y gasto total
CREATE VIEW vista_usuarios_compras AS
SELECT 
    u.id_usuario,
    u.nombre,
    u.correo,
    COUNT(DISTINCT c.id_compra) AS total_compras,
    COUNT(c.id_entrada) AS total_entradas,
    COALESCE(SUM(p.monto), 0) AS total_gastado,
    ROUND(COALESCE(AVG(p.monto), 0), 2) AS gasto_promedio_por_compra,
    MAX(c.id_compra) AS ultima_compra_id
FROM usuario u
LEFT JOIN compra c ON u.id_usuario = c.id_usuario
LEFT JOIN pago p ON c.id_compra = p.id_compra
GROUP BY u.id_usuario, u.nombre, u.correo;
-- Vista: asistencia con nombres y estado del evento
CREATE VIEW vista_asistencia_detalle AS
SELECT 
    a.id_asistencia,
    a.id_usuario,
    u.nombre AS nombre_usuario,
    u.correo,
    a.id_evento,
    ev.nombre AS nombre_evento,
    ev.fecha,
    ev.lugar,
    a.asistio,
    CASE 
        WHEN a.asistio = 1 THEN 'Asistió'
        WHEN a.asistio = 0 THEN 'No asistió'
        ELSE 'No registrado'
    END AS estado_asistencia,
    CASE 
        WHEN ev.fecha > CURDATE() THEN 'Próximo'
        WHEN ev.fecha = CURDATE() THEN 'Hoy'
        ELSE 'Finalizado'
    END AS estado_evento
FROM asistencia a
JOIN usuario u ON a.id_usuario = u.id_usuario
JOIN evento ev ON a.id_evento = ev.id_evento;
-- Vista: control de disponibilidad (entradas vendidas vs configuración)
CREATE VIEW vista_disponibilidad_eventos AS
SELECT 
    e.id_evento,
    e.nombre,
    e.fecha,
    COUNT(ent.id_entrada) AS total_entradas_creadas,
    SUM(CASE WHEN ent.estado = 'vendida' THEN 1 ELSE 0 END) AS entradas_vendidas,
    SUM(CASE WHEN ent.estado = 'cancelada' THEN 1 ELSE 0 END) AS entradas_canceladas,
    SUM(CASE WHEN ent.estado = 'vendida' THEN 1 ELSE 0 END) AS disponibles_para_venta,
    ROUND((SUM(CASE WHEN ent.estado = 'vendida' THEN 1 ELSE 0 END) / COUNT(ent.id_entrada)) * 100, 2) AS porcentaje_venta
FROM evento e
LEFT JOIN entrada ent ON e.id_evento = ent.id_evento
GROUP BY e.id_evento, e.nombre, e.fecha;
-- Vista: pagos realizados con información de usuario y evento
CREATE VIEW vista_pagos_completos AS
SELECT 
    p.id_pago,
    p.id_compra,
    p.monto,
    p.metodo,
    c.id_usuario,
    u.nombre AS nombre_usuario,
    u.correo AS email_usuario,
    ent.id_entrada,
    ent.precio AS precio_entrada,
    ev.id_evento,
    ev.nombre AS nombre_evento,
    ev.fecha AS fecha_evento,
    CASE 
        WHEN p.monto >= ent.precio THEN 'Pago completo'
        WHEN p.monto < ent.precio THEN 'Pago parcial'
        ELSE 'Inconsistente'
    END AS estado_pago
FROM pago p
JOIN compra c ON p.id_compra = c.id_compra
JOIN usuario u ON c.id_usuario = u.id_usuario
JOIN entrada ent ON c.id_entrada = ent.id_entrada
JOIN evento ev ON ent.id_evento = ev.id_evento;
-- Vista: estadísticas de ventas según método de pago
CREATE VIEW vista_ventas_por_metodo AS
SELECT 
    p.metodo,
    COUNT(p.id_pago) AS total_transacciones,
    SUM(p.monto) AS monto_total,
    ROUND(AVG(p.monto), 2) AS monto_promedio,
    COUNT(DISTINCT c.id_usuario) AS usuarios_distintos,
    ROUND((SUM(p.monto) / (SELECT SUM(monto) FROM pago) * 100), 2) AS porcentaje_del_total
FROM pago p
JOIN compra c ON p.id_compra = c.id_compra
GROUP BY p.metodo;
-- Vista: ranking de eventos por ingresos y asistencia
CREATE VIEW vista_ranking_eventos AS
SELECT 
    e.id_evento,
    e.nombre,
    e.fecha,
    COUNT(CASE WHEN ent.estado = 'vendida' THEN 1 END) AS entradas_vendidas,
    COALESCE(SUM(CASE WHEN ent.estado = 'vendida' THEN ent.precio ELSE 0 END), 0) AS ingreso_total,
    COALESCE(SUM(CASE WHEN a.asistio = 1 THEN 1 ELSE 0 END), 0) AS asistentes_reales,
    ROUND(COALESCE(SUM(CASE WHEN a.asistio = 1 THEN 1 ELSE 0 END) * 100.0 / 
        NULLIF(COUNT(CASE WHEN ent.estado = 'vendida' THEN 1 END), 0), 0), 2) AS porcentaje_asistencia,
    RANK() OVER (ORDER BY COALESCE(SUM(CASE WHEN ent.estado = 'vendida' THEN ent.precio ELSE 0 END), 0) DESC) AS ranking_ingresos
FROM evento e
LEFT JOIN entrada ent ON e.id_evento = ent.id_evento
LEFT JOIN asistencia a ON e.id_evento = a.id_evento
GROUP BY e.id_evento, e.nombre, e.fecha;
-- Vista: usuarios que compraron pero no asistieron al evento
CREATE VIEW vista_ausentes_con_compra AS
SELECT 
    u.id_usuario,
    u.nombre,
    u.correo,
    COUNT(c.id_compra) AS compras_realizadas,
    SUM(p.monto) AS total_gastado,
    GROUP_CONCAT(DISTINCT CONCAT(ev.nombre, ' (', ev.fecha, ')') SEPARATOR ', ') AS eventos_perdidos
FROM usuario u
JOIN compra c ON u.id_usuario = c.id_usuario
JOIN entrada ent ON c.id_entrada = ent.id_entrada
JOIN evento ev ON ent.id_evento = ev.id_evento
JOIN pago p ON c.id_compra = p.id_compra
LEFT JOIN asistencia a ON u.id_usuario = a.id_usuario AND ev.id_evento = a.id_evento
WHERE a.asistio IS NULL OR a.asistio = 0
GROUP BY u.id_usuario, u.nombre, u.correo;
-- Vista: ingresos agrupados por fecha de evento
CREATE VIEW vista_ingresos_por_fecha AS
SELECT 
    ev.fecha AS fecha_evento,
    COUNT(DISTINCT ev.id_evento) AS eventos_en_fecha,
    COUNT(ent.id_entrada) AS entradas_vendidas_en_fecha,
    COALESCE(SUM(CASE WHEN ent.estado = 'vendida' THEN ent.precio ELSE 0 END), 0) AS ingresos_totales,
    COUNT(DISTINCT c.id_usuario) AS compradores_distintos
FROM evento ev
LEFT JOIN entrada ent ON ev.id_evento = ent.id_evento AND ent.estado = 'vendida'
LEFT JOIN compra c ON ent.id_entrada = c.id_entrada
GROUP BY ev.fecha
ORDER BY ev.fecha;
-- Vista: métricas globales de unifest_db
CREATE VIEW vista_resumen_general AS
SELECT 
    (SELECT COUNT(*) FROM usuario) AS total_usuarios,
    (SELECT COUNT(*) FROM evento) AS total_eventos,
    (SELECT COUNT(*) FROM entrada WHERE estado = 'vendida') AS entradas_vendidas,
    (SELECT COUNT(*) FROM entrada WHERE estado = 'cancelada') AS entradas_canceladas,
    (SELECT COALESCE(SUM(monto), 0) FROM pago) AS ingresos_totales,
    (SELECT COALESCE(AVG(monto), 0) FROM pago) AS ingreso_promedio_por_pago,
    (SELECT COUNT(*) FROM asistencia WHERE asistio = 1) AS total_asistencias,
    ROUND((SELECT COUNT(*) FROM asistencia WHERE asistio = 1) * 100.0 / 
          NULLIF((SELECT COUNT(*) FROM entrada WHERE estado = 'vendida'), 0), 2) AS porcentaje_asistencia_global,
    (SELECT metodo FROM pago GROUP BY metodo ORDER BY COUNT(*) DESC LIMIT 1) AS metodo_pago_mas_usado;
-- Ejecutar todas las vistas (copiar y pegar en MySQL)
-- Luego consultar:

-- Ver resumen de eventos
SELECT * FROM vista_resumen_eventos;

-- Usuarios con más compras
SELECT * FROM vista_usuarios_compras ORDER BY total_gastado DESC;

-- Asistencia detallada
SELECT * FROM vista_asistencia_detalle WHERE estado_evento = 'Finalizado';

-- Disponibilidad actual
SELECT * FROM vista_disponibilidad_eventos;

-- Ventas por método de pago
SELECT * FROM vista_ventas_por_metodo;

-- Top eventos
SELECT * FROM vista_ranking_eventos;

-- Ausentes
SELECT * FROM vista_ausentes_con_compra;

-- Dashboard general
SELECT * FROM vista_resumen_general;