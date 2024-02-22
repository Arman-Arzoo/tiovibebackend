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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_packages`
--

LOCK TABLES `hosts_packages` WRITE;
/*!40000 ALTER TABLE `hosts_packages` DISABLE KEYS */;
INSERT INTO `hosts_packages` VALUES (1,'Free Host Plan',0,13),(2,'Premium Vibe Host Plan',499,0);
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
  PRIMARY KEY (`id`),
  KEY `created_by_user` (`created_by_user`),
  CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`created_by_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES (1,'PC','Lahore',1.112,5,2,0,'12:00:00','11:59:00',4,1233,1,0,34.43,'2023-07-07 21:40:05','2023-07-07 21:40:05','0',1,'','','CA','','','','',0,'','hotel','/property/Screenshot (3).png','',0,0,0,0,'',0,'0','North America',NULL,NULL,0,1),(2,'like','New York,New York, United States',-73.9866,10,2,1,'00:00:00','00:00:00',4,21,1,0,40.7306,'2023-07-07 21:42:13','2023-07-07 21:42:13','0',1,'','','US','','','','',0,'','Rents','/property/Screenshot (12).png','',0,0,0,0,'',0,'0','North America',NULL,NULL,0,1),(3,'kito pka','Toronto,Ontario, Canada',-79.3839,40,5,1,'00:00:00','00:00:00',4,21,1,0,43.6535,'2023-07-07 21:44:25','2023-07-07 21:44:25','0',1,'','','CA','','','','',0,'','Appartments','/property/Screenshot (17).png','',0,0,0,0,'',0,'0','North America',NULL,NULL,0,1),(4,'asd asdasd','Lima, Ohio 45804, United States of America',-84.0275,60,10,1,'00:00:00','00:00:00',4,21,1,0,40.7115,'2023-07-07 21:52:47','2023-07-07 21:52:47','0',1,'','','US','','','','',0,'','House','/property/download (4).png','',0,0,0,0,'',0,'0','North America','adasd asd asd as d',NULL,0,1),(5,' asd xcz zxc','Belém,Pará, Brazil',-48.4682,10,4,1,'00:00:00','00:00:00',4,433,1,0,-1.45056,'2023-07-07 21:56:08','2023-07-07 21:56:08','0',1,'','','BR','','','','',0,'','Appartments','/property/Screenshot (14).png','',0,0,0,0,'',0,'0','South America','as zxc zx c  zxc  zZXC',NULL,0,1),(6,'xc s dcas dca','Caribbean Beach, Orlando, Florida 32836, United States of America',-81.5423,30,3,1,'00:00:00','00:00:00',4,21,1,0,28.3675,'2023-07-07 22:02:14','2023-07-07 22:02:14','0',1,'','','US','','','','',0,'','House','/property/Screenshot (21).png','',0,0,0,0,'',0,'0','North America','xzzc zxc sd f s fa',NULL,0,1),(7,'liokhtt','4812 E Busch Blvd Ste G, Tampa, Florida 33617, United States of America',-82.4072,10,4,1,'00:00:00','00:00:00',4,12,1,0,28.033,'2023-07-07 22:12:55','2023-07-07 22:12:55','0',1,'','','US','','','','',0,'','Rents','/property/screenshot (3).png where id=1','',0,0,0,0,'',0,'0','North America','s d asd  sdf asd fasd f',NULL,0,1),(8,'loksia','Ολυμπιάδα Χαλκιδικής 570 14, 570 14 Olympiada, Greece',23.7863,12,3,1,'00:00:00','00:00:00',4,22,1,0,40.5906,'2023-07-07 22:16:50','2023-07-07 22:16:50','0',1,'','','GR','','','','',0,'','House','/property/screenshot (3).png where id=1','',0,0,0,0,'',0,'0','Europe','write additional note',NULL,0,1),(9,'loseic','Caribbean Beach,0240, Hartebeespoort, North West, South Africa',27.8309,23,5,1,'00:00:00','00:00:00',4,12,1,0,-25.7483,'2023-07-07 23:26:58','2023-07-07 23:26:58','0',1,'','','ZA','','','','',0,'','House',',/property/download (10).jpg','',0,0,0,0,'',0,'0','Africa',' sd fa dasdas d asd as',NULL,0,1),(10,'powli','Caribbean Beach, Orlando, Florida 32836, United States of America',-81.5423,20,6,1,'00:00:00','00:00:00',4,56,1,0,28.3675,'2023-07-07 23:31:47','2023-07-07 23:31:47','0',1,'','','US','','','','',0,'','Appartments','/property/download (11).jpg','',0,0,0,0,'',0,'0','North America',' da fasd fas sd f asd a',NULL,0,1),(11,'xvvdfgdf','Sahiwal,Punjab, Pakistan',73.0941,10,3,1,'00:00:00','00:00:00',4,121,1,0,30.6438,'2023-07-10 20:17:35','2023-07-10 20:17:35','0',1,'','','PK','','','','',0,'','Rents','/property/download (8).jpg','',0,0,0,0,'',0,'0','Asia',' gdgsdgsd fgs dfgsdfg sdfg sdfg sdfg',NULL,0,1);
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_reviews`
--

LOCK TABLES `property_reviews` WRITE;
/*!40000 ALTER TABLE `property_reviews` DISABLE KEYS */;
INSERT INTO `property_reviews` VALUES (1,1,4,'Very good property.',NULL,NULL,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_languages`
--

LOCK TABLES `user_languages` WRITE;
/*!40000 ALTER TABLE `user_languages` DISABLE KEYS */;
INSERT INTO `user_languages` VALUES (20,1,1),(21,1,4),(26,4,1),(27,4,1),(32,4,1),(33,4,1),(34,4,1),(35,4,1),(36,4,1),(37,4,1),(38,4,1),(39,4,1),(42,4,1),(43,4,4),(44,4,1),(45,4,5),(46,4,1),(47,4,5),(48,4,1),(49,4,4),(50,4,5),(51,4,7),(52,4,1),(53,4,4),(54,4,5),(55,4,7),(56,4,1),(57,4,4),(58,4,5),(59,4,7),(60,4,1),(61,4,4),(62,4,5),(63,4,7),(64,4,1),(65,4,4),(66,4,5),(67,4,7),(68,4,1),(69,4,4),(70,4,5),(71,4,7),(72,4,1),(73,4,4);
/*!40000 ALTER TABLE `user_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_packages`
--

DROP TABLE IF EXISTS `user_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_packages` (
  `id` int NOT NULL,
  `package_id` int NOT NULL,
  `user_id` int NOT NULL,
  `is_active` int NOT NULL,
  `created_at` datetime NOT NULL,
  `modified_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_packages`
--

LOCK TABLES `user_packages` WRITE;
/*!40000 ALTER TABLE `user_packages` DISABLE KEYS */;
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
INSERT INTO `user_properties` VALUES (1,4,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_services`
--

LOCK TABLES `user_services` WRITE;
/*!40000 ALTER TABLE `user_services` DISABLE KEYS */;
INSERT INTO `user_services` VALUES (21,1,1),(22,2,1),(23,1,4),(24,2,4),(25,1,4),(26,1,4),(27,1,4),(28,1,4),(29,1,4),(30,1,4),(31,1,4),(32,1,4),(33,1,4),(34,2,4),(35,1,4),(36,2,4),(37,1,4),(38,2,4),(39,1,4),(40,2,4),(41,1,4),(42,2,4),(43,1,4),(44,2,4),(45,1,4),(46,2,4),(47,1,4),(48,2,4),(49,1,4),(50,2,4),(51,3,4),(52,1,4),(53,2,4),(54,3,4),(55,1,4),(56,2,4),(57,3,4),(58,1,4),(59,2,4),(60,3,4),(61,1,4),(62,2,4),(63,3,4),(64,1,4),(65,2,4),(66,3,4),(67,1,4),(68,2,4);
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
  `phone_number` int DEFAULT NULL,
  `verification_token` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `reset_password_token` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `profile_info` text COLLATE utf8mb4_general_ci NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `profile_pic` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `identification_doc` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `is_visitor` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin1','admin1@gmail.com',1,0,0,NULL,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImNzLm11aGFtbWFkYWRuYW5AZ21haWwuY29tIiwiaWF0IjoxNjg2NTA4NzIwfQ.1fdVSxVfor_yKmCb3V6aMaMPji0kdDbf8AlyC60MeHg',0,'$2a$10$4f34CDjJcSOFlIyrH8pdauvkT73BM43p.aq065p8nGlt9JokGPOy.','2023-06-11 23:38:40','2023-06-21 02:33:46','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImNzLm11aGFtbWFkYWRuYW5AZ21haWwuY29tIiwiaWF0IjoxNjg3Mjk2NTM0LCJleHAiOjE2ODcyOTY4MzR9.F0DEcpzW_TRZJ1Zi02V3L9IHdayyuaO3Iux01sEVviM','','','','','WhatsApp Image 2023-01-09 at 21.46.59.jpg','',0),(3,'MOSN','mohsin70009@gmail.com',1,0,1,123123123,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1vaHNpbjcwMDA5QGdtYWlsLmNvbSIsImlhdCI6MTY4NjUyMzg1M30.9XZNbyD5yILfkDWOe4oinK0BKRGZlGNT3d-sKQxok38',0,'$2a$10$uw1rHZbaq7rTeVxvEzCoNOwZ98dsycxI/GsmIKAMgdaLutaFOBr/W','2023-06-12 03:50:53','2023-06-12 04:01:47',NULL,'','','','',NULL,'',0),(4,'admin','admin@gmail.com',1,0,1,1234567890,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFzZGZAZ21haWwuY29tIiwiaWF0IjoxNjg4MTA3ODQ4fQ.EmAUai41b_-SMKdkqIrdXpRRCLSO3aVlsxSe_EtoN_s',0,'$2a$10$K6MCn1EWB8ipo.WkYHxRN.UZe1pr8m60QAjdesNdfSSmXoWo74J0y','2023-06-30 11:50:48','2023-07-10 17:32:40',NULL,'washon','ston','','-1','','',0);
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

-- Dump completed on 2023-07-18 19:23:26
