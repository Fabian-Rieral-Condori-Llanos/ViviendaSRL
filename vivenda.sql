-- CREATE DATABASE Vivienda
use Vivienda
CREATE TABLE Cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  ci VARCHAR(20) UNIQUE,
  correo VARCHAR(100),
  telefono VARCHAR(20),
  tipo_cliente ENUM('propietario', 'arrendatario', 'comprador')
);

CREATE TABLE Agente (
  id_agente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  correo VARCHAR(100),
  telefono VARCHAR(20)
);

CREATE TABLE Inmueble (
  id_inmueble INT AUTO_INCREMENT PRIMARY KEY,
  direccion VARCHAR(200),
  ciudad VARCHAR(50),
  tipo VARCHAR(50),
  precio DECIMAL(12,2),
  caracteristicas TEXT,
  estado ENUM('disponible', 'alquilado', 'vendido'),
  id_propietario INT,
  FOREIGN KEY (id_propietario) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Contrato (
  id_contrato INT AUTO_INCREMENT PRIMARY KEY,
  tipo ENUM('alquiler', 'venta'),
  fecha_inicio DATE,
  fecha_fin DATE,
  estado ENUM('activo', 'vencido', 'cancelado'),
  id_cliente INT,
  id_inmueble INT,
  id_agente INT,
  porcentaje_comision DECIMAL(5,2),
  modalidad_pago ENUM('contado', 'cuotas'),
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
  FOREIGN KEY (id_inmueble) REFERENCES Inmueble(id_inmueble),
  FOREIGN KEY (id_agente) REFERENCES Agente(id_agente)
);

CREATE TABLE Pago (
  id_pago INT AUTO_INCREMENT PRIMARY KEY,
  id_contrato INT,
  fecha_pago DATE,
  monto DECIMAL(10,2),
  tipo_pago ENUM('alquiler', 'venta', 'servicio'),
  estado ENUM('pendiente', 'pagado'),
  FOREIGN KEY (id_contrato) REFERENCES Contrato(id_contrato)
);

CREATE TABLE Visita (
  id_visita INT AUTO_INCREMENT PRIMARY KEY,
  fecha DATE,
  hora TIME,
  id_inmueble INT,
  id_cliente INT,
  id_agente INT,
  comentarios TEXT,
  FOREIGN KEY (id_inmueble) REFERENCES Inmueble(id_inmueble),
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
  FOREIGN KEY (id_agente) REFERENCES Agente(id_agente)
);

INSERT INTO Cliente (nombre, ci, correo, telefono, tipo_cliente) VALUES
('Juan Pérez', '1234567', 'juanperez@gmail.com', '76543210', 'propietario'),
('María López', '2345678', 'mlopez@hotmail.com', '71234567', 'arrendatario'),
('Carlos Torres', '3456789', 'ctorres@yahoo.com', '78901234', 'comprador'),
('Ana Rojas', '4567890', 'anarojas@gmail.com', '70001234', 'propietario'),
('Luis Gómez', '5678901', 'lgomez@gmail.com', '75432109', 'arrendatario');

INSERT INTO Agente (nombre, correo, telefono) VALUES
('Gabriela Mendoza', 'gmendoza@viviendaideal.com', '78889999'),
('Ricardo Vargas', 'rvargas@viviendaideal.com', '79998888');

INSERT INTO Inmueble (direccion, ciudad, tipo, precio, caracteristicas, estado, id_propietario) VALUES
('Av. Blanco Galindo #123', 'Cochabamba', 'Departamento', 80000, '3 dormitorios, 2 baños, cocina equipada', 'disponible', 1),
('Calle Sucre #456', 'La Paz', 'Casa', 120000, '4 dormitorios, patio, garaje', 'alquilado', 4),
('Av. Banzer #789', 'Santa Cruz', 'Local Comercial', 150000, '200 m2, vidrieras grandes', 'vendido', 1);

INSERT INTO Contrato (tipo, fecha_inicio, fecha_fin, estado, id_cliente, id_inmueble, id_agente, porcentaje_comision, modalidad_pago) VALUES
('alquiler', '2025-01-01', '2025-12-31', 'activo', 2, 2, 1, 5.00, 'cuotas'),
('venta', '2024-05-01', '2024-06-15', 'cancelado', 3, 3, 2, 3.00, 'contado');

INSERT INTO Pago (id_contrato, fecha_pago, monto, tipo_pago, estado) VALUES
(1, '2025-02-01', 500, 'alquiler', 'pagado'),
(1, '2025-03-01', 500, 'alquiler', 'pendiente'),
(2, '2024-05-10', 150000, 'venta', 'pagado');

INSERT INTO Visita (fecha, hora, id_inmueble, id_cliente, id_agente, comentarios) VALUES
('2025-01-10', '10:00:00', 1, 3, 1, 'Cliente interesado en conocer más detalles'),
('2025-01-15', '15:30:00', 1, 5, 2, 'Cliente solicitó planos del departamento');


CREATE PROCEDURE ReporteContratos()
BEGIN
  SELECT
    C.id_contrato,
    C.tipo,
    C.fecha_inicio,
    C.fecha_fin,
    C.estado,
    CL.nombre AS cliente,
    I.direccion AS inmueble
  FROM Contrato C
  JOIN Cliente CL ON C.id_cliente = CL.id_cliente
  JOIN Inmueble I ON C.id_inmueble = I.id_inmueble;
END;

CALL ReporteContratos();

DELIMITER $$

CREATE PROCEDURE ReportePagosPendientes(IN mes INT, IN anio INT)
BEGIN
  SELECT
    P.id_pago,
    P.fecha_pago,
    P.monto,
    P.tipo_pago,
    P.estado,
    CL.nombre AS cliente,
    I.direccion AS inmueble
  FROM Pago P
  JOIN Contrato C ON P.id_contrato = C.id_contrato
  JOIN Cliente CL ON C.id_cliente = CL.id_cliente
  JOIN Inmueble I ON C.id_inmueble = I.id_inmueble
  WHERE P.estado = 'pendiente'
    AND MONTH(P.fecha_pago) = mes
    AND YEAR(P.fecha_pago) = anio;
END;

DELIMITER ;
CALL ReportePagosPendientes(3, 2025);


CREATE PROCEDURE ReporteIngresosMensuales(IN mes INT, IN anio INT)
BEGIN
  SELECT
    P.tipo_pago AS tipo_operacion,
    SUM(P.monto) AS monto_total,
    COUNT(*) AS cantidad_pagos
  FROM Pago P
  WHERE P.estado = 'pagado'
    AND MONTH(P.fecha_pago) = mes
    AND YEAR(P.fecha_pago) = anio
  GROUP BY P.tipo_pago;
END;

CALL ReporteIngresosMensuales(5, 2024);


CREATE PROCEDURE ReporteComisiones()
BEGIN
  SELECT
    A.nombre AS agente,
    COUNT(C.id_contrato) AS cantidad_contratos,
    SUM((P.monto * C.porcentaje_comision) / 100) AS monto_comision
  FROM Agente A
  JOIN Contrato C ON C.id_agente = A.id_agente
  JOIN Pago P ON P.id_contrato = C.id_contrato
  WHERE P.estado = 'pagado'
  GROUP BY A.id_agente;
END;

CALL ReporteComisiones();


CREATE PROCEDURE ReporteVisitas()
BEGIN
  SELECT
    I.direccion AS inmueble,
    COUNT(V.id_visita) AS cantidad_visitas
  FROM Visita V
  JOIN Inmueble I ON V.id_inmueble = I.id_inmueble
  GROUP BY V.id_inmueble
  ORDER BY cantidad_visitas DESC;
END;

CALL ReporteVisitas();