-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: localhost    Database: tiovibe
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.22.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `hosts_packages`
--

DROP TABLE IF EXISTS `hosts_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hosts_packages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `packages_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `price` int NOT NULL,
  `comission` int NOT NULL,
  `is_premium` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_packages`
--

LOCK TABLES `hosts_packages` WRITE;
/*!40000 ALTER TABLE `hosts_packages` DISABLE KEYS */;
INSERT INTO `hosts_packages` VALUES (1,'Free Host Plan',0,0,0),(2,'Premium Vibe Host Plan',499,12,1);
/*!40000 ALTER TABLE `hosts_packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(5) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'English','En'),(4,'Spanish','Es'),(5,'French','Fr'),(7,'Potuguse','Pr');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `languages` int NOT NULL,
  `services` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,1,1,1),(2,1,1,1);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `properties` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `longitude` float NOT NULL,
  `bedrooms` int NOT NULL,
  `washrooms` int NOT NULL,
  `wifi` tinyint(1) NOT NULL,
  `check_in` time NOT NULL,
  `check_out` time NOT NULL,
  `created_by_user` int NOT NULL,
  `night_rate` int NOT NULL,
  `pool` tinyint(1) NOT NULL,
  `laundary` tinyint(1) NOT NULL,
  `latitude` float NOT NULL,
  `created_at` datetime NOT NULL,
  `modified_at` datetime NOT NULL,
  `post_status` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `address` text COLLATE utf8mb4_general_ci NOT NULL,
  `contact` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `street` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `zipcode` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `pets` tinyint(1) NOT NULL,
  `tags` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `property_img` text COLLATE utf8mb4_general_ci NOT NULL,
  `booking_note` text COLLATE utf8mb4_general_ci NOT NULL,
  `booking_offset` int NOT NULL,
  `booking_window` int NOT NULL,
  `minimum_booking_duration` int NOT NULL,
  `maximum_booking_duration` int NOT NULL,
  `booking_import_url` text COLLATE utf8mb4_general_ci NOT NULL,
  `manual` tinyint(1) NOT NULL,
  `currency` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `continent` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `additional` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL DEFAULT '0',
  `is_pending` tinyint(1) NOT NULL DEFAULT '1',
  `property_doc` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `availibility_from` datetime DEFAULT NULL,
  `availibility_to` datetime DEFAULT NULL,
  `cleaning_charges` decimal(10,0) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `created_by_user` (`created_by_user`),
  CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`created_by_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=231 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES (1,'PC','Lahore',1.112,5,2,0,'12:00:00','11:59:00',4,1233,1,0,34.43,'2023-07-07 21:40:05','2023-07-07 21:40:05','0',0,'','','CA','','','','',0,'','hotel','/property/Screenshot (3).png','',0,0,0,0,'',0,'0','North America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(2,'like','New York,New York, United States',-73.9866,10,2,1,'00:00:00','00:00:00',4,21,1,0,40.7306,'2023-07-07 21:42:13','2023-07-07 21:42:13','0',0,'','','US','','','','',0,'','Rents','/property/Screenshot (12).png','',0,0,0,0,'',0,'0','North America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(3,'kito pka','Toronto,Ontario, Canada',-79.3839,40,5,1,'00:00:00','00:00:00',4,21,1,0,43.6535,'2023-07-07 21:44:25','2023-07-07 21:44:25','0',0,'','','CA','','','','',0,'','Appartments','/property/Screenshot (17).png','',0,0,0,0,'',0,'0','North America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(4,'asd asdasd','Lima, Ohio 45804, United States of America',-84.0275,60,10,1,'00:00:00','00:00:00',4,21,1,0,40.7115,'2023-07-07 21:52:47','2023-07-07 21:52:47','0',0,'','','US','','','','',0,'','House','/property/download (4).png','',0,0,0,0,'',0,'0','North America','adasd asd asd as d',NULL,1,0,NULL,NULL,NULL,NULL,12),(5,' asd xcz zxc','Belém,Pará, Brazil',-48.4682,10,4,1,'00:00:00','00:00:00',4,433,1,0,-1.45056,'2023-07-07 21:56:08','2023-07-07 21:56:08','0',0,'','','BR','','','','',0,'','Appartments','/property/Screenshot (14).png','',0,0,0,0,'',0,'0','South America','as zxc zx c  zxc  zZXC',NULL,1,0,NULL,NULL,NULL,NULL,12),(6,'xc s dcas dca','Caribbean Beach, Orlando, Florida 32836, United States of America',-81.5423,30,3,1,'00:00:00','00:00:00',4,21,1,0,28.3675,'2023-07-07 22:02:14','2023-07-07 22:02:14','0',0,'','','US','','','','',0,'','House','/property/Screenshot (21).png','',0,0,0,0,'',0,'0','North America','xzzc zxc sd f s fa',NULL,1,0,NULL,NULL,NULL,NULL,12),(7,'liokhtt','4812 E Busch Blvd Ste G, Tampa, Florida 33617, United States of America',-82.4072,10,4,1,'00:00:00','00:00:00',4,12,1,0,28.033,'2023-07-07 22:12:55','2023-07-07 22:12:55','0',0,'','','US','','','','',0,'','Rents','/property/screenshot (3).png where id=1','',0,0,0,0,'',0,'0','North America','s d asd  sdf asd fasd f',NULL,1,0,NULL,NULL,NULL,NULL,12),(8,'loksia','Ολυμπιάδα Χαλκιδικής 570 14, 570 14 Olympiada, Greece',23.7863,12,3,1,'00:00:00','00:00:00',4,22,1,0,40.5906,'2023-07-07 22:16:50','2023-07-07 22:16:50','0',1,'','','GR','','','','',0,'','House','/property/screenshot (3).png where id=1','',0,0,0,0,'',0,'0','Europe','write additional note',NULL,1,0,NULL,NULL,NULL,NULL,12),(9,'loseic','Caribbean Beach,0240, Hartebeespoort, North West, South Africa',27.8309,23,5,1,'00:00:00','00:00:00',4,12,1,0,-25.7483,'2023-07-07 23:26:58','2023-07-07 23:26:58','0',0,'','','ZA','','','','',0,'','House',',/property/download (10).jpg','',0,0,0,0,'',0,'0','Africa',' sd fa dasdas d asd as',NULL,1,0,NULL,NULL,NULL,NULL,12),(10,'powli','Caribbean Beach, Orlando, Florida 32836, United States of America',-81.5423,20,6,1,'00:00:00','00:00:00',4,56,1,0,28.3675,'2023-07-07 23:31:47','2023-07-07 23:31:47','0',0,'','','US','','','','',0,'','Appartments','/property/download (11).jpg','',0,0,0,0,'',0,'0','North America',' da fasd fas sd f asd a',NULL,1,0,NULL,NULL,NULL,NULL,12),(11,'xvvdfgdf','Sahiwal,Punjab, Pakistan',73.0941,10,3,1,'00:00:00','00:00:00',4,121,1,0,30.6438,'2023-07-10 20:17:35','2023-07-10 20:17:35','0',1,'','','PK','','','','',0,'','Rents','/property/download (8).jpg','',0,0,0,0,'',0,'0','Asia',' gdgsdgsd fgs dfgsdfg sdfg sdfg sdfg',NULL,1,0,NULL,NULL,NULL,NULL,12),(152,'Nice room','Cuzco, Cusco, Peru',-71.9785,0,0,0,'00:00:00','00:00:00',4,85,0,0,-13.5171,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/Screenshot_20230408_161947_Chrome-tumglt.jpg,/property/IMG-20230407-WA0004-dgl2un.jpg','',0,0,0,0,'',0,'','',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(153,'Visita Roma','Perugia, Italy',12.389,0,0,0,'00:00:00','00:00:00',4,45,0,0,43.112,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(154,'room in bogota test','Bogotá, Colombia',-74.0836,2,1,1,'00:00:00','00:00:00',4,50,0,0,4.65346,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/IMG-20230129-WA0007-q0f4w2.jpg','',0,0,0,0,'',0,'','',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(155,'Pieza en Atacama test','Atacama, Chile',-70.3323,1,1,1,'00:00:00','00:00:00',4,50,0,0,-27.3665,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/20230122_204858_0000-j0ubz0.png','',0,0,0,0,'',0,'','',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(156,'Mini Casa test','Viña del Mar, Valparaíso, Chile',-71.5518,2,1,1,'00:00:00','00:00:00',4,80,0,0,-33.0245,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/Screenshot_20230204_102314-dhbfsg.png','',0,0,0,0,'',0,'','',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(157,'La casa azul test','Lima, Lima Province, Peru',-77.0365,2,1,1,'00:00:00','00:00:00',4,60,0,0,-12.0621,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/Screenshot_20230424_130041_Chrome-qxpirt.jpg','',0,0,0,0,'',0,'','',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(158,'Ali\'s Apartment','France',2.61879,2,2,1,'00:00:00','00:00:00',4,50,0,0,47.8249,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/platform.png','',0,0,0,0,'',0,'','',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(159,'nice house in budapest','Budapest, Hungary',19.0404,1,1,0,'00:00:00','00:00:00',4,50,0,0,47.498,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/image-18.jpg','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(160,'Stylish place russia','Moscow, Russia',37.6175,1,1,0,'00:00:00','00:00:00',4,50,0,0,55.7504,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(161,'Pet friendly house in London','London, Greater London, England, United Kingdom',-0.127647,1,1,0,'00:00:00','00:00:00',4,135,0,0,51.5073,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/image-13.jpg','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(162,'dublin house close to pubs','Dublin, Ireland',-6.2603,1,1,0,'00:00:00','00:00:00',4,135,0,0,53.3498,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(163,'Modern stay in Iceland','Reykjavík, Capital Region, Iceland',-21.9436,1,1,0,'00:00:00','00:00:00',4,145,0,0,64.1458,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/image-12.jpg','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(164,'Modern seaside  in croatia','Zagreb, Croatia',15.5908,1,1,0,'00:00:00','00:00:00',4,145,0,0,45.7683,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(165,'house in helsinki','Helsinki, Uusimaa, Finland',24.9427,1,1,0,'00:00:00','00:00:00',4,80,0,0,60.1675,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/image-15.jpg','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(166,'house in belgium','Brussels-Capital, Belgium',4.3517,1,1,0,'00:00:00','00:00:00',4,80,0,0,50.8466,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(167,'house in istanbul','Istanbul, Türkiye',28.9662,1,1,0,'00:00:00','00:00:00',4,120,0,0,41.0092,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/image-19.jpg','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(168,'Fully furnished Apartment in Gijon','Gijón, Asturias, Spain',-5.66264,1,1,0,'00:00:00','00:00:00',4,120,0,0,43.545,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(169,'sweden house','Stockholm, Sweden',18.0711,3,2,0,'00:00:00','00:00:00',4,460,0,0,59.3251,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(170,'Cozy remodeled house zurich','Zürich, Switzerland',8.54104,2,1,0,'00:00:00','00:00:00',4,420,0,0,47.3745,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/image-6.jpg','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(171,'Cozy home in Berlin','Berlin, Germany',13.3889,2,1,0,'00:00:00','00:00:00',4,420,0,0,52.517,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(172,'Central and quiet Luxembourg','Luxembourg Airport, 4 Rue de Trèves, Findel, Luxembourg 1110, Luxembourg',6.21037,1,1,0,'00:00:00','00:00:00',4,50,0,0,49.629,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/image-7.jpg','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(173,'Central and quiet in Tirana','Tirana, Albania',19.8184,1,1,0,'00:00:00','00:00:00',4,50,0,0,41.3281,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(174,'Stunning seaside cottage Denmark','Copenhagen, Capital Region of Denmark, Denmark',12.5701,2,1,0,'00:00:00','00:00:00',4,350,0,0,55.6867,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/image-5.jpg','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(175,'Stunning place in Austria','Vienna, Austria',16.3725,2,1,0,'00:00:00','00:00:00',4,350,0,0,48.2084,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(176,'great house in cusco','Lima, Peru',-76.2851,2,2,0,'00:00:00','00:00:00',4,500,0,0,-12.2001,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/download-23-2.jpg,/property/IMG-20230129-WA0017-vqdoky.jpg','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(177,'Confy Apartment panama','Panama City, Panamá, Panama',-79.5342,2,1,1,'00:00:00','00:00:00',4,200,0,0,8.97145,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/CW-2-scaled-2.jpg,/property/IMG-20230129-WA0017-st8jpv.jpg','',0,0,0,0,'',0,'','Central America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(178,'Uruguay mansion','Acegua, Melo, Cerro Largo, Uruguay',-54.1628,10,8,1,'00:00:00','00:00:00',4,350,0,0,-31.8718,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/mansion-1.jpg,/property/20230121_120121-1dxx8l.jpg','',0,0,0,0,'',0,'','',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(179,'mansion in quito','Quito, Pichincha, Ecuador',-78.5123,2,2,1,'00:00:00','00:00:00',4,350,0,0,-0.220164,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/20230121_120121-uprgxs.jpg,/property/mansion.jpg','',0,0,0,0,'',0,'','',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(180,'mansion in la paz','La Paz, Bolivia',-68.1336,4,4,1,'00:00:00','00:00:00',4,350,0,0,-16.4955,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/mansion-2.jpg,/property/20230121_120121-pkz6w2.jpg','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(181,'Beautiful Rio','Rio de Janeiro, Rio de Janeiro, Brazil',-43.2094,2,2,1,'00:00:00','00:00:00',4,500,0,0,-22.911,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/20230121_120121-ytyc1f.jpg,/property/87239245_215896552883705_8953981185157963123_n_17896396357445625.jpg,/property/jhjk.jpg','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(182,'house in Whistler','Whistler, British Columbia, Canada',-122.954,0,0,1,'00:00:00','00:00:00',4,350,0,0,50.1172,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/mansion-4.jpg,/property/20230121_120121-kx9kyv.jpg','',0,0,1,5,'',0,'','North America',NULL,NULL,1,0,NULL,NULL,'2023-07-31 05:01:48','2023-08-10 05:01:48',12),(183,'House in Caracas','Caracas, Venezuela, Sucre, Miranda 10, Venezuela',-66.8101,3,2,1,'00:00:00','00:00:00',4,120,0,0,10.497,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/mansion-6.jpg,/property/mansion-tcvkev.jpg,/property/IMG-20230129-WA0007-utqq0b.jpg','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(184,'house in belize','Belize City Centre, Belize City, Belize, Belize',-88.1877,1,1,0,'00:00:00','00:00:00',4,450,0,0,17.4987,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/20230121_120121-wz09cp.jpg','',0,0,0,0,'',0,'','Central America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(185,'nice apartment Cartagena','Medellín, Antioquia, Colombia',-75.5736,0,0,1,'00:00:00','00:00:00',4,200,0,0,6.24434,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/20230121_120121-p7l57e.jpg','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(186,'Santorini Home','Santorini National Airport, Μονόλιθος, Santorini, South Aegean 847 00, Greece',25.4763,0,0,1,'00:00:00','00:00:00',4,250,0,0,36.401,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/20230121_120121-c3w9al.jpg','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(187,'house Managua','Granada, Nicaragua',-85.9536,1,1,0,'00:00:00','00:00:00',4,35,0,0,11.9304,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/mansion-jlcrop.jpg,/property/cd0b7e79983d61bd3701702157fc76f7.jpg,/property/R-2.jpg','',0,0,0,0,'',0,'','Central America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(188,'Enjoy Guyana','Georgetown, Demerara-Mahaica, Guyana',-58.1624,0,0,0,'00:00:00','00:00:00',4,45,0,0,6.81374,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/mansion-oy9tdl.jpg','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(189,'Nice House in Florida','Florida, United States',-82.0336,0,0,0,'00:00:00','00:00:00',4,95,0,0,28.9445,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/download-23.jpg','',0,0,0,0,'',0,'','North America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(190,'mendoza mansion','Mendoza, Argentina',-68.8446,6,5,1,'00:00:00','00:00:00',4,350,0,0,-32.8894,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/mansion-1.jpg,/property/20230121_120121-a77ksb.jpg','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(191,'house in Honduras','Choluteca, Choluteca, Honduras',-87.1846,0,0,0,'00:00:00','00:00:00',4,300,0,0,13.3005,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','Central America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(192,'White house in chile','Providencia, Santiago Metropolitan Region, Chile',-70.6095,2,2,1,'00:00:00','00:00:00',4,250,0,0,-33.4322,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/20230103_153833.jpg,/property/Screenshot_20230209_141842-t2vujw.jpg','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(193,'Disfruta Quito','Quito, Pichincha, Ecuador',-78.5123,0,0,0,'00:00:00','00:00:00',4,56,0,0,-0.220164,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(194,'Tiny house in Limon','Limón, Limón, Costa Rica',-83.0294,0,0,0,'00:00:00','00:00:00',4,64,0,0,9.99524,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','Central America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(195,'Enjoy Guatemala','Cobán, Alta Verapaz, Guatemala',-90.3735,0,0,0,'00:00:00','00:00:00',4,96,0,0,15.4702,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','Central America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(196,'Relax in El Salvador','Usulután, Usulután, El Salvador',-88.4382,1,1,1,'00:00:00','00:00:00',4,80,0,0,13.3438,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/R.jpg,/property/R-1.jpg','',0,0,0,0,'',0,'','Central America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(197,'Montevideo fun','Montevideo, Montevideo, Uruguay',-56.1913,0,0,0,'00:00:00','00:00:00',4,75,0,0,-34.9059,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(198,'Discover Tulum','Tulum, Quintana Roo, Mexico',-87.4628,3,2,1,'00:00:00','00:00:00',4,45,0,0,20.2112,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/j.jpg,/property/jhjk.jpg','',0,0,4,15,'',0,'','North America',NULL,NULL,1,0,NULL,NULL,'2023-07-21 05:01:48','2023-08-28 05:01:48',12),(199,'Varadero','Varadero, Cárdenas, Matanzas, Cuba',-81.2628,0,0,0,'00:00:00','00:00:00',4,35,0,0,23.1494,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','caribbean',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(200,'Enjoy San Juan','San Juan, Puerto Rico',-66.1167,0,0,0,'00:00:00','00:00:00',4,50,0,0,18.4653,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','caribbean',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(201,'The magic of Paris','Paris, France',2.34839,0,0,0,'00:00:00','00:00:00',4,120,0,0,48.8535,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(202,'Beautiful Roma','Rome, Rome, Italy',12.4829,0,0,0,'00:00:00','00:00:00',4,80,0,0,41.8933,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','Europe',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(203,'Emjoy Asuncion','Asunción, Paraguay',-57.6344,0,0,0,'00:00:00','00:00:00',4,45,0,0,-25.28,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(204,'Paradise in Barbados','Oistins, Christ Church, Barbados',-59.5322,0,0,0,'00:00:00','00:00:00',4,80,0,0,13.0623,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','caribbean',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(205,'Confy apartment in Jamaica','Kingston, Saint Andrew, Jamaica',-76.8027,0,0,0,'00:00:00','00:00:00',4,100,0,0,18.0176,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','caribbean',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(206,'Relax in Bahamas','Bahamas Harvest Church, Nassau, New Providence, The Bahamas',-77.2899,0,0,0,'00:00:00','00:00:00',4,150,0,0,25.0384,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','caribbean',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(207,'Punta Cana','Punta Cana, La Altagracia, Dominican Republic',-68.3681,0,0,0,'00:00:00','00:00:00',4,50,0,0,18.5583,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','caribbean',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(208,'Enjoy Aruba','Noord, Aruba',-70.0319,2,1,1,'00:00:00','00:00:00',4,200,0,0,12.5645,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/kkl.jpg,/property/CN-tower-test-image.jpg','',0,0,0,0,'',0,'','caribbean',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(209,'Discover Haiti','Limbé, Nord, Haiti',-72.4029,0,0,0,'00:00:00','00:00:00',4,45,0,0,19.7064,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','caribbean',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(210,'Vacation in Saint Lucia','Castries, Castries, Saint Lucia',-60.9902,0,0,0,'00:00:00','00:00:00',4,300,0,0,14.0096,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','caribbean',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(211,'Enjoy Trinidad y Tobago','Arima, Arima, Trinidad and Tobago',-61.283,0,0,0,'00:00:00','00:00:00',4,250,0,0,10.6372,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','caribbean',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(212,'Luxury Antigua And Barbuda','Codrington, Barbuda, Antigua and Barbuda',-61.819,0,0,0,'00:00:00','00:00:00',4,300,0,0,17.6434,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','caribbean',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(213,'Beautiful Dominica','Berekua, Saint Patrick, Dominica',-61.3153,0,0,0,'00:00:00','00:00:00',4,150,0,0,15.2399,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','caribbean',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(214,'Turks and caicos beaches','North Caicos, Turks and Caicos Islands',-72.0224,0,0,0,'00:00:00','00:00:00',4,200,0,0,21.89,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','','',0,0,0,0,'',0,'','caribbean',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(215,'New home','Santiago, Santiago Metropolitan Region, Chile',-70.6505,0,0,0,'00:00:00','00:00:00',4,120,0,0,-33.4378,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/Screenshot_20230407_132029_Chrome-mzqhew.jpg','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(216,'Linda casita','Mendoza, Argentina',-68.8446,0,0,0,'00:00:00','00:00:00',4,150,0,0,-32.8894,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/Screenshot_20230407_143616_Chrome-wco56e.jpg,/property/Screenshot_20230407_143616_Chrome-badbmj.jpg','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(217,'Mini home','Rio de Janeiro, Rio de Janeiro, Brazil',-43.2094,2,1,0,'00:00:00','00:00:00',4,95,0,0,-22.911,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/IMG-20230407-WA0004-vmjglt.jpg,/property/Screenshot_20230118_074049.png','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(218,'Linda habitacion en santiago test','Santiago, Santiago Metropolitan Region, Chile',-70.6505,1,1,1,'00:00:00','00:00:00',4,40,0,0,-33.4378,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/Screenshot_20230409_172840_PracticaTest-2rqava.jpg','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(219,'Casa de playa test','Viña del Mar, Valparaíso, Chile',-71.5518,2,1,1,'00:00:00','00:00:00',4,60,0,0,-33.0245,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/Screenshot_20230408_120431_Chrome-yzoqle.jpg','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(220,'Beauty house test','Edmonton, Alberta, Canada',-113.508,2,2,1,'00:00:00','00:00:00',4,150,0,0,53.5354,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/Screenshot_20230410_193204-pqeeuj.jpg','',0,0,0,0,'',0,'','North America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(221,'Home in Renaca chile test','Valparaíso, Chile',-71.6197,2,2,0,'00:00:00','00:00:00',4,200,0,0,-33.0458,'2023-07-20 00:00:00','2023-07-20 00:00:00','',1,'','','','','','','',0,'','','/property/Screenshot_20230424_234255.jpg','',0,0,0,0,'',0,'','South America',NULL,NULL,1,0,NULL,NULL,NULL,NULL,12),(222,' x sx as a sx asxax','Grand Trunk Road, Amritsar, 143108, India',74.5762,10,2,1,'07:36:00','09:25:00',4,253,1,0,31.6045,'2023-07-25 23:37:26','2023-07-25 23:37:26','0',1,'','','IN','','','','',0,'','Appartments','','',0,0,0,0,'',0,'0','Asia','jkjsdkjfaskj aks d kdaksda',NULL,0,1,'','',NULL,NULL,12),(223,'kjdadkajsnd','94390 Paray-Vieille-Poste, France',2.3677,10,3,1,'16:20:00','15:15:00',4,3649,1,0,48.7279,'2023-07-30 21:10:38','2023-07-30 21:10:38','0',1,'','','FR','','','','',0,'','Room','','3',1,0,1,1100,'',0,'0','Europe','no desdiana asdjadj kaasdk verih ',NULL,1,0,'','','2023-08-01 00:00:00','2025-08-31 00:00:00',90),(224,'asasc','Ukhta, 169302, Russia',53.8052,20,5,1,'06:25:00','11:55:00',4,321,1,0,63.5556,'2023-07-30 21:18:49','2023-07-30 21:18:49','0',1,'','','RU','','','','',0,'','Houses','','3',4,0,1,1200,'',0,'0','Europe','3f qwefqwef wefewfq wefwef',NULL,0,1,'','','2023-08-01 00:00:00','2024-08-02 00:00:00',45),(225,'asasc','Ukhta, 169302, Russia',53.8052,20,5,1,'06:25:00','11:55:00',4,321,1,0,63.5556,'2023-07-30 21:21:28','2023-07-30 21:21:28','0',1,'','','RU','','','','',0,'','Houses','','3',4,0,1,1200,'',0,'0','Europe','3f qwefqwef wefewfq wefwef',NULL,0,1,'','','2023-08-01 00:00:00','2024-08-02 00:00:00',45),(226,'asasc','Ukhta, 169302, Russia',53.8052,20,5,1,'06:25:00','11:55:00',4,321,1,0,63.5556,'2023-07-30 21:22:19','2023-07-30 21:22:19','0',1,'','','RU','','','','',0,'','Houses','','3',4,0,1,1200,'',0,'0','Europe','3f qwefqwef wefewfq wefwef',NULL,0,1,'','','2023-08-01 00:00:00','2024-08-02 00:00:00',45),(227,'asasc','Ukhta, 169302, Russia',53.8052,20,5,1,'06:25:00','11:55:00',4,321,1,0,63.5556,'2023-07-30 21:25:13','2023-07-30 21:25:13','0',1,'','','RU','','','','',0,'','Houses','','3',4,0,1,1200,'',0,'0','Europe','3f qwefqwef wefewfq wefwef',NULL,0,1,'','','2023-08-01 00:00:00','2024-08-02 00:00:00',45),(228,'asasc','Ukhta, 169302, Russia',53.8052,20,5,1,'06:25:00','11:55:00',4,321,1,0,63.5556,'2023-07-30 21:26:55','2023-07-30 21:26:55','0',1,'','','RU','','','','',0,'','Houses','','3',4,0,1,1200,'',0,'0','Europe','3f qwefqwef wefewfq wefwef',NULL,0,1,'','','2023-08-01 00:00:00','2024-08-02 00:00:00',45),(229,'asasc','Ukhta, 169302, Russia',53.8052,20,5,1,'06:25:00','11:55:00',4,321,1,0,63.5556,'2023-07-30 21:29:07','2023-07-30 21:29:07','0',1,'','','RU','','','','',0,'','Houses','','3',4,0,1,1200,'',0,'0','Europe','3f qwefqwef wefewfq wefwef',NULL,0,1,'','','2023-08-01 00:00:00','2024-08-02 00:00:00',45),(230,'asasc','Ukhta, 169302, Russia',53.8052,20,5,1,'06:25:00','11:55:00',4,321,1,0,63.5556,'2023-07-30 21:31:19','2023-07-30 21:31:19','0',1,'','','RU','','','','',0,'','Houses','/property/download (7).jpg,/property/download (8).jpg,/property/download (9).jpg,/property/download (10).jpg,/property/download (11).jpg','3',4,0,1,1200,'',0,'0','Europe','3f qwefqwef wefewfq wefwef',NULL,1,0,'','','2023-08-01 00:00:00','2024-08-02 00:00:00',45);
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_booking`
--

DROP TABLE IF EXISTS `property_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_booking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `property_id` int NOT NULL,
  `booked_by_user_id` int NOT NULL,
  `booked_from_date` date DEFAULT NULL,
  `booked_to_date` date DEFAULT NULL,
  `is_cancelled` tinyint(1) DEFAULT '0',
  `is_confirmed` tinyint(1) DEFAULT '0',
  `booked_at` datetime DEFAULT NULL,
  `is_manual` tinyint(1) DEFAULT '0',
  `is_booked` int NOT NULL DEFAULT '1',
  `quantity` int DEFAULT NULL,
  `service_fee` decimal(10,0) DEFAULT NULL,
  `cleaning_charges` decimal(10,0) DEFAULT NULL,
  `property_cost` decimal(10,0) DEFAULT NULL,
  `total_property_cost` decimal(10,0) DEFAULT NULL,
  `commission` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `property_id` (`property_id`),
  KEY `booked_by_user_id` (`booked_by_user_id`),
  CONSTRAINT `property_booking_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`),
  CONSTRAINT `property_booking_ibfk_2` FOREIGN KEY (`booked_by_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_booking`
--

LOCK TABLES `property_booking` WRITE;
/*!40000 ALTER TABLE `property_booking` DISABLE KEYS */;
INSERT INTO `property_booking` VALUES (6,4,4,'2023-07-21',NULL,0,0,'2023-07-18 22:37:11',0,1,NULL,NULL,NULL,NULL,NULL,NULL),(7,4,4,'2023-07-21',NULL,0,0,'2023-07-18 22:40:47',0,1,NULL,NULL,NULL,NULL,NULL,NULL),(8,4,4,'2023-07-21','2023-07-29',0,0,'2023-07-18 22:42:05',0,1,NULL,NULL,NULL,NULL,NULL,NULL),(9,4,4,'2023-07-21','2023-07-29',0,0,'2023-07-18 22:44:34',0,1,NULL,NULL,NULL,NULL,NULL,NULL),(10,4,4,'2023-07-21','2023-07-29',0,0,'2023-07-18 22:44:58',0,1,NULL,NULL,NULL,NULL,NULL,NULL),(11,4,4,'2023-07-21','2023-07-28',0,0,'2023-07-18 22:45:54',0,1,NULL,NULL,NULL,NULL,NULL,NULL),(12,4,4,'2023-07-21','2023-07-28',0,0,'2023-07-18 22:47:55',0,1,NULL,NULL,NULL,NULL,NULL,NULL),(13,6,4,'2023-07-19','2023-07-28',0,0,'2023-07-18 22:50:21',0,1,NULL,NULL,NULL,NULL,NULL,NULL),(14,4,4,'2023-07-19','2023-07-19',0,0,'2023-07-19 01:06:40',0,1,NULL,NULL,NULL,NULL,NULL,NULL),(15,1,4,'2023-07-19','2023-07-19',0,0,'2023-07-19 01:06:40',0,1,NULL,NULL,NULL,NULL,NULL,NULL),(16,182,4,'2023-07-31','2023-08-04',0,0,'2023-07-30 15:43:19',0,1,4,28,12,350,1440,NULL),(17,182,4,'2023-07-31','2023-08-04',0,0,'2023-07-30 15:43:52',0,1,4,28,12,350,1440,NULL);
/*!40000 ALTER TABLE `property_booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_comment`
--

DROP TABLE IF EXISTS `property_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment` text COLLATE utf8mb4_general_ci NOT NULL,
  `rating` int NOT NULL,
  `created_by` int NOT NULL,
  `post_id` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `property_comment_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `property_comment_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `properties` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_comment`
--

LOCK TABLES `property_comment` WRITE;
/*!40000 ALTER TABLE `property_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `property_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_images`
--

DROP TABLE IF EXISTS `property_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `property_id` int NOT NULL,
  `property_img` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_images`
--

LOCK TABLES `property_images` WRITE;
/*!40000 ALTER TABLE `property_images` DISABLE KEYS */;
INSERT INTO `property_images` VALUES (1,9,'Screenshot (3).png'),(2,9,'Screenshot (12).png'),(3,9,'Screenshot (14).png'),(4,10,'./public/data/property/Screenshot (3).png'),(5,10,'./public/data/property/Screenshot (12).png'),(6,10,'./public/data/property/Screenshot (14).png');
/*!40000 ALTER TABLE `property_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_pics`
--

DROP TABLE IF EXISTS `property_pics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_pics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `pic_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `property_pics_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `properties` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_pics`
--

LOCK TABLES `property_pics` WRITE;
/*!40000 ALTER TABLE `property_pics` DISABLE KEYS */;
/*!40000 ALTER TABLE `property_pics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_reviews`
--

DROP TABLE IF EXISTS `property_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `property_id` int NOT NULL,
  `user_id` int NOT NULL,
  `comment` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `rating` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_reviews`
--

LOCK TABLES `property_reviews` WRITE;
/*!40000 ALTER TABLE `property_reviews` DISABLE KEYS */;
INSERT INTO `property_reviews` VALUES (1,1,4,'Very good property.',NULL,NULL,1,NULL),(2,182,4,'Good experience',NULL,NULL,1,4),(3,230,4,'having good experiencw',NULL,NULL,1,5),(4,182,39,'like',NULL,NULL,1,5),(5,189,39,'nyc ',NULL,NULL,1,5);
/*!40000 ALTER TABLE `property_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `service_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Experience'),(2,'Rent'),(3,'Transport'),(4,'Transport');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_attachments`
--

DROP TABLE IF EXISTS `user_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_attachments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profile_image` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `profile_doc` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_attachments`
--

LOCK TABLES `user_attachments` WRITE;
/*!40000 ALTER TABLE `user_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_favourite_property`
--

DROP TABLE IF EXISTS `user_favourite_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_favourite_property` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `property_id` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `modified_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `property_id` (`property_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_favourite_property_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`),
  CONSTRAINT `user_favourite_property_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_favourite_property`
--

LOCK TABLES `user_favourite_property` WRITE;
/*!40000 ALTER TABLE `user_favourite_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_favourite_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_languages`
--

DROP TABLE IF EXISTS `user_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `language_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `language_id` (`language_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_languages_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`),
  CONSTRAINT `user_languages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_languages`
--

LOCK TABLES `user_languages` WRITE;
/*!40000 ALTER TABLE `user_languages` DISABLE KEYS */;
INSERT INTO `user_languages` VALUES (20,1,1),(21,1,4),(74,20,1),(75,20,4),(76,25,1),(77,25,4),(78,25,5),(79,25,7),(114,4,1),(115,4,4),(116,4,5),(117,4,7),(118,39,1),(119,39,4),(120,39,5),(121,39,7);
/*!40000 ALTER TABLE `user_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_packages`
--

DROP TABLE IF EXISTS `user_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_packages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `package_id` int NOT NULL,
  `user_id` int NOT NULL,
  `is_active` int DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `package_id` (`package_id`),
  CONSTRAINT `user_packages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_packages_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `hosts_packages` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_packages`
--

LOCK TABLES `user_packages` WRITE;
/*!40000 ALTER TABLE `user_packages` DISABLE KEYS */;
INSERT INTO `user_packages` VALUES (1,2,4,1,NULL,NULL),(2,2,4,1,NULL,NULL);
/*!40000 ALTER TABLE `user_packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_properties`
--

DROP TABLE IF EXISTS `user_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_properties` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `property_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `service_fee` decimal(10,0) DEFAULT NULL,
  `cleaning_charges` decimal(10,0) DEFAULT NULL,
  `property_cost` decimal(10,0) DEFAULT NULL,
  `total_property_cost` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `property_id` (`property_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_properties`
--

LOCK TABLES `user_properties` WRITE;
/*!40000 ALTER TABLE `user_properties` DISABLE KEYS */;
INSERT INTO `user_properties` VALUES (1,4,1,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_services`
--

DROP TABLE IF EXISTS `user_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `service_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `service_id` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_services`
--

LOCK TABLES `user_services` WRITE;
/*!40000 ALTER TABLE `user_services` DISABLE KEYS */;
INSERT INTO `user_services` VALUES (21,1,1),(22,2,1),(69,1,20),(70,2,20),(71,1,25),(72,2,25),(73,3,25),(100,1,4),(101,2,4),(102,3,4),(103,4,4),(104,1,39),(105,2,39),(106,3,39);
/*!40000 ALTER TABLE `user_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `phone_number` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `verification_token` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `reset_password_token` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `profile_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `profile_pic` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `identification_doc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_visitor` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin1','admin1@gmail.com',1,0,0,NULL,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImNzLm11aGFtbWFkYWRuYW5AZ21haWwuY29tIiwiaWF0IjoxNjg2NTA4NzIwfQ.1fdVSxVfor_yKmCb3V6aMaMPji0kdDbf8AlyC60MeHg',0,'$2a$10$4f34CDjJcSOFlIyrH8pdauvkT73BM43p.aq065p8nGlt9JokGPOy.','2023-06-11 23:38:40','2023-07-24 18:16:41','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImNzLm11aGFtbWFkYWRuYW5AZ21haWwuY29tIiwiaWF0IjoxNjg3Mjk2NTM0LCJleHAiOjE2ODcyOTY4MzR9.F0DEcpzW_TRZJ1Zi02V3L9IHdayyuaO3Iux01sEVviM','','','','','WhatsApp Image 2023-01-09 at 21.46.59.jpg','',0),(4,'admin','admin@gmail.com',1,0,1,'1234567890','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFzZGZAZ21haWwuY29tIiwiaWF0IjoxNjg4MTA3ODQ4fQ.EmAUai41b_-SMKdkqIrdXpRRCLSO3aVlsxSe_EtoN_s',0,'$2a$10$K6MCn1EWB8ipo.WkYHxRN.UZe1pr8m60QAjdesNdfSSmXoWo74J0y','2023-06-30 11:50:48','2023-08-01 20:39:25',NULL,'imran','ali','','-1','/profile_pic/download (1).jpg','/profile_pic/download (7).jpg',0),(5,'sdasdas','adaasdfasd@gmail.com',1,0,0,'54654654','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkYWFzZGZhc2RAZ21haWwuY29tIiwiaWF0IjoxNjg5NzkxOTc3fQ.aR0mnDBA1wOpcqR0X9u_iA3aXNvu4HbaB2w9rlUqbNo',0,'$2a$10$IVv6UClZNg1rI2/llmZPIe39ovB/HoL3KbM9TCHA5xa29ODhSQMGO','2023-07-19 18:39:37',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(7,'sda12sdas','adaasdfaasdasdsd@gmail.com',1,0,0,'5465124','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkYWFzZGZhYXNkYXNkc2RAZ21haWwuY29tIiwiaWF0IjoxNjg5NzkyNDAzfQ.stPnoSAZBGbqZ9L1ZWwjZe9PrUqFTz6NHuVxX_KTsdM',0,'$2a$10$nSzRA9lRUKtQiMhRNQpLCO6NqUssPhm/WeKkUIcgCFGuyOc56SusW','2023-07-19 18:46:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(9,'asdasd','riotweirweoriu@gmail.com',1,0,0,'128312312','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJpb3R3ZWlyd2Vvcml1QGdtYWlsLmNvbSIsImlhdCI6MTY4OTc5Mjc2OH0.G_BjDoL-lYMFYK9MM70wTEwdZFHqh9KJY3kdkdgjwaw',0,'$2a$10$0smopkNy.C37NwxfntIie.L3WS1Uj87TCfwTxCGAnwdqedDYWU3/i','2023-07-19 18:52:49',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(11,'asdasda','sdafsdfsdf@gmail.com',1,0,0,'112423123','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNkYWZzZGZzZGZAZ21haWwuY29tIiwiaWF0IjoxNjg5NzkyOTgxfQ.qUQs1diXTtQf_9NV1bv9zEiow3kijLRgba03zMPKurQ',0,'$2a$10$pYLQXZJP0D2LjAFQaQOkP.npx9SZZWzgX8J0agk0HTZ0OAAgeKHDW','2023-07-19 18:56:21',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(13,'zczcz','addfalsdjnfasldkn@gmail.com',1,0,0,'123412341','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkZGZhbHNkam5mYXNsZGtuQGdtYWlsLmNvbSIsImlhdCI6MTY4OTc5MzExNn0.zMo85IaMEKZ_MmqG0gQuFP0HcISSRbjuAUyswgcWhjg',0,'$2a$10$yA/1WBSWQ8Wsm3/qk2R1L.JcCuvIRSxA4mxaurPPM630eYNypelKC','2023-07-19 18:58:36',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(15,'zxvcxcvzcxv','sdcxcz@gmail.com',1,0,0,'23432142','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNkY3hjekBnbWFpbC5jb20iLCJpYXQiOjE2ODk3OTM1MTl9.40k3m-egqjll_bDv9aLd76AycNlkuWExFU5TA-fjYg4',0,'$2a$10$dN80gPd5VlSrUb7iGdeoyeA5.1xYsyc.O2VeJPQz48TNCLb3d1ogC','2023-07-19 19:05:20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(17,'zxvcxcvczcxv','sdccxcz@gmail.com',1,0,0,'234322142','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNkY2N4Y3pAZ21haWwuY29tIiwiaWF0IjoxNjg5NzkzNTg3fQ._Lfdj5sv8t2Ps877TIJou5aNCVK4xBp2HbFkjGWx8XE',0,'$2a$10$yCmZnNYhEDHuht0OZjZ99ebfSFOyFt97rKh4iYm5NZx.p0xKOC8au','2023-07-19 19:06:27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(19,'ydxxydrf','gfcuv@gmail.com',1,0,0,'1234569877','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImdmY3V2QGdtYWlsLmNvbSIsImlhdCI6MTY4OTg3NzY2N30.a0Y9CezvXsO_6w6ZJlOxjaaG3vaYC_ZKQ18OUNKY8Ys',0,'$2a$10$vkpGdQpPrRcs5GWq/l.t2.1wtUs4gGPKo0sIXoI3S0NHhrXyytsOm','2023-07-20 18:27:47',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(20,'arslan','arslanqurashi222@gmail.com',1,0,0,'223423423','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFyc2xhbnF1cmFzaGkyMjJAZ21haWwuY29tIiwiaWF0IjoxNjg5ODgxOTUxfQ.ruXhyErW8epAmz_hdmkZshrBRPKlIvAGhY6kOpn6kJU',0,'$2a$10$/e.abPC25Z3VEEIoMNKAX.0HtCzYX4tOYqLEbClNX0gYOFG19Aj2a','2023-07-20 19:39:11','2023-07-20 19:41:58',NULL,'arslan','test',NULL,'Pakistan','./public/data/profile_pic/oeoozh57-n9b5o5vrzbj6u5avwyjs89g9.jpg','./public/data/profile_pic/oeoozh57-n9b5o5vrzbj6u5avwyjs89g9.jpg',0),(23,'arslan222','dexter8969@gmail.com',1,0,0,'223423421','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImRleHRlcjg5NjlAZ21haWwuY29tIiwiaWF0IjoxNjg5ODgyMDU3fQ.l_juf2WsdwaMv5qsl2kx6ISQ1ZIi_SgnvcJvUhZvXAM',0,'$2a$10$Ed8SuRqdSkTpMbScm7S3IOug7x67cdPM7apcDstUL0Adq2SvxbEgq','2023-07-20 19:40:58',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(25,'pok','ahassan@ibl.mx',1,0,0,'463453465','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFoYXNzYW5AaWJsLm14IiwiaWF0IjoxNjg5ODg1MDQ1fQ.yn1mhSv_iykKdAdYvAJjn49QN8lvfZDWvQoF0loXjOU',0,'$2a$10$CzWe1QYoKKjp1bhGwYO7duTOIiUjwMR/NHQF74rjE8FPF2hSsLhdC','2023-07-20 20:30:46','2023-07-20 20:32:23',NULL,'hasaan','ali',NULL,'Pakistan','./public/data/profile_pic/download (1).jpg','./public/data/profile_pic/download (8).jpg',0),(32,'ahassam120','sherazhassan@cybernef.in',1,0,1,'03244292008','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNoZXJhemhhc3NhbkBjeWJlcm5lZi5pbiIsImlhdCI6MTY5MDI0MjMwNn0.INr0cOuBOcwC_r5Y0-yflnT2WFsl-spHksTqmiEGTtQ',0,'$2a$10$ix1w4FYwsQYTEQ81XeJdt.AKDzasjMU.K/TR3cTlONoZjQJSjehqu','2023-07-24 23:45:07','2023-07-27 23:07:57',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(33,'qwerty','qwert@qwerty.com',1,0,0,'+923151234567','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InF3ZXJ0QHF3ZXJ0eS5jb20iLCJpYXQiOjE2OTAyNDIzNzV9.HrYnWUwmka77DNAGR9cSK5VkXa1PSRBQfjcbSQhkl8c',0,'$2a$10$whVsajx8zk.lVuaeH3yzR.WIVIN3wrmn/0P9JYe.41TGeCP5sH7A2','2023-07-24 23:46:15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(37,'daasd','csmohsinzulfiqar@gmail.com',1,0,1,'+923365070009','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImNzbW9oc2luenVsZmlxYXJAZ21haWwuY29tIiwiaWF0IjoxNjkwMzMzNTg2fQ.n-PCT7Wlke2J8vMS5o2dHdB1qNcXzYqXzfo_uEWETPY',0,'$2a$10$nz1MkR8g3C3EAhAKxNCvG.qx7awJ0iSXpiXQa3UxmXjRCGlSNHzWe','2023-07-26 01:06:27','2023-07-26 01:29:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(38,'mohsin70009@gmail.com','mohsin70009@gmail.com',1,0,1,NULL,'',0,'','2023-07-31 00:34:23',NULL,NULL,'M','Mohsin',NULL,NULL,'https://lh3.googleusercontent.com/a/AAcHTtc_aAgbPAs7mrJovGIf64_HdXoR5eiB9bRmqZIY8JY=s96-c',NULL,0),(39,'poul','pojagin948@kkoup.com',1,0,1,'+92 968-85655','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBvamFnaW45NDhAa2tvdXAuY29tIiwiaWF0IjoxNjkwODE4MzkzfQ.PdyQXu_RIavdbDFen0K54CCAyC5hYXmkUiO3V6kVOZg',0,'$2a$10$dhfTqhYQM4hIuTvLlolKRObEBWKiXRFIcpbHmE4t3Yuk/AbwUvss.','2023-07-31 15:46:33','2023-07-31 15:47:12',NULL,'iaol','kjan',NULL,'Palestine','/profile_pic/Article (1).png','/profile_pic/Article (1).png',0),(40,'siltesodru@gufum.com','siltesodru@gufum.com',1,0,1,'+923244292008','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNpbHRlc29kcnVAZ3VmdW0uY29tIiwiaWF0IjoxNjkwOTIzMTkyfQ.i3dRyQIPGC0lQ_orFIIAoCkNX_SlFAX3SpaPy-N6J8M',0,'$2a$10$IfOxRSZvFs5Sr6PEMJ4AduYEK5goRquzVRnm/lR3qXBNvR3BZpid.','2023-08-01 20:53:13','2023-08-01 20:53:39',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-02 21:20:03
