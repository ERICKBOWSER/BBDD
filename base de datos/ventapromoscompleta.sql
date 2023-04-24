

DROP DATABASE  IF EXISTS `ventapromoscompleta`;

CREATE DATABASE  IF NOT EXISTS `ventapromoscompleta`;
USE `ventapromoscompleta`;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias` (
  `codcat` int NOT NULL,
  `nomcat` varchar(100) DEFAULT NULL,
  `descat` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`codcat`)
) ENGINE=InnoDB ;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'ASEO PERSONAL','ASEO PERSONAL'),(2,'PRODUCTOS SOLARES','PRODUCTOS SOLARES'),(3,'MAQUILLAJES','MAQUILLAJES'),(4,'COSMÉTICA NATURAL','COSMÉTICA NATURAL'),(5,'CREMAS','CREMAS'),(6,'COLONIAS Y PERFUMES','COLONIAS Y PERFUMES'),(11,'ASEO PERSONAL AHORRO-FAMILY','ASEO PERSONAL AHORRO-FAMILY'),(12,'PRODUCTOS SOLARES AHORRO-FAMILY','PRODUCTOS SOLARES AHORRO-FAMILY'),(13,'MAQUILLAJES AHORRO-FAMILY','MAQUILLAJES AHORRO-FAMILY'),(14,'COSMÉTICA NATURAL AHORRO-FAMILY','COSMÉTICA NATURAL AHORRO-FAMILY'),(15,'CREMAS AHORRO-FAMILY','CREMAS AHORRO-FAMILY'),(16,'COLONIAS Y PERFUMES AHORRO-FAMILY','COLONIAS Y PERFUMES AHORRO-FAMILY');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS `articulos`;

CREATE TABLE `articulos` (
  `refart` char(12) NOT NULL,
  `nomart` varchar(50) DEFAULT NULL,
  `desart` varchar(120) DEFAULT NULL,
  `preciobase` decimal(5,2) DEFAULT NULL,
  `precioventa` decimal(5,2) DEFAULT NULL,
  `codcat` int DEFAULT NULL,
  `stock` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`refart`),
  KEY `fk_articulos_categorias` (`codcat`),
  CONSTRAINT `fk_articulos_categorias` FOREIGN KEY (`codcat`) REFERENCES `categorias` (`codcat`)
);


INSERT INTO `articulos` VALUES ('C1_01','Gel de Baño Fragancias del Mediterráneo','',1.50,3.95,1,7),('C1_02','Champú Rayos de sol','',2.00,4.95,1,10),('C1_03','Gel de Baño Fragancias del Adriático','',1.50,3.95,1,7),('C1_04','Gel de Baño Fragancias del Caribe','',1.50,3.95,1,10),('C2_01','Crema solar con aloe vera prot 10','',3.50,6.95,2,3),('C2_02','Crema solar con aloe vera prot 20','',4.50,7.95,2,10),('C2_03','Crema solar con aloe vera alta protección','',5.50,8.95,2,7),('C2_04','Crema solar con aloe vera especial niños','',5.50,8.95,2,10),('C2_05','Crema solar con aloe vera especial cara y cuello','',12.50,-22.00,2,7),('C2_06','AfterSun con aloe vera','',3.50,6.95,2,10),('C6_01','Agua de primavera','',7.90,12.95,6,7),('C6_02','Agua de verano','',8.90,13.95,6,10),('C6_03','Agua de otoño','',7.90,12.95,6,7),('C6_04','Agua de invierno','',8.90,13.95,6,10);

DROP TABLE IF EXISTS `catalogoprecios`;
/*!50001 DROP VIEW IF EXISTS `catalogoprecios`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50001 CREATE VIEW `catalogoprecios` AS SELECT 
 1 AS `refProducto`,
 1 AS `descripProducto`,
 1 AS `precioactualProducto`,
 1 AS `codcat`*/;
SET character_set_client = @saved_cs_client;


DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
CREATE TABLE `clientes` (
  `codcli` int NOT NULL,
  `nomcli` varchar(20) DEFAULT NULL,
  `ape1cli` varchar(20) DEFAULT NULL,
  `ape2cli` varchar(20) DEFAULT NULL,
  `tlfcli` char(9) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `dircli` varchar(150) DEFAULT NULL,
  `codposcli` char(5) DEFAULT NULL,
  `fecnaccli` date DEFAULT NULL,
  `fecincorpo` date DEFAULT NULL,
  `ptosacumulados` int DEFAULT NULL,
  `ptoscanjeados` int DEFAULT NULL,
  PRIMARY KEY (`codcli`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Loreta','Zapata',NULL,'911 703 9','LoretaZapataOzuna@trashymail.c','C/ Eras 18 Pedrezuela','28723','2002-01-01','2013-01-01',10,10),(2,'Teodequilda','Godoy',NULL,'955 510 9','TeodequildaGodoyBahena@dodgit.','Eusebio Dávila 82 La Campana','41429','2001-08-09','2013-01-01',10,10),(3,'Danel','Jimínez',NULL,'877 886 7','DanelJiminezSisneros@pookmail.','Outid de Arriba 7 Alcanar','43530','2000-11-19','2013-01-01',10,10),(4,'Eliezer','Arroyo',NULL,'981 329 5','EliezerArroyoPedraza@pookmail.','Quevedo 1 Cariño','15360','2003-09-04','2013-01-01',10,10),(5,'Clelia','Gurule',NULL,'911 626 2','CleliaGuruleBenitez@mailinator','C/ Amoladera 95 Ajalvir','28864','2001-10-05','2013-01-01',10,10),(6,'Longinos','Nazario',NULL,'923 684 6','LonginosNazarioAcevedo@mailina','Enxertos 49 La Atalaya','37591','1950-01-01','2013-01-01',10,10),(7,'Débora','Carranza',NULL,'911 956 5','DeboraCarranzaOrdonez@mailinat','Avda. de la Estación 80 Chapinería','28694','1956-01-01','2013-01-01',10,10),(8,'Florida','Candelaria',NULL,'920 308 2','FloridaCandelariaOcasio@mailin','C/ Libertad 80 El Barraco','05110','1956-01-01','2013-01-01',10,10),(9,'Elisea','Pabón',NULL,'984 208 4','EliseaPabonAngulo@dodgit.com','Ctra. Villena 11 San Martín del Rey Aurelio','33950','1956-01-01','2013-01-01',10,10),(10,'Michele','Acosta',NULL,'971 452 1','MicheleAcostaLuevano@dodgit.co','Zumalakarregi etorbidea 83 Calvià','07184','2002-02-21','2013-01-01',10,10),(11,'Sofiel','Centeno',NULL,'710 745 1','SofielCentenoApodaca@trashymai','Avendaño 72 Níjar','04100','2002-04-21','2013-01-01',10,10),(12,'Abbot','Valadez',NULL,'967 914 8','AbbotValadezCenteno@spambob.co','C/ Domingo Beltrán 62 Mahora','02240','2001-11-30','2013-01-01',10,10),(13,'Myrna','Ibarra',NULL,'886 479 2','MyrnaIbarraRodriguez@mailinato','Atamaria 37 Pontecesures','36640','2000-02-05','2013-01-01',10,10),(14,'Hilario','Alonso',NULL,'928 949 3','HilarioAlonsoTijerina@pookmail','Avda. Explanada Barnuevo 23 Artenara','35350','2000-12-20','2013-01-01',10,10),(15,'Elsira','Gaytan',NULL,'881 364 7','ElsiraGaytanVillagomez@pookmai','El Roqueo 41 Ribeira','15960','2003-02-20','2013-01-01',10,10),(16,'Nacho','Batista',NULL,'643 260 1','NachoBatistaFranco@spambob.com','Cartagena 6 Cehegín','30430','1999-12-03','2013-01-01',10,10),(17,'Evarista','Torres',NULL,'687 956 1','EvaristaTorresSalazar@mailinat','Avda. Andalucía 96 Rabanera','26133','1999-06-04','2013-01-01',10,10),(18,'Domiciano','Ballesteros',NULL,'785 112 5','DomicianoBallesterosUribe@dodg','Plaza Colón 81 Astorga','24700','2001-10-17','2013-01-01',10,10),(19,'Arquímedes','Muñiz',NULL,'915 232 8','ArquimedesMunizCordova@trashym','C/ Eras 53 Lozoya','28742','2001-09-17','2013-01-01',10,10),(20,'Eira','Salcido',NULL,'953 001 8','EiraSalcidoTirado@trashymail.c','Ctra. Bailén-Motril 66 Santa Elena','23213','2001-08-15','2013-01-01',10,10),(21,'Carmine','Mata',NULL,'941 573 4','CarmineMataCarrera@trashymail.','Ctra. Hornos 33 Ochánduri','26213','2002-07-01','2013-01-01',10,10),(22,'Patsy','Cordova',NULL,'983 328 9','PatsyCordovaLebron@trashymail.','Calvo Sotelo 85 Tudela de Duero','47320','2002-06-14','2013-01-01',10,10),(23,'Madeleine','Merino',NULL,'932 032 3','MadeleineMerinoPosada@mailinat','Cercas Bajas 89 Lliçà d\'Amunt','08186','2002-06-14','2013-01-01',10,10),(24,'Hilen','Anaya',NULL,'637 192 0','HilenAnayaEnriquez@mailinator.','Cartagena 54 Ulea','30612','2001-06-21','2013-01-01',10,10),(25,'Gian','Gastelum',NULL,'964 171 8','GianGastelumBarrientos@pookmai','Paseo Junquera 33 Caudiel','12440','2001-06-29','2013-01-01',10,10),(26,'Fuencista','Becerra',NULL,'937 478 8','FuencistaBecerraAlvarez@pookma','C/ Benito Guinea 35 Premià de Mar','08330','1998-06-29','2013-01-01',10,10),(27,'Georges','Matos',NULL,'665 977 4','GeorgesMatosNevarez@trashymail','C/ Canarias 96 Hernani','20120','2003-12-18','2013-01-01',10,10),(28,'Midas','Saenz',NULL,'822 724 1','MidasSaenzEspinal@spambob.com','Antonio Vázquez 19 Fuencaliente de la Palma','38740','2001-01-15','2013-01-01',10,10),(29,'Ray','Villareal',NULL,'789 149 9','RayVillarealColunga@mailinator','Cruce Casa de Postas 36 Pampaneira','18411','2002-11-15','2013-01-01',10,10),(30,'Joseph','Haro',NULL,'716 392 8','JosephHaroPrado@pookmail.com','C/ Rosa de los Vientos 87 Arcos de la Frontera','11630','2000-11-19','2013-01-01',10,10),(31,'Alejandrino','Romero',NULL,'925 152 9','AlejandrinoRomeroMadrid@mailin','Reiseñor 97 Quintanar de la Orden','45800','2000-02-21','2013-01-01',10,10),(32,'Lain','Alaniz',NULL,'917 441 9','LainAlanizJasso@trashymail.com','C/ Henan Cortes 85 Alcorcón','28920','1985-04-01','2013-01-01',10,10),(33,'Jessica','Rojo',NULL,'981 095 4','JessicaRojoNava@mailinator.com','El Roqueo 54 Vedra','15885','2001-04-15','2013-01-01',10,10),(34,'Minotauro','Hinojosa',NULL,'959 586 3','MinotauroHinojosaMojica@dodgit','Prolongacion San Sebastian 62 Linares de la Sierra','21341','2001-04-17','2013-01-01',10,10),(35,'Ahmed','Zaragoza',NULL,'974 901 4','AhmedZaragozaVera@trashymail.c','Cañadilla 46 Aínsa-Sobrarbe','22330','2001-04-17','2013-01-01',10,10),(36,'Cupido','Sotelo',NULL,'628 406 3','CupidoSoteloRodrigez@mailinato','C/ Los Herrán 91 Villafranca de los Barros','06220','2001-09-13','2013-01-01',10,10),(37,'Grau','Nino',NULL,'858 206 6','GrauNinoRubio@pookmail.com','Paseo del Atlántico 46 Arenas del Rey','18126','2001-05-18','2013-01-01',10,10),(38,'Chiara','Leyva',NULL,'958 466 1','ChiaraLeyvaRojo@spambob.com','Paseo del Atlántico 92 Píñar','18127','2001-08-18','2013-01-01',10,10),(39,'Neptuno','Gamboa',NULL,'957 024 6','NeptunoGamboaPorras@dodgit.com','La Fontanilla 35 Villanueva de Córdoba','14440','2003-07-11','2013-01-01',10,10),(40,'Adassa','Porras',NULL,'868 006 4','AdassaPorrasApodaca@dodgit.com','Cartagena 3 Ojós','30611','2003-09-22','2013-01-01',10,10),(41,'Arydea','Segura',NULL,'941 042 5','ArydeaSeguraZavala@dodgit.com','Ctra. de la Puerta 42 Bergasa','26588','2003-01-22','2013-01-01',10,10),(42,'Daila','Mena',NULL,'958 000 3','DailaMenaTafoya@trashymail.com','Cádiz 87 Ferreira','18513','2003-01-12','2013-01-01',10,10),(43,'Igone','Gutiérrez',NULL,'923 105 2','IgoneGutierrezHernadez@pookmai','Socampo 1 Sepulcro-Hilario','37638','2001-03-12','2013-01-01',10,10),(44,'Clotilde','Ulibarri',NULL,'913 015 9','ClotildeUlibarriVelasco@mailin','Ventanilla de Beas 56 Madrid','28000','2001-04-18','2013-01-01',10,10),(45,'Lara','Varela',NULL,'691 127 3','LaraVarelaSoria@pookmail.com','Cartagena 97 Caravaca de la Cruz','30400','2001-04-30','2013-01-01',10,10),(46,'Dalma','Abrego',NULL,'868 570 4','DalmaAbregoSaldana@pookmail.co','Alcon Molina 8 Mazarrón','30870','1998-04-10','2013-01-01',10,10),(47,'Prudencio','Haro',NULL,'663 979 0','PrudencioHaroSanabria@mailinat','Rúa de San Pedro 42 Berrocal de Salvatierra','37795','2002-08-10','2013-01-01',10,10),(48,'Yair','Reyna',NULL,'693 941 4','YairReynaHinojosa@mailinator.c','Prolongacion San Sebastian 87 El Cerro de Andévalo','21320','2002-07-21','2013-01-01',10,10),(49,'Marién','Tejada',NULL,'923 579 4','MarienTejadaRangel@mailinator.','Rua da Rapina 91 Aldehuela de la Bóveda','37460','2002-10-30','2013-01-01',10,10),(50,'Amira','Cardona',NULL,'988 016 3','AmiraCardonaBarela@pookmail.co','Salzillo 91 A Mezquita','32549','2000-09-07','2013-01-01',10,10),(51,'Maggie','Benavidez',NULL,'913 712 3','MaggieBenavidezCenteno@pookmai','C/ Amoladera 20 Ribatejada','28815','2001-09-11','2013-01-01',10,10),(52,'Uberto','Mateo',NULL,'941 077 1','UbertoMateoUrias@pookmail.com','Plaza Colón 51 Albelda de Iregua','26120','2002-12-19','2013-01-01',10,10),(53,'Apia','Carrión',NULL,'968 843 6','ApiaCarrionRocha@pookmail.com','Alcon Molina 94 Los Alcázares','30710','1958-01-01','2013-01-01',10,10),(54,'Emillen','Oquendo',NULL,'971 142 3','EmillenOquendoPichardo@spambob','Zumalakarregi etorbidea 58 Bunyola','07110','1956-01-01','2013-01-01',10,10),(55,'Erico','Barrios',NULL,'601 095 1','EricoBarriosRael@pookmail.com','Bouciña 35 Amposta','43870','1989-01-01','2013-01-01',10,10);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
CREATE TABLE `pedidos` (
  `codpedido` int NOT NULL,
  `fecpedido` date NOT NULL,
  `fecentrega` date DEFAULT NULL,
  `refart` char(12) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`codpedido`),
  KEY `fk_pedidos_articulos` (`refart`),
  CONSTRAINT `fk_pedidos_articulos` FOREIGN KEY (`refart`) REFERENCES `articulos` (`refart`) ON UPDATE CASCADE
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,'2020-05-12',NULL,'C2_01',5);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
--
-- Table structure for table `catalogospromos`
--

-- Table structure for table `promociones`
--

DROP TABLE IF EXISTS `promociones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
CREATE TABLE `promociones` (
  `codpromo` int NOT NULL,
  `despromo` varchar(100) DEFAULT NULL,
  `fecinipromo` date DEFAULT NULL,
  `duracionpromo` int DEFAULT NULL,
  PRIMARY KEY (`codpromo`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promociones`
--

LOCK TABLES `promociones` WRITE;
/*!40000 ALTER TABLE `promociones` DISABLE KEYS */;
INSERT INTO `promociones` VALUES (1,'Primavera 2012','2012-03-21',90),(2,'Verano 2012','2012-06-23',90),(3,'Otoño 2012','2012-09-26',60),(4,'Navidad 2012','2012-12-01',25),(5,'Cuesta de enero 2013','2013-01-07',22),(6,'Invierno 2013','2013-02-01',45);
/*!40000 ALTER TABLE `promociones` ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS `catalogospromos`;
CREATE TABLE `catalogospromos` (
  `refart` char(12) NOT NULL,
  `codpromo` int NOT NULL,
  `precioartpromo` decimal(5,2) DEFAULT NULL,
  `ptosparacli` int DEFAULT NULL,
  PRIMARY KEY (`refart`,`codpromo`),
  KEY `fk_catalogospromo_promociones` (`codpromo`),
  CONSTRAINT `fk_catalogospromo_articulos` FOREIGN KEY (`refart`) REFERENCES `articulos` (`refart`),
  CONSTRAINT `fk_catalogospromo_promociones` FOREIGN KEY (`codpromo`) REFERENCES `promociones` (`codpromo`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogospromos`
--

LOCK TABLES `catalogospromos` WRITE;
/*!40000 ALTER TABLE `catalogospromos` DISABLE KEYS */;
INSERT INTO `catalogospromos` VALUES ('C1_01',1,2.50,1),('C1_02',1,4.00,1),('C1_03',1,3.35,1),('C1_03',6,3.35,1),('C1_04',1,3.30,1),('C1_04',6,3.30,1),('C2_02',2,5.50,1),('C2_04',2,8.00,1),('C2_06',2,5.00,1),('C6_01',1,10.95,1),('C6_02',2,11.50,2),('C6_04',6,11.50,2);
/*!40000 ALTER TABLE `catalogospromos` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `clientes`
--
DROP TABLE IF EXISTS `vendedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;

CREATE TABLE `vendedores` (
  `codvende` int NOT NULL,
  `nomvende` varchar(100) DEFAULT NULL,
  `fecincempresa` date DEFAULT NULL,
  PRIMARY KEY (`codvende`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedores`
--

LOCK TABLES `vendedores` WRITE;
/*!40000 ALTER TABLE `vendedores` DISABLE KEYS */;
INSERT INTO `vendedores` VALUES (1,'Pedro','2011-03-21'),(2,'María','2012-01-02'),(3,'Germán','2010-06-21'),(4,'Anaís','2009-09-01');
/*!40000 ALTER TABLE `vendedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
CREATE TABLE `ventas` (
  `codventa` int NOT NULL,
  `codcli` int DEFAULT NULL,
  `fecventa` date DEFAULT NULL,
  `codvende` int DEFAULT NULL,
  PRIMARY KEY (`codventa`),
  KEY `fk_ventas_clientes` (`codcli`),
  KEY `fk_ventas_vende` (`codvende`),
  CONSTRAINT `fk_ventas_clientes` FOREIGN KEY (`codcli`) REFERENCES `clientes` (`codcli`),
  CONSTRAINT `fk_ventas_vende` FOREIGN KEY (`codvende`) REFERENCES `vendedores` (`codvende`)
) ENGINE=InnoDB;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,1,'2012-05-04',1),(2,1,'2012-05-05',1),(3,5,'2012-05-06',2);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `detalleventa`
--

DROP TABLE IF EXISTS `detalleventa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
CREATE TABLE `detalleventa` (
  `codventa` int NOT NULL,
  `refart` char(12) NOT NULL,
  `cant` int DEFAULT NULL,
  `precioventa` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`codventa`,`refart`),
  KEY `fk_detalleVenta_articulos` (`refart`),
  CONSTRAINT `fk_detalleVenta_articulos` FOREIGN KEY (`refart`) REFERENCES `articulos` (`refart`),
  CONSTRAINT `fk_detalleVenta_ventas` FOREIGN KEY (`codventa`) REFERENCES `ventas` (`codventa`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalleventa`
--

LOCK TABLES `detalleventa` WRITE;
/*!40000 ALTER TABLE `detalleventa` DISABLE KEYS */;
INSERT INTO `detalleventa` VALUES (1,'C2_04',1,8.95),(1,'C6_01',1,10.95),(2,'C1_01',1,2.50),(2,'C1_02',1,4.00),(2,'C6_01',1,10.95),(3,'C1_03',1,3.35),(3,'C1_04',1,8.95),(3,'C6_02',1,13.95);
/*!40000 ALTER TABLE `detalleventa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--



--
-- Table structure for table `vendedores`
--


--
-- Final view structure for view `catalogoprecios`
--



-- Dump completed on 2020-05-12 21:55:17
