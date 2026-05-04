USE coca_cola_distribucion;

-- Insertar datos en la tabla categoria
INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES
(1, 'Gaseosas', 'Bebidas carbonatadas de diferentes sabores'),
(2, 'Energizantes', 'Bebidas con cafeína y estimulantes'),
(3, 'Jugos', 'Bebidas naturales o procesadas a base de frutas'),
(4, 'Aguas', 'Agua mineral y agua saborizada'),
(5, 'Tés', 'Bebidas frías a base de té');

-- Insertar datos en la tabla producto
INSERT INTO producto (id_producto, id_categoria, nombre, presentacion, volumen_ml, precio_unitario, estado) VALUES
(1, 1, 'Coca-Cola Original', 'Botella', 2000, 15.00, 'activo'),
(2, 1, 'Fanta Naranja', 'Botella', 2000, 13.50, 'activo'),
(3, 1, 'Sprite', 'Lata', 355, 6.00, 'activo'),
(4, 2, 'Power Energy', 'Lata', 473, 10.00, 'activo'),
(5, 3, 'Del Valle Durazno', 'Botella', 1000, 12.00, 'activo'),
(6, 3, 'Del Valle Manzana', 'Botella', 1000, 11.50, 'inactivo'),
(7, 4, 'Agua Vital', 'Botella', 600, 5.00, 'activo'),
(8, 5, 'Té Frío Limón', 'Botella', 500, 7.50, 'activo');

-- Insertar datos en la tabla planta
INSERT INTO planta (id_planta, nombre, ciudad, direccion) VALUES
(1, 'Planta La Paz', 'La Paz', 'Av. Industrial 123'),
(2, 'Planta Cochabamba', 'Cochabamba', 'Zona Parque Industrial'),
(3, 'Planta Santa Cruz', 'Santa Cruz', 'Av. Doble Vía 450'),
(4, 'Planta Oruro', 'Oruro', 'Zona Norte Industrial'),
(5, 'Planta Sucre', 'Sucre', 'Av. Circunvalación 88');

-- Insertar datos en la tabla inventario
INSERT INTO inventario (id_inventario, id_planta, id_producto, stock, stock_minimo, fecha_actualizacion) VALUES
(1, 1, 1, 120, 50, '2026-05-01'),
(2, 1, 2, 80, 40, '2026-05-01'),
(3, 2, 3, 30, 50, '2026-05-02'),
(4, 2, 4, 100, 30, '2026-05-02'),
(5, 3, 5, 25, 60, '2026-05-03'),
(6, 3, 6, 70, 40, '2026-05-03'),
(7, 4, 7, 200, 80, '2026-05-04');

-- Insertar datos en la tabla cliente
INSERT INTO cliente (id_cliente, nombre, tipo_cliente, ciudad, direccion, telefono) VALUES
(1, 'Supermercado Sol', 'supermercado', 'La Paz', 'Av. Arce 120', '70111111'),
(2, 'Tienda San Miguel', 'tienda', 'La Paz', 'Calle 21 de Calacoto', '70222222'),
(3, 'Restaurante El Buen Sabor', 'restaurante', 'Cochabamba', 'Av. Blanco Galindo 500', '70333333'),
(4, 'Supermercado Central', 'supermercado', 'Santa Cruz', 'Av. Cristo Redentor 300', '70444444'),
(5, 'Tienda La Estrella', 'tienda', 'Oruro', 'Calle Bolívar 45', '70555555'),
(6, 'Restaurante Sabor Criollo', 'restaurante', 'Sucre', 'Plaza 25 de Mayo', '70666666'),
(7, 'Supermercado Norte', 'supermercado', 'La Paz', 'Av. Montes 90', '70777777'),
(8, 'Tienda Sin Pedido', 'tienda', 'Tarija', 'Calle Comercio 11', '70888888');

-- Insertar datos en la tabla distribuidor
INSERT INTO distribuidor (id_distribuidor, nombre, telefono, ciudad, estado) VALUES
(1, 'Distribuidora Andina', '71000001', 'La Paz', 'activo'),
(2, 'Distribuidora Valle', '71000002', 'Cochabamba', 'activo'),
(3, 'Distribuidora Oriental', '71000003', 'Santa Cruz', 'activo'),
(4, 'Distribuidora Altiplano', '71000004', 'Oruro', 'inactivo'),
(5, 'Distribuidora Sin Ruta', '71000005', 'Potosí', 'activo');

-- Insertar datos en la tabla ruta
INSERT INTO ruta (id_ruta, id_distribuidor, nombre_ruta, ciudad_origen, ciudad_destino, distancia_km, estado) VALUES
(1, 1, 'Ruta La Paz Centro', 'La Paz', 'La Paz', 15.50, 'activa'),
(2, 1, 'Ruta La Paz Sur', 'La Paz', 'La Paz', 25.00, 'activa'),
(3, 2, 'Ruta Cochabamba Norte', 'Cochabamba', 'Cochabamba', 18.75, 'activa'),
(4, 3, 'Ruta Santa Cruz Este', 'Santa Cruz', 'Santa Cruz', 35.00, 'activa'),
(5, 4, 'Ruta Oruro Centro', 'Oruro', 'Oruro', 12.00, 'inactiva'),
(6, 3, 'Ruta Sin Pedidos', 'Santa Cruz', 'Montero', 45.00, 'activa');

-- Insertar datos en la tabla pedido
INSERT INTO pedido (id_pedido, id_cliente, id_ruta, fecha_pedido, estado_pedido) VALUES
(1, 1, 1, '2026-05-02 09:30:00', 'asignado'),
(2, 2, 2, '2026-05-03 10:15:00', 'asignado'),
(3, 3, 3, '2026-05-05 11:00:00', 'registrado'),
(4, 4, 4, '2026-05-06 14:20:00', 'asignado'),
(5, 5, 5, '2026-05-08 16:40:00', 'cancelado'),
(6, 6, 3, '2026-05-10 08:50:00', 'asignado'),
(7, 7, NULL, '2026-05-12 13:10:00', 'registrado');

-- Insertar datos en la tabla detalle_pedido
INSERT INTO detalle_pedido (id_detalle_pedido, id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 10, 15.00),
(2, 1, 3, 24, 6.00),
(3, 2, 2, 8, 13.50),
(4, 2, 5, 6, 12.00),
(5, 3, 4, 12, 10.00),
(6, 4, 1, 20, 15.00),
(7, 4, 7, 30, 5.00),
(8, 5, 6, 5, 11.50),
(9, 6, 5, 15, 12.00),
(10, 7, 8, 10, 7.50);

-- Insertar datos en la tabla entrega
INSERT INTO entrega (id_entrega, id_pedido, fecha_salida, fecha_entrega, estado_entrega, observacion) VALUES
(1, 1, '2026-05-02 12:00:00', '2026-05-02 16:30:00', 'entregado', 'Entrega realizada sin inconvenientes'),
(2, 2, '2026-05-03 13:00:00', NULL, 'en_ruta', 'Pedido en proceso de distribución'),
(3, 3, NULL, NULL, 'pendiente', 'Pedido pendiente de asignación final'),
(4, 4, '2026-05-06 15:00:00', '2026-05-06 18:45:00', 'entregado', 'Cliente recibió el pedido completo'),
(5, 5, NULL, NULL, 'pendiente', 'Pedido cancelado, no se realizó entrega'),
(6, 6, '2026-05-10 10:00:00', NULL, 'en_ruta', 'Entrega en camino');