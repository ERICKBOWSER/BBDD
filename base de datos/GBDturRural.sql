CREATE DATABASE  IF NOT EXISTS `GBDturRural2015` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `GBDturRural2015`;
-- MySQL dump 10.13  Distrib 5.5.35, for debian-linux-gnu (i686)
--
-- Host: 127.0.0.1    Database: GBDturRural2014
-- ------------------------------------------------------
-- Server version	5.5.35-0ubuntu0.12.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `propietarios`
--

DROP TABLE IF EXISTS `propietarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `propietarios` (
  `codpropietario` int(11) NOT NULL DEFAULT '0',
  `nompropietario` varchar(100) DEFAULT NULL,
  `personacontacto` varchar(100) DEFAULT NULL,
  `dni_cif` char(12) DEFAULT NULL,
  `tlf_contacto` char(13) DEFAULT NULL,
  `correoelectronico` varchar(60) DEFAULT NULL,
  `codtipopropi` int(11) DEFAULT NULL,
  PRIMARY KEY (`codpropietario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propietarios`
--

LOCK TABLES `propietarios` WRITE;
/*!40000 ALTER TABLE `propietarios` DISABLE KEYS */;
INSERT INTO `propietarios` VALUES (1,'Mª Flores Sánchez',NULL,'19087678q','678000000','mariaflores@gmail.com',NULL),(2,'Juan Sánchez Núñez',NULL,'00000123A','666000000','juanito@hotmail.com',NULL),(3,'Inmobiliaria Campo y Sol','Marina Tortosa','DX123456AB','609010203','marina@campoysol.com',NULL),(4,'Sofía López Gómez',NULL,'11111111L','607908070','sofilopez@hotmail.com',NULL);
/*!40000 ALTER TABLE `propietarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zonas`
--

DROP TABLE IF EXISTS `zonas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zonas` (
  `numzona` int(11) NOT NULL DEFAULT '0',
  `nomzona` varchar(20) DEFAULT NULL,
  `deszona` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`numzona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zonas`
--

LOCK TABLES `zonas` WRITE;
/*!40000 ALTER TABLE `zonas` DISABLE KEYS */;
INSERT INTO `zonas` VALUES (1,'Serranía Ronda',NULL),(2,'Valle del Genal',NULL),(3,'Axarquía',NULL),(4,'Sierra Grazalema',NULL),(5,'Los Alcornocales',NULL),(6,'Sierra de las Nieves',NULL),(7,'La Alpujarra',NULL),(8,'Sierra de Cazorla, S',NULL);
/*!40000 ALTER TABLE `zonas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `casas`
--

DROP TABLE IF EXISTS `casas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `casas` (
  `codcasa` int(11) NOT NULL DEFAULT '0',
  `nomcasa` varchar(20) DEFAULT NULL,
  `numbanios` tinyint(4) DEFAULT NULL,
  `numhabit` tinyint(4) DEFAULT NULL,
  `m2` int(11) DEFAULT NULL,
  `minpersonas` tinyint(4) DEFAULT NULL,
  `maxpersonas` tinyint(4) DEFAULT NULL,
  `preciobase` decimal(10,2) DEFAULT NULL,
  `codpropi` int(11) DEFAULT NULL,
  `codtipocasa` int(11) DEFAULT NULL,
  `codzona` int(11) DEFAULT NULL,
  `dirpostal` varchar(100) DEFAULT NULL,
  `poblacion` varchar(20) DEFAULT NULL,
  `provincia` varchar(20) DEFAULT NULL,
  `codpostal` char(5) DEFAULT NULL,
  PRIMARY KEY (`codcasa`),
  KEY `fk_casas_tiposcasa` (`codtipocasa`),
  KEY `fk_casas_propietarios` (`codpropi`),
  KEY `fk_casas_zonas` (`codzona`),
  CONSTRAINT `fk_casas_propietarios` FOREIGN KEY (`codpropi`) REFERENCES `propietarios` (`codpropietario`),
  CONSTRAINT `fk_casas_tiposcasa` FOREIGN KEY (`codtipocasa`) REFERENCES `tiposcasa` (`numtipo`),
  CONSTRAINT `fk_casas_zonas` FOREIGN KEY (`codzona`) REFERENCES `zonas` (`numzona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casas`
--

LOCK TABLES `casas` WRITE;
/*!40000 ALTER TABLE `casas` DISABLE KEYS */;
INSERT INTO `casas` VALUES (1,'Jazmín',2,4,120,4,8,50.00,1,1,1,'','','',''),(2,'Azucena',3,4,200,4,10,40.00,1,1,1,'','','',''),(3,'Jardines del campo',1,2,120,3,6,40.00,2,2,3,'','','',''),(4,'La casona del Valle',2,5,250,4,12,50.00,2,1,2,'','','',''),(5,'La casona del Pinar',2,5,250,4,12,50.00,2,1,2,'','','','');
/*!40000 ALTER TABLE `casas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiposcasa`
--

DROP TABLE IF EXISTS `tiposcasa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tiposcasa` (
  `numtipo` int(11) NOT NULL DEFAULT '0',
  `nomtipo` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`numtipo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiposcasa`
--

LOCK TABLES `tiposcasa` WRITE;
/*!40000 ALTER TABLE `tiposcasa` DISABLE KEYS */;
INSERT INTO `tiposcasa` VALUES (1,'Apartament'),(2,'Apartament'),(3,'Casa - Cas'),(4,'Casa - Cam');
/*!40000 ALTER TABLE `tiposcasa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devoluciones`
--

DROP TABLE IF EXISTS `devoluciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devoluciones` (
  `numdevol` int(11) NOT NULL DEFAULT '0',
  `codreserva` int(11) DEFAULT NULL,
  `importedevol` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`numdevol`),
  KEY `fk_devoluciones_reservas` (`codreserva`),
  CONSTRAINT `fk_devoluciones_reservas` FOREIGN KEY (`codreserva`) REFERENCES `reservas` (`codreserva`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devoluciones`
--

LOCK TABLES `devoluciones` WRITE;
/*!40000 ALTER TABLE `devoluciones` DISABLE KEYS */;
INSERT INTO `devoluciones` VALUES (1,1,120.00);
/*!40000 ALTER TABLE `devoluciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservas`
--

DROP TABLE IF EXISTS `reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservas` (
  `codreserva` int(11) NOT NULL DEFAULT '0',
  `codcliente` int(11) DEFAULT NULL,
  `codcasa` int(11) DEFAULT NULL,
  `fecreserva` date DEFAULT NULL,
  `pagocuenta` decimal(10,2) DEFAULT NULL,
  `feciniestancia` date DEFAULT NULL,
  `numdiasestancia` tinyint(4) DEFAULT NULL,
  `fecanulacion` date DEFAULT NULL,
  `observaciones` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`codreserva`),
  KEY `fk_reservas_casas` (`codcasa`),
  KEY `fk_reservas_clientes` (`codcliente`),
  CONSTRAINT `fk_reservas_casas` FOREIGN KEY (`codcasa`) REFERENCES `casas` (`codcasa`),
  CONSTRAINT `fk_reservas_clientes` FOREIGN KEY (`codcliente`) REFERENCES `clientes` (`codcli`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservas`
--

LOCK TABLES `reservas` WRITE;
/*!40000 ALTER TABLE `reservas` DISABLE KEYS */;
INSERT INTO `reservas` VALUES (1,1,1,'2012-01-20',120.00,'2012-03-20',4,'2012-03-01','nueva observacion; se ha procedido a la devolucion de la cantidad entregada a cuenta'),(2,2,1,'2012-04-02',120.00,'2012-04-30',4,'2012-04-20','; No se ha deuelto la cantidad entregada a cuenta por la fecha de anulación'),(3,1,2,'2013-01-20',130.00,'2013-03-19',5,NULL,NULL),(4,1,1,'2013-01-20',NULL,'2012-03-20',4,'2013-02-06',NULL),(5,2,1,'2012-04-02',NULL,'2012-04-30',4,'2013-02-06',NULL),(6,1,2,'2013-01-20',NULL,'2013-03-19',5,'2013-02-06',NULL);
/*!40000 ALTER TABLE `reservas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `codcli` int(11) NOT NULL DEFAULT '0',
  `nomcli` varchar(20) DEFAULT NULL,
  `ape1cli` varchar(20) DEFAULT NULL,
  `ape2cli` varchar(20) DEFAULT NULL,
  `dnicli` char(9) DEFAULT NULL,
  `tlf_contacto` char(13) DEFAULT NULL,
  `correoelectronico` varchar(60) DEFAULT NULL,
  `dircli` varchar(100) DEFAULT NULL,
  `pobcli` varchar(15) DEFAULT NULL,
  `provcli` varchar(15) DEFAULT NULL,
  `codpostalcli` char(5) DEFAULT NULL,
  PRIMARY KEY (`codcli`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Ángeles','Ruiz','Nieto','19087678q','678000000','angelesruiz@gmail.com',NULL,'Estepona','Málaga','29680'),(2,'Juan','Toro','Toro','00000123A','666000000','juanito99@hotmail.com','C/ Vigia nº 10','Marbella','Málaga','29600'),(3,'Ángeles','Ruiz','Nieto','19087678q','678000000','angelesruiz@gmail.com',NULL,'Estepona','Málaga','29680');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caracteristicas`
--

DROP TABLE IF EXISTS `caracteristicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caracteristicas` (
  `numcaracter` int(11) NOT NULL DEFAULT '0',
  `nomcaracter` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`numcaracter`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caracteristicas`
--

LOCK TABLES `caracteristicas` WRITE;
/*!40000 ALTER TABLE `caracteristicas` DISABLE KEYS */;
INSERT INTO `caracteristicas` VALUES (1,'Piscina privada'),(2,'Piscina comunitaria'),(3,'Barbacoa'),(4,'Aparcamiento privado'),(5,'Aparcamiento comunitario'),(6,'Chimenea'),(7,'Calefacción'),(8,'A/A'),(9,'Jardín privado');
/*!40000 ALTER TABLE `caracteristicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipospropietario`
--

DROP TABLE IF EXISTS `tipospropietario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipospropietario` (
  `codtipopropi` int(11) NOT NULL DEFAULT '0',
  `nomtipopropi` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codtipopropi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipospropietario`
--

LOCK TABLES `tipospropietario` WRITE;
/*!40000 ALTER TABLE `tipospropietario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipospropietario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caracteristicasdecasas`
--

DROP TABLE IF EXISTS `caracteristicasdecasas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caracteristicasdecasas` (
  `codcasa` int(11) NOT NULL DEFAULT '0',
  `codcaracter` int(11) NOT NULL DEFAULT '0',
  `tiene` bit(1) DEFAULT NULL,
  `observaciones` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`codcasa`,`codcaracter`),
  KEY `fk_caracteristicasdecasas_caracteristicas` (`codcaracter`),
  KEY `prueba` (`tiene`),
  CONSTRAINT `fk_caracteristicasdecasas_caracteristicas` FOREIGN KEY (`codcaracter`) REFERENCES `caracteristicas` (`numcaracter`),
  CONSTRAINT `fk_caracteristicasdecasas_casas` FOREIGN KEY (`codcasa`) REFERENCES `casas` (`codcasa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caracteristicasdecasas`
--

LOCK TABLES `caracteristicasdecasas` WRITE;
/*!40000 ALTER TABLE `caracteristicasdecasas` DISABLE KEYS */;
/*!40000 ALTER TABLE `caracteristicasdecasas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-05-06  1:01:18
