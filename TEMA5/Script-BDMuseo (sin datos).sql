CREATE DATABASE  IF NOT EXISTS `BDMUSEO` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `BDMUSEO`;
-- MySQL dump 10.13  Distrib 5.5.46, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: BDMUSEO
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.14.04.2

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
-- Table structure for table `artistas`
--

DROP TABLE IF EXISTS `artistas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artistas` (
  `codartista` int(11) NOT NULL DEFAULT '0',
  `nomartista` varchar(60) DEFAULT NULL,
  `biografia` text,
  `edad` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`codartista`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados` (
  `codemple` int(11) NOT NULL DEFAULT '0',
  `nomemle` varchar(20) DEFAULT NULL,
  `ape1emple` varchar(20) DEFAULT NULL,
  `ape2emple` varchar(20) DEFAULT NULL,
  `fecincorp` date DEFAULT NULL,
  `numsegsoc` char(15) DEFAULT NULL,
  PRIMARY KEY (`codemple`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estilos`
--

DROP TABLE IF EXISTS `estilos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estilos` (
  `codestilo` int(11) NOT NULL DEFAULT '0',
  `nomestilo` varchar(20) DEFAULT NULL,
  `desestilo` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`codestilo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `obras`
--

DROP TABLE IF EXISTS `obras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obras` (
  `codobra` int(11) NOT NULL DEFAULT '0',
  `nomobra` varchar(20) DEFAULT NULL,
  `desobra` varchar(100) DEFAULT NULL,
  `feccreacion` date DEFAULT NULL,
  `fecadquisicion` date DEFAULT NULL,
  `valoracion` decimal(12,2) DEFAULT NULL,
  `codestilo` int(11) DEFAULT NULL,
  `codtipobra` int(11) DEFAULT NULL,
  `codubicacion` int(11) DEFAULT NULL,
  `codartista` int(11) DEFAULT NULL,
  PRIMARY KEY (`codobra`),
  KEY `fk_obras_tipobras` (`codtipobra`),
  KEY `fk_obras_estilos` (`codestilo`),
  KEY `fk_obras_salas` (`codubicacion`),
  KEY `fk_obras_artistas` (`codartista`),
  CONSTRAINT `fk_obras_artistas` FOREIGN KEY (`codartista`) REFERENCES `artistas` (`codartista`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_obras_estilos` FOREIGN KEY (`codestilo`) REFERENCES `estilos` (`codestilo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_obras_salas` FOREIGN KEY (`codubicacion`) REFERENCES `salas` (`codsala`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_obras_tipobras` FOREIGN KEY (`codtipobra`) REFERENCES `tipobras` (`codtipobra`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restauraciones`
--

DROP TABLE IF EXISTS `restauraciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restauraciones` (
  `codrestaurador` int(11) NOT NULL DEFAULT '0',
  `codobra` int(11) NOT NULL DEFAULT '0',
  `fecinirestauracion` date NOT NULL DEFAULT '0000-00-00',
  `fecfinrestauracion` date DEFAULT NULL,
  `observaciones` text,
  PRIMARY KEY (`codrestaurador`,`codobra`,`fecinirestauracion`),
  KEY `fk_restauraciones_obras` (`codobra`),
  CONSTRAINT `fk_restauraciones_obras` FOREIGN KEY (`codobra`) REFERENCES `obras` (`codobra`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_restauraciones_restauradores` FOREIGN KEY (`codrestaurador`) REFERENCES `restauradores` (`codrestaurador`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restauradores`
--

DROP TABLE IF EXISTS `restauradores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restauradores` (
  `codrestaurador` int(11) NOT NULL DEFAULT '0',
  `codemple` int(11) DEFAULT NULL,
  `especialidad` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`codrestaurador`),
  KEY `fk_restauradores_empleados` (`codemple`),
  CONSTRAINT `fk_restauradores_empleados` FOREIGN KEY (`codemple`) REFERENCES `empleados` (`codemple`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salas`
--

DROP TABLE IF EXISTS `salas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salas` (
  `codsala` int(11) NOT NULL DEFAULT '0',
  `nomsala` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codsala`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seguridad`
--

DROP TABLE IF EXISTS `seguridad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seguridad` (
  `codsegur` int(11) NOT NULL DEFAULT '0',
  `codemple` int(11) DEFAULT NULL,
  `codsala` int(11) DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`codsegur`),
  KEY `fk_seguridad_empleados` (`codemple`),
  KEY `fk_seguridad_salas` (`codsala`),
  CONSTRAINT `fk_seguridad_empleados` FOREIGN KEY (`codemple`) REFERENCES `empleados` (`codemple`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_seguridad_salas` FOREIGN KEY (`codsala`) REFERENCES `salas` (`codsala`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipobras`
--

DROP TABLE IF EXISTS `tipobras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipobras` (
  `codtipobra` int(11) NOT NULL DEFAULT '0',
  `destipobra` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codtipobra`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'BDMUSEO'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-15  9:47:24
