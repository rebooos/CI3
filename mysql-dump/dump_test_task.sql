-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: test_task
-- ------------------------------------------------------
-- Server version	5.7.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `boosterpack`
--

DROP TABLE IF EXISTS `boosterpack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boosterpack` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `bank` decimal(10,2) NOT NULL DEFAULT '0.00',
  `time_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `time_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boosterpack`
--

LOCK TABLES `boosterpack` WRITE;
/*!40000 ALTER TABLE `boosterpack` DISABLE KEYS */;
INSERT INTO `boosterpack` VALUES (1,5.00,1.00,'2020-03-30 00:17:28','2020-04-20 17:25:07'),(2,20.00,1.00,'2020-03-30 00:17:28','2020-04-20 17:24:35'),(3,50.00,1.00,'2020-03-30 00:17:28','2020-04-20 17:25:13');
/*!40000 ALTER TABLE `boosterpack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL,
  `assign_id` int(10) unsigned NOT NULL,
  `text` text NOT NULL,
  `time_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `time_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `likes` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,0,1,1,'Ну чо ассигн проверим','2020-03-27 21:39:44','2020-04-20 19:41:19',26),(2,0,1,1,'Второй коммент','2020-03-27 21:39:55','2020-04-20 09:01:31',2),(3,0,2,1,'Второй коммент от второго человека','2020-03-27 21:40:22','2020-04-20 09:01:30',1),(4,0,1,1,'dddd','2020-04-20 09:38:48','2020-04-20 09:38:48',0),(5,2,1,1,'dddd','2020-04-20 09:38:50','2020-04-20 09:50:23',0),(6,3,1,1,'dddd','2020-04-20 09:38:59','2020-04-20 09:50:23',0),(7,3,1,1,'asdas','2020-04-20 09:39:11','2020-04-20 13:02:57',4),(8,4,1,1,'asdas','2020-04-20 09:39:27','2020-04-20 13:02:54',1),(9,0,1,1,'asdas','2020-04-20 09:39:29','2020-04-20 13:02:53',1),(10,9,1,1,'Тест','2020-04-20 09:40:13','2020-04-20 09:50:23',0),(11,0,1,2,'123','2020-04-20 10:40:39','2020-04-20 19:41:48',3),(12,0,1,1,'Новый комментарий.... ','2020-04-20 19:42:10','2020-04-20 19:42:10',0),(13,0,1,2,'Привет привет привет','2020-04-20 19:42:22','2020-04-20 19:44:00',14);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_balance`
--

DROP TABLE IF EXISTS `history_balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_balance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `old_balance` decimal(10,2) DEFAULT '0.00',
  `new_balance` decimal(10,2) DEFAULT '0.00',
  `time_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_balance`
--

LOCK TABLES `history_balance` WRITE;
/*!40000 ALTER TABLE `history_balance` DISABLE KEYS */;
INSERT INTO `history_balance` VALUES (1,1,15.00,16.00,'2020-04-20 05:19:45'),(2,1,16.00,11.00,'2020-04-20 06:33:54'),(3,1,11.00,1011.00,'2020-04-20 06:35:24'),(4,1,1011.00,1006.00,'2020-04-20 06:35:30'),(5,1,1006.00,1001.00,'2020-04-20 06:43:32'),(6,1,1001.00,981.00,'2020-04-20 06:43:40'),(7,1,981.00,961.00,'2020-04-20 06:43:50'),(8,1,961.00,956.00,'2020-04-20 06:44:05'),(9,1,956.00,951.00,'2020-04-20 06:48:02'),(10,1,951.00,946.00,'2020-04-20 06:48:09'),(11,1,946.00,896.00,'2020-04-20 06:49:02'),(12,1,896.00,996.00,'2020-04-20 06:53:03'),(13,1,996.00,991.00,'2020-04-20 06:53:07'),(14,1,991.00,991.00,'2020-04-20 12:15:45'),(15,1,991.00,971.00,'2020-04-20 16:05:20'),(16,1,971.00,951.00,'2020-04-20 16:35:13'),(17,1,951.00,931.00,'2020-04-20 16:35:19'),(18,1,931.00,911.00,'2020-04-20 16:35:26'),(19,1,911.00,906.00,'2020-04-20 17:22:15'),(20,1,906.00,901.00,'2020-04-20 17:23:40'),(21,1,901.00,896.00,'2020-04-20 17:23:43'),(22,1,896.00,891.00,'2020-04-20 17:23:45'),(23,1,891.00,871.00,'2020-04-20 17:24:35'),(24,1,871.00,866.00,'2020-04-20 17:25:07'),(25,1,866.00,816.00,'2020-04-20 17:25:13');
/*!40000 ALTER TABLE `history_balance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_boosterpack`
--

DROP TABLE IF EXISTS `history_boosterpack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_boosterpack` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `boosterpack_id` int(10) unsigned DEFAULT NULL,
  `price` decimal(10,2) DEFAULT '0.00',
  `likes` int(11) NOT NULL DEFAULT '0',
  `time_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_boosterpack` (`boosterpack_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_boosterpack`
--

LOCK TABLES `history_boosterpack` WRITE;
/*!40000 ALTER TABLE `history_boosterpack` DISABLE KEYS */;
INSERT INTO `history_boosterpack` VALUES (1,1,1,5.00,4,'2020-04-20 06:26:46'),(2,1,1,5.00,4,'2020-04-20 06:33:54'),(3,1,1,5.00,4,'2020-04-20 06:35:30'),(4,1,1,5.00,6,'2020-04-20 06:43:32'),(5,1,2,20.00,9,'2020-04-20 06:43:40'),(6,1,2,20.00,22,'2020-04-20 06:43:50'),(7,1,1,5.00,26,'2020-04-20 06:44:05'),(8,1,1,5.00,28,'2020-04-20 06:48:02'),(9,1,1,5.00,33,'2020-04-20 06:48:09'),(10,1,3,50.00,44,'2020-04-20 06:49:02'),(11,1,1,5.00,48,'2020-04-20 06:53:07'),(12,1,2,20.00,27,'2020-04-20 16:05:20'),(13,1,2,20.00,35,'2020-04-20 16:35:13'),(14,1,2,20.00,62,'2020-04-20 16:35:19'),(15,1,2,20.00,66,'2020-04-20 16:35:26'),(16,1,1,5.00,69,'2020-04-20 17:22:15'),(17,1,1,5.00,5,'2020-04-20 17:23:40'),(18,1,1,5.00,6,'2020-04-20 17:23:43'),(19,1,1,5.00,3,'2020-04-20 17:23:45'),(20,1,2,20.00,28,'2020-04-20 17:24:35'),(21,1,1,5.00,5,'2020-04-20 17:25:07'),(22,1,3,50.00,63,'2020-04-20 17:25:13');
/*!40000 ALTER TABLE `history_boosterpack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_likes`
--

DROP TABLE IF EXISTS `history_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type_id` int(10) unsigned NOT NULL,
  `type` int(2) NOT NULL,
  `time_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id_type` (`user_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_likes`
--

LOCK TABLES `history_likes` WRITE;
/*!40000 ALTER TABLE `history_likes` DISABLE KEYS */;
INSERT INTO `history_likes` VALUES (1,1,1,1,'2020-04-20 08:31:12'),(2,1,1,1,'2020-04-20 08:31:15'),(3,1,1,1,'2020-04-20 08:31:15'),(4,1,1,1,'2020-04-20 08:31:15'),(5,1,1,1,'2020-04-20 08:31:16'),(6,1,1,1,'2020-04-20 08:31:16'),(7,1,1,1,'2020-04-20 08:31:16'),(8,1,1,1,'2020-04-20 08:31:17'),(9,1,1,1,'2020-04-20 08:31:17'),(10,1,1,1,'2020-04-20 08:31:17'),(11,1,1,1,'2020-04-20 08:31:18'),(12,1,1,1,'2020-04-20 08:31:18'),(13,1,1,1,'2020-04-20 08:31:18'),(14,1,1,1,'2020-04-20 08:31:18'),(15,1,1,1,'2020-04-20 08:31:18'),(16,1,1,1,'2020-04-20 08:31:18'),(17,1,2,1,'2020-04-20 08:33:02'),(18,1,2,1,'2020-04-20 08:33:43'),(19,1,1,1,'2020-04-20 08:33:49'),(20,1,1,1,'2020-04-20 08:33:49'),(21,1,1,1,'2020-04-20 09:01:27'),(22,1,1,2,'2020-04-20 09:01:29'),(23,1,2,2,'2020-04-20 09:01:30'),(24,1,3,2,'2020-04-20 09:01:30'),(25,1,2,2,'2020-04-20 09:01:31'),(26,1,9,2,'2020-04-20 13:02:53'),(27,1,8,2,'2020-04-20 13:02:54'),(28,1,7,2,'2020-04-20 13:02:57'),(29,1,7,2,'2020-04-20 13:02:57'),(30,1,7,2,'2020-04-20 13:02:57'),(31,1,7,2,'2020-04-20 13:02:57'),(32,1,1,1,'2020-04-20 14:18:09'),(33,1,1,1,'2020-04-20 14:18:09'),(34,1,1,1,'2020-04-20 14:18:09'),(35,1,1,1,'2020-04-20 14:18:10'),(36,1,1,1,'2020-04-20 14:18:10'),(37,1,1,1,'2020-04-20 14:18:10'),(38,1,1,1,'2020-04-20 14:18:10'),(39,1,1,1,'2020-04-20 14:18:10'),(40,1,1,1,'2020-04-20 14:18:10'),(41,1,1,1,'2020-04-20 14:18:11'),(42,1,1,1,'2020-04-20 14:18:11'),(43,1,1,1,'2020-04-20 14:18:11'),(44,1,1,1,'2020-04-20 14:18:11'),(45,1,1,1,'2020-04-20 14:18:11'),(46,1,1,1,'2020-04-20 14:18:11'),(47,1,1,1,'2020-04-20 14:18:11'),(48,1,1,1,'2020-04-20 17:25:24'),(49,1,1,1,'2020-04-20 17:25:24'),(50,1,1,1,'2020-04-20 17:25:25'),(51,1,1,1,'2020-04-20 17:25:25'),(52,1,1,1,'2020-04-20 17:25:25'),(53,1,1,1,'2020-04-20 17:25:25'),(54,1,1,1,'2020-04-20 17:25:25'),(55,1,1,1,'2020-04-20 17:25:25'),(56,1,1,1,'2020-04-20 17:25:25'),(57,1,1,1,'2020-04-20 17:25:26'),(58,1,1,1,'2020-04-20 17:25:26'),(59,1,1,1,'2020-04-20 17:25:26'),(60,1,1,1,'2020-04-20 17:25:26'),(61,1,1,2,'2020-04-20 17:25:27'),(62,1,1,2,'2020-04-20 17:25:27'),(63,1,1,2,'2020-04-20 17:25:27'),(64,1,1,2,'2020-04-20 17:25:27'),(65,1,1,2,'2020-04-20 17:25:27'),(66,1,1,2,'2020-04-20 17:25:28'),(67,1,2,1,'2020-04-20 17:25:33'),(68,1,2,1,'2020-04-20 17:25:33'),(69,1,2,1,'2020-04-20 17:25:33'),(70,1,2,1,'2020-04-20 17:25:34'),(71,1,2,1,'2020-04-20 17:25:34'),(72,1,2,1,'2020-04-20 17:25:34'),(73,1,2,1,'2020-04-20 17:25:34'),(74,1,2,1,'2020-04-20 17:25:34'),(75,1,2,1,'2020-04-20 17:25:35'),(76,1,2,1,'2020-04-20 17:25:35'),(77,1,2,1,'2020-04-20 17:25:35'),(78,1,2,1,'2020-04-20 17:25:35'),(79,1,2,1,'2020-04-20 17:25:35'),(80,1,1,2,'2020-04-20 19:41:13'),(81,1,1,2,'2020-04-20 19:41:14'),(82,1,1,2,'2020-04-20 19:41:14'),(83,1,1,2,'2020-04-20 19:41:14'),(84,1,1,2,'2020-04-20 19:41:15'),(85,1,1,2,'2020-04-20 19:41:15'),(86,1,1,2,'2020-04-20 19:41:15'),(87,1,1,2,'2020-04-20 19:41:16'),(88,1,1,2,'2020-04-20 19:41:16'),(89,1,1,2,'2020-04-20 19:41:16'),(90,1,1,2,'2020-04-20 19:41:17'),(91,1,1,2,'2020-04-20 19:41:17'),(92,1,1,2,'2020-04-20 19:41:17'),(93,1,1,2,'2020-04-20 19:41:18'),(94,1,1,2,'2020-04-20 19:41:18'),(95,1,1,2,'2020-04-20 19:41:18'),(96,1,1,2,'2020-04-20 19:41:19'),(97,1,1,2,'2020-04-20 19:41:19'),(98,1,11,2,'2020-04-20 19:41:47'),(99,1,11,2,'2020-04-20 19:41:48'),(100,1,11,2,'2020-04-20 19:41:48'),(101,1,2,1,'2020-04-20 19:41:52'),(102,1,13,2,'2020-04-20 19:43:58'),(103,1,13,2,'2020-04-20 19:43:58'),(104,1,13,2,'2020-04-20 19:43:58'),(105,1,13,2,'2020-04-20 19:43:59'),(106,1,13,2,'2020-04-20 19:43:59'),(107,1,13,2,'2020-04-20 19:43:59'),(108,1,13,2,'2020-04-20 19:43:59'),(109,1,13,2,'2020-04-20 19:43:59'),(110,1,13,2,'2020-04-20 19:43:59'),(111,1,13,2,'2020-04-20 19:44:00'),(112,1,13,2,'2020-04-20 19:44:00'),(113,1,13,2,'2020-04-20 19:44:00'),(114,1,13,2,'2020-04-20 19:44:00'),(115,1,13,2,'2020-04-20 19:44:00');
/*!40000 ALTER TABLE `history_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `text` text NOT NULL,
  `img` varchar(1024) DEFAULT NULL,
  `time_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `time_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `likes` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,1,'Тестовый постик 1','/images/posts/1.png','2018-08-30 13:31:14','2020-04-20 17:25:26',52),(2,1,'Печальный пост','/images/posts/2.png','2018-10-11 01:33:27','2020-04-20 19:41:52',16);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(60) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `personaname` varchar(50) NOT NULL DEFAULT '',
  `avatarfull` varchar(150) NOT NULL DEFAULT '',
  `rights` tinyint(4) NOT NULL DEFAULT '0',
  `wallet_balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `wallet_total_refilled` decimal(10,2) NOT NULL DEFAULT '0.00',
  `wallet_total_withdrawn` decimal(10,2) NOT NULL DEFAULT '0.00',
  `count_likes` int(11) DEFAULT '0',
  `time_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `time_created` (`time_created`),
  KEY `time_updated` (`time_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin@niceadminmail.pl','12345','AdminProGod','https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/96/967871835afdb29f131325125d4395d55386c07a_full.jpg',0,816.00,1116.00,300.00,111,'2019-07-26 01:53:54','2020-04-20 19:44:00'),(2,'simpleuser@niceadminmail.pl','12345','simpleuser','https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/86/86a0c845038332896455a566a1f805660a13609b_full.jpg',0,0.00,0.00,0.00,0,'2019-07-26 01:53:54','2020-04-19 15:52:52'),(3,'test@mail.ru','asdasd','asas','',0,0.00,0.00,0.00,10,'2020-04-20 17:11:17','2020-04-20 17:11:17');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-21 10:01:37
