/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.11-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: db_fastbox
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB-0+deb12u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auditoria`
--

DROP TABLE IF EXISTS `auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria` (
  `id_auditoria` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `tabla_afectada` varchar(255) NOT NULL,
  `id_registro` int(11) NOT NULL,
  `accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `fecha_hora` timestamp NULL DEFAULT current_timestamp(),
  `descripcion` text DEFAULT NULL,
  PRIMARY KEY (`id_auditoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria`
--

LOCK TABLES `auditoria` WRITE;
/*!40000 ALTER TABLE `auditoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direccion`
--

DROP TABLE IF EXISTS `direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `direccion` (
  `id_direccion` int(11) NOT NULL AUTO_INCREMENT,
  `calle_principal` varchar(255) NOT NULL,
  `numero` varchar(50) DEFAULT NULL,
  `calle_secundaria` varchar(255) DEFAULT NULL,
  `zona` varchar(255) DEFAULT NULL,
  `colonia_o_barrio` varchar(255) DEFAULT NULL,
  `municipio` varchar(255) NOT NULL,
  `departamento` varchar(255) NOT NULL,
  `codigo_postal` varchar(50) DEFAULT NULL,
  `referencias` text DEFAULT NULL,
  PRIMARY KEY (`id_direccion`)
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direccion`
--

LOCK TABLES `direccion` WRITE;
/*!40000 ALTER TABLE `direccion` DISABLE KEYS */;
INSERT INTO `direccion` VALUES
(1,'Av. Central','123','Calle B','Zona 1','Colonia X','Guatemala','Guatemala','01001','Frente al parque'),
(2,'Calle Final','456',NULL,'Zona 10','Colonia Y','Mixco','Guatemala','01010','Junto a la escuela'),
(3,'1a Avenida','12','Calle B','3','Colonia Central','Ciudad de Guatemala','Guatemala','01001','Frente al parque'),
(4,'5a Avenida','45','Calle F','11','Colonia La Paz','Ciudad de Guatemala','Guatemala','01011','Cerca del mercado'),
(5,'1a Avenida','12','Calle B','3','Colonia Central','Ciudad de Guatemala','Guatemala','01001','Frente al parque'),
(6,'5a Avenida','45','Calle F','7','Colonia La Paz','Ciudad de Guatemala','Guatemala','01007','Cerca del mercado'),
(7,'2a Avenida','100','Calle C','5','Colonia Central','Mixco','Guatemala','01005','Frente a la iglesia'),
(8,'3a Avenida','50','Calle D','10','Colonia La Esperanza','Mixco','Guatemala','01010','Cerca de la plaza'),
(9,'2a Avenida','100','Calle C','5','Colonia Central','Mixco','Guatemala','01005','Frente a la iglesia'),
(10,'3a Avenida','50','Calle D','10','Colonia La Esperanza','Mixco','Guatemala','01010','Cerca de la plaza'),
(11,'6a Avenida','15','Calle Z','17','Colonia Central','Ciudad de Guatemala','Guatemala','01017','Frente a la estación'),
(12,'8a Avenida','80','Calle Y','19','Colonia San José','Ciudad de Guatemala','Guatemala','01019','Cerca del hospital'),
(13,'1a Avenida','12','Calle B','3','Colonia Central','Ciudad de Guatemala','Guatemala','01001','Frente al parque'),
(14,'5a Avenida','45','Calle F','11','Colonia La Paz','Ciudad de Guatemala','Guatemala','01011','Cerca del mercado'),
(15,'2a Avenida','100','Calle C','5','Colonia Central','Mixco','Guatemala','01005','Frente a la iglesia'),
(16,'3a Avenida','50','Calle D','10','Colonia La Esperanza','Mixco','Guatemala','01010','Cerca de la plaza'),
(17,'6a Avenida','15','Calle Z','17','Colonia Central','Ciudad de Guatemala','Guatemala','01017','Frente a la estación'),
(18,'8a Avenida','80','Calle Y','19','Colonia San José','Ciudad de Guatemala','Guatemala','01019','Cerca del hospital'),
(19,'4a Avenida','200','Calle X','2','Colonia Norte','Fraijanes','Guatemala','01020','Al lado del colegio'),
(20,'7a Avenida','90','Calle W','3','Colonia Central','San Jose Pinula','Guatemala','01025','Cerca de la plaza principal'),
(21,'9a Avenida','33','Calle V','6','Colonia Sur','Villa Nueva','Guatemala','01030','Frente al supermercado'),
(22,'10a Avenida','70','Calle U','10','Colonia Central','San Miguel Petapa','Guatemala','01035','Cerca de la estación de buses'),
(23,'1a Avenida','12','Calle B','3','Colonia Central','Ciudad de Guatemala','Guatemala','01001','Frente al parque'),
(24,'5a Avenida','45','Calle F','7','Colonia La Paz','Ciudad de Guatemala','Guatemala','01007','Cerca del mercado'),
(25,'1a Avenida','100','Calle X','5','Colonia Santa Elena','Mixco','Guatemala','01005','Frente al supermercado'),
(26,'4a Calle','200','Calle Y','10','Colonia La Paz','Villa Nueva','Guatemala','01015','Cerca de la plaza'),
(27,'8a Avenida','30','Calle Z','16','Colonia Centro','Ciudad de Guatemala','Guatemala','01016','Frente a la estación'),
(28,'9a Calle','75','Calle W','19','Colonia San José','Mixco','Guatemala','01019','Cerca del hospital'),
(29,'1a Avenida','12','Calle B','3','Colonia Central','Ciudad de Guatemala','Guatemala','01001','Frente al parque'),
(30,'5a Avenida','45','Calle F','11','Colonia La Paz','Ciudad de Guatemala','Guatemala','01011','Cerca del mercado'),
(31,'2a Avenida','100','Calle C','5','Colonia Central','Mixco','Guatemala','01005','Frente a la iglesia'),
(32,'3a Avenida','50','Calle D','10','Colonia La Esperanza','Mixco','Guatemala','01010','Cerca de la plaza'),
(33,'6a Avenida','15','Calle Z','17','Colonia Central','Ciudad de Guatemala','Guatemala','01017','Frente a la estación'),
(34,'8a Avenida','80','Calle Y','19','Colonia San José','Ciudad de Guatemala','Guatemala','01019','Cerca del hospital'),
(35,'10a Avenida','200','Calle E','7','Colonia Norte','Villa Nueva','Guatemala','01020','Frente a supermercado'),
(36,'12a Avenida','75','Calle F','11','Colonia Sur','San Miguel Petapa','Guatemala','01021','Cerca del centro'),
(37,'3a Avenida','30','Calle G','2','Colonia Central','Ciudad de Guatemala','Guatemala','01003','Frente al banco'),
(38,'7a Avenida','90','Calle H','15','Colonia Santa María','Ciudad de Guatemala','Guatemala','01015','Cerca del parque'),
(39,'1a Avenida','12','Calle B','3','Colonia Central','Ciudad de Guatemala','Guatemala','01001','Frente al parque'),
(40,'5a Avenida','45','Calle F','5','Colonia La Paz','Ciudad de Guatemala','Guatemala','01011','Cerca del mercado'),
(41,'2a Avenida','100','Calle C','10','Colonia Central','Mixco','Guatemala','01005','Frente a la iglesia'),
(42,'3a Avenida','50','Calle D','11','Colonia La Esperanza','Mixco','Guatemala','01010','Cerca de la plaza'),
(43,'10a Avenida','8','Calle X','18','Colonia Centro','Ciudad de Guatemala','Guatemala','01020','Frente al parque'),
(44,'12a Avenida','15','Calle Y','18','Colonia El Bosque','Ciudad de Guatemala','Guatemala','01022','Cerca de supermercado'),
(45,'Calle Central','1','Calle A','10','Colonia Centro','Fraijanes','Guatemala','01040','Frente a la iglesia'),
(46,'Calle Secundaria','5','Calle B','10','Colonia La Paz','Fraijanes','Guatemala','01041','Cerca del mercado'),
(47,'4a Avenida','50','Calle M','17','Colonia Centro','Ciudad de Guatemala','Guatemala','01015','Frente a parque'),
(48,'6a Avenida','80','Calle N','18','Colonia La Esperanza','Ciudad de Guatemala','Guatemala','01018','Cerca de centro comercial'),
(49,'1a Av','10','Calle A','3','Centro','Ciudad de Guatemala','Guatemala','01001','Frente al parque'),
(50,'5a Av','20','Calle B','3','Zona 3','Ciudad de Guatemala','Guatemala','01003','Cerca de la plaza'),
(51,'2a Av','12','Calle C','9','Centro','Ciudad de Guatemala','Guatemala','01005','Frente a iglesia'),
(52,'3a Av','15','Calle D','9','Zona 9','Ciudad de Guatemala','Guatemala','01007','Cerca del mercado'),
(53,'6a Av','15','Calle Z','5','Mixco','San Miguel Petapa','Guatemala','01017','Frente estación'),
(54,'8a Av','80','Calle Y','7','Mixco','Villa Nueva','Guatemala','01019','Cerca del hospital'),
(55,'6a Av','15','Calle Z','5','Mixco','San Miguel Petapa','Guatemala','01017','Frente estación'),
(56,'8a Av','80','Calle Y','7','Mixco','Villa Nueva','Guatemala','01019','Cerca del hospital'),
(57,'1a Av','5','Calle X','3','Centro','Fraijanes','Guatemala','01021','Frente a parque'),
(58,'2a Av','10','Calle Y','10','Centro','Fraijanes','Guatemala','01022','Cerca del mercado'),
(59,'3a Av','8','Calle A','3','Centro','San Jose Pinula','Guatemala','01025','Frente a iglesia'),
(60,'4a Av','12','Calle B','3','Zona B','San Jose Pinula','Guatemala','01026','Cerca de parque'),
(61,'5a Av','1','Calle D','15','Centro','Ciudad de Guatemala','Guatemala','01015','Frente banco'),
(62,'6a Av','3','Calle E','15','Zona 15','Ciudad de Guatemala','Guatemala','01016','Cerca del hospital'),
(63,'1a Av','12','Calle A','10','Centro','Villa Nueva','Guatemala','01010','Frente estación'),
(64,'2a Av','20','Calle B','17','Centro','Villa Nueva','Guatemala','01012','Cerca del parque'),
(65,'7a Av','5','Calle Z','20','CAES','Ciudad de Guatemala','Guatemala','01020','Frente escuela'),
(66,'8a Av','10','Calle Y','20','CAES','Ciudad de Guatemala','Guatemala','01021','Cerca hospital'),
(67,'1a Av','1','Calle X','3','Centro','Fraijanes','Guatemala','01025','Frente a parque'),
(68,'2a Av','10','Calle Y','3','Centro','San Jose Pinula','Guatemala','01026','Cerca del mercado'),
(69,'1a Av','1','Calle A','1','Centro','Ciudad de Guatemala','Guatemala','01001','Frente banco'),
(70,'2a Av','5','Calle B','1','Zona 1','Ciudad de Guatemala','Guatemala','01002','Cerca parque'),
(71,'1a Avenida','100','Calle B','1','Zona 1','Ciudad de Guatemala','Guatemala','01001','Frente a parque'),
(72,'2a Avenida','200','Calle C','5','Zona 5','Ciudad de Guatemala','Guatemala','01005','Cerca del supermercado'),
(73,'Avenida 7','50','Calle X','2','Zona 2','Ciudad de Guatemala','Guatemala','01002','Frente al banco'),
(74,'Calle 10','75','Calle Y','3','Zona 3','Ciudad de Guatemala','Guatemala','01003','Junto a la iglesia'),
(75,'Calle 1','10','Calle 2','7','Zona 7','Ciudad de Guatemala','Guatemala','01007','Frente al parque'),
(76,'Calle 5','20','Calle 6','8','Zona 8','Villa Nueva','Guatemala','01008','Cerca del centro comercial'),
(77,'Calle 3','30','Calle 4','9','Zona 9','Mixco','Guatemala','01009','Junto al colegio'),
(78,'Avenida 2','40','Calle 5','10','Zona 10','Mixco','Guatemala','01010','Frente al parque'),
(79,'Calle A','5','Calle B','1','Zona 1','San Miguel Petapa','Guatemala','01011','Frente al centro'),
(80,'Calle C','15','Calle D','2','Zona 2','San Miguel Petapa','Guatemala','01012','Junto a la iglesia'),
(81,'Calle X','12','Calle Y','4','Zona 4','Fraijanes','Guatemala','01013','Cerca del supermercado'),
(82,'Calle Z','18','Calle W','3','Zona 3','Fraijanes','Guatemala','01014','Junto al parque'),
(83,'Calle 7','8','Calle 8','6','Zona 6','San Jose Pinula','Guatemala','01015','Frente a la iglesia'),
(84,'Avenida 8','25','Calle 9','10','Zona 10','San Jose Pinula','Guatemala','01016','Junto al colegio'),
(85,'Calle 7','8','Calle 8','6','Zona 6','San Jose Pinula','Guatemala','01015','Frente a la iglesia'),
(86,'Avenida 8','25','Calle 9','10','Zona 10','San Jose Pinula','Guatemala','01016','Junto al colegio'),
(87,'Calle 9','10','Calle 11','12','Zona 12','Ciudad de Guatemala','Guatemala','01017','Cerca del parque'),
(88,'Avenida 12','50','Calle 13','14','Zona 14','Ciudad de Guatemala','Guatemala','01018','Frente al supermercado'),
(89,'Calle 5','30','Calle 6','3','Zona 3','Villa Nueva','Guatemala','01019','Cerca de la estación'),
(90,'Calle 7','35','Calle 8','3','Zona 3','Villa Nueva','Guatemala','01020','Frente a la tienda'),
(91,'Calle 11','22','Calle 12','5','Zona 5','Ciudad de Guatemala','Guatemala','01021','Frente al parque'),
(92,'Avenida 15','40','Calle 16','16','Zona 16','Ciudad de Guatemala','Guatemala','01022','Junto al centro comercial'),
(93,'Calle A','10','Calle B','5','Colonia 1','Guatemala','Guatemala','01001','Frente al parque'),
(94,'Calle C','20','Calle D','3','Colonia 2','San Miguel Petapa','Guatemala','01002','Cerca de la iglesia'),
(95,'Calle X','5','Calle Y','2','Colonia 3','Guatemala','Guatemala','01003','Frente a la tienda'),
(96,'Calle Z','15','Calle W','6','Colonia 4','Fraijanes','Guatemala','01004','Cerca de la escuela'),
(97,'Calle 1','1','Calle 2','8','Colonia 5','Guatemala','Guatemala','01005','Al lado del banco'),
(98,'Calle 3','10','Calle 4','12','Colonia 6','Villa Nueva','Guatemala','01006','Frente a la plaza'),
(99,'Calle M','3','Calle N','2','Colonia 7','Guatemala','Guatemala','01007','Cerca del mercado'),
(100,'Calle O','6','Calle P','4','Colonia 8','Guatemala','Guatemala','01008','Frente a la librería'),
(101,'Calle Q','7','Calle R','1','Colonia 9','Guatemala','Guatemala','01009','Cerca del parque central'),
(102,'Calle S','9','Calle T','7','Colonia 10','Guatemala','Guatemala','01010','Frente a la estación'),
(103,'Calle U','12','Calle V','5','Colonia 11','Guatemala','Guatemala','01011','Cerca del cine'),
(104,'Calle W','15','Calle X','9','Colonia 12','San Jose Pinula','Guatemala','01012','Frente al hospital'),
(105,'Calle Y','4','Calle Z','6','Colonia 13','Guatemala','Guatemala','01013','Cerca del banco'),
(106,'Calle A1','7','Calle B1','10','Colonia 14','Guatemala','Guatemala','01014','Frente al parque'),
(107,'1a Calle','10','Ave Central','1','Zona 1','Guatemala','Guatemala','01001',''),
(108,'2a Calle','20','Ave Secundaria','3','Mixco Centro','San Miguel Petapa','Mixco','01010',''),
(109,'3a Calle','5','Ave Central','2','Zona 2','Guatemala','Guatemala','01002',''),
(110,'4a Calle','15','Ave Secundaria','5','Zona 5','Guatemala','Guatemala','01003',''),
(111,'5a Calle','12','Ave Norte','3','Zona 3','Guatemala','Guatemala','01004',''),
(112,'6a Calle','25','Ave Sur','10','Fraijanes Centro','Fraijanes','Fraijanes','01005',''),
(113,'7a Calle','8','Ave Norte','6','Zona 6','Guatemala','Guatemala','01006',''),
(114,'8a Calle','18','Ave Sur','8','Zona 8','Guatemala','Guatemala','01007',''),
(115,'9a Calle','30','Ave Norte','10','Zona 10','Guatemala','Guatemala','01008',''),
(116,'10a Calle','40','Ave Sur','1','Mixco Centro','San Miguel Petapa','Mixco','01009',''),
(117,'Avenida 1','10','B','50','Centro','Ciudad X','Guatemala','01001',''),
(118,'Calle 5','20','D','50','Centro','Ciudad Y','Guatemala','01002',''),
(119,'Av Central','1','A','3','Zona 3','Mixco','Guatemala','01003',''),
(120,'Calle B','2','C','3','Zona 3','Mixco','Guatemala','01004',''),
(121,'Av Mixco','10','B','10','Barrio X','Villa Nueva','Guatemala','01005',''),
(122,'Calle F','15','G','10','Barrio Y','Villa Nueva','Guatemala','01006',''),
(123,'Av KM','5','X','0','Barrio KM','San José Pinula','Guatemala','01007',''),
(124,'Calle KM','1','Y','0','Barrio KM','San José Pinula','Guatemala','01008',''),
(125,'Av KM','5','X','0','Barrio KM','San José Pinula','Guatemala','01007',''),
(126,'Calle KM','1','Y','0','Barrio KM','San José Pinula','Guatemala','01008',''),
(127,'Av Zonas','1','A','5','Barrio Z','Mixco','Guatemala','01009',''),
(128,'Calle Z','2','B','5','Barrio Z','Ciudad X','Guatemala','01010',''),
(129,'Av KM','5','X','0','Barrio KM','San José Pinula','Guatemala','01007',''),
(130,'Calle KM','1','Y','0','Barrio KM','San José Pinula','Guatemala','01008',''),
(131,'1a Avenida','12','Calle B','3','Zona 3','Guatemala','Guatemala','01001',''),
(132,'2a Calle','34','Calle C','10','Zona 10','Fraijanes','Guatemala','01010',''),
(133,'Av. Reforma','100','Calle D','1','Zona 1','Guatemala','Guatemala','01001',''),
(134,'3a Avenida','55','Calle E','2','Zona 2','San Miguel Petapa','Guatemala','01002',''),
(135,'Boulevard Liberación','200','Calle F','5','Zona 5','Guatemala','Guatemala','01003',''),
(136,'4a Avenida','78','Calle G','8','Zona 8','Villa Nueva','Guatemala','01005',''),
(137,'Calle H','12','Calle I','12','Zona 12','Guatemala','Guatemala','01012',''),
(138,'5a Calle','34','Calle J','16','Zona 16','San Jose Pinula','Guatemala','01020',''),
(139,'Calle K','50','Calle L','6','Zona 6','Guatemala','Guatemala','01006',''),
(140,'6a Avenida','90','Calle M','14','Zona 14','Fraijanes','Guatemala','01014',''),
(141,'Calle K','50','Calle L','6','Zona 6','Guatemala','Guatemala','01006',''),
(142,'6a Avenida','90','Calle M','14','Zona 14','Fraijanes','Guatemala','01014',''),
(143,'Calle K','50','Calle L','6','Zona 6','Guatemala','Guatemala','01006',''),
(144,'6a Avenida','90','Calle M','14','Zona 14','Fraijanes','Guatemala','01014',''),
(145,'Calle K','50','Calle L','6','Zona 6','Guatemala','Guatemala','01006',''),
(146,'6a Avenida','90','Calle M','14','Zona 14','Fraijanes','Guatemala','01014',''),
(147,'7a Avenida','12','10a Calle','1','Centro','Guatemala','Guatemala','01001','Frente al Parque Central'),
(148,'Boulevard Los Próceres','20','Calle Real','10','Las Charcas','Guatemala','Guatemala','01010','Cerca del centro comercial'),
(149,'7a Avenida','12','10a Calle','1','Centro','Guatemala','Guatemala','01001','Frente al Parque Central'),
(150,'Boulevard Los Próceres','20','Calle Real','10','Las Charcas','Guatemala','Guatemala','01010','Cerca del centro comercial'),
(151,'Calle 1','10','Calle 2','Zona 1','Colonia Centro','Mixco','Guatemala','01010','Frente al parque'),
(152,'Avenida Reforma','100','','Zona 1','Zona Financiera','Mixco','Guatemala','01011','Cerca de la plaza'),
(153,'Calle 1','10','Calle 2','Zona 1','Colonia Centro','Mixco','Guatemala','01010','Frente al parque'),
(154,'Avenida Reforma','100','','Zona 1','Zona Financiera','Mixco','Guatemala','01011','Cerca de la plaza'),
(155,'Calle 1','10','Calle 2','Zona 1','Colonia Centro','Mixco','Guatemala','01010','Frente al parque'),
(156,'Avenida Reforma','100','','Zona 1','Zona Financiera','Mixco','Guatemala','01011','Cerca de la plaza'),
(157,'Calle 1','10','Calle 2','Zona 1','Colonia Centro','Mixco','Guatemala','01010','Frente al parque'),
(158,'Avenida Reforma','100','','Zona 1','Zona Financiera','Mixco','Guatemala','01011','Cerca de la plaza'),
(159,'Calle 1','10','Calle 2','Zona 1','Colonia Centro','Mixco','Guatemala','01010','Frente al parque'),
(160,'Avenida Reforma','100','','Zona 1','Zona Financiera','Mixco','Guatemala','01011','Cerca de la plaza'),
(161,'Calle 1','10','Calle 2','Zona 1','Colonia Centro','Mixco','Guatemala','01010','Frente al parque'),
(162,'Avenida Reforma','100','','Zona 1','Zona Financiera','Mixco','Guatemala','01011','Cerca de la plaza'),
(163,'Calle 1','10','Calle 2','Zona 1','Colonia Centro','Mixco','Guatemala','01010','Frente al parque'),
(164,'Avenida Reforma','100','','Zona 1','Zona Financiera','Mixco','Guatemala','01011','Cerca de la plaza'),
(165,'Calle 3','50','','Zona 10','Colonia Sur','Mixco','Guatemala','01020',''),
(166,'Calle 4','60','','Zona 10','Colonia Norte','Mixco','Guatemala','01021',''),
(167,'Calle 5','15','','Zona 14','Centro','Guatemala','Guatemala','01050',''),
(168,'Calle 6','20','','Zona 14','Zona Norte','Guatemala','Guatemala','01051',''),
(169,'Calle 3','50','','Zona 10','Colonia Sur','Mixco','Guatemala','01020',''),
(170,'Calle 4','60','','Zona 10','Colonia Norte','Mixco','Guatemala','01021',''),
(171,'Calle 1','10','Calle 2','Zona 1','Colonia Centro','Mixco','Guatemala','01010','Frente al parque'),
(172,'Avenida Central','50','','Zona 1','Zona Financiera','Mixco','Guatemala','01011','Cerca del parque'),
(173,'Calle 5','15','Calle 6','Zona 2','Colonia Centro','Mixco','Guatemala','01012',''),
(174,'Calle Reforma','20','','Zona 3','Colonia Norte','Mixco','Guatemala','01013','Frente al mercado'),
(175,'Avenida 1','100','','Zona 1','Centro','Villa Nueva','Guatemala','01014',''),
(176,'Avenida 3','200','','Zona 3','Sur','Villa Nueva','Guatemala','01015',''),
(177,'Calle 3','50','Calle 4','Zona 2','Colonia Central','Guatemala','Guatemala','01005','Frente a la iglesia'),
(178,'Avenida La Reforma','200','Calle 10','Zona 3','Zona Comercial','Guatemala','Guatemala','01006','Al lado del banco'),
(179,'Calle 3','50','Calle 4','Zona 2','Colonia Central','Guatemala','Guatemala','01005','Frente a la iglesia'),
(180,'Avenida La Reforma','200','Calle 10','Zona 3','Zona Comercial','Guatemala','Guatemala','01006','Al lado del banco'),
(181,'Calle 3','50','Calle 4','Zona 2','Colonia Central','Guatemala','Guatemala','01005','Frente a la iglesia'),
(182,'Avenida La Reforma','200','Calle 10','Zona 3','Zona Comercial','Guatemala','Guatemala','01006','Al lado del banco'),
(183,'Calle 1','10','Calle 2','1','Colonia Centro','Guatemala','Guatemala','01010','Frente al parque'),
(184,'Avenida Reforma','100','','1','Zona Financiera','Guatemala','Guatemala','01011','Cerca de la plaza'),
(185,'Calle 1','10','Calle 2','Zona 1','Colonia Centro','Mixco','Guatemala','01010','Frente al parque'),
(186,'Avenida Reforma','100','','Zona 1','Zona Financiera','Mixco','Guatemala','01011','Cerca de la plaza'),
(187,'Calle 1','10','Calle 2','Zona 1','Colonia Centro','Mixco','Guatemala','01010','Frente al parque'),
(188,'Avenida Reforma','100','','Zona 1','Zona Financiera','Mixco','Guatemala','01011','Cerca de la plaza'),
(189,'Calle 1','10','Calle 2','Zona 1','Colonia Centro','Mixco','Guatemala','01010','Frente al parque'),
(190,'Avenida Reforma','100','','Zona 1','Zona Financiera','Mixco','Guatemala','01011','Cerca de la plaza'),
(191,'7a Avenida','12-45','12 Calle','Zona 1','Centro Histórico','Guatemala','Guatemala','01001','Frente al Palacio Nacional'),
(192,'Boulevard Liberación','20-30','4a Avenida','Zona 9','Aurora','Guatemala','Guatemala','01009','Atrás de Plaza España'),
(193,'Calzada Roosevelt','15-50','9a Avenida','Zona 7','Colonia Landívar','Guatemala','Guatemala','01007','Diagonal a Tikal Futura'),
(194,'Avenida Petapa','35-20','12 Calle','Zona 12','Colonia El Carmen','Guatemala','Guatemala','01012','A una cuadra de la USAC'),
(195,'Calzada Roosevelt','15-50','9a Avenida','Zona 7','Colonia Landívar','Guatemala','Guatemala','01007','Diagonal a Tikal Futura'),
(196,'Avenida Petapa','35-20','12 Calle','Zona 12','Colonia El Carmen','Guatemala','Guatemala','01012','A una cuadra de la USAC'),
(197,'Calzada Roosevelt','15-50','9a Avenida','Zona 7','Colonia Landívar','Guatemala','Guatemala','01007','Diagonal a Tikal Futura'),
(198,'Avenida Petapa','35-20','12 Calle','Zona 12','Colonia El Carmen','Guatemala','Guatemala','01012','A una cuadra de la USAC'),
(199,'Calzada Roosevelt','15-50','9a Avenida','Zona 7','Colonia Landívar','Guatemala','Guatemala','01007','Diagonal a Tikal Futura'),
(200,'Avenida Petapa','35-20','12 Calle','Zona 12','Colonia El Carmen','Guatemala','Guatemala','01012','A una cuadra de la USAC'),
(201,'Calzada Roosevelt','15-50','9a Avenida','Zona 7','Colonia Landívar','Guatemala','Guatemala','01007','Diagonal a Tikal Futura'),
(202,'Avenida Petapa','35-20','12 Calle','Zona 12','Colonia El Carmen','Guatemala','Guatemala','01012','A una cuadra de la USAC'),
(203,'Calzada Roosevelt','15-50','9a Avenida','Zona 7','Colonia Landívar','Guatemala','Guatemala','01007','Diagonal a Tikal Futura'),
(204,'Avenida Petapa','35-20','12 Calle','Zona 12','Colonia El Carmen','Guatemala','Guatemala','01012','A una cuadra de la USAC'),
(205,'Calzada Roosevelt','15-50','9a Avenida','Zona 7','Colonia Landívar','Guatemala','Guatemala','01007','Diagonal a Tikal Futura'),
(206,'Avenida Petapa','35-20','12 Calle','Zona 12','Colonia El Carmen','Guatemala','Guatemala','01012','A una cuadra de la USAC'),
(207,'Calzada Roosevelt','15-50','9a Avenida','Zona 7','Colonia Landívar','Guatemala','Guatemala','01007','Diagonal a Tikal Futura'),
(208,'Avenida Petapa','35-20','12 Calle','Zona 12','Colonia El Carmen','Guatemala','Guatemala','01012','A una cuadra de la USAC'),
(209,'Calzada Roosevelt','15-50','9a Avenida','Zona 7','Colonia Landívar','Guatemala','Guatemala','01007','Diagonal a Tikal Futura'),
(210,'Avenida Petapa','35-20','12 Calle','Zona 12','Colonia El Carmen','Guatemala','Guatemala','01012','A una cuadra de la USAC'),
(211,'Boulevard Vista Hermosa','5-60','Diagonal 6','Zona 15','Vista Hermosa II','Guatemala','Guatemala','01015','Cerca del Colegio Americano'),
(212,'Carretera a El Salvador','Km 18.5','Entrada a San José Pinula','N/A','Residenciales Los Álamos','San José Pinula','Guatemala','01052','Casa con portón café al final de la cuadra'),
(213,'Boulevard Vista Hermosa','5-60','Diagonal 6','Zona 15','Vista Hermosa II','Guatemala','Guatemala','01015','Cerca del Colegio Americano'),
(214,'Carretera a El Salvador','Km 18.5','Entrada a San José Pinula','N/A','Residenciales Los Álamos','San José Pinula','Guatemala','01052','Casa con portón café al final de la cuadra'),
(215,'Boulevard Vista Hermosa','5-60','Diagonal 6','Zona 15','Vista Hermosa II','Guatemala','Guatemala','01015','Cerca del Colegio Americano'),
(216,'Carretera a El Salvador','Km 18.5','Entrada a San José Pinula','N/A','Residenciales Los Álamos','San José Pinula','Guatemala','01052','Casa con portón café al final de la cuadra'),
(217,'Boulevard Vista Hermosa','5-60','Diagonal 6','Zona 15','Vista Hermosa II','Guatemala','Guatemala','01015','Cerca del Colegio Americano'),
(218,'Carretera a El Salvador','Km 18.5','Entrada a San José Pinula','8','Residenciales Los Álamos','San José Pinula','Guatemala','01052','Casa con portón café al final de la cuadra'),
(219,'Boulevard Vista Hermosa','5-60','Diagonal 6','Zona 15','Vista Hermosa II','Guatemala','Guatemala','01015','Cerca del Colegio Americano'),
(220,'Carretera a El Salvador','Km 18.5','Entrada a San José Pinula','1','Residenciales Los Álamos','San José Pinula','Guatemala','01052','Casa con portón café al final de la cuadra'),
(221,'Boulevard Vista Hermosa','5-60','Diagonal 6','15','Vista Hermosa II','Guatemala','Guatemala','01015','Cerca del Colegio Americano'),
(222,'Carretera a El Salvador','Km 18.5','Entrada a San José Pinula','1','Residenciales Los Álamos','San José Pinula','Guatemala','01052','Casa con portón café al final de la cuadra'),
(223,'Boulevard Vista Hermosa','5-60','Diagonal 6','15','Vista Hermosa II','Guatemala','Guatemala','01015','Cerca del Colegio Americano'),
(224,'Carretera a El Salvador','Km 18.5','Entrada a San José Pinula','1','Residenciales Los Álamos','San José Pinula','Guatemala','01052','Casa con portón café al final de la cuadra'),
(225,'6a Avenida','12-34','Frente al Centro Comercial La Pradera','10','Zona 10','Ciudad de Guatemala','Guatemala','01069','Enfrente de la casa verde'),
(226,'4a. Calle','15-55','Frente a la Plaza de la Constitución','1','Zona 1','Ciudad de Guatemala','Guatemala','01065','Enfrente de Castors'),
(227,'Boulevard Vista Hermosa','5-60','Diagonal 6','15','Vista Hermosa II','Guatemala','Guatemala','01065','Al lado del campo de futbol, casa verde'),
(228,'Carretera a El Salvador','Km 18.5','Entrada a San José Pinula','1','Residenciales Los Álamos','San José Pinula','San José Pinula','San José Pinula','Casa con portón café al final de la cuadra'),
(229,'Boulevard Vista Hermosa','2-20','Diagonal 6','15','Vista Hermosa II','Guatemala','Guatemala','01065','Enfrente de la panaderia'),
(230,'Carretera a El Salvador','Km 18.5','Entrada a San José Pinula','1','Residenciales Los Álamos','San José Pinula','San José Pinula','01069','Enfrente de Liceo del Monte'),
(231,'Boulevard Vista Hermosa','2-20','Diagonal 6','15','Vista Hermosa II','Guatemala','Guatemala','01065','Enfrente de la panaderia'),
(232,'Carretera a El Salvador','Km 18.5','Entrada a San José Pinula','1','Residenciales Los Álamos','San José Pinula','San José Pinula','01069','Enfrente de Liceo del Monte');
/*!40000 ALTER TABLE `direccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envio`
--

DROP TABLE IF EXISTS `envio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `envio` (
  `id_envio` int(11) NOT NULL AUTO_INCREMENT,
  `id_pedido` int(11) NOT NULL,
  `id_repartidor` int(11) DEFAULT NULL,
  `costo` decimal(10,2) NOT NULL,
  `fecha_asignacion` timestamp NULL DEFAULT current_timestamp(),
  `estado` varchar(255) DEFAULT 'En tránsito',
  PRIMARY KEY (`id_envio`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_repartidor` (`id_repartidor`),
  CONSTRAINT `envio_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envio`
--

LOCK TABLES `envio` WRITE;
/*!40000 ALTER TABLE `envio` DISABLE KEYS */;
INSERT INTO `envio` VALUES
(1,1,NULL,25.00,'2025-09-03 03:01:55','En tránsito'),
(2,2,NULL,25.00,'2025-09-03 03:04:07','En tránsito'),
(3,3,NULL,25.00,'2025-09-03 03:04:47','En tránsito'),
(4,4,NULL,25.00,'2025-09-03 03:04:50','En tránsito'),
(5,5,NULL,35.00,'2025-09-03 03:05:22','En tránsito'),
(6,6,NULL,30.00,'2025-09-03 03:10:21','En tránsito'),
(7,7,NULL,25.00,'2025-09-03 03:11:02','En tránsito'),
(8,8,NULL,35.00,'2025-09-03 03:11:28','En tránsito'),
(9,9,NULL,40.00,'2025-09-03 03:11:50','En tránsito'),
(10,10,NULL,35.00,'2025-09-03 03:12:12','En tránsito'),
(11,11,NULL,30.00,'2025-09-03 04:20:29','En tránsito'),
(12,12,NULL,35.00,'2025-09-03 04:21:12','En tránsito'),
(13,13,NULL,35.00,'2025-09-03 04:21:29','En tránsito'),
(14,14,NULL,25.00,'2025-09-03 04:29:33','En tránsito'),
(15,15,NULL,25.00,'2025-09-03 04:30:02','En tránsito'),
(16,16,NULL,35.00,'2025-09-03 04:30:30','En tránsito'),
(17,17,NULL,25.00,'2025-09-03 04:30:53','En tránsito'),
(18,18,NULL,25.00,'2025-09-03 04:31:17','En tránsito'),
(19,19,NULL,25.00,'2025-09-03 04:37:45','En tránsito'),
(20,20,NULL,25.00,'2025-09-03 04:38:03','En tránsito'),
(21,21,NULL,30.00,'2025-09-03 04:38:23','En tránsito'),
(22,22,NULL,25.00,'2025-09-03 04:38:46','En tránsito'),
(23,23,NULL,30.00,'2025-09-03 04:39:14','En tránsito'),
(24,24,NULL,25.00,'2025-09-03 04:50:31','En tránsito'),
(25,25,NULL,25.00,'2025-09-03 04:53:40','En tránsito'),
(26,26,NULL,25.00,'2025-09-03 04:53:59','En tránsito'),
(27,27,NULL,25.00,'2025-09-03 04:54:01','En tránsito'),
(28,28,NULL,25.00,'2025-09-03 04:54:15','En tránsito'),
(29,29,NULL,25.00,'2025-09-03 04:54:35','En tránsito'),
(30,30,NULL,25.00,'2025-09-03 04:54:48','En tránsito'),
(31,31,NULL,35.00,'2025-09-03 04:55:05','En tránsito'),
(32,32,NULL,30.00,'2025-09-03 04:55:23','En tránsito'),
(33,33,NULL,25.00,'2025-09-03 04:55:41','En tránsito'),
(34,34,NULL,25.00,'2025-09-03 04:55:57','En tránsito'),
(35,35,NULL,30.00,'2025-09-03 05:05:43','En tránsito'),
(36,36,NULL,30.00,'2025-09-03 05:06:02','En tránsito'),
(37,37,NULL,35.00,'2025-09-03 05:06:24','En tránsito'),
(38,38,NULL,25.00,'2025-09-03 05:06:42','En tránsito'),
(39,39,NULL,35.00,'2025-09-03 05:06:58','En tránsito'),
(40,40,NULL,40.00,'2025-09-03 05:07:17','En tránsito'),
(41,41,NULL,40.00,'2025-09-03 05:07:31','En tránsito'),
(42,42,NULL,40.00,'2025-09-03 05:07:41','En tránsito'),
(43,43,NULL,30.00,'2025-09-03 05:07:57','En tránsito'),
(44,44,NULL,30.00,'2025-09-03 05:08:15','En tránsito'),
(45,45,NULL,30.00,'2025-09-03 05:08:33','En tránsito'),
(46,46,NULL,35.00,'2025-09-03 05:21:01','En tránsito'),
(47,47,NULL,40.00,'2025-09-03 05:21:27','En tránsito'),
(48,48,NULL,35.00,'2025-09-03 05:21:49','En tránsito'),
(49,49,NULL,30.00,'2025-09-03 05:22:10','En tránsito'),
(50,50,NULL,30.00,'2025-09-03 05:22:32','En tránsito'),
(51,51,NULL,40.00,'2025-09-03 05:22:58','En tránsito'),
(52,52,NULL,30.00,'2025-09-03 05:23:18','En tránsito'),
(53,53,NULL,35.00,'2025-09-03 05:41:13','En tránsito'),
(54,54,NULL,30.00,'2025-09-03 05:41:31','En tránsito'),
(55,55,NULL,40.00,'2025-09-03 05:41:49','En tránsito'),
(56,56,NULL,25.00,'2025-09-03 05:42:07','En tránsito'),
(57,57,NULL,35.00,'2025-09-03 05:42:24','En tránsito'),
(58,58,NULL,25.00,'2025-09-03 05:44:50','En tránsito'),
(59,59,NULL,35.00,'2025-09-03 05:45:05','En tránsito'),
(60,60,NULL,30.00,'2025-09-03 05:46:00','En tránsito'),
(61,61,NULL,40.00,'2025-09-03 05:54:29','En tránsito'),
(62,62,NULL,35.00,'2025-09-03 05:54:49','En tránsito'),
(63,63,NULL,35.00,'2025-09-03 05:55:18','En tránsito'),
(64,64,NULL,40.00,'2025-09-03 05:55:45','En tránsito'),
(65,65,NULL,40.00,'2025-09-03 05:56:13','En tránsito'),
(66,66,NULL,40.00,'2025-09-06 08:21:40','En tránsito'),
(67,67,NULL,25.00,'2025-09-10 22:31:45','En tránsito'),
(68,68,NULL,30.00,'2025-09-10 23:01:20','En tránsito'),
(69,69,NULL,25.00,'2025-09-10 23:03:54','En tránsito'),
(70,70,NULL,25.00,'2025-09-10 23:12:20','En tránsito'),
(71,71,8,25.00,'2025-09-11 03:00:29','En tránsito'),
(72,72,8,25.00,'2025-09-11 03:05:37','En tránsito'),
(73,73,11,25.00,'2025-09-11 03:06:18','En tránsito'),
(74,74,8,25.00,'2025-09-11 03:08:40','En tránsito'),
(75,75,10,25.00,'2025-09-11 03:09:02','En tránsito'),
(76,76,11,25.00,'2025-09-11 03:09:35','En tránsito'),
(77,77,9,25.00,'2025-09-11 03:20:47','Entregado'),
(78,78,8,25.00,'2025-09-11 03:22:23','En tránsito'),
(79,79,8,25.00,'2025-09-11 03:23:05','En tránsito'),
(80,80,8,25.00,'2025-09-11 04:23:58','En tránsito'),
(81,81,11,25.00,'2025-09-11 04:42:31','En tránsito'),
(82,82,11,25.00,'2025-09-11 04:53:21','En tránsito'),
(83,83,11,25.00,'2025-09-11 07:31:13','En tránsito'),
(84,84,11,25.00,'2025-09-13 07:50:34','En tránsito'),
(85,85,11,25.00,'2025-09-13 08:00:35','En tránsito'),
(86,86,11,25.00,'2025-09-13 08:00:39','En tránsito');
/*!40000 ALTER TABLE `envio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paquete`
--

DROP TABLE IF EXISTS `paquete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `paquete` (
  `id_paquete` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text NOT NULL,
  `peso` decimal(10,2) DEFAULT NULL,
  `dimensiones` varchar(255) DEFAULT NULL,
  `fragil` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_paquete`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paquete`
--

LOCK TABLES `paquete` WRITE;
/*!40000 ALTER TABLE `paquete` DISABLE KEYS */;
INSERT INTO `paquete` VALUES
(1,'Laptop Gamer',3.50,'50x30x15',1),
(2,'Caja con libros',5.20,'30x20x15 cm',1),
(3,'Caja con libros',5.00,'30x20x15 cm',1),
(4,'Paquete de ropa',2.50,'40x30x20 cm',0),
(5,'Paquete de ropa',2.50,'40x30x20 cm',0),
(6,'Electrónica',8.00,'50x40x30 cm',1),
(7,'Caja con libros',5.20,'30x20x15 cm',1),
(8,'Paquete de ropa',2.50,'40x30x20 cm',0),
(9,'Electrónica',8.00,'50x40x30 cm',1),
(10,'Material de oficina',12.00,'60x50x40 cm',0),
(11,'Regalos variados',6.00,'45x35x25 cm',1),
(12,'Caja con libros',5.00,'30x20x15 cm',1),
(13,'Caja de juguetes',4.50,'40x30x25 cm',0),
(14,'Electrodomésticos pequeños',7.00,'50x40x35 cm',1),
(15,'Caja con libros',5.20,'30x20x15 cm',1),
(16,'Paquete de ropa',2.50,'40x30x20 cm',0),
(17,'Electrónica',8.00,'50x40x30 cm',1),
(18,'Paquete de alimentos',3.50,'25x20x15 cm',0),
(19,'Paquete frágil',1.50,'20x15x10 cm',1),
(20,'Caja con libros',5.00,'30x20x15 cm',1),
(21,'Ropa de temporada',2.50,'40x30x20 cm',0),
(22,'Documentos importantes',1.20,'25x15x10 cm',1),
(23,'Electrónica',7.00,'50x40x30 cm',1),
(24,'Juguetes',3.00,'35x25x20 cm',0),
(25,'Libros',5.00,'30x20x15 cm',1),
(26,'Ropa',2.50,'40x30x20 cm',0),
(27,'Electrónica',8.00,'50x40x30 cm',1),
(28,'Electrónica',8.00,'50x40x30 cm',1),
(29,'Muebles',20.00,'200x100x50 cm',0),
(30,'Paquete general',3.00,'30x30x30 cm',0),
(31,'Documentos',1.00,'20x20x5 cm',1),
(32,'Electrodomésticos',10.00,'60x40x40 cm',1),
(33,'Paquete pequeño',2.00,'25x20x10 cm',0),
(34,'Paquete grande',15.00,'100x50x50 cm',0),
(35,'Papelería',1.00,'15x15x5 cm',1),
(36,'Caja pequeña',2.00,'20x15x10',1),
(37,'Paquete mediano',5.00,'30x20x15',0),
(38,'Sobres',0.50,'10x5x1',0),
(39,'Electrónica',1.00,'15x15x10',1),
(40,'Ropa',3.00,'25x20x15',0),
(41,'Documentos',0.30,'15x10x2',0),
(42,'Juguetes',2.00,'20x15x15',1),
(43,'Juguetes',2.00,'20x15x15',1),
(44,'Alimentos',4.00,'30x25x15',0),
(45,'Herramientas',6.00,'40x20x20',0),
(46,'Libros',1.00,'20x15x5',0),
(47,'Caja pequeña',2.00,'20x20x20',0),
(48,'Sobre',0.50,'10x10x2',0),
(49,'Paquete mediano',5.00,'30x30x30',1),
(50,'Documento',1.00,'15x10x1',0),
(51,'Caja grande',10.00,'50x50x50',1),
(52,'Sobre mediano',2.00,'25x20x2',0),
(53,'Caja pequeña',1.00,'15x15x15',0),
(54,'Caja mediana',5.00,'30x30x30',0),
(55,'Sobre',1.00,'20x10x2',0),
(56,'Electrónica',8.00,'50x40x30',1),
(57,'Documentos',2.00,'25x20x5',0),
(58,'Mueble',15.00,'100x50x40',1),
(59,'Caja pequeña',2.00,'10x10x10',0),
(60,'Paquete ligero',1.00,'5x5x5',1),
(61,'Caja mediana',5.00,'20x20x20',0),
(62,'Sobre importante',0.50,'2x2x1',1),
(63,'Sobre importante',0.50,'2x2x1',1),
(64,'Paquete estándar',3.00,'15x15x15',0),
(65,'Sobre importante',0.50,'2x2x1',1),
(66,'Caja mediana',5.00,'30x20x15',0),
(67,'Sobre',1.00,'20x10x2',0),
(68,'Paquete grande',15.00,'60x40x30',1),
(69,'Documento urgente',0.50,'15x10x1',0),
(70,'Caja frágil',3.00,'25x20x15',1),
(71,'Caja frágil',3.00,'25x20x15',1),
(72,'Caja frágil',3.00,'25x20x15',1),
(73,'Caja frágil',3.00,'25x20x15',1),
(74,'Paquete electrónico frágil',2.50,'30x20x10',1),
(75,'Paquete electrónico frágil',2.50,'30x20x10',1),
(76,'Caja de libros',5.50,'30x20x15',1),
(77,'Caja de libros',5.50,'30x20x15',1),
(78,'Caja de libros',5.50,'30x20x15',1),
(79,'Caja de libros',5.50,'30x20x15',1),
(80,'Caja de libros',5.50,'30x20x15',1),
(81,'Caja de libros',5.50,'30x20x15',1),
(82,'Caja de libros',5.50,'30x20x15',1),
(83,'Paquete frágil',2.00,'20x20x20',1),
(84,'Electrónica',3.00,'40x30x10',1),
(85,'Paquete frágil',2.00,'20x20x20',1),
(86,'Caja de libros',5.50,'30x20x15',1),
(87,'Caja de herramientas',12.00,'40x30x25',0),
(88,'Paquete frágil',3.00,'20x20x10',1),
(89,'Caja de papelería',2.50,'20x15x10',0),
(90,'Caja de papelería',2.50,'20x15x10',0),
(91,'Caja de papelería',2.50,'20x15x10',0),
(92,'Caja de libros',5.50,'30x20x15',1),
(93,'Caja de libros',5.50,'30x20x15',1),
(94,'Caja de libros',5.50,'30x20x15',1),
(95,'Laptop',2.50,'40x30x10',1),
(96,'Caja de libros',5.50,'30x20x15',1),
(97,'Caja con documentos legales',3.20,'35x25x10',1),
(98,'Zapatos deportivos',1.80,'30x20x12',0),
(99,'Zapatos deportivos',1.80,'30x20x12',0),
(100,'Zapatos deportivos',1.80,'30x20x12',0),
(101,'Zapatos deportivos',1.80,'30x20x12',0),
(102,'Zapatos deportivos',1.80,'30x20x12',0),
(103,'Zapatos deportivos',1.80,'30x20x12',0),
(104,'Zapatos deportivos',1.80,'30x20x12',0),
(105,'Zapatos deportivos',1.80,'30x20x12',0),
(106,'Zapatos deportivos',1.80,'30x20x12',0),
(107,'Televisor LED 55 pulgadas',10.50,'125x80x20',1),
(108,'Televisor LED 55 pulgadas',10.50,'125x80x20',1),
(109,'Televisor LED 55 pulgadas',10.50,'125x80x20',1),
(110,'Televisor LED 55 pulgadas',10.50,'125x80x20',1),
(111,'Televisor LED 55 pulgadas',10.50,'125x80x20',1),
(112,'Televisor LED 55 pulgadas',10.50,'125x80x20',1),
(113,'Televisor LED 55 pulgadas',10.50,'125x80x20',1),
(114,'Paquete de Calcetines Rosados',1.00,'20x10x5',0),
(115,'Televisor LED 55 pulgadas',5.00,'40x40x40',1),
(116,'Ropa ',1.00,'10x10x10',0),
(117,'Ropa ',1.00,'10x10x10',0);
/*!40000 ALTER TABLE `paquete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_paquete` int(11) NOT NULL,
  `id_direccion_origen` int(11) NOT NULL,
  `id_direccion_destino` int(11) NOT NULL,
  `nombre_destinatario` varchar(255) NOT NULL,
  `email_destinatario` varchar(255) DEFAULT NULL,
  `telefono_destinatario` varchar(50) DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT current_timestamp(),
  `estado` varchar(255) DEFAULT 'Pendiente',
  PRIMARY KEY (`id_pedido`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_paquete` (`id_paquete`),
  KEY `id_direccion_origen` (`id_direccion_origen`),
  KEY `id_direccion_destino` (`id_direccion_destino`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`id_paquete`) REFERENCES `paquete` (`id_paquete`),
  CONSTRAINT `pedido_ibfk_3` FOREIGN KEY (`id_direccion_origen`) REFERENCES `direccion` (`id_direccion`),
  CONSTRAINT `pedido_ibfk_4` FOREIGN KEY (`id_direccion_destino`) REFERENCES `direccion` (`id_direccion`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES
(1,3,2,3,4,'Carlos Lopez','carlos@example.com','12345678','2025-09-03 03:01:55','Pendiente'),
(2,3,3,5,6,'Ana Pérez','ana@example.com','87654321','2025-09-03 03:04:07','Pendiente'),
(3,3,4,7,8,'Luis Gómez','luis@example.com','23456789','2025-09-03 03:04:47','Pendiente'),
(4,3,5,9,10,'Luis Gómez','luis@example.com','23456789','2025-09-03 03:04:50','Pendiente'),
(5,3,6,11,12,'María López','maria@example.com','34567890','2025-09-03 03:05:22','Pendiente'),
(6,3,7,13,14,'Carlos Lopez','carlos@example.com','12345678','2025-09-03 03:10:21','Pendiente'),
(7,3,8,15,16,'Luis Gómez','luis@example.com','23456789','2025-09-03 03:11:02','Pendiente'),
(8,3,9,17,18,'María López','maria@example.com','34567890','2025-09-03 03:11:28','Pendiente'),
(9,3,10,19,20,'Ana Martínez','ana@example.com','45678901','2025-09-03 03:11:50','Pendiente'),
(10,3,11,21,22,'Pedro Sánchez','pedro@example.com','56789012','2025-09-03 03:12:12','Pendiente'),
(11,3,12,23,24,'Ana Pérez','ana@example.com','87654321','2025-09-03 04:20:29','Pendiente'),
(12,3,13,25,26,'Pedro Ramírez','pedro@example.com','56789012','2025-09-03 04:21:12','Pendiente'),
(13,3,14,27,28,'Laura González','laura@example.com','67890123','2025-09-03 04:21:29','Pendiente'),
(14,3,15,29,30,'Carlos Lopez','carlos@example.com','12345678','2025-09-03 04:29:33','Pendiente'),
(15,3,16,31,32,'Luis Gómez','luis@example.com','23456789','2025-09-03 04:30:02','Pendiente'),
(16,3,17,33,34,'María López','maria@example.com','34567890','2025-09-03 04:30:30','Pendiente'),
(17,3,18,35,36,'Ana Fernández','ana@example.com','45678901','2025-09-03 04:30:53','Pendiente'),
(18,3,19,37,38,'Jorge Ramírez','jorge@example.com','56789012','2025-09-03 04:31:17','Pendiente'),
(19,3,20,39,40,'Carlos Lopez','carlos@example.com','12345678','2025-09-03 04:37:45','Pendiente'),
(20,3,21,41,42,'Luis Gómez','luis@example.com','23456789','2025-09-03 04:38:03','Pendiente'),
(21,3,22,43,44,'Ana Martínez','ana@example.com','34567891','2025-09-03 04:38:23','Pendiente'),
(22,3,23,45,46,'Pedro Sánchez','pedro@example.com','45678912','2025-09-03 04:38:46','Pendiente'),
(23,3,24,47,48,'Sofia Rivera','sofia@example.com','56789123','2025-09-03 04:39:14','Pendiente'),
(24,3,25,49,50,'Ana Pérez','ana@example.com','11111111','2025-09-03 04:50:31','Pendiente'),
(25,3,26,51,52,'Luis Gómez','luis@example.com','22222222','2025-09-03 04:53:40','Pendiente'),
(26,3,27,53,54,'María López','maria@example.com','33333333','2025-09-03 04:53:59','Pendiente'),
(27,3,28,55,56,'María López','maria@example.com','33333333','2025-09-03 04:54:01','Pendiente'),
(28,3,29,57,58,'Carlos Ruiz','carlos@example.com','44444444','2025-09-03 04:54:15','Pendiente'),
(29,3,30,59,60,'Sofía Herrera','sofia@example.com','55555555','2025-09-03 04:54:35','Pendiente'),
(30,3,31,61,62,'Pedro Martínez','pedro@example.com','66666666','2025-09-03 04:54:48','Pendiente'),
(31,3,32,63,64,'Laura Morales','laura@example.com','77777777','2025-09-03 04:55:05','Pendiente'),
(32,3,33,65,66,'Fernando Soto','fernando@example.com','88888888','2025-09-03 04:55:23','Pendiente'),
(33,3,34,67,68,'Ana Soto','ana@example.com','99999999','2025-09-03 04:55:41','Pendiente'),
(34,3,35,69,70,'Jorge Pérez','jorge@example.com','10101010','2025-09-03 04:55:57','Pendiente'),
(35,3,36,71,72,'Juan Pérez','juan@example.com','55551234','2025-09-03 05:05:43','Pendiente'),
(36,3,37,73,74,'Ana López','ana@example.com','55553456','2025-09-03 05:06:02','Pendiente'),
(37,3,38,75,76,'Carlos Ruiz','carlos@example.com','55555678','2025-09-03 05:06:24','Pendiente'),
(38,3,39,77,78,'Laura Gómez','laura@example.com','55557890','2025-09-03 05:06:42','Pendiente'),
(39,3,40,79,80,'Pedro Torres','pedro@example.com','55559012','2025-09-03 05:06:58','Pendiente'),
(40,3,41,81,82,'Sofía Medina','sofia@example.com','55550123','2025-09-03 05:07:17','Pendiente'),
(41,3,42,83,84,'Miguel Ángel','miguel@example.com','55551234','2025-09-03 05:07:30','Pendiente'),
(42,3,43,85,86,'Miguel Ángel','miguel@example.com','55551234','2025-09-03 05:07:41','Pendiente'),
(43,3,44,87,88,'Diana Castillo','diana@example.com','55552345','2025-09-03 05:07:57','Pendiente'),
(44,3,45,89,90,'Ricardo López','ricardo@example.com','55553456','2025-09-03 05:08:15','Pendiente'),
(45,3,46,91,92,'Elena Morales','elena@example.com','55554567','2025-09-03 05:08:33','Pendiente'),
(46,3,47,93,94,'Juan Perez','juan@example.com','55512345','2025-09-03 05:21:01','Pendiente'),
(47,3,48,95,96,'Ana Lopez','ana@example.com','55567890','2025-09-03 05:21:27','Pendiente'),
(48,3,49,97,98,'Carlos Ruiz','carlos@example.com','55511223','2025-09-03 05:21:49','Pendiente'),
(49,3,50,99,100,'Luisa Gomez','luisa@example.com','55533445','2025-09-03 05:22:10','Pendiente'),
(50,3,51,101,102,'Miguel Torres','miguel@example.com','55555667','2025-09-03 05:22:32','Pendiente'),
(51,3,52,103,104,'Sofia Ramirez','sofia@example.com','55577889','2025-09-03 05:22:58','Pendiente'),
(52,3,53,105,106,'Pedro Martinez','pedro@example.com','55599001','2025-09-03 05:23:18','Pendiente'),
(53,3,54,107,108,'Juan Perez','juan@example.com','5555-5555','2025-09-03 05:41:13','Pendiente'),
(54,3,55,109,110,'Ana Lopez','ana@example.com','5555-5556','2025-09-03 05:41:31','Pendiente'),
(55,3,56,111,112,'Carlos Ruiz','carlos@example.com','5555-5557','2025-09-03 05:41:49','Pendiente'),
(56,3,57,113,114,'Luis Gomez','luis@example.com','5555-5558','2025-09-03 05:42:07','Pendiente'),
(57,3,58,115,116,'Sofia Morales','sofia@example.com','5555-5559','2025-09-03 05:42:24','Pendiente'),
(58,3,60,119,120,'Cliente 2','cliente2@mail.com','55522222','2025-09-03 05:44:50','Pendiente'),
(59,3,61,121,122,'Cliente 3','cliente3@mail.com','55533333','2025-09-03 05:45:05','Pendiente'),
(60,3,64,127,128,'Cliente 5','cliente5@mail.com','55555555','2025-09-03 05:46:00','Pendiente'),
(61,3,66,131,132,'Juan Perez','juan@example.com','5555555','2025-09-03 05:54:29','Pendiente'),
(62,3,67,133,134,'Ana López','ana@example.com','5555556','2025-09-03 05:54:49','Pendiente'),
(63,3,68,135,136,'Carlos Méndez','carlos@example.com','5555557','2025-09-03 05:55:18','Pendiente'),
(64,3,69,137,138,'Lucía Hernández','lucia@example.com','5555558','2025-09-03 05:55:45','Pendiente'),
(65,3,70,139,140,'Miguel Torres','miguel@example.com','5555559','2025-09-03 05:56:13','Pendiente'),
(66,2,71,141,142,'Miguel Torres','miguel@example.com','5555559','2025-09-06 08:21:39','Pendiente'),
(67,3,72,143,144,'Miguel Torres','miguel@example.com','5555559','2025-09-10 22:31:45','Pendiente'),
(68,3,73,145,146,'Miguel Torres','miguel@example.com','5555559','2025-09-10 23:01:20','Pendiente'),
(69,3,74,147,148,'Ana López','ana.lopez@example.com','55551234','2025-09-10 23:03:54','Pendiente'),
(70,3,75,149,150,'Ana López','ana.lopez@example.com','55551234','2025-09-10 23:12:20','Pendiente'),
(71,3,81,161,162,'Pedro Perez','pedro@test.com','12345678','2025-09-11 03:00:29','Pendiente'),
(72,3,82,163,164,'Pedro Perez','pedro@test.com','12345678','2025-09-11 03:05:37','Pendiente'),
(73,3,84,167,168,'Ana Perez','ana@test.com','33445566','2025-09-11 03:06:18','Pendiente'),
(74,3,86,171,172,'Pedro Perez','pedro@test.com','12345678','2025-09-11 03:08:40','Pendiente'),
(75,3,87,173,174,'Sofia López','sofia@test.com','98765432','2025-09-11 03:09:02','Pendiente'),
(76,3,88,175,176,'Luis Martínez','luis@test.com','44445555','2025-09-11 03:09:35','Pendiente'),
(77,3,92,183,184,'Pedro Perez','pedro@test.com','12345678','2025-09-11 03:20:47','Pendiente'),
(78,3,93,185,186,'Pedro Perez','pedro@test.com','12345678','2025-09-11 03:22:23','Pendiente'),
(79,3,94,187,188,'Pedro Perez','pedro@test.com','12345678','2025-09-11 03:23:05','Pendiente'),
(80,3,96,189,190,'Pedro Perez','pedro@test.com','12345678','2025-09-11 04:23:58','Pendiente'),
(81,3,111,219,220,'Luis Fernández','luis.fernandez@test.com','50244556677','2025-09-11 04:42:31','Pendiente'),
(82,3,112,221,222,'Luis Fernández','luis.fernandez@test.com','50244556677','2025-09-11 04:53:21','Pendiente'),
(83,3,113,223,224,'Luis Fernández','luis.fernandez@test.com','50244556677','2025-09-11 07:31:13','Pendiente'),
(84,5,115,227,228,'Joab Mendez','joab@demomo.com','77556699','2025-09-13 07:50:34','Pendiente'),
(85,5,116,229,230,'Luis','luis@demo.com','88556600','2025-09-13 08:00:35','Pendiente'),
(86,5,117,231,232,'Luis','luis@demo.com','88556600','2025-09-13 08:00:39','Pendiente');
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repartidor_zona`
--

DROP TABLE IF EXISTS `repartidor_zona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `repartidor_zona` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_repartidor` int(11) NOT NULL,
  `municipio` varchar(255) NOT NULL,
  `zona` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_repartidor` (`id_repartidor`),
  CONSTRAINT `repartidor_zona_ibfk_1` FOREIGN KEY (`id_repartidor`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repartidor_zona`
--

LOCK TABLES `repartidor_zona` WRITE;
/*!40000 ALTER TABLE `repartidor_zona` DISABLE KEYS */;
INSERT INTO `repartidor_zona` VALUES
(4,9,'Guatemala','1'),
(5,10,'Guatemala','10'),
(6,11,'Guatemala','14'),
(7,8,'Mixco','1'),
(8,9,'Mixco','2'),
(9,10,'Mixco','3'),
(10,11,'Mixco','9'),
(11,12,'Mixco','11'),
(12,3,'San Miguel Petapa','1'),
(13,4,'San Miguel Petapa','2'),
(14,10,'Villa Nueva','1'),
(15,11,'Villa Nueva','3'),
(16,11,'San Jose Pinula','1'),
(17,14,'Fraijanes','1'),
(18,9,'Guatemala','1'),
(19,9,'Guatemala','2'),
(20,9,'Guatemala','3'),
(21,9,'Mixco','5'),
(22,9,'Mixco','7');
/*!40000 ALTER TABLE `repartidor_zona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES
(3,'Admin'),
(1,'Cliente'),
(2,'Repartidor');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracking_envio`
--

DROP TABLE IF EXISTS `tracking_envio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tracking_envio` (
  `id_tracking` int(11) NOT NULL AUTO_INCREMENT,
  `id_envio` int(11) NOT NULL,
  `latitud` decimal(10,7) NOT NULL,
  `longitud` decimal(10,7) NOT NULL,
  `fecha_hora` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_tracking`),
  KEY `id_envio` (`id_envio`),
  CONSTRAINT `tracking_envio_ibfk_1` FOREIGN KEY (`id_envio`) REFERENCES `envio` (`id_envio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracking_envio`
--

LOCK TABLES `tracking_envio` WRITE;
/*!40000 ALTER TABLE `tracking_envio` DISABLE KEYS */;
/*!40000 ALTER TABLE `tracking_envio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES
(2,'Joab Guzman','12345678','joab@example.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',3,1),
(3,'Grace Lara Mendez','12345678','grace@demo.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',1,1),
(4,'demo demoo','12345678','demo@demodemo.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',2,1),
(5,'Yulisa Mendez','11223344','yuli@demo.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',1,1),
(6,'Ginebra Mayo','77885566','ginebra@demo.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',1,0),
(7,'Luis Alfono','88556699','luis@demo.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',1,1),
(8,'asd','12312312','mate@demo.xyz','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',1,1),
(9,'Carlos Pérez','55550001','carlos.perez@example.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',2,1),
(10,'María Gómez','55550002','maria.gomez@example.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',2,1),
(11,'Jorge Ramírez','55550003','jorge.ramirez@example.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',2,1),
(12,'Ana López','55550004','ana.lopez@example.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',2,1),
(13,'Luis Torres','55550005','luis.torres@example.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',2,1),
(14,'Clara Martínez','55550006','clara.martinez@example.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',2,1),
(15,'Pedro Castillo','55550007','pedro.castillo@example.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',2,1),
(16,'Sofia Hernández','55550008','sofia.hernandez@example.com','$2b$10$hU09Vtz/hx3YS/Qssmf8u.ZOLnMb/56nNlAwCQVT.OnkfInsi4/W6',2,1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-13  3:48:27
