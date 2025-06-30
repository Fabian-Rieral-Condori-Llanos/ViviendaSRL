/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.1-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 192.168.0.5    Database: Vivienda
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `Agente`
--

DROP TABLE IF EXISTS `Agente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Agente` (
  `id_agente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_agente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Agente`
--

LOCK TABLES `Agente` WRITE;
/*!40000 ALTER TABLE `Agente` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Agente` VALUES
(1,'Gabriela Mendoza','gmendoza@viviendaideal.com','78889999'),
(2,'Ricardo Vargas','rvargas@viviendaideal.com','79998888');
/*!40000 ALTER TABLE `Agente` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `ci` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `tipo_cliente` enum('propietario','arrendatario','comprador') DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `ci` (`ci`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Cliente` VALUES
(1,'Juan Pérez','1234567','juanperez@gmail.com','76543210','propietario'),
(2,'María López','2345678','mlopez@hotmail.com','71234567','arrendatario'),
(3,'Carlos Torres','3456789','ctorres@yahoo.com','78901234','comprador'),
(4,'Ana Rojas','4567890','anarojas@gmail.com','70001234','propietario'),
(5,'Luis Gómez','5678901','lgomez@gmail.com','75432109','arrendatario');
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Contrato`
--

DROP TABLE IF EXISTS `Contrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Contrato` (
  `id_contrato` int NOT NULL AUTO_INCREMENT,
  `tipo` enum('alquiler','venta') DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estado` enum('activo','vencido','cancelado') DEFAULT NULL,
  `id_cliente` int DEFAULT NULL,
  `id_inmueble` int DEFAULT NULL,
  `id_agente` int DEFAULT NULL,
  `porcentaje_comision` decimal(5,2) DEFAULT NULL,
  `modalidad_pago` enum('contado','cuotas') DEFAULT NULL,
  PRIMARY KEY (`id_contrato`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_inmueble` (`id_inmueble`),
  KEY `id_agente` (`id_agente`),
  CONSTRAINT `Contrato_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `Cliente` (`id_cliente`),
  CONSTRAINT `Contrato_ibfk_2` FOREIGN KEY (`id_inmueble`) REFERENCES `Inmueble` (`id_inmueble`),
  CONSTRAINT `Contrato_ibfk_3` FOREIGN KEY (`id_agente`) REFERENCES `Agente` (`id_agente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contrato`
--

LOCK TABLES `Contrato` WRITE;
/*!40000 ALTER TABLE `Contrato` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Contrato` VALUES
(1,'alquiler','2025-01-01','2025-12-31','activo',2,2,1,5.00,'cuotas'),
(2,'venta','2024-05-01','2024-06-15','cancelado',3,3,2,3.00,'contado');
/*!40000 ALTER TABLE `Contrato` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Inmueble`
--

DROP TABLE IF EXISTS `Inmueble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Inmueble` (
  `id_inmueble` int NOT NULL AUTO_INCREMENT,
  `direccion` varchar(200) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `precio` decimal(12,2) DEFAULT NULL,
  `caracteristicas` text,
  `estado` enum('disponible','alquilado','vendido') DEFAULT NULL,
  `id_propietario` int DEFAULT NULL,
  PRIMARY KEY (`id_inmueble`),
  KEY `id_propietario` (`id_propietario`),
  CONSTRAINT `Inmueble_ibfk_1` FOREIGN KEY (`id_propietario`) REFERENCES `Cliente` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Inmueble`
--

LOCK TABLES `Inmueble` WRITE;
/*!40000 ALTER TABLE `Inmueble` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Inmueble` VALUES
(1,'Av. Blanco Galindo #123','Cochabamba','Departamento',80000.00,'3 dormitorios, 2 baños, cocina equipada','disponible',1),
(2,'Calle Sucre #456','La Paz','Casa',120000.00,'4 dormitorios, patio, garaje','alquilado',4),
(3,'Av. Banzer #789','Santa Cruz','Local Comercial',150000.00,'200 m2, vidrieras grandes','vendido',1);
/*!40000 ALTER TABLE `Inmueble` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Pago`
--

DROP TABLE IF EXISTS `Pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pago` (
  `id_pago` int NOT NULL AUTO_INCREMENT,
  `id_contrato` int DEFAULT NULL,
  `fecha_pago` date DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `tipo_pago` enum('alquiler','venta','servicio') DEFAULT NULL,
  `estado` enum('pendiente','pagado') DEFAULT NULL,
  PRIMARY KEY (`id_pago`),
  KEY `id_contrato` (`id_contrato`),
  CONSTRAINT `Pago_ibfk_1` FOREIGN KEY (`id_contrato`) REFERENCES `Contrato` (`id_contrato`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pago`
--

LOCK TABLES `Pago` WRITE;
/*!40000 ALTER TABLE `Pago` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Pago` VALUES
(1,1,'2025-02-01',500.00,'alquiler','pagado'),
(2,1,'2025-03-01',500.00,'alquiler','pendiente'),
(3,2,'2024-05-10',150000.00,'venta','pagado');
/*!40000 ALTER TABLE `Pago` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Visita`
--

DROP TABLE IF EXISTS `Visita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Visita` (
  `id_visita` int NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `id_inmueble` int DEFAULT NULL,
  `id_cliente` int DEFAULT NULL,
  `id_agente` int DEFAULT NULL,
  `comentarios` text,
  PRIMARY KEY (`id_visita`),
  KEY `id_inmueble` (`id_inmueble`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_agente` (`id_agente`),
  CONSTRAINT `Visita_ibfk_1` FOREIGN KEY (`id_inmueble`) REFERENCES `Inmueble` (`id_inmueble`),
  CONSTRAINT `Visita_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `Cliente` (`id_cliente`),
  CONSTRAINT `Visita_ibfk_3` FOREIGN KEY (`id_agente`) REFERENCES `Agente` (`id_agente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Visita`
--

LOCK TABLES `Visita` WRITE;
/*!40000 ALTER TABLE `Visita` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Visita` VALUES
(1,'2025-01-10','10:00:00',1,3,1,'Cliente interesado en conocer más detalles'),
(2,'2025-01-15','15:30:00',1,5,2,'Cliente solicitó planos del departamento');
/*!40000 ALTER TABLE `Visita` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'Vivienda'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReporteComisiones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `ReporteComisiones`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReporteContratos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `ReporteContratos`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReporteIngresosMensuales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `ReporteIngresosMensuales`(IN mes INT, IN anio INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReportePagosPendientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `ReportePagosPendientes`(IN mes INT, IN anio INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReporteVisitas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `ReporteVisitas`()
BEGIN
  SELECT
    I.direccion AS inmueble,
    COUNT(V.id_visita) AS cantidad_visitas
  FROM Visita V
  JOIN Inmueble I ON V.id_inmueble = I.id_inmueble
  GROUP BY V.id_inmueble
  ORDER BY cantidad_visitas DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-06-30  0:52:37
