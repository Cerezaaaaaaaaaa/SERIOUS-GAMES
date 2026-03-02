-- ELIMINA la base de datos si ya existe
DROP DATABASE IF EXISTS tienda_cojines_tdah;

-- CREA la base de datos limpia
CREATE DATABASE tienda_cojines_tdah;
USE tienda_cojines_tdah;

-- 1. Tabla Usuario
CREATE TABLE Usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    ciudad VARCHAR(50),
    correo VARCHAR(100) UNIQUE,
    contrasena VARCHAR(50),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabla Cojin
CREATE TABLE Cojin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    modelo VARCHAR(50),
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0
);

-- 3. Tabla Pedido
CREATE TABLE Pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_presente DATETIME DEFAULT CURRENT_TIMESTAMP,
    pago_total DECIMAL(10,2),
    estado VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE
);

-- 4. Tabla intermedia Pedido_Cojin
CREATE TABLE Pedido_Cojin (
    id_pedido INT NOT NULL,
    id_cojin INT NOT NULL,
    cantidad_cojines INT NOT NULL DEFAULT 1,
    pago_detalle VARCHAR(50),
    PRIMARY KEY (id_pedido, id_cojin),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id) ON DELETE CASCADE,
    FOREIGN KEY (id_cojin) REFERENCES Cojin(id) ON DELETE CASCADE
);

-- -------------------------
-- INSERTS
-- -------------------------

-- Usuarios
INSERT INTO Usuario (nombre, apellido1, apellido2, ciudad, correo, contrasena, fecha_registro) VALUES
('Lucia', 'Diaz', 'Garcia', 'Alicante', 'Lucia33@gmail.com', '45678', '2010-09-19'),
('Juan', 'Perez', 'Garcia', 'Barcelona', 'Juan2@gmail.com', '12345', '2020-09-29'),
('Maria', 'Isabel', 'Diaz', 'Madrid', 'Maria45@gmail.com', '23456', '2021-04-23'),
('Hugo', 'Aceituno', 'Rojas', 'Madrid', 'Hugo23@gmail.com', '89012', '2026-01-01');

-- SOLO 1 Cojín (el que tú pediste)
INSERT INTO Cojin (nombre, modelo, precio, stock) 
VALUES ('Cojín Calma TDAH', 'Ponderado 2kg', 45.00, 10);

-- Pedidos (todos referencian al cojin id = 1)
INSERT INTO Pedido (id_usuario, fecha_presente, pago_total, estado) VALUES
(1, '2024-10-19', 45.00, 'Entregado'),
(2, '2026-03-02', 45.00, 'Enviado'),
(3, '2026-01-05', 90.00, 'Entregado'),
(4, '2025-12-31', 135.00, 'Enviado');

-- Pedido_Cojin (todos usan id_cojin = 1 porque solo hay uno)
INSERT INTO Pedido_Cojin (id_pedido, id_cojin, cantidad_cojines, pago_detalle) VALUES
(1, 1, 1, 'Pagado'),
(2, 1, 1, 'Pagado'),
(3, 1, 2, 'Pagado'),
(4, 1, 3, 'Pagado');